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

  void onFinishTutorial(String tutorialId) {
    state.tutorials[tutorialId] = true;
    emit(state.copyWith(tutorials: state.tutorials));
  }

  bool wasTutorialShown(String tutorialId) {
    return state.tutorials[tutorialId] ?? false;
  }

  void switchCurrency() {
    emit(state.copyWith(
        currency: state.currency == Currency.G1 ? Currency.DU : Currency.G1));
  }
}
