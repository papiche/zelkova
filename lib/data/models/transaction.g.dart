// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction type(TransactionType type);

  Transaction amount(double amount);

  Transaction comment(String comment);

  Transaction time(DateTime time);

  Transaction from(Contact from);

  Transaction recipients(List<Contact> recipients);

  Transaction recipientsAmounts(List<double>? recipientsAmounts);

  Transaction debugInfo(String? debugInfo);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Transaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ```
  Transaction call({
    TransactionType type,
    double amount,
    String comment,
    DateTime time,
    Contact from,
    List<Contact> recipients,
    List<double>? recipientsAmounts,
    String? debugInfo,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransaction.copyWith(...)` or call `instanceOfTransaction.copyWith.fieldName(value)` for a single field.
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  const _$TransactionCWProxyImpl(this._value);

  final Transaction _value;

  @override
  Transaction type(TransactionType type) => call(type: type);

  @override
  Transaction amount(double amount) => call(amount: amount);

  @override
  Transaction comment(String comment) => call(comment: comment);

  @override
  Transaction time(DateTime time) => call(time: time);

  @override
  Transaction from(Contact from) => call(from: from);

  @override
  Transaction recipients(List<Contact> recipients) =>
      call(recipients: recipients);

  @override
  Transaction recipientsAmounts(List<double>? recipientsAmounts) =>
      call(recipientsAmounts: recipientsAmounts);

  @override
  Transaction debugInfo(String? debugInfo) => call(debugInfo: debugInfo);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Transaction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ```
  Transaction call({
    Object? type = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? recipients = const $CopyWithPlaceholder(),
    Object? recipientsAmounts = const $CopyWithPlaceholder(),
    Object? debugInfo = const $CopyWithPlaceholder(),
  }) {
    return Transaction(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as TransactionType,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as double,
      comment: comment == const $CopyWithPlaceholder() || comment == null
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
      time: time == const $CopyWithPlaceholder() || time == null
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as DateTime,
      from: from == const $CopyWithPlaceholder() || from == null
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as Contact,
      recipients:
          recipients == const $CopyWithPlaceholder() || recipients == null
          ? _value.recipients
          // ignore: cast_nullable_to_non_nullable
          : recipients as List<Contact>,
      recipientsAmounts: recipientsAmounts == const $CopyWithPlaceholder()
          ? _value.recipientsAmounts
          // ignore: cast_nullable_to_non_nullable
          : recipientsAmounts as List<double>?,
      debugInfo: debugInfo == const $CopyWithPlaceholder()
          ? _value.debugInfo
          // ignore: cast_nullable_to_non_nullable
          : debugInfo as String?,
    );
  }
}

extension $TransactionCopyWith on Transaction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransaction.copyWith(...)` or `instanceOfTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionCWProxy get copyWith => _$TransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toDouble(),
  comment: json['comment'] as String,
  time: DateTime.parse(json['time'] as String),
  from: Contact.fromJson(json['from'] as Map<String, dynamic>),
  recipients: (json['recipients'] as List<dynamic>)
      .map((e) => Contact.fromJson(e as Map<String, dynamic>))
      .toList(),
  recipientsAmounts: (json['recipientsAmounts'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  debugInfo: json['debugInfo'] as String?,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'from': instance.from,
      'amount': instance.amount,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
      'debugInfo': instance.debugInfo,
      'recipients': instance.recipients,
      'recipientsAmounts': instance.recipientsAmounts,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.sending: 'sending',
  TransactionType.received: 'received',
  TransactionType.receiving: 'receiving',
  TransactionType.sent: 'sent',
  TransactionType.pending: 'pending',
  TransactionType.failed: 'failed',
  TransactionType.waitingNetwork: 'waitingNetwork',
  TransactionType.dividendReceived: 'dividendReceived',
};
