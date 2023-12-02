// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentStateCWProxy {
  PaymentState contacts(List<Contact>? contacts);

  PaymentState comment(String comment);

  PaymentState amount(double? amount);

  PaymentState status(PaymentStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentState(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentState call({
    List<Contact>? contacts,
    String? comment,
    double? amount,
    PaymentStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaymentState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaymentState.copyWith.fieldName(...)`
class _$PaymentStateCWProxyImpl implements _$PaymentStateCWProxy {
  const _$PaymentStateCWProxyImpl(this._value);

  final PaymentState _value;

  @override
  PaymentState contacts(List<Contact>? contacts) => this(contacts: contacts);

  @override
  PaymentState comment(String comment) => this(comment: comment);

  @override
  PaymentState amount(double? amount) => this(amount: amount);

  @override
  PaymentState status(PaymentStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentState(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentState call({
    Object? contacts = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PaymentState(
      contacts: contacts == const $CopyWithPlaceholder()
          ? _value.contacts
          // ignore: cast_nullable_to_non_nullable
          : contacts as List<Contact>?,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as double?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PaymentStatus,
    );
  }
}

extension $PaymentStateCopyWith on PaymentState {
  /// Returns a callable class that can be used as follows: `instanceOfPaymentState.copyWith(...)` or like so:`instanceOfPaymentState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentStateCWProxy get copyWith => _$PaymentStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentState _$PaymentStateFromJson(Map<String, dynamic> json) => PaymentState(
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.notSent,
    );

Map<String, dynamic> _$PaymentStateToJson(PaymentState instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'comment': instance.comment,
      'amount': instance.amount,
      'status': _$PaymentStatusEnumMap[instance.status]!,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.notSent: 'notSent',
  PaymentStatus.sending: 'sending',
  PaymentStatus.isSent: 'isSent',
};
