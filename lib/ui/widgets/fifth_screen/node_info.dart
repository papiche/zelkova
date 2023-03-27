import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_list_state.dart';
import '../../../data/models/node_type.dart';
import '../../../g1/api.dart';
import '../../logger.dart';
import '../fifth_screen/info_card.dart';

class NodeInfoCard extends StatelessWidget {
  const NodeInfoCard({super.key, required this.type});

  final NodeType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      final List<Node> nodes = type == NodeType.duniter
          ? state.duniterNodes
          : type == NodeType.cesiumPlus
              ? state.cesiumPlusNodes
              : state.gvaNodes;
      return GestureDetector(
          onTap: () {
            context.read<NodeListCubit>().shuffle(type);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('long_press_to_refresh')),
              ),
            );
          },
          onLongPress: () {
            logger('On long press');
            if (type == NodeType.duniter) {
              fetchDuniterNodes(type, force: true);
            }
            if (type == NodeType.cesiumPlus) {
              fetchCesiumPlusNodes(force: true);
            } else {
              fetchDuniterNodes(type, force: true);
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
              icon: type == NodeType.duniter
                  ? Icons.hub
                  : type == NodeType.cesiumPlus
                      ? Icons.diversity_2
                      : Icons.g_mobiledata));
    });
  }
}
