import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../data/models/node_manager.dart';
import '../../g1/api.dart';
import '../../g1/export_import.dart';
import '../../main.dart';
import '../ui_helpers.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/fifth_screen/grid_item.dart';
import '../widgets/fifth_screen/info_card.dart';
import '../widgets/fifth_screen/link_card.dart';
import '../widgets/fifth_screen/text_divider.dart';
import '../widgets/header.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      return Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const Header(text: 'bottom_nav_fifth'),
              const TextDivider(text: 'key_tools_title'),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1.15,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: <GridItem>[
                    GridItem(
                        title: 'export_key',
                        icon: Icons.download,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ExportImportPage();
                            },
                          );
                        }),
                    GridItem(
                        title: 'import_key',
                        icon: Icons.upload,
                        onTap: () {
                          const ExportImportPage();
                        }),
                    GridItem(
                      title: 'copy_your_key',
                      icon: Icons.copy,
                      onTap: () => copyPublicKeyToClipboard(context),
                    )
                  ]),
              const TextDivider(text: 'technical_info_title'),
              _buildNodeInfo(NodeType.duniter, state.duniterNodes, context),
              _buildNodeInfo(
                  NodeType.cesiumPlus, state.cesiumPlusNodes, context),
              LinkCard(
                  title: 'code_card_title',
                  icon: Icons.code_rounded,
                  url: Uri.parse('https://git.duniter.org/vjrj/ginkgo')),
              const BottomWidget()
            ]),
      );
    });
  }

  GestureDetector _buildNodeInfo(
      NodeType type, List<Node> nodes, BuildContext context) {
    return GestureDetector(
        onTap: () => showTooltip(context, '', tr('long_press_to_refresh')),
        onLongPress: () {
          logger('On long press');
          if (type == NodeType.duniter) {
            fetchDuniterNodes(force: true);
          } else {
            fetchCesiumPlusNodes(force: true);
          }
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
            icon: Icons.hub));
  }
}
