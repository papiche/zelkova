// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_wallet_transaction_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MultiWalletTransactionStateCWProxy {
  MultiWalletTransactionState map(Map<String, TransactionState> map);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MultiWalletTransactionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MultiWalletTransactionState(...).copyWith(id: 12, name: "My name")
  /// ```
  MultiWalletTransactionState call({Map<String, TransactionState> map});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMultiWalletTransactionState.copyWith(...)` or call `instanceOfMultiWalletTransactionState.copyWith.fieldName(value)` for a single field.
class _$MultiWalletTransactionStateCWProxyImpl
    implements _$MultiWalletTransactionStateCWProxy {
  const _$MultiWalletTransactionStateCWProxyImpl(this._value);

  final MultiWalletTransactionState _value;

  @override
  MultiWalletTransactionState map(Map<String, TransactionState> map) =>
      call(map: map);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MultiWalletTransactionState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MultiWalletTransactionState(...).copyWith(id: 12, name: "My name")
  /// ```
  MultiWalletTransactionState call({
    Object? map = const $CopyWithPlaceholder(),
  }) {
    return MultiWalletTransactionState(
      map == const $CopyWithPlaceholder() || map == null
          ? _value.map
          // ignore: cast_nullable_to_non_nullable
          : map as Map<String, TransactionState>,
    );
  }
}

extension $MultiWalletTransactionStateCopyWith on MultiWalletTransactionState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMultiWalletTransactionState.copyWith(...)` or `instanceOfMultiWalletTransactionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MultiWalletTransactionStateCWProxy get copyWith =>
      _$MultiWalletTransactionStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiWalletTransactionState _$MultiWalletTransactionStateFromJson(
  Map<String, dynamic> json,
) => MultiWalletTransactionState(
  (json['map'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, TransactionState.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$MultiWalletTransactionStateToJson(
  MultiWalletTransactionState instance,
) => <String, dynamic>{'map': instance.map};
