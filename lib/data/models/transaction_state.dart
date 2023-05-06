import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'pending_transaction.dart';
import 'transaction.dart';

part 'transaction_state.g.dart';

@JsonSerializable()
@CopyWith()
class TransactionState extends Equatable {
  TransactionState(
      {required this.transactions,
      required this.pendingTransactions,
      required this.balance,
      required this.lastChecked,
      DateTime? latestSentNotification,
      DateTime? latestReceivedNotification,
      this.endCursor})
      : latestSentNotification = latestSentNotification ?? DateTime.now(),
        latestReceivedNotification =
            latestReceivedNotification ?? DateTime.now();

  factory TransactionState.fromJson(Map<String, dynamic> json) =>
      _$TransactionStateFromJson(json);

  final List<Transaction> transactions;
  final List<PendingTransaction> pendingTransactions;
  final double balance;
  final DateTime lastChecked;
  final DateTime latestSentNotification;
  final DateTime latestReceivedNotification;
  final String? endCursor;

  Map<String, dynamic> toJson() => _$TransactionStateToJson(this);

  @override
  List<Object?> get props => <dynamic>[
        transactions,
        pendingTransactions,
        balance,
        lastChecked,
        latestSentNotification,
        latestReceivedNotification,
        endCursor
      ];
}
