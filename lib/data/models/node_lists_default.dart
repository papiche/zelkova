import '../../env.dart';
import 'node.dart';
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
