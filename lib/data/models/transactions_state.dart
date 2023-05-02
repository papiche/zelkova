part of 'transactions_bloc.dart';

class TransactionsState {
  TransactionsState({
    this.itemList,
    this.error,
    this.nextPageKey,
  });

  final List<Transaction>? itemList;
  final dynamic error;
  final String? nextPageKey;
}
