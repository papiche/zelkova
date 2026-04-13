import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/cesium_message_service.dart';

void main() {
  group('CesiumMessageService._compactSortedJson', () {
    test('ASCII-only payload matches expected compact JSON', () {
      // Verify that keys are sorted alphabetically
      final String result = CesiumMessageService.compactSortedJsonForTest(
        <String, dynamic>{
          'version': 2,
          'currency': 'g1',
          'issuer': 'ABCDEF',
          'recipient': 'GHIJKL',
          'title': 'Hello',
          'content': 'World',
          'time': 1234567890,
          'nonce': '42',
        },
      );
      // Keys sorted: content, currency, issuer, nonce, recipient, time, title, version
      expect(result,
          '{"content":"World","currency":"g1","issuer":"ABCDEF","nonce":"42","recipient":"GHIJKL","time":1234567890,"title":"Hello","version":2}');
    });

    test('Non-ASCII characters are \\uXXXX-escaped (like Python ensure_ascii=True)', () {
      // 'é' is U+00E9, 'Ğ' is U+011E
      final String result = CesiumMessageService.compactSortedJsonForTest(
        <String, dynamic>{'content': 'caf\u00e9 \u011e1'},
      );
      expect(result, r'{"content":"caf\u00e9 \u011e1"}');
    });

    test('Emoji are encoded as UTF-16 surrogate pairs (like Python ensure_ascii=True)', () {
      // 👋 is U+1F44B → UTF-16 surrogate pair: U+D83D U+DC4B
      // In Dart, the string '👋' has length 2 (two code units: 0xD83D, 0xDC4B)
      final String result = CesiumMessageService.compactSortedJsonForTest(
        <String, dynamic>{'content': '👋'},
      );
      expect(result, r'{"content":"\ud83d\udc4b"}');
    });

    test('Newlines are escaped as \\n', () {
      final String result = CesiumMessageService.compactSortedJsonForTest(
        <String, dynamic>{'content': 'line1\nline2'},
      );
      expect(result, r'{"content":"line1\nline2"}');
    });

    test('French invitation message produces stable SHA-256 hash', () {
      // Regression test: the compact JSON of a real invitation must produce
      // the same hash every time (deterministic), regardless of platform.
      // The expected hash is derived from the Python-compatible encoding.
      final String frContent =
          '👋 Rejoins ẐEN, l\'unité d\'usage coopérative du G1FabLab '
          'pour les membres de la toile de confiance Ğ1 (Duniter) !\n\n'
          '🌐 Application : https://u.copylaradio.com/ipns/coracle.copylaradio.com\n'
          '🎮 Démo en ligne : https://u.copylaradio.com/nostr\n\n'
          '🪙 ẐEN = crédit d\'usage local · 🆓 Logiciels libres · 🔓 Souveraineté numérique\n\n'
          '#ẐEN #UPlanet #G1FabLab #MonnaieLibre #NOSTR';

      final Map<String, dynamic> payload = <String, dynamic>{
        'version': 2,
        'currency': 'g1',
        'issuer': 'testIssuer',
        'recipient': 'testRecipient',
        'title': 'Inviter sur ẐEN',
        'content': frContent,
        'time': 1000000000,
        'nonce': '123456',
      };

      final String compact =
          CesiumMessageService.compactSortedJsonForTest(payload);

      // All non-ASCII must be escaped: no raw emoji or accented chars
      expect(compact.contains('👋'), isFalse,
          reason: 'Raw emoji must be escaped');
      expect(compact.contains('é'), isFalse,
          reason: 'Raw accented chars must be escaped');
      expect(compact.contains(r'\u'), isTrue,
          reason: 'Must contain \\u escapes');

      // Hash must be deterministic
      final String hash1 =
          sha256.convert(utf8.encode(compact)).toString().toUpperCase();
      final String hash2 =
          sha256.convert(utf8.encode(compact)).toString().toUpperCase();
      expect(hash1, equals(hash2));
      expect(hash1.length, equals(64));
    });

    test('Backslash and double-quote are escaped', () {
      final String result = CesiumMessageService.compactSortedJsonForTest(
        <String, dynamic>{'x': r'a\b"c'},
      );
      expect(result, r'{"x":"a\\b\"c"}');
    });
  });
}
