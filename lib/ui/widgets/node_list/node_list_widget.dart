import 'package:flutter/material.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_type.dart';
import '../../../g1/g1_helper.dart';
import '../../ui_helpers.dart';

class NodeListWidget extends StatelessWidget {
  const NodeListWidget(
      {super.key,
      required this.nodes,
      required this.currentBlock,
      required this.type});

  final List<Node> nodes;
  final int currentBlock;
  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.generate(
      nodes.length,
      (int index) {
        final Node node = nodes[index];
        final int wrongNode = wrongNodeDuration.inMicroseconds;
        return Theme(
            data: Theme.of(context).copyWith(
              visualDensity: VisualDensity.compact,
            ),
            child: GestureDetector(
                onTap: () => copyToClipboard(
                    context: context,
                    uri: node.url,
                    feedbackText: 'copied_to_clipboard'),
                child: ListTile(
                  dense: true,
                  title: Text(node.url),
                  subtitle: node.latency < wrongNode
                      ? Text(
                          '${type != NodeType.cesiumPlus ? 'Current block: ${node.currentBlock}, ' : 'Current docs: ${node.currentBlock}, '}errors: ${node.errors}, latency (ms): ${node.latency}')
                      : null,
                  leading: node.currentBlock == currentBlock &&
                          node.latency < wrongNode
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : node.latency < wrongNode
                          ? const Icon(Icons.run_circle, color: Colors.grey)
                          : const Icon(Icons.power_off, color: Colors.grey),
                )));
      },
    ));
  }
}
