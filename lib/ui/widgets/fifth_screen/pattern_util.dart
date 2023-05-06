import 'package:flutter/material.dart';

import '../../ui_helpers.dart';

extension BuildContextX on BuildContext {
  void replaceSnackbar({required Widget content}) {
    globalMessengerKey.currentState!.removeCurrentSnackBar();
    globalMessengerKey.currentState!.showSnackBar(
      SnackBar(content: content),
    );
  }
}
