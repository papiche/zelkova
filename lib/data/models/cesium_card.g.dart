// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cesium_card.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountCardCWProxy {
  AccountCard seed(String seed);

  AccountCard pubKey(String pubKey);

  AccountCard name(String name);

  AccountCard theme(AccountCardTheme theme);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccountCard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccountCard(...).copyWith(id: 12, name: "My name")
  /// ````
  AccountCard call({
    String? seed,
    String? pubKey,
    String? name,
    AccountCardTheme? theme,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAccountCard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAccountCard.copyWith.fieldName(...)`
class _$AccountCardCWProxyImpl implements _$AccountCardCWProxy {
  const _$AccountCardCWProxyImpl(this._value);

  final AccountCard _value;

  @override
  AccountCard seed(String seed) => this(seed: seed);

  @override
  AccountCard pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  AccountCard name(String name) => this(name: name);

  @override
  AccountCard theme(AccountCardTheme theme) => this(theme: theme);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccountCard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccountCard(...).copyWith(id: 12, name: "My name")
  /// ````
  AccountCard call({
    Object? seed = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
  }) {
    return AccountCard(
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
          : theme as AccountCardTheme,
    );
  }
}

extension $AccountCardCopyWith on AccountCard {
  /// Returns a callable class that can be used as follows: `instanceOfAccountCard.copyWith(...)` or like so:`instanceOfAccountCard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountCardCWProxy get copyWith => _$AccountCardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCard _$AccountCardFromJson(Map<String, dynamic> json) => AccountCard(
      seed: json['seed'] as String,
      pubKey: json['pubKey'] as String,
      name: json['name'] as String,
      theme: AccountCardTheme.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountCardToJson(AccountCard instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'seed': instance.seed,
      'theme': instance.theme,
      'name': instance.name,
    };
