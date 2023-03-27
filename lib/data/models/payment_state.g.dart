// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentState _$PaymentStateFromJson(Map<String, dynamic> json) => PaymentState(
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      comment: json['comment'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.notSent,
    );

Map<String, dynamic> _$PaymentStateToJson(PaymentState instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'comment': instance.comment,
      'amount': instance.amount,
      'status': _$PaymentStatusEnumMap[instance.status]!,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.notSent: 'notSent',
  PaymentStatus.sending: 'sending',
  PaymentStatus.isSent: 'isSent',
};
