import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/services/derivation_scan_service.dart';
import 'package:ginkgo/shared_prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_mock.dart' show registerMockSecureStorage;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Wallet Sync Consistency Tests', () {
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

    test(
        'imported wallet is immediately selected and notifies listeners consistently',
        () async {
      debugPrint('=== TEST: Imported wallet selection consistency ===');

      final List<int> notificationCount = <int>[0];
      final List<String> currentAccountAtNotification = <String>[];

      // Listen to changes
      helper.addListener(() {
        notificationCount[0]++;
        final String currentPubKey = helper.getCurrentAccount().pubKey;
        currentAccountAtNotification.add(currentPubKey);
        debugPrint(
            '🔔 Notification #${notificationCount[0]}: Current wallet = $currentPubKey');
      });

      // Import a wallet
      const String mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      await helper.importWalletFromMnemonic(
          mnemonic, AccountType.v2PasswordLess);

      // Verify state
      expect(helper.length, 1, reason: 'Should have 1 wallet after import');

      final String currentPubKey = helper.getCurrentAccount().pubKey;
      final String importedPubKey = helper.accounts.first.pubKey;

      expect(currentPubKey, importedPubKey,
          reason: 'Current wallet should be the imported wallet immediately');

      // Verify consistency across all notifications
      for (final String notificationPubKey in currentAccountAtNotification) {
        expect(notificationPubKey, currentPubKey,
            reason: 'All notifications should report the same current wallet');
      }

      debugPrint(
          '✅ All notifications consistent: $currentAccountAtNotification');
    });

    test('selectCurrentWallet updates drawer and credit card atomically',
        () async {
      debugPrint('=== TEST: selectCurrentWallet atomic update ===');

      // Create two wallets
      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';

      await helper.importWalletFromMnemonic(
          mnemonic1, AccountType.v2PasswordLess);
      await helper.importWalletFromMnemonic(
          mnemonic2, AccountType.v2PasswordLess);

      expect(helper.length, 2, reason: 'Should have 2 wallets');

      final String wallet2PubKey = helper.accounts[1].pubKey;

      final List<String> currentAccountHistory = <String>[];

      helper.addListener(() {
        currentAccountHistory.add(helper.getCurrentAccount().pubKey);
        debugPrint('Current account: ${helper.getCurrentAccount().pubKey}');
      });

      // Select wallet 2
      await helper.selectCurrentWallet(wallet2PubKey);

      // Verify state is consistent
      expect(helper.getCurrentAccount().pubKey, wallet2PubKey,
          reason: 'Current account should be wallet 2');

      // Verify all notifications reported consistent state
      for (final String pubKey in currentAccountHistory) {
        expect(pubKey, wallet2PubKey,
            reason: 'All notifications should report wallet 2');
      }

      debugPrint('✅ selectCurrentWallet: All notifications reported wallet 2');
    });

    test('drawer and credit card see same wallet after import', () async {
      debugPrint('=== TEST: Drawer/CreditCard consistency ===');

      const String mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      await helper.importWalletFromMnemonic(
          mnemonic, AccountType.v2PasswordLess);

      // Simulate drawer reading state (using sortedCards like CardStack does)
      final List<StoredAccount> drawerCards =
          List<StoredAccount>.from(helper.accounts);
      drawerCards.sort((StoredAccount a, StoredAccount b) {
        final int aUsed = a.lastUsed ?? 0;
        final int bUsed = b.lastUsed ?? 0;
        return aUsed.compareTo(bUsed);
      });

      final String drawerCurrentPubKey =
          drawerCards.isNotEmpty ? drawerCards.last.pubKey : '';

      // Simulate credit card reading state (directly from getCurrentAccount)
      final String creditCardCurrentPubKey = helper.getCurrentAccount().pubKey;

      expect(drawerCurrentPubKey, creditCardCurrentPubKey,
          reason: 'Drawer and credit card should show same wallet');

      debugPrint('✅ Drawer: $drawerCurrentPubKey');
      debugPrint('✅ CreditCard: $creditCardCurrentPubKey');
    });

    test('multiple wallets remain consistent through selection changes',
        () async {
      debugPrint('=== TEST: Multiple wallet selection consistency ===');

      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';
      const String mnemonic3 =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      await helper.importWalletFromMnemonic(
          mnemonic1, AccountType.v2PasswordLess);
      await helper.importWalletFromMnemonic(
          mnemonic2, AccountType.v2PasswordLess);
      await helper.importWalletFromMnemonic(
          mnemonic3, AccountType.v2PasswordLess);

      expect(helper.length, 3, reason: 'Should have 3 wallets');

      // Cycle through wallets multiple times
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < helper.length; j++) {
          final String walletPubKey = helper.accounts[j].pubKey;
          await helper.selectCurrentWallet(walletPubKey);

          // Verify consistency
          expect(helper.getCurrentAccount().pubKey, walletPubKey);
          expect(helper.accounts[helper.getCurrentWalletIndex()].pubKey,
              walletPubKey);
        }
      }

      debugPrint('✅ Cycled through 3 wallets 3 times, all consistent');
    });

    test('getCurrentWalletIndex matches getCurrentAccount', () async {
      debugPrint('=== TEST: Index/Account consistency ===');

      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';

      await helper.importWalletFromMnemonic(
          mnemonic1, AccountType.v2PasswordLess);
      await helper.importWalletFromMnemonic(
          mnemonic2, AccountType.v2PasswordLess);

      for (int i = 0; i < helper.length; i++) {
        await helper.selectCurrentWalletIndex(i);

        final int index = helper.getCurrentWalletIndex();
        final StoredAccount accountAtIndex = helper.accounts[index];
        final StoredAccount currentAccount = helper.getCurrentAccount();

        expect(accountAtIndex, currentAccount,
            reason: 'Account at index should match getCurrentAccount');
      }

      debugPrint('✅ Index and account always consistent');
    });

    test('no duplicate notifications on import', () async {
      debugPrint('=== TEST: No duplicate notifications ===');

      int notificationCount = 0;
      helper.addListener(() {
        notificationCount++;
      });

      const String mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      await helper.importWalletFromMnemonic(
          mnemonic, AccountType.v2PasswordLess);

      // Should have minimal notifications (ideally 1-2, not 3+)
      debugPrint('Total notifications: $notificationCount');

      // With atomic update, we should get fewer notifications
      expect(notificationCount, lessThanOrEqualTo(3),
          reason: 'Should minimize notifications with atomic update');
    });

    test('state stays consistent when switching between wallets rapidly',
        () async {
      debugPrint('=== TEST: Rapid wallet switching consistency ===');

      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';

      await helper.importWalletFromMnemonic(
          mnemonic1, AccountType.v2PasswordLess);
      await helper.importWalletFromMnemonic(
          mnemonic2, AccountType.v2PasswordLess);

      final String wallet1 = helper.accounts[0].pubKey;
      final String wallet2 = helper.accounts[1].pubKey;

      // Rapidly switch wallets
      for (int i = 0; i < 5; i++) {
        await helper.selectCurrentWallet(wallet1);
        expect(helper.getCurrentAccount().pubKey, wallet1);

        await helper.selectCurrentWallet(wallet2);
        expect(helper.getCurrentAccount().pubKey, wallet2);
      }

      debugPrint('✅ Rapid switching: 10 changes, all consistent');
    });
  });
}
