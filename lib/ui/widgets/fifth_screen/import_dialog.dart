import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/transaction_cubit.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../custom_error_widget.dart';
import '../loading_box.dart';
import 'pattern_util.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key});

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _importWallet(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
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
                      selectedColor: Colors.red,
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
                            SharedPreferencesHelper().setKeys(
                                keys['pub'] as String, keys['seed'] as String);
                            if (!mounted) {
                              return;
                            }
                            context.replaceSnackbar(
                              content: Text(
                                tr('wallet_imported'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                            // ok, fetch the transactions & balance
                            fetchTransactions(context);
                          }
                          if (!mounted) {
                            return;
                          }
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          context.replaceSnackbar(
                            content: Text(
                              tr('wrong_pattern'),
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
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
            return const LoadingBox();
          }
        });
  }

  Future<String> _importWallet() async {
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
      } catch (e) {
        logger('Error importing wallet $e');
      }
    });
    return completer.future;
  }

  Future<bool?> confirmImport(BuildContext context) async {
    final bool hasBalance = context.read<TransactionsCubit>().balance > 0;
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
