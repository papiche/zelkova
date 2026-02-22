// -----------------------------------------------------------------------------
//  shared_prefs_helper.dart   (facade)
// -----------------------------------------------------------------------------
//  * Keeps the original public name `SharedPreferencesHelper` so no imports
//    across the project need to change.
//  * At runtime it delegates every call to either V1 (SharedPreferences) or
//    V2 (FlutterSecureStorage), depending on the flag set with `configure()`.
// -----------------------------------------------------------------------------

import 'dart:async';
import 'dart:math';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import 'data/models/legacy_wallet.dart';
import 'data/models/stored_account.dart';
import 'data/models/wallet_themes.dart';
import 'g1/g1_helper.dart';
import 'shared_prefs_helper_v1.dart' as v1;
import 'shared_prefs_helper_v2.dart' as v2;

abstract class SharedPreferencesHelperDelegate {
  static const String seedKey = 'seed';
  static const String pubKey = 'pub';

  Future<void> init();

  Future<CesiumWallet> getCesiumWallet();

  String getPubKey();

  String getName();

  WalletTheme getTheme();

  List<LegacyWallet> get cards;

  int getCurrentWalletIndex();

  Future<void> selectCurrentWalletIndex(int i);

  Future<void> selectCurrentWallet(String pubKey);

  void setName({required String name, bool notify});

  void setTheme({required WalletTheme theme});

  void addLegacyWallet(LegacyWallet c);

  void removeCurrentWallet();

  bool has(String pk);

  bool hasVolatilePass([StoredAccount? account]);

  void addCesiumVolatileCard(CesiumWallet w);

  Future<KeyPair> getKeyPair([int? index, StoredAccount? account]);

  Future<void> importWalletFromMnemonic(String m, AccountType type);

  Future<void> saveLegacyWallets([bool notify]);

  bool get hasMultipleWallets;

  bool get isEmpty;

  int get length;

  List<String> get publicKeys;

  /// This should replace cards
  List<StoredAccount> get accounts;

  StoredAccount getCurrentAccount();

  /// Used only in tests
  void accountsClear();

  bool isPasswordLessWallet([StoredAccount? other]);

  Future<StoredAccount> createDefWalletIfNotExist();

  Future<void> reEncryptAllProtectedAccounts({
    required Uint8List oldKey,
    required Uint8List newKey,
  });

  bool isLocked([StoredAccount? account]);

  Future<void> refreshWalletsInfo();

  void removeCesiumVolatileCard(CesiumWallet? wallet);

  bool isSecureStorageUnlocked();
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

  SharedPreferencesHelperDelegate get _d {
    _delegate ??= _useV2
        ? v2.SharedPreferencesHelperV2()
        : v1.SharedPreferencesHelperV1();
    return _delegate!;
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    v1.SharedPreferencesHelperV1().addListener(listener);
    v2.SharedPreferencesHelperV2().addListener(listener);
    /* if (_d is ChangeNotifier) {
      (_d as ChangeNotifier).addListener(listener);
    } */
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    v1.SharedPreferencesHelperV1().removeListener(listener);
    v2.SharedPreferencesHelperV2().removeListener(listener);
    /* if (_d is ChangeNotifier) {
      (_d as ChangeNotifier).removeListener(listener);
    } */
  }

  @override
  void dispose() {
    /* if (_d is ChangeNotifier) {
      (_d as ChangeNotifier).dispose();
    } */
    v1.SharedPreferencesHelperV1().dispose();
    v2.SharedPreferencesHelperV2().dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Internal delegation (lazy instantiation)
  // ──────────────────────────────────────────────────────────────────────────
  static SharedPreferencesHelperDelegate? _delegate;

  // ──────────────────────────────────────────────────────────────────────────
  // Public API
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> init({bool onlyV2 = false}) async {
    if (onlyV2) {
      // Used V2
      await v2.SharedPreferencesHelperV2().init();
    } else {
      await v1.SharedPreferencesHelperV1().init();
      await v2.SharedPreferencesHelperV2().init();
    }
  }

  Future<CesiumWallet> getCesiumWallet() => _d.getCesiumWallet();

  String getPubKey() => _d.getPubKey();

  String getName() => _d.getName();

  WalletTheme getTheme() => _d.getTheme();

  @Deprecated('Review its use')
  List<LegacyWallet> get cards => _d.cards;

  int getCurrentWalletIndex() => _d.getCurrentWalletIndex();

  Future<void> selectCurrentWalletIndex(int i) =>
      _d.selectCurrentWalletIndex(i);

  Future<void> selectCurrentWallet(String pubKey) =>
      _d.selectCurrentWallet(pubKey);

  void setName({required String name, bool notify = true}) =>
      _d.setName(name: name, notify: notify);

  void setTheme({required WalletTheme theme}) => _d.setTheme(theme: theme);

  void addLegacyWallet(LegacyWallet c) => _d.addLegacyWallet(c);

  void removeCurrentWallet() => _d.removeCurrentWallet();

  bool has(String pk) => _d.has(pk);

  bool hasVolatilePass([StoredAccount? account]) => _d.hasVolatilePass(account);

  void addCesiumVolatileCard(CesiumWallet w) => _d.addCesiumVolatileCard(w);

  void removeCesiumVolatileCard([CesiumWallet? w]) =>
      _d.removeCesiumVolatileCard(w);

  Future<KeyPair> getKeyPair([int? index, StoredAccount? account]) =>
      _d.getKeyPair(index, account);

  Future<void> importWalletFromMnemonic(String m, AccountType type) =>
      _d.importWalletFromMnemonic(m, type);

  /// Helper to create a v1 LegacyWallet, either password-less (with seed) or
  /// password-protected (with empty seed).
  LegacyWallet buildLegacyWallet(
      {required String seed, required String pubKey}) {
    return LegacyWallet(
      seed: seed,
      pubKey: pubKey,
      theme: SharedPreferencesHelper().randomTheme(),
      name: '',
    );
  }

  WalletTheme randomTheme() => WalletThemes.randomExcluding(availableThemes);

  List<WalletTheme> get availableThemes =>
      accounts.map((StoredAccount a) => a.theme).toList();

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
      _d.selectCurrentWallet(card.pubKey);
    }

    _d.addCesiumVolatileCard(wallet);
  }

  bool isPasswordLessWallet([StoredAccount? other]) =>
      _d.isPasswordLessWallet(other);

  bool get isEmpty => _d.isEmpty;

  bool get hasMultipleWallets => _d.hasMultipleWallets;

  int get length => _d.length;

  List<StoredAccount> get accounts => _d.accounts;

  void accountsClear() => _d.accountsClear();

  Uint8List? get passwordKey => v2.SharedPreferencesHelperV2().getPasswordKey();

  set passwordKey(Uint8List? key) =>
      v2.SharedPreferencesHelperV2().setPasswordKey(key);

  Future<void> saveLegacyWallets([bool notify = true]) {
    return _d.saveLegacyWallets(notify);
  }

  List<String> get publicKeys => _d.publicKeys;

  bool isLocked([StoredAccount? account]) => _d.isLocked(account);

  Future<StoredAccount> createDefWalletIfNotExist() =>
      _d.createDefWalletIfNotExist();

  StoredAccount getCurrentAccount() => _d.getCurrentAccount();

  Future<void> reEncryptAllProtectedAccounts({
    required Uint8List oldKey,
    required Uint8List newKey,
  }) =>
      _d.reEncryptAllProtectedAccounts(oldKey: oldKey, newKey: newKey);

  Future<void> refreshWalletsInfo() => _d.refreshWalletsInfo();

  bool isSecureStorageUnlocked() => _d.isSecureStorageUnlocked();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  bool isExternal(String pk) {
    return _d.has(pk) == false;
  }

  Future<void> deriveNextAccount(StoredAccount parent) =>
      v2.SharedPreferencesHelperV2().deriveNextAccount(parent);

  String? highlightedGroupId;
  bool isHighlightVisible = false;
  Timer? _highlightTimer;

  void highlightGroup(String? id) {
    _highlightTimer?.cancel();
    highlightedGroupId = id;
    isHighlightVisible = true;
    notifyListeners();

    int count = 0;
    _highlightTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      isHighlightVisible = !isHighlightVisible;
      notifyListeners();
      count++;
      if (count >= 8) {
        timer.cancel();
        highlightedGroupId = null;
        isHighlightVisible = false;
        notifyListeners();
      }
    });
  }
}
