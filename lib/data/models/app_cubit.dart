import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  bool get isIntroViewed => state.introViewed;

  bool get isWarningViewed => state.warningViewed;

  bool get isExpertMode => state.expertMode;

  void introViewed() {
    emit(state.copyWith(introViewed: true));
  }

  void warningViewed() {
    emit(state.copyWith(warningViewed: true));
  }

  @override
  AppState fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AppState state) {
    return state.toJson();
  }

  void setExpertMode(bool value) {
    emit(state.copyWith(expertMode: value));
  }
}
