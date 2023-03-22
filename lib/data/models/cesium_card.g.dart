// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cesium_card.dart';

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
