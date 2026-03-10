import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';

void main() {
  group('u8aToHex() - Bytes to hex string conversion', () {
    test('Convert simple byte array to hex', () {
      final Uint8List bytes = Uint8List.fromList([0x2F, 0x0F, 0x5E, 0x2A]);
      expect(u8aToHex(bytes), equals('2f0f5e2a'));
    });

    test('Convert byte array with leading zeros to hex', () {
      final Uint8List bytes = Uint8List.fromList([0x00, 0x01, 0x02, 0x0F]);
      expect(u8aToHex(bytes), equals('0001020f'));
    });

    test('Convert bytes to hex with 0x prefix', () {
      final Uint8List bytes = Uint8List.fromList([0xAB, 0xCD, 0xEF]);
      expect(u8aToHex(bytes, includePrefix: true), equals('0xabcdef'));
    });

    test('Convert 32-byte Ed25519 seed to hex', () {
      final List<int> seedBytes = List<int>.generate(32, (int i) => i);
      final Uint8List bytes = Uint8List.fromList(seedBytes);
      final String hex = u8aToHex(bytes);

      expect(hex.length, equals(64)); // 32 bytes = 64 hex chars
      expect(
          hex,
          equals(
              '000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f'));
    });

    test('Handle empty byte array', () {
      final Uint8List bytes = Uint8List.fromList([]);
      expect(u8aToHex(bytes), equals(''));
    });
  });

  group('pubkeyToHex() - Base58 public key to hex conversion', () {
    test('Convert known Base58 pubkey to hex', () {
      // This is the Base58 pubkey from Cesium2s test vectors
      const String base58Pubkey =
          '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';
      final String hex = pubkeyToHex(base58Pubkey);

      expect(
          hex.length, equals(64)); // Ed25519 pubkey = 32 bytes = 64 hex chars
      expect(hex, isNotEmpty);
      expect(hex, matches(RegExp(r'^[0-9a-f]+$'))); // Valid hex
    });

    test('Convert different Base58 pubkeys to different hex', () {
      const String pubkey1 = '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';
      const String pubkey2 = '82mTJiTsVb7y6BPTyxjWQbF3LNgmp6fzTVJrWKeSjTyM';

      final String hex1 = pubkeyToHex(pubkey1);
      final String hex2 = pubkeyToHex(pubkey2);

      expect(hex1, isNot(equals(hex2)));
    });

    test('pubkeyToHex result is consistent across calls', () {
      const String base58Pubkey =
          'BdJtU7DzN72Bd4teH7qqxvpgzJFmys2mAMJuDhXSR4Ud';

      final String hex1 = pubkeyToHex(base58Pubkey);
      final String hex2 = pubkeyToHex(base58Pubkey);

      expect(hex1, equals(hex2));
    });
  });

  group('addressFromV1Pubkey() - Base58 to G1 address conversion', () {
    test('Convert known Base58 pubkey to G1 address', () {
      const String base58Pubkey =
          '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';
      final String address = addressFromV1Pubkey(base58Pubkey);

      // G1 addresses start with 'g1' and are ~50 chars long
      expect(address, startsWith('g1'));
      expect(address.length, greaterThan(40));
    });

    test('G1 address matches Cesium2s for café password', () {
      const String base58Pubkey =
          '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';
      final String address = addressFromV1Pubkey(base58Pubkey);

      expect(
        address,
        equals('g1L3US4Dxxh2kuZRwqiufJHarRXSpGEs2gQRkVyMcGgzjEh5h'),
        reason: 'G1 address should match Cesium2s for café password',
      );
    });

    test('Different Base58 pubkeys produce different G1 addresses', () {
      const String pubkey1 = '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';
      const String pubkey2 = '82mTJiTsVb7y6BPTyxjWQbF3LNgmp6fzTVJrWKeSjTyM';

      final String address1 = addressFromV1Pubkey(pubkey1);
      final String address2 = addressFromV1Pubkey(pubkey2);

      expect(address1, isNot(equals(address2)));
    });

    test('addressFromV1Pubkey is consistent across calls', () {
      const String base58Pubkey =
          'BdJtU7DzN72Bd4teH7qqxvpgzJFmys2mAMJuDhXSR4Ud';

      final String address1 = addressFromV1Pubkey(base58Pubkey);
      final String address2 = addressFromV1Pubkey(base58Pubkey);

      expect(address1, equals(address2));
    });
  });

  group('v1pubkeyFromAddress() - G1 address to Base58 reverse conversion', () {
    test('Roundtrip: Base58 -> G1 address -> Base58', () {
      const String originalPubkey =
          '4AhkgiN3eoa9o8WmTHpRe4Jyjr1XmouoXeSY5tTh6VDR';

      // Convert to G1 address
      final String g1Address = addressFromV1Pubkey(originalPubkey);

      // Convert back to Base58
      final String recoveredPubkey = v1pubkeyFromAddress(g1Address);

      expect(recoveredPubkey, equals(originalPubkey));
    });
  });
}
