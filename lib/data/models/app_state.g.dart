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
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'introViewed': instance.introViewed,
      'warningViewed': instance.warningViewed,
      'warningBrowserViewed': instance.warningBrowserViewed,
      'expertMode': instance.expertMode,
    };
