import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'ui/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logger('============= onCreate ============= ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // Disabled
    // logger('============= ${bloc.runtimeType} $change =============');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    Sentry.captureException(error, stackTrace: stackTrace);
    logger('============= onError ============= $error');
    logger(stackTrace);
  }
}
