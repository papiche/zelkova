import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_helper.dart';
import '../../ui/ui_helpers.dart';
import 'contact.dart';
import 'transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
@CopyWith()
class Transaction extends Equatable {
  Transaction(
      {required this.type,
      required this.amount,
      required this.comment,
      required this.time,
      required this.from,
      required this.recipients,
      List<double>? recipientsAmounts,
      this.debugInfo})
      : recipientsAmounts = recipientsAmounts ?? <double>[amount];

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final TransactionType type;
  final Contact from;
  final double amount;
  final String comment;
  final DateTime time;
  final String? debugInfo;
  final List<Contact> recipients;
  final List<double> recipientsAmounts;

  bool get isFailed => type == TransactionType.failed;

  bool get isPending =>
      type == TransactionType.pending ||
      type == TransactionType.failed ||
      type == TransactionType.waitingNetwork;

  bool get isIncoming =>
      type == TransactionType.receiving || type == TransactionType.received;

  // Remove cash pay back address
  bool get isToMultiple => recipientsWithoutCashBack.length >= 2;

  List<Contact> get recipientsWithoutCashBack => recipients
      .where((Contact c) =>
          extractPublicKey(from.pubKey) != extractPublicKey(c.pubKey))
      .toList();

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  String toStringSmall(String pubKey) =>
      // ignore: deprecated_member_use_from_same_package
      "Transaction { type: ${type.name}, from: ${from.toStringSmall(pubKey)}, amount: $amount, comment: $comment, time: ${humanizeTime(time, 'en')}, debugInfo: '$debugInfo' }";

  @override
  List<Object?> get props => <dynamic>[
        type,
        from,
        amount,
        comment,
        time,
        // debugInfo,
        recipients,
        recipientsAmounts
      ];
}
