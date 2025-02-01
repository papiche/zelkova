// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LegacyWalletCWProxy {
  LegacyWallet seed(String seed);

  LegacyWallet pubKey(String pubKey);

  LegacyWallet name(String name);

  LegacyWallet theme(WalletTheme theme);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LegacyWallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LegacyWallet(...).copyWith(id: 12, name: "My name")
  /// ````
  LegacyWallet call({
    String? seed,
    String? pubKey,
    String? name,
    WalletTheme? theme,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLegacyWallet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLegacyWallet.copyWith.fieldName(...)`
class _$LegacyWalletCWProxyImpl implements _$LegacyWalletCWProxy {
  const _$LegacyWalletCWProxyImpl(this._value);

  final LegacyWallet _value;

  @override
  LegacyWallet seed(String seed) => this(seed: seed);

  @override
  LegacyWallet pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  LegacyWallet name(String name) => this(name: name);

  @override
  LegacyWallet theme(WalletTheme theme) => this(theme: theme);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LegacyWallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LegacyWallet(...).copyWith(id: 12, name: "My name")
  /// ````
  LegacyWallet call({
    Object? seed = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
  }) {
    return LegacyWallet(
      seed: seed == const $CopyWithPlaceholder() || seed == null
          ? _value.seed
          // ignore: cast_nullable_to_non_nullable
          : seed as String,
      pubKey: pubKey == const $CopyWithPlaceholder() || pubKey == null
          ? _value.pubKey
          // ignore: cast_nullable_to_non_nullable
          : pubKey as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      theme: theme == const $CopyWithPlaceholder() || theme == null
          ? _value.theme
          // ignore: cast_nullable_to_non_nullable
          : theme as WalletTheme,
    );
  }
}

extension $LegacyWalletCopyWith on LegacyWallet {
  /// Returns a callable class that can be used as follows: `instanceOfLegacyWallet.copyWith(...)` or like so:`instanceOfLegacyWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LegacyWalletCWProxy get copyWith => _$LegacyWalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegacyWallet _$LegacyWalletFromJson(Map<String, dynamic> json) => LegacyWallet(
      seed: json['seed'] as String,
      pubKey: json['pubKey'] as String,
      name: json['name'] as String,
      theme: WalletTheme.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LegacyWalletToJson(LegacyWallet instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'seed': instance.seed,
      'theme': instance.theme,
      'name': instance.name,
    };
