import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';

/// NIP-44 v2 — Encrypted Direct Messages
/// Spec: https://github.com/nostr-protocol/nips/blob/master/44.md
///
/// Encryption: secp256k1 ECDH → HKDF-SHA256 → ChaCha20 + HMAC-SHA256
class Nip44 {
  Nip44._();

  static final ECDomainParameters _curve = ECCurve_secp256k1();

  // ─── Internal helpers ────────────────────────────────────────────────────

  static Uint8List _bigIntToBytes32(BigInt n) {
    final String hex = n.toRadixString(16).padLeft(64, '0');
    return Uint8List.fromList(HEX.decode(hex));
  }

  // secp256k1 ECDH: x-coordinate of privKey * pubPoint
  static Uint8List _ecdh(String hexPrivKey, String hexPubKey) {
    final BigInt priv = BigInt.parse(hexPrivKey, radix: 16);
    final Uint8List pubBytes =
        Uint8List.fromList(HEX.decode('02$hexPubKey'));
    final ECPoint? pub = _curve.curve.decodePoint(pubBytes);
    if (pub == null) {
      throw Exception('Nip44: invalid public key');
    }
    final ECPoint? shared = pub * priv;
    if (shared == null || shared.isInfinity) {
      throw Exception('Nip44: ECDH point at infinity');
    }
    return _bigIntToBytes32(shared.x!.toBigInteger()!);
  }

  static Uint8List _hmacSha256(Uint8List key, Uint8List data) {
    final HMac mac = HMac(SHA256Digest(), 64);
    mac.init(KeyParameter(key));
    return mac.process(data);
  }

  // HKDF-Extract: PRK = HMAC-SHA256(salt="nip44-v2", IKM=sharedSecret)
  static Uint8List _hkdfExtract(Uint8List ikm) {
    final Uint8List salt = Uint8List.fromList(utf8.encode('nip44-v2'));
    return _hmacSha256(salt, ikm);
  }

  // HKDF-Expand: produce [length] bytes with [info] as context
  static Uint8List _hkdfExpand(Uint8List prk, Uint8List info, int length) {
    final List<int> okm = <int>[];
    Uint8List t = Uint8List(0);
    for (int i = 1; okm.length < length; i++) {
      final Uint8List input = Uint8List(t.length + info.length + 1)
        ..setAll(0, t)
        ..setAll(t.length, info)
        ..[t.length + info.length] = i;
      t = _hmacSha256(prk, input);
      okm.addAll(t);
    }
    return Uint8List.fromList(okm.sublist(0, length));
  }

  // NIP-44 message padding (fingerprint-resistant size bucketing)
  static int _calcPaddedLen(int msgLen) {
    if (msgLen == 0) {
      throw Exception('Nip44: empty message');
    }
    if (msgLen <= 32) {
      return 32;
    }
    int next = 1;
    while (next < msgLen) {
      next <<= 1;
    }
    final int chunk = (next >> 3) < 32 ? 32 : (next >> 3);
    return chunk * ((msgLen + chunk - 1) ~/ chunk);
  }

  static Uint8List _padMessage(String plaintext) {
    final Uint8List msg = Uint8List.fromList(utf8.encode(plaintext));
    final int pLen = _calcPaddedLen(msg.length);
    final Uint8List out = Uint8List(pLen + 2);
    out[0] = (msg.length >> 8) & 0xff;
    out[1] = msg.length & 0xff;
    out.setAll(2, msg);
    return out;
  }

  static String _unpadMessage(Uint8List data) {
    final int msgLen = (data[0] << 8) | data[1];
    if (msgLen < 1 || msgLen + 2 > data.length) {
      throw Exception('Nip44: invalid padding');
    }
    return utf8.decode(data.sublist(2, 2 + msgLen));
  }

  static Uint8List _chacha20(
      bool forEncrypt, Uint8List key, Uint8List nonce12, Uint8List data) {
    final ChaCha7539Engine engine = ChaCha7539Engine();
    engine.init(forEncrypt, ParametersWithIV<KeyParameter>(KeyParameter(key), nonce12));
    final Uint8List out = Uint8List(data.length);
    engine.processBytes(data, 0, data.length, out, 0);
    return out;
  }

  // ─── Public API ──────────────────────────────────────────────────────────

  /// Encrypt [plaintext] from [senderPrivHex] to [recipientPubHex].
  /// Returns base64-encoded NIP-44 v2 payload.
  static String encrypt(
    String plaintext,
    String senderPrivHex,
    String recipientPubHex,
  ) {
    final Uint8List sharedX = _ecdh(senderPrivHex, recipientPubHex);
    final Uint8List convKey = _hkdfExtract(sharedX);

    final Uint8List nonce = Uint8List.fromList(
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    );

    final Uint8List keys = _hkdfExpand(convKey, nonce, 76);
    final Uint8List chachaKey = keys.sublist(0, 32);
    final Uint8List chaChaNonce = keys.sublist(32, 44); // 12-byte IETF nonce
    final Uint8List hmacKey = keys.sublist(44, 76);

    final Uint8List padded = _padMessage(plaintext);
    final Uint8List ciphertext = _chacha20(true, chachaKey, chaChaNonce, padded);

    final Uint8List macInput = Uint8List(32 + ciphertext.length)
      ..setAll(0, nonce)
      ..setAll(32, ciphertext);
    final Uint8List mac = _hmacSha256(hmacKey, macInput);

    final Uint8List payload = Uint8List(1 + 32 + ciphertext.length + 32);
    payload[0] = 2; // version
    payload.setAll(1, nonce);
    payload.setAll(33, ciphertext);
    payload.setAll(33 + ciphertext.length, mac);
    return base64.encode(payload);
  }

  /// Decrypt a NIP-44 v2 [payload] for [recipientPrivHex] from [senderPubHex].
  static String decrypt(
    String payload,
    String recipientPrivHex,
    String senderPubHex,
  ) {
    final Uint8List bytes = base64.decode(payload);
    if (bytes.isEmpty || bytes[0] != 2) {
      throw Exception('Nip44: unsupported version ${bytes.isEmpty ? "empty" : bytes[0]}');
    }
    if (bytes.length < 99) {
      throw Exception('Nip44: payload too short (${bytes.length} bytes)');
    }

    final Uint8List nonce = bytes.sublist(1, 33);
    final Uint8List ciphertext = bytes.sublist(33, bytes.length - 32);
    final Uint8List mac = bytes.sublist(bytes.length - 32);

    final Uint8List sharedX = _ecdh(recipientPrivHex, senderPubHex);
    final Uint8List convKey = _hkdfExtract(sharedX);
    final Uint8List keys = _hkdfExpand(convKey, nonce, 76);
    final Uint8List chachaKey = keys.sublist(0, 32);
    final Uint8List chaChaNonce = keys.sublist(32, 44);
    final Uint8List hmacKey = keys.sublist(44, 76);

    // Constant-time MAC verification
    final Uint8List macInput = Uint8List(32 + ciphertext.length)
      ..setAll(0, nonce)
      ..setAll(32, ciphertext);
    final Uint8List expectedMac = _hmacSha256(hmacKey, macInput);
    int diff = 0;
    for (int i = 0; i < 32; i++) {
      diff |= mac[i] ^ expectedMac[i];
    }
    if (diff != 0) {
      throw Exception('Nip44: MAC verification failed');
    }

    final Uint8List padded = _chacha20(false, chachaKey, chaChaNonce, ciphertext);
    return _unpadMessage(padded);
  }
}
