import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';
import 'transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
@CopyWith()
class Transaction extends Equatable {
  const Transaction({
    required this.type,
    required this.amount,
    required this.comment,
    required this.time,
    required this.from,
    required this.to,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final TransactionType type;
  final Contact from;
  final Contact to;
  final double amount;
  final String comment;
  final DateTime time;

  bool get isOutgoing =>
      type == TransactionType.sending ||
      type == TransactionType.sent ||
      type == TransactionType.pending;

  bool get isIncoming =>
      type == TransactionType.receiving || type == TransactionType.received;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => <dynamic>[type, from, to, amount, comment, time];
}
