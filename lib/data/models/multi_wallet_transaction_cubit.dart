import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../g1/api.dart';
import '../../g1/currency.dart';
import '../../g1/g1_helper.dart';
import '../../g1/transaction_parser.dart';
import '../../shared_prefs_helper.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import '../../ui/pay_helper.dart';
import '../../ui/ui_helpers.dart';
import '../../ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'app_cubit.dart';
import 'contact.dart';
import 'multi_wallet_transaction_state.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';
import 'transaction.dart';
import 'transaction_state.dart';
import 'transaction_type.dart';

class MultiWalletTransactionCubit
    extends HydratedCubit<MultiWalletTransactionState> {
  MultiWalletTransactionCubit()
      : super(const MultiWalletTransactionState(<String, TransactionState>{}));

  @override
  String get storagePrefix =>
      kIsWeb ? 'MultiWalletTransactionsCubit' : super.storagePrefix;

  @override
  MultiWalletTransactionState fromJson(Map<String, dynamic> json) =>
      MultiWalletTransactionState.fromJson(json);

  @override
  Map<String, dynamic> toJson(MultiWalletTransactionState state) =>
      state.toJson();

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

  void _emitState(String keyRaw, TransactionState newState) {
    final String key = extractPublicKey(keyRaw);
    final Map<String, TransactionState> newStates =
        Map<String, TransactionState>.of(state.map)..[key] = newState;
    emit(MultiWalletTransactionState(newStates));
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
      NodeListCubit cubit, AppCubit appCubit,
      {int retries = 5,
      int? pageSize,
      String? cursor,
      String? pubKey,
      bool isExternal = false}) async {
    final bool isCurrentWallet = pubKey != null &&
        (extractPublicKey(pubKey) ==
            extractPublicKey(SharedPreferencesHelper().getPubKey()));
    pubKey = _defKey(pubKey);
    final TransactionState currentState = _getStateOfWallet(pubKey);
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;
    final bool isG1 = appCubit.currency == Currency.G1;

    for (int attempt = 0; attempt < retries; attempt++) {
      txDataResult = await gvaHistoryAndBalance(pubKey, pageSize, cursor);
      final Node node = txDataResult.item2;
      logger(
          'Loading transactions using $node (pageSize: $pageSize, cursor: $cursor) --------------------');

      if (txDataResult.item1 == null) {
        logger(
            'Failed to get transactions, attempt ${attempt + 1} of $retries');
        await Future<void>.delayed(const Duration(seconds: 1));
        increaseNodeErrors(NodeType.gva, node);
        continue;
      }

      final Map<String, dynamic> txData = txDataResult.item1!;
      final TransactionState newParsedState =
          await transactionsGvaParser(txData, currentState, pubKey);

      if (newParsedState.balance < 0) {
        logger('Warning: Negative balance in node ${txDataResult.item2}');
        increaseNodeErrors(NodeType.gva, node);
        continue;
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
        resetCurrentGvaNode(newState, cubit);
      }

      // Is external, forget notifications
      if (isExternal) {
        return currentModifiedState.transactions;
      }

      logger(
          'Last received notification: ${currentModifiedState.latestReceivedNotification.toIso8601String()})}');
      logger(
          'Last sent notification: ${currentModifiedState.latestSentNotification.toIso8601String()})}');

      logger(
          '>>>>>>>>>>>>>>>>>>> Transactions: ${currentModifiedState.transactions.length}, wallets ${state.map.length}');
      for (final Transaction tx in currentModifiedState.transactions.reversed) {
        bool stateModified = false;

        if (tx.type == TransactionType.received &&
            currentModifiedState.latestReceivedNotification.isBefore(tx.time)) {
          // Future
          final Contact from = tx.from;
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: tx.amount,
              currentUd: appCubit.currentUd,
              comment: tx.comment,
              from: from.title,
              isG1: isG1);
          currentModifiedState = currentModifiedState.copyWith(
              latestReceivedNotification: tx.time);
          stateModified = true;
        }

        if (tx.type == TransactionType.sent &&
            currentModifiedState.latestSentNotification.isBefore(tx.time)) {
          // Future
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: -tx.amount,
              currentUd: appCubit.currentUd,
              comment: tx.comment,
              to: humanizeContacts(
                  publicAddress: tx.from.pubKey,
                  contacts: tx.recipientsWithoutCashBack),
              isG1: isG1);
          currentModifiedState =
              currentModifiedState.copyWith(latestSentNotification: tx.time);
          stateModified = true;
        }

        if (stateModified) {
          _emitState(pubKey, currentModifiedState);
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

      // Adjust pending transactions in state
      // If waiting: re-add
      // If sent: don't add
      // If sending: add is with debug info
      // If other type WARN and ignore
      // If don't match:
      //    - is old -> mark as failed
      //    - is not old --> re-add
      for (final Transaction pend in newState.pendingTransactions) {
        /* if (pend.type == TransactionType.waitingNetwork) {
          // Pending for manual retry
          newPendingTxs.add(pend);
          continue;
        } */
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
          }
        }
      }

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
}
