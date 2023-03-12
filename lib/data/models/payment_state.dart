import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_state.g.dart';

@JsonSerializable()
class PaymentState extends Equatable {
  const PaymentState({
    required this.publicKey,
    required this.nick,
    this.avatar,
    required this.description,
    required this.amount,
    required this.isSent,
  });

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);

  final String publicKey;
  final String nick;
  @JsonKey(fromJson: _fromList, toJson: _toList)
  final Uint8List? avatar;
  final String description;
  final double amount;
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
    description: '',
    amount: 0,
    isSent: false,
  );

  @override
  List<Object?> get props =>
      <dynamic>[publicKey, nick, avatar, description, amount, isSent];

  static Uint8List _fromList(List<int> list) => Uint8List.fromList(list);

  static List<int> _toList(Uint8List? uint8List) =>
      uint8List != null ? uint8List.toList() : <int>[];
}
