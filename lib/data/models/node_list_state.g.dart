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
      lastFetchDuniterNodesTime: json['lastFetchDuniterNodesTime'] == null
          ? null
          : DateTime.parse(json['lastFetchDuniterNodesTime'] as String),
      lastFetchCPlusNodesTime: json['lastFetchCPlusNodesTime'] == null
          ? null
          : DateTime.parse(json['lastFetchCPlusNodesTime'] as String),
    );

Map<String, dynamic> _$NodeListStateToJson(NodeListState instance) =>
    <String, dynamic>{
      'duniterNodes': instance.duniterNodes,
      'cesiumPlusNodes': instance.cesiumPlusNodes,
      'lastFetchDuniterNodesTime':
          instance.lastFetchDuniterNodesTime.toIso8601String(),
      'lastFetchCPlusNodesTime':
          instance.lastFetchCPlusNodesTime.toIso8601String(),
    };
