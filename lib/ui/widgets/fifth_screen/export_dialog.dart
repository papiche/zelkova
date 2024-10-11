import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/cesium_card.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../g1/g1_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import 'pattern_util.dart';

enum ExportType { clipboard, file, share }

class ExportDialog extends StatefulWidget {
  const ExportDialog(
      {super.key,
      required this.type,
      required this.wallets,
      required this.exportContacts});

  final ExportType type;
  final List<CesiumCard> wallets;
  final bool exportContacts;

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  bool isConfirm = false;
  List<int>? pattern;

  final GlobalKey<ScaffoldState> _exportKey =
      GlobalKey<ScaffoldState>(debugLabel: 'exportKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _exportKey,
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
    final ContactsCubit cubit = context.read<ContactsCubit>();
    context.read<ContactsCubit>().sortContactsAsStored();
    // Export only selected wallets, not all of them
    final List<Map<String, dynamic>> selectedWallets =
        widget.wallets.map((CesiumCard card) => card.toJson()).toList();
    final Map<String, dynamic> prefsObj = <String, dynamic>{};
    // Add only the selected wallets to prefsObj
    prefsObj['cesiumCards'] = jsonEncode(selectedWallets);
    if (widget.exportContacts && cubit.contacts.isNotEmpty) {
      prefsObj['contacts'] = cubit.contacts.map((Contact c) {
        // ignore: avoid_redundant_argument_values
        final Contact c2 = c.copyWith(avatar: null);
        return c2.toJson();
      }).toList();
    }
    final String jsonString = jsonEncode(prefsObj);

    final Map<String, dynamic> jsonData =
        encryptJsonForExport(jsonString, password);
    loggerDev('Exporting: $jsonData and contacts: ${cubit.contacts.length}');
    final String fileJson = jsonEncode(jsonData);
    final List<int> bytes = utf8.encode(fileJson);

    switch (type) {
      case ExportType.clipboard:
        FlutterClipboard.copy(fileJson).then((dynamic value) {
          if (context.mounted) {
            context.replaceSnackbar(
              content: Text(
                tr('wallet_copied'),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        });
        break;
      case ExportType.file:
        bool result = false;
        if (kIsWeb) {
          webDownload(bytes);
          result = true;
        } else {
          if (!context.mounted) {
            return;
          }
          result = await saveFile(context, bytes);
        }
        if (!context.mounted) {
          return;
        }
        if (result) {
          context.replaceSnackbar(
            content: Text(
              tr('wallet_exported'),
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
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
    anchor.download = getWalletFileName();
    anchor.click();
  }

  Future<bool> saveFile(BuildContext context, List<int> bytes) async {
    try {
      final bool hasPermission = await requestStoragePermission(context);
      if (!hasPermission) {
        return false;
      }

      final Directory? directory = await getGinkgoDownloadDirectory();
      if (directory == null) {
        logger('App files directory not found');
        return false;
      }
      final String fileName = getWalletFileName();
      final File file = File(join(directory.path, fileName));
      await file.writeAsBytes(bytes);
      logger('File saved at: ${file.path}');
      return true;
    } catch (e, stacktrace) {
      logger('Error saving wallet file $e');
      await Sentry.captureException(e, stackTrace: stacktrace);
      return false;
    }
  }

  Future<void> saveFileApp(List<int> bytesList) async {
    final Uint8List bytes = Uint8List.fromList(bytesList);

    final String fileName = getWalletFileName();

    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      // 'application/json',
      mimeType: MimeType.json,
    );
  }

  String getWalletFileName() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMddHHmm').format(now);
    const String baseFileName = 'ginkgo-export';
    return '$baseFileName-$formattedDate.json';
  }
}
