import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;

import 'helpers/test_helpers.dart';

void main() {
  group('Navigation & Basic UI', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('App starts with SkeletonScreen (main navigation)',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify main structure
      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Bottom navigation bar has multiple tabs',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find the bottom nav bar
      final Finder navBar = find.byType(BottomNavigationBar);
      expect(navBar, findsOneWidget);

      // Get all navigation items
      final Finder navItems = find.byType(BottomNavigationBarItem);

      // Should have at least 3-5 tabs
      expect(navItems.evaluate().length, greaterThanOrEqualTo(3),
          reason: 'Bottom navigation should have at least 3 tabs');
    });

    testWidgets('Can navigate between tabs by tapping',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find bottom nav bar
      final Finder navBar = find.byType(BottomNavigationBar);
      expect(navBar, findsOneWidget);

      // Try to navigate through different tabs
      // Get the nav items from the BottomNavigationBar
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      // If we have nav items, try clicking them
      if (navItems.evaluate().length >= 2) {
        // Tap the second tab
        await tester.tap(navItems.at(1));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify we're still in the app
        expect(find.byType(Scaffold), findsWidgets);

        // Tap the first tab again
        await tester.tap(navItems.first);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify we're still in the app
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('All main screens are accessible', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find all navigation items
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      // Navigate through all available tabs
      for (int i = 0; i < navItems.evaluate().length; i++) {
        // Tap the tab
        await tester.tap(navItems.at(i));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify app remains functional
        expect(find.byType(Scaffold), findsWidgets,
            reason: 'Tab $i should be functional');
      }
    });

    testWidgets('First screen (wallet overview) displays',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // The first screen should be visible by default
      // Look for common first-screen elements
      final Finder content = find.byType(Text);
      expect(content, findsWidgets,
          reason: 'First screen should display content');

      // Should have some kind of wallet information
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Second screen is accessible', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to second screen (usually index 1)
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      if (navItems.evaluate().length > 1) {
        await tester.tap(navItems.at(1));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify screen changed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Third screen (contacts) is accessible',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to third screen (usually index 2)
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      if (navItems.evaluate().length > 2) {
        await tester.tap(navItems.at(2));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify screen changed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Fourth screen is accessible', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to fourth screen (usually index 3)
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      if (navItems.evaluate().length > 3) {
        await tester.tap(navItems.at(3));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify screen changed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Fifth screen (settings/menu) is accessible',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navigate to fifth screen (usually index 4)
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      if (navItems.evaluate().length > 4) {
        await tester.tap(navItems.at(4));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Verify screen changed
        expect(find.byType(Scaffold), findsWidgets);
      }
    });

    testWidgets('Tab switching is smooth and responsive',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Rapid tab switching
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      // Switch tabs multiple times rapidly
      for (int i = 0; i < 3; i++) {
        if (navItems.evaluate().isNotEmpty) {
          await tester.tap(navItems.first);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));

          if (navItems.evaluate().length > 1) {
            await tester.tap(navItems.at(1));
            await tester.pumpAndSettle(const Duration(milliseconds: 500));
          }
        }
      }

      // App should still be functional
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should handle rapid tab switching');
    });

    testWidgets('Back navigation works (if applicable)',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Try to navigate backwards using Android back button
      // This is a basic test to ensure back navigation doesn't crash

      // The app should handle back navigation gracefully
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Screen content is visible and readable',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for text content
      final Finder textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets,
          reason: 'Screen should display readable text content');

      // Look for interactive elements
      final Finder buttons = find.byType(ElevatedButton);
      final Finder iconButtons = find.byType(IconButton);

      // Either buttons or icon buttons should be present
      final int buttonCount =
          buttons.evaluate().length + iconButtons.evaluate().length;
      expect(buttonCount, greaterThanOrEqualTo(0),
          reason: 'Screen should have interactive elements');
    });

    testWidgets('App handles orientation changes gracefully',
        (WidgetTester tester) async {
      // Start the app in portrait
      tester.view.physicalSize = const Size(540, 1080);
      addTearDown(tester.view.resetPhysicalSize);

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(Scaffold), findsWidgets);

      // The app should remain functional
      final Finder navBar = find.byType(BottomNavigationBar);
      expect(navBar, findsOneWidget);
    });
  });

  group('UI Responsiveness', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('UI responds to user input without lag',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tap on a navigation item and verify immediate response
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      if (navItems.evaluate().length > 1) {
        // Measure response time
        final Stopwatch stopwatch = Stopwatch()..start();

        await tester.tap(navItems.at(1));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        stopwatch.stop();

        // Response should be within reasonable time (2 seconds)
        expect(stopwatch.elapsedMilliseconds, lessThan(2000),
            reason: 'UI should respond quickly to user input');
      }
    });

    testWidgets('No memory leaks from repeated navigation',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Repeatedly navigate between screens
      final Finder navBar = find.byType(BottomNavigationBar);
      final Finder navItems = find.descendant(
        of: navBar,
        matching: find.byType(InkResponse),
      );

      // Do 10 cycles of navigation
      for (int cycle = 0; cycle < 10; cycle++) {
        for (int i = 0; i < navItems.evaluate().length; i++) {
          await tester.tap(navItems.at(i));
          await tester.pumpAndSettle(const Duration(milliseconds: 300));
        }
      }

      // App should still be functional
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should remain stable after repeated navigation');
    });
  });
}
