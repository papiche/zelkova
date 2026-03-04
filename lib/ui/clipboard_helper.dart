import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../data/models/stored_account.dart';
import '../shared_prefs_helper.dart';
import 'logger.dart';
import 'pattern_util.dart';

Future<void> copyPublicKeyToClipboard(BuildContext context,
    [String? uri, String? feedbackText]) async {
  final SystemClipboard? clipboard = SystemClipboard.instance;
  if (clipboard == null) {
    return; // Clipboard API is not supported on this platform.
  }
  final DataWriterItem item = DataWriterItem();
  final StoredAccount account = SharedPreferencesHelper().getCurrentAccount();
  final String textToCopy = uri ??
      (account.type.isV2
          ? account.address
          : SharedPreferencesHelper().getPubKey());
  item.add(Formats.plainText(textToCopy));
  await clipboard.write(<DataWriterItem>[item]);
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(feedbackText ?? 'key_copied_to_clipboard'))));
  }
}

Future<void> copyToClipboard(
    {required BuildContext context,
    required String text,
    required String feedbackText}) async {
  final SystemClipboard? clipboard = SystemClipboard.instance;
  if (clipboard == null) {
    return; // Clipboard API is not supported on this platform.
  }
  final DataWriterItem item = DataWriterItem();
  item.add(Formats.plainText(text));
  await clipboard.write(<DataWriterItem>[item]);
  if (context.mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(tr(feedbackText))));
  }
}

Future<void> copyFileToClipboard(
    {required BuildContext context,
    required String fileJson,
    required String feedbackText}) async {
  final SystemClipboard? clipboard = SystemClipboard.instance;
  if (clipboard == null) {
    return; // Clipboard API is not supported on this platform.
  }
  final DataWriterItem item = DataWriterItem();
  item.add(Formats.plainText(fileJson));
  await clipboard.write(<DataWriterItem>[item]);
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
  final SystemClipboard? clipboard = SystemClipboard.instance;
  if (clipboard != null) {
    try {
      loggerDev('Reading from clipboard...');
      final ClipboardReader reader = await clipboard.read();
      loggerDev(
          'Clipboard reader obtained, items count: ${reader.items.length}');
      final ClipboardDataReader? item = reader.items.firstOrNull;
      if (item != null) {
        loggerDev('Reading clipboard item as plain text...');
        final String? text = await item.readValue(Formats.plainText);
        final String preview = text != null
            ? (text.length > 50 ? text.substring(0, 50) : text)
            : 'null';
        loggerDev('Clipboard text obtained: $preview...');
        onPaste(text);
      } else {
        loggerDev('No items in clipboard');
        onPaste(null);
      }
    } catch (e, st) {
      loggerDev('Error reading from clipboard: $e', error: e, stackTrace: st);
      onPaste(null);
    }
  } else {
    loggerDev('SystemClipboard not available');
    onPaste(null);
  }
}
