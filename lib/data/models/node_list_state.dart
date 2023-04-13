import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'node.dart';

part 'node_list_state.g.dart';

@immutable
@JsonSerializable()
@CopyWith()
class NodeListState extends Equatable {
  NodeListState(
      {List<Node>? duniterNodes,
      List<Node>? cesiumPlusNodes,
      List<Node>? gvaNodes,
      bool? isLoading})
      : duniterNodes = duniterNodes ?? defaultDuniterNodes,
        cesiumPlusNodes = cesiumPlusNodes ?? defaultCesiumPlusNodes,
        gvaNodes = gvaNodes ?? defaultGvaNodes,
        isLoading = isLoading ?? false;

  factory NodeListState.fromJson(Map<String, dynamic> json) =>
      _$NodeListStateFromJson(json);

  final List<Node> duniterNodes;
  final List<Node> cesiumPlusNodes;
  final List<Node> gvaNodes;
  final bool isLoading;

  @override
  List<Object?> get props =>
      <Object>[duniterNodes, cesiumPlusNodes, gvaNodes, isLoading];

  Map<String, dynamic> toJson() => _$NodeListStateToJson(this);
}
