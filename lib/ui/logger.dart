// logs
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

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
  if (inDevelopment && message != null) {
    if (error != null || stackTrace != null) {
      // Log in a more discrete way instead of using log.e()
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
      logger(buffer.toString());
    } else {
      logger(message);
    }
  }
}
