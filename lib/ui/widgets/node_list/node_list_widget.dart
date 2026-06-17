import 'package:flutter/material.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_manager.dart';
import '../../../data/models/node_type.dart';
import '../../clipboard_helper.dart';

class NodeListWidget extends StatelessWidget {
  const NodeListWidget({
    super.key,
    required this.nodes,
    required this.currentBlock,
    required this.type,
  });

  final List<Node> nodes;
  final int currentBlock;
  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(nodes.length, (int index) {
        final Node node = nodes[index];
        final bool isPinned = NodeManager().getPinnedNodeUrl(type) == node.url;
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(visualDensity: VisualDensity.compact),
          child: GestureDetector(
            onTap: () => copyToClipboard(
              context: context,
              text: node.url,
              feedbackText: 'copied_to_clipboard',
            ),
            child: ListTile(
              dense: true,
              title: Text(node.url),
              subtitle: node.isOk ? Text(_buildSubtitle(node, type)) : null,
              leading: node.currentBlock == currentBlock && node.isOk
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : node.isOk
                      ? const Icon(Icons.run_circle, color: Colors.grey)
                      : const Icon(Icons.power_off, color: Colors.grey),
              trailing: IconButton(
                icon: Icon(
                  isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: isPinned ? Colors.red : Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  if (isPinned) {
                    NodeManager().unpinNode(type);
                  } else {
                    NodeManager().pinNode(type, node.url);
                  }
                },
                constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        );
      }),
    );
  }

  String _buildSubtitle(Node node, NodeType type) {
    final StringBuffer subtitle = StringBuffer();

    // Block/profile count
    if (type == NodeType.datapodEndpoint) {
      subtitle.write('Current profiles: ${node.currentBlock}, ');
    } else {
      subtitle.write('Current block: ${node.currentBlock}, ');
    }

    // Version (only for indexer nodes)
    if (type == NodeType.duniterIndexer && node.hasVersion) {
      subtitle.write('version: ${node.version}, ');
    }

    // Errors and latency
    subtitle.write('errors: ${node.errors}, latency (ms): ${node.latency}');

    return subtitle.toString();
  }
}
