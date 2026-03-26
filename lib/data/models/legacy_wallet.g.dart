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

  LegacyWallet lastUsed(int? lastUsed);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LegacyWallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LegacyWallet(...).copyWith(id: 12, name: "My name")
  /// ```
  LegacyWallet call({
    String seed,
    String pubKey,
    String name,
    WalletTheme theme,
    int? lastUsed,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLegacyWallet.copyWith(...)` or call `instanceOfLegacyWallet.copyWith.fieldName(value)` for a single field.
class _$LegacyWalletCWProxyImpl implements _$LegacyWalletCWProxy {
  const _$LegacyWalletCWProxyImpl(this._value);

  final LegacyWallet _value;

  @override
  LegacyWallet seed(String seed) => call(seed: seed);

  @override
  LegacyWallet pubKey(String pubKey) => call(pubKey: pubKey);

  @override
  LegacyWallet name(String name) => call(name: name);

  @override
  LegacyWallet theme(WalletTheme theme) => call(theme: theme);

  @override
  LegacyWallet lastUsed(int? lastUsed) => call(lastUsed: lastUsed);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LegacyWallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LegacyWallet(...).copyWith(id: 12, name: "My name")
  /// ```
  LegacyWallet call({
    Object? seed = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
    Object? lastUsed = const $CopyWithPlaceholder(),
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
      lastUsed: lastUsed == const $CopyWithPlaceholder()
          ? _value.lastUsed
          // ignore: cast_nullable_to_non_nullable
          : lastUsed as int?,
    );
  }
}

extension $LegacyWalletCopyWith on LegacyWallet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLegacyWallet.copyWith(...)` or `instanceOfLegacyWallet.copyWith.fieldName(...)`.
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
  lastUsed: (json['lastUsed'] as num?)?.toInt(),
);

Map<String, dynamic> _$LegacyWalletToJson(LegacyWallet instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'seed': instance.seed,
      'theme': instance.theme,
      'name': instance.name,
      'lastUsed': instance.lastUsed,
    };
