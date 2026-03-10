import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

const Duration wrongNodeDuration = Duration(days: 2);
final int wrongNode = wrongNodeDuration.inMicroseconds;

@JsonSerializable()
class Node extends Equatable {
  const Node(
      {required this.url,
      this.latency = 99999,
      this.errors = 0,
      this.currentBlock = 0,
      this.version,
      this.lastErrorTime,
      this.consecutiveErrors = 0});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  final String url;
  final int latency;
  final int errors;
  final int currentBlock;
  final String? version;
  final DateTime? lastErrorTime;
  final int consecutiveErrors;

  Node copyWith(
      {String? url,
      int? latency,
      int? errors,
      int? currentBlock,
      String? version,
      DateTime? lastErrorTime,
      int? consecutiveErrors}) {
    return Node(
      url: url ?? this.url,
      latency: latency ?? this.latency,
      errors: errors ?? this.errors,
      currentBlock: currentBlock ?? this.currentBlock,
      version: version ?? this.version,
      lastErrorTime: lastErrorTime ?? this.lastErrorTime,
      consecutiveErrors: consecutiveErrors ?? this.consecutiveErrors,
    );
  }

  /// Copy with support for explicitly setting null values
  /// Use this when you need to reset fields to null (e.g., lastErrorTime)
  Node copyWithNullable({
    String? url,
    int? latency,
    int? errors,
    int? currentBlock,
    String? version,
    DateTime? Function()? lastErrorTime,
    int? consecutiveErrors,
  }) {
    return Node(
      url: url ?? this.url,
      latency: latency ?? this.latency,
      errors: errors ?? this.errors,
      currentBlock: currentBlock ?? this.currentBlock,
      version: version ?? this.version,
      lastErrorTime:
          lastErrorTime != null ? lastErrorTime() : this.lastErrorTime,
      consecutiveErrors: consecutiveErrors ?? this.consecutiveErrors,
    );
  }

  @override
  String toString() {
    return 'node url: $url latency: $latency errors: $errors currentBlock: $currentBlock version: $version';
  }

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  Node fromJson(Map<String, dynamic> json) => Node.fromJson(json);

  bool get isNotOk => latency >= wrongNode;

  bool get isOk => latency < wrongNode;

  bool get hasVersion => version != null && version!.isNotEmpty;

  @override
  List<Object?> get props => <dynamic>[url, lastErrorTime, consecutiveErrors];
}
