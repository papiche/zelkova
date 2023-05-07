import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'node_list_cubit.dart';
import 'transaction.dart';
import 'transaction_cubit.dart';

part 'transactions_state.dart';

class TransactionsBloc {
  TransactionsBloc() {
    _onPageRequest.stream
        .flatMap(_fetchTransactionsList)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    _onSearchInputChangedSubject.stream
        .flatMap((_) => _resetSearch())
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  late NodeListCubit nodeListCubit;
  late TransactionCubit transCubit;

  static const int _pageSize = 20;

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

  void init(TransactionCubit transCubit, NodeListCubit nodeListCubit) {
    this.transCubit = transCubit;
    this.nodeListCubit = nodeListCubit;
  }

  Stream<TransactionsState> _fetchTransactionsList(String? pageKey) async* {
    final TransactionsState lastListingState =
        _onNewListingStateController.value;
    try {
      /*    final newItems = await RemoteApi.getCharacterList(
        pageKey,
        _pageSize,
        searchTerm: _searchInputValue,
      );
*/
      final List<Transaction> fetchedItems = await transCubit.fetchTransactions(
          nodeListCubit,
          cursor: pageKey,
          pageSize: _pageSize);

      final bool isLastPage = fetchedItems.length < _pageSize;
      final String? nextPageKey =
          isLastPage ? null : transCubit.state.endCursor;

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
