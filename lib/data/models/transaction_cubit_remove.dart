// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../g1/currency.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import '../../ui/pay_helper.dart';
import 'app_cubit.dart';
import 'contact.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';
import 'transaction.dart';
import 'transaction_state.dart';
import 'transaction_type.dart';

class TransactionCubitRemove extends HydratedCubit<TransactionState> {
  TransactionCubitRemove()
      : super(TransactionState(
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            balance: 0,
            lastChecked: DateTime.now()));

  @override
  String get storagePrefix =>
      kIsWeb ? 'TransactionsCubit' : super.storagePrefix;

  @Deprecated('Use MultiWalletTransactionCubit instead.')
  void addPendingTransaction(Transaction pendingTransaction) {
    final TransactionState currentState = state;
    final List<Transaction> newPendingTransactions =
        List<Transaction>.of(currentState.pendingTransactions)
          ..add(pendingTransaction);
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }

  void removePendingTransaction(Transaction pendingTransaction) {
    final TransactionState currentState = state;
    final List<Transaction> newPendingTransactions =
        List<Transaction>.of(currentState.pendingTransactions)
          ..remove(pendingTransaction);
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }

  Future<List<Transaction>> fetchTransactions(
      NodeListCubit cubit, AppCubit appCubit,
      {int retries = 5, int? pageSize, String? cursor}) async {
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;
    final bool isG1 = appCubit.currency == Currency.G1;

    for (int attempt = 0; attempt < retries; attempt++) {
      final String myPubKey = SharedPreferencesHelper().getPubKey();
      txDataResult = await gvaHistoryAndBalance(myPubKey, pageSize, cursor);
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
      TransactionState newState =
          await transactionsGvaParser(txData, state, myPubKey);

      if (newState.balance < 0) {
        logger('Warning: Negative balance in node ${txDataResult.item2}');
        increaseNodeErrors(NodeType.gva, node);
        continue;
      }
      success = true;

      if (newState.currentUd != null) {
        appCubit.setUd(newState.currentUd!);
      }

      logger(
          'Last received notification: ${newState.latestReceivedNotification.toIso8601String()})}');
      logger(
          'Last sent notification: ${newState.latestSentNotification.toIso8601String()})}');

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
        for (final Transaction t in newState.transactions) {
          txMap[_getTxKey(t)] = t;
        }
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

      emit(newState);
      for (final Transaction tx in newState.transactions.reversed) {
        if (tx.type == TransactionType.received &&
            newState.latestReceivedNotification.isBefore(tx.time)) {
          // Future
          final Contact from = tx.from;
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: tx.amount,
              currentUd: appCubit.currentUd,
              from: from.title,
              isG1: isG1);
          emit(newState.copyWith(latestReceivedNotification: tx.time));
        }
        if (tx.type == TransactionType.sent &&
            newState.latestSentNotification.isBefore(tx.time)) {
          // Future
          final Contact to = tx.to;
          NotificationController.notifyTransaction(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: -tx.amount,
              currentUd: appCubit.currentUd,
              to: to.title,
              isG1: isG1);
          emit(newState.copyWith(latestSentNotification: tx.time));
        }
      }
      return newState.transactions;
    }
    if (!success) {
      throw Exception('Failed to get transactions after $retries attempts');
    }
    // This should not be executed
    return <Transaction>[];
  }

  String _getTxKey(Transaction t) => '${t.to.pubKey}-${t.comment}-${t.amount}';

  @override
  TransactionState fromJson(Map<String, dynamic> json) =>
      TransactionState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TransactionState state) => state.toJson();

  List<Transaction> get transactions => state.transactions;

  double get balance => state.balance;

  DateTime get lastChecked => state.lastChecked;

  void updatePendingTransaction(Transaction tx) {
    final TransactionState currentState = state;
    final List<Transaction> newPendingTransactions = <Transaction>[];
    for (final Transaction t in state.pendingTransactions) {
      if (tx.from == t.from &&
          tx.to == t.to &&
          tx.amount == t.amount &&
          tx.comment == t.comment) {
        newPendingTransactions
            .add(t.copyWith(time: DateTime.now(), type: tx.type));
      } else {
        newPendingTransactions.add(t);
      }
    }
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }

  void insertPendingTransaction(Transaction tx) {
    final TransactionState currentState = state;
    final List<Transaction> newPendingTransactions = state.pendingTransactions;
    newPendingTransactions.insert(0, tx);
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }
}
