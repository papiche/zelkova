import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../ui/ui_helpers.dart';
import 'contact.dart';
import 'transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
@CopyWith()
class Transaction extends Equatable {
  const Transaction(
      {required this.type,
      required this.amount,
      required this.comment,
      required this.time,
      required this.from,
      required this.to,
      this.debugInfo});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final TransactionType type;
  final Contact from;
  final Contact to;
  final double amount;
  final String comment;
  final DateTime time;
  final String? debugInfo;

/*
  bool get isOutgoing =>
      type == TransactionType.sending ||
      type == TransactionType.sent ||
      type == TransactionType.pending;


bool get isProcessing =>
    type == TransactionType.sending ||
    type == TransactionType.receiving ||
    type == TransactionType.pending; */

  bool get isPending =>
      type == TransactionType.pending || type == TransactionType.failed;

  bool get isIncoming =>
      type == TransactionType.receiving || type == TransactionType.received;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  String toStringSmall(String pubKey) =>
      "Transaction { type: ${type.name}, from: ${from.toStringSmall(pubKey)}, to: ${to.toStringSmall(pubKey)}, amount: $amount, comment: $comment, time: ${humanizeTime(time, 'en')}, debugInfo: '$debugInfo' }";

  @override
  List<Object?> get props =>
      <dynamic>[type, from, to, amount, comment, time, debugInfo];
}
