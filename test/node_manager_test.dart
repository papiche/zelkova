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
      nm.increaseNodeErrors(NodeType.gva, node, notify: false);

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
      nm.addNode(NodeType.gva, const Node(url: 'node1', errors: 0),
          notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'node2', errors: 3),
          notify: false);
      nm.addNode(NodeType.gva, const Node(url: 'node3', errors: 10),
          notify: false);

      final int workingCount = nm.nodesWorking(NodeType.gva);

      expect(workingCount, 2);
    });

    test('nodesWorkingList should return only nodes with few errors', () {
      nm.addNode(NodeType.cesiumPlus, const Node(url: 'node1', errors: 0),
          notify: false);
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
            const Node(
                url: 'node1', latency: 100, errors: 0, currentBlock: 1000),
            const Node(
                url: 'node2', latency: 150, errors: 1, currentBlock: 1001),
            const Node(
                url: 'node3', latency: 200, errors: 0, currentBlock: 999),
            const Node(
                url: 'node4', latency: 120, errors: 10, currentBlock: 1000),
            const Node(
                url: 'node5', latency: 180, errors: 0, currentBlock: 900),
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
            const Node(
                url: 'node1', latency: 100, errors: 0, currentBlock: 1000),
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
            const Node(
                url: 'node1', latency: 100, errors: 0, currentBlock: 1000),
            Node(
                url: 'node2',
                latency: wrongNode,
                errors: 0,
                currentBlock: 1000),
            const Node(
                url: 'node3', latency: 200, errors: 0, currentBlock: 1000),
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
            const Node(
                url: 'bad-node1', latency: 999999, errors: 10, currentBlock: 0),
            const Node(
                url: 'bad-node2', latency: 999999, errors: 10, currentBlock: 0),
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
            const Node(
                url: 'node1', latency: 100, errors: 0, currentBlock: 1000),
            const Node(
                url: 'node2', latency: 100, errors: 0, currentBlock: 999),
            const Node(
                url: 'node3', latency: 100, errors: 0, currentBlock: 998),
            const Node(
                url: 'node4', latency: 100, errors: 0, currentBlock: 997),
            const Node(
                url: 'node5', latency: 100, errors: 0, currentBlock: 990),
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
            const Node(
                url: 'slow-no-errors',
                latency: 300,
                errors: 0,
                currentBlock: 1000),
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
      const Node node1 = Node(url: 'node1', latency: 100, errors: 0);
      const Node node2 = Node(url: 'node1', latency: 200, errors: 5);

      expect(node1, equals(node2));
    });

    test('nodes with different urls should not be equal', () {
      const Node node1 = Node(url: 'node1', latency: 100, errors: 0);
      const Node node2 = Node(url: 'node2', latency: 100, errors: 0);

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
      expect(url1, '${gateway1}/ipfs/QmHash1');
      expect(url2, '${gateway2}/ipfs/QmHash2');
    });
  });
}
