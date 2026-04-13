import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/crypto/cesium_wallet.dart';
import 'package:zelkova/g1/g1_export_auth_utils.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';

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
      final List<int> seedList = List<int>.generate(32, (int i) => i);
      final CesiumWallet wallet1 =
          CesiumWallet.fromSeed(Uint8List.fromList(List<int>.from(seedList)));

      final CesiumWallet wallet2 =
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
      const String document = 'Original document';
      const String modifiedDocument = 'Modified document';

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

  group('CesiumWallet - Cesium2s compatibility (Base58 pubkey)', () {
    /// These tests verify that Ginkgo generates the same Base58-encoded
    /// public keys as Cesium2s for UTF-8 passwords with special characters.
    ///
    /// Base58 pubkey format: '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR' (44 chars)
    /// This is the internal format used by both Ginkgo and Cesium2s.
    ///
    /// Test vectors generated from Cesium2s (Node.js) using:
    /// - Scrypt: N=4096, r=16, p=1
    /// - UTF-8 encoding: TextEncoder.encode() / utf8.encode()
    /// - Ed25519 keypair from seed

    test('Accents (café) - Base58 pubkey matches Cesium2s', () {
      const String salt = 'mon_identifiant';
      const String password = 'café123';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      // Expected from Cesium2s
      expect(
        wallet.pubkey,
        equals('4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR'),
        reason: 'Base58 pubkey should match Cesium2s for accents (café)',
      );
    });

    test('Ğ character (Ğ1) - Base58 pubkey matches Cesium2s', () {
      const String salt = 'Ğ1user';
      const String password = 'Ğ1pass';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      expect(
        wallet.pubkey,
        equals('82mTJiTsVb7y6BPTyxjWQbF3LNgmp6fzTVJrWKeSjTyM'),
        reason: 'Base58 pubkey should match Cesium2s for Ğ character',
      );
    });

    test('Euro symbol (€) - Base58 pubkey matches Cesium2s', () {
      const String salt = 'user€';
      const String password = '€123';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      expect(
        wallet.pubkey,
        equals('BdJtU7DzN72Bd4teH7qqxvpgzJFmys2mAMJuDhXSR4Ud'),
        reason: 'Base58 pubkey should match Cesium2s for euro symbol',
      );
    });

    test('ASCII only - Base58 pubkey matches Cesium2s', () {
      const String salt = 'salt123';
      const String password = 'password123';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      expect(
        wallet.pubkey,
        equals('34WF7EpRtxHh55VucGyk1UXyXh1hjxvHYpBw9GUjNq38'),
        reason: 'Base58 pubkey should match Cesium2s for ASCII characters',
      );
    });

    test('Em-dash (—) - Base58 pubkey matches Cesium2s', () {
      const String salt = 'test—password';
      const String password = 'my—secure—pass';

      final CesiumWallet wallet = CesiumWallet(salt, password);

      expect(
        wallet.pubkey,
        equals('JBZDx2udLfZqrJqvBLhwvw7AK1cudPWo1Q59XnM32bPe'),
        reason: 'Base58 pubkey should match Cesium2s for em-dash character',
      );
    });
  });

  group('CesiumWallet - Cesium2s compatibility (G1 address)', () {
    /// These tests verify that Ginkgo generates the same G1 addresses
    /// (SS58 format) as Cesium2s. This is what users actually see in the UI.
    ///
    /// G1 address format: 'g1L3US4Dxxh2kuZRwqiufJHarRXSpGEs2gQRkVyMcGgzjEh5h'
    /// This is the user-visible format in wallets and transaction history.
    ///
    /// Conversion: Base58 pubkey → G1 address using SS58 codec (prefix: 4450)

    test('Accents (café) - G1 address matches Cesium2s', () {
      const String salt = 'mon_identifiant';
      const String password = 'café123';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String g1Address = addressFromV1Pubkey(wallet.pubkey);

      // Expected from Cesium2s
      expect(
        g1Address,
        equals('g1L3US4Dxxh2kuZRwqiufJHarRXSpGEs2gQRkVyMcGgzjEh5h'),
        reason: 'G1 address should match Cesium2s for accents (café)',
      );
    });

    test('Ğ character (Ğ1) - G1 address matches Cesium2s', () {
      const String salt = 'Ğ1user';
      const String password = 'Ğ1pass';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String g1Address = addressFromV1Pubkey(wallet.pubkey);

      expect(
        g1Address,
        equals('g1MLjYhNaSAhvxGerfH2RMnp9zfmHYfgf6AHzrvnPGSSAUeQj'),
        reason: 'G1 address should match Cesium2s for Ğ character',
      );
    });

    test('Euro symbol (€) - G1 address matches Cesium2s', () {
      const String salt = 'user€';
      const String password = '€123';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String g1Address = addressFromV1Pubkey(wallet.pubkey);

      expect(
        g1Address,
        equals('g1NYnGjRqE9Xe1XDmxBbyedQqEu3Ybxgtdmq2CPeLgSjbzf92'),
        reason: 'G1 address should match Cesium2s for euro symbol',
      );
    });

    test('ASCII only - G1 address matches Cesium2s', () {
      const String salt = 'salt123';
      const String password = 'password123';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String g1Address = addressFromV1Pubkey(wallet.pubkey);

      expect(
        g1Address,
        equals('g1KfukEmpccaukFtW1BrAKrpru4U1pD4QKCJaLobs1RNxJbeg'),
        reason: 'G1 address should match Cesium2s for ASCII characters',
      );
    });

    test('Em-dash (—) - G1 address matches Cesium2s', () {
      const String salt = 'test—password';
      const String password = 'my—secure—pass';

      final CesiumWallet wallet = CesiumWallet(salt, password);
      final String g1Address = addressFromV1Pubkey(wallet.pubkey);

      expect(
        g1Address,
        equals('g1QkW5ozZChB4C5q6t7aJftBYunEFCpDTworUeFRfMRoVqYWc'),
        reason: 'G1 address should match Cesium2s for em-dash character',
      );
    });
  });

  group('CesiumWallet - Security verification', () {
    test('Different em-dash vs hyphen produces different public keys', () {
      final CesiumWallet walletEmDash = CesiumWallet('test—pass', 'pass');
      final CesiumWallet walletHyphen = CesiumWallet('test-pass', 'pass');

      final String pubkeyEmDashHex = pubkeyToHex(walletEmDash.pubkey);
      final String pubkeyHyphenHex = pubkeyToHex(walletHyphen.pubkey);

      expect(
        pubkeyEmDashHex,
        isNot(equals(pubkeyHyphenHex)),
        reason: 'Em-dash (—) and hyphen (-) must produce different public keys',
      );
    });
  });
}
