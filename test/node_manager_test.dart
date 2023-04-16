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
}
