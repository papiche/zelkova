import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:durt/durt.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:polkadart/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_html/html.dart' show window;

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_lists_default.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../data/models/utxo.dart';
import '../env.dart';
import '../graphql/__generated__/duniter-custom-queries.data.gql.dart';
import '../graphql/__generated__/duniter-custom-queries.req.gql.dart';
import '../graphql/__generated__/duniter-custom-queries.var.gql.dart';
import '../graphql/__generated__/duniter-indexer.schema.gql.dart';
import '../graphql/duniter_indexer_client.dart';
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_helper.dart';
import 'no_nodes_exception.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

// use g1-test or g1 for production (fallback to g1)
const String currencyDotEnv = Env.currency;
final String currency = currencyDotEnv.isEmpty ? 'g1' : currencyDotEnv;

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

Future<List<dynamic>> getPeers(NodeType type) async {
  final List<Node> nodes = NodeManager().nodeList(type);
  loggerDev('Fetching ${type.name} peers with peers ${nodes.length}');
  List<dynamic> currentPeers = <dynamic>[];
  for (final Node node in nodes) {
    String nodeUrl = node.url;
    nodeUrl = nodeUrl.replaceAll(RegExp(r'/gva$'), '');
    nodeUrl = '$nodeUrl/network/peers';
    loggerDev('Fetching $nodeUrl');
    try {
      final Response response = await http.get(Uri.parse(nodeUrl));
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
          // sometimes getPeers returns a small list of nodes (somethmes even one)
          currentPeers = peers;
        }
      }
    } catch (e) {
      loggerDev('Error retrieving $nodeUrl ($e)');
      // Ignore
    }
  }
  return currentPeers;
}

Future<Response> getPeersOld(NodeType type) async {
  final Response response =
      (await requestWithRetry(type, '/network/peers', dontRecord: true)).item2;
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load duniter node peers');
  }
}

Future<Response> searchCPlusUser(String initialSearchTerm) async {
  final String searchTerm = normalizeQuery(initialSearchTerm);
  final String searchTermLower = searchTerm.toLowerCase();
  final String searchTermCapitalized =
      searchTermLower[0].toUpperCase() + searchTermLower.substring(1);

  final String query =
      '/user/profile/_search?q=title:$searchTermLower OR issuer:$searchTerm OR title:$searchTermCapitalized OR title:$searchTerm';

  final Response response =
      (await requestCPlusWithRetry(query, retryWith404: false)).item2;
  return response;
}

Future<Contact> getProfile(String pubKeyRaw,
    {bool onlyCPlusProfile = false, bool resize = true}) async {
  final String pubKey = extractPublicKey(pubKeyRaw);
  try {
    final Response cPlusResponse = (await requestCPlusWithRetry(
            '/user/profile/$pubKey',
            retryWith404: false))
        .item2;
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

Future<List<Contact>> searchWotV2(String namePattern) async {
  final List<Contact> contacts = <Contact>[];
  final GAccountsByNameOrPkReq req = GAccountsByNameOrPkReq(
      (GAccountsByNameOrPkReqBuilder b) => b..vars.pattern = namePattern);
  final ferry.Client client = await initDuniterIndexerClient(
      _getBestNodes(NodeType.duniterIndexer).first.url);

  final ferry
      .OperationResponse<GAccountsByNameOrPkData, GAccountsByNameOrPkVars>
      response = await client.request(req).first;

  if (response.hasErrors) {
    loggerDev('Error: ${response.linkException?.originalException}');
  } else {
    final GAccountsByNameOrPkData? accounts = response.data;
    for (final GAccountsByNameOrPkData_account account in accounts!.account) {
      final String? pubkey = account.identity?.account?.identity?.pubkey;
      if (pubkey == null) {
        loggerDev('ERROR: Pubkey is null');
      } else {
        contacts.add(Contact(
            nick: account.identity?.account?.identity?.name, pubKey: pubkey));
      }
    }
  }
  return contacts;
}

@Deprecated('use getProfile')
Future<String> _getDataImageFromKey(String publicKey) async {
  final Response response =
      (await requestCPlusWithRetry('/user/profile/$publicKey')).item2;
  if (response.statusCode == HttpStatus.ok) {
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> source = data['_source'] as Map<String, dynamic>;
    if (source.containsKey('avatar')) {
      final Map<String, dynamic> avatarData =
          source['avatar'] as Map<String, dynamic>;
      if (avatarData.containsKey('_content')) {
        final String content = avatarData['_content'] as String;
        return 'data:image/png;base64,$content';
      }
    }
  }
  throw Exception('Failed to load avatar');
}

Uint8List imageFromBase64String(String base64String) {
  return Uint8List.fromList(
      base64Decode(base64String.substring(base64String.indexOf(',') + 1)));
}

@Deprecated('use getProfile')
Future<Uint8List> getAvatar(String pubKey) async {
  final String dataImage = await _getDataImageFromKey(pubKey);
  return imageFromBase64String(dataImage);
}

Future<void> fetchNodesIfNotReady() async {
  for (final NodeType type in <NodeType>[
    NodeType.gva,
    NodeType.duniter,
    NodeType.endpoint,
    NodeType.duniterIndexer
  ]) {
    if (NodeManager().nodesWorking(type) < 3) {
      await fetchNodes(type, true);
    }
  }
}

Future<void> fetchNodes(NodeType type, bool force) async {
  try {
    if (type == NodeType.duniter) {
      _fetchDuniterNodes(force: force);
    } else {
      if (type == NodeType.cesiumPlus) {
        _fetchCesiumPlusNodes(force: force);
      }
      if (type == NodeType.endpoint) {
        _fetchEndPointNodes(force: force);
      }
      if (type == NodeType.duniterIndexer) {
        _fetchDuniterIndexerNodes(force: force);
      } else {
        _fetchGvaNodes(force: force);
      }
    }
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

Future<void> _fetchEndPointNodes({bool force = false}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.endpoint;
  if (force) {
    NodeManager().updateNodes(type, defaultEndPointNodes);
    logger('Fetching endPoint nodes forced');
  } else {
    logger(
        'Fetching endPoint nodes, we have ${NodeManager().nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchNodes(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

Future<void> _fetchDuniterIndexerNodes({bool force = false}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.duniterIndexer;
  if (force) {
    NodeManager().updateNodes(type, defaultDuniterIndexerNodes);
    logger('Fetching duniter indexer nodes forced');
  } else {
    logger(
        'Fetching duniter indexer nodes, we have ${NodeManager().nodesWorking(type)}');
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
  // To compare with something...
  String? fastestNode;
  late Duration fastestLatency = const Duration(minutes: 1);
  try {
    final List<dynamic> peers = await getPeers(type);
    // reorder peer list
    peers.shuffle();
    for (final dynamic peerR in peers) {
      final Map<String, dynamic> peer = peerR as Map<String, dynamic>;
      if (peer['endpoints'] != null) {
        final List<String> endpoints =
            List<String>.from(peer['endpoints'] as List<dynamic>);
        for (int j = 0; j < endpoints.length; j++) {
          if (endpoints[j].startsWith(apyType)) {
            final String endpointUnParsed = endpoints[j];
            final String? endpoint = parseHost(endpointUnParsed);
            if (endpoint != null &&
                //  !endpoint.contains('test') &&
                !endpoint.contains('localhost')) {
              try {
                final NodeCheck nodeCheck = await _pingNode(endpoint, type);
                final Duration latency = nodeCheck.latency;
                loggerD(debug,
                    'Evaluating node: $endpoint, latency ${latency.inMicroseconds} currentBlock: ${nodeCheck.currentBlock}');
                final Node node = Node(
                    url: endpoint,
                    latency: latency.inMicroseconds,
                    currentBlock: nodeCheck.currentBlock);
                if (fastestNode == null || latency < fastestLatency) {
                  fastestNode = endpoint;
                  fastestLatency = latency;
                  if (!kReleaseMode) {
                    loggerD(
                        debug, 'Node bloc: Current faster node $fastestNode');
                  }
                  NodeManager().insertNode(type, node);
                  lNodes.insert(0, node);
                } else {
                  // Not the faster
                  NodeManager().addNode(type, node);
                  lNodes.add(node);
                }
              } catch (e) {
                logger('Error fetching $endpoint, error: $e');
              }
            }
          }
        }
        if (kReleaseMode && lNodes.length >= NodeManager.maxNodes) {
          // In production dont' get too much nodes
          loggerD(debug, 'We have enough ${type.name} nodes for now');
          break;
        }
      }
    }
    logger(
        'Fetched ${lNodes.length} ${type.name} nodes ordered by latency ${lNodes.isNotEmpty ? '(first: ${lNodes.first.url})' : '(zero nodes)'}');
  } catch (e, stacktrace) {
    await Sentry.captureException(e, stackTrace: stacktrace);
    logger('General error in fetch ${type.name} nodes: $e');
    logger(stacktrace);
    // rethrow;
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

Future<List<Node>> _fetchNodes(NodeType type) async {
  final List<Node> lNodes = <Node>[];
  String? fastestNode;
  late Duration fastestLatency = const Duration(minutes: 1);
  try {
    final List<Node> currentNodes = <Node>[...NodeManager().nodeList(type)];
    currentNodes.shuffle();
    for (final Node node in currentNodes) {
      final String endpoint = node.url;
      try {
        final NodeCheck nodeCheck = await _pingNode(endpoint, type);
        final Duration latency = nodeCheck.latency;
        logger('Evaluating node: $endpoint, latency ${latency.inMicroseconds}');
        final Node node = Node(
            url: endpoint,
            latency: latency.inMicroseconds,
            currentBlock: nodeCheck.currentBlock);
        if (fastestNode == null || latency < fastestLatency) {
          fastestNode = endpoint;
          fastestLatency = latency;
          if (!kReleaseMode) {
            logger('Node $type: Current faster node $fastestNode');
          }
          NodeManager().insertNode(type, node);
          lNodes.insert(0, node);
        } else {
          // Not the faster
          NodeManager().addNode(type, node);
          lNodes.add(node);
        }
      } catch (e) {
        logger('Error fetching $endpoint, error: $e');
      }
    }

    logger(
        'Fetched ${lNodes.length} ${type.name} nodes ordered by latency (first: ${lNodes.first.url})');
  } catch (e, stacktrace) {
    await Sentry.captureException(e, stackTrace: stacktrace);
    logger('General error in fetch ${type.name}: $e');
    logger(stacktrace);
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  logger('First node in list ${lNodes.first.url}');
  return lNodes;
}

Future<NodeCheck> _pingNode(String node, NodeType type) async {
  // Decrease timeout during ping
  const Duration timeout = Duration(seconds: 10);
  int currentBlock = 0;
  Duration latency;
  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    if (type == NodeType.duniter) {
      final Response response = await http
          .get(Uri.parse('$node/blockchain/current'))
          .timeout(timeout);
      stopwatch.stop();
      latency = stopwatch.elapsed;
      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        currentBlock = json['number'] as int;
      } else {
        latency = wrongNodeDuration;
      }
    } else if (type == NodeType.cesiumPlus) {
      // see: http://g1.data.e-is.pro/network/peering
      final Response response = await http
          .get(Uri.parse('$node/node/stats'))
          // Decrease http timeout during ping
          .timeout(timeout);
      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> json =
              jsonDecode(response.body.replaceAll('"cluster"{', '"cluster": {'))
                  as Map<String, dynamic>;
          currentBlock = ((((json['stats'] as Map<String, dynamic>)['cluster']
                      as Map<String, dynamic>)['indices']
                  as Map<String, dynamic>)['docs']
              as Map<String, dynamic>)['count'] as int;
        } catch (e) {
          loggerDev('Cannot parse node/stats $e');
        }
      } else {
        latency = wrongNodeDuration;
      }
      stopwatch.stop();
      latency = stopwatch.elapsed;
    } else if (type == NodeType.endpoint) {
      if (!kIsWeb) {
        try {
          final Provider polkadot = Provider(Uri.parse(node));
          // From:
          // https://github.com/leonardocustodio/polkadart/blob/main/examples/bin/extrinsic_demo.dart
          final RpcResponse<dynamic> block =
              await polkadot.send('chain_getBlock', <dynamic>[]);
          currentBlock = int.parse(
              (((block.result as Map<String, dynamic>)['block']
                      as Map<String, dynamic>)['header']
                  as Map<String, dynamic>)['number'] as String);
          stopwatch.stop();
          latency = stopwatch.elapsed;
          await polkadot.disconnect();
        } catch (e) {
          loggerDev('Cannot parse node/stats $e');
          latency = wrongNodeDuration;
        }
      } else {
        // Waiting for web support in polkadart:
        // https://github.com/leonardocustodio/polkadart/issues/297
        latency = wrongNodeDuration;
      }
    } else if (type == NodeType.duniterIndexer) {
      final ferry.Client client = await initDuniterIndexerClient(node);
      final ferry.OperationResponse<GLastIndexedBlockNumberData,
              GLastIndexedBlockNumberVars> response =
          await client.request(GLastIndexedBlockNumberReq()).first;
      if (response.hasErrors) {
        latency = wrongNodeDuration;
        loggerDev('HAS ERRORS');
        loggerDev(response.linkException!.originalException);
      } else {
        final Gjsonb? lastIndexedBlockNumber =
            response.data?.parameters_by_pk!.value;
        loggerDev(lastIndexedBlockNumber?.value);
        if (lastIndexedBlockNumber?.value is num) {
          currentBlock = (lastIndexedBlockNumber!.value as num).toInt();
          latency = stopwatch.elapsed;
        } else {
          latency = wrongNodeDuration;
        }
      }
    } else {
      // Test GVA with a query
      final Gva gva = Gva(node: proxyfyNode(node));
      currentBlock = await gva.getCurrentBlock().timeout(timeout);
//      NodeManager().updateNode(type, node.copyWith(latency: newLatency));
      stopwatch.stop();
      final double balance = await gva
          .balance('78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8')
          .timeout(timeout);
      latency = balance >= 0 ? stopwatch.elapsed : wrongNodeDuration;
    }
    logger(
        'Ping tested in node $node ($type), latency ${latency.inMicroseconds}, current block $currentBlock');
    return NodeCheck(latency: latency, currentBlock: currentBlock);
  } catch (e) {
    // Handle exception when node is unavailable etc
    logger('Node $node does not respond to ping $e');
    return NodeCheck(latency: wrongNodeDuration, currentBlock: 0);
  }
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
    {bool retryWith404 = true}) async {
  return _requestWithRetry(NodeType.cesiumPlus, path, true, retryWith404);
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
    Encoding? encoding}) async {
  final List<Node> nodes = NodeManager().nodesWorkingList(type);
  if (nodes.isEmpty) {
    nodes.addAll(type == NodeType.duniter
        ? defaultDuniterNodes
        : type == NodeType.cesiumPlus
            ? defaultCesiumPlusNodes
            : defaultGvaNodes);
  }
  for (final int timeout in <int>[10]) {
    // only one timeout for now
    for (int i = 0; i < nodes.length; i++) {
      final Node node = nodes[i];
      try {
        final Uri url = Uri.parse('${node.url}$path');
        logger('Fetching $url (${type.name})');
        final int startTime = DateTime.now().millisecondsSinceEpoch;
        final Response response = httpType == HttpType.get
            ? await http.get(url).timeout(Duration(seconds: timeout))
            : httpType == HttpType.post
                ? await http
                    .post(url, body: body, headers: headers, encoding: encoding)
                    .timeout(Duration(seconds: timeout))
                : await http.delete(url,
                    body: body, headers: headers, encoding: encoding);
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
            logger('${node.url} gave 404, retrying with other');
            NodeManager()
                .updateNode(type, node.copyWith(errors: node.errors + 1));
            continue;
          } else {
            if (!kReleaseMode) {
              logger('Returning not 200 or 400 response');
            }
            return Tuple2<Node, Response>(node, response);
          }
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
          increaseNodeErrors(type, node);
        }
        continue;
      }
    }
  }
  throw NoNodesException(
      'Cannot make the request to any of the ${nodes.length} nodes');
}

Future<PayResult> payWithGVA(
    {required List<String> to, required double amount, String? comment}) async {
  try {
    final Tuple2<String, Node> selected = getGvaNode();

    final String nodeUrl = selected.item1;
    try {
      final Gva gva = Gva(node: nodeUrl);
      final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
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
  final List<Node> nodes = _getBestNodes(NodeType.gva);
  if (nodes.isNotEmpty) {
    final Node? currentGvaNode = NodeManager().getCurrentGvaNode();
    final Node node = currentGvaNode ?? nodes.first;
    NodeManager().setCurrentGvaNode(node);
    return Tuple2<String, Node>(proxyfyNode(node.url), node);
  } else {
    throw Exception(
        'Sorry: I cannot find a working node to send the transaction');
  }
}

class PayResult {
  PayResult({required this.message, this.node});

  final Node? node;
  final String message;
}

String proxyfyNode(String nodeUrl) {
  final String url = inProduction && kIsWeb
      ? '${window.location.protocol}//${window.location.hostname}/proxy/${nodeUrl.replaceFirst('https://', '').replaceFirst('http://', '')}/'
      : nodeUrl;
  return url;
}

Future<Tuple2<Map<String, dynamic>?, Node>> gvaHistoryAndBalance(
    String pubKeyRaw,
    [int? pageSize,
    String? cursor]) async {
  logger('Get tx history (page size: $pageSize: cursor $cursor)');
  final String pubKey = extractPublicKey(pubKeyRaw);
  return gvaFunctionWrapper<Map<String, dynamic>>(
      (Gva gva) => gva.history(pubKey, pageSize, cursor));
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
  final List<Node> nodes = _getBestNodes(NodeType.gva);

  // Try first the current GVA node
  final Node? currentGvaNode = NodeManager().getCurrentGvaNode();
  if (currentGvaNode != null) {
    nodes.remove(currentGvaNode);
    nodes.insert(0, currentGvaNode);
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
      increaseNodeErrors(NodeType.gva, node);
      continue;
    }
  }
  throw Exception('Sorry: I cannot find a working gva node');
}

List<Node> _getBestNodes(NodeType type) {
  final List<Node> fnodes = NodeManager().nodesWorkingList(type);
  final int maxCurrentBlock = fnodes.fold(
      0,
      (int max, Node node) =>
          node.currentBlock > max ? node.currentBlock : max);
  final List<Node> nodesAtMaxBlock = fnodes
      .where((Node node) => node.currentBlock == maxCurrentBlock)
      .toList();
  nodesAtMaxBlock.sort((Node a, Node b) {
    final int errorComparison = a.errors.compareTo(b.errors);
    if (errorComparison != 0) {
      return errorComparison;
    } else {
      return a.latency.compareTo(b.latency);
    }
  });
  if (nodesAtMaxBlock.isEmpty) {
    nodesAtMaxBlock.addAll(defaultNodes(type));
  }
  return nodesAtMaxBlock;
}

class NodeCheck {
  NodeCheck({required this.latency, required this.currentBlock});

  final Duration latency;
  final int currentBlock;
}

void increaseNodeErrors(NodeType type, Node node) {
  NodeManager().increaseNodeErrors(type, node);
}

// http://doc.e-is.pro/cesium-plus-pod/REST_API.html#userprofile
// https://git.p2p.legal/axiom-team/jaklis/src/branch/master/lib/cesiumCommon.py
// Get an profile, by public key: user/profile/<pubkey>
// Add a new profile: user/profile (POST)
// Update an existing profile: user/profile/_update (POST)
// Delete an existing profile: user/profile/_delete (DELETE?)
Future<void> createOrUpdateCesiumPlusUser(String name) async {
  final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
  final String pubKey = wallet.pubkey;

  // Check if the user exists
  final String? userName = await getCesiumPlusUser(pubKey);

  // Prepare the user profile data
  final Map<String, dynamic> userProfile = <String, dynamic>{
    'version': 2,
    'issuer': pubKey,
    'title': name + g1nkgoUserNameSuffix,
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
    } else {
      logger(
          'Failed to update user profile. Status code: ${updateResponse.statusCode}');
      logger('Response body: ${updateResponse.body}');
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
    } else {
      logger(
          'Failed to create user profile. Status code: ${createResponse.statusCode}');
    }
  }
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

Future<String?> getCesiumPlusUser(String pubKey) async {
  final Contact c = await getProfile(pubKey, onlyCPlusProfile: true);
  return c.name;
}

Future<bool> deleteCesiumPlusUser() async {
  final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
  final String pubKey = wallet.pubkey;
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
