import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';

/// NOSTR protocol utilities (NIP-01)
class NostrUtils {
  /// Calculate event ID per NIP-01: SHA-256 of serialized event
  static String calculateEventId(Map<String, dynamic> event) {
    final String serialized = jsonEncode(<dynamic>[
      0,
      event['pubkey'],
      event['created_at'],
      event['kind'],
      event['tags'],
      event['content'],
    ]);
    final Digest hash = sha256.convert(utf8.encode(serialized));
    return HEX.encode(hash.bytes);
  }

  /// Generate a unique subscription ID
  static String generateSubscriptionId(String prefix) {
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}';
  }
}
