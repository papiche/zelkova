import 'package:hydrated_bloc/hydrated_bloc.dart';

class Transaction {
  Transaction(
      {required this.from,
      required this.to,
      required this.amount,
      required this.comment,
      required this.time});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      from: map['from'] as String,
      to: map['to'] as String,
      amount: map['amount'] as int,
      comment: map['comment'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  final String from;
  final String to;
  final int amount;
  final String comment;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'amount': amount,
      'comment': comment,
      'time': time.millisecondsSinceEpoch,
    };
  }
}

class TransactionListBloc
    extends HydratedBloc<List<Transaction>, List<Transaction>> {
  TransactionListBloc() : super(<Transaction>[]);

  void addTransaction(Transaction transaction) {
    add(state..add(transaction));
  }

  void removeTransaction(Transaction transaction) {
    add(state..remove(transaction));
  }

  @override
  List<Transaction> fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> transactions =
        List<Map<String, dynamic>>.from(
            json['transactions'] as List<Map<String, dynamic>>);
    return transactions
        .map((dynamic e) => Transaction.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic> toJson(List<Transaction> state) {
    final List<dynamic> transactions =
        state.map((dynamic e) => e.toMap()).toList();
    return <String, dynamic>{'transactions': transactions};
  }
}

class TransactionsAndBalance {
  TransactionsAndBalance({required this.transactions, required this.balance});

  List<Transaction> transactions;
  int balance;
}
