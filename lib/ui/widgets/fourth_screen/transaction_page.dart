import 'dart:async';

import 'package:backdrop/backdrop.dart';
import 'package:cron/cron.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../data/models/transaction_state.dart';
import '../../../data/models/transactions_bloc.dart';
import '../../../g1/currency.dart';
import '../../../shared_prefs.dart';
import '../../logger.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
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
  late AppCubit appCubit;
  late NodeListCubit nodeListCubit;
  late TransactionCubit transCubit;

  final PagingController<String?, Transaction> _pagingController =
      PagingController<String?, Transaction>(firstPageKey: null);

  final PagingController<int, Transaction> _pendingController =
      PagingController<int, Transaction>(firstPageKey: 0);

  final int _pendingPageSize = 30;
  final Cron cron = Cron();
  static const double balanceFontSize = 36.0;

  @override
  void initState() {
    // Remove in the future
    appCubit = context.read<AppCubit>();
    transCubit = context.read<TransactionCubit>();
    nodeListCubit = context.read<NodeListCubit>();
    _bloc.init(transCubit, nodeListCubit, appCubit);
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
    _pendingController.addPageRequestListener((int cursor) {
      _fetchPending(cursor);
    });

    cron.schedule(Schedule.parse(kReleaseMode ? '*/10 * * * *' : '*/5 * * * *'),
        () async {
      logger('---------- fetchTransactions via cron');
      _refresh();
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
    _pendingController.dispose();
    _blocListingStateSubscription.cancel();
    cron.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);
    final NumberFormat currentNumber = currentNumberFormat(
        useSymbol: true, isG1: isG1, locale: currentLocale(context));
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);

    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (BuildContext context, TransactionState transBalanceState) {
      // final List<Transaction> transactions = transBalanceState.transactions;
      final double balance = transBalanceState.balance;

      return BackdropScaffold(
          appBar: BackdropAppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(tr('balance')),
            actions: <Widget>[
              IconButton(
                  key: txRefreshKey,
                  icon: const Icon(Icons.refresh),
                  onPressed: () => EasyThrottle.throttle('my-throttler-refresh',
                      const Duration(seconds: 1), () => _refresh(),
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
            ),
            child: Scrollbar(
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                      child: Text.rich(TextSpan(
                    children: <InlineSpan>[
                      if (isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol),
                      if (isCurrencyBefore) separatorSpan(),
                      TextSpan(
                        text: formatKAmount(
                            context: context,
                            amount: balance,
                            isG1: isG1,
                            currentUd: currentUd,
                            useSymbol: false),
                        style: TextStyle(
                            fontSize: balanceFontSize,
                            color: balance == 0
                                ? Colors.lightBlue
                                : Colors.lightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      if (!isCurrencyBefore) separatorSpan(),
                      if (!isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol),
                    ],
                  ))),
                ),
                // if (!kReleaseMode) TransactionChart(transactions: transactions)
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
            onRefresh: () => _refresh(),
            child: CustomScrollView(
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  // Some widget before all,
                  PagedSliverList<int, Transaction>(
                    shrinkWrapFirstPageIndicators: true,
                    pagingController: _pendingController,
                    builderDelegate: PagedChildBuilderDelegate<Transaction>(
                        animateTransitions: true,
                        transitionDuration: const Duration(milliseconds: 500),
                        itemBuilder:
                            (BuildContext context, Transaction tx, int index) {
                          return TransactionListItem(
                              pubKey: myPubKey,
                              index: index,
                              transaction: tx,
                              isG1: isG1,
                              currentSymbol: currentSymbol,
                              currentUd: currentUd,
                              isCurrencyBefore: isCurrencyBefore,
                              afterRetry: () => _refresh(),
                              afterCancel: () => _refresh());
                        },
                        noItemsFoundIndicatorBuilder: (_) => Container()),
                  ),
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
                                currentUd: currentUd,
                                isG1: isG1,
                                isCurrencyBefore: isCurrencyBefore,
                                currentSymbol: currentSymbol,
                                index: index +
                                    (_pendingController.itemList != null
                                        ? _pendingController.itemList!.length
                                        : 0),
                                transaction: tx);
                          },
                          noItemsFoundIndicatorBuilder: (_) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  Center(child: Text(tr('no_transactions'))))))
                ]),
          ));
    });
  }

  InlineSpan separatorSpan() {
    return const WidgetSpan(
      child: SizedBox(width: 7),
    );
  }

  InlineSpan currencyBalanceWidget(bool isG1, String currentSymbol) {
    return TextSpan(children: <InlineSpan>[
      TextSpan(
        text: currentSymbol,
        style: const TextStyle(
          fontSize: balanceFontSize,
          fontWeight: FontWeight.w500,
          color: Colors.deepPurple,
        ),
      ),
      if (!isG1)
        WidgetSpan(
            child: Transform.translate(
                offset: const Offset(2, 16),
                child: const Text(
                  'Ğ1',
                  style: TextStyle(
                    fontSize: balanceFontSize - 10,
                    fontWeight: FontWeight.w500,
                    // fontFeatures: <FontFeature>[FontFeature.subscripts()],
                    color: Colors.deepPurple,
                  ),
                )))
    ]);
  }

  Future<void> _refresh() {
    return Future<void>.sync(() {
      _pagingController.refresh();
      _pendingController.refresh();
    });
  }

  Future<void> _fetchPending(int pageKey) async {
    try {
      final bool shouldPaginate =
          transCubit.state.pendingTransactions.length > _pendingPageSize;
      final List<Transaction> newItems = shouldPaginate
          ? transCubit.state.pendingTransactions
              .sublist(pageKey, _pendingPageSize)
          : transCubit.state.pendingTransactions;
      final bool isLastPage = newItems.length < _pendingPageSize;
      if (isLastPage) {
        _pendingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pendingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pendingController.error = error;
    }
  }
}
