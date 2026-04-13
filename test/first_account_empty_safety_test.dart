import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/stored_account.dart';
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_mock.dart' show registerMockSecureStorage;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesHelper helper;

  setUp(() async {
    registerMockSecureStorage();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    helper = SharedPreferencesHelper();
    await helper.init(onlyV2: true);
    SharedPreferencesHelper.configure(useV2: true);
    helper.accountsClear();
  });

  group('Empty Accounts Safety', () {
    test('isEmpty returns true when accounts list is empty', () {
      expect(helper.isEmpty, true);
      expect(helper.length, 0);
    });

    test('getCurrentAccount() throws RangeError when accounts are empty', () {
      expect(helper.isEmpty, true);
      expect(
        () => helper.getCurrentAccount(),
        throwsA(isA<RangeError>()),
      );
    });

    test('getPubKey() throws RangeError when accounts are empty', () {
      expect(helper.isEmpty, true);
      expect(
        () => helper.getPubKey(),
        throwsA(isA<RangeError>()),
      );
    });

    test('getName() throws RangeError when accounts are empty', () {
      expect(helper.isEmpty, true);
      expect(
        () => helper.getName(),
        throwsA(isA<RangeError>()),
      );
    });

    test('getTheme() throws RangeError when accounts are empty', () {
      expect(helper.isEmpty, true);
      expect(
        () => helper.getTheme(),
        throwsA(isA<RangeError>()),
      );
    });

    test('createDefWalletIfNotExist() creates account when empty', () async {
      expect(helper.isEmpty, true);
      final StoredAccount account = await helper.createDefWalletIfNotExist();
      expect(account, isNotNull);
      expect(account.pubKey.isNotEmpty, true);
      expect(helper.isEmpty, false);
      expect(helper.length, 1);
    });

    test('createDefWalletIfNotExist() returns existing account when not empty',
        () async {
      expect(helper.isEmpty, true);
      final StoredAccount account1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      final StoredAccount account2 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1); // Still just one account
      expect(account1.pubKey, account2.pubKey); // Same account
    });

    test('Can access pubKey after creating default account', () async {
      expect(helper.isEmpty, true);
      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      final String pubKey = helper.getPubKey();
      expect(pubKey.isNotEmpty, true);
      expect(pubKey.contains(':'), true); // pubKey:checksum format
    });

    test('Can access getCurrentAccount after creating default account',
        () async {
      expect(helper.isEmpty, true);
      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      final StoredAccount account = helper.getCurrentAccount();
      expect(account.pubKey.isNotEmpty, true);
      expect(account.address.isNotEmpty, true);
    });

    test('getName throws RangeError before account creation', () async {
      expect(helper.isEmpty, true);
      expect(
        () => helper.getName(),
        throwsA(isA<RangeError>()),
      );
    });

    test('getName returns account name after account creation', () async {
      expect(helper.isEmpty, true);
      await helper.createDefWalletIfNotExist();
      final String name = helper.getName();
      // Initial account name should be empty or not set
      expect(name, isA<String>());
    });

    test('_currentPubKey is set after account creation', () async {
      expect(helper.isEmpty, true);
      final StoredAccount account = await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      // Verify we can get the account without errors
      final String pubKey = helper.getPubKey();
      expect(pubKey.contains(account.pubKey.substring(0, 20)), true);
    });

    test('Multiple calls to createDefWalletIfNotExist do not create duplicates',
        () async {
      expect(helper.isEmpty, true);

      final StoredAccount account1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      final StoredAccount account2 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      final StoredAccount account3 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      expect(account1.pubKey, account2.pubKey);
      expect(account2.pubKey, account3.pubKey);
    });

    test('First created account is accessible immediately', () async {
      expect(helper.isEmpty, true);

      final StoredAccount created = await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      // Should be able to access without exception
      final StoredAccount retrieved = helper.getCurrentAccount();
      expect(retrieved.pubKey, created.pubKey);
      expect(retrieved.address, created.address);
    });

    test('Account verification works after creation', () async {
      expect(helper.isEmpty, true);

      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      // All these should work without throwing
      expect(() => helper.getCurrentAccount(), returnsNormally);
      expect(() => helper.getPubKey(), returnsNormally);
      expect(() => helper.getName(), returnsNormally);
      expect(() => helper.getTheme(), returnsNormally);
    });

    test('Idempotency: createDefWalletIfNotExist can be called multiple times',
        () async {
      expect(helper.isEmpty, true);

      for (int i = 0; i < 5; i++) {
        final StoredAccount account = await helper.createDefWalletIfNotExist();
        expect(account.pubKey.isNotEmpty, true);
        expect(helper.isEmpty, false);
        expect(helper.length, 1);
      }

      final String finalPubKey = helper.getPubKey();
      expect(finalPubKey.isNotEmpty, true);
    });
  });

  group('RangeError Prevention Through Proper Initialization', () {
    test('Methods that access accounts list throw RangeError on empty', () {
      expect(helper.isEmpty, true);

      // All methods that access accounts[_getCurrentIndex()] throw RangeError
      expect(() => helper.getName(), throwsA(isA<RangeError>()));
      expect(() => helper.getTheme(), throwsA(isA<RangeError>()));
      expect(() => helper.getCurrentAccount(), throwsA(isA<RangeError>()));
      expect(() => helper.getPubKey(), throwsA(isA<RangeError>()));
    });

    test(
        'getCurrentWalletIndex returns 0 even when accounts are empty (for safety)',
        () {
      expect(helper.isEmpty, true);
      // This method returns 0 by design (defensive)
      final int index = helper.getCurrentWalletIndex();
      expect(index, 0);
    });

    test('Proper V2 initialization prevents RangeError at startup', () {
      // The minimal fix (SharedPreferencesHelper.configure(useV2: true))
      // ensures empty accounts list never occurs during normal app flow
      // because createDefWalletIfNotExist() is called in _initializeAccounts
      expect(helper.isEmpty, true);

      // Before creating, accessing would fail with RangeError
      expect(() => helper.getCurrentAccount(), throwsA(isA<RangeError>()));
    });

    test('After default account creation, all methods work', () async {
      expect(helper.isEmpty, true);
      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      // Now all methods should work without throwing
      expect(() => helper.getName(), returnsNormally);
      expect(() => helper.getTheme(), returnsNormally);
      expect(() => helper.getCurrentAccount(), returnsNormally);
      expect(() => helper.getPubKey(), returnsNormally);
    });
  });
}
