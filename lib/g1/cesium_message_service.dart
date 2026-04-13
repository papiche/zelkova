import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../ui/logger.dart';
import 'crypto/cesium_wallet.dart';

/// Send a private message via the Cesium+ Elastic Search API.
///
/// Replicates the logic from Jaklis (jaklis/lib/cesium.py):
///
///   1. Build the payload JSON with issuer, recipient, title, content, time, nonce.
///   2. Compute SHA-256 hash of the compact JSON (sorted keys, no spaces).
///   3. Sign the hash with the issuer's Ed25519 key (CesiumWallet.sign).
///   4. POST to {cesiumPlusNode}/message/record.
///
/// References:
///   https://git.p2p.legal/axiom-team/jaklis/src/branch/master/lib/cesium.py
///   https://git.p2p.legal/axiom-team/jaklis/src/branch/master/lib/cesiumCommon.py
class CesiumMessageService {
  static const int _version = 2;
  static const String _currency = 'g1';

  /// Send an invitation/message from [senderWallet] to [recipientPubKey].
  ///
  /// [senderWallet]  — CesiumWallet derived from the MULTIPASS (salt, pepper).
  ///                   Only MULTIPASS accounts have a CesiumWallet.
  /// [recipientPubKey] — Base58 G1 public key of the recipient (V1 contact).
  /// [title]  — message subject
  /// [content]— message body
  ///
  /// Returns `true` if at least one Cesium+ node accepted the message.
  static Future<bool> sendMessage({
    required CesiumWallet senderWallet,
    required String recipientPubKey,
    required String title,
    required String content,
  }) async {
    final String issuer = senderWallet.pubkey;
    final int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String nonce = (Random().nextInt(1000000) + 1).toString();

    // Build payload WITHOUT hash and signature first (for signing)
    final Map<String, dynamic> payload = <String, dynamic>{
      'version': _version,
      'currency': _currency,
      'issuer': issuer,
      'recipient': recipientPubKey,
      'title': title,
      'content': content,
      'time': time,
      'nonce': nonce,
    };

    // Compact JSON with sorted keys — same as jaklis
    final String compact = _compactSortedJson(payload);

    // SHA-256 hash of the compact JSON
    final String hash =
        sha256.convert(utf8.encode(compact)).toString().toUpperCase();

    // Ed25519 signature of the hash string
    final String signature = senderWallet.sign(hash);

    payload['hash'] = hash;
    payload['signature'] = signature;

    // Try each Cesium+ node (space-separated list)
    final List<String> nodes = Env.cesiumPlusNodes
        .split(' ')
        .where((String n) => n.isNotEmpty)
        .toList();

    for (final String node in nodes) {
      try {
        final Uri uri = Uri.parse('$node/message/record');
        final http.Response r = await http
            .post(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode(payload),
            )
            .timeout(const Duration(seconds: 10));

        if (r.statusCode == 200 || r.statusCode == 201) {
          loggerDev('[CesiumMsg] Message sent via $node → HTTP ${r.statusCode}');
          return true;
        } else {
          loggerDev(
              '[CesiumMsg] Node $node rejected message: ${r.statusCode} ${r.body}');
        }
      } catch (e) {
        loggerDev('[CesiumMsg] Node $node unreachable: $e');
      }
    }

    return false;
  }

  /// Exposed for unit tests only.
  @visibleForTesting
  static String compactSortedJsonForTest(Map<String, dynamic> map) =>
      _compactSortedJson(map);

  /// Produce a compact JSON string with keys sorted alphabetically.
  /// Matches Python's json.dumps(data, sort_keys=True, separators=(',', ':'))
  /// with the default ensure_ascii=True — non-ASCII characters are \uXXXX-escaped
  /// (BMP) or encoded as UTF-16 surrogate pairs (\uD8xx\uDCxx) for emoji and
  /// other supplementary-plane characters (U+10000+).
  static String _compactSortedJson(Map<String, dynamic> map) {
    final List<String> keys = map.keys.toList()..sort();
    final StringBuffer sb = StringBuffer('{');
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) sb.write(',');
      sb.write(_escapeString(keys[i]));
      sb.write(':');
      sb.write(_jsonValue(map[keys[i]]));
    }
    sb.write('}');
    return sb.toString();
  }

  /// Encode a string as a JSON string literal, escaping all non-ASCII characters
  /// as \uXXXX exactly like Python's json.dumps with ensure_ascii=True (the default).
  /// Dart strings are UTF-16 internally, so supplementary-plane characters (emoji,
  /// etc.) are already stored as two surrogate code units — each gets its own
  /// \uXXXX escape, matching what Python produces.
  static String _escapeString(String v) {
    final StringBuffer sb = StringBuffer('"');
    for (int i = 0; i < v.length; i++) {
      final int unit = v.codeUnitAt(i);
      if (unit == 0x22) {
        sb.write(r'\"');
      } else if (unit == 0x5C) {
        sb.write(r'\\');
      } else if (unit == 0x0A) {
        sb.write(r'\n');
      } else if (unit == 0x0D) {
        sb.write(r'\r');
      } else if (unit == 0x09) {
        sb.write(r'\t');
      } else if (unit < 0x20 || unit > 0x7E) {
        sb.write('\\u${unit.toRadixString(16).padLeft(4, '0')}');
      } else {
        sb.writeCharCode(unit);
      }
    }
    sb.write('"');
    return sb.toString();
  }

  static String _jsonValue(dynamic v) {
    if (v is String) return _escapeString(v);
    if (v is int || v is double || v is bool) return v.toString();
    if (v == null) return 'null';
    if (v is Map<String, dynamic>) return _compactSortedJson(v);
    return jsonEncode(v);
  }
}
