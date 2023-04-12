import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../data/models/node_type.dart';
import '../widgets/debug_nodes/debug_node_list.dart';

class DebugNodesScreen extends StatelessWidget {
  const DebugNodesScreen({super.key});

  List<Node> filterAndSortNodesByType(List<Node> nodes, NodeType type) {
    nodes.sort(
        (Node a, Node b) => a.currentBlock.compareTo(b.currentBlock) * -1);
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      final List<Node> duniterNodes =
          filterAndSortNodesByType(state.duniterNodes, NodeType.duniter);
      final List<Node> cesiumPlusNodes =
          filterAndSortNodesByType(state.cesiumPlusNodes, NodeType.cesiumPlus);
      final List<Node> gvaNodes =
          filterAndSortNodesByType(state.gvaNodes, NodeType.gva);
      return Scaffold(
          appBar: AppBar(title: Text(tr('nodes_tech_info'))),
          body: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Text('GVA Nodes', style: TextStyle(fontSize: 24)),
                      ),
                      DebugNodeList(
                          nodes: gvaNodes,
                          type: NodeType.gva,
                          currentBlock: gvaNodes[0].currentBlock),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Duniter Nodes',
                            style: TextStyle(fontSize: 24)),
                      ),
                      DebugNodeList(
                          nodes: duniterNodes,
                          type: NodeType.duniter,
                          currentBlock: duniterNodes[0].currentBlock),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cesium+ Nodes',
                            style: TextStyle(fontSize: 24)),
                      ),
                      DebugNodeList(
                          nodes: cesiumPlusNodes,
                          type: NodeType.cesiumPlus,
                          currentBlock: cesiumPlusNodes[0].currentBlock),
                    ],
                  ),
                ),
              )));
    });
  }
}
