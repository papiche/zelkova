import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../g1/g1_helper.dart';
import '../../ui/logger.dart';
import '../../ui/pay_helper.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'app_cubit.dart';
import 'multi_wallet_transaction_cubit.dart';
import 'node_list_cubit.dart';
import 'transaction.dart';
import 'utxo_cubit.dart';

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

  late AppCubit appCubit;
  late NodeListCubit nodeListCubit;
  late MultiWalletTransactionCubit transCubit;
  late UtxoCubit utxoCubit;

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

  List<Transaction> lastTx({bool applyDateFilter = false}) {
    if (_onNewListingStateController.value.itemList != null) {
      return _onNewListingStateController.value.itemList!
          .where((Transaction tx) =>
              !applyDateFilter ||
              areDatesClose(DateTime.now(), tx.time, paymentTimeRange))
          .toList();
    } else {
      return <Transaction>[];
    }
  }

  // String? get _searchInputValue => _onSearchInputChangedSubject.value;

  Stream<TransactionsState> _resetSearch() async* {
    yield TransactionsState();
    yield* _fetchTransactionsList(null);
  }

  void init(MultiWalletTransactionCubit transCubit, NodeListCubit nodeListCubit,
      AppCubit appCubit, UtxoCubit utxoCubit) {
    this.appCubit = appCubit;
    this.transCubit = transCubit;
    this.nodeListCubit = nodeListCubit;
    this.utxoCubit = utxoCubit;
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

      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      logger('isConnected: $isConnected');

      if (!isConnected) {
        yield TransactionsState(
          nextPageKey: pageKey,
          itemList: transCubit.transactions,
        );
      } else {
        final List<Transaction> fetchedItems =
            await transCubit.fetchTransactions(nodeListCubit, appCubit,
                cursor: pageKey, pageSize: _pageSize);

        final bool isLastPage = fetchedItems.length < _pageSize;
        final String? nextPageKey =
            isLastPage ? null : transCubit.currentWalletState().endCursor;

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
