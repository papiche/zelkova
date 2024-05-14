import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../cesium_auth_dialog.dart';
import '../custom_error_widget.dart';
import 'import_clipboard_dialog.dart';
import 'pattern_util.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key, this.wallet});

  final String? wallet;

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext c) {
    return FutureBuilder<String>(
        future: widget.wallet == null
            ? (kIsWeb ? _importWalletWeb(c) : _importWallet(c))
            : Future<String>.value(widget.wallet),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            final String keyEncString = snapshot.data!;
            final Map<String, dynamic> keyJson =
                jsonDecode(keyEncString) as Map<String, dynamic>;
            final String keyEncrypted = keyJson['key'] as String;
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(tr('draw_your_pattern')),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          tr('intro_pattern_to_import'),
                          style: const TextStyle(fontSize: 26),
                        )),
                  ),
                  Flexible(
                    child: PatternLock(
                      selectedColor: selectedPatternLock(),
                      notSelectedColor: notSelectedPatternLock(),
                      pointRadius: 8,
                      fillPoints: true,
                      onInputComplete: (List<int> pattern) async {
                        try {
                          // try to decrypt
                          final Map<String, dynamic> keys =
                              decryptJsonForImport(
                                  keyEncrypted, pattern.join());
                          try {
                            final dynamic cesiumCards = keys['cesiumCards'];
                            if (cesiumCards != null) {
                              final List<dynamic> cesiumCardList =
                                  jsonDecode(cesiumCards as String)
                                      as List<dynamic>;
                              // ignore: avoid_function_literals_in_foreach_calls
                              int imported = 0;
                              for (final dynamic cesiumCard in cesiumCardList) {
                                final bool result = importWalletToSharedPrefs(
                                    cesiumCard as Map<String, dynamic>);
                                if (result) {
                                  imported += 1;
                                }
                              }
                              c.replaceSnackbar(
                                content: Text(
                                  imported == 0
                                      ? tr('wallet_already_imported')
                                      : tr('wallets_imported',
                                          namedArgs: <String, String>{
                                              'number': imported.toString()
                                            }),
                                  style: TextStyle(
                                      color: imported == 0
                                          ? Colors.red
                                          : Colors.white),
                                ),
                              );
                              Navigator.of(context).pop(true);
                              return;
                            } else {
                              importWalletToSharedPrefs(keys);
                            }
                            if (!mounted) {
                              return;
                            }
                            c.replaceSnackbar(
                              content: Text(
                                tr('wallet_imported'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                            // ok, fetch the transactions & balance
                            // fetchTransactions(context);
                          } catch (e, stacktrace) {
                            logger('Error importing wallet: $e');
                            if (!c.mounted) {
                              return;
                            }
                            c.replaceSnackbar(
                              content: Text(
                                tr('error_importing_wallet'),
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                            await Sentry.captureException(e,
                                stackTrace: stacktrace);
                            return;
                          }

                          if (!context.mounted) {
                            return;
                          }
                          Navigator.of(context).pop(true);
                        } catch (e, stacktrace) {
                          logger(e.toString());
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.of(context).pop(true);
                          context.replaceSnackbar(
                            content: Text(
                              tr('wrong_pattern'),
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                          await Sentry.captureException(e,
                              stackTrace: stacktrace);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return CustomErrorWidget(snapshot.error);
          } else {
            return CustomErrorWidget(tr('import_failed'));
          }
        });
  }

  bool importWalletToSharedPrefs(Map<String, dynamic> cesiumCard) {
    final dynamic pub = cesiumCard['pub'];
    final String pubKey =
        pub != null ? pub as String : cesiumCard['pubKey'] as String;
    if (!SharedPreferencesHelper().has(pubKey)) {
      SharedPreferencesHelper().addCesiumCard(SharedPreferencesHelper()
          .buildCesiumCard(pubKey: pubKey, seed: cesiumCard['seed'] as String));
      return true;
    } else {
      return false;
    }
  }

  Future<String> _importWallet(BuildContext context) async {
    try {
      // Use file_picker to pick a file

      /* final bool hasPermission = await requestStoragePermission(context);

      if (hasPermission == null || !hasPermission) {
        logger('No permission to access storage');
        return '';
      }*/

      final Directory? appDocDir = await getAppSpecificExternalFilesDirectory();
      if (appDocDir == null) {
        return '';
      }
      logger('appDocDir: ${appDocDir.path}');

      if (!context.mounted) {
        return '';
      }

      final String? filePath = await FilesystemPicker.openDialog(
        title: tr('select_file_to_import'),
        context: context,
        rootDirectory: appDocDir,
        fsType: FilesystemType.file,
        allowedExtensions: <String>['.json'],
        // requestPermission: () async => _requestStoragePermission(context),
        fileTileSelectMode: FileTileSelectMode.wholeTile,
      );

      if (filePath == null || filePath.isEmpty) {
        return '';
      }

      final File file = File(filePath);
      final String jsonString = await file.readAsString();

      // Log the content if not in release mode
      if (!kReleaseMode) {
        logger(jsonString);
      }

      return jsonString;
    } catch (e, stacktrace) {
      logger('Error importing wallet $e');
      await Sentry.captureException(e, stackTrace: stacktrace);
      // Handle the exception using Sentry or any other error reporting tool
      // await Sentry.captureException(e, stackTrace: stacktrace);
      return '';
    }
  }

  Future<String> _importWalletWeb(BuildContext context) async {
    final Completer<String> completer = Completer<String>();
    final html.InputElement input = html.InputElement()..type = 'file';

    input.multiple = false;
    input.accept = '.json'; // limit file types
    input.click();

    input.onChange.listen((html.Event event) async {
      if (input.files != null && input.files!.isEmpty) {
        completer.complete('');
        return;
      }

      final html.File file = input.files!.first;
      final html.FileReader reader = html.FileReader();

      // Read as text
      reader.readAsText(file);
      await reader.onLoadEnd.first;

      try {
        final String? jsonString = reader.result as String?;
        if (jsonString != null && !kReleaseMode) {
          logger(jsonString);
        }
        completer.complete(jsonString);
      } catch (e, stacktrace) {
        logger('Error importing wallet $e');
        await Sentry.captureException(e, stackTrace: stacktrace);
        completer.complete('');
      }
    });
    return completer.future;
  }
}

Future<void> showSelectImportMethodDialog(
    BuildContext context, int returnTo) async {
  final String? method = await showDialog<String>(
    context: context,
    builder: (BuildContext context) => const SelectImportMethodDialog(),
  );
  if (method != null) {
    if (!context.mounted) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (method == 'file') {
          return const ImportDialog();
        } else {
          // if (method == 'clipboard') {
          return ImportClipboardDialog(onImport: (String wallet) {
            if (validateKey(wallet)) {
              // It's a pubkey, let's think is a cesium wallet
              if (!SharedPreferencesHelper().has(wallet)) {
                showImportCesiumWalletDialog(context, wallet, returnTo);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr('wallet_already_imported'))));
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImportDialog(wallet: wallet);
                  });
            }
          });
        }
      },
    );
  }
}

Future<bool?> showImportCesiumWalletDialog(
    BuildContext context, String wallet, int returnTo) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return CesiumAddDialog(publicKey: wallet, returnTo: returnTo);
    },
  );
}

class SelectImportMethodDialog extends StatelessWidget {
  const SelectImportMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('select_import_method')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.file_present),
              title: Text(tr('file_import')),
              onTap: () => Navigator.of(context).pop('file'),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: Text(tr('clipboard_import')),
              onTap: () => Navigator.of(context).pop('clipboard'),
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: Text(tr('clipboard_import_pubkey')),
              onTap: () => Navigator.of(context).pop('clipboard_pubkey'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('cancel')),
        ),
      ],
    );
  }
}
