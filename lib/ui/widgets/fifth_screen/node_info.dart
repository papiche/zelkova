import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_list_state.dart';
import '../../../data/models/node_manager.dart';
import '../../../g1/api.dart';
import '../../../main.dart';
import '../fifth_screen/info_card.dart';

class NodeInfoCard extends StatelessWidget {
  const NodeInfoCard({super.key, required this.type});

  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      final List<Node> nodes =
          type == NodeType.duniter ? state.duniterNodes : state.cesiumPlusNodes;
      return GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr('long_press_to_refresh')),
                ),
              ),
          onLongPress: () {
            logger('On long press');
            if (type == NodeType.duniter) {
              fetchDuniterNodes(force: true);
            } else {
              fetchCesiumPlusNodes(force: true);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(tr('reloading_nodes',
                  namedArgs: <String, String>{'type': type.name})),
            ));
          },
          child: InfoCard(
              title: tr('using_nodes', namedArgs: <String, String>{
                'type': type.name,
                'nodes': nodes.length.toString()
              }),
              translate: false,
              subtitle: nodes.isNotEmpty
                  ? tr('using_nodes_first',
                      namedArgs: <String, String>{'node': nodes.first.url})
                  : '',
              icon: type == NodeType.duniter ? Icons.hub : Icons.diversity_2));
    });
  }
}
