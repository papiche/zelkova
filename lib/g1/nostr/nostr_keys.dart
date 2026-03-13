import 'package:bech32/bech32.dart';
import 'package:hex/hex.dart';

/// NIP-19 bech32 key encoding/decoding for NOSTR keys
class NostrKeys {
  /// Decode nsec1... → hex private key
  static String nsecToHex(String nsec) {
    final List<int> decoded = _decodeBech32(nsec, 'nsec');
    return HEX.encode(decoded);
  }

  /// Decode npub1... → hex public key
  static String npubToHex(String npub) {
    final List<int> decoded = _decodeBech32(npub, 'npub');
    return HEX.encode(decoded);
  }

  /// Encode hex private key → nsec1...
  static String hexToNsec(String hex) {
    return _encodeBech32('nsec', HEX.decode(hex));
  }

  /// Encode hex public key → npub1...
  static String hexToNpub(String hex) {
    return _encodeBech32('npub', HEX.decode(hex));
  }

  static String _encodeBech32(String hrp, List<int> data) {
    final List<int> converted = _convertBits(data, 8, 5, true);
    const Bech32Codec codec = Bech32Codec();
    return codec.encode(Bech32(hrp, converted));
  }

  static List<int> _decodeBech32(String bech32String, String expectedHrp) {
    const Bech32Codec codec = Bech32Codec();
    final Bech32 decoded = codec.decode(bech32String);
    if (decoded.hrp != expectedHrp) {
      throw ArgumentError(
          'Invalid bech32 prefix: expected $expectedHrp, got ${decoded.hrp}');
    }
    return _convertBits(decoded.data, 5, 8, false);
  }

  /// BIP-173 bit conversion
  static List<int> _convertBits(
      List<int> data, int fromBits, int toBits, bool pad) {
    int acc = 0;
    int bits = 0;
    final List<int> result = <int>[];
    final int maxv = (1 << toBits) - 1;

    for (final int value in data) {
      acc = (acc << fromBits) | value;
      bits += fromBits;
      while (bits >= toBits) {
        bits -= toBits;
        result.add((acc >> bits) & maxv);
      }
    }
    if (pad) {
      if (bits > 0) {
        result.add((acc << (toBits - bits)) & maxv);
      }
    }
    return result;
  }
}
