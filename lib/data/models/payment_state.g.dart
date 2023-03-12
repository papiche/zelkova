// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentState _$PaymentStateFromJson(Map<String, dynamic> json) => PaymentState(
      publicKey: json['publicKey'] as String,
      nick: json['nick'] as String,
      avatar: PaymentState._fromList(json['avatar'] as List<int>),
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      isSent: json['isSent'] as bool,
    );

Map<String, dynamic> _$PaymentStateToJson(PaymentState instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'nick': instance.nick,
      'avatar': PaymentState._toList(instance.avatar),
      'description': instance.description,
      'amount': instance.amount,
      'isSent': instance.isSent,
    };
