import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/cesium_card.dart';
import 'data/models/credit_card_themes.dart';
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

  List<CesiumCard> cesiumCards = <CesiumCard>[];

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
      cesiumCards = list
          .map((dynamic e) => CesiumCard.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Migrate the current pair if exists
    await migrateCurrentPair();
  }

  Future<void> migrateCurrentPair() async {
    if (_prefs.containsKey(_seedKey) &&
        _prefs.containsKey(_pubKey) &&
        cesiumCards.isEmpty) {
      final String seed = _prefs.getString(_seedKey)!;
      final String pubKey = _prefs.getString(_pubKey)!;
      final CesiumCard card = buildCesiumCard(seed: seed, pubKey: pubKey);
      addCesiumCard(card);
      // Let's do this later
      await _prefs.remove(_seedKey);
      await _prefs.remove(_pubKey);
      setCurrentWalletIndex(0);
    }
  }

  CesiumCard buildCesiumCard({required String seed, required String pubKey}) {
    return CesiumCard(
        seed: seed, pubKey: pubKey, theme: CreditCardThemes.theme1, name: '');
  }

  void addCesiumCard(CesiumCard cesiumCard) {
    cesiumCards.add(cesiumCard);
    saveCesiumCards();
  }

  void removeCesiumCard() {
    // Don't allow the last card to be removed
    final int index = getCurrentWalletIndex();
    logger('Removing card at index $index');
    if (cesiumCards.length > 1) {
      cesiumCards.removeAt(index);
      saveCesiumCards();
    }
  }

  Future<void> saveCesiumCards([bool notify = true]) async {
    final String json =
        jsonEncode(cesiumCards.map((CesiumCard e) => e.toJson()).toList());
    await _prefs.setString('cesiumCards', json);
    if (notify) {
      notifyListeners();
    }
  }

  // Get the wallet from the specified index (default to first wallet)
  Future<CesiumWallet> getWallet() async {
    if (cesiumCards.isNotEmpty) {
      final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
      if (isG1nkgoCard()) {
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
      addCesiumCard(buildCesiumCard(seed: seed, pubKey: wallet.pubkey));
      return wallet;
    }
  }

  // Get the public key from the specified index (default to first wallet)
  String getPubKey() {
    final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(extractPublicKey(pubKey));
    return '$pubKey:$checksum';
  }

  String getName() {
    final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
    return card.name;
  }

  CreditCardTheme getTheme() {
    final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
    return card.theme;
  }

  void setName({required String name, bool notify = true}) {
    final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
    cesiumCards[getCurrentWalletIndex()] = card.copyWith(name: name);
    saveCesiumCards(notify);
  }

  void setTheme({required CreditCardTheme theme}) {
    final CesiumCard card = cesiumCards[getCurrentWalletIndex()];
    cesiumCards[getCurrentWalletIndex()] = card.copyWith(theme: theme);
    saveCesiumCards();
  }

  List<CesiumCard> get cards => cesiumCards;

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

  Future<void> selectCurrentWallet(CesiumCard card) async {
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
    if (index < cesiumCards.length) {
      await setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  bool has(String pubKey) {
    for (final CesiumCard card in cesiumCards) {
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

  bool isG1nkgoCard([CesiumCard? otherCard]) {
    final CesiumCard card = otherCard ?? cesiumCards[getCurrentWalletIndex()];
    return card.seed.isNotEmpty;
  }
}
