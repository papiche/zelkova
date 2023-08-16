import 'package:easy_localization/easy_localization.dart';
import 'package:feedback_gitlab/feedback_gitlab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/models/cesium_card.dart';
import '../../shared_prefs.dart';
import '../screens/sandbox.dart';
import '../ui_helpers.dart';
import 'first_screen/card_stack.dart';

class CardDrawer extends StatelessWidget {
  const CardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CesiumCard> cards = SharedPreferencesHelper().cesiumCards;

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  /* decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ), */
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => tryCatch(),
                          onLongPress: () => tryCatch(),
                          child: Image.asset(
                            'assets/img/logo.png',
                            fit: BoxFit.scaleDown,
                            height: 80.0,
                          )),
                      // const SizedBox(height: 20.0),
                      /* Text(tr('app_name'),
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          )), */
                    ],
                  ),
                ),
                if (!kReleaseMode)
                  SizedBox(
                    height: (cards.length * 70) + 50,
                    child: const Center(
                      child: CardStack(),
                    ),
                  ),
                Expanded(child: Container()),
                /* if (!kReleaseMode)
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CesiumCard card = cards[index];
                          return InkWell(
                            onTap: () {
                              SharedPreferencesHelper()
                                  .selectCurrentWallet(index);
                              Navigator.pop(context);
                            },
                            child: Text(card.pubKey),
                          );
                        },
                      ),
                    ),
                  ), */
                if (inDevelopment)
                  ListTile(
                    leading: const Icon(Icons.build),
                    title: const Text('Sandbox'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Sandbox();
                        },
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.telegram_outlined),
                  title: Text(tr('telegram_group')),
                  onTap: () async {
                    final Locale locale = context.locale;
                    if (locale == const Locale('es') ||
                        locale == const Locale('ca') ||
                        locale == const Locale('gl') ||
                        locale == const Locale('eu') ||
                        locale == const Locale('ast')) {
                      await openUrl('https://t.me/g1nkgoES');
                    }
                    if (locale == const Locale('fr')) {
                      await openUrl('https://t.me/g1nkgoFR');
                    } else {
                      await openUrl('https://t.me/g1nkgoEN');
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: Text(tr('feedback')),
                  onTap: () {
                    Navigator.pop(context);
                    final String gitLabToken = dotenv.get('GITLAB_TOKEN',
                        fallback: 'FKb9GMueV4-hyDEWjfAf');
                    BetterFeedback.of(context).showAndUploadToGitLab(
                        projectId: '663',
                        apiToken: gitLabToken,
                        gitlabUrl: 'git.duniter.org');
                    /* BetterFeedback.of(context).showAndUploadToSentry(
                      // name: 'Foo Bar',
                      // email: 'foo_bar@example.com',
                    ); */
                  },
                ),
                AboutListTile(
                    icon: g1nkgoIcon,
                    applicationName: tr('app_name'),
                    applicationVersion: 'Version: ${snapshot.data!.version}',
                    applicationIcon: g1nkgoIcon,
                    applicationLegalese:
                        '© ${DateTime.now().year.toString() == '2023' ? '2023' : '2023-${DateTime.now().year}'} Comunes Association, under AGPLv3',
                    aboutBoxChildren: const <Widget>[
                      SizedBox(height: 10.0),
                    ]),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Future<void> tryCatch() async {
  try {
    throw StateError('Testing sentry with try catch');
  } catch (error, stackTrace) {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
}
