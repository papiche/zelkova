import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/ui/widgets/fourth_screen/transactions_list/transactions_list_error.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      supportedLocales: const <Locale>[Locale('en')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: Scaffold(body: child),
    );
  }

  group('TransactionsListError', () {
    testWidgets('displays error message', (WidgetTester tester) async {
      const String errorMessage = 'Network connection failed';

      await tester.pumpWidget(
        createTestWidget(
          TransactionsListError(
            error: errorMessage,
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The widget shows the error message
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('displays error icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          TransactionsListError(
            error: 'Error',
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays retry button when error is present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          TransactionsListError(
            error: 'Error',
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check for retry button icon
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      // Check that there's a button-like widget (Material button)
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('does not display retry button when error is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const TransactionsListError(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.refresh), findsNothing);
    });

    testWidgets('does not display retry button when error is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const TransactionsListError(
            error: '',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.refresh), findsNothing);
    });

    testWidgets('does not display error text when error is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const TransactionsListError(),
        ),
      );
      await tester.pumpAndSettle();

      // Should only show the error icon and title, not the error message
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      // Error message text should not be visible (only title)
      final Iterable<Text> textWidgets =
          tester.widgetList<Text>(find.byType(Text));
      // Should have only one Text widget (the title)
      expect(textWidgets.length, equals(1));
    });

    testWidgets('calls onRetry when retry button is tapped',
        (WidgetTester tester) async {
      bool retryCalled = false;

      await tester.pumpWidget(
        createTestWidget(
          TransactionsListError(
            error: 'Error',
            onRetry: () {
              retryCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap on the button area (using the refresh icon to find it)
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      expect(retryCalled, isTrue);
    });

    testWidgets('displays long error messages correctly',
        (WidgetTester tester) async {
      const String longError =
          'This is a very long error message that should wrap correctly '
          'and display properly within the error widget without causing '
          'any layout overflow issues.';

      await tester.pumpWidget(
        createTestWidget(
          TransactionsListError(
            error: longError,
            onRetry: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(longError), findsOneWidget);
    });
  });
}
