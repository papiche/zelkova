import 'dart:convert';
import 'dart:ui';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:substrate_bip39/substrate_bip39.dart' show Language;

import 'data/models/contact.dart';
import 'data/models/legacy_wallet.dart';
import 'data/models/stored_account.dart';
import 'data/models/wallet_themes.dart';
import 'g1/api.dart';
import 'g1/g1_helper.dart';
import 'g1/g1_v2_helper.dart';
import 'secure_crypto_helper.dart';
import 'shared_prefs_helper.dart';
import 'storage_keys.dart';
import 'ui/contacts_cache.dart';
import 'ui/logger.dart';
import 'ui/secure_unlock_widget.dart';
import 'wallet_already_exists_exception.dart';

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

  /// Returns true if the secure storage is unlocked (password key is available)
  @override
  bool isSecureStorageUnlocked() {
    return _passwordKey != null && _passwordKey!.isNotEmpty;
  }

  /// Ensures a non-empty password key is available:
  /// 1) use provided
  /// 2) use cached _passwordKey
  /// 3) await requestSecureUnlock()
  /// Throws if user cancels / no key available.
  Future<Uint8List> _ensurePasswordKey([Uint8List? provided]) async {
    if (provided != null && provided.isNotEmpty) {
      _passwordKey = provided; // cache for later
      return provided;
    }
    if (_passwordKey != null && _passwordKey!.isNotEmpty) {
      return _passwordKey!;
    }
    // Check whether a stored password/pattern exists; if not, trigger setup flow
    final String? storedKey =
        await _storage.read(key: StorageKeys.securePatternOrPass);
    final bool needsSetup = storedKey == null || storedKey.isEmpty;
    final Uint8List? unlocked = await requestSecureUnlock(isSetup: needsSetup);
    if (unlocked == null || unlocked.isEmpty) {
      throw Exception('No password key available');
    }
    _passwordKey = unlocked; // cache
    return unlocked;
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

      // Check for duplicates before adding
      if (!_accountExists(pubKey)) {
        accounts.add(StoredAccount(
          pubKey: pubKey,
          address: addressFromV1Pubkey(pubKey),
          type: AccountType.v1PasswordLess,
          seed: seedFromString(seed),
          contact: Contact.withPubKey(pubKey: pubKey, name: ''),
          theme: SharedPreferencesHelper().randomTheme(),
        ));
      }
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

    // Deduplicate accounts after loading (safety measure)
    _deduplicateAccounts();
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
        // Use normalized comparison to prevent duplicates
        if (_accountExists(lw.pubKey)) {
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

  /// Check if an account with the given pubKey already exists.
  /// Normalizes pubKey by extracting the key without checksum for comparison.
  bool _accountExists(String pubKey) {
    final String normalized = extractPublicKey(pubKey);
    return accounts.any(
      (StoredAccount acc) => extractPublicKey(acc.pubKey) == normalized,
    );
  }

  /// Remove duplicate accounts based on normalized pubKey comparison.
  /// Keeps the first occurrence of each unique account.
  void _deduplicateAccounts() {
    final Set<String> seen = <String>{};
    final List<StoredAccount> unique = <StoredAccount>[];

    for (final StoredAccount acc in accounts) {
      final String normalized = extractPublicKey(acc.pubKey);
      if (!seen.contains(normalized)) {
        seen.add(normalized);
        unique.add(acc);
      } else {
        logger(
            'Warning: Removing duplicate account with pubKey: ${acc.pubKey}');
      }
    }

    if (unique.length != accounts.length) {
      accounts.clear();
      accounts.addAll(unique);
      logger(
          'Deduplication: Removed ${accounts.length - unique.length} duplicate(s)');
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
    log.e('getCesiumWallet is not implemented in SharedPreferencesHelperV2');
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

  Future<StoredAccount> createV2PasswordLessAccount([Locale? locale]) async {
    final String original =
        mnemonicGenerate(lang: bip39LanguageFromLocale(locale));
    final String english = toEnglishMnemonic(original);
    final KeyPair kp =
        await Keyring().fromUri(english, keyPairType: KeyPairType.ed25519);
    kp.ss58Format = 4450;
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);
    final StoredAccount account = StoredAccount(
      type: AccountType.v2PasswordLess,
      pubKey: pubKey,
      address: address,
      seed: mnemonicToStore(original),
      contact: Contact.withAddress(address: kp.address),
      theme: SharedPreferencesHelper().randomTheme(),
    );
    await _onAccountAdded(account);
    return account;
  }

  Future<StoredAccount> createV2PasswordProtectedAccount(Uint8List passwordKey,
      [Locale? locale]) async {
    final String original =
        mnemonicGenerate(lang: bip39LanguageFromLocale(locale));
    final String english = toEnglishMnemonic(original);
    final KeyPair kp =
        await Keyring().fromUri(english, keyPairType: KeyPairType.ed25519);
    kp.ss58Format = 4450;
    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      mnemonicToStore(original),
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
    await _onAccountAdded(account);
    return account;
  }

  @override
  Future<KeyPair> getKeyPair([int? index, StoredAccount? account]) async {
    final StoredAccount acc = account ?? accounts[index ?? _currentIndex];
    final Uint8List resolvedSeed = await _resolveActualSeed(acc);
    final KeyPair kp = acc.type.isV1
        ? KeyPair.ed25519.fromSeed(resolvedSeed)
        : await deriveKeyPairCompat(storeToMnemonic(resolvedSeed));
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
    // Double-check with normalized comparison
    if (_accountExists(card.pubKey)) {
      logger('Skipping duplicate wallet: ${card.pubKey}');
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
  Future<void> importWalletFromMnemonic(
      String? mnemonicProv, AccountType type) async {
    // Validate account type
    if (type != AccountType.v2PasswordLess &&
        type != AccountType.v2PasswordProtected) {
      throw Exception('Unsupported account type for mnemonic import: $type');
    }

    final String original = mnemonicProv ?? mnemonicGenerate();

    if (!isValidMnemonic(original)) {
      throw Exception(
          'Invalid mnemonic (supported: ${supportedMnemonicLanguages.join(", ")})');
    }

    final Language? lang = detectMnemonicLanguage(original);
    loggerDev('mnemonic language detected: ${lang ?? "unknown"}');

    // Derive keypair regardless of language (fallback to EN if needed)
    final KeyPair kp = await deriveKeyPairCompat(original);
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);
    logger('Importing wallet with pubKey: $pubKey and address: $address');

    // Use normalized comparison to detect duplicates
    if (_accountExists(pubKey)) {
      logger('Wallet already exists: $pubKey');
      throw WalletAlreadyExistsException(pubKey);
    }

    // Store seed depending on type
    Uint8List seedBytes;
    if (type == AccountType.v2PasswordProtected) {
      // this awaits the unlock dialog properly when needed
      Uint8List key;
      try {
        key = await _ensurePasswordKey(_passwordKey);
      } catch (e) {
        // Propagate a clearer error so callers can handle cancellation/no-key
        throw Exception('Import cancelled or no password key available');
      }
      seedBytes = SecureCryptoHelper.encrypt(mnemonicToStore(original), key);
    } else {
      // v2PasswordLess: store plaintext mnemonic bytes
      seedBytes = mnemonicToStore(original);
    }
    final StoredAccount acc = StoredAccount(
      pubKey: pubKey,
      address: address,
      seed: seedBytes,
      type: type,
      theme: SharedPreferencesHelper().randomTheme(),
      contact: Contact.withAddress(
        address: kp.address,
        createdOn: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    await _onAccountAdded(acc);
  }

  Future<void> _onAccountAdded(StoredAccount acc) async {
    // Final safety check before adding
    if (_accountExists(acc.pubKey)) {
      logger('ERROR: Attempted to add duplicate account: ${acc.pubKey}');
      throw WalletAlreadyExistsException(acc.pubKey);
    }
    accounts.add(acc);
    await _saveAccounts();
    await _setCurrentWalletIndex(accounts.length - 1);
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
        final Uint8List key = await _ensurePasswordKey();
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
      // Strip out the old identity from the cached version.
      // This preserves Cesium+ profile info (avatar, etc) but removes the name
      // and WOT status so getProfile won't merge a stale name back in if the
      // remote identity is empty.
      final Contact? cached = ContactsCache().getCachedContact(acc.pubKey);
      if (cached != null) {
        await ContactsCache().saveContact(cached.cloneWithoutIdentity());
      }

      final Contact updatedContact = await getProfile(
        acc.pubKey,
        resize: false,
        complete: true,
      );
      accounts[i] = acc.copyWith(contact: updatedContact);
    }
    await _saveAccounts();
  }

  @override
  Future<void> removeCesiumVolatileCard([CesiumWallet? wallet]) async {
    if (wallet != null) {
      _cesiumVolatileCards.remove(extractPublicKey(wallet.pubkey));
    } else {
      final StoredAccount account = getCurrentAccount();
      if (account.type == AccountType.v1PasswordProtected) {
        _cesiumVolatileCards.removeWhere((String key, CesiumWallet value) {
          return key == extractPublicKey(account.pubKey);
        });
      }
    }
  }
}
