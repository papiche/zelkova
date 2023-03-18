import 'dart:convert';
// import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_list_cubit.dart';
import '../data/models/node_list_state.dart';
import '../main.dart';
import 'g1_helper.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

Future<String> getTxHistory(
    NodeListCubit nodeListCubit, String publicKey) async {
  final Response response =
      await requestWithRetry(nodeListCubit, '/tx/history/$publicKey');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load tx history');
  }
}

Future<Response> getPeers(NodeListCubit nodeListCubit) async {
  final Response response =
      await requestWithRetry(nodeListCubit, '/network/peers', dontRecord: true);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load duniter node peers');
  }
}

Future<Response> searchUser(
    NodeListCubit nodeListCubit, String searchTerm) async {
  final Response response = await requestCPlusWithRetry(nodeListCubit,
      '/user/profile/_search?q=title:*$searchTerm* OR _id:$searchTerm* OR _id:$searchTerm',
      retryWith404: false);
  return response;
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
Future<Contact> getWot(NodeListCubit nodeListCubit, Contact contact) async {
  final Response response = await requestCPlusWithRetry(
      nodeListCubit, '/wot/lookup/${contact.pubkey}');
  if (response.statusCode == HttpStatus.ok) {
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> results =
        data['results'] as Map<String, dynamic>;
    final List<dynamic> uids = results['uids'] as List<dynamic>;
    if (uids.isNotEmpty) {
      return contact.copyWith(nick: uids[0]!['uid'] as String);
    }
  }
  return contact;
}

@Deprecated('use getProfile')
Future<String> _getDataImageFromKey(
    NodeListCubit nodeListCubit, String publicKey) async {
  final Response response =
      await requestCPlusWithRetry(nodeListCubit, '/user/profile/$publicKey');
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

Future<Uint8List> _getAvata2r(
    NodeListCubit nodeListCubit, String pubKey) async {
  final String dataImage = await _getDataImageFromKey(nodeListCubit, pubKey);
  return imageFromBase64String(dataImage);
}

Future<void> fetchDuniterNodes(NodeListState state, NodeListCubit cubit,
    {bool force = false}) async {
  const int minutesToWait = 45;
  if (force ||
      /* DateTime.now()
              .difference(state.lastFetchNodesTime)
              .compareTo(const Duration(minutes: minutesToWait)) >
          0 || */
      duniterNodesWorking(state) < NodeListCubit.maxNodes) {
    if (force) {
      cubit.setDuniterNodes(defaultDuniterNodes);
      logger('Fetching nodes forced');
    } else {
      logger(
          'Fetching nodes as we did it more than ${minutesToWait}min ago: ${state.lastFetchNodesTime.toIso8601String()} and we have only ${duniterNodesWorking(state)}');
    }
    final List<Node> nodes = await fetchNodesFromApi(cubit);
    cubit.setDuniterNodes(nodes);
  } else {
    logger(
        'Skipping to fetch nodes as we already did it less than ${minutesToWait}min ago and we have ${duniterNodesWorking(state)}');
    if (!kReleaseMode) {
      // developer.log(StackTrace.current.toString());
    }
  }
}

int duniterNodesWorking(NodeListState state) => state.duniterNodes
    .where((n) => n.errors < NodeListCubit.maxNodeErrors)
    .toList()
    .length;

Future<List<Node>> fetchNodesFromApi(NodeListCubit cubit) async {
  final List<Node> lNodes = <Node>[];
  // To compare with something...
  String fastestNode = 'https://g1.duniter.org';
  late Duration fastestLatency = const Duration(minutes: 1);
  try {
    final Response response = await getPeers(cubit);
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
            if (endpoints[j].startsWith('BMAS')) {
              final String endpointUnParsed = endpoints[j];
              final String? endpoint = parseHost(endpointUnParsed);
              if (endpoint != null) {
                try {
                  final Duration latency = await _pingNode(endpoint);
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
                    cubit.insertDuniterNode(node);
                    lNodes.insert(0, node);
                  } else {
                    // Not the faster
                    cubit.addDuniterNode(node);
                    lNodes.add(node);
                  }
                } catch (e) {
                  logger('Error fetching $endpoint, error: $e');
                }
              }
            }
          }
          if (lNodes.length >= NodeListCubit.maxNodes) {
            logger('We have enought nodes for now');
            break;
          }
        }
      }
    }
    logger(
        'Fetched ${lNodes.length} duniter nodes ordered by latency (first: ${lNodes.first.url})');
  } catch (e) {
    logger('General error in fetch nodes: $e');
    // rethrow;
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  logger('First node in list ${lNodes.first.url}');
  return lNodes;
}

Future<Duration> _pingNode(String node) async {
  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    await http
        .get(Uri.parse('$node/network/peers/self/ping'))
        // Decrease http timeout during ping
        .timeout(const Duration(seconds: 10));
    stopwatch.stop();
    return stopwatch.elapsed;
  } catch (e) {
    // Handle exception when node is unavailable etc
    logger('Node $node does not respond to ping $e');
    return const Duration(days: 2);
  }
}

Future<http.Response> requestWithRetry(NodeListCubit cubit, String path,
    {bool dontRecord = false, bool retryWith404 = true}) async {
  return _requestWithRetry(
      cubit, cubit.duniterNodes, path, dontRecord, retryWith404);
}

Future<http.Response> requestCPlusWithRetry(NodeListCubit cubit, String path,
    {bool retryWith404 = true}) async {
  return _requestWithRetry(
      cubit, cubit.cesiumPlusNodes, path, true, retryWith404);
}

Future<http.Response> _requestWithRetry(NodeListCubit cubit, List<Node> nodes,
    String path, bool dontRecord, bool retryWith404) async {
  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];
    if (node.errors >= NodeListCubit.maxNodeErrors) {
      // Too much errors skip
      continue;
    }
    try {
      final Uri url = Uri.parse('${node.url}$path');
      logger('Fetching $url');
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      final Response response =
          await http.get(url).timeout(const Duration(seconds: 10));
      final int endTime = DateTime.now().millisecondsSinceEpoch;
      final int newLatency = endTime - startTime;
      if (response.statusCode == 200) {
        if (!dontRecord) {
          cubit.updateDuniterNode(node.copyWith(latency: newLatency));
        }
        return response;
      } else if (response.statusCode == 404) {
        logger('404 on fetch $url');
        if (retryWith404) {
          // Retry with other nodes
          cubit.updateDuniterNode(node.copyWith(errors: node.errors + 1));
          continue;
        } else {
          return response;
        }
      } else {
        logger('${response.statusCode} error on $url');
        cubit.updateDuniterNode(node.copyWith(errors: node.errors + 1));
      }
    } catch (e) {
      logger('Error trying ${node.url} $e');
      if (!dontRecord) {
        logger('Increasing node errors of ${node.url} (${node.errors})');
        cubit.updateDuniterNode(node.copyWith(errors: node.errors + 1));
      }
      continue;
    }
  }
  throw Exception(
      'Cannot make the request to any of the ${nodes.length} nodes');
}
