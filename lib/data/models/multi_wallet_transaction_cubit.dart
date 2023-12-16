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
import 'transactions_bloc.dart';
import 'utxo_cubit.dart';

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
    key = _defKey(key);
    final TransactionState currentState = _getStateOfWallet(key);
    final List<Transaction> newPendingTransactions = <Transaction>[];
    for (final Transaction t in currentState.pendingTransactions) {
      if (tx.from == t.from &&
          tx.recipients == t.recipients &&
          tx.amount == t.amount &&
          tx.comment == t.comment) {
        newPendingTransactions
            .add(t.copyWith(time: DateTime.now(), type: tx.type));
      } else {
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

  List<Transaction> get transactions => currentWalletState().transactions;

  TransactionState currentWalletState() => _getStateOfWallet(_defKey(null));

  double get balance => currentWalletState().balance;

  DateTime get lastChecked => currentWalletState().lastChecked;

  String _getTxKey(Transaction t) {
    final String id = t.isToMultiple
        ? '${t.recipients.map((Contact c) => extractPublicKey(c.pubKey)).join('-')}-${t.comment}-${t.amount}'
        : '${extractPublicKey(t.to.pubKey)}-${t.comment}-${t.amount}';
    /* if (t.type == TransactionType.pending ||
        t.type == TransactionType.sending) {
      loggerDev(t.toJson().toString());
    }
    loggerDev(
        '###################### >>>> Key for tx ${t.toStringSmall(_defKey(null))}: $id'); */
    return id;
  }

  Future<List<Transaction>> fetchTransactions(
      NodeListCubit cubit, UtxoCubit utxoCubit, AppCubit appCubit,
      {int retries = 5, int? pageSize, String? cursor, String? pubKey}) async {
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

      resetCurrentGvaNode(newState, cubit);

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
                  fromAddress: tx.from.pubKey, contacts: tx.recipients),
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
      final LinkedHashSet<Transaction> newPendingTransactions =
          LinkedHashSet<Transaction>();
      final List<Transaction> newTransactions = <Transaction>[];

      // Index transactions by key
      final Map<String, Transaction> txMap = <String, Transaction>{};
      final Map<String, Transaction> pendingMap = <String, Transaction>{};

      //  or maybe it doesn't merit the effort
      for (final Transaction t in newState.transactions) {
        txMap[_getTxKey(t)] = t;
      }
      // Get a range of tx in 1h
      TransactionsBloc().lastTx().forEach((Transaction t) {
        txMap[_getTxKey(t)] = t;
      });
      for (final Transaction t in newState.pendingTransactions) {
        pendingMap[_getTxKey(t)] = t;
      }

      // Adjust pending transactions
      for (final Transaction pend in newState.pendingTransactions) {
        if (pend.type == TransactionType.waitingNetwork) {
          newPendingTransactions.add(pend);
          continue;
        }
        if (txMap[_getTxKey(pend)] != null) {
          // Found a match
          // VER SI SENT o que
          final Transaction t = txMap[_getTxKey(pend)]!;
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
              newPendingTransactions.add(pend.copyWith(
                  debugInfo:
                      pend.debugInfo ?? 'Node where see it: ${node.url}'));
            } else {
              loggerDev(
                  '@@@@@ WARNING: Found a ${t.type} match for pending transaction ${pend.toStringSmall(myPubKey)}');
            }
          }
        } else {
          // Not found a match
          if (areDatesClose(DateTime.now(), pend.time, paymentTimeRange)) {
            loggerDev(
                '@@@@@ Not found yet pending transaction ${pend.toStringSmall(myPubKey)}');
            newPendingTransactions.add(pend);
          } else {
            // Old pending transaction, warn user
            loggerDev(
                '@@@@@ Warn user: Not found an old pending transaction ${pend.toStringSmall(myPubKey)}');
            // Add it but with missing type
            newPendingTransactions
                .add(pend.copyWith(type: TransactionType.failed));
          }
        }
      }

      for (final Transaction tx in newState.transactions) {
        if (pendingMap[_getTxKey(tx)] != null &&
            (tx.type == TransactionType.sending ||
                tx.type == TransactionType.sent)) {
          // Found a match
          if (tx.type == TransactionType.sent) {
            // Ok add it, but not as pending
            newTransactions.add(tx);
          } else {
            // It's sending so should be added before as pending
          }
        } else {
          // Does not match
          if (tx.type == TransactionType.sending) {
            // Not found, maybe we are in other client, so add as pending
            newPendingTransactions
                .add(tx.copyWith(type: TransactionType.pending));
          } else {
            // the rest
            newTransactions.add(tx);
          }
        }
      }

      newState = newState.copyWith(
          transactions: newTransactions,
          pendingTransactions: newPendingTransactions.toList());
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
}
