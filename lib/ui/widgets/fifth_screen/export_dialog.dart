import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import 'pattern_util.dart';

class ExportDialog extends StatefulWidget {
  const ExportDialog({super.key});

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  bool isConfirm = false;
  List<int>? pattern;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(tr('intro_some_pattern_to_export')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Text(
              isConfirm ? tr('confirm_pattern') : tr('draw_pattern'),
              style: const TextStyle(fontSize: 26),
            ),
          ),
          Flexible(
            child: PatternLock(
              selectedColor: Colors.amber,
              pointRadius: 12,
              onInputComplete: (List<int> input) {
                if (input.length < 3) {
                  context.replaceSnackbar(
                    content: Text(
                      tr('at_least_3'),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                  return;
                }
                if (isConfirm) {
                  if (listEquals<int>(input, pattern)) {
                    Navigator.of(context).pop();
                    _export(pattern!.join(), context);
                  } else {
                    context.replaceSnackbar(
                      content: Text(
                        tr('patterns_do_not_match'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                    setState(() {
                      pattern = null;
                      isConfirm = false;
                    });
                  }
                } else {
                  setState(() {
                    pattern = input;
                    isConfirm = true;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _export(String password, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(prefs
        .getKeys()
        .fold<Map<String, dynamic>>(
            <String, dynamic>{},
            (Map<String, dynamic> map, String key) =>
                <String, dynamic>{...map, key: prefs.get(key)}));
    final Uint8List plainText = Uint8List.fromList(utf8.encode(jsonString));

    final encrypt.Key key = encrypt.Key.fromUtf8(password.padRight(32));
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypt.Encrypted encrypted =
        encrypter.encryptBytes(plainText, iv: iv);

    final Map<String, String> jsonData = <String, String>{
      'key': base64Encode(encrypted.bytes)
    };

    final String fileJson = jsonEncode(jsonData);
    final List<int> bytes = utf8.encode(fileJson);

    final Blob blob = html.Blob([bytes]);
    final String url = html.Url.createObjectUrlFromBlob(blob);

    final AnchorElement anchor = html.AnchorElement(href: url);
    anchor.download = 'ginkgo-wallet.json';
    anchor.click();

    if (!mounted) {
      return;
    }
    context.replaceSnackbar(
      content: const Text(
        "HURRA",
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
