import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';

/// Port Dart canonique de phi2x.py / phi2x.js (UPlanet/earth/phi2x.js).
///
/// TOUTES les constantes et formules sont synchronisées avec :
///   - Astroport.ONE/tools/phi2x.py   (Python — newsletters, KIN.daily)
///   - UPlanet/earth/phi2x.js         (JavaScript/Web — atomic.html)
///   - cabine-33/autoloads/Phi2X_Math.gd (GDScript — app Godot)

// ── Constantes canoniques ─────────────────────────────────────────────────────

const double phi2xPhi          = 1.6180339887;
const double phi2xFPhi         = 33.17;          // Hz
const double phi2xF2           = 31.32;          // Hz
const double phi2xFWater       = 429.62;         // Hz — fréquence eau physiologique
const double phi2xWaveStretch  = phi2xFPhi / phi2xF2;  // ≈ 1.059
const double phi2xTau          = 2 * pi;
const double phi2xOrbitalYearS = 365.25636 * 86400; // Année sidérale [s]
const double phi2xOrbitalDayS  = 86400.0;           // Jour [s]
const double phi2xAlphaShapiro = 1.0 / 137.035999084; // ≈ 0.00729735

// 12 pentagones du polyèdre de Goldberg (époque J2000, [lat, lon])
const List<List<double>> phi2xPentagonsGps = <List<double>>[
  <double>[ 90.0,    0.0], <double>[-90.0,   0.0],
  <double>[ 26.56,   0.0], <double>[ 26.56,  72.0], <double>[ 26.56, 144.0],
  <double>[ 26.56, -72.0], <double>[ 26.56,-144.0],
  <double>[-26.56,  36.0], <double>[-26.56, 108.0], <double>[-26.56, 180.0],
  <double>[-26.56, -36.0], <double>[-26.56,-108.0],
];

// ── Haversine ─────────────────────────────────────────────────────────────────

double phi2xHaversineKm(double lat1, double lon1, double lat2, double lon2) {
  const double r   = 6371.0;
  final double p1  = lat1 * pi / 180;
  final double p2  = lat2 * pi / 180;
  final double dp  = (lat2 - lat1) * pi / 180;
  final double dl  = (lon2 - lon1) * pi / 180;
  final double a   = sin(dp / 2) * sin(dp / 2)
      + cos(p1) * cos(p2) * sin(dl / 2) * sin(dl / 2);
  return r * 2 * atan2(sqrt(a), sqrt(1 - a));
}

// ── Pentagon offset (moyenne circulaire pondérée exponentielle) ───────────────

double phi2xPentagonOffset(double lat, double lon) {
  double sumSin = 0, sumCos = 0;
  for (int i = 0; i < phi2xPentagonsGps.length; i++) {
    final double plat = phi2xPentagonsGps[i][0];
    final double plon = phi2xPentagonsGps[i][1];
    final double d    = phi2xHaversineKm(lat, lon, plat, plon);
    final double w    = exp(-d / 1500.0);
    final double angle = i / 12.0 * phi2xTau;
    sumSin += sin(angle) * w;
    sumCos += cos(angle) * w;
  }
  final double result = atan2(sumSin, sumCos);
  return result >= 0 ? result : result + phi2xTau;
}

// ── Phase personnelle φ_i ─────────────────────────────────────────────────────

/// φ_i ∈ [0, 2π) — identique à computePersonalPhase() de phi2x.js.
/// [birthUnix] : timestamp Unix UTC de naissance.
/// [utcOffsetH] : décalage UTC [heures] (0 = correction solaire seule).
double phi2xComputePersonalPhase(
    int birthUnix, double birthLat, double birthLon,
    {double utcOffsetH = 0.0}) {
  final double utcCorr      = -utcOffsetH * 3600.0;
  final double birthUnixUtc = birthUnix + utcCorr;
  final double solarCorr    = birthLon / 360.0 * phi2xOrbitalDayS;
  final double tAnn = (birthUnixUtc % phi2xOrbitalYearS) / phi2xOrbitalYearS * phi2xTau;
  final double tDay = ((birthUnixUtc + solarCorr) % phi2xOrbitalDayS) / phi2xOrbitalDayS * phi2xTau;
  final double penta = phi2xPentagonOffset(birthLat, birthLon);
  return ((tAnn + tDay + penta) * phi2xWaveStretch) % phi2xTau;
}

// ── Compression gravitationnelle (effet Shapiro) ──────────────────────────────

double phi2xComputePersonalStretch(double weightKg) {
  final double w = weightKg < 0.5 ? 0.5 : weightKg;
  return phi2xWaveStretch * exp(-phi2xAlphaShapiro * (w / 3.5));
}

/// φ_i avec compression gravitationnelle (poids de naissance).
double phi2xComputePersonalPhaseWeighted(
    int birthUnix, double birthLat, double birthLon,
    {double weightKg = 3.5, double utcOffsetH = 0.0}) {
  final double stretch      = phi2xComputePersonalStretch(weightKg);
  final double utcCorr      = -utcOffsetH * 3600.0;
  final double birthUnixUtc = birthUnix + utcCorr;
  final double solarCorr    = birthLon / 360.0 * phi2xOrbitalDayS;
  final double tAnn = (birthUnixUtc % phi2xOrbitalYearS) / phi2xOrbitalYearS * phi2xTau;
  final double tDay = ((birthUnixUtc + solarCorr) % phi2xOrbitalDayS) / phi2xOrbitalDayS * phi2xTau;
  final double penta = phi2xPentagonOffset(birthLat, birthLon);
  return ((tAnn + tDay + penta) * stretch) % phi2xTau;
}

// ── ω_bio ─────────────────────────────────────────────────────────────────────

/// ω_bio = F_WATER × (water_kg / 70)
/// sex=0 → PHI-wave (65% eau) · sex=1 → Octave-wave (60% eau).
/// Port exact de compute_omega_bio() de phi2x.py.
double phi2xComputeOmegaBio(double weightKg, int sex) {
  final double waterRatio = sex == 0 ? 0.65 : 0.60;
  final double waterKg    = weightKg * waterRatio;
  return phi2xFWater * (waterKg / 70.0);
}

/// Ramène omegaBio dans la gamme audible [root, root×4) en doublant d'octaves.
double phi2xToAudible(double omegaBio, {double root = 110.0}) {
  double f = omegaBio;
  while (f < root) {
    f *= 2;
  }
  while (f >= root * 4) {
    f /= 2;
  }
  return f;
}

// ── Résonance k ───────────────────────────────────────────────────────────────

/// k = 1 / (1 + |sin(Δφ)|) ∈ [0.5, 1.0]
double phi2xComputeResonanceK(double phiI, double phiJ) =>
    1.0 / (1.0 + sin(phiI - phiJ).abs());

// ── Gestation ─────────────────────────────────────────────────────────────────

/// Déduire l'Unix de conception : gestation_days = 280 + (weight − 3.5) × 4
int phi2xComputeConceptionUnix(int birthUnix, {double weightKg = 3.5}) {
  final double w = weightKg < 0.5 ? 0.5 : weightKg;
  final double gestationS = (280.0 + (w - 3.5) * 4.0) * phi2xOrbitalDayS;
  return (birthUnix - gestationS).round();
}

// ── a4l_proof (NIP-101 / Kind 30078) ─────────────────────────────────────────

/// SHA256(pubkeyHex + ":" + appSalt) — vérifié par NIP-101/filter/30078.sh
String phi2xComputeA4lProof(String hexPubkey,
    {String appSalt = 'ATOM4LOVE_ALPHA'}) {
  final Uint8List input = Uint8List.fromList(
      '$hexPubkey:$appSalt'.codeUnits,
  );
  return HEX.encode(sha256.convert(input).bytes);
}
