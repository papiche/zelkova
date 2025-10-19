import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/v2_peers.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('V2Peers', () {
    test('should create instance with empty sets by default', () {
      final V2Peers peers = V2Peers();

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should create instance with provided sets', () {
      final Set<String> rpcSet = <String>{
        'wss://node1.com/ws',
        'wss://node2.com/ws'
      };
      final Set<String> squidSet = <String>{
        'https://indexer1.com',
        'https://indexer2.com'
      };

      final V2Peers peers = V2Peers(rpc: rpcSet, squid: squidSet);

      expect(peers.endpoint, equals(rpcSet));
      expect(peers.indexer, equals(squidSet));
    });
  });

  group('discoverV2PeersFromNode', () {
    test('should parse valid response with rpc and squid endpoints', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node1.example.com',
                },
                <String, dynamic>{
                  'protocol': 'squid',
                  'address': 'https://indexer1.example.com',
                },
              ],
            },
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node2.example.com',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        expect(request.url.toString(), 'https://test.example.com');
        expect(request.headers['Content-Type'], contains('application/json'));

        final Map<String, dynamic> body =
            jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['method'], 'duniter_peerings');
        expect(body['jsonrpc'], '2.0');

        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 2);
      expect(peers.endpoint, contains('wss://node1.example.com/ws'));
      expect(peers.endpoint, contains('wss://node2.example.com/ws'));
      expect(peers.indexer.length, 1);
      expect(peers.indexer, contains('https://indexer1.example.com'));
    });

    test('should append /ws to rpc addresses without it', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node.example.com',
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node2.example.com/',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, contains('wss://node.example.com/ws'));
      expect(peers.endpoint, contains('wss://node2.example.com/ws'));
    });

    test('should not append /ws if already present', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, contains('wss://node.example.com/ws'));
      expect(peers.endpoint, isNot(contains('wss://node.example.com/ws/ws')));
    });

    test('should handle empty peerings list', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should handle missing result field', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should handle non-200 status code', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response('Internal Server Error', 500);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should handle network timeout', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        await Future<void>.delayed(const Duration(seconds: 2));
        return http.Response('{}', 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
        timeout: const Duration(milliseconds: 100),
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should handle malformed JSON response', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response('not valid json{]', 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should skip endpoints with null or empty addresses', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': null,
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': '',
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://valid.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 1);
      expect(peers.endpoint, contains('wss://valid.example.com/ws'));
    });

    test('should skip endpoints with invalid protocol', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'unknown',
                  'address': 'wss://node.example.com/ws',
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://valid.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 1);
      expect(peers.endpoint, contains('wss://valid.example.com/ws'));
    });

    test('should handle multiple peers with mixed protocols', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node1.example.com/ws',
                },
              ],
            },
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'squid',
                  'address': 'https://indexer1.example.com',
                },
              ],
            },
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node2.example.com',
                },
                <String, dynamic>{
                  'protocol': 'squid',
                  'address': 'https://indexer2.example.com',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 2);
      expect(peers.endpoint, contains('wss://node1.example.com/ws'));
      expect(peers.endpoint, contains('wss://node2.example.com/ws'));
      expect(peers.indexer.length, 2);
      expect(peers.indexer, contains('https://indexer1.example.com'));
      expect(peers.indexer, contains('https://indexer2.example.com'));
    });

    test('should use https scheme from original URL', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        expect(request.url.scheme, 'https');
        expect(request.url.host, 'example.com');
        expect(request.url.path, '');
        return http.Response(jsonEncode(mockResponse), 200);
      });

      await discoverV2PeersFromNode(
        'wss://example.com/ws',
        client: mockClient,
      );
    });

    test('should deduplicate endpoints using Set', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node.example.com/ws',
                },
              ],
            },
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 1);
      expect(peers.endpoint, contains('wss://node.example.com/ws'));
    });

    test('should handle non-map endpoint entries', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                'invalid string endpoint',
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://valid.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 1);
      expect(peers.endpoint, contains('wss://valid.example.com/ws'));
    });

    test('should handle non-map peering entries', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            'invalid peering',
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://valid.example.com/ws',
                },
              ],
            },
          ],
        },
      };

      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response(jsonEncode(mockResponse), 200);
      });

      final V2Peers peers = await discoverV2PeersFromNode(
        'https://test.example.com',
        client: mockClient,
      );

      expect(peers.endpoint.length, 1);
      expect(peers.endpoint, contains('wss://valid.example.com/ws'));
    });
  });
}
