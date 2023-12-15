import 'package:flutter/foundation.dart';

import '../../ui/logger.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_type.dart';

class NodeManager {
  factory NodeManager() {
    return _singleton;
  }

  NodeManager._internal();

  static int maxNodes = kReleaseMode ? 30 : 20;
  static int maxNodeErrors = 3;
  static int minutesToWait = 45;

  static final NodeManager _singleton = NodeManager._internal();

  final List<Node> duniterNodes = <Node>[];
  final List<Node> cesiumPlusNodes = <Node>[];
  final List<Node> gvaNodes = <Node>[];
  static Node? currentGvaNode;

  void loadFromCubit(NodeListCubit cubit) {
    NodeManagerObserver.instance.cubit = cubit;
    duniterNodes.clear();
    cesiumPlusNodes.clear();
    gvaNodes.clear();
    duniterNodes.addAll(cubit.duniterNodes);
    cesiumPlusNodes.addAll(cubit.cesiumPlusNodes);
    gvaNodes.addAll(cubit.gvaNodes);
  }

  void updateNodes(NodeType type, List<Node> newNodes, {bool notify = true}) {
    final List<Node> nodes = _getList(type);

    final Map<String, int> existingNodesMap = <String, int>{
      for (final Node node in nodes) node.url: node.errors
    };

    /*   final List<Node> workingNodes = nodes.where((Node node) {
      return node.errors == 0;
    }).toList(); */
    nodes.clear();

    final Set<Node> uniqueNodes = <Node>{};

//    uniqueNodes.addAll(workingNodes);

    for (final Node newNode in newNodes) {
      Node updatedNode = newNode;
      if (existingNodesMap.containsKey(newNode.url)) {
        updatedNode = newNode.copyWith(errors: existingNodesMap[newNode.url]);
      }
      uniqueNodes.add(updatedNode);
    }

    nodes.addAll(uniqueNodes);

    if (notify) {
      notifyObserver();
    }
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
      // Maintain errors of the update node
      final Node updateNodeWithErrors =
          updatedNode.copyWith(errors: list[index].errors);
      list.replaceRange(index, index + 1, <Node>[updateNodeWithErrors]);
    }
    notifyObserver();
  }

  void increaseNodeErrors(NodeType type, Node node) {
    logger('Increasing node errors of ${node.url} (${node.errors})');
    updateNode(type, node.copyWith(errors: node.errors + 1));
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

  bool get loading => NodeManagerObserver.instance.cubit.isLoading;

  set loading(bool isLoading) {
    NodeManagerObserver.instance.setLoading(isLoading);
  }

  void notifyObserver() {
    NodeManagerObserver.instance.update(this);
  }

  int nodesWorking(NodeType type) => nodeList(type)
      .where((Node n) => n.errors < NodeManager.maxNodeErrors)
      .toList()
      .length;

  List<Node> nodesWorkingList(NodeType type) => nodeList(type)
      .where((Node n) => n.errors < NodeManager.maxNodeErrors)
      .toList();

  Node? getCurrentGvaNode() {
    return NodeManagerObserver.instance.currentGvaNode();
  }

  void setCurrentGvaNode(Node node) {
    NodeManagerObserver.instance.cubit.setCurrentGvaNode(node);
  }
}

class NodeManagerObserver {
  NodeManagerObserver._internal();

  static final NodeManagerObserver instance = NodeManagerObserver._internal();

  late NodeListCubit cubit;

  void setLoading(bool isLoading) {
    cubit.setLoading(isLoading);
  }

  void update(NodeManager nodeManager) {
    cubit.setDuniterNodes(nodeManager.duniterNodes);
    cubit.setCesiumPlusNodes(nodeManager.cesiumPlusNodes);
    cubit.setGvaNodes(nodeManager.gvaNodes);
  }

  Node? currentGvaNode() => cubit.currentGvaNode;
}
