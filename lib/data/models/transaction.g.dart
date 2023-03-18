// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction from(String from);

  Transaction to(String to);

  Transaction amount(int amount);

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
    String? from,
    String? to,
    int? amount,
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
  Transaction from(String from) => this(from: from);

  @override
  Transaction to(String to) => this(to: to);

  @override
  Transaction amount(int amount) => this(amount: amount);

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
          : amount as int,
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

abstract class _$TransactionsAndBalanceStateCWProxy {
  TransactionsAndBalanceState transactions(List<Transaction> transactions);

  TransactionsAndBalanceState balance(int balance);

  TransactionsAndBalanceState lastChecked(DateTime lastChecked);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionsAndBalanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionsAndBalanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionsAndBalanceState call({
    List<Transaction>? transactions,
    int? balance,
    DateTime? lastChecked,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionsAndBalanceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionsAndBalanceState.copyWith.fieldName(...)`
class _$TransactionsAndBalanceStateCWProxyImpl
    implements _$TransactionsAndBalanceStateCWProxy {
  const _$TransactionsAndBalanceStateCWProxyImpl(this._value);

  final TransactionsAndBalanceState _value;

  @override
  TransactionsAndBalanceState transactions(List<Transaction> transactions) =>
      this(transactions: transactions);

  @override
  TransactionsAndBalanceState balance(int balance) => this(balance: balance);

  @override
  TransactionsAndBalanceState lastChecked(DateTime lastChecked) =>
      this(lastChecked: lastChecked);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionsAndBalanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionsAndBalanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionsAndBalanceState call({
    Object? transactions = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
    Object? lastChecked = const $CopyWithPlaceholder(),
  }) {
    return TransactionsAndBalanceState(
      transactions:
          transactions == const $CopyWithPlaceholder() || transactions == null
              ? _value.transactions
              // ignore: cast_nullable_to_non_nullable
              : transactions as List<Transaction>,
      balance: balance == const $CopyWithPlaceholder() || balance == null
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as int,
      lastChecked:
          lastChecked == const $CopyWithPlaceholder() || lastChecked == null
              ? _value.lastChecked
              // ignore: cast_nullable_to_non_nullable
              : lastChecked as DateTime,
    );
  }
}

extension $TransactionsAndBalanceStateCopyWith on TransactionsAndBalanceState {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionsAndBalanceState.copyWith(...)` or like so:`instanceOfTransactionsAndBalanceState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionsAndBalanceStateCWProxy get copyWith =>
      _$TransactionsAndBalanceStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      from: json['from'] as String,
      to: json['to'] as String,
      amount: json['amount'] as int,
      comment: json['comment'] as String,
      time: DateTime.parse(json['time'] as String),
      toAvatar: uIntFromList(json['toAvatar'] as List<int>),
      toNick: json['toNick'] as String?,
      fromAvatar: uIntFromList(json['fromAvatar'] as List<int>),
      fromNick: json['fromNick'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'toAvatar': uIntToList(instance.toAvatar),
      'toNick': instance.toNick,
      'amount': instance.amount,
      'fromAvatar': uIntToList(instance.fromAvatar),
      'fromNick': instance.fromNick,
      'comment': instance.comment,
      'time': instance.time.toIso8601String(),
    };

TransactionsAndBalanceState _$TransactionsAndBalanceStateFromJson(
        Map<String, dynamic> json) =>
    TransactionsAndBalanceState(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: json['balance'] as int,
      lastChecked: DateTime.parse(json['lastChecked'] as String),
    );

Map<String, dynamic> _$TransactionsAndBalanceStateToJson(
        TransactionsAndBalanceState instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
      'balance': instance.balance,
      'lastChecked': instance.lastChecked.toIso8601String(),
    };
