import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../data/models/node_type.dart';
import '../../g1/api.dart';
import '../../g1/no_nodes_exception.dart';
import '../ui_helpers.dart';
import '../widgets/node_list/node_list_widget.dart';

class NodeListPage extends StatelessWidget {
  const NodeListPage({super.key});

  List<Node> filterAndSortNodesByType(List<Node> nodes, NodeType type) {
    nodes.sort(
        (Node a, Node b) => a.currentBlock.compareTo(b.currentBlock) * -1);
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    final NodeListState state = context.watch<NodeListCubit>().state;
    final List<Node> duniterNodes =
        filterAndSortNodesByType(state.duniterNodes, NodeType.duniter);
    final List<Node> cesiumPlusNodes =
        filterAndSortNodesByType(state.cesiumPlusNodes, NodeType.cesiumPlus);
    final List<Node> gvaNodes =
        filterAndSortNodesByType(state.gvaNodes, NodeType.gva);
    return Scaffold(
        appBar: AppBar(
          title: Text(tr('nodes_tech_info')),
          bottom: state.isLoading
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(4.0),
                  child: LinearProgressIndicator(),
                )
              : null,
        ),
        body: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const DebugNodeHeader(type: NodeType.gva),
                    if (gvaNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: gvaNodes,
                          type: NodeType.gva,
                          currentBlock: gvaNodes[0].currentBlock),
                    const DebugNodeHeader(type: NodeType.duniter),
                    if (duniterNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: duniterNodes,
                          type: NodeType.duniter,
                          currentBlock: duniterNodes[0].currentBlock),
                    const DebugNodeHeader(type: NodeType.cesiumPlus),
                    if (cesiumPlusNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: cesiumPlusNodes,
                          type: NodeType.cesiumPlus,
                          currentBlock: cesiumPlusNodes[0].currentBlock),
                  ],
                ),
              ),
            )));
  }
}

class DebugNodeHeader extends StatelessWidget {
  const DebugNodeHeader({super.key, required this.type});

  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${capitalize(type.name)} Nodes',
                style: const TextStyle(fontSize: 20)),
            GestureDetector(
              onLongPress: () => _fetchNodes(context, true),
              child: IconButton(
                  icon: const Icon(Icons.refresh),
                  // Force in all cases
                  onPressed: () => _fetchNodes(context, true)),
            )
          ],
        ));
  }

  void _fetchNodes(BuildContext context, bool force) {
    try {
      fetchNodes(type, force);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(tr('reloading_nodes',
            namedArgs: <String, String>{'type': type.name})),
      ));
    } on NoNodesException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(tr('no_nodes_found',
            namedArgs: <String, String>{'type': type.name})),
      ));
    }
  }
}
