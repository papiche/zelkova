import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import 'pattern_util.dart';

enum ExportType { clipboard, file, share }

class ExportDialog extends StatefulWidget {
  const ExportDialog({super.key, required this.type});

  final ExportType type;

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
              selectedColor: selectedPatternLock(),
              notSelectedColor: notSelectedPatternLock(),
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
                    _export(pattern!.join(), context, widget.type);
                  } else {
                    context.replaceSnackbar(
                      content: Text(
                        tr('pattern_do_not_match'),
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

  Future<void> _export(
      String password, BuildContext context, ExportType type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(prefs
        .getKeys()
        .fold<Map<String, dynamic>>(
            <String, dynamic>{},
            (Map<String, dynamic> map, String key) =>
                <String, dynamic>{...map, key: prefs.get(key)}));
    final Map<String, String> jsonData =
        encryptJsonForExport(jsonString, password);
    final String fileJson = jsonEncode(jsonData);
    final List<int> bytes = utf8.encode(fileJson);

    switch (type) {
      case ExportType.clipboard:
        FlutterClipboard.copy(fileJson)
            .then((dynamic value) => context.replaceSnackbar(
                  content: Text(
                    tr('wallet_copied'),
                    style: const TextStyle(color: Colors.red),
                  ),
                ));
        break;
      case ExportType.file:
        if (kIsWeb) {
          webDownload(bytes);
        } else {
          saveFile(bytes);
        }
        if (!context.mounted) {
          return;
        }
        context.replaceSnackbar(
          content: Text(
            tr('wallet_exported'),
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;
      case ExportType.share:
        if (!context.mounted) {
          return;
        }
        shareExport(context, fileJson);
        break;
    }
  }

  Future<void> shareExport(BuildContext context, String fileJson) {
    if (kIsWeb) {
      final Uri uri = Uri.parse(html.window.location.href);
      final String fileJsonUrlComponent = Uri.encodeComponent(fileJson);
      final Uri finalUri = uri.replace(path: '/import/$fileJsonUrlComponent');
      // TODO(vjrj): Allow to import this link
      return Share.share(inDevelopment ? finalUri.toString() : fileJson,
          subject: tr('share_export_subject'));
    } else {
      return Share.share(fileJson, subject: tr('share_export_subject'));
    }
  }

  void webDownload(List<int> bytes) {
    final html.Blob blob = html.Blob(<dynamic>[bytes]);
    final String url = html.Url.createObjectUrlFromBlob(blob);

    final html.AnchorElement anchor = html.AnchorElement(href: url);
    anchor.download =
        'ginkgo-wallet-${simplifyPubKey(SharedPreferencesHelper().getPubKey())}.json';
    anchor.click();
  }

  Future<void> saveFile(List<int> bytes) async {
    try {
      final Directory? externalDirectory =
          await getAppSpecificExternalFilesDirectory(); // ensureDownloadsDirectoryExists();
      if (externalDirectory == null) {
        logger('Downloads directory not found');
        return;
      }
      final String fileName = walletFileName();
      final File file = File(join(externalDirectory.path, fileName));
      await file.writeAsBytes(bytes);

      logger('File saved at: ${file.path}');
    } catch (e, stacktrace) {
      logger('Error saving wallet file $e');
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  Future<void> saveFileApp(List<int> bytesList) async {
    final Uint8List bytes = Uint8List.fromList(bytesList);

    final String fileName = walletFileName();

    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      // 'application/json',
      mimeType: MimeType.json,
    );
  }

  String walletFileName() {
    final String fileName =
        'ginkgo-wallet-${simplifyPubKey(SharedPreferencesHelper().getPubKey())}.json';
    return fileName;
  }
}
