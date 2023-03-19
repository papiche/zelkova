import 'package:flutter/material.dart';

import '../../data/models/node_manager.dart';
import '../ui_helpers.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/fifth_screen/export_dialog.dart';
import '../widgets/fifth_screen/grid_item.dart';
import '../widgets/fifth_screen/import_dialog.dart';
import '../widgets/fifth_screen/link_card.dart';
import '../widgets/fifth_screen/node_info.dart';
import '../widgets/fifth_screen/text_divider.dart';
import '../widgets/header.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            return const ExportDialog();
                          },
                        );
                      }),
                  GridItem(
                      title: 'import_key',
                      icon: Icons.upload,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImportDialog();
                          },
                        );
                      }),
                  GridItem(
                    title: 'copy_your_key',
                    icon: Icons.copy,
                    onTap: () => copyPublicKeyToClipboard(context),
                  )
                ]),
            const TextDivider(text: 'technical_info_title'),
            const NodeInfoCard(type: NodeType.duniter),
            const NodeInfoCard(type: NodeType.cesiumPlus),
            LinkCard(
                title: 'code_card_title',
                icon: Icons.code_rounded,
                url: Uri.parse('https://git.duniter.org/vjrj/ginkgo')),
            const BottomWidget()
          ]),
    );
  }
}
