import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../ui/logger.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'multi_wallet_transaction_cubit.dart';
import 'transaction.dart';
import 'transaction_state.dart';

part 'transactions_state.dart';

class TransactionsBloc {
  TransactionsBloc({this.pubKey, this.pageSize = 20, required this.isV2}) {
    _onPageRequest.stream
        .flatMap(_fetchTransactionsList)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  final String? pubKey;
  final int pageSize;
  final bool isV2;

  final CompositeSubscription _subscriptions = CompositeSubscription();

  final BehaviorSubject<TransactionsState> _onNewListingStateController =
      BehaviorSubject<TransactionsState>.seeded(
    TransactionsState(),
  );

  Stream<TransactionsState> get onNewListingState =>
      _onNewListingStateController.stream;

  TransactionsState get currentState => _onNewListingStateController.value;

  final StreamController<String?> _onPageRequest = StreamController<String?>();

  Sink<String?> get onPageRequestSink => _onPageRequest.sink;

  final BehaviorSubject<String?> _onSearchInputChangedSubject =
      BehaviorSubject<String?>.seeded(null);

  Sink<String?> get onSearchInputChangedSink =>
      _onSearchInputChangedSubject.sink;

  Stream<TransactionsState> _resetSearch() async* {
    yield TransactionsState();
    yield* _fetchTransactionsList(null); // Always start with null cursor
  }

  Stream<TransactionsState> _fetchTransactionsList(String? pageKey) async* {
    logger(
        '[TransactionsBloc] _fetchTransactionsList START: pageKey=$pageKey, pubKey=$pubKey');
    final TransactionsState lastListingState =
        _onNewListingStateController.value;
    try {
      final MultiWalletTransactionCubit transCubit =
          GetIt.instance<MultiWalletTransactionCubit>();

      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      logger('[TransactionsBloc] isConnected: $isConnected');

      if (!isConnected) {
        logger(
            '[TransactionsBloc] No connection, yielding cached transactions');
        yield TransactionsState(
          itemList: transCubit.transactions(pubKey),
        );
      } else {
        logger('[TransactionsBloc] Fetching transactions from server...');
        final List<Transaction> fetchedItems =
            await transCubit.fetchTransactions(
          cursor: pageKey,
          pageSize: pageSize,
          pubKey: pubKey,
        );

        // For V2 with cursor-based pagination, use hasNextPage flag from API
        // For V1, use the old logic based on item count
        final TransactionState currentState =
            transCubit.currentWalletState(pubKey);
        final bool isLastPage =
            isV2 ? !currentState.hasNextPage : fetchedItems.length < pageSize;

        final String? nextPageKey = isLastPage ? null : currentState.endCursor;

        logger(
            '[TransactionsBloc] Yielding state: items=${fetchedItems.length}, nextPageKey=$nextPageKey, isLastPage=$isLastPage');
        yield TransactionsState(
          nextPageKey: nextPageKey,
          itemList: pageKey == null
              ? fetchedItems
              : <Transaction>[
                  ...lastListingState.itemList ?? <Transaction>[],
                  ...fetchedItems
                ],
        );
        logger('[TransactionsBloc] State yielded successfully');
      }
    } catch (e) {
      logger('[TransactionsBloc] ERROR: $e');
      yield TransactionsState(
        error: e,
        nextPageKey: lastListingState.nextPageKey,
        itemList: lastListingState.itemList,
      );
    }
  }

  void dispose() {
    _onSearchInputChangedSubject.close();
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }
}
