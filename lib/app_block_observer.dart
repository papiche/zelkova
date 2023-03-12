import 'package:bloc/bloc.dart';

import 'main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logger('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    logger('onEvent -- $event');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger('onTransition -- $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger('onError -- $error');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    logger('onClose -- ${bloc.runtimeType}');
  }
}
