import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ui/logger.dart';

class V2Peers {
  V2Peers({Set<String>? rpc, Set<String>? squid})
      : endpoint = rpc ?? <String>{},
        indexer = squid ?? <String>{};
  final Set<String> endpoint;
  final Set<String> indexer;
}

Future<V2Peers> discoverV2PeersFromNode(String nodeBaseUrl2,
    {Duration timeout = const Duration(seconds: 10)}) async {
  final Uri originalUri = Uri.parse(nodeBaseUrl2);
  final String httpsBaseUrl = 'https://${originalUri.host}';
  final Uri uri = Uri.parse(httpsBaseUrl);
  final Map<String, dynamic> payload = <String, dynamic>{
    'jsonrpc': '2.0',
    'method': 'duniter_peerings',
    'params': <dynamic>[],
    'id': 1,
  };

  try {
    final http.Response resp = await http
        .post(
          uri,
          headers: const <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(payload),
        )
        .timeout(timeout);

    if (resp.statusCode != 200) {
      loggerDev(
          'discoverV2PeersFromNode: non-200 from $httpsBaseUrl -> ${resp.statusCode}');
      return V2Peers();
    }

    final dynamic data = jsonDecode(resp.body);
    final dynamic result = (data is Map) ? data['result'] : null;
    final List<dynamic> peerings = (result is Map && result['peerings'] is List)
        ? result['peerings'] as List<dynamic>
        : const <dynamic>[];

    final Set<String> endpoints = <String>{};
    final Set<String> indexers = <String>{};

    for (final dynamic p in peerings) {
      if (p is! Map<String, dynamic>) {
        continue;
      }
      final List<dynamic> peerEndpoints = (p['endpoints'] is List)
          ? p['endpoints'] as List<dynamic>
          : const <dynamic>[];
      for (final dynamic ep in peerEndpoints) {
        if (ep is! Map<String, dynamic>) {
          continue;
        }
        final String? protocol =
            (ep['protocol'] is String) ? ep['protocol'] as String : null;
        final String? address =
            (ep['address'] is String) ? ep['address'] as String : null;
        if (address == null || address.isEmpty) {
          continue;
        }

        if (protocol == 'rpc') {
          endpoints.add(address.endsWith('/ws')
              ? address
              : (address.endsWith('/') ? '${address}ws' : '$address/ws'));
        } else if (protocol == 'squid') {
          indexers.add(address);
        }
      }
    }

    loggerDev(
        'discoverV2PeersFromNode: endpoints ${endpoints.length}, indexers ${indexers.length} from $httpsBaseUrl');
    return V2Peers(rpc: endpoints, squid: indexers);
  } catch (e) {
    loggerDev('discoverV2PeersFromNode: error calling $httpsBaseUrl -> $e');
    return V2Peers();
  }
}
