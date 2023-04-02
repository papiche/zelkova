import 'dart:convert';
import 'dart:io';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:universal_html/html.dart' show window;

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../shared_prefs.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_helper.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

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
  final Response response = await requestCPlusWithRetry(
      '/user/profile/_search?q=title:$searchTerm OR issuer:$searchTerm',
      retryWith404: false);
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

Future<void> fetchDuniterNodes(NodeType type, {bool force = false}) async {
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
}

// https://github.com/duniter/cesium/blob/467ec68114be650cd1b306754c3142fc4020164c/www/js/config.js#L96
// https://g1.data.le-sou.org/g1/peer/_search?pretty
Future<void> fetchCesiumPlusNodes({bool force = false}) async {
  const NodeType type = NodeType.cesiumPlus;
  if (force) {
    NodeManager().updateNodes(type, defaultCesiumPlusNodes);
    logger('Fetching cesium nodes forced');
  } else {
    logger('Fetching cesium plus nodes, we have ${nodesWorking(type)}');
  }
  final List<Node> nodes = await _fetchNodes(NodeType.cesiumPlus);
  NodeManager().updateNodes(type, nodes);
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
              (peer as Map<String, dynamic>)['currency'] == 'g1')
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
                  !endpoint.contains('test') &&
                  !endpoint.contains('localhost')) {
                try {
                  final Duration latency = await _pingNode(endpoint, type);
                  logger(
                      'Evaluating node: $endpoint, latency ${latency.inMicroseconds}');
                  final Node node =
                      Node(url: endpoint, latency: latency.inMicroseconds);
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
          if (lNodes.length >= NodeManager.maxNodes) {
            logger('We have enough ${type.name} nodes for now');
            break;
          }
        }
      }
    }
    logger(
        'Fetched ${lNodes.length} ${type.name} nodes ordered by latency (first: ${lNodes.first.url})');
  } catch (e, stacktrace) {
    logger('General error in fetch ${type.name} nodes: $e');
    logger(stacktrace);
    // rethrow;
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  logger('First node in list ${lNodes.first.url}');
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
        final Duration latency = await _pingNode(endpoint, type);
        logger('Evaluating node: $endpoint, latency ${latency.inMicroseconds}');
        final Node node = Node(url: endpoint, latency: latency.inMicroseconds);
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
    logger('General error in fetch ${type.name}: $e');
    logger(stacktrace);
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  logger('First node in list ${lNodes.first.url}');
  return lNodes;
}

Future<Duration> _pingNode(String node, NodeType type) async {
  const Duration timeout = Duration(seconds: 10);
  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    if (type == NodeType.duniter || type == NodeType.cesiumPlus) {
      await http
          .get(Uri.parse(type == NodeType.duniter
              ? '$node/network/peers/self/ping'
              : type == NodeType.cesiumPlus
                  ?
                  // see: http://g1.data.e-is.pro/network/peering
                  '$node/network/peering'
                  // gva, test for playground
                  : '$node/playground'))
          // Decrease http timeout during ping
          .timeout(timeout);
    } else {
      // Test GVA with a query
      final Gva gva = Gva(node: proxyfyNode(node));
      await gva.balance('').timeout(timeout);
    }
    stopwatch.stop();
    return stopwatch.elapsed;
  } catch (e) {
    // Handle exception when node is unavailable etc
    logger('Node $node does not respond to ping $e');
    return const Duration(days: 2);
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
  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];
    try {
      final Uri url = Uri.parse('${node.url}$path');
      logger('Fetching $url (${type.name})');
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      final Response response =
          await http.get(url).timeout(const Duration(seconds: 10));
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
        logger('${response.statusCode} error on $url');
        NodeManager().updateNode(type, node.copyWith(errors: node.errors + 1));
      }
    } catch (e) {
      logger('Error trying ${node.url} $e');
      if (!dontRecord) {
        logger('Increasing node errors of ${node.url} (${node.errors})');
        NodeManager().updateNode(type, node.copyWith(errors: node.errors + 1));
      }
      continue;
    }
  }
  throw Exception(
      'Cannot make the request to any of the ${nodes.length} nodes');
}

Future<String> pay(
    {required String to, required double amount, String? comment}) async {
  final String output = getGvaNode();
  if (Uri.tryParse(output) != null) {
    final String node = output;
    try {
      final Gva gva = Gva(node: node);
      final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
      logger(
          'Trying $node to send $amount to $to with comment ${comment ?? ''}');

      final String response = await gva.pay(
          recipient: to,
          amount: amount,
          comment: comment ?? '',
          cesiumSeed: wallet.seed,
          raiseException: true);
      logger('GVA replied with "$response"');
      return response;
    } on GraphQLException catch (e) {
      final List<String> eCause = e.cause.split('message: ');
      return eCause.isNotEmpty
          ? eCause[eCause.length > 1 ? 1 : 0].split(',')[0]
          : 'Transaction failed for unknown reason';
    } catch (e, stacktrace) {
      logger(e);
      logger(stacktrace);
      return "Something didn't work as expected ($e)";
    }
  }
  return output;
}

String getGvaNode() {
  final List<Node> nodes = nodesWorkingList(NodeType.gva);
  if (nodes.isNotEmpty) {
    // reorder list to use others
    nodes.shuffle();
    // Reference of working proxy 'https://g1demo.comunes.net/proxy/g1v1.p2p.legal/gva/';
    return proxyfyNode(nodes.first.url);
  } else {
    // FIXME
    return 'Sorry: I cannot find a working node to send the transaction';
  }
}

String proxyfyNode(String nodeUrl) {
  final String url = inProduction()
      ? '${window.location.protocol}//${window.location.hostname}/proxy/${nodeUrl.replaceFirst('https://', '').replaceFirst('http://', '')}/'
      : nodeUrl;
  return url;
}

Future<Map<String, dynamic>?> gvaHistoryAndBalance(String pubKey) async {
  return gvaFunctionWrapper<Map<String, dynamic>>(
      pubKey, (Gva gva) => gva.history(pubKey));
}

Future<double?> gvaBalance(String pubKey) async {
  return gvaFunctionWrapper<double>(pubKey, (Gva gva) => gva.balance(pubKey));
}

Future<String?> gvaNick(String pubKey) async {
  return gvaFunctionWrapper<String>(
      pubKey, (Gva gva) => gva.getUsername(pubKey));
}

Future<T?> gvaFunctionWrapper<T>(
    String pubKey, Future<T?> Function(Gva) specificFunction) async {
  final List<Node> nodes = NodeManager()
      .nodeList(NodeType.gva)
      .where((Node node) => node.errors <= NodeManager.maxNodeErrors)
      .toList();
  if (nodes.isEmpty) {
    nodes.addAll(defaultGvaNodes);
  }
  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];

    try {
      final String output = getGvaNode();
      if (Uri.tryParse(output) != null) {
        final String node = output;
        final Gva gva = Gva(node: node);
        final T? result = await specificFunction(gva);
        return result;
      }
    } catch (e) {
      logger('Error trying ${node.url} $e');
      logger('Increasing node errors of ${node.url} (${node.errors})');
      NodeManager()
          .updateNode(NodeType.gva, node.copyWith(errors: node.errors + 1));
      continue;
    }
  }
  throw Exception(
      'Sorry: I cannot find a working node to get your transactions');
}
