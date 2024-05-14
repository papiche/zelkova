import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'node.dart';
import 'node_lists_default.dart';

part 'node_list_state.g.dart';

@immutable
@JsonSerializable()
@CopyWith()
class NodeListState extends Equatable {
  NodeListState(
      {List<Node>? duniterNodes,
      List<Node>? cesiumPlusNodes,
      List<Node>? gvaNodes,
      List<Node>? endpointNodes,
      List<Node>? duniterIndexerNodes,
      this.currentGvaNode,
      bool? isLoading})
      : duniterNodes = duniterNodes ?? defaultDuniterNodes,
        cesiumPlusNodes = cesiumPlusNodes ?? defaultCesiumPlusNodes,
        gvaNodes = gvaNodes ?? defaultGvaNodes,
        endpointNodes = endpointNodes ?? defaultEndPointNodes,
        duniterIndexerNodes = duniterIndexerNodes ?? defaultDuniterIndexerNodes,
        isLoading = isLoading ?? false;

  factory NodeListState.fromJson(Map<String, dynamic> json) =>
      _$NodeListStateFromJson(json);

  @JsonKey(fromJson: _nodesFromJson, toJson: _nodesToJson)
  final List<Node> duniterNodes;
  @JsonKey(fromJson: _nodesFromJson, toJson: _nodesToJson)
  final List<Node> cesiumPlusNodes;
  @JsonKey(fromJson: _nodesFromJson, toJson: _nodesToJson)
  final List<Node> gvaNodes;
  @JsonKey(fromJson: _nodesFromJson, toJson: _nodesToJson)
  final List<Node> endpointNodes;
  @JsonKey(fromJson: _nodesFromJson, toJson: _nodesToJson)
  final List<Node> duniterIndexerNodes;
  final bool isLoading;
  @JsonKey(fromJson: _nodeFromJson, toJson: _nodeToJson)
  final Node? currentGvaNode;

  @override
  List<Object?> get props => <Object>[
        duniterNodes,
        cesiumPlusNodes,
        gvaNodes,
        endpointNodes,
        duniterIndexerNodes,
        isLoading
      ];

  Map<String, dynamic> toJson() => _$NodeListStateToJson(this);

  static Node? _nodeFromJson(Map<String, dynamic>? json) =>
      json != null ? Node.fromJson(json) : null;

  static Map<String, dynamic>? _nodeToJson(Node? node) => node?.toJson();

  static List<Node> _nodesFromJson(List<dynamic> json) => json
      .map((dynamic item) => Node.fromJson(item as Map<String, dynamic>))
      .toList();

  static List<Map<String, dynamic>> _nodesToJson(List<Node> nodes) =>
      nodes.map((Node item) => item.toJson()).toList();
}
