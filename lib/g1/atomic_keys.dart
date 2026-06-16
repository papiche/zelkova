import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

// ── Entrée isolate pour Flutter compute() ─────────────────────────────────────

/// Calcule (stretchedSalt, stretchedPepper) depuis les chaînes brutes.
/// Conçu pour compute() : fonctions top-level, pas de closures.
(String, String) computeAtomicKeyPair((String, String) pair) =>
    (stretchKey(pair.$1), stretchKey(pair.$2));

// ── Cœur PBKDF2 ───────────────────────────────────────────────────────────────

/// PBKDF2-HMAC-SHA256, domain salt = 'uplanet-a4l-v1', 600k itérations, 256 bits.
/// Sortie : 43 chars base64url sans padding — identique à atomic.html _stretch().
String stretchKey(String raw) {
  final Uint8List domSalt = Uint8List.fromList(utf8.encode('uplanet-a4l-v1'));
  final Uint8List password = Uint8List.fromList(utf8.encode(raw));
  final PBKDF2KeyDerivator kdf = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
  kdf.init(Pbkdf2Parameters(domSalt, 600000, 32));
  return base64Url.encode(kdf.process(password)).replaceAll('=', '');
}

// ── Construction des chaînes brutes ──────────────────────────────────────────

/// saltRaw conforme à atomic.html : "${birthDtUtc}_${lat}_${lon}_${polarity}_${weight}"
String buildSaltRaw({
  required String birthDtUtc,
  required double birthLat,
  required double birthLon,
  required int polarity,
  required double weight,
}) =>
    '${birthDtUtc}_'
    '${birthLat.toStringAsFixed(2)}_'
    '${birthLon.toStringAsFixed(2)}_'
    '${polarity}_'
    '${weight.toStringAsFixed(1)}';

/// pepperRaw conforme à atomic.html : "${conDtUtc}_${conLat}_${conLon}_${weight}"
String buildPepperRaw({
  required String conDtUtc,
  required double conLat,
  required double conLon,
  required double weight,
}) =>
    '${conDtUtc}_'
    '${conLat.toStringAsFixed(2)}_'
    '${conLon.toStringAsFixed(2)}_'
    '${weight.toStringAsFixed(1)}';

/// Convertit un datetime local en chaîne UTC "YYYYMMDDHHMM"
/// conforme à atomic.html : utcOffset = round(lon / 15)
String localToUtcStr(DateTime local, int utcOffset) {
  final DateTime utc = local.subtract(Duration(hours: utcOffset));
  return '${utc.year.toString().padLeft(4, '0')}'
      '${utc.month.toString().padLeft(2, '0')}'
      '${utc.day.toString().padLeft(2, '0')}'
      '${utc.hour.toString().padLeft(2, '0')}'
      '${utc.minute.toString().padLeft(2, '0')}';
}
