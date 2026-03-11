import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper to wrap widgets with necessary providers for testing
Widget createTestableWidget(Widget child) {
  return EasyLocalization(
    supportedLocales: const <Locale>[Locale('en'), Locale('es')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

/// Initialize EasyLocalization for tests
Future<void> initializeEasyLocalization() async {
  await EasyLocalization.ensureInitialized();
}
