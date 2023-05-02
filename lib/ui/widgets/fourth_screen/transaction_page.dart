import 'dart:async';

import 'package:backdrop/backdrop.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_balance_state.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../data/models/transactions_bloc.dart';
import '../../../shared_prefs.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import 'transaction_chart.dart';
import 'transaction_item.dart';

class TransactionsAndBalanceWidget extends StatefulWidget {
  const TransactionsAndBalanceWidget({super.key});

  @override
  State<TransactionsAndBalanceWidget> createState() =>
      _TransactionsAndBalanceWidgetState();
}

class _TransactionsAndBalanceWidgetState
    extends State<TransactionsAndBalanceWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController _transScrollController = ScrollController();
  final TransactionsBloc _bloc = TransactionsBloc();
  late StreamSubscription<TransactionsState> _blocListingStateSubscription;
  late NodeListCubit nodeListCubit;
  late TransactionsCubit transCubit;
  bool isLoading = false;

  final PagingController<String?, Transaction> _pagingController =
      PagingController<String?, Transaction>(firstPageKey: null);

  @override
  void initState() {
    // Remove in the future
    transCubit = context.read<TransactionsCubit>();
    nodeListCubit = context.read<NodeListCubit>();
    _bloc.init(transCubit, nodeListCubit);
    _pagingController.addPageRequestListener((String? cursor) {
      _bloc.onPageRequestSink.add(cursor);
    });
    // We could've used StreamBuilder, but that would unnecessarily recreate
    // the entire [PagedSliverGrid] every time the state changes.
    // Instead, handling the subscription ourselves and updating only the
    // _pagingController is more efficient.
    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((TransactionsState listingState) {
      _pagingController.value = PagingState<String?, Transaction>(
        nextPageKey: listingState.nextPageKey,
        error: listingState.error,
        itemList: listingState.itemList,
      );
    });

    /*
    _pagingController.addPageRequestListener((String? cursor) {
      EasyThrottle.throttle('my-throttler-$cursor', const Duration(seconds: 1),
          () => _fetchPage(cursor),
          onAfter:
              () {} // <-- Optional callback, called after the duration has passed
          );
    }); */
    _pagingController.addStatusListener((PagingStatus status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('fetch_tx_error')),
            action: SnackBarAction(
              label: tr('retry'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

/*  Future<void> _fetchPage(String? cursor) async {
    logger('Fetching from transaction page with cursor $cursor');
    try {
      final List<Transaction> newItems = await transCubit.fetchTransactions(
          nodeListCubit,
          cursor: cursor,
          pageSize: _pageSize);

      final bool isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final String? nextCursor = transCubit.state.endCursor;
        _pagingController.appendPage(newItems, nextCursor);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }*/

  @override
  void dispose() {
    _transScrollController.dispose();
    _pagingController.dispose();
    _blocListingStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    return BlocBuilder<TransactionsCubit, TransactionsAndBalanceState>(builder:
        (BuildContext context, TransactionsAndBalanceState transBalanceState) {
      final List<Transaction> transactions = transBalanceState.transactions;
      final double balance = transBalanceState.balance;
      return BackdropScaffold(
          appBar: BackdropAppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(tr('balance')),
            actions: <Widget>[
              IconButton(
                  key: txRefreshKey,
                  icon: const Icon(Icons.refresh),
                  onPressed: () => EasyThrottle.throttle(
                      'my-throttler-refresh',
                      const Duration(seconds: 1),
                      () => _pagingController.refresh(),
                      onAfter:
                          () {} // <-- Optional callback, called after the duration has passed
                      )),
              // const BackdropToggleButton(),
              LayoutBuilder(
                  builder: (BuildContext lContext,
                          BoxConstraints constraints) =>
                      IconButton(
                          key: txBalanceKey,
                          // icon: const Icon(Icons.account_balance_wallet),
                          icon: const Icon(Icons.savings),
                          onPressed: () {
                            if (Backdrop.of(lContext).isBackLayerConcealed) {
                              Backdrop.of(lContext).revealBackLayer();
                            } else {
                              Backdrop.of(lContext).concealBackLayer();
                            }
                          })),
              const SizedBox(width: 10),
            ],
          ),
          backLayer: Center(
              child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 3),
              /* borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ), */
            ),
            child: Scrollbar(
                child: ListView(
              //   controller: scrollController,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                      child: Text(
                    formatKAmount(context, balance),
                    style: TextStyle(
                        fontSize: 36.0,
                        color:
                            balance == 0 ? Colors.lightBlue : Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                if (!kReleaseMode) TransactionChart(transactions: transactions)
              ],
            )),
          )),
          subHeader: BackdropSubHeader(
            key: txMainKey,
            title: Text(tr('transactions')),
            divider: Divider(
              color: Theme.of(context).colorScheme.surfaceVariant,
              height: 0,
            ),
          ),
          frontLayer: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            strokeWidth: 4.0,
            onRefresh: () => Future<void>.sync(
              () => _pagingController.refresh(),
            ),
            child: CustomScrollView(
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  // Some widget before all,
                  PagedSliverList<String?, Transaction>(
                      pagingController: _pagingController,
                      // separatorBuilder: (BuildContext context, int index) =>
                      //    const Divider(),
                      builderDelegate: PagedChildBuilderDelegate<Transaction>(
                          animateTransitions: true,
                          transitionDuration: const Duration(milliseconds: 500),
                          itemBuilder: (BuildContext context, Transaction tx,
                              int index) {
                            return TransactionListItem(
                              pubKey: myPubKey,
                              index: index,
                              transaction: tx,
                            );
                          },
                          noItemsFoundIndicatorBuilder: (_) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  Center(child: Text(tr('no_transactions'))))))

                  /*

          Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: transactions.isEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(child: Text(tr('no_transactions'))))
                          : RefreshIndicator(
                              key: _refreshIndicatorKey,
                              color: Colors.white,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              strokeWidth: 4.0,
                              onRefresh: () async {
                                return _refreshTransactions();
                              },
                              // Pull from top to show refresh indicator.
                              child: PagedListView<String?, Transaction>(
                                  pagingController: _pagingController,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<Transaction>(
                                    animateTransitions: true,
                                    noMoreItemsIndicatorBuilder: (_) =>
                                        const Text('No more transactions'),
                                    itemBuilder: (BuildContext context,
                                        Transaction tx, int index) {
                                      return TransactionListItem(
                                        pubKey: myPubKey,
                                        index: index,
                                        transaction: tx,
                                      );
                                    },
                                  ))))) */
                ]),
          ));
    });
  }
}
