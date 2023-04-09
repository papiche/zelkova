import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../shared_prefs.dart';
import '../../ui/contacts_cache.dart';
import '../../ui/logger.dart';
import '../../ui/notification_controller.dart';
import 'contact.dart';
import 'node_list_cubit.dart';
import 'transaction.dart';
import 'transaction_balance_state.dart';
import 'transaction_type.dart';

class TransactionsCubit extends HydratedCubit<TransactionsAndBalanceState> {
  TransactionsCubit()
      : super(TransactionsAndBalanceState(
            transactions: const <Transaction>[],
            balance: 0,
            lastChecked: DateTime.now()));

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

  Future<void> fetchTransactions(NodeListCubit cubit) async {
    logger('Loading transactions --------------------');
    final Map<String, dynamic>? txData =
        await gvaHistoryAndBalance(SharedPreferencesHelper().getPubKey());
    if (txData == null) {
      logger('Failed to get transactions');
      return;
    }
    final TransactionsAndBalanceState newState =
        transactionsGvaParser(txData, state);
    // Notify
    //logger(
    //  'Last received: ${lastReceived.toIso8601String()}, last received notification: ${lastReceivedNotification.toIso8601String()}, compared ${lastReceived.compareTo(lastReceivedNotification)}');
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
