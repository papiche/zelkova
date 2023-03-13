import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'node.dart';

part 'node_list_state.g.dart';

@immutable
@JsonSerializable()
class NodeListState extends Equatable {
  NodeListState(
      {this.duniterNodes = defaultDuniterNodes,
      this.cesiumPlusNodes = defaultCesiumPlusNodes,
      DateTime? lastFetchNodesTime})
      : lastFetchNodesTime = lastFetchNodesTime ?? DateTime(1970);

  factory NodeListState.fromJson(Map<String, dynamic> json) =>
      _$NodeListStateFromJson(json);

  final List<Node> duniterNodes;
  final List<Node> cesiumPlusNodes;
  final DateTime lastFetchNodesTime;

  NodeListState copyWith(
      {List<Node>? duniterNodes,
      List<Node>? cesiumPlusNodes,
      DateTime? lastFetchNodesTime}) {
    return NodeListState(
      duniterNodes: duniterNodes ?? this.duniterNodes,
      cesiumPlusNodes: cesiumPlusNodes ?? this.cesiumPlusNodes,
      lastFetchNodesTime: lastFetchNodesTime ?? lastFetchNodesTime,
    );
  }

  @override
  List<Object?> get props =>
      <Object>[duniterNodes, cesiumPlusNodes, lastFetchNodesTime];

  Map<String, dynamic> toJson() => _$NodeListStateToJson(this);
}
