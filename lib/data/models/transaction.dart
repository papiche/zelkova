import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model_utils.dart';
import 'transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
@CopyWith()
class Transaction extends Equatable {
  const Transaction({
    required this.type,
    required this.from,
    required this.to,
    required this.amount,
    required this.comment,
    required this.time,
    this.toAvatar,
    this.toNick,
    this.fromAvatar,
    this.fromNick,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final TransactionType type;
  final String from;
  final String to;
  final double amount;
  final String comment;
  final DateTime time;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? toAvatar;
  final String? toNick;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? fromAvatar;
  final String? fromNick;

  bool get isOutgoing =>
      type == TransactionType.sending || type == TransactionType.sent;

  bool get isIncoming =>
      type == TransactionType.receiving || type == TransactionType.received;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => <dynamic>[
        type,
        from,
        to,
        amount,
        comment,
        time,
        toAvatar,
        toNick,
        fromAvatar,
        fromNick
      ];
}

@JsonSerializable()
@CopyWith()
class TransactionsAndBalanceState extends Equatable {
  const TransactionsAndBalanceState(
      {required this.transactions,
      required this.balance,
      required this.lastChecked,
      this.lastSent,
      this.lastReceivedAmount,
      this.lastReceived,
      this.lastReceivedNotif});

  factory TransactionsAndBalanceState.fromJson(Map<String, dynamic> json) =>
      _$TransactionsAndBalanceStateFromJson(json);
  final List<Transaction> transactions;
  final double balance;
  final DateTime lastChecked;
  final DateTime? lastSent;
  final double? lastReceivedAmount;
  final DateTime? lastReceived;
  final DateTime? lastReceivedNotif;

  Map<String, dynamic> toJson() => _$TransactionsAndBalanceStateToJson(this);

  @override
  List<Object?> get props => <dynamic>[
        transactions,
        balance,
        lastChecked,
        lastSent,
        lastReceivedAmount,
        lastReceived,
        lastReceivedNotif
      ];
}
