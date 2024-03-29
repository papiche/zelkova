// logs
import 'package:easy_logger/easy_logger.dart';

import 'ui_helpers.dart';

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

void loggerDev(Object? message) {
  if (inDevelopment && message != null) {
    logger(message);
  }
}
