import 'package:flutter/material.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_type.dart';

class DebugNodeList extends StatelessWidget {
  const DebugNodeList(
      {super.key,
      required this.nodes,
      required this.currentBlock,
      required this.type});

  final List<Node> nodes;
  final int currentBlock;
  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      //physics: const AlwaysScrollableScrollPhysics(),
      itemCount: nodes.length,
      itemBuilder: (BuildContext context, int index) {
        final Node node = nodes[index];
        return ListTile(
          dense: true,
          title: Text(node.url),
          subtitle: Text(
              '${type != NodeType.cesiumPlus ? 'Current block: ${node.currentBlock}, ' : ''}errors: ${node.errors}, latency (ms): ${node.latency}'),
          leading: node.currentBlock == currentBlock
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.run_circle, color: Colors.grey),
        );
      },
    );
  }
}
