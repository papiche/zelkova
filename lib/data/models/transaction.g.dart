// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction type(TransactionType type);

  Transaction from(String from);

  Transaction to(String to);

  Transaction amount(double amount);

  Transaction comment(String comment);

  Transaction time(DateTime time);

  Transaction toAvatar(Uint8List? toAvatar);

  Transaction toNick(String? toNick);

  Transaction fromAvatar(Uint8List? fromAvatar);

  Transaction fromNick(String? fromNick);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    TransactionType? type,
    String? from,
    String? to,
    double? amount,
    String? comment,
    DateTime? time,
    Uint8List? toAvatar,
    String? toNick,
    Uint8List? fromAvatar,
    String? fromNick,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransaction.copyWith.fieldName(...)`
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  const _$TransactionCWProxyImpl(this._value);

  final Transaction _value;

  @override
  Transaction type(TransactionType type) => this(type: type);

  @override
  Transaction from(String from) => this(from: from);

  @override
  Transaction to(String to) => this(to: to);

  @override
  Transaction amount(double amount) => this(amount: amount);

  @override
  Transaction comment(String comment) => this(comment: comment);

  @override
  Transaction time(DateTime time) => this(time: time);

  @override
  Transaction toAvatar(Uint8List? toAvatar) => this(toAvatar: toAvatar);

  @override
  Transaction toNick(String? toNick) => this(toNick: toNick);

  @override
  Transaction fromAvatar(Uint8List? fromAvatar) => this(fromAvatar: fromAvatar);

  @override
  Transaction fromNick(String? fromNick) => this(fromNick: fromNick);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? toAvatar = const $CopyWithPlaceholder(),
    Object? toNick = const $CopyWithPlaceholder(),
    Object? fromAvatar = const $CopyWithPlaceholder(),
    Object? fromNick = const $CopyWithPlaceholder(),
  }) {
    return Transaction(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as TransactionType,
      from: from == const $CopyWithPlaceholder() || from == null
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as String,
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as String,
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
      toAvatar: toAvatar == const $CopyWithPlaceholder()
          ? _value.toAvatar
          // ignore: cast_nullable_to_non_nullable
          : toAvatar as Uint8List?,
      toNick: toNick == const $CopyWithPlaceholder()
          ? _value.toNick
          // ignore: cast_nullable_to_non_nullable
          : toNick as String?,
      fromAvatar: fromAvatar == const $CopyWithPlaceholder()
          ? _value.fromAvatar
          // ignore: cast_nullable_to_non_nullable
          : fromAvatar as Uint8List?,
      fromNick: fromNick == const $CopyWithPlaceholder()
          ? _value.fromNick
          // ignore: cast_nullable_to_non_nullable
          : fromNick as String?,
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
      from: json['from'] as String,
      to: json['to'] as String,
      amount: (json['amount'] as num).toDouble(),
      comment: json['comment'] as String,
      time: DateTime.parse(json['time'] as String),
      toAvatar: uIntFromList(json['toAvatar']),
      toNick: json['toNick'] as String?,
      fromAvatar: uIntFromList(json['fromAvatar']),
      fromNick: json['fromNick'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
      'toAvatar': uIntToList(instance.toAvatar),
      'toNick': instance.toNick,
      'fromAvatar': uIntToList(instance.fromAvatar),
      'fromNick': instance.fromNick,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.sending: 'sending',
  TransactionType.received: 'received',
  TransactionType.receiving: 'receiving',
  TransactionType.sent: 'sent',
  TransactionType.pending: 'pending',
};
