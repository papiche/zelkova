import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/legacy_wallet.dart';
import 'data/models/wallet_themes.dart';
import 'g1/g1_helper.dart';
import 'ui/logger.dart';

class SharedPreferencesHelper with ChangeNotifier {
  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal() {
    SharedPreferences.getInstance().then((SharedPreferences value) {
      _prefs = value;
    });
  }

  List<LegacyWallet> legacyWallets = <LegacyWallet>[];

  Map<String, CesiumWallet> cesiumVolatileCards = <String, CesiumWallet>{};

  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  late SharedPreferences _prefs;

  static const String _seedKey = 'seed';
  static const String _pubKey = 'pub';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final String? json = _prefs.getString('cesiumCards');
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
      final LegacyWallet card = buildLegacyWallet(seed: seed, pubKey: pubKey);
      addLegacyWallet(card);
      // Let's do this later
      await _prefs.remove(_seedKey);
      await _prefs.remove(_pubKey);
      setCurrentWalletIndex(0);
    }
  }

  LegacyWallet buildLegacyWallet(
      {required String seed, required String pubKey}) {
    return LegacyWallet(
        seed: seed, pubKey: pubKey, theme: WalletThemes.theme1, name: '');
  }

  void addLegacyWallet(LegacyWallet cesiumCard) {
    legacyWallets.add(cesiumCard);
    saveLegacyWallets();
  }

  void removeLegacyWallet() {
    // Don't allow the last card to be removed
    final int index = getCurrentWalletIndex();
    logger('Removing card at index $index');
    if (legacyWallets.length > 1) {
      legacyWallets.removeAt(index);
      saveLegacyWallets();
    }
  }

  Future<void> saveLegacyWallets([bool notify = true]) async {
    final String json =
        jsonEncode(legacyWallets.map((LegacyWallet e) => e.toJson()).toList());
    await _prefs.setString('cesiumCards', json);
    if (notify) {
      notifyListeners();
    }
  }

  // Get the wallet from the specified index (default to first wallet)
  Future<CesiumWallet> getWallet() async {
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
      addLegacyWallet(buildLegacyWallet(seed: seed, pubKey: wallet.pubkey));
      return wallet;
    }
  }

  // Get the public key from the specified index (default to first wallet)
  String getPubKey() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(extractPublicKey(pubKey));
    return '$pubKey:$checksum';
  }

  String getName() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    return card.name;
  }

  WalletTheme getTheme() {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    return card.theme;
  }

  void setName({required String name, bool notify = true}) {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    legacyWallets[getCurrentWalletIndex()] = card.copyWith(name: name);
    saveLegacyWallets(notify);
  }

  void setTheme({required WalletTheme theme}) {
    final LegacyWallet card = legacyWallets[getCurrentWalletIndex()];
    legacyWallets[getCurrentWalletIndex()] = card.copyWith(theme: theme);
    saveLegacyWallets();
  }

  List<LegacyWallet> get cards => legacyWallets;

  static const String _currentWalletIndexKey = 'current_wallet_index';

  // Get the current wallet index from shared preferences
  int getCurrentWalletIndex() {
    return _prefs.getInt(_currentWalletIndexKey) ?? 0;
  }

  // Set the current wallet index in shared preferences
  Future<void> setCurrentWalletIndex(int index) async {
    await _prefs.setInt(_currentWalletIndexKey, index);
    notifyListeners();
  }

  Future<void> selectCurrentWallet(LegacyWallet card) async {
    // TODO(vjrj): this should be a find with pubkey
    final int index = cards.indexOf(card);
    if (index >= 0) {
      await _prefs.setInt(_currentWalletIndexKey, index);
      notifyListeners();
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  // Select the current wallet and save its index in shared preferences
  Future<void> selectCurrentWalletIndex(int index) async {
    if (index < legacyWallets.length) {
      await setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  bool has(String pubKey) {
    for (final LegacyWallet card in legacyWallets) {
      if (card.pubKey == extractPublicKey(pubKey) || card.pubKey == pubKey) {
        return true;
      }
    }
    return false;
  }

  bool hasVolatile() {
    return cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));
  }

  void addCesiumVolatileCard(CesiumWallet cesiumWallet) {
    cesiumVolatileCards[cesiumWallet.pubkey] = cesiumWallet;
  }

  Future<KeyPair> getKeyPair() async {
    final CesiumWallet walletV1 = await getWallet();
    final KeyPair kp = KeyPair.ed25519.fromSeed(walletV1.seed);
    return kp;
  }

  bool isPasswordLessWallet([LegacyWallet? otherCard]) {
    final LegacyWallet wallet =
        otherCard ?? legacyWallets[getCurrentWalletIndex()];
    return wallet.seed.isNotEmpty;
  }

  bool hasMultipleWallets() {
    return legacyWallets.length > 1;
  }
}
