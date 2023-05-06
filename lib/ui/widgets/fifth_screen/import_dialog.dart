import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/transaction_cubit.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../custom_error_widget.dart';
import 'pattern_util.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key});

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext c) {
    return FutureBuilder<String>(
        future: kIsWeb ? _importWalletWeb(c) : _importWallet(c),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            final String keyEncString = snapshot.data!;
            final Map<String, dynamic> keyJson =
                jsonDecode(keyEncString) as Map<String, dynamic>;
            final String keyEncrypted = keyJson['key'] as String;
            // final Uint8List keyBase64 = base64Decode(keyEncrypted);
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
                          final bool? confirm = await confirmImport(context);
                          if (confirm != null && confirm) {
                            try {
                              final dynamic cesiumCards = keys['cesiumCards'];
                              if (cesiumCards != null) {
                                final List<dynamic> cesiumCardList =
                                    jsonDecode(cesiumCards as String)
                                        as List<dynamic>;
                                // ignore: avoid_function_literals_in_foreach_calls
                                cesiumCardList.forEach((dynamic cesiumCard) {
                                  importWalletToSharedPrefs(
                                      cesiumCard as Map<String, dynamic>);
                                });
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
                              if (!mounted) {
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
                          }
                          if (!mounted) {
                            return;
                          }
                          Navigator.of(context).pop(true);
                        } catch (e, stacktrace) {
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

  void importWalletToSharedPrefs(Map<String, dynamic> cesiumCard) {
    final dynamic pub = cesiumCard['pub'];
    SharedPreferencesHelper().setDefaultWallet(SharedPreferencesHelper()
        .buildCesiumCard(
            pubKey:
                pub != null ? pub as String : cesiumCard['pubKey'] as String,
            seed: cesiumCard['seed'] as String));
    /* In the future, with multicards, use this instead
     SharedPreferencesHelper().addCesiumCard(SharedPreferencesHelper()
        .buildCesiumCard(
        pubKey: cesiumCard['pub'] as String,
        seed: cesiumCard['seed'] as String)); */
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

      if (!mounted) {
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

  Future<bool?> confirmImport(BuildContext context) async {
    final bool hasBalance = context.read<TransactionCubit>().balance > 0;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('import_config_title')),
          content: Text(tr(
              hasBalance ? 'import_config_desc_danger' : 'import_config_desc')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(tr('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(tr('yes_import')),
            ),
          ],
        );
      },
    );
  }
}
