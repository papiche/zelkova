import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/theme_cubit.dart';
import '../../g1/currency.dart';
import '../../shared_prefs_helper.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../ui_helpers.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/faq.dart';
import '../widgets/fifth_screen/export_dialog.dart';
import '../widgets/fifth_screen/fifth_tutorial.dart';
import '../widgets/fifth_screen/grid_item.dart';
import '../widgets/fifth_screen/import_dialog.dart';
import '../widgets/fifth_screen/link_card.dart';
import '../widgets/fifth_screen/node_list_card.dart';
import '../widgets/fifth_screen/text_divider.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  late Tutorial tutorial;

  @override
  void initState() {
    tutorial = FifthTutorial(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
        SharedPreferencesHelper prefsHelper, Widget? child) {
      return BlocBuilder<AppCubit, AppState>(
          builder: (BuildContext context, AppState state) => Scaffold(
                appBar: AppBar(
                  key: infoMainKey,
                  title: Text(tr('bottom_nav_fifth')),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(context.watch<ThemeCubit>().isDark()
                          ? Icons.wb_sunny
                          : Icons.nights_stay),
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).getTheme(
                            ThemeModeState(
                                themeMode: context.read<ThemeCubit>().isDark()
                                    ? ThemeMode.light
                                    : ThemeMode.dark));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        tutorial.showTutorial(showAlways: true);
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                drawer: const CardDrawer(),
                body: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      const SizedBox(height: 10),
                      DropdownButtonFormField<Locale>(
                        value: context.locale,
                        decoration: InputDecoration(
                          labelText: tr('language_switch_title'),
                          icon: const Icon(Icons.language),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (Locale? newLocale) {
                          context.setLocale(newLocale!);
                          // NotificationController.locale = newLocale;
                        },
                        items: const <DropdownMenuItem<Locale>>[
                          DropdownMenuItem<Locale>(
                            value: Locale('es', 'AST'),
                            child: Text('Asturianu'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('ca'),
                            child: Text('Català'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('de'),
                            child: Text('Deutsch'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('en'),
                            child: Text('English'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('eo'),
                            child: Text('Esperanto'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('es'),
                            child: Text('Español'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('eu'),
                            child: Text('Euskara'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('fr'),
                            child: Text('Français'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('gl'),
                            child: Text('Galego'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('nl'),
                            child: Text('Nederlands'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('it'),
                            child: Text('Italiano'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('pt'),
                            child: Text('Português'),
                          ),
                          // Add more DropdownMenuItem for more languages
                        ],
                      ),
                      const TextDivider(text: 'key_tools_title'),
                      const SizedBox(height: 20),
                      GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 1.15,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: <GridItem>[
                            if (showShare())
                              GridItem(
                                  title: 'share_your_key',
                                  icon: Icons.share,
                                  onTap: () => Share.share(
                                      SharedPreferencesHelper().getPubKey())),
                            GridItem(
                              title: 'copy_your_key',
                              icon: Icons.copy,
                              onTap: () => copyPublicKeyToClipboard(context),
                            ),
                            if (PWAInstall().installPromptEnabled)
                              GridItem(
                                title: 'install_desktop',
                                icon: Icons.install_desktop,
                                onTap: () {
                                  try {
                                    PWAInstall().promptInstall_();
                                  } catch (e) {
                                    final String error = e.toString();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(tr(
                                            'error_installing_desktop',
                                            namedArgs: <String, String>{
                                              'error': error
                                            })),
                                      ),
                                    );
                                  }
                                },
                              ),
                            if (SharedPreferencesHelper().isG1nkgoCard())
                              GridItem(
                                  key: exportMainKey,
                                  title: 'export_key',
                                  icon: Icons.download,
                                  onTap: () {
                                    _showSelectExportMethodDialog();
                                  }),
                            GridItem(
                                title: 'import_key',
                                icon: Icons.upload,
                                onTap: () =>
                                    showSelectImportMethodDialog(context, 0)),
                          ]),
                      SwitchListTile(
                          title: Text(tr('expert_mode')),
                          value: state.expertMode,
                          onChanged: (bool expert) {
                            context.read<AppCubit>().setExpertMode(expert);
                          }),
                      if (state.expertMode)
                        SwitchListTile(
                            title: Text(tr('display_amounts_du')),
                            value: state.currency == Currency.DU,
                            onChanged: (bool useDU) {
                              if (!useDU) {
                                context.read<AppCubit>().setG1Currency();
                              } else {
                                context.read<AppCubit>().setDUCurrency();
                              }
                            }),
                      if (state.expertMode)
                        const TextDivider(text: 'technical_info_title'),
                      if (state.expertMode) const NodeListCard(),
                      const TextDivider(text: 'info_links'),
                      if (state.expertMode)
                        LinkCard(
                            title: 'bug_report',
                            icon: Icons.bug_report,
                            url: Uri.parse(
                                'https://git.duniter.org/vjrj/ginkgo/-/issues')),
                      if (state.expertMode)
                        LinkCard(
                            title: 'code_card_title',
                            icon: Icons.code_rounded,
                            url: Uri.parse(
                                'https://git.duniter.org/vjrj/ginkgo')),
                      LinkCard(
                          title: 'code_translate',
                          icon: Icons.translate,
                          url: Uri.parse(
                              'https://weblate.duniter.org/projects/g1nkgo/g1nkgo/')),
                      const TextDivider(text: 'faq_title'),
                      const FAQ(),
                      const BottomWidget()
                    ]),
              ));
    });
  }

  Future<void> _showSelectExportMethodDialog() async {
    final ExportType? method = await showDialog<ExportType>(
      context: context,
      builder: (BuildContext context) => const SelectExportMethodDialog(),
    );
    if (method != null) {
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExportDialog(type: method);
        },
      );
    }
  }
}

class SelectExportMethodDialog extends StatelessWidget {
  const SelectExportMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('select_export_method')),
      // content: Text(tr('select_export_method_desc')),
      actions: <Widget>[
        TextButton.icon(
            icon: const Icon(Icons.file_present),
            label: Text(tr('file_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.file)),
        TextButton.icon(
            icon: const Icon(Icons.content_paste),
            label: Text(tr('clipboard_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.clipboard)),
        TextButton.icon(
            icon: const Icon(Icons.share),
            label: Text(tr('share_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.share)),
      ],
    );
  }
}
