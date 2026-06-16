import 'dart:math';

// ── Résultat KIN ─────────────────────────────────────────────────────────────

class KinResult {
  const KinResult({
    required this.kin,
    required this.glyph,
    required this.tone,
    required this.toneNumber,
    required this.color,
    required this.action,
    required this.power,
    required this.essence,
  });

  final int kin;
  final String glyph;
  final String tone;
  final int toneNumber; // 1–13
  final String color;
  final String action;
  final String power;
  final String essence;
}

// ── Tables Tzolkin ────────────────────────────────────────────────────────────

const List<String> kinGlyphs = <String>[
  'Imix', 'Ik', 'Akbal', 'Kan', 'Chicchan',
  'Cimi', 'Manik', 'Lamat', 'Muluc', 'Oc',
  'Chuen', 'Eb', 'Ben', 'Ix', 'Men',
  'Cib', 'Caban', 'Etznab', 'Cauac', 'Ahau',
];

const List<String> kinTones = <String>[
  'Magnétique', 'Lunaire', 'Électrique', 'Auto-existante', 'Harmonique',
  'Rythmique', 'Résonnante', 'Galactique', 'Solaire', 'Planétaire',
  'Spectrale', 'Cristal', 'Cosmique',
];

const List<String> kinColors = <String>[
  'Rouge', 'Blanc', 'Bleu', 'Jaune', 'Vert',
];

// Action | Pouvoir | Essence — indexé par tone_idx (0–12)
const List<(String, String, String)> kinToneKeys = <(String, String, String)>[
  ('Unifier',       'Unification',    'Présence'),
  ('Polariser',     'Stabilisation',  'Définition'),
  ('Activer',       'Activation',     'Unification'),
  ('Définir',       'Mesure',         'Définition'),
  ('Commander',     'Commandement',   'Pouvoir'),
  ('Organiser',     'Organisation',   'Équilibre'),
  ('Canaliser',     'Inspiration',    'Canalisation'),
  ('Harmoniser',    'Harmonisation',  'Modélisation'),
  ('Réaliser',      'Réalisation',    'Impulsion'),
  ('Perfectionner', 'Perfectionnement','Production'),
  ('Dissoudre',     'Dissolution',    'Abandon'),
  ('Universaliser', 'Dédication',     'Universalisation'),
  ('Transcender',   'Confrontation',  'Transcendance'),
];

// ── Port de calculate_maya_kin() de kin.sh ────────────────────────────────────
// meses[]: décalages mensuels (1-indexed), identiques à kin.sh
const List<int> _meses = <int>[0, 31, 59, 90, 120, 151, 181, 212, 243, 13, 44, 74];

// sumaAnio: year%52 → décalage annuel. Clés 33 et 43 absentes → 0 par défaut.
// [42]=222 est la valeur finale (la déclaration [42]=67 dans kin.sh est écrasée).
const Map<int, int> _sumaAnio = <int, int>{
  30: 2,   35: 7,   40: 12,  45: 17,  50: 22,  3: 27,
  8: 32,   13: 37,  18: 42,  23: 47,  28: 52,  32: 57,
  38: 62,  42: 222, 48: 72,  1: 76,   6: 82,   11: 87,
  16: 92,  21: 97,  26: 102, 31: 107, 36: 112, 41: 117,
  46: 122, 51: 127, 4: 132,  9: 137,  14: 142, 19: 147,
  24: 152, 29: 157, 34: 162, 39: 167, 44: 172, 49: 177,
  2: 182,  7: 187,  12: 192, 17: 197, 22: 202, 27: 207,
  37: 217, 47: 227, 0: 232,  5: 237,  10: 242, 15: 247,
  20: 252, 25: 257,
};

/// Calcule le KIN Maya (Tzolkin) à partir d'une date.
/// Port exact de `calculate_maya_kin()` de `Astroport.ONE/tools/kin.sh`.
KinResult calculateMayaKin(DateTime date) {
  final int year  = date.year;
  final int month = date.month;
  final int day   = date.day;

  final int numMes    = _meses[month - 1];
  final int sumaAnio  = _sumaAnio[year % 52] ?? 0;
  int kin             = day + numMes + sumaAnio;
  if (kin > 260) {
    kin -= 260;
  }

  final int glyphIdx = (kin - 1) % 20;
  final int toneIdx  = (kin - 1) % 13;
  final int colorIdx = ((kin - 1) ~/ 13) % 5;

  final (String action, String power, String essence) = kinToneKeys[toneIdx];

  return KinResult(
    kin:       kin,
    glyph:     kinGlyphs[glyphIdx],
    tone:      kinTones[toneIdx],
    toneNumber: toneIdx + 1,
    color:     kinColors[colorIdx],
    action:    action,
    power:     power,
    essence:   essence,
  );
}

/// KIN de conception ≈ naissance − 280 jours.
KinResult calculateConceptionKin(DateTime birthDate) {
  return calculateMayaKin(birthDate.subtract(const Duration(days: 280)));
}

// ── omegaBio ─────────────────────────────────────────────────────────────────

/// Fréquence biologique personnelle.
/// Approx. de `Phi2X.computeOmegaBio(height, weight, polarity)` d'atomic.html.
/// root = 110 Hz (A2), élevé à la puissance du rapport tone/PHI.
double computeOmegaBio(int kinTone, int polarity) {
  const double phi  = 1.6180339887;
  const double root = 110.0; // A2
  return root * pow(phi, (kinTone - 1) / (polarity == 0 ? 6.0 : 7.0));
}
