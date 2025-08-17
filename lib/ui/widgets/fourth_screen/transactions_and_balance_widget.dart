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
import '../../../data/models/transaction.dart';
import '../../../data/models/transactions_bloc.dart';
import '../../../data/models/utxo_cubit.dart';
import '../../../g1/currency.dart';
import '../../../shared_prefs_helper.dart';
import '../../currency_helper.dart';
import '../../locale_helper.dart';
import '../../logger.dart';
import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import '../card_drawer.dart';
import 'fourth_tutorial.dart';
import 'transaction_item.dart';
import 'transactions_widget_error_widget.dart';

class TransactionsAndBalanceWidget extends StatefulWidget {
  const TransactionsAndBalanceWidget({
    super.key,
    this.isExternalAccount = false,
    this.isScrollEnabled = true,
    this.pubKey,
    this.from,
    this.to,
    this.pageSize,
  });

  final bool isExternalAccount;
  final String? pubKey;
  final int? from;
  final int? to;
  final bool isScrollEnabled;
  final int? pageSize;

  @override
  State<TransactionsAndBalanceWidget> createState() =>
      _TransactionsAndBalanceWidgetState();
}

class _TransactionsAndBalanceWidgetState
    extends State<TransactionsAndBalanceWidget>
    with SingleTickerProviderStateMixin {
  late TransactionsBloc _bloc;

  late StreamSubscription<TransactionsState> _blocListingStateSubscription;
  late AppCubit appCubit;
  late MultiWalletTransactionCubit transCubit;
  late UtxoCubit utxoCubit;

  PagingState<String?, Transaction> _txState =
      PagingState<String?, Transaction>(isLoading: true);
  PagingState<int, Transaction> _pendingState =
      PagingState<int, Transaction>(isLoading: true);

  String? _nextCursor;
  String? _lastRequestedCursor;

  static const int _pendingPageSize = 30;
  final Cron cron = Cron();
  late Tutorial tutorial;
  late ScheduledTask scheduledTask;

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    transCubit = context.read<MultiWalletTransactionCubit>();
    utxoCubit = context.read<UtxoCubit>();

    _bloc = TransactionsBloc(
      isExternal: widget.isExternalAccount,
      pubKey: widget.pubKey,
      isV2: appCubit.isV2,
    );

    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((TransactionsState listingState) {
      final List<Transaction> items = listingState.itemList ?? <Transaction>[];

      setState(() {
        final List<List<Transaction>> pageList = <List<Transaction>>[items];
        final List<String?> keyList = <String?>[_lastRequestedCursor];

        final bool keepLoading = items.isEmpty &&
            listingState.error == null &&
            (listingState.nextPageKey != null || _txState.isLoading);

        _txState = _txState.copyWith(
          pages: pageList,
          keys: keyList,
          hasNextPage: listingState.nextPageKey != null,
          isLoading: keepLoading,
          error: listingState.error,
        );

        _nextCursor = listingState.nextPageKey;
      });
    });

    _fetchNextTxPage();

    scheduledTask = cron.schedule(
      Schedule.parse(kReleaseMode ? '*/10 * * * *' : '*/5 * * * *'),
      () async {
        logger(
            '---------- fetchTransactions via cron in txs_and_balance widget');
        try {
          await _refresh();
        } catch (e) {
          logger('Failed via _refresh, lets try a basic fetchTransactions');
          transCubit.fetchTransactions(
            isExternal: widget.isExternalAccount,
            pubKey: widget.pubKey,
          );
        }
      },
    );

    tutorial = FourthTutorial(context);
    super.initState();
  }

  @override
  void dispose() {
    _blocListingStateSubscription.cancel();
    scheduledTask.cancel();
    super.dispose();
  }

  Future<void> _fetchNextTxPage() async {
    if (_txState.isLoading) {
      return;
    }

    setState(() {
      _txState = _txState.copyWith(isLoading: true, error: null);
    });

    _lastRequestedCursor = _nextCursor;
    _bloc.onPageRequestSink.add(_lastRequestedCursor);
  }

  Future<void> _fetchNextPendingPage() async {
    if (widget.pubKey != null) {
      return;
    }
    if (_pendingState.isLoading) {
      return;
    }

    setState(() {
      _pendingState = _pendingState.copyWith(isLoading: true, error: null);
    });

    try {
      final List<Transaction> pendTxs =
          transCubit.currentWalletState(widget.pubKey).pendingTransactions;

      final int already = _pendingState.items?.length ?? 0;
      final List<Transaction> newItems =
          pendTxs.skip(already).take(_pendingPageSize).toList(growable: false);

      final bool isLastPage = already + newItems.length >= pendTxs.length;

      setState(() {
        _pendingState = _pendingState.copyWith(
          pages: <List<Transaction>>[
            ...?_pendingState.pages,
            newItems,
          ],
          keys: <int>[
            ...?_pendingState.keys,
            (_pendingState.keys?.length ?? 0)
          ],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      });
    } catch (error) {
      setState(() {
        _pendingState = _pendingState.copyWith(
          error: error,
          isLoading: false,
        );
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _txState = PagingState<String?, Transaction>();
      _pendingState = PagingState<int, Transaction>();
      _nextCursor = null;
      _lastRequestedCursor = null;
    });

    await Future.wait(<Future<void>>[
      Future<void>.sync(_fetchNextTxPage),
      if (!widget.isExternalAccount) Future<void>.sync(_fetchNextPendingPage),
    ]);
  }

  double getBalance(BuildContext context) =>
      context.read<MultiWalletTransactionCubit>().balance(widget.pubKey);

  @override
  Widget build(BuildContext context) {
    final WeSlideController weSlideController = WeSlideController();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const double panelMinSize = 0.0;
    final double panelMaxSize = MediaQuery.of(context).size.height / 3;
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);

    return BlocBuilder<MultiWalletTransactionCubit,
        MultiWalletTransactionState>(
      builder: (BuildContext context,
          MultiWalletTransactionState transBalanceState) {
        final String currentPubKey =
            widget.pubKey ?? SharedPreferencesHelper().getPubKey();
        final double balance = getBalance(context);
        final NumberFormat currentNumber = currentNumberFormat(
          useSymbol: true,
          isG1: isG1,
          locale: currentLocale(context),
          amount: balance,
        );
        final bool isCurrencyBefore =
            isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);

        return widget.pubKey == null
            ? Scaffold(
                drawer: const CardDrawer(),
                onDrawerChanged: (bool isOpened) {
                  if (isOpened && weSlideController.isOpened) {
                    weSlideController.hide();
                  } else {
                    _refresh();
                  }
                },
                appBar: AppBar(
                  title: Text(key: txMainKey, tr('transactions')),
                  actions: <Widget>[
                    IconButton(
                      key: txRefreshKey,
                      icon: const Icon(Icons.refresh),
                      onPressed: () => EasyThrottle.throttle(
                        'my-throttler-refresh',
                        const Duration(seconds: 1),
                        () => _refresh(),
                      ),
                    ),
                    IconButton(
                      key: txBalanceKey,
                      icon: const Icon(Icons.savings),
                      onPressed: () => weSlideController.isOpened
                          ? weSlideController.hide()
                          : weSlideController.show(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => tutorial.showTutorial(showAlways: true),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                body: _buildMainTxContainer(
                  weSlideController,
                  panelMinSize,
                  panelMaxSize,
                  colorScheme,
                  context,
                  currentPubKey,
                  isG1,
                  currentSymbol,
                  currentUd,
                  isCurrencyBefore,
                  balance,
                ),
              )
            : _buildMainTxContainer(
                weSlideController,
                panelMinSize,
                panelMaxSize,
                colorScheme,
                context,
                currentPubKey,
                isG1,
                currentSymbol,
                currentUd,
                isCurrencyBefore,
                balance,
              );
      },
    );
  }

  WeSlide _buildMainTxContainer(
    WeSlideController weSlideController,
    double panelMinSize,
    double panelMaxSize,
    ColorScheme colorScheme,
    BuildContext context,
    String pubKey,
    bool isG1,
    String currentSymbol,
    double currentUd,
    bool isCurrencyBefore,
    double balance,
  ) {
    return WeSlide(
      controller: weSlideController,
      panelMinSize: panelMinSize,
      panelMaxSize: panelMaxSize,
      body: Container(
        color: colorScheme.surface,
        child: _transactionPanelBuilder(
          context,
          pubKey,
          isG1,
          currentSymbol,
          currentUd,
          isCurrencyBefore,
          balance,
        ),
      ),
      panel: widget.isExternalAccount
          ? const SizedBox.shrink()
          : _balancePanelBuilder(colorScheme, context, pubKey),
      panelHeader: Container(
        height: panelMinSize,
        color: colorScheme.secondary,
        child: Center(child: Text(tr('balance'))),
      ),
    );
  }

  Container _balancePanelBuilder(
    ColorScheme colorScheme,
    BuildContext context,
    String pubKey,
  ) {
    return Container(
      color: colorScheme.inversePrimary,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.savings),
                  const SizedBox(width: 30),
                  Text(
                    tr('balance'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  BalanceWidget(pubKey: pubKey, small: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  RefreshIndicator _transactionPanelBuilder(
    BuildContext context,
    String myPubKey,
    bool isG1,
    String currentSymbol,
    double currentUd,
    bool isCurrencyBefore,
    double balance,
  ) {
    final int pendingCount = _pendingState.items?.length ?? 0;

    return RefreshIndicator(
      displacement: 120.0,
      color: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      strokeWidth: 4.0,
      onRefresh: _refresh,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverVisibility(
              visible: !widget.isExternalAccount &&
                  (_pendingState.items?.isNotEmpty ?? false),
              sliver: PagedSliverList<int, Transaction>(
                state: _pendingState,
                fetchNextPage: _fetchNextPendingPage,
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
                      isExternalAccount: widget.isExternalAccount,
                      afterRetry: _refresh,
                      afterCancel: _refresh,
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) =>
                      TransactionWidgetErrorWidget(
                    onTryAgain: _fetchNextPendingPage,
                  ),
                  newPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  newPageErrorIndicatorBuilder: (_) =>
                      TransactionWidgetErrorWidget(
                    onTryAgain: _fetchNextPendingPage,
                  ),
                  noItemsFoundIndicatorBuilder: (_) => const SizedBox.shrink(),
                ),
              )),
          PagedSliverList<String?, Transaction>(
            state: _txState,
            fetchNextPage: _fetchNextTxPage,
            builderDelegate: PagedChildBuilderDelegate<Transaction>(
              animateTransitions: true,
              transitionDuration: const Duration(milliseconds: 500),
              itemBuilder: (BuildContext context, Transaction tx, int index) {
                return TransactionListItem(
                  pubKey: myPubKey,
                  currentUd: currentUd,
                  isG1: isG1,
                  isCurrencyBefore: isCurrencyBefore,
                  currentSymbol: currentSymbol,
                  isExternalAccount: widget.isExternalAccount,
                  index: index + pendingCount,
                  transaction: tx,
                );
              },
              firstPageErrorIndicatorBuilder: (_) =>
                  TransactionWidgetErrorWidget(
                onTryAgain: _fetchNextTxPage,
              ),
              newPageProgressIndicatorBuilder: (_) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
              newPageErrorIndicatorBuilder: (_) => TransactionWidgetErrorWidget(
                onTryAgain: _fetchNextTxPage,
              ),
              noItemsFoundIndicatorBuilder: (_) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    _txState.isLoading
                        ? ''
                        : tr(widget.isExternalAccount
                            ? 'no_transactions_simple'
                            : 'no_transactions'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key, required this.pubKey, required this.small});

  final String pubKey;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final AppCubit appCubit = context.read<AppCubit>();
    final double balanceFontSize = small ? 18 : 36;
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);
    final double balance =
        context.read<MultiWalletTransactionCubit>().balance(pubKey);
    final NumberFormat currentNumber = currentNumberFormat(
        useSymbol: true,
        isG1: isG1,
        locale: currentLocale(context),
        amount: balance);
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
          child: Text.rich(humanizeAmount(isCurrencyBefore, context, isG1,
              small, currentSymbol, balanceFontSize, balance, currentUd))),
    );
  }
}
