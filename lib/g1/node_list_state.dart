import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'node.dart';

part 'node_list_state.g.dart';

@immutable
@JsonSerializable()
class NodeListState extends Equatable {
  const NodeListState(
      {this.duniterNodes = defaultDuniterNodes,
      this.cesiumPlusNodes = defaultCesiumPlusNodes});

  factory NodeListState.fromJson(Map<String, dynamic> json) =>
      _$NodeListStateFromJson(json);

  final List<Node> duniterNodes;
  final List<Node> cesiumPlusNodes;

  NodeListState copyWith(
      {List<Node>? duniterNodes, List<Node>? cesiumPlusNodes}) {
    return NodeListState(
        duniterNodes: duniterNodes ?? this.duniterNodes,
        cesiumPlusNodes: cesiumPlusNodes ?? this.cesiumPlusNodes);
  }

  @override
  List<Object?> get props => <Object>[duniterNodes, cesiumPlusNodes];

  Map<String, dynamic> toJson() => _$NodeListStateToJson(this);
}
