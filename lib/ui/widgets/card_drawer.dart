import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../shared_prefs_helper_v2.dart';
import '../in_dev_helper.dart';
import '../screens/sandbox.dart';
import '../ui_helpers.dart';
import 'backup_reminder_dialog.dart';
import 'first_screen/card_stack.dart';
import 'lazy_about_info.dart';
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
  bool _isMultipass = false;

  @override
  void initState() {
    super.initState();
    _detectMultipass();
  }

  Future<void> _detectMultipass() async {
    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    if (mounted) {
      setState(() {
        _isMultipass = nsec != null && nsec.isNotEmpty;
      });
    }
  }

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
            if (!_isMultipass && !state.hasRecentExport)
              ListTile(
                tileColor: Colors.red[100],
                leading: const Icon(
                  Icons.warning_rounded,
                  color: Colors.redAccent,
                ),
                title: Text(tr('export_reminder_title'),
                    style: const TextStyle(color: Colors.blue)),
                onTap: () => showBackupReminderDialog(context),
              ),
            const CardStack(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(tr('settings_title')),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => const SettingsPage(),
                  ),
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
            ListTile(
              leading: const Icon(Icons.forum_outlined),
              title: const Text('Votre Réseau'),
              subtitle: const Text('NOSTR · décentralisé · souverain'),
              onTap: () async {
                await openUrl('https://coracle.copylaradio.com');
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
                          context: ZelkovaApp.navigatorKey.currentContext!,
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
                          context: ZelkovaApp.navigatorKey.currentContext!,
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
              icon: zelkovaIcon,
              applicationName: tr('app_name'),
              applicationIcon: zelkovaIcon,
              applicationLegalese:
                  '© ${DateTime.now().year.toString() == '2023' ? '2023' : '2023-${DateTime.now().year}'} Comunes Association • G1FabLab#monnaie-libre, under AGPLv3',
              aboutBoxChildren: <Widget>[
                const SizedBox(height: 8.0),
                const Text(
                  'G1FabLab · AMAP Numérique Citoyenne\n'
                  "Ğ1 apporte la Liberté · Ẑen apporte l'Égalité · ❤️ apporte la Fraternité",
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: () async {
                    await openUrl(
                        'https://github.com/papiche/zelkova');
                  },
                  child: const Text(
                    '🔗 github.com/papiche/zelkova',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 12),
                  ),
                ),
              ],

              // versionLabelPrefix: 'Version: ',
              // fallbackVersion: 'dev',
            ),
            /* AboutListTile(
                      icon: zelkovaIcon,
                      applicationName: tr('app_name'),
                      applicationVersion: 'Version: ${snapshot.data!.version}',
                      applicationIcon: zelkovaIcon,
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
