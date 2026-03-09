import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/crypto/cesium_wallet.dart';
import 'package:ginkgo/g1/g1_export_auth_utils.dart';

void main() {
  group('CesiumWallet', () {
    test('Create wallet from salt and password', () {
      const String salt = 'testuser';
      const String password = 'testpass';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      expect(wallet.pubkey, isNotEmpty);
      expect(wallet.pubkey.length, equals(44)); // Base58 encoded key length
      expect(wallet.seed, isNotEmpty);
      expect(wallet.seed.length, equals(32)); // Scrypt output length
    });

    test('Create wallet from seed', () {
      final List<int> seedList = List.generate(32, (i) => i);
      final wallet1 =
          CesiumWallet.fromSeed(Uint8List.fromList(List<int>.from(seedList)));

      final wallet2 =
          CesiumWallet.fromSeed(Uint8List.fromList(List<int>.from(seedList)));

      expect(wallet1.pubkey, equals(wallet2.pubkey));
      expect(wallet1.seed, equals(wallet2.seed));
    });

    test('Same salt and password produce consistent pubkeys', () {
      const String salt = 'alice';
      const String password = 'alicepass';

      final CesiumWallet wallet1 = CesiumWallet(salt, password);
      final CesiumWallet wallet2 = CesiumWallet(salt, password);

      expect(wallet1.pubkey, equals(wallet2.pubkey));
      expect(wallet1.seed, equals(wallet2.seed));
    });

    test('Different passwords produce different pubkeys', () {
      const String salt = 'testuser';
      final CesiumWallet wallet1 = CesiumWallet(salt, 'password1');
      final CesiumWallet wallet2 = CesiumWallet(salt, 'password2');

      expect(wallet1.pubkey, isNot(equals(wallet2.pubkey)));
    });

    test('Different salts produce different pubkeys', () {
      const String password = 'testpass';
      final CesiumWallet wallet1 = CesiumWallet('user1', password);
      final CesiumWallet wallet2 = CesiumWallet('user2', password);

      expect(wallet1.pubkey, isNot(equals(wallet2.pubkey)));
    });

    test('Sign and verify document', () {
      const String salt = 'testuser';
      const String password = 'testpass';
      const String document = 'This is a test document';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String signature = wallet.sign(document);

      expect(signature, isNotEmpty);
      expect(wallet.verifySign(document, signature), isTrue);
    });

    test('Signature verification fails for modified document', () {
      const String salt = 'testuser';
      const String password = 'testpass';
      final String document = 'Original document';
      final String modifiedDocument = 'Modified document';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String signature = wallet.sign(document);

      expect(wallet.verifySign(modifiedDocument, signature), isFalse);
    });
  });

  group('CesiumWallet with special characters (em-dash —)', () {
    test('Create wallet with em-dash in secret phrase', () {
      const String secret = 'test—password';
      const String password = 'normal';

      final CesiumWallet wallet = CesiumWallet(secret, password);

      // Validate that a public key is generated
      expect(wallet.pubkey, isNotEmpty);
      expect(wallet.pubkey.length, equals(44)); // Base58 encoded key length

      // FIXED: Em-dash (—, U+2014) is different from hyphen (-, U+002D)
      // They must produce different public keys to maintain security
      final CesiumWallet walletWithHyphen =
          CesiumWallet('test-password', password);
      expect(wallet.pubkey, isNot(equals(walletWithHyphen.pubkey)),
          reason:
              'Em-dash and hyphen must produce different public keys for security');

      // Verify consistency - same inputs produce same output
      final CesiumWallet wallet2 = CesiumWallet(secret, password);
      expect(wallet.pubkey, equals(wallet2.pubkey),
          reason:
              'Same secret and password should produce consistent public key');
    });

    test('Create wallet with em-dash in password', () {
      const String secret = 'normal';
      const String password = 'my—secure—pass';

      final CesiumWallet wallet = CesiumWallet(secret, password);

      // Validate that a public key is generated
      expect(wallet.pubkey, isNotEmpty);

      // Validate consistency
      final CesiumWallet wallet2 = CesiumWallet(secret, password);
      expect(wallet.pubkey, equals(wallet2.pubkey),
          reason: 'Same secret and password should produce same public key');
    });

    test('Create wallet with em-dash in both secret and password', () {
      const String secret = 'test—secret';
      const String password = 'my—password';

      final CesiumWallet wallet = CesiumWallet(secret, password);

      expect(wallet.pubkey, isNotEmpty);

      final CesiumWallet wallet2 = CesiumWallet(secret, password);
      expect(wallet.pubkey, equals(wallet2.pubkey));
    });

    test('EWIF export and import with em-dash password', () async {
      const String password = 'dev—test';
      final CesiumWallet wallet = CesiumWallet(password, password);

      // Generate EWIF with em-dash password
      final String ewifData = generateEwif(wallet, password);
      expect(ewifData, isNotEmpty);

      // Create EWIF file content
      final String ewifContent = '''
Type: EWIF
Version: 1
Data: $ewifData
''';

      // Parse back the EWIF with em-dash password
      final CesiumWallet importedWallet =
          await parseKeyFile(ewifContent, null, password);

      // Verify the imported wallet matches the original
      expect(importedWallet.pubkey, equals(wallet.pubkey),
          reason: 'Imported wallet should have same pubkey as original');
    });

    test('Multiple em-dashes in password', () {
      const String secret = 'my—secret—phrase—here';
      const String password = '—password—with—multiple—dashes—';

      final CesiumWallet wallet = CesiumWallet(secret, password);

      expect(wallet.pubkey, isNotEmpty);

      final CesiumWallet wallet2 = CesiumWallet(secret, password);
      expect(wallet.pubkey, equals(wallet2.pubkey));
    });
  });
}
