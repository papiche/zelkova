import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../ui/logger.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'app_cubit.dart';
import 'multi_wallet_transaction_cubit.dart';
import 'node_list_cubit.dart';
import 'transaction.dart';
import 'utxo_cubit.dart';

part 'transactions_state.dart';

class TransactionsBloc {
  TransactionsBloc({this.isExternal = false, this.pubKey}) {
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
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      logger('isConnected: $isConnected');

      if (!isConnected) {
        yield TransactionsState(
          nextPageKey: pageKey,
          itemList: transCubit.transactions(pubKey),
        );
      } else {
        final List<Transaction> fetchedItems =
            await transCubit.fetchTransactions(nodeListCubit, appCubit,
                cursor: pageKey,
                pageSize: _pageSize,
                pubKey: pubKey,
                isExternal: isExternal);

        final bool isLastPage = fetchedItems.length < _pageSize;
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
