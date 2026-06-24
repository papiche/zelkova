import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/atomic_keys.dart';

/// Vecteurs de test validés contre atomic.html _dateToUtcUnix() + _unixToUtcStr().
/// Chaque cas vérifie que localSolarToUtcStr() produit le même résultat
/// que l'implémentation de référence JavaScript.
void main() {
  group('localSolarToUtcStr', () {
    // Paris (lon=2.35°) — 11 juillet 1984 08:30 solaire local
    //   lonMin = 2.35 × 4 = 9.4
    //   EoT(11 jul, doy=193): B=(2π/365)*(193-81)=1.9268 → ≈ -5.13 min
    //   offsetMin ≈ 4.27 → round → 4 min
    //   utcMin = 510 - 4 = 506 → 08:26
    test('Paris — correction longitude + EoT', () {
      expect(
        localSolarToUtcStr(1984, 7, 11, 8, 30, 2.35),
        '198407110826',
      );
    });

    // Sydney (lon=151.2°) — 15 février 1980 14:00 solaire local
    //   lonMin = 151.2 × 4 = 604.8
    //   EoT(15 fev, doy=46): B=(2π/365)*(46-81)=-0.6017 → ≈ -14.56 min
    //   offsetMin ≈ 590.24 → round → 590 min
    //   utcMin = 840 - 590 = 250 → 04:10
    test('Sydney — grand décalage est + EoT négatif hiver boréal', () {
      expect(
        localSolarToUtcStr(1980, 2, 15, 14, 0, 151.2),
        '198002150410',
      );
    });

    // Greenland (lon=-51.7°) — 21 mars 1990 12:00 (équinoxe, EoT ≈ 0)
    //   lonMin = -51.7 × 4 = -206.8
    //   EoT(21 mar, doy=80): B=(2π/365)*(80-81)=-0.01721 → ≈ 0.17 min
    //   offsetMin ≈ -206.63 → utcMin = 720 - (-207) = 927 min → 15:27
    test('Groenland — longitude négative (ouest)', () {
      expect(
        localSolarToUtcStr(1990, 3, 21, 12, 0, -51.7),
        '199003211527',
      );
    });

    // Minuit — débordement vers le jour précédent
    // Paris (lon=2.35°), 1 jan 2000 00:05 solaire local
    //   lonMin=9.4, EoT(1 jan, doy=1): B=(2π/365)*(-80)=-1.377 → ≈ -3.58 min
    //   offsetMin ≈ 5.82 → utcMin = 5 - 6 = -1 → veille 23:59
    test('Débordement minuit — jour précédent', () {
      final String result = localSolarToUtcStr(2000, 1, 1, 0, 5, 2.35);
      expect(result, '199912312359');
    });

    // UTC pur (lon=0°, EoT=0 autour de l'équinoxe) — doit rester inchangé
    test('Méridien de Greenwich — pas de correction', () {
      // 21 mars : EoT ≈ 0.17 min → round → 0 min
      expect(
        localSolarToUtcStr(2000, 3, 21, 10, 30, 0.0),
        '200003211030',
      );
    });
  });

  group('buildSaltRaw / buildPepperRaw', () {
    test('Format SALT — 7 champs séparés par _', () {
      final String s = buildSaltRaw(
        birthDtUtc: '198407110826',
        birthLat: 48.85,
        birthLon: 2.35,
        polarity: 0,
        weight: 3.5,
      );
      expect(s, '198407110826_48.85_2.35_0_3.5_50_170');
    });

    test('Format PEPPER — 5 champs séparés par _', () {
      final String p = buildPepperRaw(
        conDtUtc: '198409141200',
        conLat: 48.85,
        conLon: 2.35,
        weight: 3.5,
      );
      expect(p, '198409141200_48.85_2.35_3.5_50');
    });
  });
}
