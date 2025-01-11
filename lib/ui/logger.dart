// logs
import 'package:easy_logger/easy_logger.dart';
import 'package:logger/logger.dart';

import 'in_dev_helper.dart';

final Logger log = Logger();

final EasyLogger logger = EasyLogger(
  name: 'ginkgo',
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
      log.e(message, error: error, stackTrace: stackTrace);
    } else {
      logger(message);
    }
  }
}
