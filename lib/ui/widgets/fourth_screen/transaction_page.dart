import 'dart:async';

import 'package:cron/cron.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:we_slide/we_slide.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/multi_wallet_transaction_state.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/theme_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transactions_bloc.dart';
import '../../../data/models/utxo_cubit.dart';
import '../../../g1/currency.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import '../card_drawer.dart';
import 'fourth_tutorial.dart';
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
  late MultiWalletTransactionCubit transCubit;
  late UtxoCubit utxoCubit;

  final PagingController<String?, Transaction> _pagingController =
      PagingController<String?, Transaction>(firstPageKey: null);

  final PagingController<int, Transaction> _pendingController =
      PagingController<int, Transaction>(firstPageKey: 0);

  final int _pendingPageSize = 30;
  final Cron cron = Cron();
  static const double balanceFontSize = 36.0;
  late Tutorial tutorial;
  late ScheduledTask scheduledTask;

  @override
  void initState() {
    // Remove in the future
    appCubit = context.read<AppCubit>();
    transCubit = context.read<MultiWalletTransactionCubit>();
    nodeListCubit = context.read<NodeListCubit>();
    utxoCubit = context.read<UtxoCubit>();
    _bloc.init(transCubit, nodeListCubit, appCubit, utxoCubit);
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
                onPressed: () =>
                    _refresh() //  _pagingController.retryLastFailedRequest(),
                ),
          ),
        );
      }
    });
    _pendingController.addPageRequestListener((int cursor) {
      _fetchPending(cursor);
    });

    scheduledTask = cron
        .schedule(Schedule.parse(kReleaseMode ? '*/10 * * * *' : '*/5 * * * *'),
            () async {
      logger('---------- fetchTransactions via cron');
      try {
        _refresh();
      } catch (e) {
        logger('Failed via _refresh, lets try a basic fetchTransactions');
        transCubit.fetchTransactions(nodeListCubit, appCubit);
      }
    });
    tutorial = FourthTutorial(context);
    super.initState();
  }

  @override
  void dispose() {
    _transScrollController.dispose();
    _pagingController.dispose();
    _pendingController.dispose();
    _blocListingStateSubscription.cancel();
    scheduledTask.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WeSlideController weSlideController = WeSlideController();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const double panelMinSize = 0.0;
    final double panelMaxSize = MediaQuery.of(context).size.height / 3;
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);
    final NumberFormat currentNumber = currentNumberFormat(
        useSymbol: true, isG1: isG1, locale: currentLocale(context));
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
    return BlocBuilder<MultiWalletTransactionCubit,
            MultiWalletTransactionState>(
        builder: (BuildContext context,
            MultiWalletTransactionState transBalanceState) {
      // final List<Transaction> transactions = transBalanceState.transactions;
      final String myPubKey = SharedPreferencesHelper().getPubKey();
      final double balance = getBalance(context);

      return Scaffold(
        drawer: const CardDrawer(),
        onDrawerChanged: (bool isOpened) {
          if (isOpened && weSlideController.isOpened) {
            weSlideController.hide();
          } else {
            // I do here a refresh because for some reason the Consumer is not working on card change
            _refresh();
          }
        },
        appBar: AppBar(
          title: Text(key: txMainKey, tr('transactions')),
          actions: <Widget>[
            IconButton(
                key: txRefreshKey,
                icon: const Icon(Icons.refresh),
                onPressed: () => EasyThrottle.throttle('my-throttler-refresh',
                    const Duration(seconds: 1), () => _refresh(),
                    onAfter:
                        () {} // <-- Optional callback, called after the duration has passed
                    )),
            IconButton(
                key: txBalanceKey,
                icon: const Icon(Icons.savings),
                onPressed: () => weSlideController.isOpened
                    ? weSlideController.hide()
                    : weSlideController.show()),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                tutorial.showTutorial(showAlways: true);
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: WeSlide(
          controller: weSlideController,
          panelMinSize: panelMinSize,
          panelMaxSize: panelMaxSize,
          // isDismissible: false,
          body: Container(
            color: colorScheme.background,
            child: _transactionPanelBuilder(context, myPubKey, isG1,
                currentSymbol, currentUd, isCurrencyBefore),
          ),
          panel: _balancePanelBuilder(colorScheme, context, isCurrencyBefore,
              isG1, currentSymbol, balance, currentUd),
          // This is hidden right now
          panelHeader: Container(
            height: panelMinSize,
            color: colorScheme.secondary,
            child: Center(child: Text(tr('balance'))),
          ),
        ),
      );
    });
  }

  Container _balancePanelBuilder(
      ColorScheme colorScheme,
      BuildContext context,
      bool isCurrencyBefore,
      bool isG1,
      String currentSymbol,
      double balance,
      double currentUd) {
    return Container(
        color: colorScheme.inversePrimary,
        child: Column(children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(children: <Widget>[
                  const Icon(Icons.savings),
                  const SizedBox(width: 30),
                  Text(
                    tr('balance'),
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ]),
              )),
          Expanded(
              child: Scrollbar(
                  child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child: Text.rich(TextSpan(
                  children: <InlineSpan>[
                    if (isCurrencyBefore)
                      currencyBalanceWidget(context, isG1, currentSymbol),
                    if (isCurrencyBefore) separatorSpan(),
                    TextSpan(
                      text: formatKAmountInView(
                          context: context,
                          amount: balance,
                          isG1: isG1,
                          currentUd: currentUd,
                          useSymbol: false),
                      style: TextStyle(
                          fontSize: balanceFontSize,
                          color: context.read<ThemeCubit>().isDark()
                              ? Colors.white
                              : positiveAmountColor,
                          fontWeight: FontWeight.bold),
                    ),
                    if (!isCurrencyBefore) separatorSpan(),
                    if (!isCurrencyBefore)
                      currencyBalanceWidget(context, isG1, currentSymbol),
                  ],
                ))),
              ),
              // if (!kReleaseMode) TransactionChart(transactions: transactions)
            ],
          )))
        ]));
  }

  RefreshIndicator _transactionPanelBuilder(
      BuildContext context,
      String myPubKey,
      bool isG1,
      String currentSymbol,
      double currentUd,
      bool isCurrencyBefore) {
    return RefreshIndicator(
      displacement: 120.0,
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
                    itemBuilder:
                        (BuildContext context, Transaction tx, int index) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(child: Text(tr('no_transactions'))))))
          ]),
    );
  }

  InlineSpan separatorSpan() {
    return const WidgetSpan(
      child: SizedBox(width: 7),
    );
  }

  InlineSpan currencyBalanceWidget(
      BuildContext context, bool isG1, String currentSymbol) {
    final Color currencyColor = Theme.of(context).colorScheme.secondary;
    return TextSpan(children: <InlineSpan>[
      TextSpan(
        text: currentSymbol,
        style: TextStyle(
          fontSize: balanceFontSize,
          fontWeight: FontWeight.w500,
          color: currencyColor,
        ),
      ),
      if (!isG1)
        WidgetSpan(
            child: Transform.translate(
                offset: const Offset(2, 16),
                child: Text(
                  'Ğ1',
                  style: TextStyle(
                    fontSize: balanceFontSize - 10,
                    fontWeight: FontWeight.w500,
                    // fontFeatures: <FontFeature>[FontFeature.subscripts()],
                    color: currencyColor,
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
      final List<Transaction> pendTxs =
          transCubit.currentWalletState().pendingTransactions;
      final bool shouldPaginate = pendTxs.length > _pendingPageSize;
      final List<Transaction> newItems =
          shouldPaginate ? pendTxs.sublist(pageKey, _pendingPageSize) : pendTxs;
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

  double getBalance(BuildContext context) =>
      context.read<MultiWalletTransactionCubit>().balance;
}
