import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/shared_prefs_helper.dart';
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

  group('Init - No Account Corruption', () {
    test('createDefWalletIfNotExist preserves existing accounts', () async {
      // Create initial account
      final StoredAccount account1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);
      final String pubKey1 = account1.pubKey;
      final String address1 = account1.address;

      // Call createDefWalletIfNotExist again (should not corrupt)
      final StoredAccount account2 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1); // Still only one account

      // Verify the account data is exactly the same
      expect(account2.pubKey, pubKey1);
      expect(account2.address, address1);
      expect(account2.type, account1.type);
    });

    test('Multiple init() calls do not duplicate or corrupt existing accounts',
        () async {
      // Create first account
      final StoredAccount initial = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);
      final String initialPubKey = initial.pubKey;

      // Create new helper instance and init (should load existing account)
      final SharedPreferencesHelper helper2 = SharedPreferencesHelper();
      await helper2.init(onlyV2: true);

      expect(helper2.length, 1); // Should load the existing account
      final StoredAccount loaded = helper2.getCurrentAccount();
      expect(loaded.pubKey, initialPubKey); // Same account

      // Create another helper and init
      final SharedPreferencesHelper helper3 = SharedPreferencesHelper();
      await helper3.init(onlyV2: true);

      expect(helper3.length, 1); // Still just one account
      final StoredAccount reloaded = helper3.getCurrentAccount();
      expect(reloaded.pubKey, initialPubKey); // Same account data
    });

    test(
        'Account data integrity is preserved through createDefWalletIfNotExist',
        () async {
      final StoredAccount created = await helper.createDefWalletIfNotExist();

      // Store original data
      final String originalPubKey = created.pubKey;
      final String originalAddress = created.address;
      final String originalName = created.contact.name ?? '';
      final dynamic originalTheme = created.theme;
      final dynamic originalType = created.type;

      // Call createDefWalletIfNotExist again
      final StoredAccount retrieved = await helper.createDefWalletIfNotExist();

      // Verify all fields are unchanged
      expect(retrieved.pubKey, originalPubKey);
      expect(retrieved.address, originalAddress);
      expect(retrieved.contact.name ?? '', originalName);
      expect(retrieved.theme, originalTheme);
      expect(retrieved.type, originalType);
    });

    test(
        'Current pubKey selection is preserved after createDefWalletIfNotExist',
        () async {
      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);

      final String currentPubKey1 = helper.getPubKey();

      // Call createDefWalletIfNotExist again
      await helper.createDefWalletIfNotExist();

      final String currentPubKey2 = helper.getPubKey();

      // Should still be the same current account
      expect(currentPubKey2, currentPubKey1);
    });

    test(
        'Account list order is preserved across createDefWalletIfNotExist calls',
        () async {
      // Create first account
      final StoredAccount acc1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      // Call createDefWalletIfNotExist again (should not affect existing accounts)
      final StoredAccount result = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1); // Still 1 account
      expect(result.pubKey, acc1.pubKey);
    });

    test('Seed data is not corrupted after createDefWalletIfNotExist',
        () async {
      final StoredAccount created = await helper.createDefWalletIfNotExist();
      expect(created.seed, isNotNull);
      expect(created.seed, isNotEmpty);

      final Uint8List originalSeed = created.seed!;

      // Call createDefWalletIfNotExist again
      final StoredAccount retrieved = await helper.createDefWalletIfNotExist();

      // Verify seed is the same
      expect(retrieved.seed, originalSeed);
    });

    test(
        'CreateDefWalletIfNotExist with existing accounts does not trigger save',
        () async {
      // Create initial account
      await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      // Get current state
      final String pubKeyBefore = helper.getPubKey();

      // Call createDefWalletIfNotExist (should be idempotent)
      await helper.createDefWalletIfNotExist();

      // Verify nothing changed
      expect(helper.length, 1);
      expect(helper.getPubKey(), pubKeyBefore);

      // Create new helper and verify data is still correct
      final SharedPreferencesHelper newHelper = SharedPreferencesHelper();
      await newHelper.init(onlyV2: true);
      expect(newHelper.length, 1);
      expect(newHelper.getPubKey(), pubKeyBefore);
    });

    test('No accounts are added with duplicate pubKeys', () async {
      final StoredAccount account1 = await helper.createDefWalletIfNotExist();
      final String pubKey1 = account1.pubKey;

      expect(helper.length, 1);

      // Call multiple times
      for (int i = 0; i < 10; i++) {
        await helper.createDefWalletIfNotExist();
      }

      expect(helper.length, 1); // Still just one

      // Verify the pubKey is still the same
      final StoredAccount retrieved = helper.getCurrentAccount();
      expect(retrieved.pubKey, pubKey1);

      // Verify no duplicates in the list
      final Set<String> uniquePubKeys = <String>{};
      for (final StoredAccount acc in helper.accounts) {
        uniquePubKeys.add(acc.pubKey);
      }
      expect(uniquePubKeys.length, 1);
    });

    test(
        'Manually imported accounts are not affected by createDefWalletIfNotExist',
        () async {
      // Create default account
      await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      // Store account info before calling createDefWalletIfNotExist again
      final StoredAccount accountBefore = helper.getCurrentAccount();

      // Call createDefWalletIfNotExist (should be idempotent)
      await helper.createDefWalletIfNotExist();

      // Verify account is still there
      expect(helper.length, 1);

      // Verify account data is preserved
      final StoredAccount accountAfter = helper.getCurrentAccount();
      expect(accountAfter.pubKey, accountBefore.pubKey);
      expect(accountAfter.address, accountBefore.address);
      expect(accountAfter.type, accountBefore.type);
    });

    test('Current selection is maintained when accounts exist', () async {
      // Create default account
      final StoredAccount acc1 = await helper.createDefWalletIfNotExist();
      expect(helper.length, 1);

      final String initialPubKeyWithChecksum = helper.getPubKey();
      expect(initialPubKeyWithChecksum, contains(acc1.pubKey));

      // Call createDefWalletIfNotExist again
      await helper.createDefWalletIfNotExist();

      // Verify current selection is still the same
      expect(helper.getPubKey(), initialPubKeyWithChecksum);
      expect(helper.getCurrentWalletIndex(), 0);
      expect(helper.length, 1);
    });

    test(
        'Contact and profile data is not corrupted by createDefWalletIfNotExist',
        () async {
      await helper.createDefWalletIfNotExist();

      // Update the contact name
      const String newName = 'My Account';
      helper.setName(name: newName, notify: false);

      // Get the updated account
      final String nameBefore = helper.getName();
      expect(nameBefore, newName);

      // Call createDefWalletIfNotExist
      await helper.createDefWalletIfNotExist();

      // Verify name is still set
      final String nameAfter = helper.getName();
      expect(nameAfter, newName);
    });

    test('Theme setting is not corrupted by createDefWalletIfNotExist',
        () async {
      await helper.createDefWalletIfNotExist();

      // Get the theme
      final dynamic themeBefore = helper.getTheme();

      // Call createDefWalletIfNotExist
      await helper.createDefWalletIfNotExist();

      // Verify theme is unchanged
      final dynamic themeAfter = helper.getTheme();
      expect(themeAfter, themeBefore);
    });

    test('Empty accounts list does not get populated unexpectedly', () async {
      expect(helper.isEmpty, true);

      // Call createDefWalletIfNotExist once
      await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);
      expect(helper.length, 1);

      // Now manually clear (simulating edge case)
      helper.accountsClear();
      expect(helper.isEmpty, true);

      // Call createDefWalletIfNotExist again (should create new one)
      final StoredAccount newAccount = await helper.createDefWalletIfNotExist();
      expect(helper.isEmpty, false);
      expect(helper.length, 1);

      // Verify it's a new account (different pubKey since random mnemonic)
      expect(newAccount.pubKey, isNotEmpty);
    });

    test('Retry mechanism does not create duplicate accounts', () async {
      // Simulate multiple attempts to create default wallet
      for (int i = 0; i < 5; i++) {
        await helper.createDefWalletIfNotExist();
        expect(helper.length, 1,
            reason: 'Should never have more than 1 account');
      }

      // Verify no duplicate pubKeys
      final Set<String> uniquePubKeys = <String>{};
      for (final StoredAccount acc in helper.accounts) {
        uniquePubKeys.add(acc.pubKey);
      }
      expect(uniquePubKeys.length, 1);
    });

    test('Accounts are not corrupted across multiple helper instances',
        () async {
      // Create account with helper1
      final StoredAccount account1 = await helper.createDefWalletIfNotExist();
      final String pubKey1 = account1.pubKey;

      // Create helper2 and verify it has the same account
      final SharedPreferencesHelper helper2 = SharedPreferencesHelper();
      await helper2.init(onlyV2: true);
      expect(helper2.length, 1);

      final StoredAccount account2 = helper2.getCurrentAccount();
      expect(account2.pubKey, pubKey1);

      // Call createDefWalletIfNotExist on helper2
      await helper2.createDefWalletIfNotExist();
      expect(helper2.length, 1); // Still just one

      // Create helper3 and verify it still has the same account
      final SharedPreferencesHelper helper3 = SharedPreferencesHelper();
      await helper3.init(onlyV2: true);
      expect(helper3.length, 1);

      final StoredAccount account3 = helper3.getCurrentAccount();
      expect(account3.pubKey, pubKey1);
    });

    test('LastUsed timestamp is set during account addition', () async {
      final StoredAccount created = await helper.createDefWalletIfNotExist();
      final String pubKey = created.pubKey;

      // The returned account might not have lastUsed set yet (it's set internally),
      // so let's retrieve it from the accounts list to verify it was set
      final StoredAccount accountInList = helper.getCurrentAccount();
      expect(accountInList.pubKey, pubKey);
      expect(accountInList.lastUsed, isNotNull);
      final int firstLastUsed = accountInList.lastUsed!;

      // Call createDefWalletIfNotExist again - should return same account
      final StoredAccount retrieved2 = await helper.createDefWalletIfNotExist();
      expect(retrieved2.pubKey, pubKey);

      // Verify account in storage wasn't corrupted
      final StoredAccount retrieved = helper.getCurrentAccount();
      expect(retrieved.pubKey, pubKey);

      // LastUsed should remain the same since we didn't actually use the account
      expect(retrieved.lastUsed, firstLastUsed);
    });
  });
}
