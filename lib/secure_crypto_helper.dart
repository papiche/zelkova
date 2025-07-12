import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'ui/logger.dart' show loggerDev;

mixin SecureCryptoHelper {
  static Uint8List generateSalt([int length = 32]) {
    final Random random = Random.secure();
    final List<int> salt =
        List<int>.generate(length, (_) => random.nextInt(256));
    return Uint8List.fromList(salt);
  }

  static Future<Uint8List> deriveKeyFromPattern(
      List<int> pattern, List<int> salt) async {
    final String joined = pattern.join('-');
    final List<int> password = utf8.encode(joined);
    return Uint8List.fromList(_pbkdf2(password, salt));
  }

  static Future<Uint8List> deriveKeyFromPassword(
      String password, List<int> salt) async {
    final List<int> input = utf8.encode(password);
    return Uint8List.fromList(_pbkdf2(input, salt));
  }

  static List<int> _pbkdf2(List<int> password, List<int> salt,
      {int iterations = 100000, int keyLength = 32}) {
    final Hmac hmac = Hmac(sha256, password);
    final List<int> result = <int>[];
    final int blockCount =
        (keyLength / hmac.convert(<int>[]).bytes.length).ceil();

    for (int i = 1; i <= blockCount; i++) {
      final List<int> saltBlock = List<int>.from(salt)
        ..addAll(<int>[
          (i >> 24) & 0xff,
          (i >> 16) & 0xff,
          (i >> 8) & 0xff,
          i & 0xff,
        ]);

      List<int> u = hmac.convert(saltBlock).bytes;
      final List<int> block = List<int>.from(u);
      for (int j = 1; j < iterations; j++) {
        u = hmac.convert(u).bytes;
        for (int k = 0; k < block.length; k++) {
          block[k] ^= u[k];
        }
      }
      result.addAll(block);
    }

    return result.sublist(0, keyLength);
  }

  static String encrypt(String data, List<int> salt) {
    try {
      final Key key = Key(Uint8List.fromList(salt));
      final IV iv = IV.fromSecureRandom(12);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.gcm));

      final Encrypted encrypted = encrypter.encrypt(data, iv: iv);

      final String combined = '${iv.base64}|${encrypted.base64}';
      return combined;
    } catch (e) {
      loggerDev('Encryption error', error: e);
      throw Exception('Encryption failed');
    }
  }

  static String? decrypt(String encryptedData, List<int> salt) {
    try {
      final List<String> parts = encryptedData.split('|');
      if (parts.length != 2) {
        return null;
      }

      final IV iv = IV.fromBase64(parts[0]);
      final String encrypted = parts[1];

      final Key key = Key(Uint8List.fromList(salt));
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.gcm));

      return encrypter.decrypt64(encrypted, iv: iv);
    } catch (_) {
      return null;
    }
  }
}
