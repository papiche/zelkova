// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      introViewed: json['introViewed'] as bool? ?? false,
      warningViewed: json['warningViewed'] as bool? ?? false,
      warningBrowserViewed: json['warningBrowserViewed'] as bool? ?? false,
      expertMode: json['expertMode'] as bool? ?? false,
      walletCreatedViewed: json['walletCreatedViewed'] as bool?,
      v2mode: json['v2mode'] as bool? ?? false,
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
      currentUd: (json['currentUd'] as num?)?.toDouble(),
      tutorials: (json['tutorials'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      distancePrecompute: json['distancePrecompute'] == null
          ? null
          : DistancePrecompute.fromJson(
              json['distancePrecompute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'introViewed': instance.introViewed,
      'walletCreatedViewed': instance.walletCreatedViewed,
      'warningViewed': instance.warningViewed,
      'warningBrowserViewed': instance.warningBrowserViewed,
      'expertMode': instance.expertMode,
      'v2mode': instance.v2mode,
      'currency': _$CurrencyEnumMap[instance.currency]!,
      'currentUd': instance.currentUd,
      'tutorials': instance.tutorials,
      if (instance.distancePrecompute case final value?)
        'distancePrecompute': value,
    };

const _$CurrencyEnumMap = {
  Currency.G1: 'G1',
  Currency.DU: 'DU',
};
