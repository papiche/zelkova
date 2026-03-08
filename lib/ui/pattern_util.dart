import 'package:flutter/material.dart';

import 'ui_helpers.dart';

extension BuildContextX on BuildContext {
  void replaceSnackbar({
    required Widget content,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 4),
  }) {
    globalMessengerKey.currentState!.removeCurrentSnackBar();
    globalMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
