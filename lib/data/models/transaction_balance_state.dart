import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'transaction.dart';

part 'transaction_balance_state.g.dart';

@JsonSerializable()
@CopyWith()
class TransactionsAndBalanceState extends Equatable {
  TransactionsAndBalanceState({required this.transactions,
    required this.balance,
    required this.lastChecked,
    DateTime? latestSentNotification,
    DateTime? latestReceivedNotification})
      : latestSentNotification = latestSentNotification ?? DateTime.now(),
        latestReceivedNotification =
            latestReceivedNotification ?? DateTime.now();

  factory TransactionsAndBalanceState.fromJson(Map<String, dynamic> json) =>
      _$TransactionsAndBalanceStateFromJson(json);

  final List<Transaction> transactions;
  final double balance;
  final DateTime lastChecked;
  final DateTime latestSentNotification;
  final DateTime latestReceivedNotification;

  Map<String, dynamic> toJson() => _$TransactionsAndBalanceStateToJson(this);

  @override
  List<Object?> get props =>
      <dynamic>[
        transactions,
        balance,
        lastChecked,
        latestSentNotification,
        latestReceivedNotification
      ];
}
