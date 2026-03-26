// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentStateCWProxy {
  PaymentState contacts(List<Contact>? contacts);

  PaymentState comment(String comment);

  PaymentState amount(double? amount);

  PaymentState currency(Currency currency);

  PaymentState status(PaymentStatus status);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentState(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentState call({
    List<Contact>? contacts,
    String comment,
    double? amount,
    Currency currency,
    PaymentStatus status,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentState.copyWith(...)` or call `instanceOfPaymentState.copyWith.fieldName(value)` for a single field.
class _$PaymentStateCWProxyImpl implements _$PaymentStateCWProxy {
  const _$PaymentStateCWProxyImpl(this._value);

  final PaymentState _value;

  @override
  PaymentState contacts(List<Contact>? contacts) => call(contacts: contacts);

  @override
  PaymentState comment(String comment) => call(comment: comment);

  @override
  PaymentState amount(double? amount) => call(amount: amount);

  @override
  PaymentState currency(Currency currency) => call(currency: currency);

  @override
  PaymentState status(PaymentStatus status) => call(status: status);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentState(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentState call({
    Object? contacts = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
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
      currency: currency == const $CopyWithPlaceholder() || currency == null
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as Currency,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PaymentStatus,
    );
  }
}

extension $PaymentStateCopyWith on PaymentState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentState.copyWith(...)` or `instanceOfPaymentState.copyWith.fieldName(...)`.
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
  currency:
      $enumDecodeNullable(_$CurrencyEnumMap, json['currency']) ?? Currency.ZEN,
  status:
      $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
      PaymentStatus.notSent,
);

Map<String, dynamic> _$PaymentStateToJson(PaymentState instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'comment': instance.comment,
      'amount': instance.amount,
      'currency': _$CurrencyEnumMap[instance.currency]!,
      'status': _$PaymentStatusEnumMap[instance.status]!,
    };

const _$CurrencyEnumMap = {
  Currency.G1: 'G1',
  Currency.DU: 'DU',
  Currency.ZEN: 'ZEN',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.notSent: 'notSent',
  PaymentStatus.sending: 'sending',
  PaymentStatus.isSent: 'isSent',
};
