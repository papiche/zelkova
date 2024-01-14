import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

@JsonSerializable()
class Node extends Equatable {
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

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  Node fromJson(Map<String, dynamic> json) => Node.fromJson(json);

  @override
  List<Object?> get props => <dynamic>[url];
}
