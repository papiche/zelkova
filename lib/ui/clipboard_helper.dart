import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/models/stored_account.dart';
import '../shared_prefs_helper.dart';
import 'logger.dart';
import 'pattern_util.dart';

Future<void> copyPublicKeyToClipboard(BuildContext context,
    [String? uri, String? feedbackText]) async {
  final StoredAccount account = SharedPreferencesHelper().getCurrentAccount();
  final String textToCopy = uri ??
      (account.type.isV2
          ? account.address
          : SharedPreferencesHelper().getPubKey());
  await Clipboard.setData(ClipboardData(text: textToCopy));
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(feedbackText ?? 'key_copied_to_clipboard'))));
  }
}

Future<void> copyToClipboard(
    {required BuildContext context,
    required String text,
    required String feedbackText}) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(tr(feedbackText))));
  }
}

Future<void> copyFileToClipboard(
    {required BuildContext context,
    required String fileJson,
    required String feedbackText}) async {
  await Clipboard.setData(ClipboardData(text: fileJson));
  if (context.mounted) {
    context.replaceSnackbar(
      content: Text(
        feedbackText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

Future<void> pasteFromClipboard({required Function(String?) onPaste}) async {
  loggerDev('Starting pasteFromClipboard');
  try {
    loggerDev('Reading from clipboard...');
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    final String? text = data?.text;
    final String preview = text != null
        ? (text.length > 50 ? text.substring(0, 50) : text)
        : 'null';
    loggerDev('Clipboard text obtained: $preview...');
    onPaste(text);
  } catch (e, st) {
    loggerDev('Error reading from clipboard: $e', error: e, stackTrace: st);
    onPaste(null);
  }
}
