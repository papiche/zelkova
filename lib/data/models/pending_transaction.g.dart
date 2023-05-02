// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PendingTransactionCWProxy {
  PendingTransaction amount(double amount);

  PendingTransaction comment(String comment);

  PendingTransaction time(DateTime time);

  PendingTransaction from(Contact from);

  PendingTransaction to(Contact to);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PendingTransaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PendingTransaction(...).copyWith(id: 12, name: "My name")
  /// ````
  PendingTransaction call({
    double? amount,
    String? comment,
    DateTime? time,
    Contact? from,
    Contact? to,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPendingTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPendingTransaction.copyWith.fieldName(...)`
class _$PendingTransactionCWProxyImpl implements _$PendingTransactionCWProxy {
  const _$PendingTransactionCWProxyImpl(this._value);

  final PendingTransaction _value;

  @override
  PendingTransaction amount(double amount) => this(amount: amount);

  @override
  PendingTransaction comment(String comment) => this(comment: comment);

  @override
  PendingTransaction time(DateTime time) => this(time: time);

  @override
  PendingTransaction from(Contact from) => this(from: from);

  @override
  PendingTransaction to(Contact to) => this(to: to);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PendingTransaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PendingTransaction(...).copyWith(id: 12, name: "My name")
  /// ````
  PendingTransaction call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
  }) {
    return PendingTransaction(
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
    );
  }
}

extension $PendingTransactionCopyWith on PendingTransaction {
  /// Returns a callable class that can be used as follows: `instanceOfPendingTransaction.copyWith(...)` or like so:`instanceOfPendingTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PendingTransactionCWProxy get copyWith =>
      _$PendingTransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingTransaction _$PendingTransactionFromJson(Map<String, dynamic> json) =>
    PendingTransaction(
      amount: (json['amount'] as num).toDouble(),
      comment: json['comment'] as String,
      time: DateTime.parse(json['time'] as String),
      from: Contact.fromJson(json['from'] as Map<String, dynamic>),
      to: Contact.fromJson(json['to'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingTransactionToJson(PendingTransaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
    };
