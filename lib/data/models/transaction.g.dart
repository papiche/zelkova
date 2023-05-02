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

  Transaction fromC(Contact fromC);

  Transaction toC(Contact toC);

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
    Contact? fromC,
    Contact? toC,
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
  Transaction fromC(Contact fromC) => this(fromC: fromC);

  @override
  Transaction toC(Contact toC) => this(toC: toC);

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
    Object? fromC = const $CopyWithPlaceholder(),
    Object? toC = const $CopyWithPlaceholder(),
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
      fromC: fromC == const $CopyWithPlaceholder() || fromC == null
          ? _value.fromC
          // ignore: cast_nullable_to_non_nullable
          : fromC as Contact,
      toC: toC == const $CopyWithPlaceholder() || toC == null
          ? _value.toC
          // ignore: cast_nullable_to_non_nullable
          : toC as Contact,
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
      fromC: Contact.fromJson(json['fromC'] as Map<String, dynamic>),
      toC: Contact.fromJson(json['toC'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'fromC': instance.fromC,
      'toC': instance.toC,
      'amount': instance.amount,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.sending: 'sending',
  TransactionType.received: 'received',
  TransactionType.receiving: 'receiving',
  TransactionType.sent: 'sent',
  TransactionType.pending: 'pending',
};
