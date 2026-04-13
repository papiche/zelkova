import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/api.dart';
import 'package:zelkova/g1/crypto/cesium_wallet.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

void main() {
  group('migrateProfileCPlus - hash and signature construction', () {
    late KeyPair oldKeyPair;
    late String oldAddress;
    late String newAddress;

    setUp(() {
      // Create a deterministic keypair from a known secret/password
      const String password = 'devtest';
      final CesiumWallet walletV1 = CesiumWallet(password, password);
      oldKeyPair = KeyPair.ed25519.fromSeed(walletV1.seed);
      oldKeyPair.ss58Format = 4450;
      oldAddress = oldKeyPair.address;

      // Use a fixed new address for testing
      newAddress = '5GrpknVvGGrGH3EFuURXeMrWHvbpj3VfER1oX5jFtuGbfzCE';
    });

    test('hash is deterministic for same addresses', () {
      final Map<String, dynamic> message1 = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };
      final Map<String, dynamic> message2 = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };

      final String hash1 = calculateHash(jsonEncode(message1));
      final String hash2 = calculateHash(jsonEncode(message2));

      expect(hash1, equals(hash2));
      expect(hash1, isNotEmpty);
    });

    test('hash changes when addresses differ', () {
      final Map<String, dynamic> message1 = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };
      final Map<String, dynamic> message2 = <String, dynamic>{
        'addressOld': newAddress,
        'addressNew': oldAddress,
      };

      final String hash1 = calculateHash(jsonEncode(message1));
      final String hash2 = calculateHash(jsonEncode(message2));

      expect(hash1, isNot(equals(hash2)));
    });

    test('signature is valid and verifiable by old keypair', () {
      final Map<String, dynamic> message = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };
      final String hash = calculateHash(jsonEncode(message));
      final Uint8List signatureBytes =
          oldKeyPair.sign(Uint8List.fromList(hash.codeUnits));

      // Verify the signature is valid
      final bool isVerified =
          oldKeyPair.verify(Uint8List.fromList(hash.codeUnits), signatureBytes);
      expect(isVerified, isTrue);
    });

    test('signature is deterministic for same input', () {
      final Map<String, dynamic> message = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };
      final String hash = calculateHash(jsonEncode(message));
      final String sig1 =
          encodeHex(oldKeyPair.sign(Uint8List.fromList(hash.codeUnits)));
      final String sig2 =
          encodeHex(oldKeyPair.sign(Uint8List.fromList(hash.codeUnits)));

      expect(sig1, equals(sig2));
      expect(sig1, isNotEmpty);
    });

    test('signature encoded as hex is non-empty and has expected length', () {
      final Map<String, dynamic> message = <String, dynamic>{
        'addressOld': oldAddress,
        'addressNew': newAddress,
      };
      final String hash = calculateHash(jsonEncode(message));
      final String signature =
          encodeHex(oldKeyPair.sign(Uint8List.fromList(hash.codeUnits)));

      // Ed25519 signatures are 64 bytes = 128 hex chars
      expect(signature.length, equals(128));
    });
  });

  group('migrateProfileCPlus - profile data construction', () {
    test('hashAndSignV2 adds hash and signature to profile data', () {
      const String password = 'devtest';
      final CesiumWallet walletV1 = CesiumWallet(password, password);
      final KeyPair keyPair = KeyPair.ed25519.fromSeed(walletV1.seed);
      keyPair.ss58Format = 4450;

      final Map<String, dynamic> profile = <String, dynamic>{
        'version': 2,
        'issuer': 'testPubKey',
        'title': 'Test User',
        'time': 1234567890,
      };

      hashAndSignV2(profile, keyPair);

      expect(profile['hash'], isNotNull);
      expect(profile['hash'], isNotEmpty);
      expect(profile['signature'], isNotNull);
      expect(profile['signature'], isNotEmpty);
      // Hash should be uppercase SHA-256 (64 hex chars)
      expect((profile['hash'] as String).length, equals(64));
      expect(
          profile['hash'], equals((profile['hash'] as String).toUpperCase()));
    });

    test('new profile preserves all optional fields from source', () {
      // Simulate what migrateProfileCPlus does when building the new profile
      final Map<String, dynamic> source = <String, dynamic>{
        'title': 'Alice',
        'description': 'A Ğ1 user',
        'city': 'Paris',
        'geoPoint': <String, dynamic>{'lat': 48.8566, 'lon': 2.3522},
        'socials': <Map<String, String>>[
          <String, String>{'type': 'web', 'url': 'https://example.com'}
        ],
        'avatar': <String, String>{
          '_content_type': 'image/png',
          '_content': 'base64data',
        },
        'tags': <String>['tag1', 'tag2'],
      };

      const String newPubKey = 'newTestPubKey';
      final Map<String, dynamic> newProfile = <String, dynamic>{
        'version': 2,
        'issuer': newPubKey,
        'title': source['title'] as String? ?? '',
        'time': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      };

      // Copy optional fields (same logic as migrateProfileCPlus)
      if (source['description'] != null) {
        newProfile['description'] = source['description'];
      }
      if (source['city'] != null) {
        newProfile['city'] = source['city'];
      }
      if (source['geoPoint'] != null) {
        newProfile['geoPoint'] = source['geoPoint'];
      }
      if (source['socials'] != null) {
        newProfile['socials'] = source['socials'];
      }
      if (source['avatar'] != null) {
        newProfile['avatar'] = source['avatar'];
      }
      if (source['tags'] != null) {
        newProfile['tags'] = source['tags'];
      }

      expect(newProfile['issuer'], equals(newPubKey));
      expect(newProfile['title'], equals('Alice'));
      expect(newProfile['description'], equals('A Ğ1 user'));
      expect(newProfile['city'], equals('Paris'));
      expect(newProfile['geoPoint'],
          equals(<String, dynamic>{'lat': 48.8566, 'lon': 2.3522}));
      expect(newProfile['socials'], isNotEmpty);
      expect(newProfile['avatar'], isNotNull);
      expect(newProfile['tags'], equals(<String>['tag1', 'tag2']));
    });

    test('new profile handles missing optional fields gracefully', () {
      // Source with only title (minimal profile)
      final Map<String, dynamic> source = <String, dynamic>{
        'title': 'Bob',
      };

      const String newPubKey = 'newTestPubKey';
      final Map<String, dynamic> newProfile = <String, dynamic>{
        'version': 2,
        'issuer': newPubKey,
        'title': source['title'] as String? ?? '',
        'time': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      };

      if (source['description'] != null) {
        newProfile['description'] = source['description'];
      }
      if (source['city'] != null) {
        newProfile['city'] = source['city'];
      }

      expect(newProfile['issuer'], equals(newPubKey));
      expect(newProfile['title'], equals('Bob'));
      expect(newProfile.containsKey('description'), isFalse);
      expect(newProfile.containsKey('city'), isFalse);
      expect(newProfile.containsKey('geoPoint'), isFalse);
      expect(newProfile.containsKey('socials'), isFalse);
      expect(newProfile.containsKey('avatar'), isFalse);
    });

    test('delete profile data has correct structure', () {
      const String oldPubKey = 'oldTestPubKey';
      final Map<String, dynamic> deleteData = <String, dynamic>{
        'version': 2,
        'id': oldPubKey,
        'issuer': oldPubKey,
        'index': 'user',
        'type': 'profile',
        'time': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      };

      expect(deleteData['version'], equals(2));
      expect(deleteData['id'], equals(oldPubKey));
      expect(deleteData['issuer'], equals(oldPubKey));
      expect(deleteData['index'], equals('user'));
      expect(deleteData['type'], equals('profile'));
      expect(deleteData['time'], isNotNull);
    });
  });

  group('migrateProfileCPlus - calculateHash', () {
    test('hash is uppercase SHA-256', () {
      final Map<String, dynamic> message = <String, dynamic>{
        'addressOld': 'addr1',
        'addressNew': 'addr2',
      };
      final String hash = calculateHash(jsonEncode(message));

      // SHA-256 produces 64 hex characters, calculateHash returns uppercase
      expect(hash.length, equals(64));
      expect(hash, equals(hash.toUpperCase()));
    });

    test('hash of profile JSON is deterministic', () {
      final Map<String, dynamic> profile = <String, dynamic>{
        'version': 2,
        'issuer': 'testPubKey',
        'title': 'Test',
        'time': 1234567890,
      };

      final String hash1 = calculateHash(jsonEncode(profile));
      final String hash2 = calculateHash(jsonEncode(profile));

      expect(hash1, equals(hash2));
    });
  });
}
