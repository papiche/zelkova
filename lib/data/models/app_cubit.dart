import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../g1/currency.dart';
import '../../g1/distance_precompute.dart';
import '../../ui/logger.dart';
import '../wot_info_fetcher.dart';
import 'app_state.dart';
import 'contact.dart';
import 'contact_wot_info.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(AppState());

  @override
  String get storagePrefix => kIsWeb ? 'AppCubit' : super.storagePrefix;

  bool get isIntroViewed => state.introViewed;

  bool get isWalletCreatedViewed => state.walletCreatedViewed;

  bool get isWarningViewed => state.warningViewed;

  bool get isWarningBrowserViewed => state.warningBrowserViewed;

  bool get isWarningBraveViewed => state.warningBraveViewed;

  bool get isExpertMode => state.expertMode;

  Currency get currency => state.currency;

  double get currentUd => state.currentUd;

  bool get hasRecentExport => state.hasRecentExport;

  int get recentExportReminderInDays => state.recentExportReminderInDays;

  void introViewed() {
    emit(state.copyWith(introViewed: true));
  }

  void walletCreatedViewed() {
    emit(state.copyWith(walletCreatedViewed: true));
  }

  void warningViewed() {
    emit(state.copyWith(warningViewed: true));
  }

  void warningBrowserViewed() {
    emit(state.copyWith(warningBrowserViewed: true));
  }

  void warningBraveViewed() {
    emit(state.copyWith(warningBraveViewed: true));
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

  void multipassPrompted() {
    onFinishTutorial('multipass_prompt');
  }

  void setG1Currency() {
    emit(state.copyWith(currency: Currency.G1));
  }

  void setDUCurrency() {
    emit(state.copyWith(currency: Currency.DU));
  }

  void setZenCurrency() {
    emit(state.copyWith(currency: Currency.ZEN));
  }

  void setUd(double currentUd) {
    if (isClosed) {
      logger(
          '[AppCubit] Skipping setUd(currentUd=$currentUd), cubit is closed. '
          'UD will be re-fetched on next app startup.');
      return;
    }

    try {
      emit(state.copyWith(
          currentUd: currentUd, currentUdLastUpdate: DateTime.now()));
      loggerDev('[AppCubit] Updated UD to $currentUd');
    } catch (e) {
      if (e is StateError &&
          e.toString().contains('Cannot emit new states after calling close')) {
        logger('[AppCubit] State emission prevented (cubit already closed). '
            'UD will be re-fetched on next app startup.');
      } else {
        rethrow;
      }
    }
  }

  bool shouldUpdateUd() {
    // Update UD if never updated or if it's been more than 24 hours
    if (state.currentUdLastUpdate == null) {
      return true;
    }
    final Duration timeSinceLastUpdate =
        DateTime.now().difference(state.currentUdLastUpdate!);
    return timeSinceLastUpdate.inHours >= 24;
  }

  DateTime? get currentUdLastUpdate => state.currentUdLastUpdate;

  void setV2Mode(bool v2mode) {
    emit(state.copyWith(v2mode: v2mode));
  }

  bool get isV2 => state.v2mode;

  bool get isV2AutoActivated => state.v2AutoActivated;

  void autoActivateV2() {
    emit(state.copyWith(v2mode: true, v2AutoActivated: true));
  }

  void deactivateAutoV2() {
    emit(state.copyWith(v2mode: false, v2AutoActivated: false));
  }

  void setDistancePreCompute(DistancePrecompute distancePrecompute) {
    emit(state.copyWith(distancePrecompute: distancePrecompute));
  }

  DistancePrecompute? get distancePrecompute => state.distancePrecompute;

  void setHasRecentExport(bool value) {
    emit(state.copyWith(hasRecentExport: value));
  }

  void setRecentExportReminderInDays(int days) {
    emit(state.copyWith(recentExportReminderInDays: days));
  }

  Future<void> updateWotInfo(Contact contact) async {
    await for (final ContactWotInfo info
        in WotInfoFetcher.fetch(contact, this)) {
      emit(state.copyWith(wotInfo: info));
    }
  }
}
