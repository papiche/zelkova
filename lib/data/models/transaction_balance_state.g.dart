// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_balance_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionsAndBalanceStateCWProxy {
  TransactionsAndBalanceState transactions(List<Transaction> transactions);

  TransactionsAndBalanceState balance(double balance);

  TransactionsAndBalanceState lastChecked(DateTime lastChecked);

  TransactionsAndBalanceState latestSentNotification(
      DateTime? latestSentNotification);

  TransactionsAndBalanceState latestReceivedNotification(
      DateTime? latestReceivedNotification);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionsAndBalanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionsAndBalanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionsAndBalanceState call({
    List<Transaction>? transactions,
    double? balance,
    DateTime? lastChecked,
    DateTime? latestSentNotification,
    DateTime? latestReceivedNotification,
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
  TransactionsAndBalanceState balance(double balance) => this(balance: balance);

  @override
  TransactionsAndBalanceState lastChecked(DateTime lastChecked) =>
      this(lastChecked: lastChecked);

  @override
  TransactionsAndBalanceState latestSentNotification(
          DateTime? latestSentNotification) =>
      this(latestSentNotification: latestSentNotification);

  @override
  TransactionsAndBalanceState latestReceivedNotification(
          DateTime? latestReceivedNotification) =>
      this(latestReceivedNotification: latestReceivedNotification);

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
    Object? latestSentNotification = const $CopyWithPlaceholder(),
    Object? latestReceivedNotification = const $CopyWithPlaceholder(),
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
          : balance as double,
      lastChecked:
          lastChecked == const $CopyWithPlaceholder() || lastChecked == null
              ? _value.lastChecked
              // ignore: cast_nullable_to_non_nullable
              : lastChecked as DateTime,
      latestSentNotification:
          latestSentNotification == const $CopyWithPlaceholder()
              ? _value.latestSentNotification
              // ignore: cast_nullable_to_non_nullable
              : latestSentNotification as DateTime?,
      latestReceivedNotification:
          latestReceivedNotification == const $CopyWithPlaceholder()
              ? _value.latestReceivedNotification
              // ignore: cast_nullable_to_non_nullable
              : latestReceivedNotification as DateTime?,
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

TransactionsAndBalanceState _$TransactionsAndBalanceStateFromJson(
        Map<String, dynamic> json) =>
    TransactionsAndBalanceState(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: (json['balance'] as num).toDouble(),
      lastChecked: DateTime.parse(json['lastChecked'] as String),
      latestSentNotification: json['latestSentNotification'] == null
          ? null
          : DateTime.parse(json['latestSentNotification'] as String),
      latestReceivedNotification: json['latestReceivedNotification'] == null
          ? null
          : DateTime.parse(json['latestReceivedNotification'] as String),
    );

Map<String, dynamic> _$TransactionsAndBalanceStateToJson(
        TransactionsAndBalanceState instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
      'balance': instance.balance,
      'lastChecked': instance.lastChecked.toIso8601String(),
      'latestSentNotification':
          instance.latestSentNotification.toIso8601String(),
      'latestReceivedNotification':
          instance.latestReceivedNotification.toIso8601String(),
    };
