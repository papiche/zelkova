// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionStateCWProxy {
  TransactionState transactions(List<Transaction> transactions);

  TransactionState pendingTransactions(List<Transaction> pendingTransactions);

  TransactionState balance(double balance);

  TransactionState currentUd(double? currentUd);

  TransactionState lastChecked(DateTime lastChecked);

  TransactionState latestSentNotification(DateTime? latestSentNotification);

  TransactionState latestReceivedNotification(
    DateTime? latestReceivedNotification,
  );

  TransactionState endCursor(String? endCursor);

  TransactionState hasNextPage(bool hasNextPage);

  TransactionState udTransactions(List<Transaction> udTransactions);

  TransactionState udEndCursor(String? udEndCursor);

  TransactionState udHasNextPage(bool udHasNextPage);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionState(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionState call({
    List<Transaction> transactions,
    List<Transaction> pendingTransactions,
    double balance,
    double? currentUd,
    DateTime lastChecked,
    DateTime? latestSentNotification,
    DateTime? latestReceivedNotification,
    String? endCursor,
    bool hasNextPage,
    List<Transaction> udTransactions,
    String? udEndCursor,
    bool udHasNextPage,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTransactionState.copyWith(...)` or call `instanceOfTransactionState.copyWith.fieldName(value)` for a single field.
class _$TransactionStateCWProxyImpl implements _$TransactionStateCWProxy {
  const _$TransactionStateCWProxyImpl(this._value);

  final TransactionState _value;

  @override
  TransactionState transactions(List<Transaction> transactions) =>
      call(transactions: transactions);

  @override
  TransactionState pendingTransactions(List<Transaction> pendingTransactions) =>
      call(pendingTransactions: pendingTransactions);

  @override
  TransactionState balance(double balance) => call(balance: balance);

  @override
  TransactionState currentUd(double? currentUd) => call(currentUd: currentUd);

  @override
  TransactionState lastChecked(DateTime lastChecked) =>
      call(lastChecked: lastChecked);

  @override
  TransactionState latestSentNotification(DateTime? latestSentNotification) =>
      call(latestSentNotification: latestSentNotification);

  @override
  TransactionState latestReceivedNotification(
    DateTime? latestReceivedNotification,
  ) => call(latestReceivedNotification: latestReceivedNotification);

  @override
  TransactionState endCursor(String? endCursor) => call(endCursor: endCursor);

  @override
  TransactionState hasNextPage(bool hasNextPage) =>
      call(hasNextPage: hasNextPage);

  @override
  TransactionState udTransactions(List<Transaction> udTransactions) =>
      call(udTransactions: udTransactions);

  @override
  TransactionState udEndCursor(String? udEndCursor) =>
      call(udEndCursor: udEndCursor);

  @override
  TransactionState udHasNextPage(bool udHasNextPage) =>
      call(udHasNextPage: udHasNextPage);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `TransactionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// TransactionState(...).copyWith(id: 12, name: "My name")
  /// ```
  TransactionState call({
    Object? transactions = const $CopyWithPlaceholder(),
    Object? pendingTransactions = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
    Object? currentUd = const $CopyWithPlaceholder(),
    Object? lastChecked = const $CopyWithPlaceholder(),
    Object? latestSentNotification = const $CopyWithPlaceholder(),
    Object? latestReceivedNotification = const $CopyWithPlaceholder(),
    Object? endCursor = const $CopyWithPlaceholder(),
    Object? hasNextPage = const $CopyWithPlaceholder(),
    Object? udTransactions = const $CopyWithPlaceholder(),
    Object? udEndCursor = const $CopyWithPlaceholder(),
    Object? udHasNextPage = const $CopyWithPlaceholder(),
  }) {
    return TransactionState(
      transactions:
          transactions == const $CopyWithPlaceholder() || transactions == null
          ? _value.transactions
          // ignore: cast_nullable_to_non_nullable
          : transactions as List<Transaction>,
      pendingTransactions:
          pendingTransactions == const $CopyWithPlaceholder() ||
              pendingTransactions == null
          ? _value.pendingTransactions
          // ignore: cast_nullable_to_non_nullable
          : pendingTransactions as List<Transaction>,
      balance: balance == const $CopyWithPlaceholder() || balance == null
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as double,
      currentUd: currentUd == const $CopyWithPlaceholder()
          ? _value.currentUd
          // ignore: cast_nullable_to_non_nullable
          : currentUd as double?,
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
      endCursor: endCursor == const $CopyWithPlaceholder()
          ? _value.endCursor
          // ignore: cast_nullable_to_non_nullable
          : endCursor as String?,
      hasNextPage:
          hasNextPage == const $CopyWithPlaceholder() || hasNextPage == null
          ? _value.hasNextPage
          // ignore: cast_nullable_to_non_nullable
          : hasNextPage as bool,
      udTransactions:
          udTransactions == const $CopyWithPlaceholder() ||
              udTransactions == null
          ? _value.udTransactions
          // ignore: cast_nullable_to_non_nullable
          : udTransactions as List<Transaction>,
      udEndCursor: udEndCursor == const $CopyWithPlaceholder()
          ? _value.udEndCursor
          // ignore: cast_nullable_to_non_nullable
          : udEndCursor as String?,
      udHasNextPage:
          udHasNextPage == const $CopyWithPlaceholder() || udHasNextPage == null
          ? _value.udHasNextPage
          // ignore: cast_nullable_to_non_nullable
          : udHasNextPage as bool,
    );
  }
}

extension $TransactionStateCopyWith on TransactionState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTransactionState.copyWith(...)` or `instanceOfTransactionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionStateCWProxy get copyWith => _$TransactionStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionState _$TransactionStateFromJson(Map<String, dynamic> json) =>
    TransactionState(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingTransactions: (json['pendingTransactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: (json['balance'] as num).toDouble(),
      currentUd: (json['currentUd'] as num?)?.toDouble(),
      lastChecked: DateTime.parse(json['lastChecked'] as String),
      latestSentNotification: json['latestSentNotification'] == null
          ? null
          : DateTime.parse(json['latestSentNotification'] as String),
      latestReceivedNotification: json['latestReceivedNotification'] == null
          ? null
          : DateTime.parse(json['latestReceivedNotification'] as String),
      endCursor: json['endCursor'] as String?,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      udTransactions:
          (json['udTransactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Transaction>[],
      udEndCursor: json['udEndCursor'] as String?,
      udHasNextPage: json['udHasNextPage'] as bool? ?? false,
    );

Map<String, dynamic> _$TransactionStateToJson(
  TransactionState instance,
) => <String, dynamic>{
  'transactions': instance.transactions,
  'pendingTransactions': instance.pendingTransactions,
  'balance': instance.balance,
  'currentUd': instance.currentUd,
  'lastChecked': instance.lastChecked.toIso8601String(),
  'latestSentNotification': instance.latestSentNotification.toIso8601String(),
  'latestReceivedNotification': instance.latestReceivedNotification
      .toIso8601String(),
  'endCursor': instance.endCursor,
  'hasNextPage': instance.hasNextPage,
  'udTransactions': instance.udTransactions,
  'udEndCursor': instance.udEndCursor,
  'udHasNextPage': instance.udHasNextPage,
};
