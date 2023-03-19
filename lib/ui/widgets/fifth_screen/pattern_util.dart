import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void replaceSnackbar({
    required Widget content,
  }) {
    final ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(this);
    scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(content: content),
    );
  }
}
