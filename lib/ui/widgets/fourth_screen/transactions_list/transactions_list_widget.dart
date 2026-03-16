import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_slide/we_slide.dart';

import '../../../../data/models/app_cubit.dart';
import '../../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../../data/models/multi_wallet_transaction_state.dart';
import '../../../../data/models/transaction.dart';
import '../../../../data/models/transaction_state.dart';
import '../../../../shared_prefs_helper.dart';
import '../../../in_dev_helper.dart';
import '../../../logger.dart';
import '../../balance_widget.dart';
import '../../card_drawer.dart';
import '../../connectivity_widget_wrapper_wrapper.dart';
import '../../multipass_recharge_dialog.dart';
import '../../zen_remboursement_dialog.dart';
import 'transaction_list_item_wrapper.dart';
import 'transactions_list_empty.dart';
import 'transactions_list_error.dart';
import 'transactions_list_header.dart';

class TransactionsListWidget extends StatefulWidget {
  const TransactionsListWidget({
    super.key,
    this.pubKey,
    this.pageSize = 20,
    this.isScrollEnabled = true,
  });

  final String? pubKey;
  final int pageSize;
  final bool isScrollEnabled;

  @override
  State<TransactionsListWidget> createState() => _TransactionsListWidgetState();
}

class _TransactionsListWidgetState extends State<TransactionsListWidget> {
  late final String _pubKey;
  late final bool _isExternalAccount;
  late final AppCubit _appCubit;
  late final MultiWalletTransactionCubit _transCubit;
  late final ScrollController _scrollController;

  List<Transaction> _transactions = <Transaction>[];
  List<Transaction> _pendingTransactions = <Transaction>[];
  List<Transaction> _udTransactions = <Transaction>[];
  String? _nextCursor;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  bool _isInitialLoading = true;
  bool _showUD = false;
  String? _error;
  bool _fakeErrorForDev = false; // Debug: toggle fake error for testing UI

  StreamSubscription<TransactionState>? _transactionSubscription;

  @override
  void initState() {
    super.initState();
    _appCubit = context.read<AppCubit>();
    _transCubit = context.read<MultiWalletTransactionCubit>();
    _scrollController = ScrollController();

    _pubKey = widget.pubKey ?? SharedPreferencesHelper().getPubKey();
    _isExternalAccount = SharedPreferencesHelper().isExternal(_pubKey);

    logger(
        '[TransactionsListWidget.initState] pubKey=$_pubKey, isExternal=$_isExternalAccount, widget.pubKey=${widget.pubKey}');

    _scrollController.addListener(_onScroll);
    _initializeData();
  }

  void _onScroll() {
    if (!mounted) {
      return;
    }

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    const double delta = 200.0;

    if (maxScroll - currentScroll <= delta) {
      _onLoadMore();
    }
  }

  Future<void> _initializeData() async {
    logger(
        '[TransactionsListWidget._initializeData] Starting for pubKey=$_pubKey, isExternal=$_isExternalAccount');

    if (!_isExternalAccount) {
      final TransactionState cachedState =
          _transCubit.currentWalletState(_pubKey);
      if (cachedState.transactions.isNotEmpty && mounted) {
        setState(() {
          _transactions = cachedState.transactions;
          _pendingTransactions = cachedState.pendingTransactions;
          _nextCursor = _appCubit.isV2 ? null : cachedState.endCursor;
          _hasMorePages = _appCubit.isV2 || cachedState.endCursor != null;
          _isInitialLoading = false;
        });
        logger(
            '[TransactionsListWidget] Loaded ${_transactions.length} cached transactions');
      } else {
        logger(
            '[TransactionsListWidget] No cached transactions found (${cachedState.transactions.length} txs)');
      }
    } else {
      logger(
          '[TransactionsListWidget] Skipping cache load for external account');
    }

    _transactionSubscription = _transCubit.stream
        .where((MultiWalletTransactionState state) =>
            state.map.containsKey(_pubKey))
        .map<TransactionState>(
            (MultiWalletTransactionState state) => state.map[_pubKey]!)
        .listen(_onTransactionStateChanged);

    logger(
        '[TransactionsListWidget._initializeData] Subscribed to stream, now calling _fetchTransactions');
    await _fetchTransactions(isRefresh: true);
  }

  void _onTransactionStateChanged(TransactionState state) {
    logger(
        '[TransactionsListWidget._onTransactionStateChanged] Received state with ${state.transactions.length} transactions, ${state.pendingTransactions.length} pending, ${state.udTransactions.length} UD');
    if (mounted) {
      setState(() {
        _transactions = state.transactions;
        _pendingTransactions = state.pendingTransactions;
        _udTransactions = state.udTransactions;
        logger(
            '[TransactionsListWidget._onTransactionStateChanged] Updated state - UD txs: ${_udTransactions.length}');
        logger(
            '[TransactionsListWidget._onTransactionStateChanged] _getCombinedTransactions will return: ${_showUD ? _transactions.length + _udTransactions.length : _transactions.length} items');
        if (_appCubit.isV2) {
          _hasMorePages = state.hasNextPage;
        } else {
          _nextCursor = state.endCursor;
          _hasMorePages = state.endCursor != null;
        }
      });
    }
  }

  Future<void> _fetchTransactions({bool isRefresh = false}) async {
    logger(
        '[TransactionsListWidget._fetchTransactions] START - isRefresh=$isRefresh, mounted=$mounted, isLoadingMore=$_isLoadingMore, hasMorePages=$_hasMorePages');

    if (!mounted) {
      logger(
          '[TransactionsListWidget._fetchTransactions] EARLY RETURN - not mounted');
      return;
    }

    if (_isLoadingMore && !isRefresh) {
      logger(
          '[TransactionsListWidget._fetchTransactions] EARLY RETURN - already loading more');
      return;
    }

    if (!_hasMorePages && !isRefresh) {
      logger(
          '[TransactionsListWidget._fetchTransactions] EARLY RETURN - no more pages');
      return;
    }

    if (mounted) {
      setState(() {
        if (isRefresh) {
          _isInitialLoading = _transactions.isEmpty;
          _nextCursor = null;
        }
        _isLoadingMore = true;
        _error = null;
      });
    }

    try {
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;

      logger(
          '[TransactionsListWidget._fetchTransactions] isConnected=$isConnected');

      if (!isConnected && !isRefresh) {
        logger('[TransactionsListWidget] Offline, using cached data');
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
            _isInitialLoading = false;
          });
        }
        return;
      }

      logger(
          '[TransactionsListWidget] Fetching transactions: cursor=$_nextCursor, pageSize=${widget.pageSize}');

      final List<Transaction> fetchedItems =
          await _transCubit.fetchTransactions(
        cursor: isRefresh ? null : _nextCursor,
        pageSize: widget.pageSize,
        pubKey: _pubKey,
      );

      logger(
          '[TransactionsListWidget] fetchTransactions returned ${fetchedItems.length} items');

      if (!mounted) {
        logger('[TransactionsListWidget] Widget unmounted after fetch');
        return;
      }

      final TransactionState currentState =
          _transCubit.currentWalletState(_pubKey);

      logger(
          '[TransactionsListWidget] After fetch - currentState.udTransactions=${currentState.udTransactions.length}');

      if (mounted) {
        setState(() {
          if (isRefresh) {
            _transactions = currentState.transactions;
          } else {
            final Set<String> existingIds = _transactions
                .map((Transaction t) =>
                    '${t.time.millisecondsSinceEpoch}_${t.from.pubKey}_${t.amount}')
                .toSet();
            final List<Transaction> newTransactions = fetchedItems
                .where((Transaction t) => !existingIds.contains(
                    '${t.time.millisecondsSinceEpoch}_${t.from.pubKey}_${t.amount}'))
                .toList();
            _transactions = <Transaction>[..._transactions, ...newTransactions];
          }

          _pendingTransactions = currentState.pendingTransactions;
          _udTransactions = currentState.udTransactions;
          logger(
              '[TransactionsListWidget] After setState - _udTransactions=${_udTransactions.length}');
          _nextCursor = currentState.endCursor;
          _hasMorePages = _appCubit.isV2
              ? currentState.hasNextPage
              : fetchedItems.length >= widget.pageSize;
          _isLoadingMore = false;
          _isInitialLoading = false;
          logger(
              '[TransactionsListWidget._fetchTransactions] Setting _isLoadingMore to false - hasMore=$_hasMorePages, txCount=${_transactions.length}, udCount=${currentState.udTransactions.length}');
        });
      }

      logger(
          '[TransactionsListWidget] Fetched successfully: total=${_transactions.length}, hasMore=$_hasMorePages');
    } catch (e) {
      logger('[TransactionsListWidget] Error fetching transactions: $e');
      if (!mounted) {
        return;
      }

      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoadingMore = false;
          _isInitialLoading = false;
          logger(
              '[TransactionsListWidget._fetchTransactions] Setting _isLoadingMore to false due to error');
        });
      }
    }

    logger(
        '[TransactionsListWidget._fetchTransactions] END - _isLoadingMore=$_isLoadingMore, _isInitialLoading=$_isInitialLoading');
  }

  Future<void> _onRefresh() async {
    await _fetchTransactions(isRefresh: true);
  }

  void _onLoadMore() {
    if (!_isLoadingMore && _hasMorePages) {
      _fetchTransactions();
    }
  }

  void _onRetry() {
    if (mounted) {
      setState(() {
        _error = null;
      });
      _fetchTransactions(isRefresh: true);
    }
  }

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const double panelMinSize = 0.0;
    final double panelMaxSize = MediaQuery.of(context).size.height / 3;

    // Create controller fresh for this build - no reuse to avoid disposal issues
    final WeSlideController weSlideController = WeSlideController();

    final Widget content = _buildContent(
        colorScheme, panelMinSize, panelMaxSize, weSlideController);

    if (widget.pubKey == null) {
      return Scaffold(
        drawer: const CardDrawer(),
        onDrawerChanged: (bool isOpened) {
          if (isOpened && weSlideController.isOpened) {
            weSlideController.hide();
          } else {
            _onRefresh();
          }
        },
        appBar: AppBar(
          title: Text(tr('transactions')),
          actions: <Widget>[
            // Debug: Button to toggle fake error for testing
            if (inDevelopment)
              IconButton(
                icon: Icon(
                  _fakeErrorForDev ? Icons.error : Icons.bug_report,
                  color: _fakeErrorForDev ? Colors.red : null,
                ),
                tooltip: 'Toggle fake error (dev)',
                onPressed: () {
                  setState(() {
                    _fakeErrorForDev = !_fakeErrorForDev;
                    if (_fakeErrorForDev) {
                      _error = 'Testing error for development';
                      _transactions.clear();
                    } else {
                      _error = null;
                      _onRefresh();
                    }
                  });
                },
              ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => EasyThrottle.throttle(
                'my-throttler-refresh',
                const Duration(seconds: 1),
                () => _onRefresh(),
              ),
            ),
            // UD toggle button - only show for v2 accounts with UD transactions
            if (!_isExternalAccount &&
                _udTransactions.isNotEmpty &&
                _appCubit.isV2)
              Tooltip(
                message:
                    _showUD ? tr('hide_ud_history') : tr('show_ud_history'),
                child: IconButton(
                  icon: Icon(
                    _showUD ? Icons.water_drop : Icons.water_drop_outlined,
                    color: _showUD ? colorScheme.primary : null,
                  ),
                  onPressed: () {
                    loggerDev(
                        '[UD Toggle AppBar] Toggling _showUD from $_showUD to ${!_showUD}');
                    setState(() {
                      _showUD = !_showUD;
                    });
                  },
                ),
              ),
            IconButton(
              icon: const Icon(Icons.savings),
              onPressed: () {
                weSlideController.isOpened
                    ? weSlideController.hide()
                    : weSlideController.show();
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: content,
      );
    }

    return content;
  }

  List<Transaction> _getCombinedTransactions() {
    if (!_showUD) {
      logger(
          '[_getCombinedTransactions] _showUD=false, returning ${_transactions.length} regular transactions');
      return _transactions;
    }

    // Combinar transacciones normales y UD, ordenadas por tiempo
    final List<Transaction> combined = <Transaction>[
      ..._transactions,
      ..._udTransactions,
    ];
    combined.sort((Transaction a, Transaction b) => b.time.compareTo(a.time));
    logger(
        '[_getCombinedTransactions] _showUD=true, returning ${combined.length} combined transactions (${_transactions.length} regular + ${_udTransactions.length} UD)');
    return combined;
  }

  Widget _buildContent(ColorScheme colorScheme, double panelMinSize,
      double panelMaxSize, WeSlideController weSlideController) {
    logger(
        '[_buildContent] START - _showUD=$_showUD, regularTxs=${_transactions.length}, udTxs=${_udTransactions.length}, pendingTxs=${_pendingTransactions.length}, isInitialLoading=$_isInitialLoading, isLoadingMore=$_isLoadingMore');

    // Show error state if there's a real error or fake error in development
    if (_error != null && _transactions.isEmpty) {
      // In development, if fake error is enabled, show it
      // In production, only show real errors
      if (inDevelopment && _fakeErrorForDev) {
        return TransactionsListError(
          error: _error,
          onRetry: () {
            setState(() {
              _fakeErrorForDev = false;
            });
            _onRetry();
          },
        );
      } else if (!_fakeErrorForDev) {
        // Show real errors (not fake errors)
        return TransactionsListError(
          error: _error,
          onRetry: _onRetry,
        );
      }
    }

    if (!_isInitialLoading &&
        _transactions.isEmpty &&
        _pendingTransactions.isEmpty) {
      return TransactionsListEmpty(
        onRefresh: _onRefresh,
        isExternalAccount: _isExternalAccount,
      );
    }

    if (_isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<Transaction> combinedTransactions = _getCombinedTransactions();

    return WeSlide(
      controller: weSlideController,
      panelMinSize: panelMinSize,
      panelMaxSize: panelMaxSize,
      body: Container(
        color: colorScheme.surface,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 16),
            itemCount: combinedTransactions.length +
                _pendingTransactions.length +
                1 +
                (_isLoadingMore ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              // Header at index 0
              if (index == 0) {
                logger(
                    '[itemBuilder] index=$index: Building TransactionsListHeader');
                return TransactionsListHeader(
                  pubKey: _pubKey,
                  isExternalAccount: _isExternalAccount,
                );
              }

              // Adjust index for transactions (subtract 1 for header)
              final int transactionIndex = index - 1;
              final int pendingCount = _pendingTransactions.length;
              final int totalTransactionCount =
                  pendingCount + combinedTransactions.length;

              logger(
                  '[itemBuilder] index=$index, txIndex=$transactionIndex, pendingCount=$pendingCount, totalTxCount=$totalTransactionCount, combinedTxsLength=${combinedTransactions.length}');

              // Loading indicator at the end
              if (transactionIndex == totalTransactionCount) {
                logger(
                    '[itemBuilder] index=$index: Building loading indicator');
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Pending transactions first
              if (transactionIndex < pendingCount) {
                logger(
                    '[itemBuilder] index=$index: Building pending transaction at index $transactionIndex');
                return TransactionListItemWrapper(
                  transaction: _pendingTransactions[transactionIndex],
                  pubKey: _pubKey,
                  index: transactionIndex,
                  key: ValueKey<String>(
                      'pending_${_pendingTransactions[transactionIndex].time.millisecondsSinceEpoch}'),
                );
              }

              // Regular transactions
              final int regularIndex = transactionIndex - pendingCount;
              if (regularIndex < combinedTransactions.length) {
                final Transaction tx = combinedTransactions[regularIndex];
                final bool isInUdTxList = _udTransactions.contains(tx);
                logger(
                    '[itemBuilder] index=$index: Building combined transaction at regularIndex $regularIndex (isUD=$isInUdTxList, amount=${tx.amount})');
                return TransactionListItemWrapper(
                  transaction: tx,
                  pubKey: _pubKey,
                  index: transactionIndex,
                  key: ValueKey<String>(
                      '${tx.time.millisecondsSinceEpoch}_${tx.from.pubKey}_${tx.amount}'),
                );
              }

              logger(
                  '[itemBuilder] index=$index: Building SizedBox.shrink() - out of bounds!');
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      panel: _isExternalAccount
          ? const SizedBox.shrink()
          : _buildBalancePanel(colorScheme),
      panelHeader: Container(
        height: panelMinSize,
        color: colorScheme.secondary,
        child: Center(child: Text(tr('balance'))),
      ),
    );
  }

  Widget _buildBalancePanel(ColorScheme colorScheme) {
    loggerDev('[_buildBalancePanel] _isExternalAccount=$_isExternalAccount, '
        '_udTransactions.length=${_udTransactions.length}, '
        '_appCubit.isV2=${_appCubit.isV2}, '
        'showButton=${!_isExternalAccount && _udTransactions.isNotEmpty && _appCubit.isV2}');

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
                  const Spacer(),
                  if (!_isExternalAccount &&
                      _udTransactions.isNotEmpty &&
                      _appCubit.isV2)
                    Tooltip(
                      message: _showUD
                          ? tr('hide_ud_history')
                          : tr('show_ud_history'),
                      child: IconButton(
                        icon: Icon(
                          _showUD
                              ? Icons.water_drop
                              : Icons.water_drop_outlined,
                          color: _showUD ? colorScheme.primary : null,
                        ),
                        onPressed: () {
                          loggerDev(
                              '[UD Toggle] Toggling _showUD from $_showUD to ${!_showUD}');
                          setState(() {
                            _showUD = !_showUD;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  BlocBuilder<MultiWalletTransactionCubit,
                      MultiWalletTransactionState>(
                    builder: (BuildContext context,
                        MultiWalletTransactionState state) {
                      return BalanceWidget(pubKey: _pubKey, small: false);
                    },
                  ),
                  if (!_isExternalAccount)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  showMultipassRechargeDialog(context),
                              icon: const Icon(Icons.account_balance_wallet),
                              label: Text(tr('recharge_title')),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  showZenRemboursementDialog(context),
                              icon: const Icon(Icons.receipt_long),
                              label: Text(tr('remboursement_title'),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
