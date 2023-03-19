import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';

import 'is_json_serializable.dart';

part 'node.g.dart';

@JsonSerializable()
class Node extends Equatable implements IsJsonSerializable<Node> {
  const Node({
    required this.url,
    this.latency = 99999,
    this.errors = 0,
  });

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  final String url;
  final int latency;
  final int errors;

  Node copyWith({
    String? url,
    int? latency,
    int? errors,
  }) {
    return Node(
      url: url ?? this.url,
      latency: latency ?? this.latency,
      errors: errors ?? this.errors,
    );
  }

  @override
  String toString() {
    return 'node url: $url latency: $latency errors: $errors';
  }

  @override
  Map<String, dynamic> toJson() => _$NodeToJson(this);

  @override
  Node fromJson(Map<String, dynamic> json) => Node.fromJson(json);

  @override
  List<Object?> get props => <dynamic>[url, latency, errors];
}

List<Node> readDotNodeConfig(String entry) =>
    dotenv.env[entry]!.split(' ').map((String url) => Node(url: url)).toList();

List<Node> defaultDuniterNodes = readDotNodeConfig('DUNITER_NODES');
List<Node> defaultCesiumPlusNodes = readDotNodeConfig('CESIUM_PLUS_NODES');
List<Node> defaultGvaNodes = readDotNodeConfig('GVA_NODES');
