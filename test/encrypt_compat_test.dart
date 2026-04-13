import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/g1_helper.dart';
import 'package:zelkova/secure_crypto_helper.dart';

void main() {
  group('Encryption Verification (Post Migration)', () {
    test('AES-CBC (SIC Default) Verification', () {
      const String json = '{"test": "data", "nested": {"key": "value"}}';
      const String password = 'test-password';

      final Map<String, String> encryptResult =
          encryptJsonForExport(json, password);
      final Map<String, dynamic> decrypted =
          decryptJsonForImport(encryptResult['key']!, password);

      expect(jsonEncode(decrypted), equals(jsonEncode(jsonDecode(json))));
    });

    test('AES-GCM (Local Storage) Verification', () {
      final Uint8List data =
          Uint8List.fromList(utf8.encode('secret mnemonic phrase'));
      final List<int> salt = List<int>.generate(32, (int i) => i);

      final Uint8List encrypted = SecureCryptoHelper.encrypt(data, salt);
      final Uint8List? decrypted = SecureCryptoHelper.decrypt(encrypted, salt);

      expect(decrypted, equals(data));
    });

    test('AES-ECB (V1 Keys) Verification', () {
      final Uint8List data =
          Uint8List.fromList(List<int>.generate(32, (int i) => i));
      final Uint8List key =
          Uint8List.fromList(List<int>.generate(32, (int i) => i + 10));
      final Uint8List encrypted = encryptAes(data, key);
      final Uint8List decrypted = decryptAes(encrypted, key);

      expect(decrypted, equals(data));
    });

    test('Frozen Vector: Decrypt existing backup with new implementation', () {
      const String walletBackup =
          '{"key":"rLkdXaEaz8hk0OGbb7TTMuh0d+aNrkW0fA1rlCR1lOvuURPy717ayCSvDviXE6J+LDRJ6FpbsG2SReDB6lcF8crS7DOyF5K4gx16RF4DlHaVxxZrwRnlVCxyBN9NstFlLglgAFnx/XmZJLSzZ7w/gG6ka9miXKECrPdUw93nPF3hPZhfXtcXzGo+6UKBtVtglEfjOXmgjDMTuYgbtJuHKvdAjoCDDNfpMmp6wV+C6zTglRRhHMh9+oubCmekwxrvAKA0lueC5M/CPL+puPH21/3wLHed8hF9N2F2EHmjSNGeK1r7ferN0SbwntWdNOfA/Jzhdxg7F+XNMeSNn7J4Py+jVwwx0Bs/wjw8DQI02cHSzBNOl+jP0ESs784ArMv2tL/sASAM5K0bXcc/zI89tOLI6A4+jnzOFNdGfjuPVU1AmNye79KCUDPXv6Qh4T6ZoiDgHtjFlT9n6/9RYLOFw86Lr0255ont8nnhm+MXkDhg38SscUMaU8I5CPglfWf+/bO0fDA2VQ0a/6wgpyWI02n3LzHgUEF6+l4akrHDn4ahm/pWaeS9DPIxw+WGMFYRPCph0tI5Bp0Alf6vy64ZGSP1VxrvbETvWQ3okWaOBOqm571h/CMVbre7CbKMqjFtFLiWbBJBmBNx1QSt5uGmGrWaJI29gHSW/MwU7YSvkCrIzoSJkr/7e2vDytkeG4Eq"}';
      const String password = '678';

      final Map<String, dynamic> keyJson =
          jsonDecode(walletBackup) as Map<String, dynamic>;
      final String keyEncrypted = keyJson['key'] as String;

      final Map<String, dynamic> decrypted =
          decryptJsonForImport(keyEncrypted, password);
      expect(decrypted['cesiumCards'], isNotNull);

      // Verify name of first card (matches expected data from g1_test.dart)
      final dynamic cesiumCards = decrypted['cesiumCards'];
      final Map<String, dynamic> firstCard = (jsonDecode(cesiumCards as String)
          as List<dynamic>)[0] as Map<String, dynamic>;
      final String primaryKey = firstCard['pubKey'] as String;
      expect(
          primaryKey, equals('6JgGvDDBu8XWL89BTvzHCfVmJWbSRfBNb1ZK4dQW6fNK'));
    });
  });
}
