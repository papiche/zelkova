import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/contact.dart';
import '../data/models/legacy_wallet.dart';
import '../data/models/stored_account.dart';
import '../data/models/wallet_themes.dart';
import '../g1/g1_helper.dart';
import 'g1/g1_v2_helper.dart';
import 'secure_crypto_helper.dart';
import 'shared_prefs_helper.dart';
import 'storage_keys.dart';
import 'ui/logger.dart';
import 'ui/secure_unlock_widget.dart';

class SharedPreferencesHelperV2
    with ChangeNotifier
    implements SharedPreferencesHelperDelegate {
  factory SharedPreferencesHelperV2() => _instance;

  SharedPreferencesHelperV2._internal();

  static final SharedPreferencesHelperV2 _instance =
      SharedPreferencesHelperV2._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late SharedPreferences _prefs;

  final List<StoredAccount> accounts = <StoredAccount>[];
  final Map<String, CesiumWallet> _cesiumVolatileCards =
      <String, CesiumWallet>{};

  int _currentIndex = 0;
  Uint8List? passwordKey;
  Uint8List? _salt;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadPasswordKey();
    await _migrateBetaAccount();
    await _loadAccounts();
    await _loadCurrentIndex();
  }

  Future<void> _loadPasswordKey() async {
    final String? saltBase64 = await _storage.read(key: StorageKeys.secureSalt);
    final String? keyBase64 =
        await _storage.read(key: StorageKeys.securePatternOrPass);

    if (saltBase64 != null) {
      _salt = base64Decode(saltBase64);
    }
    if (keyBase64 != null) {
      passwordKey = base64Decode(keyBase64);
    }
  }

  Future<void> _migrateBetaAccount() async {
    if (_prefs.containsKey(StorageKeys.seedKey) &&
        _prefs.containsKey(StorageKeys.pubKey)) {
      final String seed = _prefs.getString(StorageKeys.seedKey)!;
      final String pubKey = _prefs.getString(StorageKeys.pubKey)!;

      accounts.add(StoredAccount(
        pubKey: pubKey,
        type: AccountType.v1PasswordLess,
        seed: seedFromString(seed),
        contact: Contact.withPubKey(pubKey: pubKey, name: 'Migrated'),
        theme: WalletThemes.theme1,
      ));
      await _prefs.remove(StorageKeys.seedKey);
      await _prefs.remove(StorageKeys.pubKey);
      await _saveAccounts();
    }
  }

  Future<void> _loadAccounts() async {
    accounts.clear();
    final String? json = await _storage.read(key: StorageKeys.accountsKey);
    if (json == null) {
      return;
    }

    final List<dynamic> data = jsonDecode(json) as List<dynamic>;
    for (final dynamic e in data) {
      accounts.add(StoredAccount.fromJson(e as Map<String, dynamic>));
    }
  }

  Future<void> _loadCurrentIndex() async {
    _currentIndex = int.tryParse(
            await _storage.read(key: StorageKeys.currentCardIndexKey) ?? '') ??
        _prefs.getInt(StorageKeys.currentCardIndexKey) ??
        0;
  }

  Future<void> _saveAccounts([bool notify = true]) async {
    final List<Map<String, dynamic>> data =
        accounts.map((StoredAccount a) => a.toJson()).toList();
    await _storage.write(key: StorageKeys.accountsKey, value: jsonEncode(data));

    if (notify) {
      notifyListeners();
    }
  }

  // ────────────── Public API ──────────────

  @override
  List<LegacyWallet> get cards => accounts
      .map((StoredAccount acc) => LegacyWallet(
            seed: acc.seed != null ? seedToString(acc.seed!) : '',
            pubKey: acc.pubKey,
            name: acc.contact.name ?? '',
            theme: acc.theme,
          ))
      .toList();

  @override
  int getCurrentWalletIndex() => _currentIndex;

  @override
  Future<void> setCurrentWalletIndex(int index) async {
    _currentIndex = index;
    await _storage.write(key: StorageKeys.currentCardIndexKey, value: '$index');
    notifyListeners();
  }

  @override
  Future<void> selectCurrentWalletIndex(int index) async {
    if (index < accounts.length) {
      await setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  @override
  Future<void> selectCurrentWallet(LegacyWallet c) async {
    final int i =
        accounts.indexWhere((StoredAccount a) => a.pubKey == c.pubKey);
    await setCurrentWalletIndex(i);
  }

  @override
  String getPubKey() {
    final StoredAccount acc = accounts[_currentIndex];
    return '${acc.pubKey}:${pkChecksum(extractPublicKey(acc.pubKey))}';
  }

  @override
  String getName() => accounts[_currentIndex].contact.name ?? '';

  @override
  WalletTheme getTheme() => accounts[_currentIndex].theme;

  @override
  void setName({required String name, bool notify = true}) {
    final StoredAccount a = accounts[_currentIndex];
    final Contact updatedContact = a.contact.copyWith(name: name);
    final StoredAccount updatedAccount = a.copyWith(contact: updatedContact);
    accounts[_currentIndex] = updatedAccount;
    _saveAccounts();
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void setTheme({required WalletTheme theme}) {
    final StoredAccount a = accounts[_currentIndex];
    final StoredAccount updatedAccount = a.copyWith(theme: theme);
    accounts[_currentIndex] = updatedAccount;
    _saveAccounts();
    notifyListeners();
  }

  @override
  Future<CesiumWallet> getLegacyWallet() async {
    await createDefAccountIfNotExist();
    final StoredAccount acc = accounts[_currentIndex];

    switch (acc.type) {
      case AccountType.v1PasswordLess:
      case AccountType.v2PasswordLess:
      case AccountType.v2PasswordProtected:
        final Uint8List seed = await _resolveActualSeed(acc);
        return CesiumWallet.fromSeed(seed);
      case AccountType.v1PasswordProtected:
        final CesiumWallet? wallet = _cesiumVolatileCards[acc.pubKey];
        if (wallet == null) {
          throw Exception(
              'Volatile wallet not available for v1PasswordProtected');
        }
        return wallet;
    }
  }

  Future<void> createDefAccountIfNotExist() async {
    if (accounts.isNotEmpty) {
      return;
    }

    final StoredAccount acc = await createV2PasswordLessAccount();
    accounts.add(acc);
    await setCurrentWalletIndex(0);
    await _saveAccounts();
  }

  Future<StoredAccount> createV2PasswordLessAccount() async {
    final String mnemonic = mnemonicGenerate();
    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    final String pubKey = Base58Encode(kp.publicKey.bytes);

    return StoredAccount(
      type: AccountType.v2PasswordLess,
      pubKey: pubKey,
      seed: Uint8List.fromList(utf8.encode(mnemonic)),
      contact: Contact.withAddress(address: kp.address),
      theme: WalletThemes.theme1,
    );
  }

  Future<StoredAccount> createV2PasswordProtectedAccount(
      Uint8List passwordKey) async {
    final String mnemonic = mnemonicGenerate();
    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    final String pubKey = Base58Encode(kp.publicKey.bytes);
    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      Uint8List.fromList(utf8.encode(mnemonic)),
      passwordKey,
    );

    return StoredAccount(
      type: AccountType.v2PasswordProtected,
      pubKey: pubKey,
      seed: encryptedMnemonic,
      contact: Contact.withAddress(address: kp.address),
      theme: WalletThemes.theme1,
    );
  }

  @override
  Future<KeyPair> getKeyPair([int? index]) async {
    final StoredAccount acc = accounts[index ?? _currentIndex];
    final Uint8List resolvedSeed = await _resolveActualSeed(acc);
    return KeyPair.ed25519.fromSeed(resolvedSeed);
  }

  @override
  bool has(String pubKey) => accounts
      .any((StoredAccount acc) => acc.pubKey == extractPublicKey(pubKey));

  @override
  bool hasVolatilePass() =>
      _cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));

  @override
  void addCesiumVolatileCard(CesiumWallet wallet) {
    _cesiumVolatileCards[wallet.pubkey] = wallet;
  }

  @override
  void addLegacyWallet(LegacyWallet card) {
    if (has(card.pubKey)) {
      return;
    }
    final bool isVolatile = card.seed == '';
    final StoredAccount acc = StoredAccount(
      pubKey: card.pubKey,
      seed: !isVolatile ? seedFromString(card.seed) : null,
      type: isVolatile
          ? AccountType.v1PasswordProtected
          : AccountType.v1PasswordLess,
      theme: card.theme,
      contact: Contact.withPubKey(pubKey: card.pubKey, name: card.name),
    );
    accounts.add(acc);
    _saveAccounts();
  }

  @override
  void removeCurrentWallet() {
    // Don't allow the last card to be removed
    final int index = getCurrentWalletIndex();
    logger('Removing card at index $index');
    if (accounts.length > 1) {
      accounts.removeAt(index);
      _saveAccounts();
      notifyListeners();
    }
  }

  @override
  Future<void> importWalletFromMnemonic(String mnemonic) async {
    final Uint8List seed = seedFromMnemonic(mnemonic); // 64 bytes
    final Uint8List shortSeed = seed.sublist(0, 32); // como en V1
    final KeyPair kp = KeyPair.ed25519.fromSeed(shortSeed);

    final String pubKey = Base58Encode(kp.publicKey.bytes);

    if (has(pubKey)) {
      throw Exception('Already exists');
    }

    final StoredAccount acc = StoredAccount(
      pubKey: pubKey,
      seed: Uint8List.fromList(utf8.encode(mnemonic)),
      type: AccountType.v2PasswordLess,
      theme: WalletThemes.theme1,
      contact: Contact.withAddress(address: kp.address),
    );

    accounts.add(acc);
    await _saveAccounts();
    _currentIndex = accounts.indexOf(acc);
    notifyListeners();
  }

  @override
  Future<void> saveLegacyWallets([bool notify = true]) => _saveAccounts(notify);

  Future<void> setPasswordKeyFromUserInput(Uint8List key) async {
    passwordKey = key;
    _salt = SecureCryptoHelper.generateSalt();
    await _storage.write(
        key: StorageKeys.securePatternOrPass, value: base64Encode(key));
    await _storage.write(
        key: StorageKeys.secureSalt, value: base64Encode(_salt!));
  }

  Uint8List? get salt => _salt;

  Future<Uint8List> _resolveActualSeed(StoredAccount acc) async {
    switch (acc.type) {
      case AccountType.v1PasswordLess:
        return acc.seed!;
      case AccountType.v2PasswordLess:
        final String mnemonic = utf8.decode(acc.seed!);
        return seedFromMnemonic(mnemonic).sublist(0, 32);
      case AccountType.v2PasswordProtected:
        final Uint8List? key = passwordKey ?? (await requestSecureUnlock());
        if (key == null) {
          throw Exception('No password key available');
        }
        final Uint8List? dec = SecureCryptoHelper.decrypt(acc.seed!, key);
        if (dec == null) {
          throw Exception('Cannot decrypt mnemonic');
        }
        final String mnemonic = utf8.decode(dec);
        return seedFromMnemonic(mnemonic).sublist(0, 32);
      case AccountType.v1PasswordProtected:
        final CesiumWallet? wallet = _cesiumVolatileCards[acc.pubKey];
        if (wallet == null) {
          throw Exception('Missing volatile wallet');
        }
        return wallet.seed;
    }
  }

  Future<void> cardsClear() async {
    accounts.clear();
  }
}
