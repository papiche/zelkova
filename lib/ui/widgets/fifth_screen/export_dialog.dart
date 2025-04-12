import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/legacy_wallet.dart';
import '../../../g1/g1_export_auth_utils.dart';
import '../../../g1/g1_helper.dart';
import '../../clipboard_helper.dart';
import '../../in_dev_helper.dart';
import '../../logger.dart';
import '../../pattern_util.dart';
import '../../ui_helpers.dart';

enum ExportType { clipboard, file, share, pubsec, wif, ewif }

class ExportDialog extends StatefulWidget {
  const ExportDialog({
    super.key,
    required this.type,
    required this.wallets,
    required this.exportContacts,
  });

  final ExportType type;
  final List<LegacyWallet> wallets;
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
    final bool requiresPattern = _requiresPattern(widget.type);

    return Scaffold(
      key: _exportKey,
      appBar: AppBar(
        title:
            requiresPattern ? Text(tr('intro_some_pattern_to_export')) : null,
      ),
      body: requiresPattern
          ? _buildPatternLockScreen(context)
          : widget.type == ExportType.ewif
              ? _buildPasswordScreen(context)
              : _executeExportDirectly(context),
    );
  }

  Widget _buildPatternLockScreen(BuildContext context) {
    return Column(
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
    );
  }

  Widget _buildPasswordScreen(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(tr('ewif_intro')),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: tr('enter_a_password'),
            ),
          ),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: tr('confirm_password'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final String password = passwordController.text;
              final String confirmPassword = confirmPasswordController.text;

              if (password != confirmPassword) {
                context.replaceSnackbar(
                  content: Text(
                    tr('passwords_do_not_match'),
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                Navigator.of(context).pop();
                _export(password, context, widget.type);
              }
            },
            child: Text(tr('export')),
          ),
        ],
      ),
    );
  }

  Widget _executeExportDirectly(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _export('', context, widget.type);
    });
    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _export(
      String password, BuildContext context, ExportType type) async {
    final ContactsCubit cubit = context.read<ContactsCubit>();
    context.read<ContactsCubit>().sortContactsAsStored();
    // Export only selected wallets, not all of them
    final List<Map<String, dynamic>> selectedWallets =
        widget.wallets.map((LegacyWallet card) => card.toJson()).toList();
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
        copyFileToClipboard(
          context: context,
          fileJson: fileJson,
          feedbackText: tr('wallet_copied'),
        );
        break;
      case ExportType.file:
        bool result = false;
        if (kIsWeb) {
          _webFileDownload(bytes);
          result = true;
        } else {
          if (!context.mounted) {
            return;
          }
          result = await _saveFileNonWeb(context, bytes);
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
      case ExportType.pubsec:
        await _saveSpecialFile(context, generatePubSecFile, type);
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop();
        break;
      case ExportType.wif:
        await _saveSpecialFile(context, generateWifFile, type);
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop();
        break;
      case ExportType.ewif:
        await _saveSpecialFile(context, generateEwifFile, type,
            password: password);
        break;
    }
  }

  bool _requiresPattern(ExportType type) {
    return type == ExportType.clipboard ||
        type == ExportType.file ||
        type == ExportType.share;
  }

  Future<void> _saveSpecialFile(
    BuildContext context,
    Map<String, String> Function(String, String) generateFile,
    ExportType type, {
    String? password,
  }) async {
    final CesiumWallet wallet = _getFirstWallet();
    final String pubKey = wallet.pubkey;
    final String privKey =
        password != null ? generateEwif(wallet, password) : getPrivKey(wallet);

    final Map<String, String> fileResult = generateFile(pubKey, privKey);
    final String fileName = fileResult.keys.first;
    final String content = fileResult.values.first;
    bool result = false;
    if (kIsWeb) {
      _webFileDownload(utf8.encode(content), fileName);
      result = true;
    } else {
      result = await _saveFileNonWeb(context, utf8.encode(content), fileName);
    }
    if (context.mounted && result) {
      await _qrSave(context, content, fileName);
      if (!context.mounted) {
        return;
      }
      context.replaceSnackbar(
        content: Text(
          tr('wallet_exported'),
          style: const TextStyle(color: Colors.green),
        ),
      );
    }
  }

  CesiumWallet _getFirstWallet() {
    final LegacyWallet card = widget.wallets.first;
    final CesiumWallet wallet =
        CesiumWallet.fromSeed(seedFromString(card.seed));
    return wallet;
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

  void _webFileDownload(List<int> bytes, [String? fileNameArg]) {
    final html.Blob blob = html.Blob(<dynamic>[bytes]);
    final String url = html.Url.createObjectUrlFromBlob(blob);

    final html.AnchorElement anchor = html.AnchorElement(href: url);
    anchor.download = fileNameArg ?? getWalletFileName();
    anchor.click();
  }

  Future<bool> _saveFileNonWeb(BuildContext context, List<int> bytes,
      [String? fileNameArg]) async {
    try {
      final bool hasPermission = await requestStoragePermission(context);
      if (!hasPermission) {
        return false;
      }

      final Directory? directory = await getGinkgoDownloadDirectory();
      if (directory == null) {
        loggerDev('App files directory not found');
        return false;
      }
      final String fileName = fileNameArg ?? getWalletFileName();
      final File file = File(join(directory.path, fileName));
      await file.writeAsBytes(bytes);
      loggerDev('File saved at: ${file.path}');
      return true;
    } catch (e, stacktrace) {
      loggerDev('Error saving wallet file $e');
      await Sentry.captureException(e, stackTrace: stacktrace);
      return false;
    }
  }

  String getWalletFileName() {
    final DateTime now = DateTime.now();
    final String formattedDate = todayS(now);
    const String baseFileName = 'ginkgo-export';
    return '$baseFileName-$formattedDate.json';
  }

  Future<void> _qrSave(
      BuildContext context, String content, String filename) async {
    try {
      final String qrFileName = '${filename.split('.').first}_qr.png';

      final Widget qrPainter = Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: QrImageView(data: content)));
      final ScreenshotController screenshotController = ScreenshotController();
      try {
        final Uint8List imageBytes =
            await screenshotController.captureFromWidget(qrPainter);
        if (!context.mounted) {
          return;
        }
        if (kIsWeb) {
          _webFileDownload(imageBytes, qrFileName);
        } else {
          await _saveFileNonWeb(context, imageBytes, qrFileName);
        }
      } catch (e) {
        loggerDev('Error saving QR code: $e');
      }
    } catch (e) {
      loggerDev('Error saving QR code: $e');
    }
  }
}
