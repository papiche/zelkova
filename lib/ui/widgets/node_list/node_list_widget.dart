import 'package:flutter/material.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_type.dart';
import '../../clipboard_helper.dart';

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
        return Theme(
            data: Theme.of(context).copyWith(
              visualDensity: VisualDensity.compact,
            ),
            child: GestureDetector(
                onTap: () => copyToClipboard(
                    context: context,
                    text: node.url,
                    feedbackText: 'copied_to_clipboard'),
                child: ListTile(
                  dense: true,
                  title: Text(node.url),
                  subtitle: node.isOk
                      ? Text(
                          '${type != NodeType.cesiumPlus ? (type == NodeType.datapodEndpoint ? 'Current profiles: ${node.currentBlock}, ' : 'Current block: ${node.currentBlock}, ') : 'Current docs: ${node.currentBlock}, '}errors: ${node.errors}, latency (ms): ${node.latency}')
                      : null,
                  leading: node.currentBlock == currentBlock && node.isOk
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : node.isOk
                          ? const Icon(Icons.run_circle, color: Colors.grey)
                          : const Icon(Icons.power_off, color: Colors.grey),
                )));
      },
    ));
  }
}
