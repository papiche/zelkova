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
import '../../../data/models/transaction_state.dart';
import '../../../data/models/transactions_bloc.dart';
import '../../../data/models/utxo_cubit.dart';
import '../../../g1/currency.dart';
import '../../../shared_prefs_helper.dart';
import '../balance_widget.dart';
import '../../clipboard_helper.dart';
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
    this.isScrollEnabled = true,
    this.pubKey,
    this.from,
    this.to,
    this.pageSize,
  });

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
  late String pubKey;
  late bool isExternalAccount;
  late StreamSubscription<TransactionsState> _blocListingStateSubscription;
  late AppCubit appCubit;
  late MultiWalletTransactionCubit transCubit;
  late UtxoCubit utxoCubit;

  PagingState<String?, Transaction> _txState =
  PagingState<String?, Transaction>(
    isLoading: true,
  );

  PagingState<int, Transaction> _pendingState = PagingState<int, Transaction>();

  String? _nextCursor;
  String? _lastRequestedCursor;

  static const int _pendingPageSize = 30;
  final Cron cron = Cron();
  late Tutorial tutorial;
  late ScheduledTask scheduledTask;

  bool _gotFirstResponse = false;
  bool _bootstrapping = true;
  bool _firstBuildComplete = false;

  // Debug flag - set to true to enable debug bar in development mode
  static const bool _debug = false;

  int _countItems(PagingState<dynamic, Transaction> s) =>
      (s.pages ?? const <List<Transaction>>[])
          .fold(0, (int a, List<Transaction> p) => a + p.length);

  bool _isTerminalEmpty() {
    return _gotFirstResponse &&
        _txState.isLoading != true &&
        _txState.hasNextPage != true &&
        _countItems(_txState) == 0 &&
        _txState.error == null;
  }

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    transCubit = context.read<MultiWalletTransactionCubit>();
    utxoCubit = context.read<UtxoCubit>();

    pubKey = widget.pubKey ?? SharedPreferencesHelper().getPubKey();
    isExternalAccount = SharedPreferencesHelper().isExternal(pubKey);

    loggerDev(
        ' initState: isLoading=${_txState
            .isLoading}, bootstrapping=$_bootstrapping');

    if (!isExternalAccount) {
      final TransactionState cachedTs = transCubit.currentWalletState(pubKey);
      final List<Transaction> cached = cachedTs.transactions;

      logger(
          '[DEBUG] Cached transactions: ${cached.length}, endCursor=${cachedTs
              .endCursor}');

      if (cached.isNotEmpty) {
        // Update state synchronously to avoid showing NoItems
        _txState = _txState.copyWith(
          keys: <String?>[
            _lastRequestedCursor,
          ],
          pages: <List<Transaction>>[cached],
          hasNextPage: appCubit.isV2 || cachedTs.endCursor != null,
          isLoading: false,
        );
        // IMPORTANT: Mark that we got the first response from cache
        _gotFirstResponse = true;
        _bootstrapping = false;
        logger(
            '[DEBUG] After cache load: isLoading=${_txState
                .isLoading}, gotFirstResp=$_gotFirstResponse, bootstrapping=$_bootstrapping, pages=${_txState
                .pages?.length}, items=${_countItems(_txState)}');
        // For v2: don't use cached cursor from v1, always start fresh with null
        // For v1: use the cached endCursor
        _nextCursor = appCubit.isV2 ? null : cachedTs.endCursor;

        // Force a rebuild after the first frame to ensure the UI shows cached data
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              // State is already updated, just trigger rebuild
              logger(
                  '[DEBUG] PostFrameCallback: Forcing rebuild to show cached data');
            });
          }
        });
      }
    } else {
      // External account: Keep bootstrapping until first real response
      logger(
          '[DEBUG] External account: keeping bootstrapping=true until first response');
    }

    _bloc = TransactionsBloc(
      pubKey: pubKey,
      isV2: appCubit.isV2,
    );
    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((TransactionsState s) {
          final List<Transaction> items = s.itemList ?? const <Transaction>[];

          // Detect whether this is the first page and whether it's empty
          final bool firstPage = _lastRequestedCursor == null;
          final bool noItemsThisPage = items.isEmpty;
          final bool hasNext = s.nextPageKey != null;

          logger(
              '[DEBUG] Bloc response: firstPage=$firstPage, noItems=$noItemsThisPage, hasNext=$hasNext, items=${items
                  .length}, _bootstrapping=$_bootstrapping, nextPageKey=${s
                  .nextPageKey}');

          // Check if we already have cached data BEFORE processing
          final List<List<Transaction>> prevPages =
              _txState.pages ?? const <List<Transaction>>[];
          final bool hasCachedData = prevPages.isNotEmpty;

          // If the first page is empty but there is a next page, auto-fetch the next one.
          // Avoid locking the UI in a permanent "loading" state.
          if (firstPage && noItemsThisPage && hasNext) {
            _lastRequestedCursor = s.nextPageKey;
            _nextCursor = s.nextPageKey;
            logger(
                '[DEBUG] Auto-fetching next page: cursor=$_nextCursor, keeping bootstrapping=$_bootstrapping');
            // Important: do NOT mark isLoading = true here; just trigger the next request.
            // Also, keep bootstrapping=true while we fetch the next page
            _bloc.onPageRequestSink.add(_lastRequestedCursor);
            return;
          }

          // If first page is empty, no next page, but we have cache, ignore this response
          if (firstPage && noItemsThisPage && !hasNext && hasCachedData) {
            logger(
                '[DEBUG] Ignoring empty server response, keeping cached data (${prevPages[0]
                    .length} items)');
            // Don't call setState(), just update flags silently
            _gotFirstResponse = true;
            _bootstrapping = false;
            return;
          }

          // If first page is empty, no next page, and NO cache either, this is truly empty
          // But we need to make sure this is really the final state, not a transient one
          // IMPORTANT: For external accounts, we should NOT immediately mark as empty
          // because the server might send an empty first response before the real data
          if (firstPage && noItemsThisPage && !hasNext && !hasCachedData) {
            logger(
                '[DEBUG] Empty response detected: firstPage=$firstPage, noItems=$noItemsThisPage, hasNext=$hasNext, hasCached=$hasCachedData, isExternal=$isExternalAccount');

            // For external accounts, mark as empty immediately
            // The server response is definitive
            if (isExternalAccount) {
              logger(
                  '[DEBUG] External account: Marking as empty with definitive server response');
              _gotFirstResponse = true;
              _bootstrapping = false;

              setState(() {
                _txState = _txState.copyWith(
                  pages: <List<Transaction>>[],
                  keys: <String?>[],
                  isLoading: false,
                  hasNextPage: false,
                  error: s.error,
                );
                _nextCursor = null;
              });
              logger(
                  '[DEBUG] External account state set: pages=${_txState.pages
                      ?.length}, '
                      'keys=${_txState.keys?.length}, isLoading=${_txState
                      .isLoading}, '
                      'hasNext=${_txState
                      .hasNextPage}, isTerminalEmpty=${_isTerminalEmpty()}');
              return;
            }

            // For internal accounts, mark as truly empty immediately
            logger(
                '[DEBUG] Internal account: Marking as empty with definitive server response');
            _gotFirstResponse = true;
            _bootstrapping = false;

            setState(() {
              _txState = _txState.copyWith(
                pages: <List<Transaction>>[],
                keys: <String?>[],
                isLoading: false,
                hasNextPage: false,
                error: s.error,
              );
              _nextCursor = null;
            });
            logger(
                '[DEBUG] Internal account state set: pages=${_txState.pages
                    ?.length}, '
                    'keys=${_txState.keys?.length}, isLoading=${_txState
                    .isLoading}, '
                    'hasNext=${_txState
                    .hasNextPage}, isTerminalEmpty=${_isTerminalEmpty()}');
            return;
          }

          // Normal processing: we have items or we're appending to existing pages
          setState(() {
            // For the first page, if it's empty and has no next, keep pages empty.
            final List<List<Transaction>> newPages;
            if (hasCachedData && firstPage) {
              // We already have cache
              if (noItemsThisPage) {
                // Keep existing cache, don't replace with empty
                newPages = prevPages;
                logger(
                    '[DEBUG] Keeping cached data, ignoring empty first page response');
              } else {
                // Merge: keep cache but mark that we got fresh data
                // Replace the first page (cache) with the fresh data
                newPages = <List<Transaction>>[items, ...prevPages.skip(1)];
                loggerDev(' Replacing cache with fresh data from server');
              }
            } else {
              // No cache, normal logic
              newPages = firstPage
                  ? (noItemsThisPage
                  ? <List<Transaction>>[]
                  : <List<Transaction>>[items])
                  : <List<Transaction>>[...prevPages, items];
            }

            final List<String?> newKeys = firstPage
                ? (noItemsThisPage && !hasCachedData
                ? <String?>[]
                : <String?>[_lastRequestedCursor])
                : <String?>[...?_txState.keys, _lastRequestedCursor];

            _txState = _txState.copyWith(
              pages: newPages,
              keys: newKeys,
              hasNextPage: hasNext,
              // Only mark as loading when you are actively waiting for a response
              isLoading: false,
              error: s.error,
            );

            _nextCursor = s.nextPageKey;
            _gotFirstResponse = true;
            _bootstrapping = false;

            logger(
                '[DEBUG] State updated: isLoading=${_txState
                    .isLoading}, pages=${newPages.length}, items=${_countItems(
                    _txState)}, gotFirstResp=$_gotFirstResponse, hasNext=$hasNext');
          });
        });

    if (!isExternalAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchNextPendingPage();
      });
    }

    loggerDev(
        ' About to fetch first TX page, isLoading before=${_txState
            .isLoading}');
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
            pubKey: pubKey,
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
    _bloc.dispose();
    super.dispose();
  }

  Future<void> _fetchNextTxPage() async {
    if (_txState.isLoading) {
      return;
    }
    if (_lastRequestedCursor != null && _nextCursor == _lastRequestedCursor) {
      return;
    }

    setState(() {
      _txState = _txState.copyWith(isLoading: true, error: null);
    });

    _lastRequestedCursor = _nextCursor;
    _bloc.onPageRequestSink.add(_lastRequestedCursor);
  }

  Future<void> _fetchNextPendingPage() async {
    // Log for debugging
    logger('Calling _fetchNextPendingPage, pubKey: $pubKey');

    if (_pendingState.isLoading) {
      logger('Already loading pending txs');
      return;
    }

    setState(() {
      _pendingState = _pendingState.copyWith(isLoading: true, error: null);
    });

    try {
      final List<Transaction> pendTxs =
          transCubit
              .currentWalletState(pubKey)
              .pendingTransactions;
      logger('Fetched pending txs: [32m${pendTxs.length}[0m');

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
      logger('Error fetching pending txs: $error');
      setState(() {
        _pendingState = _pendingState.copyWith(
          error: error,
          isLoading: false,
        );
      });
    }
  }

  Future<void> _refresh() async {
    logger('[DEBUG] _refresh() called');
    final List<List<Transaction>> cachedPages =
        _txState.pages ?? const <List<Transaction>>[];
    final List<String?> cachedKeys = _txState.keys ?? const <String?>[];

    _nextCursor = null;
    _lastRequestedCursor = null;

    setState(() {
      // DON'T set isLoading=true here - let _fetchNextTxPage do it
      // Otherwise _fetchNextTxPage will see isLoading=true and skip the request
      _txState = PagingState<String?, Transaction>(
        // isLoading: false, // Will be set to true by _fetchNextTxPage
        pages: cachedPages.isNotEmpty ? cachedPages : null,
        keys: cachedKeys.isNotEmpty ? cachedKeys : null,
      );
      if (!isExternalAccount) {
        _pendingState = PagingState<int, Transaction>();
      }
      _gotFirstResponse = false;
      _bootstrapping = true;
    });

    _fetchNextTxPage();
    if (!isExternalAccount) {
      _fetchNextPendingPage();
    }
  }

  double getBalance(BuildContext context) =>
      context.read<MultiWalletTransactionCubit>().balance(pubKey);

  @override
  Widget build(BuildContext context) {
    // Mark that the first build is complete
    if (!_firstBuildComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _firstBuildComplete = true;
        loggerDev(' First build complete, _firstBuildComplete=true');
      });
    }

    final WeSlideController weSlideController = WeSlideController();
    final ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;
    const double panelMinSize = 0.0;
    final double panelMaxSize = MediaQuery
        .of(context)
        .size
        .height / 3;
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);

    return BlocBuilder<MultiWalletTransactionCubit,
        MultiWalletTransactionState>(
      builder: (BuildContext context,
          MultiWalletTransactionState transBalanceState) {
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
                onPressed: () =>
                    EasyThrottle.throttle(
                      'my-throttler-refresh',
                      const Duration(seconds: 1),
                          () => _refresh(),
                    ),
              ),
              IconButton(
                key: txBalanceKey,
                icon: const Icon(Icons.savings),
                onPressed: () =>
                weSlideController.isOpened
                    ? weSlideController.hide()
                    : weSlideController.show(),
              ),
              IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () =>
                      tutorial.showTutorial(showAlways: true),
                  onLongPress: () {
                    context
                        .read<MultiWalletTransactionCubit>()
                        .printStateStats();
                    /* context
                              .read<MultiWalletTransactionCubit>()
                              .autoCleanState();
                          context
                              .read<MultiWalletTransactionCubit>()
                              .printStateStats(); */
                  }),
              const SizedBox(width: 10),
            ],
          ),
          body: _buildMainTxContainer(
            weSlideController,
            panelMinSize,
            panelMaxSize,
            colorScheme,
            context,
            pubKey,
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
          pubKey,
          isG1,
          currentSymbol,
          currentUd,
          isCurrencyBefore,
          balance,
        );
      },
    );
  }

  WeSlide _buildMainTxContainer(WeSlideController weSlideController,
      double panelMinSize,
      double panelMaxSize,
      ColorScheme colorScheme,
      BuildContext context,
      String pubKey,
      bool isG1,
      String currentSymbol,
      double currentUd,
      bool isCurrencyBefore,
      double balance,) {
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
      panel: isExternalAccount
          ? const SizedBox.shrink()
          : _balancePanelBuilder(colorScheme, context, pubKey),
      panelHeader: Container(
        height: panelMinSize,
        color: colorScheme.secondary,
        child: Center(child: Text(tr('balance'))),
      ),
    );
  }

  Container _balancePanelBuilder(ColorScheme colorScheme,
      BuildContext context,
      String pubKey,) {
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
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

  Widget _transactionPanelBuilder(BuildContext context,
      String myPubKey,
      bool isG1,
      String currentSymbol,
      double currentUd,
      bool isCurrencyBefore,
      double balance,) {
    final int pendingCount = _pendingState.items?.length ?? 0;

    return Stack(
      children: <Widget>[
        RefreshIndicator(
          displacement: 120.0,
          color: Colors.white,
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          strokeWidth: 4.0,
          onRefresh: _refresh,
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              // Spacer for debug bar - only shown when debug is enabled
              if (kDebugMode && _debug)
                const SliverToBoxAdapter(
                  child: SizedBox(height: 140),
                ),
              SliverVisibility(
                  visible: !isExternalAccount &&
                      (_pendingState.items?.isNotEmpty ?? false),
                  sliver: PagedSliverList<int, Transaction>(
                    state: _pendingState,
                    fetchNextPage: _fetchNextPendingPage,
                    builderDelegate: PagedChildBuilderDelegate<Transaction>(
                      animateTransitions: true,
                      // transitionDuration: const Duration(milliseconds: 500),
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
                          isExternalAccount: isExternalAccount,
                          afterRetry: _refresh,
                          afterCancel: _refresh,
                        );
                      },
                      firstPageErrorIndicatorBuilder: (_) =>
                          TransactionWidgetErrorWidget(
                            onTryAgain: _fetchNextPendingPage,
                          ),
                      newPageProgressIndicatorBuilder: (_) =>
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      newPageErrorIndicatorBuilder: (_) =>
                          TransactionWidgetErrorWidget(
                            onTryAgain: _fetchNextPendingPage,
                          ),
                      noItemsFoundIndicatorBuilder: (_) =>
                      const SizedBox.shrink(),
                    ),
                  )),
              PagedSliverList<String?, Transaction>(
                  state: _txState,
                  fetchNextPage: _fetchNextTxPage,
                  builderDelegate: PagedChildBuilderDelegate<Transaction>(
                    animateTransitions: true,
                    // transitionDuration: const Duration(milliseconds: 500),
                    itemBuilder:
                        (BuildContext context, Transaction tx, int index) {
                      return TransactionListItem(
                        pubKey: myPubKey,
                        currentUd: currentUd,
                        isG1: isG1,
                        isCurrencyBefore: isCurrencyBefore,
                        currentSymbol: currentSymbol,
                        isExternalAccount: isExternalAccount,
                        index: index + pendingCount,
                        transaction: tx,
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) {
                      // Only show loading if we're actually waiting for the first response
                      if (!_gotFirstResponse || _bootstrapping) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      // If we already got a response but still showing this, something is wrong
                      // Show empty state instead
                      logger(
                          '[DEBUG] firstPageProgressIndicator called but gotFirstResponse=true. '
                              'This should not happen. Showing empty state.');
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            tr(isExternalAccount
                                ? 'no_transactions_simple'
                                : 'no_transactions'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    firstPageErrorIndicatorBuilder: (_) =>
                        TransactionWidgetErrorWidget(
                          onTryAgain: _fetchNextTxPage,
                        ),
                    newPageProgressIndicatorBuilder: (_) =>
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    newPageErrorIndicatorBuilder: (_) =>
                        TransactionWidgetErrorWidget(
                          onTryAgain: _fetchNextTxPage,
                        ),
                    noItemsFoundIndicatorBuilder: (_) {
                      final int totalItems = _countItems(_txState);
                      final bool isLoading = _txState.isLoading == true;
                      final bool hasNext = _txState.hasNextPage == true;
                      final bool hasError = _txState.error != null;

                      // If there are items, never show this widget
                      if (totalItems > 0) {
                        return const SizedBox.shrink();
                      }

                      // If there's an error and no items, show error
                      if (hasError) {
                        return TransactionWidgetErrorWidget(
                            onTryAgain: _fetchNextTxPage);
                      }

                      // Show loading ONLY if actively loading
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      // If has next page but not loading, something went wrong, show empty
                      // This prevents infinite loading states
                      if (hasNext && !isLoading) {
                        logger(
                            '[DEBUG] Has next page but not loading - this should not happen');
                      }

                      // Only show "no transactions" if really empty and finished
                      if (_isTerminalEmpty()) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              tr(isExternalAccount
                                  ? 'no_transactions_simple'
                                  : 'no_transactions'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      // Fallback: if we reach here, something is wrong, show empty state
                      logger(
                          '[DEBUG] noItemsFoundIndicator fallback: showing empty state. '
                              'totalItems=$totalItems, isLoading=$isLoading, hasNext=$hasNext, '
                              'hasError=$hasError, _bootstrapping=$_bootstrapping, '
                              '_gotFirstResponse=$_gotFirstResponse');
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            tr(isExternalAccount
                                ? 'no_transactions_simple'
                                : 'no_transactions'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
        // Debug bar - floating on top, only in development mode
        if (kDebugMode && _debug)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildDebugBar(context),
          ),
      ],
    );
  }

  Widget _buildDebugBar(BuildContext context) {
    final int txCount = _countItems(_txState);
    final int pendingCount = _countItems(_pendingState);
    final int txPages = _txState.pages?.length ?? 0;
    final bool isTerminalEmpty = _isTerminalEmpty();
    final int cachedTxs = !isExternalAccount
        ? transCubit
        .currentWalletState(pubKey)
        .transactions
        .length
        : 0;

    final String debugInfo = '''
🐛 DEBUG INFO - ${DateTime.now().toIso8601String()}
═══════════════════════���═══════════════════
TX STATE:
  - isLoading: ${_txState.isLoading}
  - hasNext: ${_txState.hasNextPage}
  - error: ${_txState.error != null ? "YES (${_txState.error})" : "NO"}
  - pages count: $txPages
  - items count: $txCount

PENDING STATE:
  - isLoading: ${_pendingState.isLoading}
  - hasNext: ${_pendingState.hasNextPage}
  - items count: $pendingCount

FLAGS:
  - gotFirstResponse: $_gotFirstResponse
  - bootstrapping: $_bootstrapping
  - isTerminalEmpty: $isTerminalEmpty
  - isExternalAccount: $isExternalAccount

CURSORS:
  - lastRequested: $_lastRequestedCursor
  - next: $_nextCursor

ITEMS SUMMARY:
  - TX items: $txCount
  - Pending items: $pendingCount
  - Total visible: ${txCount + pendingCount}
  - Cached in cubit: $cachedTxs

PAGES DETAIL:
  - TX pages: ${_txState.pages?.map((List<Transaction> p) => p.length).join(
        ', ') ?? 'none'}
  - TX keys: ${_txState.keys?.join(', ') ?? 'none'}
''';

    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                '🐛 DEBUG MODE',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  copyToClipboard(
                    context: context,
                    text: debugInfo,
                    feedbackText: 'Debug info copied to clipboard!',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'TX State: isLoading=${_txState.isLoading}, hasNext=${_txState
                .hasNextPage}, '
                'error=${_txState.error != null ? "YES" : "NO"}',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          Text(
            'Pending: isLoading=${_pendingState
                .isLoading}, hasNext=${_pendingState.hasNextPage}',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          Text(
            'Items: TX=$txCount (pages=$txPages), Pending=$pendingCount, Total=${txCount +
                pendingCount}, Cached=$cachedTxs',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          Text(
            'Flags: gotFirstResp=$_gotFirstResponse, bootstrapping=$_bootstrapping, '
                'isTerminalEmpty=$isTerminalEmpty',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          Text(
            'Cursors: last=$_lastRequestedCursor, nList<Transaction> ext=$_nextCursor',
            style: const TextStyle(color: Colors.white, fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
