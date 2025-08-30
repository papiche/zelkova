import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../in_dev_helper.dart';
import '../screens/sandbox.dart';
import '../ui_helpers.dart';
import 'backup_reminder_dialog.dart';
import 'first_screen/card_stack.dart';
import 'lazy_about_info.dart';
import 'market_analysis/market_analysis_page.dart';
import 'pages/settings_page.dart';

typedef IssueCreatedCallback = void Function(
    String? issueUrl, Map<String, dynamic> issueData, bool isSuccess);

class CardDrawer extends StatefulWidget {
  const CardDrawer({super.key});

  @override
  State<CardDrawer> createState() => _CardDrawerState();
}

class _CardDrawerState extends State<CardDrawer> {
  // ignore: unused_field
  bool _isLogoLongPressed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
      return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
                // onTap: () => tryCatch(),
                // onLongPress: () => tryCatch(),
                child: SizedBox(
                    height: 140.0,
                    child: DrawerHeader(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/img/logo.png',
                            fit: BoxFit.scaleDown,
                            height: 80.0,
                          ),
                        ],
                      ),
                    ))),
            if (!state.hasRecentExport)
              ListTile(
                tileColor: Colors.red[100],
                leading: const Icon(
                  Icons.warning_rounded,
                  color: Colors.redAccent,
                ),
                // color de link ,
                title: Text(tr('export_reminder_title'),
                    style: const TextStyle(
                      color: Colors.blue,
                      // decoration: TextDecoration.underline,
                    )),
                onTap: () => showBackupReminderDialog(context),
              ),
            const CardStack(),
            if (context.read<AppCubit>().isV2)
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(tr('settings_title')),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const SettingsPage();
                    },
                  );
                },
              ),
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
            if (!kIsWeb)
              ListTile(
                leading: const Icon(Icons.analytics),
                title: Text(tr('market_analysis')),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const MarketAnalysisPage();
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
                } else if (locale == const Locale('fr')) {
                  await openUrl('https://t.me/g1nkgoFR');
                } else {
                  await openUrl('https://t.me/g1nkgoEN');
                }
              },
            ),
            /*
                Until this is solved, we comment the feedback functionality
                https://github.com/ueman/feedback/issues/317
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: Text(tr('feedback')),
                  onTap: () {
                    Navigator.pop(context);
                    final String gitLabToken = Env.gitLabToken;
                    final MyCustomHttpClient client =
                        MyCustomHttpClient(http.Client(), (String? issueUrl,
                            Map<String, dynamic> issueData, bool isSuccess) {
                      if (isSuccess) {
                        showDialog(
                          context: GinkgoApp.navigatorKey.currentContext!,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text(tr('issueCreatedTitle')),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(tr('issueCreatedSuccessfully')),
                                  if (issueUrl != null)
                                    TextButton(
                                      onPressed: () {
                                        openUrl(issueUrl);
                                      },
                                      child: Text(tr('viewIssue')),
                                    ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text(tr('close')),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: GinkgoApp.navigatorKey.currentContext!,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text(tr('issueCreationErrorTitle')),
                              content: Text(tr('issueCreationErrorMessage')),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text(tr('close')),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });

                    BetterFeedback.of(context).showAndUploadToGitLab(
                        projectId: '663',
                        apiToken: gitLabToken,
                        gitlabUrl: 'git.duniter.org',
                        client: client);
                  },
                ),
                */
            LazyAboutListTile(
              icon: g1nkgoIcon,
              applicationName: tr('app_name'),
              applicationIcon: g1nkgoIcon,
              applicationLegalese:
                  '© ${DateTime.now().year.toString() == '2023' ? '2023' : '2023-${DateTime.now().year}'} Comunes Association, under AGPLv3',
              aboutBoxChildren: const <Widget>[
                SizedBox(height: 10.0),
              ],

              // versionLabelPrefix: 'Version: ',
              // fallbackVersion: 'dev',
            ),
            /* AboutListTile(
                      icon: g1nkgoIcon,
                      applicationName: tr('app_name'),
                      applicationVersion: 'Version: ${snapshot.data!.version}',
                      applicationIcon: g1nkgoIcon,
                      applicationLegalese:
                          '© ${DateTime.now().year.toString() == '2023' ? '2023' : '2023-${DateTime.now().year}'} Comunes Association, under AGPLv3',
                      aboutBoxChildren: const <Widget>[
                        SizedBox(height: 10.0),
                      ]), */
          ],
        ),
      );
    });
  }

  void bonusTrack(BuildContext context) {
    if (kIsWeb) {
      return;
    }
    setState(() {
      _isLogoLongPressed = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bonus track!')),
      );
    });
  }
}

Future<void> tryCatch() async {
  try {
    throw StateError('Testing sentry with try catch');
  } catch (error, stackTrace) {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
}

class MyCustomHttpClient extends http.BaseClient {
  MyCustomHttpClient(this._inner, this.onIssueCreated);

  final http.Client _inner;
  final IssueCreatedCallback onIssueCreated;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final http.StreamedResponse response = await _inner.send(request);

    if (request.url.path.contains('/api/v4/projects/') &&
        request.url.path.contains('/issues')) {
      final String responseBody = await response.stream.bytesToString();

      final Map<String, dynamic> issueData =
          json.decode(responseBody) as Map<String, dynamic>;
      final String? issueUrl = issueData['web_url'] as String?;

      onIssueCreated(issueUrl, issueData,
          response.statusCode == 200 || response.statusCode == 201);

      final Stream<List<int>> newStream =
          Stream<List<int>>.value(utf8.encode(responseBody));

      return http.StreamedResponse(newStream, response.statusCode,
          contentLength: response.contentLength,
          request: response.request,
          headers: response.headers,
          isRedirect: response.isRedirect,
          persistentConnection: response.persistentConnection,
          reasonPhrase: response.reasonPhrase);
    }

    return response;
  }
}
