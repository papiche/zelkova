import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../shared_prefs.dart';
import '../../ui/contacts_cache.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import 'contact.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';
import 'transaction.dart';
import 'transaction_balance_state.dart';
import 'transaction_type.dart';

class TransactionsCubit extends HydratedCubit<TransactionsAndBalanceState> {
  TransactionsCubit()
      : super(TransactionsAndBalanceState(
            transactions: const <Transaction>[],
            balance: 0,
            lastChecked: DateTime.now()));

  @override
  String get storagePrefix =>
      kIsWeb ? 'TransactionsCubit' : super.storagePrefix;

  void addTransaction(Transaction transaction) {
    final TransactionsAndBalanceState currentState = state;
    final List<Transaction> newTransactions =
        List<Transaction>.of(currentState.transactions)..add(transaction);
    final double newBalance = currentState.balance + transaction.amount;
    emit(currentState.copyWith(
        transactions: newTransactions, balance: newBalance));
  }

  void updateTransactions(
      List<Transaction> newTransactions, double newBalance) {
    emit(state.copyWith(transactions: newTransactions, balance: newBalance));
  }

  Future<void> fetchTransactions(NodeListCubit cubit, {int retries = 5}) async {
    Tuple2<Map<String, dynamic>?, Node> txDataResult;
    bool success = false;

    for (int attempt = 0; attempt < retries; attempt++) {
      txDataResult =
          await gvaHistoryAndBalance(SharedPreferencesHelper().getPubKey());
      final Node node = txDataResult.item2;
      logger('Loading transactions using $node --------------------');

      if (txDataResult.item1 == null) {
        logger(
            'Failed to get transactions, attempt ${attempt + 1} of $retries');
        await Future<void>.delayed(const Duration(seconds: 1));
        increaseNodeErrors(NodeType.gva, node);
        continue;
      }

      final Map<String, dynamic> txData = txDataResult.item1!;
      final TransactionsAndBalanceState newState =
          transactionsGvaParser(txData, state);

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
      emit(newState);
      for (final Transaction tx in newState.transactions.reversed) {
        if (tx.type == TransactionType.received &&
            newState.latestReceivedNotification.isBefore(tx.time)) {
          // Future
          final Contact from = await ContactsCache().getContact(tx.from);
          NotificationController.createNewNotification(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: tx.amount / 100,
              from: from.title);
          emit(newState.copyWith(latestReceivedNotification: tx.time));
        }
        if (tx.type == TransactionType.sent &&
            newState.latestSentNotification.isBefore(tx.time)) {
          // Future
          final Contact to = await ContactsCache().getContact(tx.from);
          NotificationController.createNewNotification(
              tx.time.millisecondsSinceEpoch.toString(),
              amount: -tx.amount / 100,
              to: to.title);
          emit(newState.copyWith(latestSentNotification: tx.time));
        }
      }
    }
    if (!success) {
      logger('Failed to get transactions after $retries attempts');
      return;
    }
  }

  @override
  TransactionsAndBalanceState fromJson(Map<String, dynamic> json) =>
      TransactionsAndBalanceState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TransactionsAndBalanceState state) =>
      state.toJson();

  List<Transaction> get transactions => state.transactions;

  double get balance => state.balance;

  DateTime get lastChecked => state.lastChecked;
}
