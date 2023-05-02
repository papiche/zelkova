import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';

part 'pending_transaction.g.dart';

@JsonSerializable()
@CopyWith()
class PendingTransaction extends Equatable {
  const PendingTransaction({
    required this.amount,
    required this.comment,
    required this.time,
    required this.from,
    required this.to,
  });

  factory PendingTransaction.fromJson(Map<String, dynamic> json) =>
      _$PendingTransactionFromJson(json);

  final Contact from;
  final Contact to;
  final double amount;
  final String comment;
  final DateTime time;

  Map<String, dynamic> toJson() => _$PendingTransactionToJson(this);

  @override
  List<Object?> get props => <dynamic>[from, to, amount, comment, time];
}
