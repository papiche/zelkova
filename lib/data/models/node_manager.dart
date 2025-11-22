import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../ui/logger.dart';
import 'node.dart';
import 'node_list_cubit.dart';
import 'node_lists_default.dart';
import 'node_type.dart';

class NodeManager {
  factory NodeManager() {
    return _singleton;
  }

  NodeManager._internal();

  static int maxNodes = kReleaseMode ? 30 : 20;
  static int maxNodeErrors = 5; // Max errors to consider node "good"
  static int absoluteMaxErrors = 10; // Absolute max before discarding node
  static int minutesToWait = 45;

  static final NodeManager _singleton = NodeManager._internal();

  final List<Node> duniterNodes = <Node>[];
  final List<Node> cesiumPlusNodes = <Node>[];
  final List<Node> gvaNodes = <Node>[];
  final List<Node> endpointNodes = <Node>[];
  final List<Node> duniterIndexerNodes = <Node>[];
  final List<Node> duniterDataNodes = <Node>[];
  final List<Node> ipfsGateways = <Node>[];
  String? currentIfpsNode;

  /*
  void loadFromCubit(NodeListCubit cubit) {
    duniterNodes.clear();
    cesiumPlusNodes.clear();
    gvaNodes.clear();
    endpointNodes.clear();
    duniterIndexerNodes.clear();
    duniterNodes.addAll(cubit.duniterNodes);
    cesiumPlusNodes.addAll(cubit.cesiumPlusNodes);
    gvaNodes.addAll(cubit.gvaNodes);
    endpointNodes.addAll(cubit.endpointNodes);
    duniterIndexerNodes.addAll(cubit.duniterIndexerNodes);
  } */

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
          : type == NodeType.endpoint
              ? endpointNodes
              : type == NodeType.duniterIndexer
                  ? duniterIndexerNodes
                  : type == NodeType.datapodEndpoint
                      ? duniterDataNodes
                      : type == NodeType.ipfsGateway
                          ? ipfsGateways
                          : gvaNodes;

  void addNode(NodeType type, Node node, {bool notify = true}) {
    final List<Node> nodes = _getList(type);
    _addNode(nodes, node, notify: notify);
  }

  void _addNode(List<Node> nodes, Node node, {bool notify = true}) {
    if (!_find(nodes, node)) {
      // Does not exist, so add it
      nodes.add(node);
      if (notify) {
        notifyObserver();
      }
    } else {
      // It exists
      _updateList(nodes, node, notify: notify);
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
      // It exists
      _updateList(nodes, node);
    }
  }

  void updateNode(NodeType type, Node updatedNode, {bool notify = true}) {
    final List<Node> nodes = _getList(type);
    _updateList(nodes, updatedNode, notify: notify);
  }

  void _updateList(List<Node> list, Node updatedNode, {bool notify = true}) {
    final int index =
        list.indexWhere((Node node) => node.url == updatedNode.url);
    if (index != -1) {
      list.replaceRange(index, index + 1, <Node>[updatedNode]);
    }
    if (notify) {
      notifyObserver();
    }
  }

  void increaseNodeErrors(NodeType type, Node node,
      {required String cause, bool notify = true}) {
    final List<Node> nodes = _getList(type);
    final Node? currentNode = nodes.cast<Node?>().firstWhere(
          (Node? n) => n?.url == node.url,
          orElse: () => null,
        );
    if (currentNode != null) {
      final int newErrors = currentNode.errors + 1;

      // If node exceeds absolute max errors, mark as offline with high latency
      // instead of removing it (to keep history)
      if (newErrors >= NodeManager.absoluteMaxErrors) {
        logger(
            'Node ${node.url} has reached $newErrors errors (limit: ${NodeManager.absoluteMaxErrors}). '
            'Marking as offline with high latency. Last cause: $cause');
        updateNode(
            type, currentNode.copyWith(errors: newErrors, latency: wrongNode),
            notify: notify);
        return;
      }

      logger(
          'Increasing node errors of ${node.url} to $newErrors. Cause: $cause');
      updateNode(type, currentNode.copyWith(errors: newErrors), notify: notify);
    } else {
      // The node does not exist in the list, this should not happen normally
      logger(
          'Warning: Trying to increase errors for non-existent node ${node.url}. Cause: $cause');
    }
  }

  void addNodeSortedByLatency(NodeType type, Node node, {bool notify = true}) {
    final List<Node> nodes = _getList(type);

    if (nodes.isEmpty) {
      _insertNode(nodes, node);
      if (notify) {
        notifyObserver();
      }
      return;
    }

    // Find the correct position based on errors first, then latency
    int insertPosition = nodes.length;
    for (int i = 0; i < nodes.length; i++) {
      final Node existingNode = nodes[i];

      // Compare errors first
      if (node.errors < existingNode.errors) {
        insertPosition = i;
        break;
      } else if (node.errors == existingNode.errors) {
        // If errors are equal, compare latency
        if (node.latency < existingNode.latency) {
          insertPosition = i;
          break;
        }
      }
    }

    // Check if node already exists
    if (_find(nodes, node)) {
      _updateList(nodes, node, notify: notify);
    } else {
      nodes.insert(insertPosition, node);
      if (notify) {
        notifyObserver();
      }
    }
  }

  void cleanErrorStats({bool notify = true}) {
    for (final NodeType type in NodeType.values) {
      final List<Node> nodes = _getList(type);
      final List<Node> newList =
          nodes.map((Node node) => node.copyWith(errors: 0)).toList();
      nodes.clear();
      nodes.addAll(newList);
    }
    if (notify) {
      notifyObserver();
    }
  }

  /// Mark nodes with excessive errors as offline (high latency) instead of removing
  void cleanNodesWithExcessiveErrors({bool notify = true}) {
    int totalMarked = 0;
    for (final NodeType type in NodeType.values) {
      final List<Node> nodes = _getList(type);
      int marked = 0;

      for (int i = 0; i < nodes.length; i++) {
        final Node node = nodes[i];
        if (node.errors >= NodeManager.absoluteMaxErrors && node.isOk) {
          // Mark as offline by setting high latency
          nodes[i] = node.copyWith(latency: wrongNode);
          marked++;
        }
      }

      if (marked > 0) {
        totalMarked += marked;
        logger(
            'Marked $marked nodes as offline in ${type.name} (errors >= ${NodeManager.absoluteMaxErrors})');
      }
    }
    if (totalMarked > 0) {
      logger(
          'Total nodes marked as offline with excessive errors: $totalMarked');
      if (notify) {
        notifyObserver();
      }
    }
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
    return NodeManagerObserver.instance.currentGvaNode;
  }

  void setCurrentGvaNode(Node node) {
    NodeManagerObserver.instance.setCurrentGvaNode(node);
  }

  List<Node> getBestNodes(NodeType type) {
    final List<Node> allNodes = NodeManager().nodeList(type);

    // For cesiumPlus, always prefer https://g1.data.e-is.pro if accessible
    if (type == NodeType.cesiumPlus) {
      Node? preferredNode;
      try {
        preferredNode = allNodes.firstWhere(
          (Node node) =>
              node.url == 'https://g1.data.e-is.pro' &&
              node.isOk &&
              node.errors < NodeManager.absoluteMaxErrors,
        );
      } catch (_) {
        preferredNode = null;
      }
      if (preferredNode != null) {
        return <Node>[
          preferredNode,
          ...allNodes.where((Node n) => n.url != 'https://g1.data.e-is.pro')
        ];
      }
    }

    // Filter out nodes with huge latency (offline nodes) AND excessive errors
    final List<Node> onlineNodes = allNodes
        .where((Node node) =>
            node.isOk && node.errors < NodeManager.absoluteMaxErrors)
        .toList();

    if (onlineNodes.isEmpty) {
      logger(
          'No online nodes available for ${type.name}, falling back to defaults');
      final List<Node> defaultNodesForType = defaultNodes(type);
      defaultNodesForType.shuffle();
      return defaultNodesForType;
    }

    // For indexer nodes, filter by highest version first
    List<Node> filteredNodes = onlineNodes;
    if (type == NodeType.duniterIndexer) {
      // Get nodes with version info (non-null and non-empty)
      final List<Node> nodesWithVersion =
          onlineNodes.where((Node n) => n.hasVersion).toList();

      if (nodesWithVersion.isNotEmpty) {
        // Find the highest version by comparing all versions
        String highestVersion = nodesWithVersion.first.version!;
        for (final Node node in nodesWithVersion) {
          if (_compareVersions(node.version!, highestVersion) > 0) {
            highestVersion = node.version!;
          }
        }

        // Filter to only nodes with the highest version
        final List<Node> nodesWithHighestVersion = nodesWithVersion
            .where((Node n) => n.version == highestVersion)
            .toList();

        // Among nodes with highest version, find the highest block
        if (nodesWithHighestVersion.isNotEmpty) {
          final int maxBlock = nodesWithHighestVersion.fold(
            0,
            (int max, Node node) =>
                node.currentBlock > max ? node.currentBlock : max,
          );

          // Use only nodes with highest version AND highest block
          filteredNodes = nodesWithHighestVersion
              .where((Node n) => (maxBlock - n.currentBlock).abs() <= 2)
              .toList();

          logger(
              'Filtering indexer nodes by highest version: $highestVersion and max block: $maxBlock (${filteredNodes.length} nodes)');
        } else {
          filteredNodes = nodesWithHighestVersion;
        }
      } else {
        logger(
            'No indexer nodes with version info available, using all online nodes');
      }
    }

    final List<Node> nodesWithFewErrors = filteredNodes
        .where((Node n) => n.errors < NodeManager.maxNodeErrors)
        .toList();

    // Use only filtered nodes to find the max block
    final int maxCurrentBlock = filteredNodes.fold(
      0,
      (int max, Node node) => node.currentBlock > max ? node.currentBlock : max,
    );

    bool isNearMax(Node node) =>
        (maxCurrentBlock - node.currentBlock).abs() <= 2;

    final List<Node> workingAndSynced =
        nodesWithFewErrors.where(isNearMax).toList();

    if (workingAndSynced.isNotEmpty) {
      sortNodesByErrorOrLatency(workingAndSynced);
      workingAndSynced
          .shuffle(); // Shuffle to avoid always using the same order
      return workingAndSynced;
    }

    final List<Node> syncedWithErrors = filteredNodes.where(isNearMax).toList();

    if (syncedWithErrors.isNotEmpty) {
      syncedWithErrors.shuffle();
      return syncedWithErrors;
    }

    final List<Node> defaultNodesForType = defaultNodes(type);
    defaultNodesForType.shuffle();
    return defaultNodesForType;
  }

  /// Compare two semantic version strings (e.g., "1.2.3" vs "1.2.4")
  /// Returns: 1 if version1 > version2, -1 if version1 < version2, 0 if equal
  int _compareVersions(String version1, String version2) {
    if (version1.isEmpty) {
      return -1;
    }
    if (version2.isEmpty) {
      return 1;
    }
    if (version1 == version2) {
      return 0;
    }

    final List<String> v1Parts = version1.split('.');
    final List<String> v2Parts = version2.split('.');
    final int maxLength =
        v1Parts.length > v2Parts.length ? v1Parts.length : v2Parts.length;

    for (int i = 0; i < maxLength; i++) {
      final int v1Part = i < v1Parts.length ? int.tryParse(v1Parts[i]) ?? 0 : 0;
      final int v2Part = i < v2Parts.length ? int.tryParse(v2Parts[i]) ?? 0 : 0;

      if (v1Part > v2Part) {
        return 1;
      }
      if (v1Part < v2Part) {
        return -1;
      }
    }

    return 0;
  }

  @Deprecated('Use cesium+ instead')
  String ipfsUrl(String path) {
    if (currentIfpsNode == null) {
      final List<Node> workingNodes = nodesWorkingList(NodeType.ipfsGateway);
      if (workingNodes.isNotEmpty) {
        currentIfpsNode = workingNodes.first.url;
      } else {
        loggerDev('No working IPFS gateway nodes available, trying defaults');
        final List<Node> defaultIpfsNodes = defaultNodes(NodeType.ipfsGateway);
        if (defaultIpfsNodes.isNotEmpty) {
          currentIfpsNode = defaultIpfsNodes.first.url;
        } else {
          throw Exception('No IPFS gateway nodes available');
        }
      }
    }
    return '${currentIfpsNode!}/ipfs/$path';
  }
}

class NodeManagerObserver {
  NodeManagerObserver._internal();

  static final NodeManagerObserver instance = NodeManagerObserver._internal();

  final NodeListCubit cubit = GetIt.instance.get<NodeListCubit>();

  void setLoading(bool isLoading) {
    cubit.setLoading(isLoading);
  }

  void update(NodeManager nodeManager) {
    cubit.setDuniterNodes(nodeManager.duniterNodes);
    cubit.setCesiumPlusNodes(nodeManager.cesiumPlusNodes);
    cubit.setGvaNodes(nodeManager.gvaNodes);
    cubit.setEndpointNodes(nodeManager.endpointNodes);
    cubit.setDuniterIndexerNodes(nodeManager.duniterIndexerNodes);
    cubit.setDuniterDataNodes(nodeManager.duniterDataNodes);
    cubit.setIpfsGateways(nodeManager.ipfsGateways);
  }

  void setCurrentGvaNode(Node node) {
    cubit.setCurrentGvaNode(node);
  }

  Node? get currentGvaNode {
    return cubit.currentGvaNode;
  }
}

void sortNodesByErrorOrLatency(List<Node> nodesNearMaxBlock) {
  nodesNearMaxBlock.sort((Node a, Node b) {
    final int errorComparison = a.errors.compareTo(b.errors);
    if (errorComparison != 0) {
      return errorComparison;
    } else {
      return a.latency.compareTo(b.latency);
    }
  });
}
