import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

@JsonSerializable()
class Node {
  Node({
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Node &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          latency == other.latency &&
          errors == other.errors;

  @override
  int get hashCode => url.hashCode ^ latency.hashCode ^ errors.hashCode;
}

abstract class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object?> get props => <dynamic>[];
}

class AddNode extends NodeEvent {
  const AddNode({required this.node});

  final Node node;

  @override
  List<Object?> get props => [node];
}

class InsertNode extends NodeEvent {
  const InsertNode({required this.node});

  final Node node;

  @override
  List<Object?> get props => <dynamic>[node];
}

class AddCPlusNode extends NodeEvent {
  const AddCPlusNode({required this.node});

  final Node node;

  @override
  List<Object?> get props => <dynamic>[node];
}

extension NodeExtensions on Node {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'latency': latency,
      'errors': errors,
    };
  }

  static Node fromJson(Map<String, dynamic> json) {
    return Node(
      url: json['url'] as String,
      latency: json['latency'] as int,
      errors: json['errors'] as int,
    );
  }
}

enum NodeStatus { loading, loaded }

class NodeState extends Equatable {
  const NodeState(
      {required this.nodes, required this.cPlusNodes, required this.status});

  final List<Node> nodes;
  final List<Node> cPlusNodes;
  final NodeStatus status;

  NodeState copyWith(
      {List<Node>? nodes, List<Node>? cPlusNodes, NodeStatus? status}) {
    return NodeState(
      nodes: nodes ?? this.nodes,
      cPlusNodes: cPlusNodes ?? this.cPlusNodes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [nodes, cPlusNodes, status];
}

class LoadNodes extends NodeEvent {
  const LoadNodes(this.nodes);

  final List<Node> nodes;

  @override
  List<Object> get props => <Object>[nodes];

  @override
  String toString() => 'LoadNodes { nodes: $nodes }';
}

class SetNodes extends NodeEvent {
  const SetNodes(this.nodes);

  final List<Node> nodes;

  @override
  List<Object> get props => <Object>[nodes];

  @override
  String toString() => 'AddNodes { nodes: $nodes }';
}

class AddCPlusNodes extends NodeEvent {
  const AddCPlusNodes(this.nodes);

  final List<Node> nodes;

  @override
  List<Object> get props => [nodes];

  @override
  String toString() => 'AddNodes { nodes: $nodes }';
}

final List<Node> defaultDuniterNodes = <Node>[
  Node(url: 'https://g1.duniter.fr'),
  Node(url: 'https://g1.le-sou.org'),
  Node(url: 'https://g1.cgeek.fr'),
  Node(url: 'https://g1.monnaielibreoccitanie.org'),
  Node(url: 'https://g1.duniter.fr'),
  Node(url: 'https://g1.le-sou.org'),
  Node(url: 'https://g1.cgeek.fr')
];

final List<Node> defaultCesiumPlusNodes = <Node>[
  Node(url: 'https://g1.data.e-is.pro'),
  Node(url: 'https://g1.data.presler.fr'),
  Node(url: 'https://g1.data.le-sou.org'),
  Node(url: 'https://g1.data.mithril.re')
];
