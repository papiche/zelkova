import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared_prefs_helper.dart';
import 'pattern_util.dart';

void copyPublicKeyToClipboard(BuildContext context,
    [String? uri, String? feedbackText]) {
  FlutterClipboard.copy(uri ?? SharedPreferencesHelper().getPubKey())
      .then((dynamic value) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr(feedbackText ?? 'key_copied_to_clipboard'))));
    }
  });
}

void copyToClipboard(
    {required BuildContext context,
    required String uri,
    required String feedbackText}) {
  FlutterClipboard.copy(uri).then((dynamic value) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr(feedbackText))));
    }
  });
}

void copyFileToClipboard(
    {required BuildContext context,
    required String fileJson,
    required String feedbackText}) {
  FlutterClipboard.copy(fileJson).then((dynamic value) {
    if (context.mounted) {
      context.replaceSnackbar(
        content: Text(
          feedbackText,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
  });
}

Future<void> pasteFromClipboard({required Function(String?) onPaste}) async {
  FlutterClipboard.paste().then((String? value) {
    onPaste(value);
  });
}
