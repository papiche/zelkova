import 'dart:convert';

import 'package:bip39_multi_nullsafety/bip39_multi_nullsafety.dart' as bip39;
import 'package:durt/durt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/data/models/wallet_themes.dart';
import 'package:ginkgo/g1/g1_helper.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';
import 'package:ginkgo/secure_crypto_helper.dart';
import 'package:ginkgo/shared_prefs_helper.dart';
import 'package:ginkgo/storage_keys.dart';
import 'package:ginkgo/ui/logger.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_mock.dart' show registerMockSecureStorage;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesHelper helper;

  setUp(() async {
    registerMockSecureStorage();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    helper = SharedPreferencesHelper();
    SharedPreferencesHelper().init(onlyV2: true);
    SharedPreferencesHelper.configure(useV2: true);
    helper.accountsClear();
  });

  // V1 tests

  group('migration', () {
    test('moves legacy seed/pub keys into cesiumCards', () async {
      final Uint8List seedBytes = generateUintSeed();
      final String seed = seedToString(seedBytes);
      final CesiumWallet w = CesiumWallet.fromSeed(seedBytes);
      SharedPreferences.setMockInitialValues(<String, Object>{
        'seed': seed,
        'pub': w.pubkey,
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('seed'), true);
      expect(prefs.containsKey('pub'), true);
      helper = SharedPreferencesHelper();
      await helper.init(onlyV2: true);
      expect(prefs.containsKey('seed'), false);
      expect(prefs.containsKey('pub'), false);
      expect(helper.length, 1);
      expect(helper.getCurrentWalletIndex(), 0);
    });
  });

  group('automatic wallet creation', () {
    test('getWallet creates and persists a wallet when none exist', () async {
      expect(helper.isEmpty, true);
      final StoredAccount w = await helper.createDefWalletIfNotExist();
      expect(w.pubKey.isNotEmpty, true);
      expect(helper.length, 1);
    });
  });

  group('wallet persistence and retrieval', () {
    test('addLegacyWallet is durable across helper instances', () async {
      await helper.createDefWalletIfNotExist(); // ensure 1st wallet
      final CesiumWallet w1 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w1.seed), pubKey: w1.pubkey));

      final SharedPreferencesHelper other = SharedPreferencesHelper();
      await other.init();
      expect(other.length, 2);
      expect(other.accounts.last.pubKey, w1.pubkey);
    });

    test('removeLegacyWallet refuses to delete the last wallet', () async {
      await helper.createDefWalletIfNotExist();
      final int before = helper.length;
      expect(before, 1);
      helper.removeCurrentWallet();
      expect(helper.length, before);
    });

    test('removeLegacyWallet removes when more than one wallet exists',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      final int before = helper.length;
      expect(before, 2);
      helper.removeCurrentWallet();
      expect(helper.length, before - 1);
    });
  });

  group('current index control', () {
    test('setCurrentWalletIndex persists value', () async {
      await helper.createDefWalletIfNotExist();
      await helper.selectCurrentWalletIndex(0);
      expect(helper.getCurrentWalletIndex(), 0);
    });

    test('selectCurrentWalletIndex throws on invalid index', () async {
      await expectLater(helper.selectCurrentWalletIndex(99), throwsException);
    });
  });

  group('naming and theming', () {
    test('setName and getName round-trip', () async {
      await helper.createDefWalletIfNotExist();
      helper.setName(name: 'alice');
      expect(helper.getName(), 'alice');
    });

    test('setTheme and getTheme round-trip', () async {
      await helper.createDefWalletIfNotExist();
      helper.setTheme(theme: WalletThemes.theme2);
      expect(helper.getTheme(), WalletThemes.theme2);
    });
  });

  group('lookup helpers', () {
    test('has and hasMultipleWallets reflect state', () async {
      await helper.createDefWalletIfNotExist();
      expect(helper.hasMultipleWallets, false);
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      expect(helper.has(w2.pubkey), true);
      expect(helper.hasMultipleWallets, true);
    });

    test('hasVolatile is true after adding volatile wallet', () async {
      final CesiumWallet w = CesiumWallet.fromSeed(generateUintSeed());
      helper.handleCorrectCesiumV1Auth(
          publicKey: w.pubkey, name: 'test', wallet: w);
      expect(helper.hasVolatilePass(), true);
    });
  });

  group('key material', () {
    test('getKeyPair derives from current wallet', () async {
      final StoredAccount w = await helper.createDefWalletIfNotExist();
      final KeyPair keyPair = await helper.getKeyPair();
      expect(Base58Encode(keyPair.publicKey.bytes), w.pubKey);
    });

    test('isPasswordLessWallet detects seed presence', () async {
      await helper.createDefWalletIfNotExist();
      expect(helper.isPasswordLessWallet(), true);
    });
  });

  // V2 tests
  group('V2 wallet flow', () {
    test('creates and retrieves wallet from secure storage', () async {
      expect(helper.isEmpty, true);
      final StoredAccount w = await helper.createDefWalletIfNotExist();
      expect(w.pubKey.isNotEmpty, true);
      expect(helper.length, 1);
    });

    test('derives keypair from wallet', () async {
      final StoredAccount w = await helper.createDefWalletIfNotExist();
      final KeyPair k = await helper.getKeyPair();
      expect(Base58Encode(k.publicKey.bytes), w.pubKey);
    });

    test('set and retrieve wallet name and theme', () async {
      await helper.createDefWalletIfNotExist();
      helper.setName(name: 'v2user');
      expect(helper.getName(), 'v2user');
      helper.setTheme(theme: WalletThemes.theme3);
      expect(helper.getTheme(), WalletThemes.theme3);
    });

    test('wallets from v1 are migrated', () async {
      final CesiumWallet w = CesiumWallet.fromSeed(generateUintSeed());

      SharedPreferences.setMockInitialValues(<String, Object>{
        'seed': seedToString(w.seed),
        'pub': w.pubkey,
      });

      helper = SharedPreferencesHelper();
      await helper.init(onlyV2: true);
      expect(
          helper.accounts.any((StoredAccount c) => c.pubKey == w.pubkey), true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('seed'), false);
      expect(prefs.containsKey('pub'), false);
    });
  });

  test('Store and retrieve v1PasswordLess account', () async {
    final Uint8List seed = generateUintSeed();
    final CesiumWallet w = CesiumWallet.fromSeed(seed);

    final StoredAccount acc = StoredAccount(
      pubKey: w.pubkey,
      address: addressFromV1Pubkey(w.pubkey),
      seed: seed,
      type: AccountType.v1PasswordLess,
      contact: Contact.withPubKey(pubKey: w.pubkey, name: 'v1Plain'),
      theme: WalletThemes.theme1,
    );
    helper.accounts.add(acc);
    await helper.saveLegacyWallets();

    final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
    await reloaded.init(onlyV2: true);
    final StoredAccount restored =
        reloaded.accounts.firstWhere((StoredAccount a) => a.pubKey == w.pubkey);
    expect(restored.type, AccountType.v1PasswordLess);
    expect(restored.seed, seed);
    expect(restored.contact.name, 'v1Plain');
  });

  test('Store and retrieve v1PasswordProtected account (volatile)', () async {
    final Uint8List seed = generateUintSeed();
    final CesiumWallet wallet = CesiumWallet.fromSeed(seed);

    helper.addCesiumVolatileCard(wallet);

    final StoredAccount acc = StoredAccount(
      pubKey: wallet.pubkey,
      address: addressFromV1Pubkey(wallet.pubkey),
      type: AccountType.v1PasswordProtected,
      contact: Contact.withPubKey(pubKey: wallet.pubkey, name: 'v1Protected'),
      theme: WalletThemes.theme2,
    );
    helper.accounts.add(acc);
    helper.saveLegacyWallets();

    final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
    await reloaded.init(onlyV2: true);
    final StoredAccount restored = reloaded.accounts
        .firstWhere((StoredAccount a) => a.pubKey == wallet.pubkey);
    expect(restored.type, AccountType.v1PasswordProtected);
    expect(restored.seed, isNull);
    expect(restored.contact.name, 'v1Protected');
  });

  test('Store and retrieve v2PasswordLess account', () async {
    final String mnemonic = mnemonicGenerate();
    helper.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
    final KeyPair kp = await KeyPair.ed25519.fromMnemonic(mnemonic);
    final String pubKey = v1pubkeyFromAddress(kp.address);

    final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
    await reloaded.init(onlyV2: true);
    final StoredAccount restored =
        reloaded.accounts.firstWhere((StoredAccount a) => a.pubKey == pubKey);
    expect(restored.type, AccountType.v2PasswordLess);
    expect(utf8.decode(restored.seed!), mnemonic);
  });

  test('Store and retrieve v2PasswordProtected account using real flow',
      () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';

    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    final String pubKey = Base58Encode(kp.publicKey.bytes);

    // Step 1: Generate a fixed salt and derive a password-based key
    final List<int> salt = List<int>.generate(32, (int i) => i);
    const String password = 'testPassword123';
    final Uint8List passwordKey =
        await SecureCryptoHelper.deriveKeyFromPassword(password, salt);

    // Step 2: Encrypt the mnemonic
    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      Uint8List.fromList(utf8.encode(mnemonic)),
      passwordKey,
    );

    // Step 3: Manually store the salt and passwordKey in the mocked secure storage
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(
      key: StorageKeys.secureSalt,
      value: base64Encode(Uint8List.fromList(salt)),
    );
    await storage.write(
      key: StorageKeys.securePatternOrPass,
      value: base64Encode(passwordKey),
    );

    // Step 4: Create and persist the account
    final StoredAccount acc = StoredAccount(
      pubKey: pubKey,
      address: addressFromV1Pubkey(pubKey),
      seed: encryptedMnemonic,
      type: AccountType.v2PasswordProtected,
      contact: Contact.withAddress(address: kp.address),
      theme: WalletThemes.theme4,
    );

    helper.accounts.add(acc);
    await helper.saveLegacyWallets();

    // Step 5: Reload helper and decrypt the mnemonic
    final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
    await reloaded.init(onlyV2: true);

    final StoredAccount restored =
        reloaded.accounts.firstWhere((StoredAccount a) => a.pubKey == pubKey);

    // Manually provide the passwordKey (normally obtained via unlock flow)
    reloaded.passwordKey = passwordKey;

    final Uint8List? decryptedBytes =
        SecureCryptoHelper.decrypt(restored.seed!, passwordKey);

    final String decryptedMnemonic = utf8.decode(decryptedBytes!);

    expect(restored.type, AccountType.v2PasswordProtected);
    expect(decryptedMnemonic, mnemonic);
  });

  test('test mnemonic to pubkey using importWalletFromMnemonic', () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';
    expect(mnemonic.split(' ').length, 12);
    expect(bip39.validateMnemonic(mnemonic), true);
    await helper.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
    final StoredAccount acc = helper.accounts.last;
    expect(acc.address, 'g1MmPVNXofuDN4tQFyGoFg7GT9npLscGWVLtV7hXCqMmha1DS',
        reason: 'No same address');
  });

  test('reencryptAllProtectedAccounts migrates mnemonic to new password key',
      () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';

    // Simulate original password and salt
    final List<int> oldSalt = List<int>.generate(32, (int i) => i);
    const String oldPassword = 'old-password';
    final Uint8List oldKey =
        await SecureCryptoHelper.deriveKeyFromPassword(oldPassword, oldSalt);

    // Encrypt the mnemonic with oldKey
    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      mnemonicToStore(mnemonic),
      oldKey,
    );

    // Create and add the account
    final KeyPair kp =
        await Keyring().fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
    final StoredAccount acc = StoredAccount(
      type: AccountType.v2PasswordProtected,
      pubKey: Base58Encode(kp.publicKey.bytes),
      address: kp.address,
      seed: encryptedMnemonic,
      contact: Contact.withAddress(address: kp.address),
      theme: WalletThemes.theme2,
    );
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    helper.accountsClear();
    helper.accounts.add(acc);

    // Simulate password change
    const String newPassword = 'new-password';
    final List<int> newSalt = List<int>.generate(32, (int i) => 100 - i);
    final Uint8List newKey =
        await SecureCryptoHelper.deriveKeyFromPassword(newPassword, newSalt);

    await helper.reEncryptAllProtectedAccounts(
      oldKey: oldKey,
      newKey: newKey,
    );

    // After re-encryption, mnemonic must be recoverable with new key
    final StoredAccount updated = helper.accounts.first;
    final Uint8List? decrypted =
        SecureCryptoHelper.decrypt(updated.seed!, newKey);
    final String recoveredMnemonic = storeToMnemonic(decrypted!);

    expect(recoveredMnemonic, equals(mnemonic));

    // Decryption with old key should now fail
    final Uint8List? decryptedWithOldKey =
        SecureCryptoHelper.decrypt(updated.seed!, oldKey);
    expect(decryptedWithOldKey, isNull);
  });

  group('derivation compatibility', () {
    test('known EN mnemonic -> expected address (compat bridge)', () async {
      const String mnemonic =
          'attitude legend purchase discover canyon panda phone change flavor language often will';
      const String expectedAddress =
          'g1Px6m62yD5J1CYLTwqVA4jFZ4YfyR6zWX8GyPgBwPNpukQx6';

      final KeyPair kp = await deriveKeyPairCompat(mnemonic);
      expect(kp.address, expectedAddress, reason: 'KeyPair address mismatch');

      await helper.importWalletFromMnemonic(
          mnemonic, AccountType.v2PasswordLess);
      final StoredAccount acc = helper.accounts.last;
      expect(acc.address, expectedAddress,
          reason: 'Stored account address mismatch');
    });
  });

  group('cross-language mnemonic equivalence', () {
    test('EN/ES/FR/IT mnemonics (same entropy) yield the same address',
        () async {
      const String enMnemonic =
          'attitude legend purchase discover canyon panda phone change flavor language often will';
      const String expectedAddress =
          'g1Px6m62yD5J1CYLTwqVA4jFZ4YfyR6zWX8GyPgBwPNpukQx6';

      // Build equivalents from the same entropy
      final String entropyHex =
          bip39.mnemonicToEntropy(enMnemonic); // , language: 'english');

      final Map<String, String> mnemonics = <String, String>{
        'english': enMnemonic,
        'spanish': bip39.entropyToMnemonic(entropyHex, language: 'spanish'),
        'french': bip39.entropyToMnemonic(entropyHex, language: 'french'),
        'italian': bip39.entropyToMnemonic(entropyHex, language: 'italian'),
      };

      // english mnemonic: attitude legend purchase discover canyon panda phone change flavor language often will
      // spanish mnemonic: añadir lima pedal danza bozal océano opaco cadáver fiebre legión nervio violín
      // french mnemonic: anormal imposer orifice déborder bouquin mouche néfaste cabanon éprouver humide menhir vinaigre
      // italian mnemonic: appetito minerale ramingo docente buca piacere poderoso capra fumante mercurio pari virulento

      for (final MapEntry<String, String> entry in mnemonics.entries) {
        logger('${entry.key} mnemonic: ${entry.value}');
      }

      // Sanity: each validates in its wordlist
      expect(
          bip39.validateMnemonic(mnemonics['english']!),
          // , language: 'english'),
          isTrue);
      expect(bip39.validateMnemonic(mnemonics['spanish']!, language: 'spanish'),
          isTrue);
      expect(bip39.validateMnemonic(mnemonics['french']!, language: 'french'),
          isTrue);
      expect(bip39.validateMnemonic(mnemonics['italian']!, language: 'italian'),
          isTrue);

      // All derived addresses must match the expected one
      for (final MapEntry<String, String> entry in mnemonics.entries) {
        final KeyPair kp = await deriveKeyPairCompat(entry.value);
        expect(kp.address, expectedAddress,
            reason: 'Mismatch for language ${entry.key}');
      }
    });

    test('import flow deduplicates the same entropy across languages',
        () async {
      // Fresh helper (mock storage is already set up in setUp)
      final SharedPreferencesHelper importHelper = SharedPreferencesHelper();
      await importHelper.init(onlyV2: true);
      importHelper.accountsClear();

      const String enMnemonic =
          'attitude legend purchase discover canyon panda phone change flavor language often will';
      final String entropyHex =
          bip39.mnemonicToEntropy(enMnemonic); // , language: 'english');

      final String esMnemonic =
          bip39.entropyToMnemonic(entropyHex, language: 'spanish');
      final String frMnemonic =
          bip39.entropyToMnemonic(entropyHex, language: 'french');
      final String itMnemonic =
          bip39.entropyToMnemonic(entropyHex, language: 'italian');

      // First import should succeed
      await importHelper.importWalletFromMnemonic(
          enMnemonic, AccountType.v2PasswordLess);
      expect(importHelper.length, 1);

      // Subsequent imports of the same entropy (other languages) should fail with "Already exists"
      Future<void> expectAlreadyExists(String m) async {
        try {
          await importHelper.importWalletFromMnemonic(
              m, AccountType.v2PasswordLess);
          fail('Expected "Already exists" when importing same entropy again');
        } catch (e) {
          expect(e.toString(), contains('Already exists'));
        }
      }

      await expectAlreadyExists(esMnemonic);
      await expectAlreadyExists(frMnemonic);
      await expectAlreadyExists(itMnemonic);

      // Still only one wallet stored
      expect(importHelper.length, 1);
    });
  });
}
