import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../g1/currency.dart';
import 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(AppState());

  @override
  String get storagePrefix => kIsWeb ? 'AppCubit' : super.storagePrefix;

  bool get isIntroViewed => state.introViewed;

  bool get isWarningViewed => state.warningViewed;

  bool get isWarningBrowserViewed => state.warningBrowserViewed;

  bool get isExpertMode => state.expertMode;

  Currency get currency => state.currency;

  double get currentUd => state.currentUd;

  void introViewed() {
    emit(state.copyWith(introViewed: true));
  }

  void warningViewed() {
    emit(state.copyWith(warningViewed: true));
  }

  void warningBrowserViewed() {
    emit(state.copyWith(warningBrowserViewed: true));
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

  bool onFinishTutorial(String tutorialId) {
    state.tutorials[tutorialId] = true;
    emit(state.copyWith(tutorials: state.tutorials));
    return true;
  }

  bool wasTutorialShown(String tutorialId) {
    return state.tutorials[tutorialId] ?? false;
  }

  void setG1Currency() {
    emit(state.copyWith(currency: Currency.G1));
  }

  void setDUCurrency() {
    emit(state.copyWith(currency: Currency.DU));
  }

  void setUd(double currentUd) {
    emit(state.copyWith(currentUd: currentUd));
  }
}
