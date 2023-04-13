// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      url: json['url'] as String,
      latency: json['latency'] as int? ?? 99999,
      errors: json['errors'] as int? ?? 0,
      currentBlock: json['currentBlock'] as int? ?? 0,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'url': instance.url,
      'latency': instance.latency,
      'errors': instance.errors,
      'currentBlock': instance.currentBlock,
    };
