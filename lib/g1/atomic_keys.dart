import 'dart:convert';
import 'dart:math';
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

/// saltRaw conforme à atomic.html : "${birthDtUtc}_${lat}_${lon}_${polarity}_${weight}_${birthHeight}_${currentHeight}"
String buildSaltRaw({
  required String birthDtUtc,
  required double birthLat,
  required double birthLon,
  required int polarity,
  required double weight,
  int birthHeightCm = 50,    // taille à la naissance (cm)
  int currentHeightCm = 170, // taille adulte actuelle (cm)
}) =>
    '${birthDtUtc}_'
    '${birthLat.toStringAsFixed(2)}_'
    '${birthLon.toStringAsFixed(2)}_'
    '${polarity}_'
    '${weight.toStringAsFixed(1)}_'
    '${birthHeightCm}_'
    '$currentHeightCm';

/// pepperRaw conforme à atomic.html : "${conDtUtc}_${conLat}_${conLon}_${weight}_${birthHeight}"
String buildPepperRaw({
  required String conDtUtc,
  required double conLat,
  required double conLon,
  required double weight,
  int birthHeightCm = 50, // taille à la naissance (cm)
}) =>
    '${conDtUtc}_'
    '${conLat.toStringAsFixed(2)}_'
    '${conLon.toStringAsFixed(2)}_'
    '${weight.toStringAsFixed(1)}_'
    '$birthHeightCm';

// ── Conversion heure solaire locale → UTC "YYYYMMDDHHMM" ────────────────────
// Conforme à atomic.html _dateToUtcUnix() + _unixToUtcStr().
// offset total = longitude × 4 min/° + équation du temps (≤ ±16 min saisonnier).

/// Correction saisonnière midi solaire vs midi civil (minutes).
/// Formule identique à atomic.html _equationOfTime().
double _equationOfTime(int year, int month, int day) {
  final int doy = DateTime.utc(year, month, day)
          .difference(DateTime.utc(year))
          .inDays +
      1;
  final double b = (2 * pi / 365) * (doy - 81);
  return 9.87 * sin(2 * b) - 7.53 * cos(b) - 1.5 * sin(b);
}

/// Convertit une heure solaire locale + longitude en chaîne UTC "YYYYMMDDHHMM".
///
/// Identique à `_dateToUtcUnix(date, time, lon)` suivi de `_unixToUtcStr()`
/// dans atomic.html. Précision : minute. Aucune dépendance timezone système.
String localSolarToUtcStr(
    int year, int month, int day, int hour, int minute, double lonDeg) {
  final double offsetMin =
      lonDeg * 4.0 + _equationOfTime(year, month, day);
  final int utcMin = (hour * 60 + minute - offsetMin).round();
  // DateTime.utc normalise les débordements minuit (utcMin < 0 ou > 1439)
  final DateTime utcDt =
      DateTime.utc(year, month, day).add(Duration(minutes: utcMin));
  return '${utcDt.year.toString().padLeft(4, '0')}'
      '${utcDt.month.toString().padLeft(2, '0')}'
      '${utcDt.day.toString().padLeft(2, '0')}'
      '${utcDt.hour.toString().padLeft(2, '0')}'
      '${utcDt.minute.toString().padLeft(2, '0')}';
}
