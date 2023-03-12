import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../main.dart';
import 'g1_helper.dart';
import 'node.dart';
import 'node_list_cubit.dart';

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
  final Response response =
      await requestWithRetry(nodeListCubit, '/wot/lookup/$searchTerm');
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

Future<String> getDataImageFromKey(
    NodeListCubit nodeListCubit, String publicKey) async {
  // FIXME (vjrj) use node manager and retry...
  final String url = 'https://g1.data.le-sou.org/user/profile/$publicKey';
  final Response response = await http.get(Uri.parse(url));
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

Future<Uint8List> getAvatar(NodeListCubit nodeListCubit, String pubKey) async {
  final String dataImage = await getDataImageFromKey(nodeListCubit, pubKey);
  return imageFromBase64String(dataImage);
}

Future<void> fetchDuniterNodes(NodeListCubit cubit) async {
  final List<Node> nodes = await fetchNodesFromApi(cubit);
  cubit.setDuniterNodes(nodes);
}

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
                final Duration latency = await _pingNode(endpoint);
                if (fastestNode == null || latency < fastestLatency) {
                  fastestNode = endpoint;
                  fastestLatency = latency;
                  if (!kReleaseMode) {
                    logger('Node bloc: Current faster node $fastestNode');
                  }
                }
                final Node node =
                    Node(url: endpoint, latency: latency.inMicroseconds);
                cubit.insertDuniterNode(node);
                lNodes.insert(0, node);
              }
            }
          }
        }
      }
    }
    logger('Node bloc: Loaded ${lNodes.length} duniter nodes');
  } catch (e) {
    logger('Error: $e');
    rethrow;
  }
  lNodes.sort((Node a, Node b) => a.latency.compareTo(b.latency));
  logger('First node in list ${lNodes.first.url}');
  return lNodes;
}

Future<Duration> _pingNode(String node) async {
  try {
    final Stopwatch stopwatch = Stopwatch()..start();
    await http.get(Uri.parse('$node/network/peers/self/ping'));
    stopwatch.stop();
    return stopwatch.elapsed;
  } catch (e) {
    // Handle exception when node is unavailable etc
    logger('Node $node does not respond to ping $e');
    return const Duration(days: 2);
  }
}

Future<http.Response> requestWithRetry(NodeListCubit cubit, String path,
    {bool dontRecord = false}) async {
  return _requestWithRetry(cubit, cubit.duniterNodes, path, dontRecord);
}

Future<http.Response> requestCPlusWithRetry(
    NodeListCubit cubit, String path) async {
  return _requestWithRetry(cubit, cubit.cesiumPlusNodes, path, true);
}

Future<http.Response> _requestWithRetry(
    NodeListCubit cubit, List<Node> nodes, String path, bool dontRecord) async {
  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];
    if (node.errors >= 3) {
      // Too much errors skip
      continue;
    }
    final Uri url = Uri.parse('${node.url}$path');
    logger('Trying $url');
    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      final Response response = await http.get(url);
      final int endTime = DateTime.now().millisecondsSinceEpoch;
      final int newLatency = endTime - startTime;
      if (response.statusCode == 200) {
        if (!dontRecord) {
          cubit.updateDuniterNode(node.copyWith(latency: newLatency));
        }
        return response;
      }
    } catch (e) {
      if (!dontRecord) {
        cubit.updateDuniterNode(node.copyWith(errors: node.errors + 1));
      }
      continue;
    }
  }
  throw Exception(
      'Cannot make the request to any of the ${nodes.length} nodes');
}
