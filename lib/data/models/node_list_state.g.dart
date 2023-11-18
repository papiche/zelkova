// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NodeListStateCWProxy {
  NodeListState duniterNodes(List<Node>? duniterNodes);

  NodeListState cesiumPlusNodes(List<Node>? cesiumPlusNodes);

  NodeListState gvaNodes(List<Node>? gvaNodes);

  NodeListState currentGvaNode(Node? currentGvaNode);

  NodeListState isLoading(bool? isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodeListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodeListState(...).copyWith(id: 12, name: "My name")
  /// ````
  NodeListState call({
    List<Node>? duniterNodes,
    List<Node>? cesiumPlusNodes,
    List<Node>? gvaNodes,
    Node? currentGvaNode,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNodeListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNodeListState.copyWith.fieldName(...)`
class _$NodeListStateCWProxyImpl implements _$NodeListStateCWProxy {
  const _$NodeListStateCWProxyImpl(this._value);

  final NodeListState _value;

  @override
  NodeListState duniterNodes(List<Node>? duniterNodes) =>
      this(duniterNodes: duniterNodes);

  @override
  NodeListState cesiumPlusNodes(List<Node>? cesiumPlusNodes) =>
      this(cesiumPlusNodes: cesiumPlusNodes);

  @override
  NodeListState gvaNodes(List<Node>? gvaNodes) => this(gvaNodes: gvaNodes);

  @override
  NodeListState currentGvaNode(Node? currentGvaNode) =>
      this(currentGvaNode: currentGvaNode);

  @override
  NodeListState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NodeListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NodeListState(...).copyWith(id: 12, name: "My name")
  /// ````
  NodeListState call({
    Object? duniterNodes = const $CopyWithPlaceholder(),
    Object? cesiumPlusNodes = const $CopyWithPlaceholder(),
    Object? gvaNodes = const $CopyWithPlaceholder(),
    Object? currentGvaNode = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return NodeListState(
      duniterNodes: duniterNodes == const $CopyWithPlaceholder()
          ? _value.duniterNodes
          // ignore: cast_nullable_to_non_nullable
          : duniterNodes as List<Node>?,
      cesiumPlusNodes: cesiumPlusNodes == const $CopyWithPlaceholder()
          ? _value.cesiumPlusNodes
          // ignore: cast_nullable_to_non_nullable
          : cesiumPlusNodes as List<Node>?,
      gvaNodes: gvaNodes == const $CopyWithPlaceholder()
          ? _value.gvaNodes
          // ignore: cast_nullable_to_non_nullable
          : gvaNodes as List<Node>?,
      currentGvaNode: currentGvaNode == const $CopyWithPlaceholder()
          ? _value.currentGvaNode
          // ignore: cast_nullable_to_non_nullable
          : currentGvaNode as Node?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
    );
  }
}

extension $NodeListStateCopyWith on NodeListState {
  /// Returns a callable class that can be used as follows: `instanceOfNodeListState.copyWith(...)` or like so:`instanceOfNodeListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NodeListStateCWProxy get copyWith => _$NodeListStateCWProxyImpl(this);
}

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
      gvaNodes: (json['gvaNodes'] as List<dynamic>?)
          ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentGvaNode: json['currentGvaNode'] == null
          ? null
          : Node.fromJson(json['currentGvaNode'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool?,
    );

Map<String, dynamic> _$NodeListStateToJson(NodeListState instance) =>
    <String, dynamic>{
      'duniterNodes': instance.duniterNodes,
      'cesiumPlusNodes': instance.cesiumPlusNodes,
      'gvaNodes': instance.gvaNodes,
      'isLoading': instance.isLoading,
      'currentGvaNode': instance.currentGvaNode,
    };
