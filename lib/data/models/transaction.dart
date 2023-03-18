import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model_utils.dart';

part 'transaction.g.dart';

@JsonSerializable()
@CopyWith()
class Transaction extends Equatable {
  const Transaction({
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
  final String from;
  final String to;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? toAvatar;
  final String? toNick;
  final int amount;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? fromAvatar;
  final String? fromNick;
  final String comment;
  final DateTime time;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => <dynamic>[
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
  const TransactionsAndBalanceState({
    required this.transactions,
    required this.balance,
    required this.lastChecked,
  });

  factory TransactionsAndBalanceState.fromJson(Map<String, dynamic> json) =>
      _$TransactionsAndBalanceStateFromJson(json);
  final List<Transaction> transactions;
  final int balance;
  final DateTime lastChecked;

  Map<String, dynamic> toJson() => _$TransactionsAndBalanceStateToJson(this);

  @override
  List<Object?> get props => <dynamic>[transactions, balance, lastChecked];
}
