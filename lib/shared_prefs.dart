import 'dart:convert';
import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/cesium_card.dart';
import 'data/models/credit_card_themes.dart';
import 'g1/g1_helper.dart';
import 'ui/logger.dart';

class SharedPreferencesHelper {
  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal() {
    SharedPreferences.getInstance().then((SharedPreferences value) {
      _prefs = value;
    });
  }

  List<CesiumCard> cesiumCards = <CesiumCard>[];

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
      // await _prefs.remove(_seedKey);
      // await _prefs.remove(_pubKey);
      setCurrentWalletIndex(0);
    }
  }

  CesiumCard buildCesiumCard({required String seed, required String pubKey}) {
    return CesiumCard(
        seed: seed,
        pubKey: pubKey,
        theme: CreditCardThemes.theme1,
        name: dotenv.env['CARD_TEXT'] ?? tr('g1_wallet'));
  }

  void addCesiumCard(CesiumCard cesiumCard) {
    cesiumCards.add(cesiumCard);
    saveCesiumCards();
  }

  void removeCesiumCard(int index) {
    // Don't allow the last card to be removed
    if (cesiumCards.length > 1) {
      cesiumCards.removeAt(index);
      saveCesiumCards();
    }
  }

  Future<void> saveCesiumCards() async {
    final String json =
        jsonEncode(cesiumCards.map((CesiumCard e) => e.toJson()).toList());
    await _prefs.setString('cesiumCards', json);
  }

  // Get the wallet from the specified index (default to first wallet)
  Future<CesiumWallet> getWallet({int index = 0}) async {
    if (cesiumCards.isNotEmpty && index < cesiumCards.length) {
      final CesiumCard card = cesiumCards[index];
      return CesiumWallet.fromSeed(seedFromString(card.seed));
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
  String getPubKey({int index = 0}) {
    final CesiumCard card = cesiumCards[index];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(pubKey);
    return '$pubKey:$checksum';
  }

  String getName({int index = 0}) {
    final CesiumCard card = cesiumCards[index];
    return card.name;
  }

  void setName({int index = 0, required String name}) {
    final CesiumCard card = cesiumCards[index];
    cesiumCards[index] = card.copyWith(name: name);
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
  }

  // Select the current wallet and save its index in shared preferences
  Future<void> selectCurrentWallet(int index) async {
    if (index < cesiumCards.length) {
      final CesiumCard card = cesiumCards[index];
      await setCurrentWalletIndex(index);
      logger('Selected wallet: ${card.pubKey}');
    } else {
      logger('Invalid wallet index: $index');
    }
  }

  // Get the currently selected wallet
  Future<CesiumWallet> getCurrentWallet() async {
    final int index = getCurrentWalletIndex();
    return getWallet(index: index);
  }

  @Deprecated('We should remove this in the future when multi-card is enabled')
  void setDefaultWallet(CesiumCard defCesiumCard) {
    cesiumCards[0] = defCesiumCard;
    saveCesiumCards();
  }
}
