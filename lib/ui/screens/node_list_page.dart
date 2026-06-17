import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../data/models/node_manager.dart';
import '../../data/models/node_type.dart';
import '../../g1/api.dart';
import '../../g1/no_nodes_exception.dart';
import '../ui_helpers.dart';
import '../widgets/node_list/astro_swarm_widget.dart';
import '../widgets/node_list/node_list_widget.dart';
import '../widgets/node_list/station_status_widget.dart';
import '../widgets/node_list/swarm_economy_widget.dart';

class NodeListPage extends StatelessWidget {
  NodeListPage({super.key});

  List<Node> filterAndSortNodesByType(List<Node> nodes, NodeType type) {
    // Create a copy of the list to avoid mutating the original state
    final List<Node> sortedNodes = List<Node>.from(nodes);
    sortedNodes.sort(
        (Node a, Node b) => a.currentBlock.compareTo(b.currentBlock) * -1);
    return sortedNodes;
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Get v2 mode from AppCubit
    final bool useV2 = context.read<AppCubit>().state.v2mode;
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext context, NodeListState state) {
      final List<Node> endPointNodes =
          filterAndSortNodesByType(state.endpointNodes, NodeType.endpoint);
      final List<Node> duniterIndexerNodes = filterAndSortNodesByType(
          state.duniterIndexerNodes, NodeType.duniterIndexer);
      // Use isV1 and isV2 from NodeType, and sort by enum index for consistent order
      final List<NodeType> v2Types = NodeType.values
          .where((NodeType type) => type.isV2)
          .toList()
        ..sort((NodeType a, NodeType b) => a.index.compareTo(b.index));
      // Map NodeType to nodes and lastUpdated
      final Map<NodeType, List<Node>> nodeTypeToNodes = <NodeType, List<Node>>{
        NodeType.endpoint: endPointNodes,
        NodeType.duniterIndexer: duniterIndexerNodes,
/*        NodeType.datapodEndpoint: duniterDataNodes,
         NodeType.ipfsGateway: ipfsGateways,*/
      };
      final Map<NodeType, DateTime?> nodeTypeToLastUpdated =
          <NodeType, DateTime?>{
        NodeType.endpoint: state.endpointNodesLastUpdate,
        NodeType.duniterIndexer: state.duniterIndexerNodesLastUpdate,
/*        NodeType.datapodEndpoint: state.duniterDataNodesLastUpdate,
         NodeType.ipfsGateway: state.ipfsGatewaysLastUpdate,*/
      };
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
                      // Station status from 12345.json (heartbox_analysis)
                      const StationStatusWidget(),
                      // Constellation economy from NOSTR kind 30850
                      const SwarmEconomyWidget(),
                      // UPlanet Astroport relay stations from SWARM JSON
                      // Shown in expert mode — same data as MULTIPASS onboarding
                      const AstroSwarmWidget(),
                      // Show v2 nodes only if useV2, otherwise show only v1 nodes
                      if (useV2)
                        for (final NodeType type in v2Types) ...<Widget>[
                          NodeListHeader(
                            type: type,
                            lastUpdated: nodeTypeToLastUpdated[type],
                            nodesCount: nodeTypeToNodes[type]?.length ?? 0,
                          ),
                          if (nodeTypeToNodes[type]?.isNotEmpty ?? false)
                            NodeListWidget(
                              nodes: nodeTypeToNodes[type]!,
                              type: type,
                              currentBlock:
                                  nodeTypeToNodes[type]![0].currentBlock,
                            ),
                        ]
                    ],
                  ),
                ),
              )));
    });
  }
}

class NodeListHeader extends StatelessWidget {
  const NodeListHeader(
      {super.key,
      required this.type,
      required this.nodesCount,
      this.lastUpdated});

  final NodeType type;
  final int nodesCount;
  final DateTime? lastUpdated;

  @override
  Widget build(BuildContext context) {
    final String? pinnedNodeUrl = NodeManager().getPinnedNodeUrl(type);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    tr('nodes_list_title', namedArgs: <String, String>{
                      'type': capitalize(type.name),
                      'count': '$nodesCount'
                    }),
                    style: const TextStyle(fontSize: 20),
                  ),
                  if (pinnedNodeUrl != null)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.push_pin, color: Colors.red, size: 20),
                    ),
                ],
              ),
              if (lastUpdated != null)
                Text(
                  tr('nodes_list_last_updated', namedArgs: <String, String>{
                    'time':
                        humanizeTime(lastUpdated!, context.locale.toString())
                  }),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              if (pinnedNodeUrl != null)
                Text(
                  'Pinned: $pinnedNodeUrl',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          GestureDetector(
            onLongPress: () => _fetchNodes(context, true, type),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _fetchNodes(context, false, type),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchNodes(BuildContext context, bool force, NodeType type) {
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
