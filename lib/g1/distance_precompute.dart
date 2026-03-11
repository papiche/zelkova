// From duniter-vue
// https://git.duniter.org/HugoTrentesaux/duniter-vue/-/blob/master/src/distance.ts?ref_type=heads
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../data/models/is_json_serializable.dart';

part 'distance_precompute.g.dart';

@JsonSerializable()
class DistancePrecompute extends Equatable
    implements IsJsonSerializable<DistancePrecompute> {
  const DistancePrecompute({
    required this.height,
    required this.block,
    required this.refereesCount,
    required this.memberCount,
    required this.minCertsForReferee,
    required this.results,
  });

  factory DistancePrecompute.fromJson(Map<String, dynamic> json) =>
      _$DistancePrecomputeFromJson(json);

  final int height;
  final String block;
  final int refereesCount;
  final int memberCount;
  final int minCertsForReferee;
  @JsonKey(fromJson: _mapFromJson, toJson: _mapToJson)
  final Map<int, int> results;

  static Map<int, int> _mapFromJson(Map<String, dynamic> json) {
    return json.map((String key, dynamic value) =>
        MapEntry<int, int>(int.parse(key), int.parse(value.toString())));
  }

  static Map<String, dynamic> _mapToJson(Map<int, int> map) {
    return map.map((int key, int value) =>
        MapEntry<String, dynamic>(key.toString(), value));
  }

  @override
  DistancePrecompute fromJson(Map<String, dynamic> json) =>
      _$DistancePrecomputeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DistancePrecomputeToJson(this);

  @override
  List<Object> get props => <Object>[
        height,
        block,
        refereesCount,
        memberCount,
        minCertsForReferee,
        results
      ];
}
