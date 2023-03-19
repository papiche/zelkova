import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:universal_html/html.dart' as html;

import '../../../g1/g1_helper.dart';
import '../../../main.dart';
import '../../../shared_prefs.dart';
import '../custom_error_widget.dart';
import '../loading_box.dart';
import 'pattern_util.dart';

class ImportDialog extends StatelessWidget {
  ImportDialog({super.key});

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
                title: Text(tr('intro_pattern_to_import')),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      tr('draw your_pattern'),
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  Flexible(
                    child: PatternLock(
                      selectedColor: Colors.red,
                      pointRadius: 8,
                      fillPoints: true,
                      onInputComplete: (List<int> pattern) {
                        try {
                          // try to decrypt
                          final Map<String, dynamic> keys =
                              decryptJsonForImport(
                                  keyEncrypted, pattern.join());
                          SharedPreferencesHelper().setKeys(
                              keys['pub'] as String, keys['seed'] as String);
                          context.replaceSnackbar(
                            content: Text(
                              tr('wallet_imported'),
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
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
        final String jsonString = reader.result as String;
        if (!kReleaseMode) {
          logger(jsonString);
        }
        completer.complete(jsonString);
      } catch (e) {
        logger('Error importing wallet $e');
      }
    });
    return completer.future;
  }
}
