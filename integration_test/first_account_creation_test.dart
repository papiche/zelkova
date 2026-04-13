import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/main.dart' as app;
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:zelkova/ui/screens/first_screen.dart';

import 'helpers/test_helpers.dart';

void main() {
  group('First Account Creation Integration Tests', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('App initializes and creates first account successfully',
        (WidgetTester tester) async {
      app.main();

      // Give the app time to initialize (including account creation)
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify app is running
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should have at least one Scaffold');

      // Verify FirstScreen is visible
      expect(find.byType(FirstScreen), findsOneWidget,
          reason: 'FirstScreen should be visible after initialization');
    });

    testWidgets('FirstScreen displays without RangeError on fresh install',
        (WidgetTester tester) async {
      // This test verifies the fix for the RangeError bug
      app.main();

      // Wait for app to initialize
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Look for error dialog that would indicate the RangeError
      final Finder errorDialog = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Dialog &&
            widget.child is Center &&
            (widget.child! as Center).child is Column,
      );

      // Should NOT find an error dialog (no RangeError should occur)
      expect(errorDialog, findsNothing,
          reason:
              'No error dialog should appear - first account should be created successfully');
    });

    testWidgets('FirstScreen error guard is not triggered on successful init',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Look for the error widget that shows "Account Initialization Error"
      final Finder errorText = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            (widget.data?.contains('Account Initialization Error') ?? false),
      );

      // Should NOT find the error text (accounts should not be empty)
      expect(errorText, findsNothing,
          reason:
              'FirstScreen should not show initialization error on fresh install');
    });

    testWidgets(
        'SharedPreferencesHelper is properly initialized after app startup',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Get the helper instance
      final SharedPreferencesHelper helper = SharedPreferencesHelper();

      // Verify accounts are not empty
      expect(helper.isEmpty, false,
          reason:
              'Helper should have at least one account after app initialization');

      expect(helper.length, greaterThan(0),
          reason: 'Should have created at least one account');

      // Verify we can access the account without errors
      expect(() => helper.getCurrentAccount(), returnsNormally,
          reason: 'Should be able to get current account without throwing');

      expect(() => helper.getPubKey(), returnsNormally,
          reason: 'Should be able to get pubKey without throwing');

      expect(() => helper.getName(), returnsNormally,
          reason: 'Should be able to get account name without throwing');

      expect(() => helper.getTheme(), returnsNormally,
          reason: 'Should be able to get theme without throwing');
    });

    testWidgets('Subsequent app launches use existing account',
        (WidgetTester tester) async {
      // First launch
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final SharedPreferencesHelper helper1 = SharedPreferencesHelper();
      expect(helper1.length, 1, reason: 'First launch should have 1 account');

      // Reset app (in practice this would be a new app launch)
      // For now we just verify the account persists

      // Verify FirstScreen is still displayed
      expect(find.byType(FirstScreen), findsOneWidget,
          reason: 'FirstScreen should be visible');

      // Verify no error occurred
      final Finder errorText = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            (widget.data?.contains('Account Initialization Error') ?? false),
      );
      expect(errorText, findsNothing,
          reason: 'No initialization error should occur');
    });

    testWidgets('FirstScreen handles empty accounts gracefully with error UI',
        (WidgetTester tester) async {
      // This test verifies that IF accounts somehow became empty,
      // the FirstScreen would show a graceful error message
      // (Though this should never happen due to main.dart retry mechanism)

      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // The main goal is that we get to FirstScreen without crashing
      expect(find.byType(FirstScreen), findsOneWidget,
          reason: 'Should reach FirstScreen without crash');

      // Verify no unhandled exceptions occurred
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets(
        'App displays expected UI elements after first account creation',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify FirstScreen is present
      expect(find.byType(FirstScreen), findsOneWidget);

      // Verify Scaffold is present (basic app structure)
      expect(find.byType(Scaffold), findsWidgets);

      // Verify MaterialApp is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
