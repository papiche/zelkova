import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../notification_controller.dart';
import '../../shared_prefs.dart';
import '../../ui/logger.dart';
import 'node_list_cubit.dart';
import 'transaction.dart';

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
    logger('Loading transactions');
    final Map<String, dynamic>? txData =
        await gvaHistoryAndBalance(SharedPreferencesHelper().getPubKey());
    if (txData == null) {
      logger('Failed to get transactions');
      return;
    }
    final TransactionsAndBalanceState state = transactionsGvaParser(txData);
    emit(state.copyWith(
        transactions: state.transactions,
        balance: state.balance,
        lastChecked: state.lastChecked));
    final DateTime? lastReceived = state.lastReceived;
    final DateTime lastReceivedNotification =
        state.lastReceivedNotif ?? DateTime(1970);
    final double? lastReceivedAmount = state.lastReceivedAmount;
    // final DateTime? lastSent = transBalanceState.lastSent;
    if (lastReceived != null &&
        lastReceivedNotification.compareTo(lastReceived) == 1) {
      // Notify
      emit(state.copyWith(lastReceivedNotif: lastReceived));
      NotificationController.createNewNotification(
          lastReceived.millisecondsSinceEpoch.toString(),
          amount: lastReceivedAmount! / 100);
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
