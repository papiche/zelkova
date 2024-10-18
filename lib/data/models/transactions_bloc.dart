import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../ui/logger.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'multi_wallet_transaction_cubit.dart';
import 'transaction.dart';

part 'transactions_state.dart';

class TransactionsBloc {
  TransactionsBloc({this.isExternal = false, this.pubKey, this.pageSize = 20}) {
    _onPageRequest.stream
        .flatMap(_fetchTransactionsList)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  final bool isExternal;
  final String? pubKey;
  final int pageSize;

  final CompositeSubscription _subscriptions = CompositeSubscription();

  final BehaviorSubject<TransactionsState> _onNewListingStateController =
      BehaviorSubject<TransactionsState>.seeded(
    TransactionsState(),
  );

  Stream<TransactionsState> get onNewListingState =>
      _onNewListingStateController.stream;

  final StreamController<String?> _onPageRequest = StreamController<String?>();

  Sink<String?> get onPageRequestSink => _onPageRequest.sink;

  final BehaviorSubject<String?> _onSearchInputChangedSubject =
      BehaviorSubject<String?>.seeded(null);

  Sink<String?> get onSearchInputChangedSink =>
      _onSearchInputChangedSubject.sink;

  // String? get _searchInputValue => _onSearchInputChangedSubject.value;

  Stream<TransactionsState> _resetSearch() async* {
    yield TransactionsState();
    yield* _fetchTransactionsList(null);
  }

  Stream<TransactionsState> _fetchTransactionsList(String? pageKey) async* {
    final TransactionsState lastListingState =
        _onNewListingStateController.value;
    try {
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      logger('isConnected: $isConnected');
      final MultiWalletTransactionCubit transCubit =
          GetIt.instance<MultiWalletTransactionCubit>();

      if (!isConnected) {
        yield TransactionsState(
          nextPageKey: pageKey,
          itemList: transCubit.transactions(pubKey),
        );
      } else {
        final List<Transaction> fetchedItems =
            await transCubit.fetchTransactions(
                cursor: pageKey,
                pageSize: pageSize,
                pubKey: pubKey,
                isExternal: isExternal);

        final bool isLastPage = fetchedItems.length < pageSize;
        final String? nextPageKey =
            isLastPage ? null : transCubit.currentWalletState(pubKey).endCursor;

        yield TransactionsState(
          // error: null,
          nextPageKey: nextPageKey,
          itemList: pageKey == null
              ? fetchedItems
              : <Transaction>[
                  ...lastListingState.itemList ?? <Transaction>[],
                  ...fetchedItems
                ],
        );
      }
    } catch (e) {
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
