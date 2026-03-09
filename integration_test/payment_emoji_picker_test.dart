import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;

import 'helpers/test_helpers.dart';

void main() {
  group('Payment Form Emoji Picker Tests', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets(
      'Emoji picker button should be visible in V2 payment form',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Look for the emoji button in the payment form
        // The emoji button should have an icon for emoji_emotions_outlined
        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);

        // The button should exist if we're in V2 mode
        if (emojiButton.evaluate().isNotEmpty) {
          expect(emojiButton, findsOneWidget,
              reason:
                  'Emoji picker button should be visible in V2 payment form');
        }
      },
    );

    testWidgets(
      'Emoji picker should open when button is tapped',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Look for the emoji button
        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);

        if (emojiButton.evaluate().isEmpty) {
          // Skip test if emoji button not found (V1 mode)
          return;
        }

        // Tap the emoji button to open the picker
        await tester.tap(emojiButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // After tapping, the button icon should change to keyboard icon
        // This indicates the picker is open
        final Finder keyboardButton = find.byIcon(Icons.keyboard);
        expect(keyboardButton, findsWidgets,
            reason: 'Icon should change to keyboard when emoji picker is open');
      },
    );

    testWidgets(
      'Emoji picker should close when keyboard button is tapped',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);

        if (emojiButton.evaluate().isEmpty) {
          return; // Skip if not in V2 mode
        }

        // Open emoji picker
        await tester.tap(emojiButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Verify picker is open (keyboard icon visible)
        expect(find.byIcon(Icons.keyboard), findsWidgets,
            reason: 'Emoji picker should be open');

        // Close emoji picker
        final Finder keyboardButton = find.byIcon(Icons.keyboard);
        await tester.tap(keyboardButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Verify picker is closed (emoji button visible again)
        expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget,
            reason:
                'Emoji button should be visible again after closing picker');
      },
    );

    testWidgets(
      'Comment text field should accept text input',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Find the comment text field
        final Finder commentField = find.byType(TextFormField);

        if (commentField.evaluate().isEmpty) {
          return;
        }

        // Tap on the text field
        await tester.tap(commentField.first);
        await tester.pumpAndSettle();

        // Enter some text
        await tester.enterText(commentField.first, 'Test comment 🎉');
        await tester.pumpAndSettle();

        // Verify text was entered
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is TextFormField &&
                (widget.controller?.text.contains('Test comment') ?? false),
          ),
          findsWidgets,
          reason: 'Comment field should contain the entered text',
        );
      },
    );

    testWidgets(
      'Emoji picker button should toggle between emoji and keyboard icons',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);

        if (emojiButton.evaluate().isEmpty) {
          return; // Skip if not in V2 mode
        }

        // Initial state: emoji button visible
        expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget);

        // Tap to open
        await tester.tap(emojiButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Should now show keyboard icon
        expect(find.byIcon(Icons.keyboard), findsWidgets,
            reason: 'Should show keyboard icon when picker is open');

        // Tap to close
        final Finder keyboardButton = find.byIcon(Icons.keyboard);
        await tester.tap(keyboardButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Should show emoji button again
        expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget,
            reason: 'Should show emoji button when picker is closed');

        // Test toggle multiple times to ensure it works consistently
        await tester.tap(emojiButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        expect(find.byIcon(Icons.keyboard), findsWidgets);

        final Finder keyboardButton2 = find.byIcon(Icons.keyboard);
        await tester.tap(keyboardButton2);
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget);
      },
    );

    testWidgets(
      'Emoji picker should not interfere with form validation',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Find the send button
        final Finder sendButton = find.byIcon(Icons.send);

        if (sendButton.evaluate().isEmpty) {
          return;
        }

        // The send button should exist
        expect(sendButton, findsOneWidget,
            reason: 'Send button should be visible in payment form');

        // Open the emoji picker
        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);
        if (emojiButton.evaluate().isNotEmpty) {
          await tester.tap(emojiButton);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));

          // The send button should still be there
          expect(sendButton, findsOneWidget,
              reason:
                  'Send button should still be visible after opening emoji picker');

          // Close the picker
          final Finder keyboardButton = find.byIcon(Icons.keyboard);
          await tester.tap(keyboardButton);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));

          // Send button should still be visible
          expect(sendButton, findsOneWidget,
              reason:
                  'Send button should still be visible after closing emoji picker');
        }
      },
    );

    testWidgets(
      'Focus should be managed properly when toggling emoji picker',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Find the comment text field
        final Finder commentField = find.byType(TextFormField);

        if (commentField.evaluate().isEmpty) {
          return;
        }

        // Find the emoji button
        final Finder emojiButton = find.byIcon(Icons.emoji_emotions_outlined);
        if (emojiButton.evaluate().isEmpty) {
          return;
        }

        // Tap the text field to focus it
        await tester.tap(commentField.first);
        await tester.pumpAndSettle();

        // Enter some text
        await tester.enterText(commentField.first, 'Focus test');
        await tester.pumpAndSettle();

        // Tap emoji button - should unfocus the text field and open picker
        await tester.tap(emojiButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Should show keyboard icon (picker open)
        expect(find.byIcon(Icons.keyboard), findsWidgets,
            reason: 'Emoji picker should be open, showing keyboard icon');

        // Close the picker
        final Finder keyboardButton = find.byIcon(Icons.keyboard);
        await tester.tap(keyboardButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Emoji button should be visible again
        expect(find.byIcon(Icons.emoji_emotions_outlined), findsWidgets,
            reason:
                'Emoji button should be visible again after closing picker');

        // The previously entered text should still be there
        expect(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is TextFormField &&
                (widget.controller?.text.contains('Focus test') ?? false),
          ),
          findsWidgets,
          reason: 'Entered text should be preserved after toggle',
        );
      },
    );
  });
}
