// lib/env/env.dart
// ignore_for_file: avoid_classes_with_only_static_members

import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied(path: kReleaseMode ? '.env' : '.env.dev', allowOptionalFields: true)
abstract class Env {
  @EnviedField(varName: 'CURRENCY')
  static const String currency = _Env.currency;
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String? sentryDsn = _Env.sentryDsn;

  @EnviedField(varName: 'GITLAB_TOKEN', obfuscate: true)
  static final String gitLabToken = _Env.gitLabToken;

  // Nodes
  // v1
  // @EnviedField(defaultValue: 'test_')
  @EnviedField(varName: 'DUNITER_NODES')
  static const String duniterNodes = _Env.duniterNodes;
  @EnviedField(varName: 'CESIUM_PLUS_NODES')
  static const String cesiumPlusNodes = _Env.cesiumPlusNodes;
  @EnviedField(varName: 'GVA_NODES')
  static const String gvaNodes = _Env.gvaNodes;

  // v2
  @EnviedField(varName: 'ENDPOINTS')
  static const String endPoints = _Env.endPoints;
  @EnviedField(varName: 'DUNITER_INDEXER_NODES')
  static const String duniterIndexerNodes = _Env.duniterIndexerNodes;
}
