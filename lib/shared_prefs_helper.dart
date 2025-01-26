import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/wallet.dart';
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
      _migrateToSecureStorage();
    });
  }

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Memory cache
  List<Wallet> wallets = <Wallet>[];
  Map<String, CesiumWallet> cesiumVolatileCards = <String, CesiumWallet>{};
  late SharedPreferences _prefs;
  int _currentWalletIndex = 0;

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
      wallets = list
          .map((dynamic e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // load current index
    final String? indexStr =
        await _secureStorage.read(key: _currentAccountIndex);
    if (indexStr != null) {
      _currentWalletIndex = int.parse(indexStr);
    }
  }

  Future<void> _migrateToSecureStorage() async {
    final bool isMigrated = await _secureStorage.containsKey(key: _accountsKey);

    if (!isMigrated) {
      try {
        final List<Wallet> walletsToMigrate = <Wallet>[];

        // Migrate legacy accounts based on seed and pub key
        final String? seed = _prefs.getString(_seedKey);
        final String? pubKey = _prefs.getString(_pubKey);
        if (seed != null && pubKey != null) {
          final Wallet wallet = buildCesiumCard(seed: seed, pubKey: pubKey);
          walletsToMigrate.add(wallet);
        }

        // Migrate legacy accounts (array)
        final String? json = _prefs.getString(_legacyAccountsKey);
        if (json != null) {
          final List<dynamic> list = jsonDecode(json) as List<dynamic>;
          final List<Wallet> legacyWallets = list
              .map((dynamic e) => Wallet.fromJson(e as Map<String, dynamic>))
              .toList();
          walletsToMigrate.addAll(legacyWallets);
        }

        // Migration current index
        final int? legacyIndex = _prefs.getInt(_legacyCurrentAccountIndex);
        if (legacyIndex != null) {
          _currentWalletIndex = legacyIndex;
        } else {
          _currentWalletIndex = 0; // Default to the first wallet
        }

        // Save wallets in memory and secure storage
        wallets = walletsToMigrate;
        await saveWallets();

        // Save current index
        await _secureStorage.write(
            key: _currentAccountIndex, value: _currentWalletIndex.toString());

        // Remove legacy data only if migration succeeded
        await _prefs.remove(_seedKey);
        await _prefs.remove(_pubKey);
        await _prefs.remove(_legacyAccountsKey);
        await _prefs.remove(_legacyCurrentAccountIndex);

        logger('Migration completed successfully');
      } catch (e) {
        logger('Migration failed: $e');
      }
    }
  }

  Wallet buildCesiumCard({required String seed, required String pubKey}) {
    return Wallet(
        seed: seed, pubKey: pubKey, theme: WalletThemes.theme1, name: '');
  }

  void addWallet(Wallet cesiumCard) {
    wallets.add(cesiumCard);
    saveWallets();
  }

  void removeWallet() {
    // Don't allow the last card to be removed
    final int index = getCurrentWalletIndex();
    logger('Removing card at index $index');
    if (wallets.length > 1) {
      wallets.removeAt(index);
      saveWallets();
    }
  }

  Future<void> saveWallets([bool notify = true]) async {
    final String json =
        jsonEncode(wallets.map((Wallet e) => e.toJson()).toList());
    await _secureStorage.write(key: _accountsKey, value: json);
    if (notify) {
      notifyListeners();
    }
  }

  // Get the wallet from the specified index (default to first wallet)
  Future<CesiumWallet> getWallet() async {
    if (wallets.isNotEmpty) {
      final Wallet card = wallets[getCurrentWalletIndex()];
      if (isPasswordLessWallet()) {
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
      addWallet(buildCesiumCard(seed: seed, pubKey: wallet.pubkey));
      return wallet;
    }
  }

  // Get the public key from the specified index (default to first wallet)
  String getPubKey() {
    final Wallet card = wallets[getCurrentWalletIndex()];
    final String pubKey = card.pubKey;
    final String checksum = pkChecksum(extractPublicKey(pubKey));
    return '$pubKey:$checksum';
  }

  String getName() {
    final Wallet card = wallets[getCurrentWalletIndex()];
    return card.name;
  }

  WalletTheme getTheme() {
    final Wallet card = wallets[getCurrentWalletIndex()];
    return card.theme;
  }

  void setName({required String name, bool notify = true}) {
    final Wallet card = wallets[getCurrentWalletIndex()];
    wallets[getCurrentWalletIndex()] = card.copyWith(name: name);
    saveWallets(notify);
  }

  void setTheme({required WalletTheme theme}) {
    final Wallet card = wallets[getCurrentWalletIndex()];
    wallets[getCurrentWalletIndex()] = card.copyWith(theme: theme);
    saveWallets();
  }

  int getCurrentWalletIndex() => _currentWalletIndex;

  Future<void> setCurrentWalletIndex(int index) async {
    _currentWalletIndex = index;
    await _secureStorage.write(
        key: _currentAccountIndex, value: index.toString());
    notifyListeners();
  }

  Future<void> selectCurrentWallet(Wallet wallet) async {
    // TODO(vjrj): this should be a find with pubkey
    final int index = wallets.indexOf(wallet);
    if (index >= 0) {
      await _prefs.setInt(_legacyCurrentAccountIndex, index);
      notifyListeners();
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  // Select the current wallet and save its index in shared preferences
  Future<void> selectCurrentWalletIndex(int index) async {
    if (index < wallets.length) {
      await setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  bool has(String pubKey) {
    for (final Wallet card in wallets) {
      if (card.pubKey == extractPublicKey(pubKey) || card.pubKey == pubKey) {
        return true;
      }
    }
    return false;
  }

  bool hasVolatile() {
    return cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));
  }

  bool hasMultipleWallets() {
    return wallets.length > 1;
  }

  void addCesiumVolatileCard(CesiumWallet cesiumWallet) {
    cesiumVolatileCards[cesiumWallet.pubkey] = cesiumWallet;
  }

  bool isPasswordLessWallet([Wallet? otherCard]) {
    final Wallet card = otherCard ?? wallets[getCurrentWalletIndex()];
    return card.seed.isNotEmpty;
  }

  Future<KeyPair> getKeyPair() async {
    final CesiumWallet walletV1 = await getWallet();
    final KeyPair kp = KeyPair.ed25519.fromSeed(walletV1.seed);
    return kp;
  }
}
