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
import '../../card_drawer.dart';
import '../../connectivity_widget_wrapper_wrapper.dart';
import 'transactions_list_body.dart';
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
  String? _nextCursor;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  bool _isInitialLoading = true;
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
        '[TransactionsListWidget._onTransactionStateChanged] Received state with ${state.transactions.length} transactions and ${state.pendingTransactions.length} pending');
    if (mounted) {
      setState(() {
        _transactions = state.transactions;
        _pendingTransactions = state.pendingTransactions;
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
          _nextCursor = currentState.endCursor;
          _hasMorePages = _appCubit.isV2
              ? currentState.hasNextPage
              : fetchedItems.length >= widget.pageSize;
          _isLoadingMore = false;
          _isInitialLoading = false;
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
        });
      }
    }
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

  Widget _buildContent(ColorScheme colorScheme, double panelMinSize,
      double panelMaxSize, WeSlideController weSlideController) {
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

    return WeSlide(
      controller: weSlideController,
      panelMinSize: panelMinSize,
      panelMaxSize: panelMaxSize,
      body: Container(
        color: colorScheme.surface,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: TransactionsListBody(
            scrollController: _scrollController,
            transactions: _transactions,
            pendingTransactions: _pendingTransactions,
            isLoadingMore: _isLoadingMore,
            hasMorePages: _hasMorePages,
            pubKey: _pubKey,
            isScrollEnabled: widget.isScrollEnabled,
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
                  TransactionsListHeader(
                    pubKey: _pubKey,
                    isExternalAccount: _isExternalAccount,
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
