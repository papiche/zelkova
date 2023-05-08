import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import '../../ui/ui_helpers.dart';
import 'contact.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';
import 'transaction.dart';
import 'transaction_state.dart';
import 'transaction_type.dart';

class TransactionCubit extends HydratedCubit<TransactionState> {
  TransactionCubit()
      : super(TransactionState(
            transactions: const <Transaction>[],
            pendingTransactions: const <Transaction>[],
            balance: 0,
            lastChecked: DateTime.now()));

  @override
  String get storagePrefix =>
      kIsWeb ? 'TransactionsCubit' : super.storagePrefix;

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

  Future<List<Transaction>> fetchTransactions(NodeListCubit cubit,
      {int retries = 5, int? pageSize, String? cursor}) async {
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;

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
      TransactionState newState = await transactionsGvaParser(txData, state);

      if (newState.balance < 0) {
        logger('Warning: Negative balance in node ${txDataResult.item2}');
        increaseNodeErrors(NodeType.gva, node);
        continue;
      }
      success = true;

      logger(
          'Last received notification: ${newState.latestReceivedNotification.toIso8601String()})}');
      logger(
          'Last sent notification: ${newState.latestSentNotification.toIso8601String()})}');

      // Check pending transactions
      if (cursor == null && state.pendingTransactions.isNotEmpty) {
        // First page, so let's check pending transactions

        final List<Transaction> newPendingTransactions = <Transaction>[];
        final List<Transaction> newTransactions = <Transaction>[];

        for (final Transaction pend in state.pendingTransactions) {
          bool pendFound = false;
          for (final Transaction t in newState.transactions) {
            if (t.to.pubKey == pend.to.pubKey &&
                t.comment == pend.comment &&
                t.amount == pend.amount &&
                (t.type == TransactionType.sending ||
                    t.type == TransactionType.sent) &&
                areDatesClose(t.time, pend.time, const Duration(minutes: 90))) {
              // Found a match
              pendFound = true;
              if (t.type == TransactionType.sent) {
                loggerDev(
                    '@@@@@ Found a sent match for pending transaction ${pend.toStringSmall(myPubKey)}');
                newTransactions.add(t);
                // and remove it from pending
              } else {
                if (t.type == TransactionType.sending) {
                  loggerDev(
                      '@@@@@ Found a sending match for pending transaction ${pend.toStringSmall(myPubKey)}');
                  newPendingTransactions
                      .add(pend.copyWith(type: TransactionType.pending));
                } else {
                  loggerDev(
                      '@@@@@ WARNING: Found a ${t.type} match for pending transaction ${pend.toStringSmall(myPubKey)}');
                }
              }
            } else {
              // No match, keep it
              /* loggerDev(
                  '@@@@@ Not found a sending/sent match for pending transaction comparing with $t <-> ${pend.toStringSmall(myPubKey)}'); */
              newTransactions.add(t);
            }
          }
          if (!pendFound) {
            // Not found, keep it
            if (areDatesClose(
                DateTime.now(), pend.time, const Duration(minutes: 60))) {
              // Old pending transaction, warn user
              loggerDev(
                  '@@@@@ Warn user: Not found an old pending transaction comparing with ${pend.toStringSmall(myPubKey)}');
              newPendingTransactions.add(pend);
            } else {
              loggerDev(
                  '@@@@@ Not found an old pending transaction comparing with ${pend.toStringSmall(myPubKey)}');
              newPendingTransactions
                  .add(pend.copyWith(type: TransactionType.missing));
            }
          }
        }
        newState = newState.copyWith(
            transactions: newTransactions,
            pendingTransactions: newPendingTransactions);
      }

      if (inDevelopment) {
        clear();
      }

      emit(newState);
      for (final Transaction tx in newState.transactions.reversed) {
        if (tx.type == TransactionType.received &&
            newState.latestReceivedNotification.isBefore(tx.time)) {
          // Future
          final Contact from = tx.from;
          NotificationController.createNewNotification(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: tx.amount / 100,
              from: from.title);
          emit(newState.copyWith(latestReceivedNotification: tx.time));
        }
        if (tx.type == TransactionType.sent &&
            newState.latestSentNotification.isBefore(tx.time)) {
          // Future
          final Contact to = tx.to;
          NotificationController.createNewNotification(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: -tx.amount / 100,
              to: to.title);
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

  @override
  TransactionState fromJson(Map<String, dynamic> json) =>
      TransactionState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TransactionState state) => state.toJson();

  List<Transaction> get transactions => state.transactions;

  double get balance => state.balance;

  DateTime get lastChecked => state.lastChecked;

  void addUpdatePendingTransaction(Transaction tx) {
    final TransactionState currentState = state;
    final List<Transaction> newPendingTransactions = <Transaction>[];
    for (final Transaction t in state.pendingTransactions) {
      if (tx.from == t.from &&
          tx.to == t.to &&
          tx.amount == t.amount &&
          tx.comment == t.comment) {
        newPendingTransactions.add(
            t.copyWith(time: DateTime.now(), type: TransactionType.pending));
      } else {
        newPendingTransactions.add(t);
      }
    }
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }
}
