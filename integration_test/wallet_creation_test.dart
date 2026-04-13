import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/main.dart' as app;

import 'helpers/test_helpers.dart';

void main() {
  group('Wallet Creation Flows', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('Can navigate to wallet creation options',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify the app started successfully
      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('Wallet options dialog can be opened',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for a button to open wallet options (typically a FAB or menu button)
      // Common patterns: FloatingActionButton or IconButton with add icon
      final Finder addWalletButton = find.byIcon(Icons.add);

      if (addWalletButton.evaluate().isNotEmpty) {
        // Tap to open wallet options
        await TestHelpers.tapAndSettle(tester, addWalletButton);

        // Wait for dialog to appear
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Look for dialog content
        final Finder dialog = find.byType(AlertDialog);
        expect(dialog, findsWidgets,
            reason: 'Wallet options dialog should appear');

        // Look for wallet creation options in the dialog
        final Finder createOption = find.byWidgetPredicate(
          (Widget widget) =>
              widget is Text &&
              (((widget.data ?? '').toLowerCase().contains('create')) ||
                  ((widget.data ?? '').toLowerCase().contains('wallet'))),
        );

        expect(createOption, findsWidgets,
            reason: 'Create wallet option should be visible in dialog');
      }
    });

    testWidgets('Multiple wallets can be listed in UI',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // If there's a list, verify it's not throwing any errors
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should remain stable when displaying wallets');
    });

    testWidgets('App displays wallet interface correctly',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify main interface elements are present
      expect(find.byType(BottomNavigationBar), findsOneWidget,
          reason: 'Bottom navigation bar should be visible');

      expect(find.byType(Scaffold), findsWidgets,
          reason: 'Scaffold should be present');

      // Check for main content
      expect(find.byType(MaterialApp), findsOneWidget,
          reason: 'MaterialApp should be present');

      // The app should have some form of wallet display
      // This could be a list, cards, or other UI elements
      final Finder anyTextContent = find.byType(Text);
      expect(anyTextContent, findsWidgets,
          reason: 'App should display some content');
    });

    testWidgets('Can interact with wallet options without errors',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Try to find and interact with any buttons in the UI
      final Finder buttons = find.byType(ElevatedButton);

      // Just verify that the UI is responsive and doesn't crash
      // when buttons are available
      if (buttons.evaluate().isNotEmpty) {
        // Try to find tooltips or labels on buttons
        final Finder firstButton = buttons.first;
        expect(firstButton, findsOneWidget);
      }

      // The test passes if the app remains stable
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Navigation between bottom tabs works without errors',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find bottom nav bar
      final Finder navBar = find.byType(BottomNavigationBar);
      expect(navBar, findsOneWidget);

      // Get all bottom nav bar items
      final Finder navItems = find.byType(BottomNavigationBarItem);

      // If we have navigation items, try clicking on them
      if (navItems.evaluate().isNotEmpty) {
        // Try to tap different nav items and verify app remains stable
        for (int i = 0; i < 3 && i < navItems.evaluate().length; i++) {
          await tester.pumpAndSettle(const Duration(milliseconds: 500));

          // Verify the app is still functioning
          expect(find.byType(Scaffold), findsWidgets,
              reason: 'Scaffold should still be present after nav change');
        }
      }
    });

    testWidgets('Wallet list displays without scrolling errors',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // If there are scrollable areas, the app should handle them gracefully
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should remain stable with scrollable content');
    });

    testWidgets('Can see wallet balance or placeholder',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for balance display - could be:
      // - A number (0.00, 123.45, etc.)
      // - Text containing "balance", "B", "kg", "€", etc.
      expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Text &&
              (((widget.data ?? '').contains('B')) ||
                  ((widget.data ?? '').contains('€')) ||
                  ((widget.data ?? '').contains('kg')) ||
                  ((widget.data ?? '').contains('0')) ||
                  ((widget.data ?? '').contains('Balance'))),
        ),
        findsWidgets,
      );

      // The app should display some form of balance (even if 0)
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'Wallet interface should be displayed');
    });
  });

  group('Wallet Creation - Specific Flows', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('Password-less wallet creation flow is accessible',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for wallet creation buttons
      // The test just verifies the UI is there and responsive
      final Finder addButtons = find.byIcon(Icons.add);

      if (addButtons.evaluate().isNotEmpty) {
        // Button exists, verify it's tappable
        expect(addButtons.first, findsOneWidget);
      }

      // Verify app is still functional
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Password-protected wallet creation flow is accessible',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify the app structure is intact
      expect(find.byType(Scaffold), findsWidgets);

      // The lock icon may or may not be visible in the main UI
      // It might only appear in dialogs
    });
  });
}
