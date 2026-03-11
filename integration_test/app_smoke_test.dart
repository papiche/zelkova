import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;
import 'helpers/test_helpers.dart';

void main() {
  group('App Smoke Tests', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('app starts successfully', (WidgetTester tester) async {
      // Start the app
      app.main();

      // Give the app time to initialize
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify app is running by checking for common app elements
      // Look for the main app structure (Scaffold, etc)
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should have at least one Scaffold');
    });

    testWidgets('app has navigation structure', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify the app has some widgets rendered
      expect(find.byType(MaterialApp), findsOneWidget,
          reason: 'App should have MaterialApp');
    });
  });
}
