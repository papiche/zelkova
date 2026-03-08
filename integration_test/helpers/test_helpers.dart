import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/services/derivation_scan_service.dart';

// ignore: avoid_classes_with_only_static_members
/// Helper functions for integration tests
class TestHelpers {
  /// Setup test environment with necessary mocks
  static Future<void> setupTestEnvironment() async {
    // Skip network calls for blockchain scanning
    DerivationScanService.skipNetworkCheck = true;
  }

  /// Clean up after tests
  static Future<void> cleanupTestEnvironment() async {
    // Reset any test-specific settings
    DerivationScanService.skipNetworkCheck = false;
  }

  /// Wait for widget to appear with timeout
  static Future<void> waitForWidget(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final DateTime endTime = DateTime.now().add(timeout);

    while (DateTime.now().isBefore(endTime)) {
      await tester.pumpAndSettle();

      if (finder.evaluate().isNotEmpty) {
        return;
      }

      await Future<void>.delayed(const Duration(milliseconds: 100));
    }

    throw TimeoutException('Widget not found: $finder', timeout);
  }

  /// Tap on a widget and wait for settlement
  static Future<void> tapAndSettle(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Enter text in a field and wait for settlement
  static Future<void> enterTextAndSettle(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Find widget by key
  static Finder findByKey(String key) {
    return find.byKey(ValueKey<String>(key));
  }

  /// Find widget by text containing substring
  static Finder findByTextContaining(String text) {
    return find.byWidgetPredicate(
      (Widget widget) =>
          widget is Text && (widget.data?.contains(text) ?? false),
    );
  }
}
