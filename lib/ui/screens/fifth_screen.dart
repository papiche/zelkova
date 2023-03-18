import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node.dart';
import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
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
      final List<Node> duniterNodes = state.duniterNodes;
      return Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const Header(text: 'bottom_nav_fifth'),
              GestureDetector(
                  onLongPress: () {
                    logger('On long press');
                    fetchDuniterNodes(force: true);
                    fetchCesiumPlusNodes(force: true);
                  },
                  child: InfoCard(
                      title: 'connected_to',
                      subtitle: duniterNodes.first.url.replaceFirst(':443', ''),
                      trailing: tr('current_nodes_length',
                          namedArgs: <String, String>{
                            'nodes': duniterNodes.length.toString()
                          }),
                      icon: Icons.hub)),
              LinkCard(
                  title: 'code_card_title',
                  icon: Icons.code_rounded,
                  url: Uri.parse('https://git.duniter.org/vjrj/ginkgo')),
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
              const BottomWidget()
            ]),
      );
    });
  }
}
