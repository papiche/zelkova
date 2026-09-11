import 'package:hive_ce_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../g1/nostr/nostr_relay_service.dart';
import '../shared_prefs_helper_v2.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import 'astroport_station_service.dart';

/// Full factory reset of the app's local state, for the "Reset application"
/// settings action.
///
/// Unlike [SharedPreferencesHelperV2.removeWallet] — which only ever removes
/// one account among several and refuses to drop the last one — this wipes
/// every account, key, cache and preference this app has ever written on
/// this device, leaving it as if freshly installed. There is no way back
/// short of restoring from an exported backup.
class AppResetService {
  const AppResetService._();

  static Future<void> resetApplication() async {
    try {
      await NostrRelayService().forceDisconnect();
    } catch (e) {
      loggerDev('AppResetService: relay disconnect error (ignored): $e');
    }

    // Accounts, NOSTR/MULTIPASS/ATOM4LOVE keys, LOVE contacts, unlock
    // pattern/password/salt — everything this app ever put in secure storage.
    await SharedPreferencesHelperV2().wipeSecureStorage();

    try {
      AstroportStationService().clearCache();
    } catch (e) {
      loggerDev('AppResetService: station cache clear error (ignored): $e');
    }
    try {
      await ContactsCache().clear();
    } catch (e) {
      loggerDev('AppResetService: contacts cache clear error (ignored): $e');
    }

    // Every persisted Cubit/Bloc state (AppCubit, ThemeCubit, ContactCubit,
    // NodeListCubit, MultiWalletTransactionCubit, ...).
    await HydratedBloc.storage.clear();

    // Every remaining Hive box on disk (contacts cache, Ferry GraphQL
    // caches, ...) — mirrors the recovery path already used in
    // main.dart's hiveInit() when Hive fails to open.
    await Hive.deleteFromDisk();

    // Anything left in plain SharedPreferences: locale, legacy V1 wallet
    // (seed/pub/cesiumCards), one-shot migration flags, notification prefs.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
