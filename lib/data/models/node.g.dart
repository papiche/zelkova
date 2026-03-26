// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
  url: json['url'] as String,
  latency: (json['latency'] as num?)?.toInt() ?? 99999,
  errors: (json['errors'] as num?)?.toInt() ?? 0,
  currentBlock: (json['currentBlock'] as num?)?.toInt() ?? 0,
  version: json['version'] as String?,
  lastErrorTime: json['lastErrorTime'] == null
      ? null
      : DateTime.parse(json['lastErrorTime'] as String),
  consecutiveErrors: (json['consecutiveErrors'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
  'url': instance.url,
  'latency': instance.latency,
  'errors': instance.errors,
  'currentBlock': instance.currentBlock,
  'version': instance.version,
  'lastErrorTime': instance.lastErrorTime?.toIso8601String(),
  'consecutiveErrors': instance.consecutiveErrors,
};
