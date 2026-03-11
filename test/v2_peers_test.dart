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

    test('should normalize URLs ending with / by removing it before adding /ws',
        () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node-with-slash.example.com/',
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
      // Should be wss://node-with-slash.example.com/ws, NOT //ws
      expect(peers.endpoint.first, 'wss://node-with-slash.example.com/ws');
      expect(peers.endpoint.first, isNot(contains('//ws')));
    });

    test('should not duplicate /ws if already present', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node-already-ws.example.com/ws',
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
      expect(peers.endpoint.first, 'wss://node-already-ws.example.com/ws');
      // Should not have /ws/ws
      expect(peers.endpoint.first, isNot(contains('/ws/ws')));
    });

    test('should handle multiple URL formats correctly', () async {
      final Map<String, dynamic> mockResponse = <String, dynamic>{
        'jsonrpc': '2.0',
        'id': 1,
        'result': <String, dynamic>{
          'peerings': <dynamic>[
            <String, dynamic>{
              'endpoints': <dynamic>[
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node1.com',
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node2.com/',
                },
                <String, dynamic>{
                  'protocol': 'rpc',
                  'address': 'wss://node3.com/ws',
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

      expect(peers.endpoint.length, 3);
      // All should end with /ws correctly
      expect(peers.endpoint, contains('wss://node1.com/ws'));
      expect(peers.endpoint, contains('wss://node2.com/ws'));
      expect(peers.endpoint, contains('wss://node3.com/ws'));

      // None should have double slash before ws (//ws) or double /ws/ws
      for (final String endpoint in peers.endpoint) {
        expect(endpoint, isNot(contains('/ws/ws')));
        expect(endpoint, isNot(contains('//ws')));
      }
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

  group('Recursive peer discovery', () {
    test('should discover peers recursively up to max depth', () async {
      int callCount = 0;

      final http.Client mockClient = MockClient((http.Request request) async {
        callCount++;

        // First node returns two peers (without /ws as real API does)
        if (request.url.host == 'node1.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://node2.example.com',
                        },
                      ],
                    },
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://node3.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        // Second node returns one more peer
        if (request.url.host == 'node2.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://node4.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        // Other nodes return empty
        return http.Response(
            jsonEncode(<String, dynamic>{
              'jsonrpc': '2.0',
              'id': 1,
              'result': <String, dynamic>{
                'peerings': <dynamic>[],
              },
            }),
            200);
      });

      final V2Peers peers = await discoverV2PeersRecursive(
        <String>{'wss://node1.example.com/ws'},
        client: mockClient,
        maxDepth: 2,
      );

      // Should discover nodes up to depth 2
      expect(peers.endpoint.length, greaterThanOrEqualTo(3));
      expect(callCount, greaterThan(1));
    });

    test('should stop at max depth limit', () async {
      int callCount = 0;

      final http.Client mockClient = MockClient((http.Request request) async {
        callCount++;

        // Each node returns a new peer (infinite chain, without /ws)
        return http.Response(
            jsonEncode(<String, dynamic>{
              'jsonrpc': '2.0',
              'id': 1,
              'result': <String, dynamic>{
                'peerings': <dynamic>[
                  <String, dynamic>{
                    'endpoints': <dynamic>[
                      <String, dynamic>{
                        'protocol': 'rpc',
                        'address': 'wss://node$callCount.example.com',
                      },
                    ],
                  },
                ],
              },
            }),
            200);
      });

      await discoverV2PeersRecursive(
        <String>{'wss://start.example.com/ws'},
        client: mockClient,
      );

      // Should stop after maxDepth levels
      expect(callCount, lessThanOrEqualTo(10)); // reasonable limit
    });

    test('should not revisit already discovered nodes', () async {
      final Set<String> visitedHosts = <String>{};

      final http.Client mockClient = MockClient((http.Request request) async {
        visitedHosts.add(request.url.host);

        // Create a circular reference (without /ws)
        return http.Response(
            jsonEncode(<String, dynamic>{
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
                        'protocol': 'rpc',
                        'address': 'wss://node2.example.com',
                      },
                    ],
                  },
                ],
              },
            }),
            200);
      });

      await discoverV2PeersRecursive(
        <String>{'wss://node1.example.com/ws'},
        client: mockClient,
      );

      // Should visit each unique host only once
      expect(visitedHosts.length, lessThanOrEqualTo(3));
    });

    test('should handle empty initial peer list', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        return http.Response('{}', 200);
      });

      final V2Peers peers = await discoverV2PeersRecursive(
        <String>{},
        client: mockClient,
        maxDepth: 2,
      );

      expect(peers.endpoint, isEmpty);
      expect(peers.indexer, isEmpty);
    });

    test('should aggregate indexers from all discovered peers', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        if (request.url.host == 'node1.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'squid',
                          'address': 'https://indexer1.example.com',
                        },
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://node2.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        if (request.url.host == 'node2.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'squid',
                          'address': 'https://indexer2.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        return http.Response('{}', 200);
      });

      final V2Peers peers = await discoverV2PeersRecursive(
        <String>{'wss://node1.example.com/ws'},
        client: mockClient,
        maxDepth: 2,
      );

      expect(peers.indexer.length, 2);
      expect(peers.indexer, contains('https://indexer1.example.com'));
      expect(peers.indexer, contains('https://indexer2.example.com'));
    });

    test('should handle failed peer discoveries gracefully', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        if (request.url.host == 'node1.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://good-node.example.com',
                        },
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://bad-node.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        if (request.url.host == 'bad-node.example.com') {
          return http.Response('Internal Server Error', 500);
        }

        if (request.url.host == 'good-node.example.com') {
          return http.Response(
              jsonEncode(<String, dynamic>{
                'jsonrpc': '2.0',
                'id': 1,
                'result': <String, dynamic>{
                  'peerings': <dynamic>[
                    <String, dynamic>{
                      'endpoints': <dynamic>[
                        <String, dynamic>{
                          'protocol': 'rpc',
                          'address': 'wss://final-node.example.com',
                        },
                      ],
                    },
                  ],
                },
              }),
              200);
        }

        return http.Response(
            jsonEncode(<String, dynamic>{
              'jsonrpc': '2.0',
              'id': 1,
              'result': <String, dynamic>{
                'peerings': <dynamic>[],
              },
            }),
            200);
      });

      final V2Peers peers = await discoverV2PeersRecursive(
        <String>{'wss://node1.example.com/ws'},
        client: mockClient,
      );

      // Should discover nodes despite some failures
      expect(peers.endpoint.length, greaterThanOrEqualTo(2));
      expect(peers.endpoint, contains('wss://good-node.example.com/ws'));
    });

    test('should respect timeout for recursive discovery', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        await Future<void>.delayed(const Duration(seconds: 2));
        return http.Response('{}', 200);
      });

      final Stopwatch stopwatch = Stopwatch()..start();

      await discoverV2PeersRecursive(
        <String>{'wss://slow-node.example.com/ws'},
        client: mockClient,
        maxDepth: 2,
        timeout: const Duration(milliseconds: 100),
      );

      stopwatch.stop();

      // Should timeout quickly, not wait for all nodes
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
    });

    test('should deduplicate peers across multiple levels', () async {
      final http.Client mockClient = MockClient((http.Request request) async {
        // All nodes return the same peers (without /ws)
        return http.Response(
            jsonEncode(<String, dynamic>{
              'jsonrpc': '2.0',
              'id': 1,
              'result': <String, dynamic>{
                'peerings': <dynamic>[
                  <String, dynamic>{
                    'endpoints': <dynamic>[
                      <String, dynamic>{
                        'protocol': 'rpc',
                        'address': 'wss://common1.example.com',
                      },
                      <String, dynamic>{
                        'protocol': 'rpc',
                        'address': 'wss://common2.example.com',
                      },
                    ],
                  },
                ],
              },
            }),
            200);
      });

      final V2Peers peers = await discoverV2PeersRecursive(
        <String>{
          'wss://start1.example.com/ws',
          'wss://start2.example.com/ws',
        },
        client: mockClient,
        maxDepth: 2,
      );

      // Should have unique peers only
      expect(peers.endpoint.length, equals(peers.endpoint.toSet().length));
    });
  });
}

// Helper function for recursive peer discovery
Future<V2Peers> discoverV2PeersRecursive(
  Set<String> initialNodes, {
  required http.Client client,
  int maxDepth = 3,
  Duration timeout = const Duration(seconds: 10),
}) async {
  final Set<String> allEndpoints = <String>{};
  final Set<String> allIndexers = <String>{};
  final Set<String> visited = <String>{};

  Future<void> discoverFromNode(String node, int depth) async {
    if (depth > maxDepth || visited.contains(node)) {
      return;
    }

    visited.add(node);

    try {
      final V2Peers peers = await discoverV2PeersFromNode(
        node,
        client: client,
        timeout: timeout,
      );

      allEndpoints.addAll(peers.endpoint);
      allIndexers.addAll(peers.indexer);

      // Recursively discover from new peers
      for (final String endpoint in peers.endpoint) {
        if (!visited.contains(endpoint)) {
          await discoverFromNode(endpoint, depth + 1);
        }
      }
    } catch (e) {
      // Continue with other nodes if one fails
    }
  }

  // Start discovery from initial nodes
  for (final String node in initialNodes) {
    await discoverFromNode(node, 0);
  }

  return V2Peers(rpc: allEndpoints, squid: allIndexers);
}
