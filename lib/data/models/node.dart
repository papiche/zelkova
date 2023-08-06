import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'node.g.dart';

@JsonSerializable()
class Node extends Equatable implements IsJsonSerializable<Node> {
  const Node(
      {required this.url,
      this.latency = 99999,
      this.errors = 0,
      this.currentBlock = 0});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  final String url;
  final int latency;
  final int errors;
  final int currentBlock;

  Node copyWith({String? url, int? latency, int? errors, int? currentBlock}) {
    return Node(
      url: url ?? this.url,
      latency: latency ?? this.latency,
      errors: errors ?? this.errors,
      currentBlock: currentBlock ?? this.currentBlock,
    );
  }

  @override
  String toString() {
    return 'node url: $url latency: $latency errors: $errors currentBlock: $currentBlock';
  }

  @override
  Map<String, dynamic> toJson() => _$NodeToJson(this);

  @override
  Node fromJson(Map<String, dynamic> json) => Node.fromJson(json);

  @override
  List<Object?> get props => <dynamic>[url];
}

List<Node> _splitList(String list) =>
    list.split(' ').map((String url) => Node(url: url)).toList();

List<Node> _readDotNodeConfig(String entry) => _splitList(dotenv.env[entry]!);

List<Node> defaultDuniterNodes = _readDotNodeConfig('DUNITER_NODES');
List<Node> defaultCesiumPlusNodes = <Node>{
  ..._readDotNodeConfig('CESIUM_PLUS_NODES'),
  ..._splitList(
      'https://g1.data.brussels.ovh https://g1.data.e-is.pro https://g1.data.mithril.re https://g1.data.pini.fr https://g1.data.presles.fr https://g1.data.geragc.es')
}.toList();
List<Node> defaultGvaNodes = <Node>{
  ..._readDotNodeConfig('GVA_NODES'),
  ..._splitList(
      'https://g1.cuates.net/gva https://g1.madeirawonders.com/gva https://g1.brussels.ovh/gva https://g1.geragc.es/gva https://gva.seeds4c.org/gva')
}.toList();

// We test local duniter node in dev mode
/* List<Node> defaultGvaNodes = kReleaseMode
    ? readDotNodeConfig('GVA_NODES')
    : <Node>[const Node(url: 'http://localhost:30901/gva/')]
  ..addAll(readDotNodeConfig('GVA_NODES'));
// List<Node> defaultGvaNodes = readDotNodeConfig('GVA_NODES');
 : <Node>[const Node(url: 'http://localhost:30901/gva/')]
  ..addAll(readDotNodeConfig('GVA_NODES')); */
