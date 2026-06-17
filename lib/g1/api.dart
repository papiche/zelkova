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
import '../env.dart';
import '../shared_prefs_helper.dart';
import '../shared_prefs_helper_v2.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import 'duniter_endpoint_helper.dart';
import 'g1_helper.dart';
import 'g1_v2_helper.dart';
import 'no_nodes_exception.dart';
import 'node_check_result.dart';
import 'nostr/nostr_profile.dart';
import 'nostr/nostr_relay_service.dart';
import 'pay_result.dart';
import 'service_manager.dart';
import 'v2_peers.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

// use g1-test or g1 for production (fallback to g1)
const String currencyDotEnv = Env.currency;
final String currency = currencyDotEnv.isEmpty ? 'g1' : currencyDotEnv;

// G1 production V2 genesis hash - used to validate discovered RPC nodes
// Obtained from .env file and https://get-g1-genesis-hash.p2p.legal
const String expectedG1GenesisHash = Env.genesisHash;

/// Normalizes genesis hashes for comparison (strips '0x' prefix, lowercase)
String _normalizeHash(String hash) {
  return hash
      .replaceFirst(RegExp(r'^0x', caseSensitive: false), '')
      .toLowerCase();
}

/// Compares two genesis hashes, handling '0x' prefix variations
bool _genesisHashesMatch(String? nodeHash, String expectedHash) {
  if (nodeHash == null) {
    return false;
  }
  return _normalizeHash(nodeHash) == _normalizeHash(expectedHash);
}

/// Extracts just the error message without full stack traces (max 50 chars)
String _getShortErrorMessage(String errorString) {
  // Take first 50 chars max - just the essential error message
  if (errorString.length > 50) {
    return '${errorString.substring(0, 50)}...';
  }
  return errorString;
}

/// Compares two semantic versions (descending: higher first, with version before without)
int _compareVersions(String? v1, String? v2) {
  // Both have versions: compare them (descending)
  if (v1 != null && v1.isNotEmpty && v2 != null && v2.isNotEmpty) {
    final List<int> p1 =
        v1.split('.').map(int.tryParse).whereType<int>().toList();
    final List<int> p2 =
        v2.split('.').map(int.tryParse).whereType<int>().toList();
    for (int i = 0; i < (p1.length > p2.length ? p1.length : p2.length); i++) {
      final int part1 = i < p1.length ? p1[i] : 0;
      final int part2 = i < p2.length ? p2[i] : 0;
      if (part1 != part2) {
        return part2 - part1; // Descending
      }
    }
    return 0;
  }
  // v1 has version, v2 doesn't: v1 comes first
  if (v1 != null && v1.isNotEmpty) {
    return -1;
  }
  if (v2 != null && v2.isNotEmpty) {
    return 1;
  }
  // Neither has version
  return 0;
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
    String nodeUrl = node.url;
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
              if (!_genesisHashesMatch(
                  nodeCheck.genesisHash, expectedG1GenesisHash)) {
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
    ..sort((Node a, Node b) {
      // First compare by version (higher versions first, then those with version)
      final int versionCmp = _compareVersions(a.version, b.version);
      if (versionCmp != 0) {
        return versionCmp;
      }
      // If same version, sort by latency
      return a.latency.compareTo(b.latency);
    });

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

// TTL for node list freshness — mirrors duniter_getnode.sh (CACHE_TTL=3600)
const Duration _nodeListTtl = Duration(hours: 1);

Future<void> fetchNodesIfNotReady(
    {required bool v2Only, bool isProduction = false}) async {
  final List<Future<void>> fetchFutures = <Future<void>>[];

  // Trigger fetch if < 3 working nodes OR if the list is stale (> 1h)
  final bool isStale = NodeManager().isNodeListStale(_nodeListTtl);

  for (final NodeType type in <NodeType>[
    NodeType.endpoint,
    NodeType.duniterIndexer,
  ]) {
    if (isStale || NodeManager().nodesWorking(type) < 3) {
      fetchFutures.add(fetchNodes(type, true, isProduction: isProduction));
    }
  }

  if (fetchFutures.isNotEmpty) {
    await Future.wait(fetchFutures);
  }
}

Future<void> fetchNodes(NodeType type, bool force,
    {bool isProduction = false}) async {
  try {
    final List<Future<void>> fetchFutures = <Future<void>>[];

    switch (type) {
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
      'https://git.duniter.org/nodes/networks/-/raw/master/gtest.json';
  return _fetchNodesFromNetworkJson(gtestUrl, 'gtest.json');
}

/// Fetches nodes from the g1.json file (production network)
/// Returns a tuple with (rpcNodes, squidNodes)
/// If fetching fails, returns empty lists to allow the application to continue
Future<Tuple2<List<Node>, List<Node>>> _fetchNodesFromG1Json() async {
  const String g1Url =
      'https://git.duniter.org/nodes/networks/-/raw/master/g1.json';
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

        // Ping failed (CORS, timeout, refused) — penalize and skip
        if (latency == wrongNodeDuration) {
          NodeManager().increaseNodeErrors(type, node,
              cause: 'Ping failed (CORS/timeout/refused)', notify: false);
          return null;
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
          'Node $node does not respond to ping: ${_getShortErrorMessage(e.toString())}');
    }
    return NodeCheckResult(latency: wrongNodeDuration, currentBlock: 0);
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

  final int baseTimeout = quickMode ? 3 : 10;

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

String calculateHash(String input) {
  final List<int> bytes = utf8.encode(input); // data being hashed
  final Digest digest = sha256.convert(bytes);
  return digest.toString().toUpperCase();
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
    if (!versionResponse.hasErrors && versionResponse.data != null) {
      final String versionString = versionResponse.data!.version.version;
      if (versionString != null && versionString.isNotEmpty) {
        version = versionString;
        loggerDev('Node $node has indexer version: $version');
      } else {
        loggerDev('Node $node: version query returned empty version');
      }
    } else if (versionResponse.hasErrors) {
      loggerDev('Node $node returned errors when getting version');
    } else {
      loggerDev('Node $node: version response has null data');
    }
  } catch (e) {
    loggerDev('Could not get version from node $node: $e');
  }

  // Then check the block height
  final ferry.OperationResponse<GLastBlockData, GLastBlockVars> response =
      await client.request(GLastBlockReq()).first.timeout(timeout);
  if (response.hasErrors) {
    loggerDev(
        'Node $node has errors: ${_getShortErrorMessage(response.linkException!.toString())}');
    result = NodeCheckResult(
        currentBlock: 0, latency: wrongNodeDuration, version: version);
  } else {
    final int currentBlock = response.data?.blocks?.nodes.first.height ?? 0;
    result = NodeCheckResult(
        currentBlock: currentBlock,
        latency: currentBlock > 0 ? stopwatch.elapsed : wrongNodeDuration,
        version: version);
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
        'Node $node has errors: ${_getShortErrorMessage(response.linkException!.originalException.toString())}');
    result = NodeCheckResult(currentBlock: 0, latency: wrongNodeDuration);
  } else {
    final int currentBlock =
        response.data?.profiles_aggregate.aggregate?.count ?? 0;
    result = NodeCheckResult(
        currentBlock: currentBlock,
        latency: currentBlock > 0 ? stopwatch.elapsed : wrongNodeDuration);
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
  final NodeCheckResult result =
      NodeCheckResult(latency: latency, currentBlock: currentBlock);
  return result;
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
  return NodeCheckResult(latency: latency, currentBlock: currentBlock);
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

Future<bool> createOrUpdateProfileNostr(String name) async {
  final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
  if (nsec == null) return false;

  final NostrRelayService relay = NostrRelayService();
  if (!relay.isConnected) return false;

  final String hexPriv = nsec;
  final String hexPub = NostrRelayService.derivePublicKey(hexPriv);

  final NostrProfile? existing = await relay.fetchProfile(hexPub);

  final NostrProfile newProfile = existing?.copyWith(name: name) ??
      NostrProfile(name: name, npub: hexPub);

  return relay.publishProfile(newProfile, hexPriv);
}

Future<bool> deleteProfile() {
  return GetIt.instance<ServiceManager>().current.deleteProfile();
}

Future<bool> deleteProfileNostr() async {
  final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
  if (nsec == null) return false;

  final NostrRelayService relay = NostrRelayService();
  if (!relay.isConnected) return false;

  final String hexPriv = nsec;
  final String hexPub = NostrRelayService.derivePublicKey(hexPriv);

  final NostrProfile emptyProfile =
      NostrProfile(name: 'Deleted User', npub: hexPub, about: '', picture: '');
  return relay.publishProfile(emptyProfile, hexPriv);
}

// Always wrap HTTP calls with this to enforce a hard timeout on Web as well.
Future<http.Response> getWithTimeout(Uri uri,
    {Duration timeout = const Duration(seconds: 10)}) {
  return http.get(uri).timeout(timeout);
}

Future<List<Contact>> searchProfilesV1(
    {required String searchTermLower,
    required String searchTerm,
    required String searchTermCapitalized,
    bool quickMode = false}) async {
  // Only use NOSTR relay search
  return _searchNostrRelay(searchTermLower);
}

Future<List<Contact>> _searchNostrRelay(String searchTerm) async {
  try {
    final NostrRelayService relay = NostrRelayService();
    if (!relay.isConnected) return <Contact>[];

    final List<NostrProfile> profiles = await relay.searchProfiles(searchTerm);
    final List<Contact> contacts = <Contact>[];
    for (final NostrProfile profile in profiles) {
      final String? g1pub = profile.g1pub;
      if (g1pub != null && g1pub.isNotEmpty) {
        final Contact c = Contact.withPubKey(
          pubKey: g1pub,
          name: profile.displayName ?? profile.name,
        ).copyWith(
          description: profile.about,
          city: profile.city,
          socials: profile.socials,
        );
        ContactsCache().addContact(c);
        contacts.add(c);
      }
    }
    return contacts;
  } catch (e) {
    loggerDev('Error in NOSTR relay search: $e');
    return <Contact>[];
  }
}
