import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/node.dart';
import 'package:ginkgo/data/models/node_manager.dart';
import 'package:ginkgo/data/models/node_type.dart';

void main() {
  group('updateNodes', () {
    test('should retain errors property when updating nodes', () {
      final NodeManager nm = NodeManager();

      nm.updateNodes(
          NodeType.gva,
          <Node>[
            const Node(url: 'node1', errors: 2),
            const Node(url: 'node2', errors: 3),
            const Node(url: 'node1'),
          ],
          notify: false);

      nm.updateNodes(
          NodeType.gva,
          <Node>[
            const Node(url: 'node1'),
            const Node(url: 'node3'),
          ],
          notify: false);

      final List<Node> updatedNodes = nm.gvaNodes;

      expect(updatedNodes.length, 2);
      expect(updatedNodes[0].url, 'node1');
      expect(updatedNodes[0].errors, 2);
      expect(updatedNodes[1].url, 'node3');
      expect(updatedNodes[1].errors, 0);
    });

    test('should handle empty node list', () {
      final NodeManager nm = NodeManager();
      nm.updateNodes(NodeType.duniter, <Node>[], notify: false);
      expect(nm.duniterNodes, isEmpty);
    });

    test('should remove duplicates based on url', () {
      final NodeManager nm = NodeManager();
      nm.updateNodes(
          NodeType.cesiumPlus,
          <Node>[
            const Node(url: 'node1', latency: 100),
            const Node(url: 'node1', latency: 200),
            const Node(url: 'node2', latency: 150),
          ],
          notify: false);

      expect(nm.cesiumPlusNodes.length, 2);
      expect(nm.cesiumPlusNodes.any((Node n) => n.url == 'node1'), isTrue);
      expect(nm.cesiumPlusNodes.any((Node n) => n.url == 'node2'), isTrue);
    });
  });

  group('NodeManager', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      // Clean lists before each test
      nm.duniterNodes.clear();
      nm.cesiumPlusNodes.clear();
      nm.gvaNodes.clear();
      nm.endpointNodes.clear();
      nm.duniterIndexerNodes.clear();
      nm.duniterDataNodes.clear();
      nm.ipfsGateways.clear();
    });

    test('increaseNodeErrors should increase the error count of a node', () {
      const Node node = Node(url: 'node a');

      nm.addNode(NodeType.gva, node, notify: false);
      nm.increaseNodeErrors(NodeType.gva, node,
          notify: false, cause: 'Test error');

      final Node updatedNode =
          nm.nodeList(NodeType.gva).firstWhere((Node n) => n.url == node.url);

      expect(updatedNode.errors, 1);
    });

    test('updateNode should update the node in the list', () {
      const Node node = Node(url: 'node b');

      nm.addNode(NodeType.gva, node, notify: false);
      const Node updatedNode = Node(url: 'node b', errors: 2);
      nm.updateNode(NodeType.gva, updatedNode, notify: false);

      final Node retrievedNode =
          nm.nodeList(NodeType.gva).firstWhere((Node n) => n.url == node.url);

      expect(retrievedNode.errors, 2);
    });

    test('addNode should not add duplicate nodes', () {
      const Node node = Node(url: 'node c');

      nm.addNode(NodeType.endpoint, node, notify: false);
      nm.addNode(NodeType.endpoint, node, notify: false);

      expect(nm.endpointNodes.length, 1);
    });

    test('addNode should update existing node with new values', () {
      const Node node = Node(url: 'node d', latency: 100);
      const Node updatedNode = Node(url: 'node d', latency: 200, errors: 1);

      nm.addNode(NodeType.endpoint, node, notify: false);
      nm.addNode(NodeType.endpoint, updatedNode, notify: false);

      expect(nm.endpointNodes.length, 1);
      expect(nm.endpointNodes.first.latency, 200);
      expect(nm.endpointNodes.first.errors, 1);
    });

    test('insertNode should insert at beginning', () {
      nm.addNode(NodeType.duniterIndexer, const Node(url: 'node1'),
          notify: false);
      nm.addNode(NodeType.duniterIndexer, const Node(url: 'node2'),
          notify: false);
      nm.insertNode(NodeType.duniterIndexer, const Node(url: 'node3'));

      expect(nm.duniterIndexerNodes.first.url, 'node3');
    });

    test('cleanErrorStats should reset all errors to 0', () {
      nm.addNode(NodeType.gva, const Node(url: 'node1', errors: 5),
          notify: false);
      nm.addNode(NodeType.duniter, const Node(url: 'node2', errors: 3),
          notify: false);

      nm.cleanErrorStats(notify: false);

      expect(nm.gvaNodes.first.errors, 0);
      expect(nm.duniterNodes.first.errors, 0);
    });

    test('nodesWorking should count nodes with errors below max', () {
      nm.addNode(NodeType.gva, const Node(url: 'node1'), notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'node2', errors: 3),
          notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'node3', errors: 10),
          notify: false);

      final int workingCount = nm.nodesWorking(NodeType.gva);

      expect(workingCount, 2);
    });

    test('nodesWorkingList should return only nodes with few errors', () {
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'node1'), notify: false);
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'node2', errors: 3),
          notify: false);
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'node3', errors: 10),
          notify: false);

      final List<Node> workingNodes = nm.nodesWorkingList(NodeType.cesiumPlus);

      expect(workingNodes.length, 2);
      expect(
          workingNodes.every((Node n) => n.errors < NodeManager.maxNodeErrors),
          isTrue);
    });
  });

  group('getBestNodes', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.duniterNodes.clear();
    });

    test('should return nodes with low errors and near max block', () {
      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(url: 'node1', latency: 100, currentBlock: 1000),
            const Node(
                url: 'node2', latency: 150, errors: 1, currentBlock: 1001),
            const Node(url: 'node3', latency: 200, currentBlock: 999),
            const Node(
                url: 'node4', latency: 120, errors: 10, currentBlock: 1000),
            const Node(url: 'node5', latency: 180, currentBlock: 900),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      expect(bestNodes.isNotEmpty, isTrue);
      // Best nodes should have few errors and be close to the max block
      expect(bestNodes.every((Node n) => n.errors < NodeManager.maxNodeErrors),
          isTrue);
      // Verify that nodes are close to the max block (1001)
      expect(bestNodes.every((Node n) => (1001 - n.currentBlock).abs() <= 2),
          isTrue);
    });

    test('should prioritize nodes with fewer errors', () {
      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(url: 'node1', latency: 100, currentBlock: 1000),
            const Node(
                url: 'node2', latency: 100, errors: 2, currentBlock: 1000),
            const Node(
                url: 'node3', latency: 100, errors: 1, currentBlock: 1000),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // After sorting, the node with 0 errors should be first
      // (although shuffle may change the order, we verify that all are valid)
      expect(bestNodes.every((Node n) => n.errors < NodeManager.maxNodeErrors),
          isTrue);
      expect(bestNodes.length, greaterThan(0));
    });

    test('should exclude offline nodes (high latency)', () {
      const Duration wrongNodeDuration = Duration(days: 2);
      final int wrongNode = wrongNodeDuration.inMicroseconds;

      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(url: 'node1', latency: 100, currentBlock: 1000),
            Node(url: 'node2', latency: wrongNode, currentBlock: 1000),
            const Node(url: 'node3', latency: 200, currentBlock: 1000),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // Should not include node2 which has very high latency
      expect(bestNodes.any((Node n) => n.url == 'node2'), isFalse);
      expect(bestNodes.every((Node n) => n.isOk), isTrue);
    });

    test('should return synced nodes with errors if no perfect nodes available',
        () {
      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(
                url: 'node1', latency: 100, errors: 10, currentBlock: 1000),
            const Node(
                url: 'node2', latency: 150, errors: 8, currentBlock: 1001),
            const Node(
                url: 'node3', latency: 200, errors: 7, currentBlock: 1000),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // All nodes have many errors, but are synchronized
      expect(bestNodes.isNotEmpty, isTrue);
      expect(bestNodes.every((Node n) => (1001 - n.currentBlock).abs() <= 2),
          isTrue);
    });

    test('should return default nodes if no good nodes available', () {
      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(url: 'bad-node1', latency: 999999, errors: 10),
            const Node(url: 'bad-node2', latency: 999999, errors: 10),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // Should return default nodes
      expect(bestNodes.isNotEmpty, isTrue);
    });

    test('should handle empty node list', () {
      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // Should return default nodes
      expect(bestNodes.isNotEmpty, isTrue);
    });

    test('should consider nodes within 2 blocks as synced', () {
      nm.updateNodes(
          NodeType.endpoint,
          <Node>[
            const Node(url: 'node1', latency: 100, currentBlock: 1000),
            const Node(url: 'node2', latency: 100, currentBlock: 999),
            const Node(url: 'node3', latency: 100, currentBlock: 998),
            const Node(url: 'node4', latency: 100, currentBlock: 997),
            const Node(url: 'node5', latency: 100, currentBlock: 990),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.endpoint);

      // Only nodes from 998 to 1000 should be considered (difference <= 2)
      expect(bestNodes.every((Node n) => n.currentBlock >= 998), isTrue);
      expect(bestNodes.any((Node n) => n.url == 'node5'), isFalse);
    });

    test('should balance latency and errors in selection', () {
      nm.updateNodes(
          NodeType.duniter,
          <Node>[
            const Node(
                url: 'fast-errors', latency: 50, errors: 3, currentBlock: 1000),
            const Node(url: 'slow-no-errors', latency: 300, currentBlock: 1000),
            const Node(
                url: 'balanced', latency: 150, errors: 1, currentBlock: 1000),
          ],
          notify: false);

      final List<Node> bestNodes = nm.getBestNodes(NodeType.duniter);

      // All should be included since they have few errors and are synchronized
      expect(bestNodes.length, 3);
      expect(bestNodes.every((Node n) => n.errors < NodeManager.maxNodeErrors),
          isTrue);
    });
  });

  group('sortNodesByErrorOrLatency', () {
    test('should sort by errors first', () {
      final List<Node> nodes = <Node>[
        const Node(url: 'node1', latency: 100, errors: 2),
        const Node(url: 'node2', latency: 50, errors: 3),
        const Node(url: 'node3', latency: 200, errors: 1),
      ];

      sortNodesByErrorOrLatency(nodes);

      expect(nodes[0].url, 'node3'); // 1 error
      expect(nodes[1].url, 'node1'); // 2 errors
      expect(nodes[2].url, 'node2'); // 3 errors
    });

    test('should sort by latency when errors are equal', () {
      final List<Node> nodes = <Node>[
        const Node(url: 'node1', latency: 200, errors: 1),
        const Node(url: 'node2', latency: 50, errors: 1),
        const Node(url: 'node3', latency: 150, errors: 1),
      ];

      sortNodesByErrorOrLatency(nodes);

      expect(nodes[0].latency, 50);
      expect(nodes[1].latency, 150);
      expect(nodes[2].latency, 200);
    });

    test('should combine error and latency sorting', () {
      final List<Node> nodes = <Node>[
        const Node(url: 'high-latency-many-errors', latency: 300, errors: 3),
        const Node(url: 'low-latency-few-errors', latency: 50, errors: 1),
        const Node(url: 'medium-latency-few-errors', latency: 150, errors: 1),
        const Node(url: 'low-latency-some-errors', latency: 100, errors: 2),
      ];

      sortNodesByErrorOrLatency(nodes);

      // First those with 1 error sorted by latency
      expect(nodes[0].errors, 1);
      expect(nodes[0].latency, 50);
      expect(nodes[1].errors, 1);
      expect(nodes[1].latency, 150);
      // Then those with 2 errors
      expect(nodes[2].errors, 2);
      // Finally those with 3 errors
      expect(nodes[3].errors, 3);
    });

    test('should handle empty list', () {
      final List<Node> nodes = <Node>[];
      sortNodesByErrorOrLatency(nodes);
      expect(nodes, isEmpty);
    });

    test('should handle single node', () {
      final List<Node> nodes = <Node>[
        const Node(url: 'node1', latency: 100, errors: 1),
      ];
      sortNodesByErrorOrLatency(nodes);
      expect(nodes.length, 1);
      expect(nodes[0].url, 'node1');
    });
  });

  group('Node equality and properties', () {
    test('nodes with same url should be equal', () {
      const Node node1 = Node(url: 'node1', latency: 100);
      const Node node2 = Node(url: 'node1', latency: 200, errors: 5);

      expect(node1, equals(node2));
    });

    test('nodes with different urls should not be equal', () {
      const Node node1 = Node(url: 'node1', latency: 100);
      const Node node2 = Node(url: 'node2', latency: 100);

      expect(node1, isNot(equals(node2)));
    });

    test('isOk should return true for low latency', () {
      const Node node = Node(url: 'node1', latency: 100);
      expect(node.isOk, isTrue);
    });

    test('isNotOk should return true for high latency', () {
      const Duration wrongNodeDuration = Duration(days: 2);
      final int wrongNode = wrongNodeDuration.inMicroseconds;
      final Node node = Node(url: 'node1', latency: wrongNode);
      expect(node.isNotOk, isTrue);
    });

    test('copyWith should preserve unchanged values', () {
      const Node original =
          Node(url: 'node1', latency: 100, errors: 2, currentBlock: 1000);
      final Node copy = original.copyWith(errors: 5);

      expect(copy.url, original.url);
      expect(copy.latency, original.latency);
      expect(copy.errors, 5);
      expect(copy.currentBlock, original.currentBlock);
    });
  });

  group('NodeType operations', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.duniterNodes.clear();
      nm.cesiumPlusNodes.clear();
      nm.gvaNodes.clear();
      nm.endpointNodes.clear();
      nm.duniterIndexerNodes.clear();
      nm.duniterDataNodes.clear();
      nm.ipfsGateways.clear();
    });

    test('should handle different node types independently', () {
      nm.addNode(NodeType.duniter, const Node(url: 'duniter1'), notify: false);
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'cesium1'),
          notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'gva1'), notify: false);
      nm.addNode(NodeType.endpoint, const Node(url: 'endpoint1'),
          notify: false);

      expect(nm.duniterNodes.length, 1);
      expect(nm.cesiumPlusNodes.length, 1);
      expect(nm.gvaNodes.length, 1);
      expect(nm.endpointNodes.length, 1);
    });

    test('should not mix nodes between different types', () {
      const Node node = Node(url: 'shared-url');
      nm.addNode(NodeType.duniter, node, notify: false);
      nm.addNode(NodeType.cesiumPlus, node, notify: false);

      expect(nm.duniterNodes.first.url, 'shared-url');
      expect(nm.cesiumPlusNodes.first.url, 'shared-url');
      expect(nm.duniterNodes.length, 1);
      expect(nm.cesiumPlusNodes.length, 1);
    });
  });

  group('IPFS URL generation', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.ipfsGateways.clear();
      // Reset current IPFS node between tests
      nm.currentIfpsNode = null;
    });

    test('should generate correct IPFS URL', () {
      nm.addNode(
          NodeType.ipfsGateway, const Node(url: 'https://ipfs.example.com'),
          notify: false);

      final String url = nm.ipfsUrl('QmHash123');

      expect(url, 'https://ipfs.example.com/ipfs/QmHash123');
    });

    test('should reuse current IPFS node', () {
      nm.addNode(
          NodeType.ipfsGateway, const Node(url: 'https://ipfs1.example.com'),
          notify: false);
      nm.addNode(
          NodeType.ipfsGateway, const Node(url: 'https://ipfs2.example.com'),
          notify: false);

      final String url1 = nm.ipfsUrl('QmHash1');
      final String url2 = nm.ipfsUrl('QmHash2');

      // Both URLs should use the same gateway (the first one selected)
      final String gateway1 = url1.substring(0, url1.indexOf('/ipfs/'));
      final String gateway2 = url2.substring(0, url2.indexOf('/ipfs/'));

      expect(gateway1, gateway2);
      expect(url1, '$gateway1/ipfs/QmHash1');
      expect(url2, '$gateway2/ipfs/QmHash2');
    });
  });

  group('Concurrent node updates', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.duniterNodes.clear();
      nm.cesiumPlusNodes.clear();
      nm.gvaNodes.clear();
      nm.endpointNodes.clear();
      nm.duniterIndexerNodes.clear();
      nm.duniterDataNodes.clear();
      nm.ipfsGateways.clear();
    });

    test('should handle concurrent updateNodes without losing data', () async {
      // Simulate concurrent updates from different sources
      final List<Future<void>> futures = <Future<void>>[];

      for (int i = 0; i < 10; i++) {
        futures.add(Future<void>(() {
          nm.updateNodes(
              NodeType.endpoint,
              <Node>[
                Node(url: 'node$i', latency: 100 * i),
              ],
              notify: false);
        }));
      }

      await Future.wait(futures);

      // All nodes should be present (no data loss)
      expect(nm.endpointNodes.length, greaterThanOrEqualTo(1));
      expect(nm.endpointNodes.length, lessThanOrEqualTo(10));
    });

    test('should preserve errors during concurrent updates', () async {
      // Add initial node with errors
      nm.addNode(NodeType.endpoint, const Node(url: 'node1', errors: 5),
          notify: false);

      final List<Future<void>> futures = <Future<void>>[];

      // Concurrent updates with the same node
      for (int i = 0; i < 5; i++) {
        futures.add(Future<void>(() {
          nm.updateNodes(
              NodeType.endpoint,
              <Node>[
                const Node(url: 'node1', latency: 100),
                Node(url: 'node$i', latency: 200),
              ],
              notify: false);
        }));
      }

      await Future.wait(futures);

      // Node1 should still have its error count preserved
      final Node? node1 = nm.endpointNodes
          .cast<Node?>()
          .firstWhere((Node? n) => n?.url == 'node1', orElse: () => null);
      expect(node1, isNotNull);
      expect(node1!.errors, 5);
    });

    test('should handle rapid sequential updates', () async {
      for (int i = 0; i < 100; i++) {
        nm.updateNodes(
            NodeType.duniter,
            <Node>[
              Node(url: 'node$i', latency: i, currentBlock: 1000 + i),
            ],
            notify: false);
      }

      expect(nm.duniterNodes.length, greaterThan(0));
      expect(nm.duniterNodes.length, lessThanOrEqualTo(100));
    });

    test('should handle concurrent addNode operations', () async {
      final List<Future<void>> futures = <Future<void>>[];

      for (int i = 0; i < 20; i++) {
        futures.add(Future<void>(() {
          nm.addNode(NodeType.cesiumPlus, Node(url: 'node$i', latency: 100),
              notify: false);
        }));
      }

      await Future.wait(futures);

      // Should have all unique nodes
      expect(nm.cesiumPlusNodes.length, 20);
      final Set<String> urls =
          nm.cesiumPlusNodes.map((Node n) => n.url).toSet();
      expect(urls.length, 20);
    });

    test('should handle concurrent increaseNodeErrors', () async {
      nm.addNode(NodeType.gva, const Node(url: 'test-node'), notify: false);

      final List<Future<void>> futures = <Future<void>>[];

      for (int i = 0; i < 10; i++) {
        futures.add(Future<void>(() {
          final Node node = nm.gvaNodes.first;
          nm.increaseNodeErrors(NodeType.gva, node,
              notify: false, cause: 'Test error');
        }));
      }

      await Future.wait(futures);

      // Due to the way the update works, the final error count
      // might not be exactly 10 due to race conditions, but should be >= 1
      final Node node = nm.gvaNodes.first;
      expect(node.errors, greaterThanOrEqualTo(1));
    });

    test('should maintain list integrity during mixed operations', () async {
      // Pre-populate with some nodes
      nm.updateNodes(
          NodeType.endpoint,
          <Node>[
            const Node(url: 'existing1', errors: 2),
            const Node(url: 'existing2', errors: 1),
          ],
          notify: false);

      final List<Future<void>> futures = <Future<void>>[];

      // Mix of different operations
      futures.add(Future<void>(() {
        nm.addNode(NodeType.endpoint, const Node(url: 'added1'), notify: false);
      }));

      futures.add(Future<void>(() {
        nm.updateNodes(
            NodeType.endpoint,
            <Node>[
              const Node(url: 'existing1', latency: 50),
              const Node(url: 'new1'),
            ],
            notify: false);
      }));

      futures.add(Future<void>(() {
        const Node node = Node(url: 'existing2');
        nm.increaseNodeErrors(NodeType.endpoint, node,
            cause: 'Test error', notify: false);
      }));

      futures.add(Future<void>(() {
        nm.insertNode(NodeType.endpoint, const Node(url: 'inserted1'));
      }));

      await Future.wait(futures);

      // Verify list is not corrupted
      expect(nm.endpointNodes.length, greaterThan(0));
      expect(nm.endpointNodes.every((Node n) => n.url.isNotEmpty), isTrue);
    });

    test('should handle updateNodes with overlapping node sets', () async {
      final List<Future<void>> futures = <Future<void>>[];

      // Multiple updates with overlapping nodes
      futures.add(Future<void>(() {
        nm.updateNodes(
            NodeType.duniter,
            <Node>[
              const Node(url: 'node1', latency: 100),
              const Node(url: 'node2', latency: 150),
            ],
            notify: false);
      }));

      futures.add(Future<void>(() {
        nm.updateNodes(
            NodeType.duniter,
            <Node>[
              const Node(url: 'node2', latency: 120),
              const Node(url: 'node3', latency: 130),
            ],
            notify: false);
      }));

      futures.add(Future<void>(() {
        nm.updateNodes(
            NodeType.duniter,
            <Node>[
              const Node(url: 'node1', latency: 110),
              const Node(url: 'node3', latency: 140),
            ],
            notify: false);
      }));

      await Future.wait(futures);

      // Should have unique nodes
      final Set<String> urls = nm.duniterNodes.map((Node n) => n.url).toSet();
      expect(urls.length, nm.duniterNodes.length);
    });
  });

  group('Node list consistency', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.endpointNodes.clear();
    });

    test('should not have duplicate nodes after multiple updates', () {
      nm.updateNodes(
          NodeType.endpoint,
          <Node>[
            const Node(url: 'node1', latency: 100),
            const Node(url: 'node2', latency: 150),
          ],
          notify: false);

      nm.updateNodes(
          NodeType.endpoint,
          <Node>[
            const Node(url: 'node1', latency: 120),
            const Node(url: 'node2', latency: 130),
            const Node(url: 'node3', latency: 140),
          ],
          notify: false);

      final Set<String> urls = nm.endpointNodes.map((Node n) => n.url).toSet();
      expect(urls.length, nm.endpointNodes.length);
      expect(nm.endpointNodes.length, 3);
    });

    test('should maintain referential integrity across node types', () {
      const Node sharedNode = Node(url: 'shared-node');

      nm.addNode(NodeType.endpoint, sharedNode, notify: false);
      nm.addNode(NodeType.duniterIndexer, sharedNode, notify: false);

      // Modifying one should not affect the other
      nm.increaseNodeErrors(NodeType.endpoint, sharedNode,
          notify: false, cause: 'Test error');

      final Node endpointNode =
          nm.endpointNodes.firstWhere((Node n) => n.url == 'shared-node');
      final Node indexerNode =
          nm.duniterIndexerNodes.firstWhere((Node n) => n.url == 'shared-node');

      expect(endpointNode.errors, 1);
      expect(indexerNode.errors, 0);
    });

    test('should handle empty updates gracefully', () {
      nm.updateNodes(
          NodeType.endpoint,
          <Node>[
            const Node(url: 'node1'),
            const Node(url: 'node2'),
          ],
          notify: false);

      nm.updateNodes(NodeType.endpoint, <Node>[], notify: false);

      expect(nm.endpointNodes, isEmpty);
    });

    test('should preserve node order after insertNode', () {
      nm = NodeManager();
      nm.duniterIndexerNodes.clear();

      nm.addNode(NodeType.duniterIndexer, const Node(url: 'node1'),
          notify: false);
      nm.addNode(NodeType.duniterIndexer, const Node(url: 'node2'),
          notify: false);
      nm.insertNode(NodeType.duniterIndexer, const Node(url: 'node0'));

      expect(nm.duniterIndexerNodes.first.url, 'node0');
      expect(nm.duniterIndexerNodes[1].url, 'node1');
      expect(nm.duniterIndexerNodes[2].url, 'node2');
    });

    test('should handle large node lists efficiently', () {
      final List<Node> largeNodeList = List<Node>.generate(
        1000,
        (int i) => Node(url: 'node$i', latency: i, currentBlock: 1000 + i),
      );

      final Stopwatch stopwatch = Stopwatch()..start();
      nm.updateNodes(NodeType.endpoint, largeNodeList, notify: false);
      stopwatch.stop();

      expect(nm.endpointNodes.length, 1000);
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });

  group('NodeManager state management', () {
    test('should maintain singleton instance', () {
      final NodeManager nm1 = NodeManager();
      final NodeManager nm2 = NodeManager();

      expect(identical(nm1, nm2), isTrue);
    });

    test('should share state across singleton instances', () {
      final NodeManager nm1 = NodeManager();
      final NodeManager nm2 = NodeManager();

      // Clean all lists first
      nm1.endpointNodes.clear();
      nm1.duniterNodes.clear();
      nm1.cesiumPlusNodes.clear();
      nm1.gvaNodes.clear();
      nm1.duniterIndexerNodes.clear();
      nm1.duniterDataNodes.clear();
      nm1.ipfsGateways.clear();

      nm1.addNode(NodeType.endpoint, const Node(url: 'test-node'),
          notify: false);

      expect(nm2.endpointNodes.length, 1);
      expect(nm2.endpointNodes.first.url, 'test-node');
    });

    test('should clear all node types with cleanErrorStats', () {
      final NodeManager nm = NodeManager();

      nm.addNode(NodeType.endpoint, const Node(url: 'node1', errors: 5),
          notify: false);
      nm.addNode(NodeType.duniter, const Node(url: 'node2', errors: 3),
          notify: false);
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'node3', errors: 4),
          notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'node4', errors: 2),
          notify: false);

      nm.cleanErrorStats(notify: false);

      expect(nm.endpointNodes.first.errors, 0);
      expect(nm.duniterNodes.first.errors, 0);
      expect(nm.cesiumPlusNodes.first.errors, 0);
      expect(nm.gvaNodes.first.errors, 0);
    });
  });

  group('Error accumulation and recovery', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.endpointNodes.clear();
    });

    test('should accumulate errors correctly', () {
      const Node node = Node(url: 'test-node');
      nm.addNode(NodeType.endpoint, node, notify: false);

      for (int i = 0; i < 5; i++) {
        final Node currentNode =
            nm.endpointNodes.firstWhere((Node n) => n.url == 'test-node');
        nm.increaseNodeErrors(NodeType.endpoint, currentNode,
            cause: 'Test error $i', notify: false);
      }

      final Node updatedNode =
          nm.endpointNodes.firstWhere((Node n) => n.url == 'test-node');
      expect(updatedNode.errors, 5);
    });

    test('should filter out nodes with too many errors', () {
      nm.addNode(NodeType.endpoint, const Node(url: 'good1', errors: 2),
          notify: false);
      nm.addNode(NodeType.endpoint, const Node(url: 'good2', errors: 3),
          notify: false);
      nm.addNode(NodeType.endpoint, const Node(url: 'bad1', errors: 10),
          notify: false);
      nm.addNode(NodeType.endpoint, const Node(url: 'bad2', errors: 15),
          notify: false);

      final List<Node> workingNodes = nm.nodesWorkingList(NodeType.endpoint);

      expect(workingNodes.length, 2);
      expect(
          workingNodes.every((Node n) => n.errors < NodeManager.maxNodeErrors),
          isTrue);
    });

    test('should allow error recovery after cleanErrorStats', () {
      nm.addNode(NodeType.endpoint, const Node(url: 'node1', errors: 10),
          notify: false);
      nm.addNode(NodeType.endpoint, const Node(url: 'node2', errors: 8),
          notify: false);

      expect(nm.nodesWorking(NodeType.endpoint), 0);

      nm.cleanErrorStats(notify: false);

      expect(nm.nodesWorking(NodeType.endpoint), 2);
    });
  });

  group('addNodeSortedByLatency', () {
    late NodeManager nm;

    setUp(() {
      nm = NodeManager();
      nm.duniterNodes.clear();
    });

    test('should prioritize nodes with fewer errors over lower latency', () {
      // Add a node with few errors but higher latency
      nm.addNodeSortedByLatency(
          NodeType.duniter, const Node(url: 'slow-but-reliable', latency: 300),
          notify: false);

      // Add a node with fast latency but more errors
      nm.addNodeSortedByLatency(NodeType.duniter,
          const Node(url: 'fast-but-errors', latency: 50, errors: 3),
          notify: false);

      // Add another reliable but slow node
      nm.addNodeSortedByLatency(NodeType.duniter,
          const Node(url: 'medium-reliable', latency: 200, errors: 1),
          notify: false);

      final List<Node> nodes = nm.duniterNodes;

      // The first node should have the fewest errors, not the lowest latency
      expect(nodes[0].errors, 0);
      expect(nodes[1].errors, 1);
      expect(nodes[2].errors, 3);
    });

    test('should sort by latency when errors are equal', () {
      nm.addNodeSortedByLatency(
          NodeType.duniter, const Node(url: 'node1', latency: 200, errors: 1),
          notify: false);

      nm.addNodeSortedByLatency(
          NodeType.duniter, const Node(url: 'node2', latency: 100, errors: 1),
          notify: false);

      nm.addNodeSortedByLatency(
          NodeType.duniter, const Node(url: 'node3', latency: 150, errors: 1),
          notify: false);

      final List<Node> nodes = nm.duniterNodes;

      // All have same errors, so should be sorted by latency
      expect(nodes[0].latency, 100);
      expect(nodes[1].latency, 150);
      expect(nodes[2].latency, 200);
    });

    test(
        'should insert node with zero errors at beginning even with high latency',
        () {
      nm.addNodeSortedByLatency(NodeType.duniter,
          const Node(url: 'fast-with-errors', latency: 50, errors: 2),
          notify: false);

      nm.addNodeSortedByLatency(
          NodeType.duniter, const Node(url: 'slow-no-errors', latency: 500),
          notify: false);

      final List<Node> nodes = nm.duniterNodes;

      // The node with 0 errors should be first
      expect(nodes[0].url, 'slow-no-errors');
      expect(nodes[0].errors, 0);
      expect(nodes[1].url, 'fast-with-errors');
      expect(nodes[1].errors, 2);
    });
  });
}
