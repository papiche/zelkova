import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'g1/keys_helper.dart';
import 'main.dart';

class SharedPreferencesHelper {
  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal() {
    SharedPreferences.getInstance().then((SharedPreferences value) {
      _prefs = value;
    });
  }

  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  late SharedPreferences _prefs;

  static const String _seedKey = 'seed';
  static const String _pubKey = 'pub';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

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
    final String? pubkey = _prefs.getString(_pubKey);
    logger('Public key $pubkey!');
    return pubkey!;
  }

  String? _getString(String key) {
    return _prefs.getString(key);
  }
}
