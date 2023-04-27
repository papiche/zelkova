import 'dart:convert';
import 'dart:io';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_html/html.dart' show window;

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../shared_prefs.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_helper.dart';
import 'no_nodes_exception.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

// use g1-test or g1 for production (fallback to g1)
final String currencyDotEnv = "${dotenv.env['CURRENCY']}";
final String currency = currencyDotEnv.isEmpty ? 'g1' : currencyDotEnv;

Future<String> getTxHistory(String publicKey) async {
  final Response response =
      await requestWithRetry(NodeType.duniter, '/tx/history/$publicKey');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load tx history');
  }
}

Future<Response> getPeers() async {
  final Response response = await requestWithRetry(
      NodeType.duniter, '/network/peers',
      dontRecord: true);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load duniter node peers');
  }
}

Future<Response> searchCPlusUser(String searchTerm) async {
  final String searchTermLower = searchTerm.toLowerCase();
  final String searchTermCapitalized =
      searchTermLower[0].toUpperCase() + searchTermLower.substring(1);

  final String query =
      '/user/profile/_search?q=title:$searchTermLower OR issuer:$searchTerm OR title:$searchTermCapitalized OR title:$searchTerm';

  final Response response =
      await requestCPlusWithRetry(query, retryWith404: false);
  return response;
}

Future<Contact> getProfile(String pubKey,
    [bool onlyCPlusProfile = false]) async {
  try {
    final Response cPlusResponse = await requestCPlusWithRetry(
        '/user/profile/$pubKey',
        retryWith404: false);
    final Map<String, dynamic> result =
        const JsonDecoder().convert(cPlusResponse.body) as Map<String, dynamic>;
    if (result['found'] == false) {
      return Contact(pubKey: pubKey);
    }
    final Map<String, dynamic> profile =
        const JsonDecoder().convert(cPlusResponse.body) as Map<String, dynamic>;
    final Contact c = contactFromResultSearch(profile);
    if (!onlyCPlusProfile) {
      // This penalize the gva rate limit
      // final String? nick = await gvaNick(pubKey);
      final List<Contact> wotList = await searchWot(pubKey);
      if (wotList.isNotEmpty) {
        final Contact c = wotList[0];
        c.copyWith(nick: c.nick);
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
Future<List<Contact>> searchWot(String searchTerm) async {
  final Response response = await requestDuniterWithRetry(
      '/wot/lookup/$searchTerm',
      retryWith404: false);
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

Future<Contact> getWot(Contact contact) async {
  final Response response = await requestDuniterWithRetry(
      '/wot/lookup/${contact.pubKey}',
      retryWith404: false);
  // Will be better to analyze the 404 response (to detect faulty node)
  if (response.statusCode == HttpStatus.ok) {
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> results = data['results'] as List<dynamic>;
    if (results.isNotEmpty) {
      final List<dynamic> uids =
          (results[0] as Map<String, dynamic>)['uids'] as List<dynamic>;
      if (uids.isNotEmpty) {
        // ignore: avoid_dynamic_calls
        return contact.copyWith(nick: uids[0]!['uid'] as String);
      }
    }
  }
  return contact;
}

@Deprecated('use getProfile')
Future<String> _getDataImageFromKey(String publicKey) async {
  final Response response =
      await requestCPlusWithRetry('/user/profile/$publicKey');
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

Future<void> fetchNodes(NodeType type, bool force) async {
  try {
    if (type == NodeType.duniter) {
      _fetchDuniterNodes(force: force);
    } else {
      if (type == NodeType.cesiumPlus) {
        _fetchCesiumPlusNodes(force: force);
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
  if (force || nodesWorking(type) < NodeManager.maxNodes) {
    if (force) {
      NodeManager().updateNodes(type, defaultDuniterNodes);
      logger('Fetching nodes forced');
    } else {
      logger('Fetching ${type.name} nodes, we have ${nodesWorking(type)}');
    }
    final List<Node> nodes = await _fetchDuniterNodesFromPeers(type);
    NodeManager().updateNodes(type, nodes);
  } else {
    logger('Skipping to fetch nodes as we have ${nodesWorking(type)}');
    if (!kReleaseMode) {
      // developer.log(StackTrace.current.toString());
    }
  }
  NodeManager().loading = false;
}

// https://github.com/duniter/cesium/blob/467ec68114be650cd1b306754c3142fc4020164c/www/js/config.js#L96
// https://g1.data.le-sou.org/g1/peer/_search?pretty
Future<void> _fetchCesiumPlusNodes({bool force = false}) async {
  NodeManager().loading = true;
  const NodeType type = NodeType.cesiumPlus;
  if (force) {
    NodeManager().updateNodes(type, defaultCesiumPlusNodes);
    logger('Fetching cesium nodes forced');
  } else {
    logger('Fetching cesium plus nodes, we have ${nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchNodes(NodeType.cesiumPlus);
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
    logger('Fetching gva nodes, we have ${nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchDuniterNodesFromPeers(type);
  NodeManager().updateNodes(type, nodes);
  NodeManager().loading = false;
}

int nodesWorking(NodeType type) => NodeManager()
    .nodeList(type)
    .where((Node n) => n.errors < NodeManager.maxNodeErrors)
    .toList()
    .length;

List<Node> nodesWorkingList(NodeType type) => NodeManager()
    .nodeList(type)
    .where((Node n) => n.errors < NodeManager.maxNodeErrors)
    .toList();

Future<List<Node>> _fetchDuniterNodesFromPeers(NodeType type) async {
  final List<Node> lNodes = <Node>[];
  final String apyType = (type == NodeType.duniter) ? 'BMAS' : 'GVA S';
  // To compare with something...
  String? fastestNode;
  late Duration fastestLatency = const Duration(minutes: 1);
  try {
    final Response response = await getPeers();
    if (response.statusCode == 200) {
      final Map<String, dynamic> peerList =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> peers = (peerList['peers'] as List<dynamic>)
          .where((dynamic peer) =>
              (peer as Map<String, dynamic>)['currency'] == currency)
          .where(
              (dynamic peer) => (peer as Map<String, dynamic>)['version'] == 10)
          .where((dynamic peer) =>
              (peer as Map<String, dynamic>)['status'] == 'UP')
          .toList();
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
                  logger(
                      'Evaluating node: $endpoint, latency ${latency.inMicroseconds} currentBlock: ${nodeCheck.currentBlock}');
                  final Node node = Node(
                      url: endpoint,
                      latency: latency.inMicroseconds,
                      currentBlock: nodeCheck.currentBlock);
                  if (fastestNode == null || latency < fastestLatency) {
                    fastestNode = endpoint;
                    fastestLatency = latency;
                    if (!kReleaseMode) {
                      logger('Node bloc: Current faster node $fastestNode');
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
            logger('We have enough ${type.name} nodes for now');
            break;
          }
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
      await http
          .get(Uri.parse('$node/network/peering'))
          // Decrease http timeout during ping
          .timeout(timeout);
      stopwatch.stop();
      latency = stopwatch.elapsed;
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

Future<http.Response> requestWithRetry(NodeType type, String path,
    {bool dontRecord = false, bool retryWith404 = true}) async {
  return _requestWithRetry(type, path, dontRecord, retryWith404);
}

Future<http.Response> requestDuniterWithRetry(String path,
    {bool retryWith404 = true}) async {
  return _requestWithRetry(NodeType.duniter, path, true, retryWith404);
}

Future<http.Response> requestCPlusWithRetry(String path,
    {bool retryWith404 = true}) async {
  return _requestWithRetry(NodeType.cesiumPlus, path, true, retryWith404);
}

Future<http.Response> requestGvaWithRetry(String path,
    {bool retryWith404 = true}) async {
  return _requestWithRetry(NodeType.gva, path, true, retryWith404);
}

Future<http.Response> _requestWithRetry(
    NodeType type, String path, bool dontRecord, bool retryWith404) async {
  final List<Node> nodes = NodeManager()
      .nodeList(type)
      .where((Node node) => node.errors <= NodeManager.maxNodeErrors)
      .toList();
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
        final Response response =
            await http.get(url).timeout(Duration(seconds: timeout));
        final int endTime = DateTime.now().millisecondsSinceEpoch;
        final int newLatency = endTime - startTime;
        if (!kReleaseMode) {
          logger('response.statusCode: ${response.statusCode}');
        }
        if (response.statusCode == 200) {
          if (!dontRecord) {
            NodeManager().updateNode(type, node.copyWith(latency: newLatency));
          }
          return response;
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
            return response;
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

Future<String> pay(
    {required String to,
    required double amount,
    String? comment,
    bool? useMempool}) async {
  try {
    final SelectedGvaNode selected = getGvaNode();

    final String nodeUrl = selected.url;
    try {
      final Gva gva = Gva(node: nodeUrl);
      final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
      logger(
          'Trying $nodeUrl to send $amount to $to with comment ${comment ?? ''}');

      final String response = await gva.pay(
          recipient: to,
          amount: amount,
          comment: comment ?? '',
          cesiumSeed: wallet.seed,
          useMempool: useMempool ?? false,
          raiseException: true);
      logger('GVA replied with "$response"');
      return response;
    } on GraphQLException catch (e) {
      final List<String> eCause = e.cause.split('message: ');
      return eCause.isNotEmpty
          ? eCause[eCause.length > 1 ? 1 : 0].split(',')[0]
          : 'Transaction failed for unknown reason';
    } catch (e, stacktrace) {
      await Sentry.captureException(e, stackTrace: stacktrace);
      logger(e);
      logger(stacktrace);
      return "Something didn't work as expected ($e)";
    }
  } catch (e) {
    return "Something didn't work as expected ($e)";
  }
}

SelectedGvaNode getGvaNode() {
  final List<Node> nodes = _getBestGvaNodes();
  if (nodes.isNotEmpty) {
    // reorder list to use others
    nodes.shuffle();
    // Reference of working proxy 'https://g1demo.comunes.net/proxy/g1v1.p2p.legal/gva/';
    final Node node = nodes.first;
    return SelectedGvaNode(url: proxyfyNode(node.url), node: node);
  } else {
    throw Exception(
        'Sorry: I cannot find a working node to send the transaction');
  }
}

class SelectedGvaNode {
  SelectedGvaNode({required this.url, required this.node});

  final String url;
  final Node node;
}

String proxyfyNode(String nodeUrl) {
  final String url = inProduction && kIsWeb
      ? '${window.location.protocol}//${window.location.hostname}/proxy/${nodeUrl.replaceFirst('https://', '').replaceFirst('http://', '')}/'
      : nodeUrl;
  return url;
}

Future<Tuple2<Map<String, dynamic>?, Node>> gvaHistoryAndBalance(String pubKey,
    [int? pageSize, String? cursor]) async {
  logger('Get tx history (page size: $pageSize: cursor $cursor)');
  return gvaFunctionWrapper<Map<String, dynamic>>(
      pubKey, (Gva gva) => gva.history(pubKey, pageSize, cursor));
}

Future<Tuple2<double?, Node>> gvaBalance(String pubKey) async {
  return gvaFunctionWrapper<double>(pubKey, (Gva gva) => gva.balance(pubKey));
}

Future<Tuple2<String?, Node>> gvaNick(String pubKey) async {
  return gvaFunctionWrapper<String>(
      pubKey, (Gva gva) => gva.getUsername(pubKey));
}

Future<Tuple2<T?, Node>> gvaFunctionWrapper<T>(
    String pubKey, Future<T?> Function(Gva) specificFunction) async {
  final List<Node> nodes = _getBestGvaNodes();
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

List<Node> _getBestGvaNodes() {
  final List<Node> fnodes = NodeManager()
      .nodeList(NodeType.gva)
      .where((Node node) => node.errors <= NodeManager.maxNodeErrors)
      .toList();
  final int maxCurrentBlock = fnodes.fold(
      0,
      (int max, Node node) =>
          node.currentBlock > max ? node.currentBlock : max);
  final List<Node> nodes = fnodes
      .where((Node node) => node.currentBlock == maxCurrentBlock)
      .toList();
  nodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  if (nodes.isEmpty) {
    // Fallback
    nodes.addAll(defaultGvaNodes);
  }
  // Don't shuffle for now
  // nodes.shuffle();
  return nodes;
}

class NodeCheck {
  NodeCheck({required this.latency, required this.currentBlock});

  final Duration latency;
  final int currentBlock;
}

void increaseNodeErrors(NodeType type, Node node) {
  logger('Increasing node errors of ${node.url} (${node.errors})');
  NodeManager().updateNode(type, node.copyWith(errors: node.errors + 1));
}
