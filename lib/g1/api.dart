import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:duniter_datapod/duniter_datapod_client.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.req.gql.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart';
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:durt/durt.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tuple/tuple.dart';

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_lists_default.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../data/models/transaction_state.dart';
import '../data/models/utxo.dart';
import '../env.dart';
import '../shared_prefs_helper.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'duniter_endpoint_helper.dart';
import 'g1_helper.dart';
import 'g1_v2_helper.dart';
import 'no_nodes_exception.dart';
import 'node_check_result.dart';
import 'pay_result.dart';
import 'proxyfy_node_stub.dart'
    if (dart.library.js_interop) 'proxyfy_node_web.dart';
import 'service_manager.dart';
import 'v2_peers.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

// use g1-test or g1 for production (fallback to g1)
const String currencyDotEnv = Env.currency;
final String currency = currencyDotEnv.isEmpty ? 'g1' : currencyDotEnv;

// G1 production V2 genesis hash - used to validate discovered RPC nodes
// Obtained from: https://get-g1-genesis-hash.p2p.legal
const String expectedG1GenesisHash =
    '0xfeb770bbb0344dabc8366b0d1f889a8e4e6ca09b914006655fe795920deb6d56';

// Deduplication map for Cesium+ requests - tracks in-flight requests
// Maps request path to list of Completers waiting for the result
final Map<String, List<Completer<Tuple2<Node, http.Response>>>> _cPlusInFlight =
    <String, List<Completer<Tuple2<Node, http.Response>>>>{};

Future<String> getTxHistory(String publicKey) async {
  final Response response =
      (await requestWithRetry(NodeType.duniter, '/tx/history/$publicKey'))
          .item2;
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load tx history');
  }
}

Future<List<dynamic>> getPeers(NodeType type, {bool debug = true}) async {
  // const Duration timeout = Duration(seconds: 10);
  // Prevent concurrent modification
  final List<Node> nodes = List<Node>.from(NodeManager().nodeList(type));
  if (debug) {
    loggerDev('Fetching ${type.name} peers with peers ${nodes.length}');
  }
  List<dynamic> currentPeers = <dynamic>[];
  for (final Node node in nodes) {
    if (type == NodeType.duniter || type == NodeType.gva) {
      String nodeUrl = node.url;
      nodeUrl = nodeUrl.replaceAll(RegExp(r'/gva$'), '');
      nodeUrl = '$nodeUrl/network/peers';
      if (debug) {
        loggerDev('Fetching $nodeUrl');
      }
      try {
        final Response response = await getWithTimeout(Uri.parse(nodeUrl));
        if (response.statusCode == 200) {
          // Try decode
          final Map<String, dynamic> peerList =
              jsonDecode(response.body) as Map<String, dynamic>;
          final List<dynamic> peers = (peerList['peers'] as List<dynamic>)
              .where((dynamic peer) =>
                  (peer as Map<String, dynamic>)['currency'] == currency)
              .where((dynamic peer) =>
                  (peer as Map<String, dynamic>)['version'] == 10)
              .where((dynamic peer) =>
                  (peer as Map<String, dynamic>)['status'] == 'UP')
              .toList();
          if (currentPeers.length < peers.length) {
            // sometimes getPeers returns a small list of nodes (sometimes even one)
            currentPeers = peers;
          }
        }
      } catch (e) {
        if (debug) {
          loggerDev('Error retrieving $nodeUrl ($e)');
        }
        // Ignore
      }
    }
  }
  return currentPeers;
}

Future<Tuple2<Set<Node>, Set<Node>>> getV2Peers({
  required List<Node> endpointNodes,
  required List<Node> indexerNodes,
  int? maxNodes,
  bool debug = true,
}) async {
  final Set<Node> discoveredEndpointNodes = <Node>{};
  final Set<Node> discoveredIndexerNodes = <Node>{};
  final Set<String> discoveredEndpointUrls = <String>{};
  final Set<String> scannedEndpointUrls = <String>{};
  final Set<String> checkedEndpointUrls =
      <String>{}; // Track all checked endpoints (success + failures)
  final Set<String> checkedIndexerUrls =
      <String>{}; // Track all checked indexers (success + failures)
  maxNodes ??= NodeManager.maxNodes;

  Future<void> scanEndpointNode(String nodeUrl) async {
    if (scannedEndpointUrls.contains(nodeUrl) ||
        discoveredEndpointUrls.length >= maxNodes!) {
      return;
    }
    scannedEndpointUrls.add(nodeUrl);

    try {
      final V2Peers res = await discoverV2PeersFromNode(nodeUrl);

      // Parallelize endpoint checks
      final List<Future<void>> endpointFutures = <Future<void>>[];
      for (final String url in res.endpoint) {
        if (discoveredEndpointUrls.length >= maxNodes) {
          break;
        }
        // Skip if already checked (either successfully or with error)
        if (checkedEndpointUrls.contains(url)) {
          if (debug) {
            loggerDev('Skipping already checked endpoint node $url');
          }
          continue;
        }

        if (discoveredEndpointUrls.add(url)) {
          checkedEndpointUrls.add(url); // Mark as checked before pinging
          endpointFutures.add(_pingNode(url, NodeType.endpoint)
              .then((NodeCheckResult nodeCheck) {
            // Only add if the node responded successfully
            if (nodeCheck.latency != wrongNodeDuration) {
              // Validate genesis hash for RPC endpoints
              if (nodeCheck.genesisHash != null &&
                  nodeCheck.genesisHash != expectedG1GenesisHash) {
                if (debug) {
                  loggerDev(
                      'Rejecting endpoint $url: genesis hash mismatch. Expected: $expectedG1GenesisHash, Got: ${nodeCheck.genesisHash}');
                }
                return Future<
                    void>.value(); // Skip this node - wrong genesis hash
              }
              discoveredEndpointNodes.add(Node(
                url: url,
                latency: nodeCheck.latency.inMicroseconds,
                currentBlock: nodeCheck.currentBlock,
              ));
              return scanEndpointNode(url);
            }
          }).catchError((_) {
            if (debug) {
              loggerDev('Error scanning endpoint node $url');
            }
          }));
        }
      }

      // Parallelize indexer checks
      final List<Future<void>> indexerFutures = <Future<void>>[];
      for (final String url in res.indexer) {
        // Skip if already checked (either successfully or with error)
        if (checkedIndexerUrls.contains(url)) {
          if (debug) {
            loggerDev('Skipping already checked indexer node $url');
          }
          continue;
        }

        checkedIndexerUrls.add(url); // Mark as checked before pinging
        indexerFutures.add(_pingNode(url, NodeType.duniterIndexer)
            .then((NodeCheckResult nodeCheck) {
          // Only add if the node responded successfully
          if (nodeCheck.latency != wrongNodeDuration) {
            discoveredIndexerNodes.add(Node(
              url: url,
              latency: nodeCheck.latency.inMicroseconds,
              currentBlock: nodeCheck.currentBlock,
            ));
          }
        }).catchError((_) {
          if (debug) {
            loggerDev('Error scanning indexer node $url');
          }
        }));
      }

      // Wait for all checks to complete in parallel
      await Future.wait(<Future<void>>[
        ...endpointFutures,
        ...indexerFutures,
      ]);
    } catch (e) {
      if (debug) {
        loggerDev('Error retrieving $nodeUrl ($e)');
      }
    }
  }

  // Mark initial nodes as already checked
  for (final Node node in endpointNodes) {
    if (discoveredEndpointUrls.length >= maxNodes) {
      break;
    }
    checkedEndpointUrls.add(node.url);
    discoveredEndpointUrls.add(node.url);
    discoveredEndpointNodes.add(node);
  }

  for (final Node node in indexerNodes) {
    checkedIndexerUrls.add(node.url);
  }

  // Parallelize initial node scanning
  final List<Future<void>> scanFutures = <Future<void>>[];
  for (final Node node in endpointNodes) {
    if (discoveredEndpointUrls.length >= maxNodes) {
      break;
    }
    scanFutures.add(scanEndpointNode(node.url));
  }
  await Future.wait(scanFutures);

  indexerNodes.forEach(discoveredIndexerNodes.add);

  final List<Node> sortedEndpoints = discoveredEndpointNodes.toList()
    ..sort((Node a, Node b) => a.latency.compareTo(b.latency));
  final List<Node> sortedIndexers = discoveredIndexerNodes.toList()
    ..sort((Node a, Node b) => a.latency.compareTo(b.latency));

  if (debug) {
    loggerDev(
        'Checked ${checkedEndpointUrls.length} unique endpoint URLs, discovered ${sortedEndpoints.length} working nodes');
    loggerDev(
        'Checked ${checkedIndexerUrls.length} unique indexer URLs, discovered ${sortedIndexers.length} working nodes');
  }

  return Tuple2<Set<Node>, Set<Node>>(
    sortedEndpoints.toSet(),
    sortedIndexers.toSet(),
  );
}

Future<List<Contact>> searchProfilesV1(
    {required String searchTermLower,
    required String searchTerm,
    required String searchTermCapitalized,
    bool quickMode = false}) async {
  final String query =
      '/user/profile/_search?q=title:$searchTermLower OR issuer:$searchTerm OR title:$searchTermCapitalized OR title:$searchTerm';

  final Response response = (await requestCPlusWithRetry(query,
          retryWith404: false, quickMode: quickMode))
      .item2;
  final List<Contact> searchResult = <Contact>[];
  if (response.statusCode != 404) {
    // Add cplus users
    final List<dynamic> hits = ((const JsonDecoder().convert(response.body)
            as Map<String, dynamic>)['hits'] as Map<String, dynamic>)['hits']
        as List<dynamic>;
    for (final dynamic hit in hits) {
      final Contact c = await contactFromResultSearch(
        hit as Map<String, dynamic>,
      );
      logger('Contact retrieved in c+ search $c');
      ContactsCache().addContact(c);
      searchResult.add(c);
    }
  }
  return searchResult;
}

Future<Contact> getProfileV1(String pubKeyRaw,
    {bool onlyCPlusProfile = false, bool resize = true}) async {
  final String pubKey = extractPublicKey(pubKeyRaw);
  try {
    final Response cPlusResponse =
        (await requestCPlusWithRetry('/user/profile/$pubKey')).item2;
    final Map<String, dynamic> result =
        const JsonDecoder().convert(cPlusResponse.body) as Map<String, dynamic>;
    Contact c;
    if (result['found'] == false) {
      c = Contact(pubKey: pubKey);
    } else {
      final Map<String, dynamic> profile = const JsonDecoder()
          .convert(cPlusResponse.body) as Map<String, dynamic>;
      c = await contactFromResultSearch(profile, resize: resize);
    }
    if (!onlyCPlusProfile) {
      // This penalize the gva rate limit
      // final String? nick = await gvaNick(pubKey);
      final List<Contact> wotList = await searchWotV1(pubKey);
      if (wotList.isNotEmpty) {
        final Contact cWot = wotList[0];
        c = c.merge(cWot);
        // c.copyWith(nick: c.nick);
      }
    }
    logger('Contact retrieved in getProfile $c (c+ only $onlyCPlusProfile)');
    return c;
  } catch (e) {
    logger('Error in getProfile $e');
    return Contact(pubKey: pubKey);
  }
}

/*
http://doc.e-is.pro/cesium-plus-pod/REST_API.html#userprofile
Not found sample:
{
"_index": "user",
"_type": "profile",
"_id": "H97or89hW4kzKcvpmFPAAvc1znJrbJWJSYS9XnW37JrM",
"found": false
}
 */
Future<List<Contact>> searchWotV1(String initialSearchTerm) async {
  final String searchTerm = normalizeQuery(initialSearchTerm);
  final Response response = (await requestDuniterWithRetry(
          '/wot/lookup/$searchTerm',
          retryWith404: false))
      .item2;
  // Will be better to analyze the 404 response (to detect faulty node)
  final List<Contact> contacts = <Contact>[];
  if (response.statusCode == HttpStatus.ok) {
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> results = data['results'] as List<dynamic>;
    // logger('Returning wot results ${results.length}');
    if (results.isNotEmpty) {
      for (final dynamic result in results) {
        final Map<String, dynamic> resultMap = result as Map<String, dynamic>;
        final String pubKey = resultMap['pubkey'] as String;
        // ignore: avoid_dynamic_calls
        final String nick = resultMap['uids'][0]['uid']! as String;
        contacts.add(Contact(nick: nick, pubKey: pubKey));
      }
    }
  }
  logger('Returning wot contact ${contacts.length}');
  if (contacts.isNotEmpty) {
    logger('First: ${contacts.first}');
  }
  return contacts;
}

Future<void> fetchNodesIfNotReady(
    {required bool v2Only, bool isProduction = false}) async {
  final List<Future<void>> fetchFutures = <Future<void>>[];

  final List<NodeType> nodesToFetch = v2Only
      ? <NodeType>[
          // V2 only needs these
          NodeType.endpoint,
          NodeType.duniterIndexer,
          NodeType.cesiumPlus,
        ]
      : <NodeType>[
          // V1 needs these
          NodeType.gva,
          NodeType.duniter,
          NodeType.cesiumPlus,
          // NodeType.ipfsGateway
        ];

  for (final NodeType type in nodesToFetch) {
    if (NodeManager().nodesWorking(type) < 3) {
      fetchFutures.add(fetchNodes(type, true, isProduction: isProduction));
    }
    await Future.wait(fetchFutures);
  }
}

Future<void> fetchNodes(NodeType type, bool force,
    {bool isProduction = false}) async {
  try {
    final List<Future<void>> fetchFutures = <Future<void>>[];

    switch (type) {
      case NodeType.duniter:
        fetchFutures.add(_fetchDuniterNodes(force: force));
        break;
      case NodeType.gva:
        fetchFutures.add(_fetchGvaNodes(force: force));
        break;
      case NodeType.cesiumPlus:
        fetchFutures.add(_fetchCesiumPlusNodes(force: force));
        break;
      case NodeType.endpoint:
      case NodeType.duniterIndexer:
        fetchFutures.add(_fetchEndPointAndSquidNodes(
            force: force, isProduction: isProduction));
        break;
      case NodeType.datapodEndpoint:
        fetchFutures
            .add(_fetchV2Nodes(type: NodeType.datapodEndpoint, force: force));
        break;
      case NodeType.ipfsGateway:
        fetchFutures.add(_fetchIpfsGateways(force: force));
        break;
    }

    await Future.wait(fetchFutures);
  } on NoNodesException catch (e, stacktrace) {
    logger(e.cause);
    await Sentry.captureException(e, stackTrace: stacktrace);
    NodeManager().loading = false;
    rethrow;
  } catch (e, stacktrace) {
    logger('Error in fetchNodes $e');
    await Sentry.captureException(e, stackTrace: stacktrace);
    NodeManager().loading = false;
  }
}

Future<void> _fetchDuniterNodes({bool force = false}) async {
  const NodeType type = NodeType.duniter;
  NodeManager().loading = true;
  final bool forceOrFewNodes =
      force || (NodeManager().nodesWorking(type) < NodeManager.maxNodes);
  if (forceOrFewNodes) {
    defaultDuniterNodes.shuffle();
    NodeManager().updateNodes(type, defaultDuniterNodes);
  }
  logger(
      'Fetching (forced: $force) ${type.name} nodes, we have ${NodeManager().nodesWorking(type)}');
  final List<Node> nodes = await _fetchDuniterNodesFromPeers(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

Future<void> _fetchGvaNodes({bool force = false}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.gva;
  if (force) {
    NodeManager().updateNodes(type, defaultGvaNodes);
    logger('Fetching gva nodes forced');
  } else {
    logger('Fetching gva nodes, we have ${NodeManager().nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchDuniterNodesFromPeers(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

// https://github.com/duniter/cesium/blob/467ec68114be650cd1b306754c3142fc4020164c/www/js/config.js#L96
// https://g1.data.le-sou.org/g1/peer/_search?pretty
Future<void> _fetchCesiumPlusNodes({bool force = false}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.cesiumPlus;
  final bool forceOrFewNodes = force || NodeManager().nodesWorking(type) <= 2;
  if (forceOrFewNodes) {
    NodeManager().updateNodes(type, defaultCesiumPlusNodes);
    logger('Fetching cesium nodes forced');
  }
  logger(
      'Fetching cesium plus nodes, we have ${NodeManager().nodesWorking(type)}');
  final List<Node> nodes = await _fetchNodes(NodeType.cesiumPlus);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

Future<void> _fetchEndPointAndSquidNodes(
    {bool force = false, bool isProduction = false}) async {
  NodeManager().loading = true;
  if (force) {
    if (isProduction) {
      // Production: don't load gtest defaults from .env
      NodeManager().updateNodes(NodeType.endpoint, <Node>[]);
      NodeManager().updateNodes(NodeType.duniterIndexer, <Node>[]);
      logger('Fetching production endPoint nodes forced');
    } else {
      // Test: load gtest defaults from .env
      NodeManager().updateNodes(NodeType.endpoint, defaultEndPointNodes);
      NodeManager()
          .updateNodes(NodeType.duniterIndexer, defaultDuniterIndexerNodes);
      logger('Fetching gtest endPoint nodes forced');
    }
  } else {
    logger(
        'Fetching endPoint and indexer nodes, we have ${NodeManager().nodesWorking(NodeType.endpoint)} and ${NodeManager().nodesWorking(NodeType.duniterIndexer)}');
  }

  // Fetch nodes from appropriate JSON (g1.json for production, gtest.json for test)
  final Tuple2<List<Node>, List<Node>> remoteNodes = isProduction
      ? await _fetchNodesFromG1Json()
      : await _fetchNodesFromGtestJson();

  final List<Node> initialEndPointNodes = await _fetchNodes(NodeType.endpoint);
  final List<Node> initialIndexerNodes =
      await _fetchNodes(NodeType.duniterIndexer);

  // Add remote nodes to initial lists if not already present
  final Set<String> endpointUrls =
      initialEndPointNodes.map((Node n) => n.url).toSet();
  final Set<String> indexerUrls =
      initialIndexerNodes.map((Node n) => n.url).toSet();

  for (final Node node in remoteNodes.item1) {
    if (!endpointUrls.contains(node.url)) {
      initialEndPointNodes.add(node);
      endpointUrls.add(node.url);
    }
  }

  for (final Node node in remoteNodes.item2) {
    if (!indexerUrls.contains(node.url)) {
      initialIndexerNodes.add(node);
      indexerUrls.add(node.url);
    }
  }

  final Tuple2<Set<Node>, Set<Node>> discoveredNodes = await getV2Peers(
      endpointNodes: initialEndPointNodes, indexerNodes: initialIndexerNodes);

  NodeManager().updateNodes(NodeType.endpoint, discoveredNodes.item1.toList());
  NodeManager()
      .updateNodes(NodeType.duniterIndexer, discoveredNodes.item2.toList());
  NodeManager().loading = false;
}

/// Fetches nodes from a remote JSON file (generic for gtest.json and g1.json)
/// Expects JSON with 'rpc' (endpoints) and 'squid' (indexers) arrays
/// Returns a tuple with (rpcNodes, squidNodes)
Future<Tuple2<List<Node>, List<Node>>> _fetchNodesFromNetworkJson(
    String url, String networkName) async {
  final List<Node> rpcNodes = <Node>[];
  final List<Node> squidNodes = <Node>[];

  try {
    logger('Fetching nodes from $networkName');

    final http.Response response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      // Extract RPC nodes
      if (data.containsKey('rpc') && data['rpc'] is List) {
        final List<dynamic> rpcs = data['rpc'] as List<dynamic>;
        for (final dynamic rpc in rpcs) {
          if (rpc is String && rpc.isNotEmpty) {
            rpcNodes.add(Node(url: rpc));
          }
        }
        logger('Loaded ${rpcNodes.length} rpc nodes from $networkName');
      }

      // Extract Squid nodes
      if (data.containsKey('squid') && data['squid'] is List) {
        final List<dynamic> squids = data['squid'] as List<dynamic>;
        for (final dynamic squid in squids) {
          if (squid is String && squid.isNotEmpty) {
            squidNodes.add(Node(url: squid));
          }
        }
        logger('Loaded ${squidNodes.length} squid nodes from $networkName');
      }
    } else {
      logger('Failed to fetch $networkName: HTTP ${response.statusCode}');
    }
  } on TimeoutException catch (e) {
    logger('Timeout fetching nodes from $networkName: $e');
  } on SocketException catch (e) {
    logger('Network error fetching nodes from $networkName: $e');
  } on http.ClientException catch (e) {
    logger('HTTP client error fetching nodes from $networkName: $e');
  } on FormatException catch (e) {
    logger('JSON parsing error from $networkName: $e');
  } catch (e) {
    logger('Unexpected error fetching nodes from $networkName: $e');
  }

  // Always return a valid tuple, even if empty, to allow the app to continue
  return Tuple2<List<Node>, List<Node>>(rpcNodes, squidNodes);
}

/// Fetches nodes from the gtest.json file (test network)
/// Returns a tuple with (rpcNodes, squidNodes)
/// If fetching fails, returns empty lists to allow the application to continue
Future<Tuple2<List<Node>, List<Node>>> _fetchNodesFromGtestJson() async {
  const String gtestUrl =
      'https://git.duniter.org/nodes/networks/-/raw/master/gtest.json?ref_type=heads';
  return _fetchNodesFromNetworkJson(gtestUrl, 'gtest.json');
}

/// Fetches nodes from the g1.json file (production network)
/// Returns a tuple with (rpcNodes, squidNodes)
/// If fetching fails, returns empty lists to allow the application to continue
Future<Tuple2<List<Node>, List<Node>>> _fetchNodesFromG1Json() async {
  const String g1Url =
      'https://git.duniter.org/nodes/networks/-/raw/master/g1.json?ref_type=heads';
  return _fetchNodesFromNetworkJson(g1Url, 'g1.json');
}

Future<void> _fetchV2Nodes({required NodeType type, bool force = false}) async {
  NodeManager().loading = true;
  if (force) {
    NodeManager().updateNodes(type, defaultNodes(type));
    logger('Fetching $type nodes forced');
  } else {
    logger('Fetching $type nodes, we have ${NodeManager().nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchNodes(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

Future<void> _fetchIpfsGateways({required bool force}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.ipfsGateway;
  if (force) {
    NodeManager().updateNodes(type, defaultNodes(type));
    logger('Fetching $type nodes forced');
  }
  final List<Node> nodes = await _fetchNodes(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

Future<List<Node>> _fetchDuniterNodesFromPeers(NodeType type,
    {bool debug = false}) async {
  logger('Fetching ${type.name} nodes from peers');
  final List<Node> lNodes = <Node>[];
  final String apyType = (type == NodeType.duniter) ? 'BMAS' : 'GVA S';
  try {
    final List<dynamic> peers = await getPeers(type);
    peers.shuffle();

    // Collect all endpoints to check
    final List<String> endpointsToCheck = <String>[];
    for (final dynamic peerR in peers) {
      final Map<String, dynamic> peer = peerR as Map<String, dynamic>;
      if (peer['endpoints'] != null) {
        final List<String> endpoints =
            List<String>.from(peer['endpoints'] as List<dynamic>);
        for (int j = 0; j < endpoints.length; j++) {
          if (endpoints[j].startsWith(apyType)) {
            final String endpointUnParsed = endpoints[j];
            final String? endpoint = parseHost(endpointUnParsed);
            if (endpoint != null && !endpoint.contains('localhost')) {
              endpointsToCheck.add(endpoint);
              if (kReleaseMode &&
                  endpointsToCheck.length >= NodeManager.maxNodes) {
                break;
              }
            }
          }
        }
        if (kReleaseMode && endpointsToCheck.length >= NodeManager.maxNodes) {
          break;
        }
      }
    }

    // Parallelize all endpoint checks
    final List<Future<Node?>> nodeFutures =
        endpointsToCheck.map((String endpoint) async {
      try {
        final NodeCheckResult nodeCheck = await _pingNode(endpoint, type);
        final Duration latency = nodeCheck.latency;
        loggerD(debug,
            'Evaluating node: $endpoint, latency ${latency.inMicroseconds} currentBlock: ${nodeCheck.currentBlock} version: ${nodeCheck.version}');
        final Node node = Node(
            url: endpoint,
            latency: latency.inMicroseconds,
            currentBlock: nodeCheck.currentBlock,
            version: nodeCheck.version);
        // Use the new method that handles insertion based on latency
        NodeManager().addNodeSortedByLatency(type, node, notify: false);
        return node;
      } catch (e) {
        logger('Error fetching $endpoint, error: $e');
        return null;
      }
    }).toList();

    // Wait for all checks to complete in parallel
    final List<Node?> results = await Future.wait(nodeFutures);

    // Filter out null results and add to list
    lNodes.addAll(results.whereType<Node>());

    // Notify once after all updates
    if (lNodes.isNotEmpty) {
      NodeManager().notifyObserver();
    }

    logger(
        'Fetched ${lNodes.length} ${type.name} nodes ordered by latency ${lNodes.isNotEmpty ? '(first: ${lNodes.first.url})' : '(zero nodes)'}');
  } catch (e, stacktrace) {
    await Sentry.captureException(e, stackTrace: stacktrace);
    logger('General error in fetch ${type.name} nodes: $e');
    logger(stacktrace);
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  if (lNodes.isNotEmpty) {
    logger('First node in list ${lNodes.first.url}');
  } else {
    logger('No nodes in list');
  }
  return lNodes;
}

void loggerD(bool debug, String message) {
  if (debug) {
    logger(message);
  }
}

Future<List<Node>> _fetchNodes(NodeType type, {bool debug = false}) async {
  final List<Node> lNodes = <Node>[];
  try {
    final List<Node> currentNodes = <Node>[...NodeManager().nodeList(type)];
    currentNodes.shuffle();

    // Parallelize node checks
    final List<Future<Node?>> nodeFutures = currentNodes.map((Node node) async {
      final String endpoint = node.url;
      try {
        if (debug) {
          logger('Evaluating node: $endpoint');
        }
        final NodeCheckResult nodeCheck = await _pingNode(endpoint, type);
        final Duration latency = nodeCheck.latency;
        if (debug) {
          logger(
              'Evaluating node: $endpoint, latency ${latency.inMicroseconds} version: ${nodeCheck.version}');
        }
        final Node resultNode = Node(
            url: endpoint,
            latency: latency.inMicroseconds,
            currentBlock: nodeCheck.currentBlock,
            version: nodeCheck.version);
        NodeManager().addNodeSortedByLatency(type, resultNode, notify: false);
        return resultNode;
      } catch (e) {
        if (debug) {
          logger('Error fetching $endpoint, error: $e');
        }
        return null;
      }
    }).toList();

    // Wait for all checks to complete in parallel
    final List<Node?> results = await Future.wait(nodeFutures);

    // Filter out null results and add to list
    lNodes.addAll(results.whereType<Node>());

    // Notify once after all updates
    if (lNodes.isNotEmpty) {
      NodeManager().notifyObserver();
      if (debug) {
        logger(
            'Fetched ${lNodes.length} ${type.name} nodes ordered by latency (first: ${lNodes.first.url})');
      }
    }
  } catch (e, stacktrace) {
    await Sentry.captureException(e, stackTrace: stacktrace);
    logger('General error in fetch ${type.name}: $e');
    logger(stacktrace);
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  if (debug && lNodes.isNotEmpty) {
    logger('First node in list ${lNodes.first.url}');
  }
  return lNodes;
}

Future<NodeCheckResult> _pingNode(String node, NodeType type,
    {bool debug = true}) async {
  const Duration timeout = Duration(seconds: 10);

  final Map<NodeType,
          Future<NodeCheckResult> Function(String node, Duration timeout)>
      testFunctions = <NodeType,
          Future<NodeCheckResult> Function(String node, Duration timeout)>{
    NodeType.duniter: testDuniterV1Node,
    NodeType.cesiumPlus: testCPlusV1Node,
    NodeType.gva: testGVAV1Node,
    NodeType.endpoint: testEndPointV2,
    NodeType.duniterIndexer: testDuniterIndexerV2,
    NodeType.datapodEndpoint: testDuniterDatapodV2,
    NodeType.ipfsGateway: testIpfsGateway
  };

  final Future<NodeCheckResult> Function(String node, Duration timeout)
      testFunction = testFunctions[type] ?? testDuniterIndexerV2;

  try {
    final NodeCheckResult result = await testFunction(node, timeout);
    if (debug) {
      _logNodePing(node, type, result.latency, result.currentBlock);
    }
    return result;
  } catch (e) {
    if (debug) {
      logger(
          'Node $node does not respond to ping: ${removeNewlines(e.toString())}');
    }
    return NodeCheckResult(
        latency: wrongNodeDuration, currentBlock: 0, genesisHash: null);
  }
}

void _logNodePing(
    String node, NodeType type, Duration latency, int currentBlock) {
  logger(
      'Ping tested in node $node ($type), latency ${latency.inMicroseconds}, current block $currentBlock');
}

Future<Tuple2<Node, http.Response>> requestWithRetry(NodeType type, String path,
    {bool dontRecord = false, bool retryWith404 = true}) async {
  return _requestWithRetry(type, path, dontRecord, retryWith404);
}

Future<Tuple2<Node, http.Response>> requestDuniterWithRetry(String path,
    {bool retryWith404 = true}) async {
  return _requestWithRetry(NodeType.duniter, path, true, retryWith404);
}

Future<Tuple2<Node, http.Response>> requestCPlusWithRetry(String path,
    {bool retryWith404 = true, bool quickMode = false}) async {
  // Check if this request is already in-flight
  if (_cPlusInFlight.containsKey(path)) {
    // Deduplicate: create a completer and wait for the in-flight request
    final Completer<Tuple2<Node, http.Response>> completer =
        Completer<Tuple2<Node, http.Response>>();
    _cPlusInFlight[path]!.add(completer);
    logger('Deduplicating CesiumPlus request for: $path');
    return completer.future;
  }

  // Mark this request as in-flight
  final Completer<Tuple2<Node, http.Response>> mainCompleter =
      Completer<Tuple2<Node, http.Response>>();
  _cPlusInFlight[path] = <Completer<Tuple2<Node, http.Response>>>[
    mainCompleter
  ];

  try {
    // For profile reads (/user/profile/...), 404 is a valid response (user has no profile)
    // For other operations, 404 is an error
    final bool treat404AsValid = path.contains('/user/profile/') &&
        !path.contains('_update') &&
        !path.contains('_delete') &&
        !path.contains('_search');

    final Tuple2<Node, http.Response> result = await _requestWithRetry(
        NodeType.cesiumPlus, path, true, retryWith404,
        quickMode: quickMode, treat404AsValid: treat404AsValid);

    // Notify all waiting completers
    final List<Completer<Tuple2<Node, http.Response>>>? waiters =
        _cPlusInFlight.remove(path);
    if (waiters != null) {
      for (final Completer<Tuple2<Node, http.Response>> waiter in waiters) {
        waiter.complete(result);
      }
    }

    return result;
  } catch (e) {
    // Notify all waiting completers about the error
    final List<Completer<Tuple2<Node, http.Response>>>? waiters =
        _cPlusInFlight.remove(path);
    if (waiters != null) {
      for (final Completer<Tuple2<Node, http.Response>> waiter in waiters) {
        waiter.completeError(e);
      }
    }
    rethrow;
  }
}

Future<Tuple2<Node, http.Response>> requestGvaWithRetry(String path,
    {bool retryWith404 = true,
    HttpType httpType = HttpType.get,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding}) async {
  return _requestWithRetry(NodeType.gva, path, true, retryWith404,
      httpType: httpType, headers: headers, body: body, encoding: encoding);
}

enum HttpType { get, post, delete }

Future<Tuple2<Node, http.Response>> _requestWithRetry(
    NodeType type, String path, bool dontRecord, bool retryWith404,
    {HttpType httpType = HttpType.get,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool quickMode = false,
    bool treat404AsValid = false}) async {
  final List<Node> nodes = NodeManager().getBestNodes(type);

  // Track consecutive 404s to detect "resource doesn't exist" scenario
  int consecutive404s = 0;

  // In quick mode, use shorter timeouts (3s instead of 30s for CesiumPlus)
  final int baseTimeout =
      quickMode ? 3 : (type == NodeType.cesiumPlus ? 30 : 10);

  for (final int timeout in <int>[baseTimeout, baseTimeout * 2]) {
    // only one timeout for now
    for (int i = 0; i < nodes.length; i++) {
      final Node node = nodes[i];
      try {
        final Uri url = Uri.parse('${node.url}$path');
        logger('Fetching $url (${type.name})');
        final int startTime = DateTime.now().millisecondsSinceEpoch;
        final Response response = httpType == HttpType.get
            ? await getWithTimeout(url, timeout: Duration(seconds: timeout))
            : httpType == HttpType.post
                ? await http
                    .post(url, body: body, headers: headers, encoding: encoding)
                    .timeout(Duration(seconds: timeout))
                : await http
                    .delete(url,
                        body: body, headers: headers, encoding: encoding)
                    .timeout(Duration(seconds: timeout));
        final int endTime = DateTime.now().millisecondsSinceEpoch;
        final int newLatency = endTime - startTime;
        if (!kReleaseMode) {
          logger('response.statusCode: ${response.statusCode}');
        }
        if (response.statusCode == 200) {
          if (!dontRecord) {
            NodeManager().updateNode(type, node.copyWith(latency: newLatency));
          }
          return Tuple2<Node, Response>(node, response);
        } else if (response.statusCode == 404) {
          logger('404 on fetch $url');
          if (retryWith404) {
            consecutive404s++;

            // If treat404AsValid is true, 404 is a valid response (resource doesn't exist)
            // Don't penalize the node for returning a 404
            // If treat404AsValid is false, 404 is an error (for write operations)
            if (!treat404AsValid) {
              NodeManager()
                  .updateNode(type, node.copyWith(errors: node.errors + 1));
            }

            // If we got 404 from 1-2 nodes and treat404AsValid, it's confirmed
            if (treat404AsValid && consecutive404s >= min(2, nodes.length)) {
              logger(
                  'Multiple nodes returned 404 for $path - resource does not exist');
              return Tuple2<Node, Response>(node, response);
            }

            logger(
                '${node.url} gave 404, retrying with other ($consecutive404s/${nodes.length})');
            continue;
          } else {
            if (!kReleaseMode) {
              logger('Returning not 200 or 400 response');
            }
            return Tuple2<Node, Response>(node, response);
          }
        } else if (response.statusCode == 502 || response.statusCode == 503) {
          // 502 Bad Gateway or 503 Service Unavailable - node is likely down
          // Mark with many errors to deprioritize it immediately
          logger(
              '${response.statusCode} error on $url - marking node as critical');
          NodeManager().updateNode(
              type, node.copyWith(errors: NodeManager.absoluteMaxErrors - 1));
          // Don't retry this node in this timeout round, move to next node
          continue;
        } else {
          /* await Sentry.captureMessage(
              'Error trying to use node ${node.url} ($type) ${response.statusCode}'); */
          logger('${response.statusCode} error on $url');
          NodeManager()
              .updateNode(type, node.copyWith(errors: node.errors + 1));
        }
      } catch (e) {
        /* await Sentry.captureMessage(
            'Error trying to use node ${node.url} ($type) $e'); */
        logger('Error trying ${node.url} $e');
        if (!dontRecord) {
          NodeManager()
              .increaseNodeErrors(type, node, cause: 'Request failed: $e');
        }
        continue;
      }
    }
  }

  // If all attempts returned 404 and it's a valid response, return the 404
  if (treat404AsValid && consecutive404s > 0) {
    logger('All attempts returned 404 for $path - resource does not exist');
    return Tuple2<Node, Response>(
      nodes.last,
      http.Response('{"found": false}', 404),
    );
  }

  // Improved logging for diagnosis
  final String failureDetails = nodes
      .map((Node node) => '${node.url} (errors: ${node.errors})')
      .join(', ');

  logger(
      '⚠️ Failed to fetch $path from any node. Nodes tried: $failureDetails');
  await Sentry.captureMessage(
    'NoNodesException for ${type.name} at $path',
    level: SentryLevel.warning,
  );

  throw NoNodesException(
      'Cannot make the request to any of the ${nodes.length} nodes');
}

Future<PayResult> payV1(
    {required List<String> to, required double amount, String? comment}) async {
  try {
    final Tuple2<String, Node> selected = getGvaNode();

    final String nodeUrl = selected.item1;
    try {
      final Gva gva = Gva(node: nodeUrl);
      final CesiumWallet wallet =
          await SharedPreferencesHelper().getCesiumWallet();
      logger(
          'Trying $nodeUrl to send $amount to $to with comment ${comment ?? ''}');
      String response;
      if (to.length == 1) {
        response = await gva.pay(
            recipient: extractPublicKey(to[0]),
            amount: amount,
            comment: comment ?? '',
            cesiumSeed: wallet.seed,
            useMempool: true,
            raiseException: true);
      } else {
        response = await gva.complexPay(
            recipients: to
                .map((String recipient) => extractPublicKey(recipient))
                .toList(),
            amounts: List<double>.filled(to.length, amount),
            totalAmount: amount * to.length,
            comment: comment ?? '',
            cesiumSeed: wallet.seed,
            useMempool: true,
            raiseException: true);
      }
      logger('GVA replied with "$response"');
      return PayResult(message: response, node: selected.item2);
    } catch (e, stacktrace) {
      if (e is GraphQLException) {
        final List<String> eCause = e.cause.split('message:');
        final String eCauseWithoutTitle = eCause.isNotEmpty
            ? eCause[eCause.length > 1 ? 1 : 0]
            : 'Unknown error';
        final String rawMessage = eCauseWithoutTitle.contains(',')
            ? eCauseWithoutTitle.split(',')[0]
            : eCauseWithoutTitle;
        if (rawMessage.contains('nsufficient balance')) {
          return PayResult(
              node: selected.item2,
              message: 'Insufficient balance in your wallet');
        }
        return PayResult(
            node: selected.item2,
            message: eCause.isNotEmpty
                ? rawMessage
                : 'Transaction failed for unknown reason');
      }
      await Sentry.captureException(e, stackTrace: stacktrace);
      logger(e);
      logger(stacktrace);
      return PayResult(
          node: selected.item2,
          message: "Something didn't work as expected ($e)");
    }
  } catch (e) {
    return PayResult(
        message: "Something didn't work as expected retrieving the nodes ($e)");
  }
}

Tuple2<String, Node> getGvaNode() {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.gva);

  if (nodes.isEmpty) {
    throw Exception(
        'Sorry: I cannot find a working node to send the transaction');
  }

  final Node? currentGvaNode = NodeManager().getCurrentGvaNode();

  // Check if the current node is in the list and has no errors
  final bool currentIsHealthy = currentGvaNode != null &&
      currentGvaNode.errors == 0 &&
      nodes.contains(currentGvaNode);

  // It's in the list but has some errors
  final bool currentIsFallback =
      currentGvaNode != null && nodes.contains(currentGvaNode);

  final Node selectedNode = currentIsHealthy
      ? currentGvaNode
      : nodes.firstWhere((Node node) => node.errors == 0,
          orElse: () => currentIsFallback ? currentGvaNode : nodes.first);

  loggerDev(
    'Selected GVA node ${selectedNode.url}, '
    'previous: ${currentGvaNode?.url ?? "none"}, '
    'errors: ${selectedNode.errors}',
  );

  return Tuple2<String, Node>(proxyfyNode(selectedNode.url), selectedNode);
}

Tuple2<String, Node> getGvaNodeOld() {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.gva);
  if (nodes.isNotEmpty) {
    final Node? currentGvaNode = NodeManager().getCurrentGvaNode();
    final bool currentIsInBest = nodes.contains(currentGvaNode);

    final Node newNode =
        currentIsInBest ? currentGvaNode ?? nodes.first : nodes.first;
    loggerDev(
        'New GVA node ${newNode.url} and currentGva ${currentGvaNode ?? const Node(url: "No node").url} is in best nodes: $currentIsInBest');
    NodeManager().setCurrentGvaNode(newNode);
    loggerDev('New GVA node ${newNode.url}');
    return Tuple2<String, Node>(proxyfyNode(newNode.url), newNode);
  } else {
    throw Exception(
        'Sorry: I cannot find a working node to send the transaction');
  }
}

Future<Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalanceV1(
    String pubKeyRaw,
    {int? pageSize,
    int? from,
    int? to,
    String? cursor,
    required bool isConnected}) async {
  logger(
      'Get tx history (page size: $pageSize: cursor $cursor, from: $from, to: $to)');
  final String pubKey = extractPublicKey(pubKeyRaw);
  return gvaFunctionWrapper<Map<String, dynamic>>((Gva gva) => gva
      .history(pubKey, pageSize: pageSize, cursor: cursor, from: from, to: to));
}

Future<Tuple2<double?, Node>> gvaBalance(String pubKey) async {
  return gvaFunctionWrapper<double>((Gva gva) => gva.balance(pubKey));
}

Future<Tuple2<String?, Node>> gvaNick(String pubKey) async {
  return gvaFunctionWrapper<String>(
      (Gva gva) => gva.getUsername(extractPublicKey(pubKey)));
}

Future<Tuple2<Map<String, dynamic>?, Node>> getCurrentBlockGVA() async {
  return gvaFunctionWrapper<Map<String, dynamic>>(
      (Gva gva) => gva.getCurrentBlockExtended());
}

Future<Tuple2<T?, Node>> gvaFunctionWrapper<T>(
    Future<T?> Function(Gva) specificFunction) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.gva);

  // Try first the current GVA node
  final Node? currentGvaNode = NodeManager().getCurrentGvaNode();
  if (currentGvaNode != null) {
    // Try to put the current Node first
    final bool currentBlockSynced = nodes.isNotEmpty &&
        currentGvaNode.currentBlock >= nodes.first.currentBlock;
    if (currentBlockSynced) {
      nodes.remove(currentGvaNode);
      nodes.insert(0, currentGvaNode);
    }
  }

  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];
    try {
      final Gva gva = Gva(node: proxyfyNode(node.url));
      logger('Trying to use gva ${node.url}');
      final T? result = await specificFunction(gva)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Timeout');
      });
      logger('Returning results from ${node.url}');
      return Tuple2<T?, Node>(result, node);
    } catch (e) {
      await Sentry.captureMessage(
          'Error trying to use gva node ${node.url} $e');
      logger('Error trying ${node.url} $e');
      NodeManager().increaseNodeErrors(NodeType.gva, node,
          cause: 'GVA request failed: $e');
      continue;
    }
  }
  throw Exception('Sorry: I cannot find a working gva node');
}

// http://doc.e-is.pro/cesium-plus-pod/REST_API.html#userprofile
// https://git.p2p.legal/axiom-team/jaklis/src/branch/master/lib/cesiumCommon.py
// Get an profile, by public key: user/profile/<pubkey>
// Add a new profile: user/profile (POST)
// Update an existing profile: user/profile/_update (POST)
// Delete an existing profile: user/profile/_delete (DELETE?)
Future<bool> createOrUpdateProfileV1(String name) async {
  final CesiumWallet wallet = await SharedPreferencesHelper().getCesiumWallet();
  final String pubKey = extractPublicKey(wallet.pubkey);

  // Check if the user exists
  final String? userName = await getProfileUserName(pubKey);

  // Prepare the user profile data
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'issuer': pubKey,
    'title': name,
    'geoPoint': null,
    'time': DateTime.now().millisecondsSinceEpoch ~/
        1000, // current time in seconds
    'tags': <String>[],
  };

  hashAndSign(userProfile, wallet);

  // Convert the user profile data into a JSON string again, now including hash and signature
  final String userProfileJsonWithHashAndSignature = jsonEncode(userProfile);

  if (userName != null) {
    logger('User exists, update the user profile');
    final http.Response updateResponse = (await _requestWithRetry(
            NodeType.cesiumPlus,
            '/user/profile/$pubKey/_update?pubkey=$pubKey',
            false,
            true,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;
    if (updateResponse.statusCode == 200) {
      logger('User profile updated successfully.');
      return true;
    } else {
      logger(
          'Failed to update user profile. Status code: ${updateResponse.statusCode}');
      logger('Response body: ${updateResponse.body}');
      return false;
    }
  } else if (userName == null) {
    logger('User does not exist, create a new user profile');
    final http.Response createResponse = (await _requestWithRetry(
            NodeType.cesiumPlus, '/user/profile', false, false,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;

    if (createResponse.statusCode == 200) {
      logger('User profile created successfully.');
      return true;
    } else {
      logger(
          'Failed to create user profile. Status code: ${createResponse.statusCode}');
      return false;
    }
  }
  return false;
}

Map<String, String> _defCPlusHeaders() {
  return <String, String>{
    'Accept': 'application/json, text/plain, */*',
    'Content-Type': 'application/json;charset=UTF-8',
  };
}

void hashAndSign(Map<String, dynamic> data, CesiumWallet wallet) {
  final String dataJson = jsonEncode(data);
  final String hash = calculateHash(dataJson);
  final String signature = wallet.sign(hash);
  data['hash'] = hash;
  data['signature'] = signature;
}

void hashAndSignV2(Map<String, dynamic> data, KeyPair wallet) {
  // For V2 with Cesium Plus: Use the same hash/sign method as V1
  // Cesium Plus API expects V1-style signatures
  final String dataJson = jsonEncode(data);
  final String hash = calculateHash(dataJson);

  // Sign the hash (UTF-8 encoded) using KeyPair
  // This matches what CesiumWallet does internally
  final Uint8List hashBytes = Uint8List.fromList(utf8.encode(hash));
  final Uint8List signatureBytes = wallet.sign(hashBytes);
  final String signature = base64.encode(signatureBytes);

  // Add hash and signature to the data
  data['hash'] = hash;
  data['signature'] = signature;
}

// http://doc.e-is.pro/cesium-plus-pod/REST_API.html#userprofile
// https://git.p2p.legal/axiom-team/jaklis/src/branch/master/lib/cesiumCommon.py
// Get an profile, by public key: user/profile/<pubkey>
// Add a new profile: user/profile (POST)
// Update an existing profile: user/profile/_update (POST)
// Delete an existing profile: user/profile/_delete (DELETE?)
Future<bool> createOrUpdateProfileV2cPlus(String name) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  // Cesium Plus expects V1 pubkey format, so convert from V2 address
  final String pubKey = v1pubkeyFromAddress(wallet.address);

  // Check if the user exists
  final String? userName = await getProfileUserName(pubKey);

  // Prepare the user profile data
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'issuer': pubKey,
    'title': name,
    'geoPoint': null,
    'time': DateTime.now().millisecondsSinceEpoch ~/
        1000, // current time in seconds
    'tags': <String>[],
  };

  hashAndSignV2(userProfile, wallet);

  // Convert the user profile data into a JSON string again, now including hash and signature
  final String userProfileJsonWithHashAndSignature = jsonEncode(userProfile);

  if (userName != null) {
    logger('User exists, update the user profile');
    final http.Response updateResponse = (await _requestWithRetry(
            NodeType.cesiumPlus,
            '/user/profile/$pubKey/_update?pubkey=$pubKey',
            false,
            true,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;
    if (updateResponse.statusCode == 200) {
      logger('User profile updated successfully.');
      return true;
    } else {
      logger(
          'Failed to update user profile. Status code: ${updateResponse.statusCode}');
      logger('Response body: ${updateResponse.body}');
      return false;
    }
  } else if (userName == null) {
    logger('User does not exist, create a new user profile');
    final http.Response createResponse = (await _requestWithRetry(
            NodeType.cesiumPlus, '/user/profile', false, false,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;

    if (createResponse.statusCode == 200) {
      logger('User profile created successfully.');
      return true;
    } else {
      logger(
          'Failed to create user profile. Status code: ${createResponse.statusCode}');
      return false;
    }
  }
  return false;
}

/// Extended profile update for V2cPlus with full profile fields
/// Supports: title, description, city, socials, avatar (base64)
Future<bool> createOrUpdateProfileV2cPlusExtended({
  required String title,
  String? description,
  String? city,
  String? avatarBase64,
  List<Map<String, String>>? socials,
}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  // Cesium Plus expects V1 pubkey format, so convert from V2 address
  final String pubKey = v1pubkeyFromAddress(wallet.address);

  // Check if the user exists
  final String? userName = await getProfileUserName(pubKey);

  // Prepare the user profile data
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'issuer': pubKey,
    'title': title,
    'time': DateTime.now().millisecondsSinceEpoch ~/
        1000, // current time in seconds
  };

  // Add optional fields if provided
  if (description != null && description.isNotEmpty) {
    userProfile['description'] = description;
  }

  if (city != null && city.isNotEmpty) {
    userProfile['city'] = city;
  }

  if (socials != null && socials.isNotEmpty) {
    userProfile['socials'] = socials;
  }

  // Add avatar if provided (as base64 with mime type)
  if (avatarBase64 != null && avatarBase64.isNotEmpty) {
    userProfile['avatar'] = <String, String>{
      '_content_type': 'image/png', // Adjust based on actual type if needed
      '_content': avatarBase64,
    };
  }

  hashAndSignV2(userProfile, wallet);

  // Convert the user profile data into a JSON string again, now including hash and signature
  final String userProfileJsonWithHashAndSignature = jsonEncode(userProfile);

  if (userName != null) {
    logger('User exists, update the user profile with extended fields');
    final http.Response updateResponse = (await _requestWithRetry(
            NodeType.cesiumPlus,
            '/user/profile/$pubKey/_update?pubkey=$pubKey',
            false,
            true,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;
    if (updateResponse.statusCode == 200) {
      logger('User profile updated successfully.');
      return true;
    } else {
      logger(
          'Failed to update user profile. Status code: ${updateResponse.statusCode}');
      logger('Response body: ${updateResponse.body}');
      return false;
    }
  } else if (userName == null) {
    logger(
        'User does not exist, create a new user profile with extended fields');
    final http.Response createResponse = (await _requestWithRetry(
            NodeType.cesiumPlus, '/user/profile', false, false,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: userProfileJsonWithHashAndSignature))
        .item2;

    if (createResponse.statusCode == 200) {
      logger('User profile created successfully.');
      return true;
    } else {
      logger(
          'Failed to create user profile. Status code: ${createResponse.statusCode}');
      return false;
    }
  }
  return false;
}

Future<String?> getProfileUserNameV1(String pubKey) async {
  final Contact c =
      await getProfile(pubKey, onlyProfile: true, complete: false);
  return c.name;
}

Future<bool> deleteProfileV1() async {
  final CesiumWallet wallet = await SharedPreferencesHelper().getCesiumWallet();
  final String pubKey = extractPublicKey(wallet.pubkey);
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'id': pubKey,
    'issuer': pubKey,
    'index': 'user',
    'type': 'profile',
    'time': DateTime.now().millisecondsSinceEpoch ~/
        1000, // current time in seconds
  };
  hashAndSign(userProfile, wallet);

  final http.Response delResponse = (await _requestWithRetry(
          NodeType.cesiumPlus, '/history/delete', false, false,
          httpType: HttpType.post,
          headers: _defCPlusHeaders(),
          body: jsonEncode(userProfile)))
      .item2;
  return delResponse.statusCode == 200;
}

Future<bool> deleteProfileV2cPlus() async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  // Cesium Plus expects V1 pubkey format, so convert from V2 address
  final String pubKey = v1pubkeyFromAddress(wallet.address);
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'id': pubKey,
    'issuer': pubKey,
    'index': 'user',
    'type': 'profile',
    'time': DateTime.now().millisecondsSinceEpoch ~/
        1000, // current time in seconds
  };
  hashAndSignV2(userProfile, wallet);

  final http.Response delResponse = (await _requestWithRetry(
          NodeType.cesiumPlus, '/history/delete', false, false,
          httpType: HttpType.post,
          headers: _defCPlusHeaders(),
          body: jsonEncode(userProfile)))
      .item2;
  return delResponse.statusCode == 200;
}

/// Migrate a Cesium+ profile from one account to another.
/// This reads the profile from the old pubkey, creates it under the new
/// pubkey (signed by the new keypair), and deletes the old profile
/// (signed by the old keypair).
/// Returns true if migration succeeded, false otherwise.
/// Throws on unexpected errors (caller should handle).
Future<bool> migrateProfileCPlus({
  required KeyPair oldKeyPair,
  required KeyPair newKeyPair,
}) async {
  final String oldPubKey = v1pubkeyFromAddress(oldKeyPair.address);
  final String newPubKey = v1pubkeyFromAddress(newKeyPair.address);

  // Step 1: Read the old profile from Cesium+
  final Response oldProfileResponse =
      (await requestCPlusWithRetry('/user/profile/$oldPubKey')).item2;

  if (oldProfileResponse.statusCode != 200) {
    logger('Cannot read old C+ profile for $oldPubKey: '
        'status ${oldProfileResponse.statusCode}');
    return false;
  }

  final Map<String, dynamic> oldResult = const JsonDecoder()
      .convert(oldProfileResponse.body) as Map<String, dynamic>;

  if (oldResult['found'] == false) {
    logger('No C+ profile found for old pubkey $oldPubKey, nothing to migrate');
    return true; // No profile to migrate is not an error
  }

  final Map<String, dynamic> source =
      oldResult['_source'] as Map<String, dynamic>;

  // Step 2: Create the profile under the new pubkey
  final Map<String, dynamic> newProfile = <String, dynamic>{
    'version': 2,
    'issuer': newPubKey,
    'title': source['title'] as String? ?? '',
    'time': DateTime.now().millisecondsSinceEpoch ~/ 1000,
  };

  // Copy optional fields from old profile
  if (source['description'] != null) {
    newProfile['description'] = source['description'];
  }
  if (source['city'] != null) {
    newProfile['city'] = source['city'];
  }
  if (source['geoPoint'] != null) {
    newProfile['geoPoint'] = source['geoPoint'];
  }
  if (source['socials'] != null) {
    newProfile['socials'] = source['socials'];
  }
  if (source['avatar'] != null) {
    newProfile['avatar'] = source['avatar'];
  }
  if (source['tags'] != null) {
    newProfile['tags'] = source['tags'];
  }

  hashAndSignV2(newProfile, newKeyPair);
  final String newProfileJson = jsonEncode(newProfile);

  // Check if new pubkey already has a profile
  final String? existingName = await getProfileUserName(newPubKey);

  http.Response createResponse;
  if (existingName != null) {
    // Update existing profile at new pubkey
    createResponse = (await _requestWithRetry(NodeType.cesiumPlus,
            '/user/profile/$newPubKey/_update?pubkey=$newPubKey', false, true,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: newProfileJson))
        .item2;
  } else {
    // Create new profile at new pubkey
    createResponse = (await _requestWithRetry(
            NodeType.cesiumPlus, '/user/profile', false, false,
            httpType: HttpType.post,
            headers: _defCPlusHeaders(),
            body: newProfileJson))
        .item2;
  }

  if (createResponse.statusCode != 200) {
    logger('Failed to create C+ profile for new pubkey $newPubKey: '
        'status ${createResponse.statusCode}');
    return false;
  }

  logger('C+ profile created/updated for new pubkey $newPubKey');

  // Step 3: Delete the old profile
  final Map<String, dynamic> deleteData = <String, dynamic>{
    'version': 2,
    'id': oldPubKey,
    'issuer': oldPubKey,
    'index': 'user',
    'type': 'profile',
    'time': DateTime.now().millisecondsSinceEpoch ~/ 1000,
  };
  hashAndSignV2(deleteData, oldKeyPair);

  final http.Response delResponse = (await _requestWithRetry(
          NodeType.cesiumPlus, '/history/delete', false, false,
          httpType: HttpType.post,
          headers: _defCPlusHeaders(),
          body: jsonEncode(deleteData)))
      .item2;

  if (delResponse.statusCode != 200) {
    logger('C+ profile created for new pubkey but failed to delete old: '
        'status ${delResponse.statusCode}');
    // Profile was copied but old not deleted - partial success
    // Still return true since the new profile exists
    return true;
  }

  logger('C+ profile migrated successfully from $oldPubKey to $newPubKey');
  return true;
}

String calculateHash(String input) {
  final List<int> bytes = utf8.encode(input); // data being hashed
  final Digest digest = sha256.convert(bytes);
  return digest.toString().toUpperCase();
}

Future<Tuple2<Map<String, dynamic>?, Node>> gvaFetchUtxosOfScript(
    {required String pubKeyRaw,
    int pageSize = 100,
    String? cursor,
    int? amount}) {
  final String pubKey = extractPublicKey(pubKeyRaw);
  return gvaFunctionWrapper<Map<String, dynamic>>((Gva gva) =>
      gva.fetchUtxosOfScript(
          script: pubKey, pageSize: pageSize, amount: amount, cursor: cursor));
}

Future<PayResult> payWithBMA({
  required CesiumWallet wallet,
  required List<Utxo> utxos,
  required String destPub,
  required double amount,
  required String blockNumber,
  required String blockHash,
  String? comment,
}) async {
  try {
    final String issuer = wallet.pubkey;
    // Change back address == issuer
    final String restPub = issuer;

    final List<List<Utxo>> utxoSlices = sliceUtxos(utxos);
    Response? finalResponse;
    Node? node;
    for (final List<Utxo> utxoSlice in utxoSlices) {
      final Map<String, Object> transaction = <String, Object>{
        'Version': 10,
        'Currency': currency,
        'Blockstamp': '$blockNumber-$blockHash',
        'Locktime': 0,
        'Issuers': <String>[issuer],
        'Comment': comment ?? ''
      };

      // Inputs
      final List<String> inputs = <String>[];
      for (final Utxo utxo in utxoSlice) {
        // if D (DU) : AMOUNT:BASE:D:PUBLIC_KEY:BLOCK_ID
        // if T (TX) : AMOUNT:BASE:T:T_HASH:T_INDEX
        inputs.add(
            '${utxo.amount}:${utxo.base}:T:${utxo.txHash}:${utxo.outputIndex}');
      }
      transaction['Inputs'] = inputs;
      // Unlocks
      final List<String> unlocks = <String>[];
      for (int i = 0; i < utxos.length; i++) {
        // INPUT_INDEX:UNLOCK_CONDITION
        unlocks.add('$i:SIG(0)');
      }
      transaction['Unlocks'] = unlocks;

      final List<String> outputs = <String>[];

      // AMOUNT:BASE:CONDITIONS
      double rest = amount;
      final int maxBase =
          utxos.fold(0, (int prev, Utxo utxo) => max(prev, utxo.base));
      final double inputsAmount =
          utxos.fold(0, (double prev, Utxo utxo) => prev + utxo.amount);
      int outputBase = maxBase;
      int outputOffset = 0;
      final List<Map<String, dynamic>> newSources = <Map<String, dynamic>>[];

      if (destPub != issuer) {
        while (rest > 0) {
          double outputAmount = truncBase(rest, outputBase);
          rest -= outputAmount;
          if (outputAmount > 0) {
            outputAmount = outputBase == 0
                ? outputAmount
                : outputAmount / pow(10, outputBase);
            outputs.add('$outputAmount:$outputBase:SIG($destPub)');
            outputOffset++;
          }
          outputBase--;
        }
        rest = inputsAmount - amount;
        outputBase = maxBase;
      }

      while (rest > 0) {
        double outputAmount = truncBase(rest, outputBase);
        rest -= outputAmount;
        if (outputAmount > 0) {
          outputAmount = outputBase == 0
              ? outputAmount
              : outputAmount / pow(10, outputBase);
          outputs.add('$outputAmount:$outputBase:SIG($restPub)');
          if (issuer == restPub) {
            newSources.add(<String, dynamic>{
              'type': 'T',
              'noffset': outputOffset,
              'amount': outputAmount,
              'base': outputBase,
              'conditions': 'SIG($restPub)',
              'consumed': false,
            });
          }
          outputOffset++;
        }
        outputBase--;
      }
      transaction['Outputs'] = outputs;

      hashAndSign(transaction, wallet);
      final String transactionJson = jsonEncode(transaction);

      // final List<int> bytes = utf8.encode(transactionJson);
      logger(transactionJson);

      final Tuple2<Node, http.Response> response = await _requestWithRetry(
          NodeType.duniter, '/tx/processTesting', false, false,
          httpType: HttpType.post,
          // headers: ??
          body: transactionJson);
      finalResponse = response.item2;
      node = response.item1;
      if (response.item2.statusCode != 200) {
        return PayResult(
            node: response.item1,
            message: "Something didn't work as expected ($e)");
      }
    }
    return PayResult(message: finalResponse!.body, node: node);
  } catch (e) {
    return PayResult(message: "Something didn't work as expected ($e)");
  }
}

Future<NodeCheckResult> testDuniterIndexerV2(
    String node, Duration timeout) async {
  NodeCheckResult result;

  final Stopwatch stopwatch = Stopwatch()..start();
  final ferry.Client client = await initDuniterIndexerClient(node);

  // First get the version info - use empty string as default if fails
  String version = '';
  try {
    final ferry.OperationResponse<GIndexerVersionData, GIndexerVersionVars>
        versionResponse =
        await client.request(GIndexerVersionReq()).first.timeout(timeout);
    if (!versionResponse.hasErrors && versionResponse.data?.version != null) {
      version = versionResponse.data!.version.version;
      loggerDev('Node $node has indexer version: $version');
    } else {
      loggerDev('Node $node returned errors when getting version');
    }
  } catch (e) {
    loggerDev('Could not get version from node $node: $e');
  }

  // Then check the block height
  final ferry.OperationResponse<GLastBlockData, GLastBlockVars> response =
      await client.request(GLastBlockReq()).first.timeout(timeout);
  if (response.hasErrors) {
    loggerDev(
        'Node $node has errors: ${removeNewlines(response.linkException!.toString())}');
    result = NodeCheckResult(
        currentBlock: 0,
        latency: wrongNodeDuration,
        version: version,
        genesisHash: null);
  } else {
    final int currentBlock = response.data?.blocks?.nodes.first.height ?? 0;
    result = NodeCheckResult(
        currentBlock: currentBlock,
        latency: currentBlock > 0 ? stopwatch.elapsed : wrongNodeDuration,
        version: version,
        genesisHash: null);
  }
  return result;
}

Future<NodeCheckResult> testDuniterDatapodV2(
    String node, Duration timeout) async {
  NodeCheckResult result;

  final Stopwatch stopwatch = Stopwatch()..start();
  final ferry.Client client = await initDuniterDatapodClient(node);

  final ferry.OperationResponse<GGetProfileCountData, GGetProfileCountVars>
      response =
      await client.request(GGetProfileCountReq()).first.timeout(timeout);
  if (response.hasErrors) {
    loggerDev(
        'Node $node has errors: ${removeNewlines(response.linkException!.originalException.toString())}');
    result = NodeCheckResult(
        currentBlock: 0, latency: wrongNodeDuration, genesisHash: null);
  } else {
    final int currentBlock =
        response.data?.profiles_aggregate.aggregate?.count ?? 0;
    result = NodeCheckResult(
        currentBlock: currentBlock,
        latency: currentBlock > 0 ? stopwatch.elapsed : wrongNodeDuration,
        genesisHash: null);
  }
  return result;
}

Future<NodeCheckResult> testIpfsGateway(String node, Duration timeout) async {
  final Stopwatch stopwatch = Stopwatch()..start();
  final Response response = await getWithTimeout(Uri.parse(node));
  stopwatch.stop();
  final Duration latency =
      response.statusCode == 200 ? stopwatch.elapsed : wrongNodeDuration;
  final int currentBlock = response.statusCode;
  final NodeCheckResult result = NodeCheckResult(
      latency: latency, currentBlock: currentBlock, genesisHash: null);
  return result;
}

Future<NodeCheckResult> testGVAV1Node(String node, Duration timeout) async {
  final Stopwatch stopwatch = Stopwatch()..start();
  // Test GVA with a query
  final Gva gva = Gva(node: proxyfyNode(node));
  final int currentBlock = await gva.getCurrentBlock().timeout(timeout);
//      NodeManager().updateNode(type, node.copyWith(latency: newLatency));
  stopwatch.stop();
  final double balance = await gva
      .balance('78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8')
      .timeout(timeout);
  final Duration latency = balance >= 0 ? stopwatch.elapsed : wrongNodeDuration;
  final NodeCheckResult result = NodeCheckResult(
      latency: latency, currentBlock: currentBlock, genesisHash: null);
  return result;
}

Future<NodeCheckResult> testCPlusV1Node(String node, Duration timeout) async {
  int currentBlock = 0;
  Duration latency;
  final Stopwatch stopwatch = Stopwatch()..start();
  // see: http://g1.data.e-is.pro/network/peering
  final Response response = await getWithTimeout(Uri.parse('$node/node/stats'));
  stopwatch.stop();
  latency = stopwatch.elapsed;
  if (response.statusCode == 200) {
    try {
      final Map<String, dynamic> json =
          jsonDecode(response.body.replaceAll('"cluster"{', '"cluster": {'))
              as Map<String, dynamic>;
      currentBlock = ((((json['stats'] as Map<String, dynamic>)['cluster']
                  as Map<String, dynamic>)['indices']
              as Map<String, dynamic>)['docs'] as Map<String, dynamic>)['count']
          as int;
    } catch (e) {
      loggerDev('Cannot parse node/stats ${removeNewlines(e.toString())}');
    }
  } else {
    latency = wrongNodeDuration;
  }
  return NodeCheckResult(
      latency: latency, currentBlock: currentBlock, genesisHash: null);
}

Future<NodeCheckResult> testDuniterV1Node(String node, Duration timeout) async {
  int currentBlock = 0;
  Duration latency;
  final Stopwatch stopwatch = Stopwatch()..start();
  final Response response =
      await getWithTimeout(Uri.parse('$node/blockchain/current'));
  stopwatch.stop();
  latency = stopwatch.elapsed;
  if (response.statusCode == 200) {
    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    currentBlock = json['number'] as int;
  } else {
    latency = wrongNodeDuration;
  }
  return NodeCheckResult(
      latency: latency, currentBlock: currentBlock, genesisHash: null);
}

Future<Contact> getProfile(String pubKeyRaw,
    {bool onlyProfile = false,
    bool resize = true,
    required bool complete}) async {
  return GetIt.instance<ServiceManager>().current.getProfile(
        pubKeyRaw,
        onlyProfile: onlyProfile,
        resize: resize,
        complete: complete,
      );
}

Future<List<Contact>> searchWot(String searchPattern) async {
  return GetIt.instance<ServiceManager>().current.searchWot(searchPattern);
}

Future<List<Contact>> searchProfiles(String initialSearchTerm,
    {bool quickMode = false}) async {
  final String searchTerm = normalizeQuery(initialSearchTerm);
  final String searchTermLower = searchTerm.toLowerCase();
  final String searchTermCapitalized =
      searchTermLower[0].toUpperCase() + searchTermLower.substring(1);
  return GetIt.instance<ServiceManager>().current.searchProfiles(
      searchTermLower: searchTermLower,
      searchTerm: searchTerm,
      searchTermCapitalized: searchTermCapitalized,
      quickMode: quickMode);
}

Future<List<Contact>> getProfiles(List<String> pubKeys) async {
  return GetIt.instance<ServiceManager>().current.getProfiles(pubKeys);
}

Future<Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalance(
    String pubKeyRaw,
    {int? pageSize,
    int? from,
    int? to,
    String? cursor,
    required bool isConnected}) {
  return GetIt.instance<ServiceManager>().current.getHistoryAndBalance(
      pubKeyRaw,
      pageSize: pageSize,
      from: from,
      to: to,
      cursor: cursor,
      isConnected: isConnected);
}

Future<TransactionState> transactionsParser(
    Map<String, dynamic> txData, TransactionState state, String myPubKeyRaw,
    {String? cursor, double? cachedUd}) {
  return GetIt.instance<ServiceManager>().current.transactionsParser(
      txData, state, myPubKeyRaw,
      cursor: cursor, cachedUd: cachedUd);
}

Future<PayResult> pay(
    {required List<String> to, required double amount, String? comment}) async {
  return GetIt.instance<ServiceManager>()
      .current
      .pay(to: to, amount: amount, comment: comment);
}

Future<String?> getProfileUserName(String pubKey) {
  return GetIt.instance<ServiceManager>().current.getProfileUserName(pubKey);
}

Future<bool> createOrUpdateProfile(String name) {
  return GetIt.instance<ServiceManager>().current.createOrUpdateProfile(name);
}

Future<bool> deleteProfile() {
  return GetIt.instance<ServiceManager>().current.deleteProfile();
}

// Always wrap HTTP calls with this to enforce a hard timeout on Web as well.
Future<http.Response> getWithTimeout(Uri uri,
    {Duration timeout = const Duration(seconds: 10)}) {
  return http.get(uri).timeout(timeout);
}
