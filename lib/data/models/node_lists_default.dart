import '../../env.dart';
import 'network_config.dart';
import 'network_registry.dart';
import 'node.dart';
import 'node_lists_g1.dart';
import 'node_lists_gtest.dart';
import 'node_type.dart';

List<Node> _splitList(String list) =>
    list.split(' ').map((String url) => Node(url: url)).toList();

List<Node> _readDotNodeConfig(String entry) => _splitList(entry);

List<Node> defaultCesiumPlusNodes = <Node>{
  ..._readDotNodeConfig(Env.cesiumPlusNodes),
  ..._splitList('https://g1.data.e-is.pro')
}.toList();

List<Node> defaultEndPointNodes = <Node>{
  // For doing tests of faulty nodes
  // if (kDebugMode) const Node(url: 'wss://just-testing-a-wrong-node.com/ws'),
  ..._readDotNodeConfig(Env.endPoints),
}.toList();

List<Node> defaultDuniterIndexerNodes = <Node>{
  ..._readDotNodeConfig(Env.duniterIndexerNodes),
}.toList();

List<Node> defaultDatapodEndpointNodes = <Node>{
  ..._readDotNodeConfig(Env.datapodEndpoints),
}.toList();

List<Node> defaultIpfsGateways = <Node>{
  ..._readDotNodeConfig(Env.ipfsGateways),
}.toList();

/// Gets hardcoded endpoint nodes based on the current network
/// Returns G1 or gtest nodes as fallback for offline mode or fetch failures
List<Node> getHardcodedEndpointNodes() {
  final config = NetworkRegistry.getConfig();
  switch (config.id) {
    case NetworkId.g1:
      return nodeListsG1Endpoints;
    case NetworkId.g1Test:
      return nodeListsGtestEndpoints;
  }
}

/// Gets hardcoded duniter indexer nodes based on the current network
/// Returns G1 or gtest nodes as fallback for offline mode or fetch failures
List<Node> getHardcodedDuniterIndexerNodes() {
  final config = NetworkRegistry.getConfig();
  switch (config.id) {
    case NetworkId.g1:
      return nodeListsG1DuniterIndexer;
    case NetworkId.g1Test:
      return nodeListsGtestDuniterIndexer;
  }
}

List<Node> defaultNodes(NodeType type) {
  switch (type) {
    case NodeType.cesiumPlus:
      return defaultCesiumPlusNodes;
    case NodeType.endpoint:
      return defaultEndPointNodes;
    case NodeType.duniterIndexer:
      return defaultDuniterIndexerNodes;
    case NodeType.datapodEndpoint:
      return defaultDatapodEndpointNodes;
    case NodeType.ipfsGateway:
      return defaultIpfsGateways;
  }
}
