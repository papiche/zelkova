import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/ui/widgets/fourth_screen/transactions_list/transactions_list_empty.dart';

void main() {
  group('TransactionsListEmpty', () {
    testWidgets('displays empty state message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsListEmpty(
              onRefresh: () async {},
            ),
          ),
        ),
      );

      // Check that the widget renders with a Text widget (translation key)
      expect(find.byType(Text), findsAtLeastNWidgets(1));
    });

    testWidgets('displays empty state icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsListEmpty(
              onRefresh: () async {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);
    });

    testWidgets('has RefreshIndicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsListEmpty(
              onRefresh: () async {},
            ),
          ),
        ),
      );

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('calls onRefresh when pulled down',
        (WidgetTester tester) async {
      bool refreshCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsListEmpty(
              onRefresh: () async {
                refreshCalled = true;
              },
            ),
          ),
        ),
      );

      // Simulate pull to refresh
      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, 300),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(refreshCalled, isTrue);
    });

    testWidgets('is scrollable for pull-to-refresh',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionsListEmpty(
              onRefresh: () async {},
            ),
          ),
        ),
      );

      final CustomScrollView scrollView =
          tester.widget(find.byType(CustomScrollView));
      expect(scrollView.physics, isA<AlwaysScrollableScrollPhysics>());
    });
  });
}
