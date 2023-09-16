// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_wallet_transaction_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MultiWalletTransactionStateCWProxy {
  MultiWalletTransactionState map(Map<String, TransactionState> map);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MultiWalletTransactionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MultiWalletTransactionState(...).copyWith(id: 12, name: "My name")
  /// ````
  MultiWalletTransactionState call({
    Map<String, TransactionState>? map,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMultiWalletTransactionState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMultiWalletTransactionState.copyWith.fieldName(...)`
class _$MultiWalletTransactionStateCWProxyImpl
    implements _$MultiWalletTransactionStateCWProxy {
  const _$MultiWalletTransactionStateCWProxyImpl(this._value);

  final MultiWalletTransactionState _value;

  @override
  MultiWalletTransactionState map(Map<String, TransactionState> map) =>
      this(map: map);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MultiWalletTransactionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MultiWalletTransactionState(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfMultiWalletTransactionState.copyWith(...)` or like so:`instanceOfMultiWalletTransactionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MultiWalletTransactionStateCWProxy get copyWith =>
      _$MultiWalletTransactionStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiWalletTransactionState _$MultiWalletTransactionStateFromJson(
        Map<String, dynamic> json) =>
    MultiWalletTransactionState(
      (json['map'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, TransactionState.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MultiWalletTransactionStateToJson(
        MultiWalletTransactionState instance) =>
    <String, dynamic>{
      'map': instance.map,
    };
