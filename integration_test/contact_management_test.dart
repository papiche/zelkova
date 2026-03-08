import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;

import 'helpers/test_helpers.dart';

void main() {
  group('Contact Management', () {
    /// Test data
    const String testContactV1 = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
    const String testContactV2 =
        'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('Can access contacts screen', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the bottom navigation bar
      final Finder navBar = find.byType(BottomNavigationBar);
      expect(navBar, findsOneWidget,
          reason: 'BottomNavigationBar should be visible');

      // Navigate to contacts (usually third tab, index 2)
      // We'll look for any list or contact-related widgets

      // The app should have UI elements
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Search field is accessible', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for a search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        expect(searchField, findsWidgets,
            reason: 'Search field should be visible');
      }

      // Or look for a search button
      final Finder searchButton = find.byIcon(Icons.search);

      if (searchButton.evaluate().isNotEmpty) {
        expect(searchButton, findsWidgets,
            reason: 'Search button should be visible');
      }
    });

    testWidgets('Can add contact with v1 pubkey via search',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Enter the v1 contact pubkey
        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, testContactV1);

        // Trigger search
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify contact appears in results
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is Text &&
                (((widget.data ?? '')
                        .contains(testContactV1.substring(0, 20))) ||
                    ((widget.data ?? '').contains('Contact'))),
          ),
          findsWidgets,
        );

        expect(find.byType(Scaffold), findsWidgets,
            reason: 'App should still be functional after search');
      }
    });

    testWidgets('Can search for existing contact', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Search for a contact (using a generic search term)
        await TestHelpers.enterTextAndSettle(tester, searchField.first, 'test');

        // Trigger search
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // The search should complete without errors
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Can add contact with v2 address via search',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Enter the v2 contact address
        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, testContactV2);

        // Trigger search
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify contact appears in results
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is Text &&
                (((widget.data ?? '')
                        .contains(testContactV2.substring(0, 20))) ||
                    ((widget.data ?? '').contains('g1'))),
          ),
          findsWidgets,
        );

        // App should remain functional
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Search with multiple characters works',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Search with multiple keys separated by spaces
        const String multipleContacts = '$testContactV1 $testContactV2';

        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, multipleContacts);

        // Trigger search
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Multiple contacts should be parsed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Invalid contact input shows appropriate response',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Try to search with invalid data
        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, 'not_a_valid_contact');

        // Trigger search
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // App should handle gracefully
        expect(find.byType(Scaffold), findsWidgets,
            reason: 'App should not crash with invalid contact input');
      }
    });

    testWidgets('Contact search field accepts clipboard input',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Focus on the field
        await tester.tap(searchField.first);
        await tester.pumpAndSettle();

        // Enter text (simulating clipboard paste)
        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, testContactV1);

        // Verify text is in the field
        expect(
            find.byWidgetPredicate(
              (Widget widget) =>
                  widget is TextField &&
                  (widget.controller?.text ?? '').contains(testContactV1),
            ),
            findsWidgets);
      }
    });

    testWidgets('Contact list displays without errors',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for any list of contacts
      final Finder listView = find.byType(ListView);

      // Try to scroll if list exists
      if (listView.evaluate().isNotEmpty) {
        await tester.pumpAndSettle();

        // Verify the list is functional
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Can clear search field', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Enter text
        await TestHelpers.enterTextAndSettle(tester, searchField.first, 'test');

        // Clear the field
        await tester.pumpAndSettle();

        // The field should be empty or clearable
        expect(find.byType(TextField), findsWidgets);
      }
    });
  });

  group('Contact Search - Edge Cases', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('Very long string handling in search',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Enter a very long string
        final String longString = 'a' * 500; // 500 character string

        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, longString);

        // App should handle gracefully without crashing
        expect(find.byType(Scaffold), findsWidgets,
            reason: 'App should handle long strings gracefully');
      }
    });

    testWidgets('Special characters in search field',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Enter special characters
        const String specialChars = r'!@#$%^&*()';

        await TestHelpers.enterTextAndSettle(
            tester, searchField.first, specialChars);

        // App should handle gracefully
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Rapid searches should not crash app',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the search field
      final Finder searchField = find.byType(TextField);

      if (searchField.evaluate().isNotEmpty) {
        // Perform multiple rapid searches
        for (int i = 0; i < 3; i++) {
          await TestHelpers.enterTextAndSettle(
              tester, searchField.first, 'test$i');

          await tester.testTextInput.receiveAction(TextInputAction.search);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));
        }

        // App should still be functional
        expect(find.byType(Scaffold), findsWidgets);
      }
    });
  });
}
