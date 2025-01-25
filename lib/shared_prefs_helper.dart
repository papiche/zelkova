import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
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
      _migrateToSecureStorage();
    });
  }

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  List<AccountCard> cesiumCards = <AccountCard>[];
  Map<String, CesiumWallet> cesiumVolatileCards = <String, CesiumWallet>{};
  late SharedPreferences _prefs;

  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  // Legacy keys
  static const String _seedKey = 'seed';
  static const String _pubKey = 'pub';
  static const String _legacyAccountsKey = 'cesiumCards';
  static const String _legacyCurrentAccountIndex = 'current_wallet_index';

  // new keys
  static const String _accountsKey = 'duniter_accounts';
  static const String _currentAccountIndex = 'current_account_index';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _migrateToSecureStorage();

    // Load data from secure storage
    final String? json = await _secureStorage.read(key: _accountsKey);
    if (json != null) {
      final List<dynamic> list = jsonDecode(json) as List<dynamic>;
      cesiumCards = list
          .map((dynamic e) => AccountCard.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _migrateToSecureStorage() async {
    // Check if data is already in secure storage
    final bool isMigrated = await _secureStorage.containsKey(key: _accountsKey);

    if (!isMigrated) {
      // Migrate cesiumCards
      final String? json = _prefs.getString(_legacyAccountsKey);
      if (json != null) {
        await _secureStorage.write(key: _accountsKey, value: json);
      }

      // Migrate current wallet index
      final int? currentWalletIndex = _prefs.getInt(_legacyCurrentAccountIndex);
      if (currentWalletIndex != null) {
        await _secureStorage.write(
            key: _currentAccountIndex, value: currentWalletIndex.toString());
      }

      // Remove sensitive data from SharedPreferences
      await _prefs.remove(_legacyAccountsKey);
      await _prefs.remove(_legacyCurrentAccountIndex);
    }
  }

  Future<void> migrateCurrentPair() async {
    if (_prefs.containsKey(_seedKey) &&
        _prefs.containsKey(_pubKey) &&
        cesiumCards.isEmpty) {
      final String seed = _prefs.getString(_seedKey)!;
      final String pubKey = _prefs.getString(_pubKey)!;
      final AccountCard card = buildCesiumCard(seed: seed, pubKey: pubKey);
      addCesiumCard(card);
      // Let's do this later
      await _prefs.remove(_seedKey);
      await _prefs.remove(_pubKey);
      setCurrentWalletIndex(0);
    }
  }

  AccountCard buildCesiumCard({required String seed, required String pubKey}) {
    return AccountCard(
        seed: seed, pubKey: pubKey, theme: CreditCardThemes.theme1, name: '');
  }

  void addCesiumCard(AccountCard cesiumCard) {
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
        jsonEncode(cesiumCards.map((AccountCard e) => e.toJson()).toList());
    await _secureStorage.write(key: _accountsKey, value: json);
    if (notify) {
      notifyListeners();
    }
  }

  // Get the wallet from the specified index (default to first wallet)
  Future<CesiumWallet> getWallet() async {
    if (cesiumCards.isNotEmpty) {
      final AccountCard card = cesiumCards[getCurrentWalletIndex()];
      if (isG1nkgoCard()) {
        return CesiumWallet.fromSeed(seedFromString(card.seed));
      } else {
        // This should have the wallet loaded
        final CesiumWallet? volatileWallet =
            cesiumVolatileCards[extractPublicKey(card.pubKey)];
        if (volatileWallet != null) {
          return volatileWallet;
        }
        throw Exception('Volatile wallet not found (need to authenticate)');
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
    final AccountCard card = cesiumCards[getCurrentWalletIndex()];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(extractPublicKey(pubKey));
    return '$pubKey:$checksum';
  }

  String getName() {
    final AccountCard card = cesiumCards[getCurrentWalletIndex()];
    return card.name;
  }

  AccountCardTheme getTheme() {
    final AccountCard card = cesiumCards[getCurrentWalletIndex()];
    return card.theme;
  }

  void setName({required String name, bool notify = true}) {
    final AccountCard card = cesiumCards[getCurrentWalletIndex()];
    cesiumCards[getCurrentWalletIndex()] = card.copyWith(name: name);
    saveCesiumCards(notify);
  }

  void setTheme({required AccountCardTheme theme}) {
    final AccountCard card = cesiumCards[getCurrentWalletIndex()];
    cesiumCards[getCurrentWalletIndex()] = card.copyWith(theme: theme);
    saveCesiumCards();
  }

  List<AccountCard> get cards => cesiumCards;

  int getCurrentWalletIndex() {
    final String? indexStr =
        _secureStorage.read(key: _currentAccountIndex) as String?;
    return indexStr != null ? int.parse(indexStr) : 0;
  }

  Future<void> setCurrentWalletIndex(int index) async {
    await _secureStorage.write(
        key: _currentAccountIndex, value: index.toString());
    notifyListeners();
  }

  Future<void> selectCurrentWallet(AccountCard card) async {
    // TODO(vjrj): this should be a find with pubkey
    final int index = cards.indexOf(card);
    if (index >= 0) {
      await _prefs.setInt(_legacyCurrentAccountIndex, index);
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
    for (final AccountCard card in cesiumCards) {
      if (card.pubKey == extractPublicKey(pubKey) || card.pubKey == pubKey) {
        return true;
      }
    }
    return false;
  }

  bool hasVolatile() {
    return cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));
  }

  bool hasMultipleCards() {
    return cesiumCards.length > 1;
  }

  void addCesiumVolatileCard(CesiumWallet cesiumWallet) {
    cesiumVolatileCards[cesiumWallet.pubkey] = cesiumWallet;
  }

  bool isG1nkgoCard([AccountCard? otherCard]) {
    final AccountCard card = otherCard ?? cesiumCards[getCurrentWalletIndex()];
    return card.seed.isNotEmpty;
  }

  Future<KeyPair> getKeyPair() async {
    final CesiumWallet walletV1 = await getWallet();
    final KeyPair kp = KeyPair.ed25519.fromSeed(walletV1.seed);
    return kp;
  }
}
