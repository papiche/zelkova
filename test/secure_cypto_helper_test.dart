import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';
import 'package:zelkova/secure_crypto_helper.dart';

void main() {
  test('Encrypt and decrypt pattern key using salt', () async {
    final List<int> pattern = <int>[0, 1, 2, 4, 7];
    final List<int> salt = SecureCryptoHelper.generateSalt();
    final Uint8List key =
        await SecureCryptoHelper.deriveKeyFromPattern(pattern, salt);

    final Uint8List encrypted = SecureCryptoHelper.encrypt(key, salt);
    final Uint8List? decrypted = SecureCryptoHelper.decrypt(encrypted, salt);

    expect(decrypted, key);
  });

  test('Decryption with wrong salt fails', () async {
    final List<int> pattern = <int>[1, 3, 6];
    final List<int> salt = SecureCryptoHelper.generateSalt();
    final List<int> wrongSalt = SecureCryptoHelper.generateSalt();
    final Uint8List key =
        await SecureCryptoHelper.deriveKeyFromPattern(pattern, salt);

    final Uint8List encrypted = SecureCryptoHelper.encrypt(key, salt);
    final Uint8List? decrypted =
        SecureCryptoHelper.decrypt(encrypted, wrongSalt);

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
  test('Mnemonic is correctly encrypted and decrypted with password key',
      () async {
    // Original mnemonic phrase to store
    const String originalMnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';

    // Convert the mnemonic to bytes (Uint8List)
    final Uint8List plainBytes = mnemonicToStore(originalMnemonic);

    // Derive a password-based key from a pattern and salt
    final List<int> pattern = <int>[1, 2, 5, 8];
    final List<int> salt = SecureCryptoHelper.generateSalt();
    final Uint8List passwordKey =
        await SecureCryptoHelper.deriveKeyFromPattern(pattern, salt);

    // Encrypt the mnemonic bytes using the derived key
    final Uint8List encrypted =
        SecureCryptoHelper.encrypt(plainBytes, passwordKey);

    // Decrypt the encrypted data using the same key
    final Uint8List? decrypted =
        SecureCryptoHelper.decrypt(encrypted, passwordKey);

    // Convert the decrypted bytes back to a string
    final String recoveredMnemonic = storeToMnemonic(decrypted!);

    // Assert that the recovered mnemonic matches the original
    expect(recoveredMnemonic, equals(originalMnemonic));
  });

  test('Decryption fails with wrong key', () async {
    const String originalMnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';
    final Uint8List plainBytes = mnemonicToStore(originalMnemonic);

    // Derive two different keys from different patterns
    final List<int> correctPattern = <int>[0, 1, 2];
    final List<int> wrongPattern = <int>[3, 4, 5];
    final List<int> salt = SecureCryptoHelper.generateSalt();

    final Uint8List correctKey =
        await SecureCryptoHelper.deriveKeyFromPattern(correctPattern, salt);
    final Uint8List wrongKey =
        await SecureCryptoHelper.deriveKeyFromPattern(wrongPattern, salt);

    // Encrypt using the correct key
    final Uint8List encrypted =
        SecureCryptoHelper.encrypt(plainBytes, correctKey);

    // Try decrypting with the wrong key (should fail)
    final Uint8List? decrypted =
        SecureCryptoHelper.decrypt(encrypted, wrongKey);

    // Ensure the decryption fails (null)
    expect(decrypted, isNull);
  });
}
