import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/app_cubit.dart';
import 'package:zelkova/data/models/transaction.dart';
import 'package:zelkova/ui/widgets/fourth_screen/transactions_list/transactions_list_body.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

// Mock storage for HydratedBloc
class MockStorage implements Storage {
  final Map<String, dynamic> _storage = <String, dynamic>{};

  @override
  dynamic read(String key) => _storage[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  group('TransactionsListBody', () {
    late ScrollController scrollController;
    // Valid base58 public key for testing
    const String testPubKey = '5ocqzyDMMWf1V8bsoNhWb1iNwax1e9M7VTUN6navs8of';
    late AppCubit mockAppCubit;

    // Helper to wrap widget with necessary providers
    Widget wrapWithProviders(Widget child) {
      return Provider<AppCubit>.value(
        value: mockAppCubit,
        child: MaterialApp(
          locale: const Locale('en'),
          supportedLocales: const <Locale>[Locale('en')],
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: Scaffold(body: child),
        ),
      );
    }

    setUp(() {
      // Initialize storage before creating AppCubit
      HydratedBloc.storage = MockStorage();
      scrollController = ScrollController();
      mockAppCubit = AppCubit();
      mockAppCubit.setG1Currency();
    });

    tearDown(() {
      scrollController.dispose();
    });

    testWidgets('renders empty list when no transactions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithProviders(
          TransactionsListBody(
            scrollController: scrollController,
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            isLoadingMore: false,
            hasMorePages: false,
            pubKey: testPubKey,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    // Note: Tests that render actual transactions are not included here
    // because TransactionListItem requires ContactsCubit, database, and other
    // infrastructure that makes them integration tests rather than unit tests.
    // The empty list test above verifies the basic ListView rendering.

    testWidgets('shows loading indicator when loading more',
        (WidgetTester tester) async {
      // Use empty transactions to avoid needing ContactsCubit
      await tester.pumpWidget(
        wrapWithProviders(
          TransactionsListBody(
            scrollController: scrollController,
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            isLoadingMore: true,
            hasMorePages: true,
            pubKey: testPubKey,
          ),
        ),
      );
      // Use pump() instead of pumpAndSettle() because CircularProgressIndicator animates continuously
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not show loading indicator when not loading more',
        (WidgetTester tester) async {
      // Use empty transactions to avoid needing ContactsCubit
      await tester.pumpWidget(
        wrapWithProviders(
          TransactionsListBody(
            scrollController: scrollController,
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            isLoadingMore: false,
            hasMorePages: true,
            pubKey: testPubKey,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('uses NeverScrollableScrollPhysics when scroll disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithProviders(
          TransactionsListBody(
            scrollController: scrollController,
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            isLoadingMore: false,
            hasMorePages: false,
            pubKey: testPubKey,
            isScrollEnabled: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final ListView listView = tester.widget(find.byType(ListView));
      expect(listView.physics, isA<NeverScrollableScrollPhysics>());
    });

    testWidgets('uses AlwaysScrollableScrollPhysics when scroll enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithProviders(
          TransactionsListBody(
            scrollController: scrollController,
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            isLoadingMore: false,
            hasMorePages: false,
            pubKey: testPubKey,
            // isScrollEnabled: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final ListView listView = tester.widget(find.byType(ListView));
      expect(listView.physics, isA<AlwaysScrollableScrollPhysics>());
    });
  });
}
