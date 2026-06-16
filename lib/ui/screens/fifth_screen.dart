import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/node_manager.dart';
import '../../data/models/theme_cubit.dart';
import '../../shared_prefs_helper.dart';
import '../clipboard_helper.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../ui_helpers.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/contacts_actions.dart';
import '../widgets/fifth_screen/fifth_tutorial.dart';
import '../widgets/fifth_screen/link_card.dart';
import '../widgets/fifth_screen/node_list_card.dart';
import '../widgets/fifth_screen/text_divider.dart';
import '../widgets/pages/settings_page.dart';
import 'apk_share_screen.dart';
import 'feedback_screen.dart';

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
          builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            key: infoMainKey,
            title: Text(tr('bottom_nav_fifth')),
            actions: <Widget>[
              IconButton(
                icon: Icon(context.watch<ThemeCubit>().isDark()
                    ? Icons.wb_sunny
                    : Icons.nights_stay),
                onPressed: () {
                  BlocProvider.of<ThemeCubit>(context).getTheme(ThemeModeState(
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
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(height: 10),
                  ListTile(
                      title: Text(tr('info_this_wallet')),
                      leading: const Icon(Icons.wallet),
                      onTap: () {
                        showMyContactPage(context);
                      }),
                  ListTile(
                      title: Text(tr('settings_title')),
                      leading: const Icon(Icons.settings),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const SettingsPage(),
                          ),
                        );
                      }),
                  const SizedBox(height: 15),
                  const TextDivider(text: 'key_tools_title'),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: <Widget>[
                      if (showShare())
                        LinkCard(
                            title: 'share_your_key',
                            icon: Icons.share,
                            onTap: () => SharePlus.instance.share(ShareParams(
                                text: SharedPreferencesHelper().getPubKey()))),
                      LinkCard(
                        title: 'copy_your_key',
                        icon: Icons.copy,
                        onTap: () => copyPublicKeyToClipboard(context),
                      ),
                      if (PWAInstall().installPromptEnabled)
                        LinkCard(
                          title: 'install_desktop',
                          icon: Icons.install_desktop,
                          onTap: () {
                            try {
                              PWAInstall().promptInstall_();
                            } catch (e) {
                              final String error = e.toString();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(tr('error_installing_desktop',
                                      namedArgs: <String, String>{
                                        'error': error
                                      })),
                                ),
                              );
                            }
                          },
                        ),
                      // Partage APK P2P — uniquement sur mobile (pas Web)
                      if (!kIsWeb)
                        LinkCard(
                          title: 'share_app',
                          icon: Icons.adaptive.share,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const ApkShareScreen(),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (state.expertMode)
                    const TextDivider(text: 'technical_info_title'),
                  if (state.expertMode &&
                      NodeManager().getCurrentGvaNode() != null)
                    ListTile(
                        title: Text(tr('last_node') +
                            NodeManager().getCurrentGvaNode()!.url)),
                  if (state.expertMode) const NodeListCard(),
                  const TextDivider(text: 'info_links'),
                  // Rapport de bug / feedback — formulaire natif via /api/feedback
                  LinkCard(
                    title: 'bug_report',
                    icon: Icons.bug_report,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const FeedbackScreen(),
                      ),
                    ),
                  ),
                  if (state.expertMode)
                    LinkCard(
                        title: 'code_card_title',
                        icon: Icons.code_rounded,
                        url: Uri.parse('https://github.com/papiche/zelkova')),
                  // const TextDivider(text: 'faq_title'),
                  // const FAQ(),
                  const BottomWidget()
                ],
              );
            },
          ),
        );
      });
    });
  }
}
