import 'dart:convert';
import 'dart:typed_data';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/contact.dart';
import 'package:zelkova/data/models/stored_account.dart';
import 'package:zelkova/data/models/wallet_themes.dart';
import 'package:zelkova/g1/crypto/cesium_wallet.dart';
import 'package:zelkova/g1/g1_helper.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';
import 'package:zelkova/secure_crypto_helper.dart';
import 'package:zelkova/services/derivation_scan_service.dart';
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:zelkova/storage_keys.dart';
import 'package:zelkova/ui/logger.dart';
import 'package:zelkova/wallet_already_exists_exception.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_mock.dart' show registerMockSecureStorage;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesHelper helper;

  setUp(() async {
    // Enable testing mode to skip network checks
    DerivationScanService.skipNetworkCheck = true;

    registerMockSecureStorage();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    helper = SharedPreferencesHelper();
    await SharedPreferencesHelper().init(onlyV2: true);
    SharedPreferencesHelper.configure(useV2: true);
    helper.accountsClear();
  });

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

    test('Calling createDefWalletIfNotExist multiple times is idempotent',
        () async {
      expect(helper.isEmpty, true);

      final StoredAccount w1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      final StoredAccount w2 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1); // Still just one account
      expect(w1.pubKey, w2.pubKey); // Same account
    });

    test('Can access all account methods after creation', () async {
      expect(helper.isEmpty, true);

      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      // All these should work without throwing
      expect(() => helper.getCurrentAccount(), returnsNormally);
      expect(() => helper.getPubKey(), returnsNormally);
      expect(() => helper.getName(), returnsNormally);
      expect(() => helper.getTheme(), returnsNormally);
    });

    test('_currentPubKey is set correctly after account creation', () async {
      expect(helper.isEmpty, true);

      final StoredAccount created = await helper.createDefWalletIfNotExist();
      final String pubKey = helper.getPubKey();

      // pubKey is in format "pubKey:checksum", so check if it starts with account pubKey
      expect(pubKey.startsWith(created.pubKey.substring(0, 20)), true);
    });

    test('Created account can be persisted and retrieved', () async {
      expect(helper.isEmpty, true);

      final StoredAccount created = await helper.createDefWalletIfNotExist();
      final String originalPubKey = created.pubKey;

      // Create a new helper instance to verify persistence
      final SharedPreferencesHelper newHelper = SharedPreferencesHelper();
      await newHelper.init(onlyV2: true);

      expect(newHelper.isEmpty, false);
      expect(newHelper.length, 1);
      final StoredAccount retrieved = newHelper.getCurrentAccount();
      expect(retrieved.pubKey, originalPubKey);
    });
  });

  group('wallet persistence and retrieval', () {
    test('addLegacyWallet is durable across helper instances', () async {
      await helper.createDefWalletIfNotExist();
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
      await helper.removeCurrentWallet();
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
      await helper.removeCurrentWallet();
      expect(helper.length, before - 1);
    });

    test('removeCurrentWallet selects most recently used', () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      final CesiumWallet w3 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w3.seed), pubKey: w3.pubkey));

      expect(helper.length, 3);

      // Simulate usage timestamps: w1=oldest, w3=most recent, w2=middle
      helper.accounts[0] = helper.accounts[0]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch - 2000);
      helper.accounts[1] = helper.accounts[1]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch - 1000);
      helper.accounts[2] = helper.accounts[2]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch);

      // Select w1 (oldest)
      await helper.selectCurrentWallet(helper.accounts[0].pubKey);
      expect(helper.getCurrentWalletIndex(), 0);

      // Remove w1
      await helper.removeCurrentWallet();

      // Should have selected w3 (most recently used)
      expect(helper.length, 2);
      expect(helper.accounts[helper.getCurrentWalletIndex()].pubKey,
          helper.accounts[1].pubKey); // w3 is now at index 1
    });

    test('removeWallet deletes the correct wallet by pubKey', () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      final CesiumWallet w3 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w3.seed), pubKey: w3.pubkey));

      final String wallet1PubKey = helper.accounts[0].pubKey;
      final String wallet2PubKey = helper.accounts[1].pubKey;

      await helper.selectCurrentWallet(wallet1PubKey);

      await helper.removeWallet(wallet2PubKey);

      expect(helper.length, 2);
      expect(
          helper.accounts
              .any((StoredAccount acc) => acc.pubKey == wallet2PubKey),
          false);
      expect(helper.getCurrentAccount().pubKey, wallet1PubKey);
    });

    test('removeWallet throws when pubKey not found', () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));

      await expectLater(
          helper.removeWallet('nonexistent_pubkey'), throwsException);
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
    await helper.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
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

    final List<int> salt = List<int>.generate(32, (int i) => i);
    const String password = 'testPassword123';
    final Uint8List passwordKey =
        await SecureCryptoHelper.deriveKeyFromPassword(password, salt);

    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      Uint8List.fromList(utf8.encode(mnemonic)),
      passwordKey,
    );

    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(
      key: StorageKeys.secureSalt,
      value: base64Encode(Uint8List.fromList(salt)),
    );
    await storage.write(
      key: StorageKeys.securePatternOrPass,
      value: base64Encode(passwordKey),
    );

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

    final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
    await reloaded.init(onlyV2: true);

    final StoredAccount restored =
        reloaded.accounts.firstWhere((StoredAccount a) => a.pubKey == pubKey);

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
    expect(isValidMnemonic(mnemonic), true);
    await helper.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
    final StoredAccount acc = helper.accounts.last;
    expect(acc.address, 'g1MmPVNXofuDN4tQFyGoFg7GT9npLscGWVLtV7hXCqMmha1DS',
        reason: 'No same address');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('reencryptAllProtectedAccounts migrates mnemonic to new password key',
      () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';

    final List<int> oldSalt = List<int>.generate(32, (int i) => i);
    const String oldPassword = 'old-password';
    final Uint8List oldKey =
        await SecureCryptoHelper.deriveKeyFromPassword(oldPassword, oldSalt);

    final Uint8List encryptedMnemonic = SecureCryptoHelper.encrypt(
      mnemonicToStore(mnemonic),
      oldKey,
    );

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

    const String newPassword = 'new-password';
    final List<int> newSalt = List<int>.generate(32, (int i) => 100 - i);
    final Uint8List newKey =
        await SecureCryptoHelper.deriveKeyFromPassword(newPassword, newSalt);

    await helper.reEncryptAllProtectedAccounts(
      oldKey: oldKey,
      newKey: newKey,
    );

    final StoredAccount updated = helper.accounts.first;
    final Uint8List? decrypted =
        SecureCryptoHelper.decrypt(updated.seed!, newKey);
    final String recoveredMnemonic = storeToMnemonic(decrypted!);

    expect(recoveredMnemonic, equals(mnemonic));

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

      final List<int> entropy = Mnemonic.fromSentence(
        enMnemonic,
        Language.english,
      ).entropy;

      final Map<String, String> mnemonics = <String, String>{
        'english': Mnemonic(entropy, Language.english).sentence,
        'spanish': Mnemonic(entropy, Language.spanish).sentence,
        'french': Mnemonic(entropy, Language.french).sentence,
        'italian': Mnemonic(entropy, Language.italian).sentence,
      };

      for (final MapEntry<String, String> entry in mnemonics.entries) {
        logger('${entry.key} mnemonic: ${entry.value}');
      }

      expect(isValidMnemonic(mnemonics['english']!), isTrue);
      expect(isValidMnemonic(mnemonics['spanish']!), isTrue);
      expect(isValidMnemonic(mnemonics['french']!), isTrue);
      expect(isValidMnemonic(mnemonics['italian']!), isTrue);

      for (final MapEntry<String, String> entry in mnemonics.entries) {
        final KeyPair kp = await deriveKeyPairCompat(entry.value);
        expect(kp.address, expectedAddress,
            reason: 'Mismatch for language ${entry.key}');
      }
    });

    test('import flow deduplicates the same entropy across languages',
        () async {
      final SharedPreferencesHelper importHelper = SharedPreferencesHelper();
      await importHelper.init(onlyV2: true);
      importHelper.accountsClear();

      const String enMnemonic =
          'attitude legend purchase discover canyon panda phone change flavor language often will';

      final List<int> entropy = Mnemonic.fromSentence(
        enMnemonic,
        Language.english,
      ).entropy;

      final String esMnemonic = Mnemonic(entropy, Language.spanish).sentence;
      final String frMnemonic = Mnemonic(entropy, Language.french).sentence;
      final String itMnemonic = Mnemonic(entropy, Language.italian).sentence;

      await importHelper.importWalletFromMnemonic(
          enMnemonic, AccountType.v2PasswordLess);
      expect(importHelper.length, 1);

      Future<void> expectAlreadyExists(String m) async {
        try {
          await importHelper.importWalletFromMnemonic(
              m, AccountType.v2PasswordLess);
          fail('Expected "Already exists" when importing same entropy again');
        } catch (e) {
          expect(e is WalletAlreadyExistsException, true,
              reason: 'Expected WalletAlreadyExistsException, got $e');
        }
      }

      await expectAlreadyExists(esMnemonic);
      await expectAlreadyExists(frMnemonic);
      await expectAlreadyExists(itMnemonic);

      expect(importHelper.length, 1);
    });
  });

  test('importing french mnemonic succeeds and derives same address', () async {
    const String fr2 =
        'anormal imposer orifice déborder bouquin mouche néfaste cabanon éprouver humide menhir vinaigre';
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    await helper.init(onlyV2: true);
    SharedPreferencesHelper.configure(useV2: true);
    helper.accountsClear();

    await helper.importWalletFromMnemonic(fr2, AccountType.v2PasswordLess);

    expect(helper.length, 1);
    final StoredAccount acc = helper.getCurrentAccount();

    final KeyPair kp = await helper.getKeyPair();
    expect(acc.address, kp.address);
  });

  group('account duplication prevention', () {
    test('prevents duplicate accounts with same pubKey', () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      final Uint8List seed = generateUintSeed();
      final CesiumWallet w = CesiumWallet.fromSeed(seed);

      // Add first wallet
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed), pubKey: w.pubkey));
      expect(h.length, 1);

      // Try to add same wallet again
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed), pubKey: w.pubkey));
      expect(h.length, 1, reason: 'Should not duplicate wallet');
    });

    test('prevents duplicate accounts with pubKey including checksum',
        () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      final Uint8List seed = generateUintSeed();
      final CesiumWallet w = CesiumWallet.fromSeed(seed);

      // Add first wallet without checksum
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed), pubKey: w.pubkey));
      expect(h.length, 1);

      // Try to add same wallet with checksum in pubKey
      final String pubKeyWithChecksum = '${w.pubkey}:${pkChecksum(w.pubkey)}';
      h.addLegacyWallet(h.buildLegacyWallet(
          seed: seedToString(seed), pubKey: pubKeyWithChecksum));
      expect(h.length, 1,
          reason: 'Should not duplicate wallet with checksum variant');
    });

    test('prevents duplicate on importWalletFromMnemonic', () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      const String mnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      // Import first time
      await h.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
      expect(h.length, 1);

      // Try to import again - should throw
      expect(
        () => h.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess),
        throwsA(isA<WalletAlreadyExistsException>()),
        reason: 'Should throw WalletAlreadyExistsException on duplicate import',
      );
      expect(h.length, 1);
    });

    test('deduplicates accounts on load from storage', () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      // Create duplicate accounts manually
      final Uint8List seed = generateUintSeed();
      final CesiumWallet w = CesiumWallet.fromSeed(seed);

      final StoredAccount acc1 = StoredAccount(
        pubKey: w.pubkey,
        address: addressFromV1Pubkey(w.pubkey),
        seed: seed,
        type: AccountType.v1PasswordLess,
        contact: Contact.withPubKey(pubKey: w.pubkey, name: 'Account 1'),
        theme: WalletThemes.theme1,
      );

      final StoredAccount acc2 = StoredAccount(
        pubKey: w.pubkey,
        address: addressFromV1Pubkey(w.pubkey),
        seed: seed,
        type: AccountType.v1PasswordLess,
        contact: Contact.withPubKey(pubKey: w.pubkey, name: 'Account 2'),
        theme: WalletThemes.theme2,
      );

      // Manually add duplicates (bypassing normal checks)
      h.accounts.add(acc1);
      h.accounts.add(acc2);
      expect(h.length, 2);

      // Save and reload
      await h.saveLegacyWallets();
      final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
      await reloaded.init(onlyV2: true);

      // Should be deduplicated
      expect(reloaded.length, 1,
          reason: 'Should deduplicate on load from storage');
    });

    test('prevents migration from creating duplicates', () async {
      final Uint8List seed = generateUintSeed();
      final CesiumWallet w = CesiumWallet.fromSeed(seed);

      // Set up legacy data (v1 format)
      SharedPreferences.setMockInitialValues(<String, Object>{
        'seed': seedToString(seed),
        'pub': w.pubkey,
      });

      // Initialize - will migrate beta account
      final SharedPreferencesHelper h1 = SharedPreferencesHelper();
      await h1.init(onlyV2: true);
      expect(h1.length, 1);

      // Initialize again - should not duplicate the migrated account
      final SharedPreferencesHelper h2 = SharedPreferencesHelper();
      await h2.init(onlyV2: true);
      expect(h2.length, 1, reason: 'Should not duplicate migrated account');
    });

    test('prevents legacy migration from creating duplicates', () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      final Uint8List seed1 = generateUintSeed();
      final CesiumWallet w1 = CesiumWallet.fromSeed(seed1);

      final Uint8List seed2 = generateUintSeed();
      final CesiumWallet w2 = CesiumWallet.fromSeed(seed2);

      // Add first wallet
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed1), pubKey: w1.pubkey));

      // Try to add duplicate of first wallet
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed1), pubKey: w1.pubkey));

      // Add second unique wallet
      h.addLegacyWallet(
          h.buildLegacyWallet(seed: seedToString(seed2), pubKey: w2.pubkey));

      // Should only have 2 accounts (duplicate prevented)
      expect(h.length, 2,
          reason: 'Should prevent duplicates (expected 2, got ${h.length})');

      // Verify the accounts
      final List<String> pubKeys = h.publicKeys;
      expect(pubKeys.contains(w1.pubkey), true);
      expect(pubKeys.contains(w2.pubkey), true);
    });

    test('no account loss during deduplication', () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      // Create 3 unique accounts
      final List<Uint8List> seeds = <Uint8List>[
        generateUintSeed(),
        generateUintSeed(),
        generateUintSeed(),
      ];

      for (final Uint8List seed in seeds) {
        final CesiumWallet w = CesiumWallet.fromSeed(seed);
        h.addLegacyWallet(
            h.buildLegacyWallet(seed: seedToString(seed), pubKey: w.pubkey));
      }

      expect(h.length, 3, reason: 'Should have 3 unique accounts');

      // Save and reload
      await h.saveLegacyWallets();
      final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
      await reloaded.init(onlyV2: true);

      // All accounts should be preserved
      expect(reloaded.length, 3,
          reason: 'All unique accounts should be preserved after reload');
    });

    test('color theme is preserved for first occurrence when deduplicating',
        () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      final Uint8List seed = generateUintSeed();
      final CesiumWallet w = CesiumWallet.fromSeed(seed);

      // Add first account with specific theme
      final StoredAccount acc1 = StoredAccount(
        pubKey: w.pubkey,
        address: addressFromV1Pubkey(w.pubkey),
        seed: seed,
        type: AccountType.v1PasswordLess,
        contact: Contact.withPubKey(pubKey: w.pubkey, name: 'First'),
        theme: WalletThemes.theme3,
      );

      h.accounts.add(acc1);

      // Manually add duplicate with different theme
      final StoredAccount acc2 = StoredAccount(
        pubKey: w.pubkey,
        address: addressFromV1Pubkey(w.pubkey),
        seed: seed,
        type: AccountType.v1PasswordLess,
        contact: Contact.withPubKey(pubKey: w.pubkey, name: 'Second'),
        theme: WalletThemes.theme5,
      );

      h.accounts.add(acc2);
      await h.saveLegacyWallets();

      // Reload and check
      final SharedPreferencesHelper reloaded = SharedPreferencesHelper();
      await reloaded.init(onlyV2: true);

      expect(reloaded.length, 1);
      final StoredAccount preserved = reloaded.accounts.first;
      // Compare theme by color properties
      expect(preserved.theme.primaryColor, WalletThemes.theme3.primaryColor,
          reason: 'Should preserve theme from first occurrence');
      expect(preserved.contact.name, 'First',
          reason: 'Should preserve name from first occurrence');
    });
  });

  group('manual derivation', () {
    test('deriveNextAccount finds next available index and imports it',
        () async {
      final SharedPreferencesHelper h = SharedPreferencesHelper();
      await h.init(onlyV2: true);
      h.accountsClear();

      const String mnemonic =
          'attitude legend purchase discover canyon panda phone change flavor language often will';

      // Import root
      await h.importWalletFromMnemonic(mnemonic, AccountType.v2PasswordLess);
      expect(h.length, 1);
      final StoredAccount root = h.accounts[0];

      // Derive first (//0)
      await h.deriveNextAccount(root);
      expect(h.length, 2);
      expect(h.accounts[1].derivationPath, '//0');
      expect(h.accounts[1].derivationParentId, root.pubKey);

      // Derive second (//1)
      await h.deriveNextAccount(root);
      expect(h.length, 3);
      expect(h.accounts[2].derivationPath, '//1');

      // Derive from a child (should still find //2)
      await h.deriveNextAccount(h.accounts[1]);
      expect(h.length, 4);
      expect(h.accounts[3].derivationPath, '//2');
    });
  });

  group('pubKey-based current wallet sync', () {
    test('getCurrentAccount returns correct wallet by pubKey', () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));

      final StoredAccount first = helper.accounts[0];
      final StoredAccount second = helper.accounts[1];

      // Select first wallet
      await helper.selectCurrentWallet(first.pubKey);
      expect(helper.getCurrentAccount().pubKey, first.pubKey);

      // Select second wallet
      await helper.selectCurrentWallet(second.pubKey);
      expect(helper.getCurrentAccount().pubKey, second.pubKey);
    });

    test(
        'getCurrentAccount remains correct after wallet list reordering by lastUsed',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      final CesiumWallet w3 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w3.seed), pubKey: w3.pubkey));

      expect(helper.length, 3);

      // Store pubKey of first wallet (for reference)
      final String firstPubKey = helper.accounts[0].pubKey;

      // Select first wallet
      await helper.selectCurrentWallet(firstPubKey);
      expect(helper.getCurrentAccount().pubKey, firstPubKey);

      // Simulate CardStack reordering by lastUsed (as done in card_stack.dart)
      final List<StoredAccount> sorted =
          List<StoredAccount>.from(helper.accounts);
      sorted.sort((StoredAccount a, StoredAccount b) {
        final int aUsed = a.lastUsed ?? 0;
        final int bUsed = b.lastUsed ?? 0;
        return aUsed.compareTo(bUsed);
      });

      // Even though the list would be reordered in UI, getCurrentAccount should still work
      expect(helper.getCurrentAccount().pubKey, firstPubKey,
          reason:
              'getCurrentAccount should still return first wallet even if list is reordered');
    });

    test(
        'selectCurrentWallet updates wallet correctly even after other wallets change lastUsed',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      final CesiumWallet w3 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w3.seed), pubKey: w3.pubkey));

      final String wallet1PubKey = helper.accounts[0].pubKey;
      final String wallet2PubKey = helper.accounts[1].pubKey;
      final String wallet3PubKey = helper.accounts[2].pubKey;

      // Select wallet 1, then wallet 3
      await helper.selectCurrentWallet(wallet1PubKey);
      await helper.selectCurrentWallet(wallet3PubKey);

      expect(helper.getCurrentAccount().pubKey, wallet3PubKey);

      // Now select wallet 2
      await helper.selectCurrentWallet(wallet2PubKey);
      expect(helper.getCurrentAccount().pubKey, wallet2PubKey);

      // Verify wallet 3 is still accessible (lastUsed should have been updated for wallet 2)
      await helper.selectCurrentWallet(wallet3PubKey);
      expect(helper.getCurrentAccount().pubKey, wallet3PubKey);
    });

    test('getCurrentWalletIndex returns correct index for current pubKey',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));

      await helper.selectCurrentWalletIndex(0);
      expect(helper.getCurrentWalletIndex(), 0);

      await helper.selectCurrentWalletIndex(1);
      expect(helper.getCurrentWalletIndex(), 1);

      await helper.selectCurrentWalletIndex(0);
      expect(helper.getCurrentWalletIndex(), 0);
    });

    test('drawer and credit card show same wallet after selectCurrentWallet',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));

      final String wallet2PubKey = helper.accounts[1].pubKey;

      // Simulate selecting a wallet from drawer (calls selectCurrentWallet)
      await helper.selectCurrentWallet(wallet2PubKey);

      // Verify credit card would show the same wallet (getCurrentAccount)
      final StoredAccount creditCardWallet = helper.getCurrentAccount();
      expect(creditCardWallet.pubKey, wallet2PubKey);

      // Simulate CardStack reordering (as would happen in UI)
      final List<StoredAccount> drawerWallets =
          List<StoredAccount>.from(helper.accounts);
      drawerWallets.sort((StoredAccount a, StoredAccount b) {
        final int aUsed = a.lastUsed ?? 0;
        final int bUsed = b.lastUsed ?? 0;
        return aUsed.compareTo(bUsed);
      });

      // The wallet at top of drawer (most recently used) should match credit card
      final StoredAccount mostRecentlyUsed = drawerWallets.last;
      expect(mostRecentlyUsed.pubKey, wallet2PubKey,
          reason:
              'Most recently used wallet in drawer should match credit card');
    });

    test(
        'removeCurrentWallet selects most recently used wallet and maintains sync',
        () async {
      await helper.createDefWalletIfNotExist();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      final CesiumWallet w3 = CesiumWallet.fromSeed(generateUintSeed());

      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w3.seed), pubKey: w3.pubkey));

      expect(helper.length, 3);

      // Set usage order: w1=oldest, w2=middle, w3=most recent
      helper.accounts[0] = helper.accounts[0]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch - 2000);
      helper.accounts[1] = helper.accounts[1]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch - 1000);
      helper.accounts[2] = helper.accounts[2]
          .copyWith(lastUsed: DateTime.now().millisecondsSinceEpoch);

      final String wallet3PubKey = helper.accounts[2].pubKey;

      // Select w1 and remove it
      await helper.selectCurrentWallet(helper.accounts[0].pubKey);
      await helper.removeCurrentWallet();

      // Should have selected w3 (most recently used)
      expect(helper.length, 2);
      expect(helper.getCurrentAccount().pubKey, wallet3PubKey);
    });
  });
}
