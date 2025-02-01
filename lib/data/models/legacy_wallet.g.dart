// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletCWProxy {
  Wallet seed(String seed);

  Wallet pubKey(String pubKey);

  Wallet name(String name);

  Wallet theme(WalletTheme theme);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Wallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ````
  Wallet call({
    String? seed,
    String? pubKey,
    String? name,
    WalletTheme? theme,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWallet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWallet.copyWith.fieldName(...)`
class _$WalletCWProxyImpl implements _$WalletCWProxy {
  const _$WalletCWProxyImpl(this._value);

  final Wallet _value;

  @override
  Wallet seed(String seed) => this(seed: seed);

  @override
  Wallet pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  Wallet name(String name) => this(name: name);

  @override
  Wallet theme(WalletTheme theme) => this(theme: theme);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Wallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ````
  Wallet call({
    Object? seed = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
  }) {
    return Wallet(
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

extension $WalletCopyWith on Wallet {
  /// Returns a callable class that can be used as follows: `instanceOfWallet.copyWith(...)` or like so:`instanceOfWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletCWProxy get copyWith => _$WalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      seed: json['seed'] as String,
      pubKey: json['pubKey'] as String,
      name: json['name'] as String,
      theme: WalletTheme.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'pubKey': instance.pubKey,
      'seed': instance.seed,
      'theme': instance.theme,
      'name': instance.name,
    };
