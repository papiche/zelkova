import 'dart:convert';
import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/cesium_card.dart';
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
  }

  void addCesiumCard(CesiumCard cesiumCard) {
    cesiumCards.add(cesiumCard);
    saveCesiumCards();
  }

  void removeCesiumCard(int index) {
    cesiumCards.removeAt(index);
    saveCesiumCards();
  }

  Future<void> saveCesiumCards() async {
    final String json =
        jsonEncode(cesiumCards.map((CesiumCard e) => e.toJson()).toList());
    await _prefs.setString('cesiumCards', json);
  }

/* WIP part */

// I'll only use shared prefs for the duniter seed
  Future<void> _saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<CesiumWallet> getWallet() async {
    String? s = _getString(_seedKey);
    if (s == null) {
      final Uint8List uS = generateUintSeed();
      s = seedToString(uS);
      await _saveString(_seedKey, s);
      final CesiumWallet wallet = CesiumWallet.fromSeed(uS);
      logger('Generated public key: ${wallet.pubkey}');
      await _saveString(_pubKey, wallet.pubkey);
      return wallet;
    } else {
      return CesiumWallet.fromSeed(seedFromString(s));
    }
  }

  String getPubKey() {
    // At this point should exists
    final String? pubKey = _prefs.getString(_pubKey);
    logger('Public key: $pubKey');
    return pubKey!;
  }

  String? _getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setKeys(String pubKey, String seed) async {
    await _saveString(_seedKey, seed);
    await _saveString(_pubKey, pubKey);
  }
}
