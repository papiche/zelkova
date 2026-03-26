// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distance_precompute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistancePrecompute _$DistancePrecomputeFromJson(Map<String, dynamic> json) =>
    DistancePrecompute(
      height: (json['height'] as num).toInt(),
      block: json['block'] as String,
      refereesCount: (json['refereesCount'] as num).toInt(),
      memberCount: (json['memberCount'] as num).toInt(),
      minCertsForReferee: (json['minCertsForReferee'] as num).toInt(),
      results: DistancePrecompute._mapFromJson(
        json['results'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DistancePrecomputeToJson(DistancePrecompute instance) =>
    <String, dynamic>{
      'height': instance.height,
      'block': instance.block,
      'refereesCount': instance.refereesCount,
      'memberCount': instance.memberCount,
      'minCertsForReferee': instance.minCertsForReferee,
      'results': DistancePrecompute._mapToJson(instance.results),
    };
