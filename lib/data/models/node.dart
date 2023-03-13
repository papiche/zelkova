import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'isJsonSerializable.dart';

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

const List<Node> defaultDuniterNodes = <Node>[
  Node(url: 'https://g1.duniter.fr'),
  Node(url: 'https://g1.le-sou.org'),
  Node(url: 'https://g1.cgeek.fr'),
  Node(url: 'https://g1.monnaielibreoccitanie.org'),
  Node(url: 'https://g1.duniter.fr'),
  Node(url: 'https://g1.le-sou.org'),
  Node(url: 'https://g1.cgeek.fr')
];

const List<Node> defaultCesiumPlusNodes = <Node>[
  Node(url: 'https://g1.data.e-is.pro'),
  Node(url: 'https://g1.data.presler.fr'),
  Node(url: 'https://g1.data.le-sou.org'),
  Node(url: 'https://g1.data.mithril.re')
];
