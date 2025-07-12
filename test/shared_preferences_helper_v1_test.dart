import 'package:durt/durt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/wallet_themes.dart';
import 'package:ginkgo/g1/g1_helper.dart';
import 'package:ginkgo/shared_prefs_helper.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesHelper helper;

  setUp(() async {
    SharedPreferencesHelper.configure(useV2: false);
    SharedPreferences.setMockInitialValues(<String, Object>{});
    helper = SharedPreferencesHelper();
    await helper.init();
    helper.cards.clear();
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
      await helper.init();
      expect(helper.cards.length, 1);
      expect(prefs.containsKey('seed'), false);
      expect(prefs.containsKey('pub'), false);
      expect(helper.getCurrentWalletIndex(), 0);
    });
  });

  group('automatic wallet creation', () {
    test('getWallet creates and persists a wallet when none exist', () async {
      expect(helper.cards.isEmpty, true);
      final CesiumWallet w = await helper.getLegacyWallet();
      expect(w.pubkey.isNotEmpty, true);
      expect(helper.cards.length, 1);
    });
  });

  group('wallet persistence and retrieval', () {
    test('addLegacyWallet is durable across helper instances', () async {
      await helper.getLegacyWallet(); // ensure 1st wallet
      final CesiumWallet w1 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w1.seed), pubKey: w1.pubkey));

      final SharedPreferencesHelper other = SharedPreferencesHelper();
      await other.init();
      expect(other.cards.length, 2);
      expect(other.cards.last.pubKey, w1.pubkey);
    });

    test('removeLegacyWallet refuses to delete the last wallet', () async {
      await helper.getLegacyWallet();
      final int before = helper.cards.length;
      expect(before, 1);
      helper.removeCurrentWallet();
      expect(helper.cards.length, before);
    });

    test('removeLegacyWallet removes when more than one wallet exists',
        () async {
      await helper.getLegacyWallet();
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      final int before = helper.cards.length;
      expect(before, 2);
      helper.removeCurrentWallet();
      expect(helper.cards.length, before - 1);
    });
  });

  group('current index control', () {
    test('setCurrentWalletIndex persists value', () async {
      await helper.getLegacyWallet();
      await helper.setCurrentWalletIndex(0);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('current_wallet_index'), 0);
    });

    test('selectCurrentWalletIndex throws on invalid index', () async {
      await expectLater(helper.selectCurrentWalletIndex(99), throwsException);
    });
  });

  group('naming and theming', () {
    test('setName and getName round-trip', () async {
      await helper.getLegacyWallet();
      helper.setName(name: 'alice');
      expect(helper.getName(), 'alice');
    });

    test('setTheme and getTheme round-trip', () async {
      await helper.getLegacyWallet();
      helper.setTheme(theme: WalletThemes.theme2);
      expect(helper.getTheme(), WalletThemes.theme2);
    });
  });

  group('lookup helpers', () {
    test('has and hasMultipleWallets reflect state', () async {
      await helper.getLegacyWallet();
      expect(helper.hasMultipleWallets(), false);
      final CesiumWallet w2 = CesiumWallet.fromSeed(generateUintSeed());
      helper.addLegacyWallet(helper.buildLegacyWallet(
          seed: seedToString(w2.seed), pubKey: w2.pubkey));
      expect(helper.has(w2.pubkey), true);
      expect(helper.hasMultipleWallets(), true);
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
      final CesiumWallet w = await helper.getLegacyWallet();
      final KeyPair keyPair = await helper.getKeyPair();
      expect(Base58Encode(keyPair.publicKey.bytes), w.pubkey);
    });

    test('isPasswordLessWallet detects seed presence', () async {
      await helper.getLegacyWallet();
      expect(helper.isPasswordLessWallet(), true);
    });
  });

  group('pubkey presentation', () {
    test('getPubKey appends checksum', () async {
      final CesiumWallet w = await helper.getLegacyWallet();
      final String pkWithChecksum = helper.getPubKey();
      final List<String> parts = pkWithChecksum.split(':');
      expect(parts.length, 2);
      expect(parts.first, w.pubkey);
      expect(parts.last.length, greaterThan(0));
    });
  });
}
