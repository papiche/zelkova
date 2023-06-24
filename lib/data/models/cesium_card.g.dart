// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cesium_card.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CesiumCardCWProxy {
  CesiumCard seed(String seed);

  CesiumCard pubKey(String pubKey);

  CesiumCard name(String name);

  CesiumCard theme(CreditCardTheme theme);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CesiumCard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CesiumCard(...).copyWith(id: 12, name: "My name")
  /// ````
  CesiumCard call({
    String? seed,
    String? pubKey,
    String? name,
    CreditCardTheme? theme,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCesiumCard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCesiumCard.copyWith.fieldName(...)`
class _$CesiumCardCWProxyImpl implements _$CesiumCardCWProxy {
  const _$CesiumCardCWProxyImpl(this._value);

  final CesiumCard _value;

  @override
  CesiumCard seed(String seed) => this(seed: seed);

  @override
  CesiumCard pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  CesiumCard name(String name) => this(name: name);

  @override
  CesiumCard theme(CreditCardTheme theme) => this(theme: theme);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CesiumCard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CesiumCard(...).copyWith(id: 12, name: "My name")
  /// ````
  CesiumCard call({
    Object? seed = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
  }) {
    return CesiumCard(
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
          : theme as CreditCardTheme,
    );
  }
}

extension $CesiumCardCopyWith on CesiumCard {
  /// Returns a callable class that can be used as follows: `instanceOfCesiumCard.copyWith(...)` or like so:`instanceOfCesiumCard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CesiumCardCWProxy get copyWith => _$CesiumCardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CesiumCard _$CesiumCardFromJson(Map<String, dynamic> json) => CesiumCard(
      seed: json['seed'] as String,
      pubKey: json['pubKey'] as String,
      name: json['name'] as String,
      theme: CreditCardTheme.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CesiumCardToJson(CesiumCard instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'seed': instance.seed,
      'theme': instance.theme,
      'name': instance.name,
    };
