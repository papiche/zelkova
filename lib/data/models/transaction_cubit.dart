import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../shared_prefs.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import 'contact.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';
import 'pending_transaction.dart';
import 'transaction.dart';
import 'transaction_state.dart';
import 'transaction_type.dart';

class TransactionCubit extends HydratedCubit<TransactionState> {
  TransactionCubit()
      : super(TransactionState(
      transactions: const <Transaction>[],
      pendingTransactions: const <PendingTransaction>[],
      balance: 0,
      lastChecked: DateTime.now()));

  @override
  String get storagePrefix =>
      kIsWeb ? 'TransactionsCubit' : super.storagePrefix;

  void addPendingTransaction(PendingTransaction pendingTransaction) {
    final TransactionState currentState = state;
    final List<PendingTransaction> newPendingTransactions =
    List<PendingTransaction>.of(currentState.pendingTransactions)
      ..add(pendingTransaction);
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }

  void removePendingTransaction(PendingTransaction pendingTransaction) {
    final TransactionState currentState = state;
    final List<PendingTransaction> newPendingTransactions =
    List<PendingTransaction>.of(currentState.pendingTransactions)
      ..remove(pendingTransaction);
    emit(currentState.copyWith(pendingTransactions: newPendingTransactions));
  }

  Future<List<Transaction>> fetchTransactions(NodeListCubit cubit,
      {int retries = 5, int? pageSize, String? cursor}) async {
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;

    for (int attempt = 0; attempt < retries; attempt++) {
      txDataResult = await gvaHistoryAndBalance(
          SharedPreferencesHelper().getPubKey(), pageSize, cursor);
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
      final TransactionState newState =
      await transactionsGvaParser(txData, state);

      if (newState.balance < 0) {
        logger('Warning: Negative balance in node ${txDataResult.item2}');
        increaseNodeErrors(NodeType.gva, node);
        continue;
      }
      success = true;

      logger(
          'Last received notification: ${newState.latestReceivedNotification
              .toIso8601String()})}');
      logger(
          'Last sent notification: ${newState.latestSentNotification
              .toIso8601String()})}');

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
}
