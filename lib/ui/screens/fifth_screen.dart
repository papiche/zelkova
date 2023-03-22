import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/node_type.dart';
import '../ui_helpers.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/fifth_screen/export_dialog.dart';
import '../widgets/fifth_screen/grid_item.dart';
import '../widgets/fifth_screen/import_dialog.dart';
import '../widgets/fifth_screen/link_card.dart';
import '../widgets/fifth_screen/node_info.dart';
import '../widgets/fifth_screen/text_divider.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) => Scaffold(
              appBar: AppBar(title: Text(tr('bottom_nav_fifth'))),
              drawer: const CardDrawer(),
              body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
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
                          if (state.expertMode)
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
                          if (state.expertMode)
                            GridItem(
                                title: 'import_key',
                                icon: Icons.upload,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ImportDialog();
                                    },
                                  );
                                }),
                          GridItem(
                            title: 'copy_your_key',
                            icon: Icons.copy,
                            onTap: () => copyPublicKeyToClipboard(context),
                          )
                        ]),
                    if (state.expertMode)
                      const TextDivider(text: 'technical_info_title'),
                    if (state.expertMode)
                      const NodeInfoCard(type: NodeType.duniter),
                    if (state.expertMode)
                      const NodeInfoCard(type: NodeType.cesiumPlus),
                    if (state.expertMode)
                      const NodeInfoCard(type: NodeType.gva),
                    if (state.expertMode)
                      LinkCard(
                          title: 'code_card_title',
                          icon: Icons.code_rounded,
                          url:
                              Uri.parse('https://git.duniter.org/vjrj/ginkgo')),
                    const BottomWidget(),
                    SwitchListTile(
                      title: Text(tr('expert_mode')),
                      value: state.expertMode,
                      onChanged: (bool value) =>
                          context.read<AppCubit>().setExpertMode(value),
                    ),
                    const BottomWidget()
                  ]),
            ));
  }
}
