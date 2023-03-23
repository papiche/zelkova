import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../shared_prefs.dart';
import '../../ui/logger.dart';
import '../../ui/ui_helpers.dart';
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
    logger('GVA balance: ${gvaBalance()}');
    final String txData = txDebugging
        ? await getTxHistory('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH')
        : await getTxHistory(SharedPreferencesHelper().getPubKey());
    final TransactionsAndBalanceState state = transactionParser(txData);
    emit(state.copyWith(
        transactions: state.transactions,
        balance: state.balance,
        lastChecked: state.lastChecked));
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
