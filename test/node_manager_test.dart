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
  });

  group('NodeManager', () {
    final NodeManager nm = NodeManager();

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
  });
}
