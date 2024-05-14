import 'package:flutter/foundation.dart';

import '../../env.dart';
import 'node.dart';
import 'node_type.dart';

List<Node> _splitList(String list) =>
    list.split(' ').map((String url) => Node(url: url)).toList();

List<Node> _readDotNodeConfig(String entry) => _splitList(entry);

List<Node> defaultDuniterNodes = <Node>{
  ..._readDotNodeConfig(Env.duniterNodes),
  ..._splitList(
      'duniter.pini.fr duniter.g1.pfouque.xyz fania.g1server.net g1.brussels.ovh g1.cgeek.fr g1.computhings.be g1.cuates.net g1.geragc.es g1.madeirawonders.com g1.rendall.fr g1.trentesaux.fr gibraleon.g1server.net vit.fdn.org')
}.toList();

List<Node> defaultCesiumPlusNodes = <Node>{
  ..._readDotNodeConfig(Env.cesiumPlusNodes),
  ..._splitList(
      'https://g1.data.brussels.ovh https://g1.data.e-is.pro https://g1.data.mithril.re https://g1.data.pini.fr https://g1.data.presles.fr https://g1.data.geragc.es')
}.toList();
List<Node> defaultGvaNodes = <Node>{
  ..._readDotNodeConfig(Env.gvaNodes),
  ..._splitList(
      'https://g1.cuates.net/gva https://g1.madeirawonders.com/gva https://g1.brussels.ovh/gva https://g1.geragc.es/gva https://gva.seeds4c.org/gva')
}.toList();

List<Node> defaultEndPointNodes = <Node>{
  // For doing tests of faulty nodes
  if (kDebugMode) const Node(url: 'wss://just-testing-a-wrong-node.com/ws'),
  ..._readDotNodeConfig(Env.endPoints),
}.toList();

List<Node> defaultDuniterIndexerNodes = <Node>{
  ..._readDotNodeConfig(Env.duniterIndexerNodes),
}.toList();

List<Node> defaultNodes(NodeType type) {
  switch (type) {
    case NodeType.duniter:
      return defaultDuniterNodes;
    case NodeType.cesiumPlus:
      return defaultCesiumPlusNodes;
    case NodeType.gva:
      return defaultGvaNodes;
    case NodeType.endpoint:
      return defaultEndPointNodes;
    case NodeType.duniterIndexer:
      return defaultDuniterIndexerNodes;
  }
}

// We test local duniter node in dev mode
/* List<Node> defaultGvaNodes = kReleaseMode
    ? readDotNodeConfig('GVA_NODES')
    : <Node>[const Node(url: 'http://localhost:30901/gva/')]
  ..addAll(readDotNodeConfig('GVA_NODES'));
// List<Node> defaultGvaNodes = readDotNodeConfig('GVA_NODES');
 : <Node>[const Node(url: 'http://localhost:30901/gva/')]
  ..addAll(readDotNodeConfig('GVA_NODES')); */
