import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/secure_crypto_helper.dart';

void main() {
  test('Encrypt and decrypt pattern key using salt', () async {
    final List<int> pattern = <int>[0, 1, 2, 4, 7];
    final List<int> salt = SecureCryptoHelper.generateSalt();

    final Uint8List key =
        await SecureCryptoHelper.deriveKeyFromPattern(pattern, salt);
    final String encoded = base64Encode(key);

    final String encrypted = SecureCryptoHelper.encrypt(encoded, salt);
    final String? decrypted = SecureCryptoHelper.decrypt(encrypted, salt);

    expect(decrypted, encoded);
  });

  test('Decryption with wrong salt fails', () async {
    final List<int> pattern = <int>[1, 3, 6];
    final List<int> salt = SecureCryptoHelper.generateSalt();
    final List<int> wrongSalt = SecureCryptoHelper.generateSalt();

    final Uint8List key =
        await SecureCryptoHelper.deriveKeyFromPattern(pattern, salt);
    final String encoded = base64Encode(key);

    final String encrypted = SecureCryptoHelper.encrypt(encoded, salt);
    final String? decrypted = SecureCryptoHelper.decrypt(encrypted, wrongSalt);

    expect(decrypted, isNull);
  });

  group('SecureCryptoHelper password-based key derivation', () {
    late List<int> salt;

    setUp(() {
      salt = List<int>.generate(16, (int i) => i + 1);
    });

    test('Derives consistent key for same password and salt', () async {
      const String password = 'testpassword';
      final Uint8List key1 =
          await SecureCryptoHelper.deriveKeyFromPassword(password, salt);
      final Uint8List key2 =
          await SecureCryptoHelper.deriveKeyFromPassword(password, salt);
      expect(key1, equals(key2));
    });

    test('Derives different key for different password', () async {
      const String password1 = 'password1';
      const String password2 = 'password2';
      final Uint8List key1 =
          await SecureCryptoHelper.deriveKeyFromPassword(password1, salt);
      final Uint8List key2 =
          await SecureCryptoHelper.deriveKeyFromPassword(password2, salt);
      expect(key1, isNot(equals(key2)));
    });

    test('Derived key has expected length', () async {
      const String password = 'longenough';
      final Uint8List key =
          await SecureCryptoHelper.deriveKeyFromPassword(password, salt);
      expect(key.length, greaterThanOrEqualTo(16));
    });
  });
}
