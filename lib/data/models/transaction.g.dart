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

  Transaction to(Contact to);

  Transaction recipients(List<Contact>? recipients);

  Transaction recipientsAmounts(List<double>? recipientsAmounts);

  Transaction debugInfo(String? debugInfo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    TransactionType? type,
    double? amount,
    String? comment,
    DateTime? time,
    Contact? from,
    Contact? to,
    List<Contact>? recipients,
    List<double>? recipientsAmounts,
    String? debugInfo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransaction.copyWith.fieldName(...)`
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  const _$TransactionCWProxyImpl(this._value);

  final Transaction _value;

  @override
  Transaction type(TransactionType type) => this(type: type);

  @override
  Transaction amount(double amount) => this(amount: amount);

  @override
  Transaction comment(String comment) => this(comment: comment);

  @override
  Transaction time(DateTime time) => this(time: time);

  @override
  Transaction from(Contact from) => this(from: from);

  @override
  Transaction to(Contact to) => this(to: to);

  @override
  Transaction recipients(List<Contact>? recipients) =>
      this(recipients: recipients);

  @override
  Transaction recipientsAmounts(List<double>? recipientsAmounts) =>
      this(recipientsAmounts: recipientsAmounts);

  @override
  Transaction debugInfo(String? debugInfo) => this(debugInfo: debugInfo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    Object? type = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
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
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as Contact,
      recipients: recipients == const $CopyWithPlaceholder()
          ? _value.recipients
          // ignore: cast_nullable_to_non_nullable
          : recipients as List<Contact>?,
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
  /// Returns a callable class that can be used as follows: `instanceOfTransaction.copyWith(...)` or like so:`instanceOfTransaction.copyWith.fieldName(...)`.
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
      to: Contact.fromJson(json['to'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
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
      'to': instance.to,
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
};
