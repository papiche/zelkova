import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_helper.dart';
import 'model_utils.dart';

part 'payment_state.g.dart';

enum PaymentStatus { notSent, sending, isSent }

@JsonSerializable()
class PaymentState extends Equatable {
  const PaymentState({
    required this.publicKey,
    this.nick,
    this.avatar,
    this.comment = '',
    this.amount,
    this.status = PaymentStatus.notSent,
  });

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);

  bool canBeSent() =>
      status == PaymentStatus.notSent &&
      validateKey(publicKey) &&
      amount != null &&
      amount! > 0;

  final String publicKey;
  final String? nick;
  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? avatar;
  final String comment;
  final double? amount;
  final PaymentStatus status;

  Map<String, dynamic> toJson() => _$PaymentStateToJson(this);

  PaymentState copyWith({
    String? publicKey,
    String? nick,
    Uint8List? avatar,
    String? comment,
    double? amount,
    PaymentStatus? status,
  }) {
    return PaymentState(
      publicKey: publicKey ?? this.publicKey,
      nick: nick ?? this.nick,
      avatar: avatar ?? this.avatar,
      comment: comment ?? this.comment,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  static PaymentState emptyPayment = const PaymentState(
    publicKey: '',
    nick: '',
  );

  @override
  String toString() {
    return '$publicKey ${amount ?? ""}';
  }

  @override
  List<Object?> get props =>
      <dynamic>[publicKey, nick, avatar, comment, amount, status];
}
