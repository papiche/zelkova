import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../data/models/node_lists_default.dart';
import '../../data/models/node_type.dart';
import '../../g1/api.dart';
import '../../g1/no_nodes_exception.dart';
import '../ui_helpers.dart';
import '../widgets/node_list/node_list_widget.dart';

class NodeListPage extends StatelessWidget {
  NodeListPage({super.key});

  List<Node> filterAndSortNodesByType(List<Node> nodes, NodeType type) {
    nodes.sort(
        (Node a, Node b) => a.currentBlock.compareTo(b.currentBlock) * -1);
    return nodes;
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final NodeListState state = context.watch<NodeListCubit>().state;
    final List<Node> endPointNodes =
        filterAndSortNodesByType(state.endpointNodes, NodeType.endpoint);
    final List<Node> duniterIndexerNodes = filterAndSortNodesByType(
        state.duniterIndexerNodes, NodeType.duniterIndexer);
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
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    NodeListHeader(
                        type: NodeType.endpoint,
                        nodesCount: endPointNodes.length),
                    if (endPointNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: endPointNodes,
                          type: NodeType.endpoint,
                          currentBlock: endPointNodes[0].currentBlock),
                    NodeListHeader(
                        type: NodeType.duniterIndexer,
                        nodesCount: defaultDuniterIndexerNodes.length),
                    if (duniterIndexerNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: duniterIndexerNodes,
                          type: NodeType.duniterIndexer,
                          currentBlock: duniterIndexerNodes[0].currentBlock),
                    NodeListHeader(
                        type: NodeType.gva, nodesCount: gvaNodes.length),
                    if (gvaNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: gvaNodes,
                          type: NodeType.gva,
                          currentBlock: gvaNodes[0].currentBlock),
                    NodeListHeader(
                      type: NodeType.duniter,
                      nodesCount: duniterNodes.length,
                    ),
                    if (duniterNodes.isNotEmpty)
                      NodeListWidget(
                          nodes: duniterNodes,
                          type: NodeType.duniter,
                          currentBlock: duniterNodes[0].currentBlock),
                    NodeListHeader(
                        type: NodeType.cesiumPlus,
                        nodesCount: cesiumPlusNodes.length),
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

class NodeListHeader extends StatelessWidget {
  const NodeListHeader(
      {super.key, required this.type, required this.nodesCount});

  final NodeType type;
  final int nodesCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${capitalize(type.name)} Nodes ($nodesCount)',
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
