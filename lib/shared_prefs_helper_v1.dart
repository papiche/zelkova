import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/legacy_wallet.dart';
import 'data/models/stored_account.dart';
import 'data/models/wallet_themes.dart';
import 'g1/g1_helper.dart';
import 'shared_prefs_helper.dart';
import 'storage_keys.dart';
import 'ui/logger.dart';

class SharedPreferencesHelperV1
    with ChangeNotifier
    implements SharedPreferencesHelperDelegate {
  factory SharedPreferencesHelperV1() {
    return _instance;
  }

  SharedPreferencesHelperV1._internal() {
    SharedPreferences.getInstance().then((SharedPreferences value) {
      _prefs = value;
    });
  }

  List<LegacyWallet> legacyWallets = <LegacyWallet>[];

  Map<String, CesiumWallet> cesiumVolatileCards = <String, CesiumWallet>{};

  static final SharedPreferencesHelperV1 _instance =
      SharedPreferencesHelperV1._internal();

  late SharedPreferences _prefs;

  static const String _seedKey = StorageKeys.seedKey;
  static const String _pubKey = StorageKeys.pubKey;
  static const String _cardsKey = StorageKeys.cardsKey;
  static const String _currentCardIndexKey = StorageKeys.currentCardIndexKey;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final String? json = _prefs.getString(_cardsKey);
    if (json != null) {
      final List<dynamic> list = jsonDecode(json) as List<dynamic>;
      legacyWallets = list
          .map((dynamic e) => LegacyWallet.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Migrate the current pair if exists
    await migrateCurrentPair();
  }

  Future<void> migrateCurrentPair() async {
    if (_prefs.containsKey(_seedKey) &&
        _prefs.containsKey(_pubKey) &&
        legacyWallets.isEmpty) {
      final String seed = _prefs.getString(_seedKey)!;
      final String pubKey = _prefs.getString(_pubKey)!;
      final LegacyWallet card = SharedPreferencesHelper()
          .buildLegacyWallet(seed: seed, pubKey: pubKey);
      addLegacyWallet(card);
      // Let's do this later
      await _prefs.remove(_seedKey);
      await _prefs.remove(_pubKey);
      _setCurrentWalletIndex(0);
    }
  }

  @override
  void addLegacyWallet(LegacyWallet cesiumCard) {
    legacyWallets.add(cesiumCard);
    saveLegacyWallets();
  }

  @override
  void removeCurrentWallet() {
    // Don't allow the last card to be removed
    final int index = getCurrentWalletIndex();
    logger('Removing card at index $index');
    if (legacyWallets.length > 1) {
      legacyWallets.removeAt(index);
      saveLegacyWallets();
    }
  }

  @override
  Future<void> saveLegacyWallets([bool notify = true]) async {
    final String json =
        jsonEncode(legacyWallets.map((LegacyWallet e) => e.toJson()).toList());
    await _prefs.setString(_cardsKey, json);
    if (notify) {
      notifyListeners();
    }
  }

  // Get the wallet from the specified index (default to first wallet)
  @override
  Future<CesiumWallet> getCesiumWallet() async {
    if (legacyWallets.isNotEmpty) {
      final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
      if (isPasswordLessWallet()) {
        return CesiumWallet.fromSeed(seedFromString(card.seed));
      } else {
        // This should have the wallet loaded
        return cesiumVolatileCards[extractPublicKey(card.pubKey)]!;
      }
    } else {
      // Generate a new wallet if no wallets exist
      final Uint8List uS = generateUintSeed();
      final String seed = seedToString(uS);
      final CesiumWallet wallet = CesiumWallet.fromSeed(uS);
      logger('Generated public key: ${wallet.pubkey}');
      addLegacyWallet(SharedPreferencesHelper()
          .buildLegacyWallet(seed: seed, pubKey: wallet.pubkey));
      return wallet;
    }
  }

  // Get the public key from the specified index (default to first wallet)
  @override
  String getPubKey() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(extractPublicKey(pubKey));
    return '$pubKey:$checksum';
  }

  @override
  String getName() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    return card.name;
  }

  @override
  WalletTheme getTheme() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    return card.theme;
  }

  @override
  void setName({required String name, bool notify = true}) {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    legacyWallets[getCurrentWalletIndex()] = card.copyWith(name: name);
    saveLegacyWallets(notify);
  }

  @override
  void setTheme({required WalletTheme theme}) {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    legacyWallets[getCurrentWalletIndex()] = card.copyWith(theme: theme);
    saveLegacyWallets();
  }

  @override
  List<LegacyWallet> get cards => legacyWallets;

  // Get the current wallet index from shared preferences
  @override
  int getCurrentWalletIndex() {
    return _prefs.getInt(_currentCardIndexKey) ?? 0;
  }

  Future<void> _setCurrentWalletIndex(int index) async {
    await _prefs.setInt(_currentCardIndexKey, index);
    notifyListeners();
  }

  @override
  Future<void> selectCurrentWallet(String pubKey) async {
    // Find the wallet with the given public key
    final String extractedPubKey = extractPublicKey(pubKey);
    final int index =
        cards.indexWhere((LegacyWallet a) => a.pubKey == extractedPubKey);
    if (index >= 0) {
      await _setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  // Select the current wallet and save its index in shared preferences
  @override
  Future<void> selectCurrentWalletIndex(int index) async {
    if (index < legacyWallets.length) {
      await _setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  @override
  bool has(String pubKey) {
    for (final LegacyWallet card in legacyWallets) {
      if (card.pubKey == extractPublicKey(pubKey) || card.pubKey == pubKey) {
        return true;
      }
    }
    return false;
  }

  @override
  bool hasVolatilePass([StoredAccount? account]) {
    if (account != null) {
      final String pubKey = extractPublicKey(account.pubKey);
      return cesiumVolatileCards.containsKey(pubKey);
    }
    return cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));
  }

  @override
  void addCesiumVolatileCard(CesiumWallet cesiumWallet) {
    cesiumVolatileCards[cesiumWallet.pubkey] = cesiumWallet;
  }

  // Although this should not be used in V1, we implement it for consistency
  @override
  Future<KeyPair> getKeyPair() async {
    final CesiumWallet walletV1 = await getCesiumWallet();
    final KeyPair kp = KeyPair.ed25519.fromSeed(walletV1.seed);
    kp.ss58Format = 4450;
    return kp;
  }

  @override
  Future<void> importWalletFromMnemonic(String m, AccountType type) async {
    throw UnimplementedError(
        'importWalletFromMnemonic is not implemented in SharedPreferencesHelperV1');
  }

  @override
  void accountsClear() {
    cards.clear();
  }

  @override
  bool get hasMultipleWallets => cards.length > 1;

  @override
  bool get isEmpty => cards.isEmpty;

  @override
  int get length => cards.length;

  @override
  List<String> get publicKeys =>
      cards.map((LegacyWallet e) => e.pubKey).toList();

  @override
  List<StoredAccount> get accounts {
    return cards.map((LegacyWallet e) => StoredAccount.fromLegacy(e)).toList();
  }

  @override
  bool isPasswordLessWallet([StoredAccount? other]) {
    final String pubKey =
        extractPublicKey(other != null ? other.pubKey : getPubKey());
    final LegacyWallet w =
        cards.where((LegacyWallet c) => c.pubKey == pubKey).first;
    return w.seed.isNotEmpty;
  }

  @override
  Future<StoredAccount> createDefWalletIfNotExist() async {
    await getCesiumWallet();
    return StoredAccount.fromLegacy(
      legacyWallets[getCurrentWalletIndex()],
    );
  }

  @override
  StoredAccount getCurrentAccount() {
    return accounts[getCurrentWalletIndex()];
  }

  @override
  Future<void> reEncryptAllProtectedAccounts(
      {required Uint8List oldKey, required Uint8List newKey}) {
    throw UnimplementedError('This should only work in V2');
  }

  @override
  bool isLocked([StoredAccount? account]) {
    if (isPasswordLessWallet(account)) {
      return false;
    } else
      return !hasVolatilePass(account);
  }

  @override
  Future<void> refreshWalletsInfo() {
    // Not implemented in V1
    return Future<void>.value();
  }

  @override
  Future<void> removeCesiumVolatileCard([CesiumWallet? wallet]) async {
    if (wallet != null) {
      cesiumVolatileCards.remove(extractPublicKey(wallet.pubkey));
    } else {
      final CesiumWallet w = await getCesiumWallet();
      cesiumVolatileCards.removeWhere((String key, CesiumWallet value) {
        return key == extractPublicKey(w.pubkey);
      });
    }
  }
}
