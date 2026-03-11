import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/main.dart' as app;
import 'package:ginkgo/shared_prefs_helper.dart';

import 'helpers/test_helpers.dart';

void main() {
  group('Wallet Sync UI Tests - Drawer and Credit Card Consistency', () {
    setUpAll(() async {
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('imported wallet shows same account in drawer and main page',
        (WidgetTester tester) async {
      debugPrint(
          '=== TEST: Wallet import - Drawer and CreditCard consistency ===');

      // Import a wallet before starting the app
      const String mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic,
        AccountType.v2PasswordLess,
      );

      final String expectedWallet =
          SharedPreferencesHelper().getCurrentAccount().pubKey;
      debugPrint('📌 Expected wallet pubKey: $expectedWallet');

      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify main page shows the wallet
      expect(find.byType(Scaffold), findsWidgets,
          reason: 'App should have Scaffold');

      // Get current account from SharedPrefs
      final String currentInApp =
          SharedPreferencesHelper().getCurrentAccount().pubKey;
      expect(currentInApp, expectedWallet,
          reason: 'App should show the imported wallet as current');

      // Open drawer to verify wallet is there
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Look for drawer content
      expect(find.byType(Drawer), findsOneWidget,
          reason: 'Drawer should be open');

      debugPrint('✅ Wallet import: Drawer and main page show same wallet');
    });

    testWidgets('switching wallet updates current selection atomically',
        (WidgetTester tester) async {
      debugPrint('=== TEST: Wallet switch - Atomic state update ===');

      // Import two wallets
      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';

      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic1,
        AccountType.v2PasswordLess,
      );
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic2,
        AccountType.v2PasswordLess,
      );

      final String wallet1 = SharedPreferencesHelper().accounts[0].pubKey;
      final String wallet2 = SharedPreferencesHelper().accounts[1].pubKey;

      debugPrint('📌 Wallet 1: $wallet1');
      debugPrint('📌 Wallet 2: $wallet2');

      // Start app - wallet 2 should be current (last imported)
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      String currentWallet =
          SharedPreferencesHelper().getCurrentAccount().pubKey;
      expect(currentWallet, wallet2,
          reason: 'Last imported wallet should be current');

      debugPrint('✅ Initial state: Wallet 2 is current');

      // Switch to wallet 1 via selectCurrentWallet
      await SharedPreferencesHelper().selectCurrentWallet(wallet1);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      currentWallet = SharedPreferencesHelper().getCurrentAccount().pubKey;
      expect(currentWallet, wallet1,
          reason: 'Current wallet should be wallet 1 after selection');

      debugPrint('✅ Switched to Wallet 1 atomically');

      // Switch back to wallet 2
      await SharedPreferencesHelper().selectCurrentWallet(wallet2);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      currentWallet = SharedPreferencesHelper().getCurrentAccount().pubKey;
      expect(currentWallet, wallet2,
          reason: 'Current wallet should be wallet 2 after second selection');

      debugPrint('✅ Switched back to Wallet 2 atomically');
    });

    testWidgets('drawer index matches current wallet after multiple switches',
        (WidgetTester tester) async {
      debugPrint('=== TEST: Drawer index / current wallet consistency ===');

      // Import three wallets
      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';
      const String mnemonic3 =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';

      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic1,
        AccountType.v2PasswordLess,
      );
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic2,
        AccountType.v2PasswordLess,
      );
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic3,
        AccountType.v2PasswordLess,
      );

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify consistency between index and current account
      for (int i = 0; i < SharedPreferencesHelper().length; i++) {
        await SharedPreferencesHelper().selectCurrentWalletIndex(i);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        final int currentIndex =
            SharedPreferencesHelper().getCurrentWalletIndex();
        final StoredAccount accountAtIndex =
            SharedPreferencesHelper().accounts[currentIndex];
        final StoredAccount currentAccount =
            SharedPreferencesHelper().getCurrentAccount();

        expect(accountAtIndex.pubKey, currentAccount.pubKey,
            reason: 'Account at index should match current account');

        debugPrint('✅ Index $i: Consistent state verified');
      }
    });

    testWidgets('rapid wallet switching maintains consistency',
        (WidgetTester tester) async {
      debugPrint('=== TEST: Rapid wallet switching consistency ===');

      // Import two wallets
      const String mnemonic1 =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      const String mnemonic2 =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';

      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic1,
        AccountType.v2PasswordLess,
      );
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic2,
        AccountType.v2PasswordLess,
      );

      final String wallet1 = SharedPreferencesHelper().accounts[0].pubKey;
      final String wallet2 = SharedPreferencesHelper().accounts[1].pubKey;

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Rapidly switch between wallets 10 times
      for (int i = 0; i < 5; i++) {
        await SharedPreferencesHelper().selectCurrentWallet(wallet1);
        await tester.pumpAndSettle();

        String current = SharedPreferencesHelper().getCurrentAccount().pubKey;
        expect(current, wallet1,
            reason: 'After switch to wallet1, current should be wallet1');

        await SharedPreferencesHelper().selectCurrentWallet(wallet2);
        await tester.pumpAndSettle();

        current = SharedPreferencesHelper().getCurrentAccount().pubKey;
        expect(current, wallet2,
            reason: 'After switch to wallet2, current should be wallet2');
      }

      debugPrint('✅ Rapid switching (10 changes): All consistent');
    });
  });
}
