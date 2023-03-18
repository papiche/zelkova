// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_list_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeListState _$NodeListStateFromJson(Map<String, dynamic> json) =>
    NodeListState(
      duniterNodes: (json['duniterNodes'] as List<dynamic>?)
          ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      cesiumPlusNodes: (json['cesiumPlusNodes'] as List<dynamic>?)
          ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastFetchNodesTime: json['lastFetchNodesTime'] == null
          ? null
          : DateTime.parse(json['lastFetchNodesTime'] as String),
    );

Map<String, dynamic> _$NodeListStateToJson(NodeListState instance) =>
    <String, dynamic>{
      'duniterNodes': instance.duniterNodes,
      'cesiumPlusNodes': instance.cesiumPlusNodes,
      'lastFetchNodesTime': instance.lastFetchNodesTime.toIso8601String(),
    };
