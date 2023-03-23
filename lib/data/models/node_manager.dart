import 'package:flutter/foundation.dart';

import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';

class NodeManager {
  factory NodeManager() {
    return _singleton;
  }

  NodeManager._internal();

  static int maxNodes = kReleaseMode ? 20 : 10;
  static int maxNodeErrors = 3;
  static int minutesToWait = 45;

  static final NodeManager _singleton = NodeManager._internal();

  final List<Node> duniterNodes = <Node>[];
  final List<Node> cesiumPlusNodes = <Node>[];
  final List<Node> gvaNodes = <Node>[];

  void loadFromCubit(NodeListCubit cubit) {
    NodeManagerObserver.instance.cubit = cubit;
    duniterNodes.clear();
    cesiumPlusNodes.clear();
    gvaNodes.clear();
    duniterNodes.addAll(cubit.duniterNodes);
    cesiumPlusNodes.addAll(cubit.cesiumPlusNodes);
    gvaNodes.addAll(cubit.gvaNodes);
  }

  void updateNodes(NodeType type, List<Node> newNodes) {
    final List<Node> nodes = _getList(type);
    nodes.clear();
    nodes.addAll(newNodes);
    notifyObserver();
  }

  List<Node> nodeList(NodeType type) => _getList(type);

  List<Node> _getList(NodeType type) => type == NodeType.duniter
      ? duniterNodes
      : type == NodeType.cesiumPlus
          ? cesiumPlusNodes
          : gvaNodes;

  void addNode(NodeType type, Node node) {
    final List<Node> nodes = _getList(type);
    _addNode(nodes, node);
  }

  void _addNode(List<Node> nodes, Node node) {
    if (!_find(nodes, node)) {
      // Does not exists, so add it
      nodes.add(node);
      notifyObserver();
    } else {
      // it exists
      _updateList(nodes, node);
    }
  }

  bool _find(List<Node> nodes, Node node) =>
      nodes.where((Node n) => n.url == node.url).isNotEmpty;

  void insertNode(NodeType type, Node node) {
    final List<Node> nodes = _getList(type);
    _insertNode(nodes, node);
  }

  void _insertNode(List<Node> nodes, Node node) {
    if (!_find(nodes, node)) {
      nodes.insert(0, node);
    } else {
      // it exists
      _updateList(nodes, node);
    }
  }

  void updateNode(NodeType type, Node updatedNode) {
    final List<Node> nodes = _getList(type);
    _updateList(nodes, updatedNode);
  }

  void _updateList(List<Node> list, Node updatedNode) {
    final int index =
        list.indexWhere((Node node) => node.url == updatedNode.url);
    if (index != -1) {
      list.replaceRange(index, index + 1, <Node>[updatedNode]);
    }
    notifyObserver();
  }

  void cleanErrorStats() {
    for (final NodeType type in NodeType.values) {
      final List<Node> nodes = _getList(type);
      final List<Node> newList =
          nodes.map((Node node) => node.copyWith(errors: 0)).toList();
      nodes.clear();
      nodes.addAll(newList);
    }
    notifyObserver();
  }

  void notifyObserver() {
    NodeManagerObserver.instance.update(this);
  }
}

class NodeManagerObserver {
  NodeManagerObserver._internal();

  static final NodeManagerObserver instance = NodeManagerObserver._internal();

  late NodeListCubit cubit;

  void update(NodeManager nodeManager) {
    cubit.setDuniterNodes(nodeManager.duniterNodes);
    cubit.setCesiumPlusNodes(nodeManager.cesiumPlusNodes);
    cubit.setGvaNodes(nodeManager.gvaNodes);
  }
}
