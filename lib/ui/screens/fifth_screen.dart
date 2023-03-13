import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/node_list_cubit.dart';
import '../../data/models/node_list_state.dart';
import '../../g1/export_import.dart';
import '../ui_helpers.dart';
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
        builder: (BuildContext context, NodeListState state) {
      return Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const Header(text: 'bottom_nav_fifth'),
              InfoCard(
                  title: 'connected-to',
                  subtitle: context
                      .read<NodeListCubit>()
                      .duniterNodes
                      .first
                      .url
                      .replaceFirst(':443', ''),
                  icon: Icons.hub),
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
                        title: 'export-key',
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
                        title: 'import-key',
                        icon: Icons.upload,
                        onTap: () {
                          const ExportImportPage();
                        }),
                    GridItem(
                      title: 'copy-your-key',
                      icon: Icons.copy,
                      onTap: () => copyPublicKeyToClipboard(context),
                    )
                  ]),
              const SizedBox(height: 36),
            ]),
      );
    });
  }
}
