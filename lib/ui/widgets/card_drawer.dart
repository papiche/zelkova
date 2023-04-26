import 'package:easy_localization/easy_localization.dart';
import 'package:feedback_gitlab/feedback_gitlab.dart';
import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/models/cesium_card.dart';
import '../../shared_prefs.dart';
import '../ui_helpers.dart';

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
            child: Column(
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
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Cards',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (kReleaseMode) Expanded(child: Container()),
                if (!kReleaseMode)
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
                  ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: Text(tr('feedback')),
                  onTap: () {
                    Navigator.pop(context);
                    final String gitLabToken = "${dotenv.env['GITLAB_TOKEN']}";
                    if (gitLabToken.isNotEmpty) {
                      BetterFeedback.of(context).showAndUploadToGitLab(
                          projectId: '663',
                          apiToken: gitLabToken,
                          gitlabUrl: 'git.duniter.org');
                    }
                    BetterFeedback.of(context).showAndUploadToSentry(
                      // name: 'Foo Bar',
                      // email: 'foo_bar@example.com',
                    );
                  },
                ),
                AboutListTile(
                    icon: g1nkgoIcon,
                    applicationName: tr('app_name'),
                    applicationVersion: 'Version: ${snapshot.data!.version}',
                    applicationIcon: g1nkgoIcon,
                    applicationLegalese:
                    '© ${DateTime
                        .now()
                        .year
                        .toString() == '2023' ? '2023' : '2023-${DateTime
                        .now()
                        .year}'} Comunes Association, under AGPLv3',
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
