import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../g1/api.dart';
import '../../g1/currency.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import '../../ui/ui_helpers.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'app_cubit.dart';
import 'contact.dart';
import 'multi_wallet_transaction_state.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_manager.dart';
import 'node_type.dart';
import 'transaction.dart';
import 'transaction_state.dart';
import 'transaction_type.dart';

class MultiWalletTransactionCubit
    extends HydratedCubit<MultiWalletTransactionState> {
  MultiWalletTransactionCubit()
      : super(const MultiWalletTransactionState(<String, TransactionState>{}));

  DateTime? _lastPersist;

  @override
  String get storagePrefix =>
      kIsWeb ? 'MultiWalletTransactionsCubit' : super.storagePrefix;

  @override
  MultiWalletTransactionState fromJson(Map<String, dynamic> json) =>
      MultiWalletTransactionState.fromJson(json);

  @override
  Map<String, dynamic> toJson(MultiWalletTransactionState state) {
    // Create a thinned state before serializing
    final Map<String, TransactionState> thinnedMap =
        <String, TransactionState>{};

    state.map.forEach((String pubKey, TransactionState ts) {
      // Skip external wallets
      if (SharedPreferencesHelper().isExternal(pubKey)) {
        return;
      }

      // Keep only last 40 transactions to save space
      thinnedMap[pubKey] =
          ts.copyWith(transactions: ts.transactions.take(40).toList());
    });

    // Use the generated toJson method with the thinned state
    final MultiWalletTransactionState thinnedState =
        MultiWalletTransactionState(thinnedMap);
    return thinnedState.toJson();
  }

  void addPendingTransaction(Transaction pendingTransaction, {String? key}) {
    key = _defKey(key);
    final TransactionState currentState = _getStateOfWallet(key);
    final List<Transaction> newPendingTransactions =
        List<Transaction>.of(currentState.pendingTransactions)
          ..add(pendingTransaction);
    final TransactionState newState =
        currentState.copyWith(pendingTransactions: newPendingTransactions);
    _emitState(key, newState);
  }

  @override
  // ignore: must_call_super
  Future<void> close() {
    return Future<void>.value();
  }

  Future<void> closeCubit() async {
    await super.close();
  }

  void _emitState(String keyRaw, TransactionState newState) {
    if (isClosed) {
      logger('[MultiWalletTransactionCubit] Skipping emit for key=$keyRaw, '
          'cubit is closed. Transactions will be re-fetched on next app startup.');
      return;
    }

    final String key = extractPublicKey(keyRaw);
    final Map<String, TransactionState> newStates =
        Map<String, TransactionState>.of(state.map)..[key] = newState;

    try {
      if (SharedPreferencesHelper().isExternal(key)) {
        // External wallet, emit without persisting thanks to toJson
        emit(MultiWalletTransactionState(newStates));
      } else {
        _emitControlled(MultiWalletTransactionState(newStates));
      }
    } catch (e) {
      if (e is StateError &&
          e.toString().contains('Cannot emit new states after calling close')) {
        logger('[MultiWalletTransactionCubit] State emission prevented '
            '(cubit already closed). Transactions will be re-fetched on next app startup.');
      } else {
        rethrow;
      }
    }
  }

  String _defKey(String? key) {
    key = key ?? SharedPreferencesHelper().getPubKey();
    return key;
  }

  TransactionState _getStateOfWallet(String keyRaw) {
    final String key = extractPublicKey(keyRaw);
    final TransactionState currentState =
        state.map[key] ?? TransactionState.emptyState;
    return currentState;
  }

  void removePendingTransaction(Transaction pendingTransaction, {String? key}) {
    key = _defKey(key);
    final TransactionState currentState = _getStateOfWallet(key);
    final List<Transaction> newPendingTransactions =
        List<Transaction>.of(currentState.pendingTransactions)
          ..remove(pendingTransaction);
    final TransactionState newState =
        currentState.copyWith(pendingTransactions: newPendingTransactions);
    _emitState(key, newState);
  }

  void updatePendingTransaction(Transaction tx, {String? key}) {
    loggerDev('»»»»»» $tx Updating ');
    key = _defKey(key);
    final TransactionState currentState = _getStateOfWallet(key);
    final List<Transaction> newPendingTransactions = <Transaction>[];
    for (final Transaction t in currentState.pendingTransactions) {
      if (tx.from.keyEqual(t.from) &&
          compareRecipientListsByKey(
              tx.recipientsWithoutCashBack, t.recipientsWithoutCashBack) &&
          tx.amount == t.amount &&
          tx.comment == t.comment) {
        loggerDev('»»»»»» $t match');
        newPendingTransactions.add(tx.copyWith(time: DateTime.now()));
      } else {
        loggerDev('»»»»»» $t do not match');
        newPendingTransactions.add(t);
      }
    }
    final TransactionState newState =
        currentState.copyWith(pendingTransactions: newPendingTransactions);
    _emitState(key, newState);
  }

  void insertPendingTransaction(Transaction tx, {String? key}) {
    key = _defKey(key);
    final TransactionState currentState = _getStateOfWallet(key);
    final List<Transaction> newPendingTransactions =
        currentState.pendingTransactions;
    newPendingTransactions.insert(0, tx);
    final TransactionState newState =
        currentState.copyWith(pendingTransactions: newPendingTransactions);
    _emitState(key, newState);
  }

  List<Transaction> transactions(String? pubKey) =>
      currentWalletState(pubKey).transactions;

  TransactionState currentWalletState(String? pubKey) =>
      _getStateOfWallet(_defKey(pubKey));

  double balance([String? pubKey]) => currentWalletState(pubKey).balance;

  // DateTime get lastChecked => currentWalletState().lastChecked;

  Future<List<Transaction>> fetchTransactions(
      {int retries = 5,
      int? pageSize,
      String? cursor,
      String? pubKey,
      bool debug = false,
      bool? isConnectedOverride}) async {
    final NodeListCubit nodeListCubit = GetIt.instance.get<NodeListCubit>();
    final AppCubit appCubit = GetIt.instance.get<AppCubit>();
    final bool isCurrentWallet = pubKey != null &&
        (extractPublicKey(pubKey) ==
            extractPublicKey(SharedPreferencesHelper().getPubKey()));
    pubKey = _defKey(pubKey);

    final bool isExternal = SharedPreferencesHelper().isExternal(pubKey);
    if (debug) {
      loggerDev('Fetching transactions for $pubKey in cubit');
    }
    final TransactionState currentState = _getStateOfWallet(pubKey);
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;
    final bool isG1 = appCubit.currency.isG1Like;

    final bool isConnected = isConnectedOverride ??
        await ConnectivityWidgetWrapperWrapper.isConnected;

    for (int attempt = 0; attempt < retries; attempt++) {
      txDataResult = await getHistoryAndBalance(pubKey,
          pageSize: pageSize, cursor: cursor, isConnected: isConnected);
      final Node node = txDataResult.item2;
      if (debug)
        logger(
            'Loading transactions using $node (pageSize: $pageSize, cursor: $cursor) --------------------');

      if (txDataResult.item1 == null) {
        logger(
            'Failed to get transactions, attempt ${attempt + 1} of $retries');
        await Future<void>.delayed(const Duration(seconds: 1));
        NodeManager().increaseNodeErrors(NodeType.endpoint, node,
            cause: 'Failed to get transactions');
        continue;
      }

      final Map<String, dynamic> txData = txDataResult.item1!;

      // Only use cached UD if it doesn't need updating (not older than 24h)
      final double? cachedUd =
          appCubit.shouldUpdateUd() ? null : appCubit.currentUd;

      final TransactionState newParsedState = await transactionsParser(
          txData, currentState, pubKey,
          cursor: cursor, cachedUd: cachedUd);

      if (newParsedState.balance < 0) {
        logger('Warning: Negative balance in node ${txDataResult.item2}');
        // Let's try to continue as it, because currently in v2 I see negative balances after accounts migrations
        //  continue;
      }
      success = true;

      if (newParsedState.currentUd != null) {
        appCubit.setUd(newParsedState.currentUd!);
      }

      // Trying to fix the issue of pending not removed
      // Hangs? _emitState(pubKey, newParsedState);

      // Check pending transactions
      final TransactionState newState =
          _checkPendingTx(cursor, newParsedState, pubKey, node);
      _emitState(pubKey, newState);

      TransactionState currentModifiedState = newState;

      if (isCurrentWallet) {
        // We only reset if it's the current wallet
        resetCurrentGvaNode(newState, nodeListCubit);
      }

      // Skip notifications for external accounts and Linux desktop
      if (isExternal) {
        return currentModifiedState.transactions;
      }

      if (!kIsWeb && Platform.isLinux) {
        return currentModifiedState.transactions;
      }

      if (debug) {
        logger(
            'Last received notification: ${currentModifiedState.latestReceivedNotification.toIso8601String()})}');
        logger(
            'Last sent notification: ${currentModifiedState.latestSentNotification.toIso8601String()})}');

        logger(
            '>>>>>>>>>>>>>>>>>>> Transactions: ${currentModifiedState.transactions.length}, balance: ${currentModifiedState.balance} cursor: $cursor page size: $pageSize');
      }

      // Limit notifications per fetch to avoid spam
      int notificationsSent = 0;
      const int maxNotificationsPerFetch = 7;

      for (final Transaction tx in currentModifiedState.transactions.reversed) {
        // Stop if we've sent too many notifications in this fetch
        if (notificationsSent >= maxNotificationsPerFetch) {
          break;
        }

        if (tx.type == TransactionType.received &&
            currentModifiedState.latestReceivedNotification.isBefore(tx.time)) {
          final Contact from = tx.from;
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: tx.amount,
              currentUd: appCubit.currentUd,
              comment: tx.comment,
              from: from.title,
              isG1: isG1,
              walletPubKey: pubKey);
          currentModifiedState = currentModifiedState.copyWith(
              latestReceivedNotification: tx.time);
          // Emit state immediately after notification to prevent duplicates
          _emitState(pubKey, currentModifiedState);
          notificationsSent++;
        }

        if (tx.type == TransactionType.sent &&
            currentModifiedState.latestSentNotification.isBefore(tx.time)) {
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: -tx.amount,
              currentUd: appCubit.currentUd,
              comment: tx.comment,
              to: humanizeContacts(
                  publicAddress: tx.from.pubKey,
                  contacts: tx.recipientsWithoutCashBack),
              isG1: isG1,
              walletPubKey: pubKey);
          currentModifiedState =
              currentModifiedState.copyWith(latestSentNotification: tx.time);
          // Emit state immediately after notification to prevent duplicates
          _emitState(pubKey, currentModifiedState);
          notificationsSent++;
        }
      }

      return currentModifiedState.transactions;
    }
    if (!success) {
      throw Exception('Failed to get transactions after $retries attempts');
    }
    // This should not be executed
    return <Transaction>[];
  }

  void resetCurrentGvaNode(TransactionState newState, NodeListCubit cubit) {
    final List<Transaction> pendingTransactions = newState.pendingTransactions;

    bool shouldResetGvaNode = pendingTransactions.isEmpty ||
        pendingTransactions
            .every((Transaction transaction) => transaction.isFailed);

    if (!shouldResetGvaNode) {
      final Transaction? oldestPendingTransaction = pendingTransactions
              .isNotEmpty
          ? pendingTransactions.reduce(
              (Transaction a, Transaction b) => a.time.isBefore(b.time) ? a : b)
          : null;

      if (oldestPendingTransaction != null &&
          oldestPendingTransaction.time
              .isBefore(DateTime.now().subtract(const Duration(hours: 1)))) {
        shouldResetGvaNode = true;
      }
    }

    if (shouldResetGvaNode) {
      cubit.resetCurrentGvaNode();
    }
  }

  TransactionState _checkPendingTx(
      String? cursor, TransactionState newState, String myPubKey, Node node) {
    // Check pending transactions
    if (cursor == null) {
      // First page, so let's check pending transactions
      // We maintain a local list of pending transactions, as we don't know
      // when the transaction will be confirmed, and we don't want to lose a payment.
      // - If we see it as sending we don't display the pending transaction
      // - If we don't see the pending tx we show it as pending but if it's an
      // old one we mark it as failed
      // - If we see it as sent, we remove it from pending

      // With this two list we'll update the state
      final List<Transaction> newTxs = <Transaction>[];
      final LinkedHashSet<Transaction> newPendingTxs =
          LinkedHashSet<Transaction>();

      // Maps of transactions by key
      final Map<String, Transaction> txMap = <String, Transaction>{};
      final Map<String, Transaction> pendingMap = <String, Transaction>{};

      //  or maybe it doesn't merit the effort
      for (final Transaction t in newState.transactions) {
        txMap[genTxKey(t)] = t;
      }
      // Get a range of tx in 1h

      for (final Transaction t in lastTx(newState.transactions)) {
        txMap[genTxKey(t)] = t;
      }
      for (final Transaction t in newState.pendingTransactions) {
        pendingMap[genTxKey(t)] = t;
      }

      // log first pending
      /*i f (newState.pendingTransactions.isNotEmpty) {
        log.i(
            'First pending transaction ${genTxKey(newState.pendingTransactions.first)}');
      }*/

      // Adjust pending transactions in state
      // If waiting: re-add
      // If sent: don't add
      // If sending: add is with debug info
      // If other type WARN and ignore
      // If don't match:
      //    - is old -> mark as failed
      //    - is not old --> re-add
      for (final Transaction pend in newState.pendingTransactions) {
        final Transaction? matchTx = txMap[genTxKey(pend)];
        if (matchTx != null) {
          // Found a match
          // VER SI SENT or what
          final Transaction t = matchTx;
          if (t.type == TransactionType.sent) {
            loggerDev(
                '@@@@@ Found a sent match for pending transaction ${pend.toStringSmall(myPubKey)}');
            // Add later the tx, but don't add the pending
          } else {
            if (t.type == TransactionType.sending) {
              loggerDev(
                  '@@@@@ Found a sending match for pending transaction ${pend.toStringSmall(myPubKey)}');
              // Re-add as pending
              // The tx will not be add as sending (as some nodes will show it and others will not,
              // we use better the pending)
              // FIXME: if this is old, probably is stuck, so maybe we should cancel->retry
              newPendingTxs.add(pend.copyWith(
                  debugInfo:
                      pend.debugInfo ?? 'Node where see it: ${node.url}'));
            } else {
              loggerDev(
                  '@@@@@ WARNING: Found a ${t.type} match for pending transaction ${pend.toStringSmall(myPubKey)}');
            }
          }
        } else {
          // Not found a match
          if (pend.type == TransactionType.waitingNetwork ||
              areDatesClose(DateTime.now(), pend.time, paymentTimeRange)) {
            loggerDev(
                '@@@@@ Not found yet pending transaction ${pend.toStringSmall(myPubKey)}');
            newPendingTxs.add(pend);
          } else {
            // Old pending transaction, warn user
            loggerDev(
                '@@@@@ Warn user: Not found an old pending transaction ${pend.toStringSmall(myPubKey)}');
            // Add it but with missing type
            newPendingTxs.add(pend.copyWith(type: TransactionType.failed));
            // Mark the node with one more error via increaseNodeErrors
            NodeManager().increaseNodeErrors(NodeType.endpoint, node,
                cause: 'Pending transaction not found');
          }
        }
      }

      /* if (newState.transactions.isNotEmpty) {
        log.i('First transaction ${genTxKey(newState.transactions.first)}');
      }*/
      // Now that we have the pending, lets see the node retrieved txs
      for (final Transaction tx in newState.transactions) {
        if (pendingMap[genTxKey(tx)] != null &&
            (tx.type == TransactionType.sending ||
                tx.type == TransactionType.sent)) {
          // Found a match
          if (tx.type == TransactionType.sent) {
            // Ok add it, but not as pending
            newTxs.add(tx);
          } else {
            // It's sending so should be added before as pending
          }
        } else {
          // Does not match
          if (tx.type == TransactionType.sending) {
            newTxs.add(
                tx.copyWith(debugInfo: 'Sending tx not found in pending?'));
            /*
            // Not found, maybe we are in other client, so add as pending
            print(
                // ignore: deprecated_member_use_from_same_package
                '---------------------- Pending tx from ${tx.to.pubKey} not found with comment ${tx.comment} ${tx.recipients.length} recipients ${tx.recipients}');
            print(genTxKey(tx));
            print('Current pending tx:\n'
                "${pendingMap.keys.join('\n')}");
            //      newPendingTransactions
            //        .add(tx.copyWith(type: TransactionType.pending));
            print('In State');
            print(newState.pendingTransactions
                .map((Transaction t) => '${genTxKey(t)}-${t.recipients.length}')
                .join('\n')); */
          } else {
            // the rest
            newTxs.add(tx);
          }
        }
      }

      newState = newState.copyWith(
          transactions: newTxs, pendingTransactions: newPendingTxs.toList());
    }
    return newState;
  }

  Future<void> clearState() async {
    final Set<String> keys = <String>{};
    for (final String keyRaw in state.map.keys) {
      final String key = extractPublicKey(keyRaw);
      keys.add(key);
    }

    // remove old key:hash keys in state that wre duplicates
    final MultiWalletTransactionState newState = state.copyWith();
    final Set<String> mapKeys = Set<String>.from(state.map.keys);

    for (final String key in mapKeys) {
      if (!keys.contains(key)) {
        newState.map.remove(key);
      }
    }

    emit(newState);

    // Clear tx if is connected and refresh
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    if (isConnected) {
      for (final String key in state.map.keys) {
        final TransactionState currentState = _getStateOfWallet(key);
        final TransactionState newState =
            currentState.copyWith(transactions: <Transaction>[]);
        _emitState(key, newState);
      }
    }
  }

  // Clear state of a pubkey (used after visiting a contact page profile)
  void removeStateForKey(String pubKey) {
    if (state.map.containsKey(pubKey)) {
      state.map.remove(pubKey);
      emit(MultiWalletTransactionState(
          Map<String, TransactionState>.of(state.map)));
    }
  }

  /// Cleans the state to avoid excessive growth.
  /// Keeps only the last [maxTxPerWallet] transactions per wallet,
  /// and deletes the state of wallets not included in the user's public keys.
  void autoCleanState({
    int maxTxPerWallet = 20,
  }) {
    final Map<String, TransactionState> cleanedMap =
        <String, TransactionState>{};
    // Get all user public keys from SharedPreferencesHelper
    final Set<String> keepSet =
        SharedPreferencesHelper().publicKeys.map(extractPublicKey).toSet();
    for (final String key in state.map.keys) {
      if (!keepSet.contains(extractPublicKey(key))) {
        // Do not keep non-owned wallets
        continue;
      }
      final TransactionState walletState = state.map[key]!;
      // Keep only the last maxTxPerWallet transactions
      final List<Transaction> limitedTxs =
          walletState.transactions.length > maxTxPerWallet
              ? walletState.transactions
                  .sublist(walletState.transactions.length - maxTxPerWallet)
              : walletState.transactions;
      cleanedMap[key] = walletState.copyWith(transactions: limitedTxs);
    }
    emit(MultiWalletTransactionState(cleanedMap));
  }

  /// Prints statistics about the state to the console (in English)
  void printStateStats([bool debug = false]) {
    if (!debug) {
      return;
    }
    final Map<String, TransactionState> map = state.map;
    loggerDev('--- MultiWalletTransactionCubit Stats ---');
    loggerDev('Total wallets: ${map.length}');
    int totalTx = 0;
    int totalPending = 0;
    Transaction? globalLargestTx;
    int globalLargestSize = 0;
    String? globalLargestWallet;
    for (final MapEntry<String, TransactionState> entry in map.entries) {
      final String key = entry.key;
      final TransactionState walletState = entry.value;
      final List<Transaction> txs = walletState.transactions;
      final List<Transaction> pendings = walletState.pendingTransactions;
      totalTx += txs.length;
      totalPending += pendings.length;
      final Map<String, dynamic> walletJson = walletState.toJson();
      final String walletJsonStr = walletJson.toString();
      loggerDev('Wallet: $key');
      loggerDev('  Transactions: ${txs.length}');
      loggerDev('  Pending transactions: ${pendings.length}');
      loggerDev('  Serialized wallet size: ${walletJsonStr.length} characters');
      Transaction? largestTx;
      int largestSize = 0;
      for (final Transaction tx in txs) {
        final Map<String, dynamic> txJson = tx.toJson();
        final String txJsonStr = txJson.toString();
        if (txJsonStr.length > largestSize) {
          largestSize = txJsonStr.length;
          largestTx = tx;
        }
        if (txJsonStr.length > globalLargestSize) {
          globalLargestSize = txJsonStr.length;
          globalLargestTx = tx;
          globalLargestWallet = key;
        }
      }
      if (largestTx != null) {
        loggerDev('  Largest transaction:');
        loggerDev('    Size: $largestSize characters');
        loggerDev('    Amount: ${largestTx.amount}');
        loggerDev('    Comment (EN): ${largestTx.comment}');
        loggerDev(
            '    Recipients size: ${largestTx.recipients.toString().length}');
        loggerDev('    From size: ${largestTx.from.toString().length}');
        loggerDev('    To size: ${largestTx.recipients.toString().length}');
      }
    }
    if (globalLargestTx != null) {
      loggerDev('--- Largest transaction in all wallets ---');
      loggerDev('Wallet: $globalLargestWallet');
      loggerDev('  Size: $globalLargestSize characters');
      loggerDev('  Amount: ${globalLargestTx.amount}');
      loggerDev('  Comment (EN): ${globalLargestTx.comment}');
      loggerDev('  Recipients: ${globalLargestTx.recipients}');
      loggerDev('  From: ${globalLargestTx.from}');
      loggerDev(
          '  Recipients size: ${globalLargestTx.recipients.toString().length}');
      loggerDev('  From size: ${globalLargestTx.from.toString().length}');
    }
    loggerDev('Total transactions: $totalTx');
    loggerDev('Total pending transactions: $totalPending');
    // Serialized state size
    final Map<String, dynamic> json = toJson(state);
    final String jsonStr = json.toString();
    loggerDev('Serialized state size: ${jsonStr.length} characters');
    loggerDev('------------------------------------------');
  }

  void _emitControlled(MultiWalletTransactionState newState,
      {bool forcePersist = false}) {
    final DateTime now = DateTime.now();
    final bool allowPersistByTime = _lastPersist == null ||
        now.difference(_lastPersist!) > const Duration(seconds: 10);
    if (forcePersist || allowPersistByTime) {
      _lastPersist = now;
      emit(newState);
    } else {
      emit(newState);
    }
  }
}
