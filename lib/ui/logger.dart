// logs
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../services/feedback_service.dart';
import 'in_dev_helper.dart';

final Logger log = Logger();

final EasyLogger logger = EasyLogger(
  name: 'zelkova',
  defaultLevel: LevelMessages.debug,
  enableBuildModes: <BuildMode>[
    BuildMode.debug,
    BuildMode.profile,
    BuildMode.release
  ],
  enableLevels: <LevelMessages>[
    LevelMessages.debug,
    LevelMessages.info,
    LevelMessages.error,
    LevelMessages.warning
  ],
);

void loggerDev(Object? message, {Object? error, StackTrace? stackTrace}) {
  if (message == null) {
    return;
  }
  final StringBuffer buffer = StringBuffer(message.toString());
  if (error != null) {
    buffer.write(' | Error: $error');
  }
  if (stackTrace != null && !kReleaseMode) {
    // Only include minimal stack trace info in debug mode
    final List<String> lines = stackTrace.toString().split('\n');
    if (lines.isNotEmpty) {
      buffer.write(' | Stack: ${lines.first}');
    }
  }
  // Alimente le buffer de feedback (AppLogBuffer) dans TOUS les modes —
  // y compris release — pour que "Inclure les informations techniques"
  // dans FeedbackScreen contienne réellement des logs. `logger(...)`
  // ci-dessous reste réservé au mode développement (bruit console/coût).
  AppLogBuffer.add(buffer.toString(), level: error != null ? 'error' : 'log');
  if (inDevelopment) {
    logger(buffer.toString());
  }
}
