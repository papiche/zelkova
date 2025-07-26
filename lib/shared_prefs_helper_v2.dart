import 'dart:convert';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/contact.dart';
import '../data/models/legacy_wallet.dart';
import '../data/models/stored_account.dart';
import '../data/models/wallet_themes.dart';
import '../g1/g1_helper.dart';
import 'g1/api.dart';
import 'g1/g1_v2_helper.dart';
import 'secure_crypto_helper.dart';
import 'shared_prefs_helper.dart';
import 'storage_keys.dart';
import 'ui/logger.dart';
import 'ui/secure_unlock_widget.dart';

class SharedPreferencesHelperV2
    with ChangeNotifier
    implements SharedPreferencesHelperDelegate {
  factory SharedPreferencesHelperV2() {
    return _instance;
  }

  SharedPreferencesHelperV2._internal() {
    SharedPreferences.getInstance().then((SharedPreferences value) {
      _prefs = value;
    });
  }

  static final SharedPreferencesHelperV2 _instance =
      SharedPreferencesHelperV2._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late SharedPreferences _prefs;

  @override
  final List<StoredAccount> accounts = <StoredAccount>[];

  final Map<String, CesiumWallet> _cesiumVolatileCards =
      <String, CesiumWallet>{};

  int _currentIndex = 0;
  Uint8List? _passwordKey;

  Uint8List? getPasswordKey() => _passwordKey!;

  void setPasswordKey(Uint8List? key) {
    _passwordKey = key;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _migrateBetaAccount();
    await _loadAccounts();
    await _migrateLegacyAccounts();
    await _loadCurrentIndex();
  }

  Future<void> _migrateBetaAccount() async {
    if (_prefs.containsKey(StorageKeys.seedKey) &&
        _prefs.containsKey(StorageKeys.pubKey)) {
      final String seed = _prefs.getString(StorageKeys.seedKey)!;
      final String pubKey = _prefs.getString(StorageKeys.pubKey)!;

      accounts.add(StoredAccount(
        pubKey: pubKey,
        address: addressFromV1Pubkey(pubKey),
        type: AccountType.v1PasswordLess,
        seed: seedFromString(seed),
        contact: Contact.withPubKey(pubKey: pubKey, name: 'Migrated'),
        theme: SharedPreferencesHelper().randomTheme(),
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
    final int currentIndex = int.tryParse(
            await _storage.read(key: StorageKeys.currentCardIndexKey) ?? '') ??
        _prefs.getInt(StorageKeys.currentCardIndexKey) ??
        0;
    if (currentIndex < accounts.length) {
      _currentIndex = currentIndex;
    } else {
      logger('Current index $currentIndex is out of bounds, resetting to 0');
      _currentIndex = 0;
      await _setCurrentWalletIndex(_currentIndex);
    }
  }

  Future<void> _migrateLegacyAccounts() async {
    final String? legacyJson = _prefs.getString(StorageKeys.cardsKey);
    if (legacyJson != null) {
      final List<dynamic> list = jsonDecode(legacyJson) as List<dynamic>;
      for (final dynamic e in list) {
        final LegacyWallet lw =
            LegacyWallet.fromJson(e as Map<String, dynamic>);
        if (accounts
            .where((StoredAccount a) => a.pubKey == lw.pubKey)
            .isNotEmpty) {
          continue;
        }
        accounts.add(StoredAccount(
          seed: seedFromString(lw.seed),
          pubKey: lw.pubKey,
          address: addressFromV1Pubkey(lw.pubKey),
          theme: lw.theme,
          contact: Contact.withPubKey(pubKey: lw.pubKey, name: lw.name),
          type: lw.seed.isEmpty
              ? AccountType.v1PasswordProtected
              : AccountType.v1PasswordLess,
        ));
      }
      await _saveAccounts();
    }
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

  Future<void> _setCurrentWalletIndex(int index) async {
    _currentIndex = index;
    await _storage.write(key: StorageKeys.currentCardIndexKey, value: '$index');
    notifyListeners();
  }

  @override
  Future<void> selectCurrentWalletIndex(int index) async {
    if (index < accounts.length) {
      await _setCurrentWalletIndex(index);
    } else {
      throw Exception('Invalid wallet index: $index');
    }
  }

  @override
  Future<void> selectCurrentWallet(String pubKey) async {
    final String extractedPubkey = extractPublicKey(pubKey);
    final int i =
        accounts.indexWhere((StoredAccount a) => a.pubKey == extractedPubkey);
    logger('Selecting wallet with pubKey: $extractedPubkey at index $i');
    await _setCurrentWalletIndex(i);
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
  Future<CesiumWallet> getCesiumWallet() async {
    throw UnimplementedError(
        'getCesiumWallet is not implemented in SharedPreferencesHelperV2');
  }

  @override
  Future<StoredAccount> createDefWalletIfNotExist() async {
    if (accounts.isNotEmpty) {
      return accounts[_currentIndex];
    }

    final StoredAccount acc = await createV2PasswordLessAccount();
    return acc;
  }

  Future<StoredAccount> createV2PasswordLessAccount() async {
    final String mnemonic = mnemonicGenerate();
    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    kp.ss58Format = 4450;
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);

    final StoredAccount account = StoredAccount(
      type: AccountType.v2PasswordLess,
      pubKey: pubKey,
      address: address,
      seed: mnemonicToStore(mnemonic),
      contact: Contact.withAddress(address: kp.address),
      theme: SharedPreferencesHelper().randomTheme(),
    );

    _onAccountAdded(account);
    return account;
  }

  Future<StoredAccount> createV2PasswordProtectedAccount(
      Uint8List passwordKey) async {
    final String mnemonic = mnemonicGenerate();
    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    kp.ss58Format = 4450;
    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      mnemonicToStore(mnemonic),
      passwordKey,
    );
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);
    final StoredAccount account = StoredAccount(
      type: AccountType.v2PasswordProtected,
      pubKey: pubKey,
      address: address,
      seed: encryptedMnemonic,
      contact: Contact.withAddress(address: kp.address),
      theme: SharedPreferencesHelper().randomTheme(),
    );
    _onAccountAdded(account);
    return account;
  }

  @override
  Future<KeyPair> getKeyPair([int? index]) async {
    final StoredAccount acc = accounts[index ?? _currentIndex];
    final Uint8List resolvedSeed = await _resolveActualSeed(acc);
    final KeyPair kp = acc.type.isV1
        ? KeyPair.ed25519.fromSeed(resolvedSeed)
        : await KeyPair.ed25519.fromMnemonic(storeToMnemonic(resolvedSeed));
    kp.ss58Format = 4450;
    return kp;
  }

  @override
  bool has(String pubKey) => accounts
      .any((StoredAccount acc) => acc.pubKey == extractPublicKey(pubKey));

  @override
  bool hasVolatilePass([StoredAccount? account]) {
    if (account != null) {
      final String pubKey = extractPublicKey(account.pubKey);
      return _cesiumVolatileCards.containsKey(pubKey);
    }
    return _cesiumVolatileCards.containsKey(extractPublicKey(getPubKey()));
  }

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
      address: addressFromV1Pubkey(card.pubKey),
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
      _setCurrentWalletIndex(accounts.length - 1);
    }
  }

  @override
  Future<void> importWalletFromMnemonic(String? mnemonicProv) async {
    final String mnemonic = mnemonicProv ?? mnemonicGenerate();
    final Keyring keyring = Keyring();
    final KeyPair kp =
        await keyring.fromMnemonic(mnemonic, keyPairType: KeyPairType.ed25519);
    kp.ss58Format = 4450;
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);
    logger('Importing wallet with pubKey: $pubKey and address: $address');

    if (has(pubKey)) {
      throw Exception('Already exists');
    }

    final StoredAccount acc = StoredAccount(
      pubKey: pubKey,
      address: address,
      seed: mnemonicToStore(mnemonic),
      type: AccountType.v2PasswordLess,
      theme: SharedPreferencesHelper().randomTheme(),
      contact: Contact.withAddress(
          address: kp.address,
          createdOn: DateTime.now().millisecondsSinceEpoch),
    );

    await _onAccountAdded(acc);
  }

  Future<void> _onAccountAdded(StoredAccount acc) async {
    accounts.add(acc);
    await _saveAccounts();
    _setCurrentWalletIndex(accounts.length - 1);
    notifyListeners();
  }

  @override
  Future<void> saveLegacyWallets([bool notify = true]) => _saveAccounts(notify);

  Future<Uint8List> _resolveActualSeed(StoredAccount acc) async {
    switch (acc.type) {
      case AccountType.v1PasswordLess:
        return acc.seed!;
      case AccountType.v2PasswordLess:
        return acc.seed!;
      case AccountType.v2PasswordProtected:
        final Uint8List? key = _passwordKey ?? (await requestSecureUnlock());
        if (key == null) {
          throw Exception('No password key available');
        }
        final Uint8List? dec = SecureCryptoHelper.decrypt(acc.seed!, key);
        if (dec == null) {
          throw Exception('Cannot decrypt mnemonic');
        }
        return dec;
      case AccountType.v1PasswordProtected:
        final CesiumWallet? wallet = _cesiumVolatileCards[acc.pubKey];
        if (wallet == null) {
          throw Exception('Missing volatile wallet');
        }
        return wallet.seed;
    }
  }

  @override
  void accountsClear() {
    accounts.clear();
  }

  @override
  bool get hasMultipleWallets => accounts.length > 1;

  @override
  bool get isEmpty => accounts.isEmpty;

  @override
  int get length => accounts.length;

  @override
  List<String> get publicKeys =>
      accounts.map((StoredAccount a) => a.pubKey).toList();

  @override
  bool isPasswordLessWallet([StoredAccount? other]) {
    final StoredAccount w = other ?? accounts[getCurrentWalletIndex()];
    return w.type == AccountType.v1PasswordLess ||
        w.type == AccountType.v2PasswordLess;
  }

  @override
  StoredAccount getCurrentAccount() {
    return accounts[_currentIndex];
  }

  @override
  Future<void> reEncryptAllProtectedAccounts({
    required Uint8List oldKey,
    required Uint8List newKey,
  }) async {
    for (final StoredAccount acc in accounts) {
      if (acc.type == AccountType.v2PasswordProtected) {
        final Uint8List? decrypted =
            SecureCryptoHelper.decrypt(acc.seed!, oldKey);
        if (decrypted != null) {
          final Uint8List reEncrypted =
              SecureCryptoHelper.encrypt(decrypted, newKey);
          final StoredAccount updated = acc.copyWith(seed: reEncrypted);
          accounts[accounts.indexOf(acc)] = updated;
        }
      }
    }
    await _saveAccounts();
  }

  @override
  bool isLocked([StoredAccount? account]) {
    if (isPasswordLessWallet(account)) {
      return false;
    } else {
      final StoredAccount acc = account == null
          ? getCurrentAccount()
          : accounts
              .firstWhere((StoredAccount a) => a.pubKey == account.pubKey);
      if (acc.type.isV1) {
        return !hasVolatilePass(account);
      } else {
        return _passwordKey == null || _passwordKey!.isEmpty;
      }
    }
  }

  @override
  Future<void> refreshWalletsInfo() async {
    for (int i = 0; i < accounts.length; i++) {
      final StoredAccount acc = accounts[i];
      final Contact updatedContact = await getProfile(
        acc.pubKey,
        resize: false,
        complete: true,
      );
      accounts[i] = acc.copyWith(contact: updatedContact);
    }
    await _saveAccounts();
  }

  // Duplicate in V1
  @override
  Future<void> removeCesiumVolatileCard([CesiumWallet? wallet]) async {
    if (wallet != null) {
      _cesiumVolatileCards.remove(extractPublicKey(wallet.pubkey));
    } else {
      final CesiumWallet w = await getCesiumWallet();
      _cesiumVolatileCards.removeWhere((String key, CesiumWallet value) {
        return key == extractPublicKey(w.pubkey);
      });
    }
  }
}
