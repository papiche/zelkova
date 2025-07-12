// -----------------------------------------------------------------------------
//  shared_prefs_helper.dart   (facade)
// -----------------------------------------------------------------------------
//  * Keeps the original public name `SharedPreferencesHelper` so no imports
//    across the project need to change.
//  * At runtime it delegates every call to either V1 (SharedPreferences) or
//    V2 (FlutterSecureStorage), depending on the flag set with `configure()`.
// -----------------------------------------------------------------------------

import 'dart:math';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../data/models/legacy_wallet.dart';
import '../data/models/wallet_themes.dart';
import 'g1/g1_helper.dart';
import 'shared_prefs_helper_v1.dart' as v1;
import 'shared_prefs_helper_v2.dart' as v2;

abstract class SharedPreferencesHelperDelegate {
  static const String seedKey = 'seed';
  static const String pubKey = 'pub';

  Future<void> init();

  Future<CesiumWallet> getWallet();

  String getPubKey();

  String getName();

  WalletTheme getTheme();

  List<LegacyWallet> get cards;

  int getCurrentWalletIndex();

  Future<void> setCurrentWalletIndex(int i);

  Future<void> selectCurrentWalletIndex(int i);

  Future<void> selectCurrentWallet(LegacyWallet c);

  void setName({required String name, bool notify});

  void setTheme({required WalletTheme theme});

  void addLegacyWallet(LegacyWallet c);

  void removeCurrentWallet();

  bool has(String pk);

  bool hasVolatilePass();

  void addCesiumVolatileCard(CesiumWallet w);

  Future<KeyPair> getKeyPair();

  Future<void> importWalletFromMnemonic(String m);

  Future<void> saveLegacyWallets([bool notify]);
}

class SharedPreferencesHelper with ChangeNotifier {
  factory SharedPreferencesHelper() => _instance;

  SharedPreferencesHelper._internal();

  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  // ──────────────────────────────────────────────────────────────────────────
  // Configuration: Call once at startup to select V2 (secure storage)
  // ──────────────────────────────────────────────────────────────────────────
  static bool _useV2 = false;

  static void configure({required bool useV2}) {
    if (_useV2 != useV2) {
      _useV2 = useV2;
      _delegate = null;
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Internal delegation (lazy instantiation)
  // ──────────────────────────────────────────────────────────────────────────
  static SharedPreferencesHelperDelegate? _delegate;

  SharedPreferencesHelperDelegate get _d {
    _delegate ??= _useV2
        ? v2.SharedPreferencesHelperV2()
        : v1.SharedPreferencesHelperV1();
    return _delegate!;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Public API
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> init() async {
    await v1.SharedPreferencesHelperV1().init();
    await v2.SharedPreferencesHelperV2().init();
  }

  Future<CesiumWallet> getLegacyWallet() => _d.getWallet();

  String getPubKey() => _d.getPubKey();

  String getName() => _d.getName();

  WalletTheme getTheme() => _d.getTheme();

  List<LegacyWallet> get cards => _d.cards;

  int getCurrentWalletIndex() => _d.getCurrentWalletIndex();

  Future<void> setCurrentWalletIndex(int i) => _d.setCurrentWalletIndex(i);

  Future<void> selectCurrentWalletIndex(int i) =>
      _d.selectCurrentWalletIndex(i);

  Future<void> selectCurrentWallet(LegacyWallet c) => _d.selectCurrentWallet(c);

  void setName({required String name, bool notify = true}) =>
      _d.setName(name: name, notify: notify);

  void setTheme({required WalletTheme theme}) => _d.setTheme(theme: theme);

  void addLegacyWallet(LegacyWallet c) => _d.addLegacyWallet(c);

  void removeCurrentWallet() => _d.removeCurrentWallet();

  bool has(String pk) => _d.has(pk);

  bool hasVolatilePass() => _d.hasVolatilePass();

  void addCesiumVolatileCard(CesiumWallet w) => _d.addCesiumVolatileCard(w);

  Future<KeyPair> getKeyPair() => _d.getKeyPair();

  Future<void> importWalletFromMnemonic(String m) =>
      _d.importWalletFromMnemonic(m);

  LegacyWallet buildLegacyWallet(
      {required String seed, required String pubKey}) {
    return LegacyWallet(
      seed: seed,
      pubKey: pubKey,
      theme: WalletThemes.theme1,
      name: '',
    );
  }

  void handleCorrectCesiumV1Auth(
      {required String publicKey,
      required String? name,
      required CesiumWallet wallet}) {
    final LegacyWallet card = LegacyWallet(
      name: name ?? '',
      pubKey: extractPublicKey(publicKey),
      // Don't store the seed in the card (that is a volatile card, only persisted in memory during the session)
      seed: '',
      theme: WalletThemes.themes[Random().nextInt(10)],
    );

    if (!has(extractPublicKey(publicKey))) {
      _d.addLegacyWallet(card);
      _d.selectCurrentWallet(card);
    }

    _d.addCesiumVolatileCard(wallet);
  }

  bool isPasswordLessWallet([LegacyWallet? other]) {
    final LegacyWallet w = other ?? cards[getCurrentWalletIndex()];
    return w.seed.isNotEmpty;
  }

  bool hasMultipleWallets() {
    return cards.length > 1;
  }
}
