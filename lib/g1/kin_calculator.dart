import 'phi2x.dart';

// ── Résultat KIN ─────────────────────────────────────────────────────────────

class KinResult {
  const KinResult({
    required this.kin,
    required this.glyph,
    required this.glyphFr,
    required this.tone,
    required this.toneNumber,
    required this.color,
    required this.action,
    required this.power,
    required this.essence,
    required this.lfoHz,
  });

  final int kin;
  final String glyph;      // Nom yucatèque (Imix, Ik…)
  final String glyphFr;    // Nom français (Dragon, Vent…)
  final String tone;       // Nom de la tonalité
  final int toneNumber;    // 1–13
  final String color;      // Rouge | Blanc | Bleu | Jaune | Vert
  final String action;
  final String power;
  final String essence;
  final double lfoHz;      // (toneNumber) × 0.15 — orchestre audio
}

// ── Tables Tzolkin ────────────────────────────────────────────────────────────
// Synchronisé avec phi2x.py, phi2x.js, Phi2X_Math.gd

const List<String> kinGlyphs = <String>[
  'Imix', 'Ik', 'Akbal', 'Kan', 'Chicchan',
  'Cimi', 'Manik', 'Lamat', 'Muluc', 'Oc',
  'Chuen', 'Eb', 'Ben', 'Ix', 'Men',
  'Cib', 'Caban', 'Etznab', 'Cauac', 'Ahau',
];

const List<String> kinGlyphsFr = <String>[
  'Dragon', 'Vent', 'Nuit', 'Graine', 'Serpent',
  'Lieur', 'Main', 'Étoile', 'Lune', 'Chien',
  'Singe', 'Chemin', 'Roseau', 'Jaguar', 'Aigle',
  'Guerrier', 'Terre', 'Miroir', 'Tempête', 'Soleil',
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
  ('Unifier',       'Unification',     'Présence'),
  ('Polariser',     'Stabilisation',   'Définition'),
  ('Activer',       'Activation',      'Unification'),
  ('Définir',       'Mesure',          'Définition'),
  ('Commander',     'Commandement',    'Pouvoir'),
  ('Organiser',     'Organisation',    'Équilibre'),
  ('Canaliser',     'Inspiration',     'Canalisation'),
  ('Harmoniser',    'Harmonisation',   'Modélisation'),
  ('Réaliser',      'Réalisation',     'Impulsion'),
  ('Perfectionner', 'Perfectionnement','Production'),
  ('Dissoudre',     'Dissolution',     'Abandon'),
  ('Universaliser', 'Dédication',      'Universalisation'),
  ('Transcender',   'Confrontation',   'Transcendance'),
];

// ── Algorithme Tzolkin ────────────────────────────────────────────────────────
// Port de calc_kin() de phi2x.py / calcKin() de phi2x.js.
// KIN_MESES et KIN_SUMA sont IDENTIQUES dans phi2x.py, phi2x.js et Phi2X_Math.gd.

const List<int> _meses = <int>[
  0, 31, 59, 90, 120, 151, 181, 212, 243, 13, 44, 74,
];

// KIN_SUMA[year % 52] → décalage. Clés 33 et 43 absentes → 0 par défaut.
// VALEUR CANONIQUE : 42 → 67 (conforme phi2x.py/phi2x.js — pas 222 comme dans kin.sh).
const Map<int, int> _kinSuma = <int, int>{
  30: 2,   35: 7,   40: 12,  45: 17,  50: 22,  3: 27,
  8: 32,   13: 37,  18: 42,  23: 47,  28: 52,  32: 57,
  38: 62,  42: 67,  48: 72,  1: 76,   6: 82,   11: 87,
  16: 92,  21: 97,  26: 102, 31: 107, 36: 112, 41: 117,
  46: 122, 51: 127, 4: 132,  9: 137,  14: 142, 19: 147,
  24: 152, 29: 157, 34: 162, 39: 167, 44: 172, 49: 177,
  2: 182,  7: 187,  12: 192, 17: 197, 22: 202, 27: 207,
  37: 217, 47: 227, 0: 232,  5: 237,  10: 242, 15: 247,
  20: 252, 25: 257,
};

/// Calcule le KIN Maya (Tzolkin) à partir d'une date.
/// Port exact de calc_kin() de phi2x.py (référence canonique).
KinResult calculateMayaKin(DateTime date) {
  final int year  = date.year;
  final int month = date.month;
  final int day   = date.day;

  int kin = day + _meses[month - 1] + (_kinSuma[year % 52] ?? 0);
  if (kin > 260) {
    kin -= 260;
  }
  if (kin <= 0) {
    kin += 260;
  }

  final int glyphIdx = (kin - 1) % 20;
  final int toneIdx  = (kin - 1) % 13;
  final int colorIdx = ((kin - 1) ~/ 13) % 5;

  final (String action, String power, String essence) = kinToneKeys[toneIdx];

  return KinResult(
    kin:        kin,
    glyph:      kinGlyphs[glyphIdx],
    glyphFr:    kinGlyphsFr[glyphIdx],
    tone:       kinTones[toneIdx],
    toneNumber: toneIdx + 1,
    color:      kinColors[colorIdx],
    action:     action,
    power:      power,
    essence:    essence,
    lfoHz:      (toneIdx + 1) * 0.15, // conforme phi2x.js: (ti+1)*0.15
  );
}

/// KIN de conception : déduit par phi2x — gestation = 280 + (weight − 3.5) × 4 jours.
/// [weight] : poids de naissance en kg (défaut 3.5).
KinResult calculateConceptionKin(DateTime birthDate, {double weight = 3.5}) {
  final int birthUnix    = birthDate.millisecondsSinceEpoch ~/ 1000;
  final int concepUnix   = phi2xComputeConceptionUnix(birthUnix, weightKg: weight);
  final DateTime concepDt = DateTime.fromMillisecondsSinceEpoch(concepUnix * 1000, isUtc: true);
  return calculateMayaKin(concepDt);
}
