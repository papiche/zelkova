import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/stored_account.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';
import 'package:zelkova/services/derivation_scan_service.dart';
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:zelkova/wallet_already_exists_exception.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_mock.dart' show registerMockSecureStorage;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Wallet Import from Mnemonic', () {
    setUp(() async {
      // Enable testing mode to skip network checks
      DerivationScanService.skipNetworkCheck = true;

      // Register mock secure storage and preferences
      registerMockSecureStorage();
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await SharedPreferencesHelper().init(onlyV2: true);
      SharedPreferencesHelper.configure(useV2: true);
    });

    test('Valid mnemonic can be imported successfully', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      // Verify wallet was imported
      expect(helper.accounts, isNotEmpty,
          reason: 'Should have at least one account');
    });

    test('Imported wallet has expected account type', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      const AccountType expectedType = AccountType.v2PasswordLess;

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        expectedType,
      );

      expect(helper.accounts.first.type, equals(expectedType),
          reason: 'Imported account should have correct type');
    });

    test('Same mnemonic imported twice raises WalletAlreadyExistsException',
        () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();

      // Import first time
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      // Try to import same mnemonic again
      expect(
        () => helper.importWalletFromMnemonic(
          testMnemonic,
          AccountType.v2PasswordLess,
        ),
        throwsA(isA<WalletAlreadyExistsException>()),
        reason: 'Should throw WalletAlreadyExistsException for duplicate',
      );
    });

    test('Imported wallet has expected account type', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      const AccountType expectedType = AccountType.v2PasswordLess;

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        expectedType,
      );

      expect(helper.accounts.first.type, equals(expectedType),
          reason: 'Imported account should have correct type');
    });

    test('Same mnemonic imported twice raises WalletAlreadyExistsException',
        () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();

      // Import first time
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      // Try to import same mnemonic again
      expect(
        () => helper.importWalletFromMnemonic(
          testMnemonic,
          AccountType.v2PasswordLess,
        ),
        throwsA(isA<WalletAlreadyExistsException>()),
        reason: 'Should throw WalletAlreadyExistsException for duplicate',
      );
    });

    test('Mnemonic generates deterministic public key', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      // Generate pubkey twice from same mnemonic
      final KeyPair kp1 = await deriveKeyPairCompat(testMnemonic);
      final KeyPair kp2 = await deriveKeyPairCompat(testMnemonic);

      expect(kp1.address, equals(kp2.address),
          reason: 'Same mnemonic should generate same address');
    });

    test('Different mnemonics generate different public keys', () async {
      const String mnemonic1 =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      const String mnemonic2 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

      final KeyPair kp1 = await deriveKeyPairCompat(mnemonic1);
      final KeyPair kp2 = await deriveKeyPairCompat(mnemonic2);

      expect(kp1.address, isNot(equals(kp2.address)),
          reason: 'Different mnemonics should generate different keys');
    });

    test('Imported account can be retrieved', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      expect(helper.accounts, isNotEmpty);

      final StoredAccount account = helper.accounts.first;
      expect(account.address, isNotEmpty,
          reason: 'Account should have a valid address');
    });

    test('Multiple different mnemonics can be imported', () async {
      const String mnemonic1 =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      const String mnemonic2 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        mnemonic1,
        AccountType.v2PasswordLess,
      );

      await helper.importWalletFromMnemonic(
        mnemonic2,
        AccountType.v2PasswordLess,
      );

      expect(helper.accounts.length, equals(2),
          reason: 'Should have two different accounts');

      // Verify they have different addresses
      expect(
          helper.accounts[0].address, isNot(equals(helper.accounts[1].address)),
          reason: 'Different mnemonics should have different addresses');
    });

    test('Imported wallet has non-empty address', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      expect(helper.accounts.first.address, isNotEmpty,
          reason: 'Imported account must have a valid address');
      expect(helper.accounts.first.address.length, greaterThan(0),
          reason: 'Address should not be empty string');
    });

    test('Imported wallet can be set as current account', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      // Set the first account as current by index
      final int accountIndex = helper.accounts.indexOf(helper.accounts.first);
      await helper.selectCurrentWalletIndex(accountIndex);

      final StoredAccount currentAccount = helper.getCurrentAccount();
      expect(currentAccount.address, equals(helper.accounts.first.address),
          reason: 'Current account should match the imported account');
    });

    test('Multiple different mnemonics can be imported together', () async {
      const String mnemonic1 =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      const String mnemonic2 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        mnemonic1,
        AccountType.v2PasswordLess,
      );

      await helper.importWalletFromMnemonic(
        mnemonic2,
        AccountType.v2PasswordLess,
      );

      expect(helper.accounts.length, equals(2),
          reason: 'Should have two different accounts');

      // Verify they have different addresses
      expect(
          helper.accounts[0].address, isNot(equals(helper.accounts[1].address)),
          reason: 'Different mnemonics should have different addresses');
    });

    test('Imported wallet has non-empty v2 address', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      expect(helper.accounts.first.address, isNotEmpty,
          reason: 'Imported account must have a valid address');
      expect(helper.accounts.first.address.length, greaterThan(0),
          reason: 'Address should not be empty string');
      expect(helper.accounts.first.address.startsWith('g1'), isTrue,
          reason: 'V2 address should start with g1');
    });

    test('Imported v2 wallet can be set as current account', () async {
      const String testMnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      final SharedPreferencesHelper helper = SharedPreferencesHelper();
      await helper.importWalletFromMnemonic(
        testMnemonic,
        AccountType.v2PasswordLess,
      );

      // Set the first account as current by index
      final int accountIndex = helper.accounts.indexOf(helper.accounts.first);
      await helper.selectCurrentWalletIndex(accountIndex);

      final StoredAccount currentAccount = helper.getCurrentAccount();
      expect(currentAccount.address, equals(helper.accounts.first.address),
          reason: 'Current account should match the imported account');
    });
  });
}
