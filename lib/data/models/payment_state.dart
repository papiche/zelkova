import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model_utils.dart';

part 'payment_state.g.dart';

@JsonSerializable()
class PaymentState extends Equatable {
  const PaymentState({
    required this.publicKey,
    this.nick,
    this.avatar,
    this.description = '',
    this.amount,
    this.isSent = false,
  });

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);

  final String publicKey;
  final String? nick;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? avatar;
  final String description;
  final double? amount;
  final bool isSent;

  Map<String, dynamic> toJson() => _$PaymentStateToJson(this);

  PaymentState copyWith({
    String? publicKey,
    String? nick,
    Uint8List? avatar,
    String? description,
    double? amount,
    bool? isSent,
  }) {
    return PaymentState(
      publicKey: publicKey ?? this.publicKey,
      nick: nick ?? this.nick,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      isSent: isSent ?? this.isSent,
    );
  }

  static PaymentState emptyPayment = const PaymentState(
    publicKey: '',
    nick: '',
    amount: 0,
  );

  @override
  String toString() {
    return '$publicKey ${amount ?? ""}';
  }

  @override
  List<Object?> get props =>
      <dynamic>[publicKey, nick, avatar, description, amount, isSent];
}
