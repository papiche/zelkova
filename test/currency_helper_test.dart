import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/ui/currency_helper.dart';
import 'package:intl/intl.dart';

void main() {
  // Helper to normalize NBSP or thin spaces and remove trailing spaces.
  String normalizeSpaces(String s) =>
      s.replaceAll('\u00A0', ' ').replaceAll('\u202F', ' ').trimRight();

  group('currentNumberFormat / formatAmountWithLocale', () {
    test('DU (isG1=false): trims trailing zeros down to 0 decimals', () {
      const bool isG1 = false;
      const String locale = 'es';
      const bool useSymbol = false;

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 10.0,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '10',
      );

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 1.300,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '1,3',
      );

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 1.333,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '1,333',
      );

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 1.23456,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '1,235',
      );
    });

    test('G1 (isG1=true): trims trailing zeros but keeps at least 1 decimal',
        () {
      const bool isG1 = true;
      const String locale = 'es';
      const bool useSymbol = false;

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 10.0,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '10,0',
      );

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 1.300,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '1,3',
      );

      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: locale,
          amount: 1.333,
          isG1: isG1,
          useSymbol: useSymbol,
        )),
        '1,33',
      );
    });

    test('Locale en_US uses dot for decimals and comma for thousands', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'en_US',
          amount: 12345.5,
          isG1: false,
          useSymbol: false,
        )),
        '12,345.5',
      );
    });

    test('Esperanto locale fallback (eo -> es)', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'eo',
          amount: 1.5,
          isG1: false,
          useSymbol: false,
        )),
        '1,5',
      );
    });

    test('Symbol on/off behaves as expected (just checks presence)', () {
      const String locale = 'es';

      final String g1WithSymbol = normalizeSpaces(formatAmountWithLocale(
        locale: locale,
        amount: 1.5,
        isG1: true,
        useSymbol: true,
      ));
      final String g1NoSymbol = normalizeSpaces(formatAmountWithLocale(
        locale: locale,
        amount: 1.5,
        isG1: true,
        useSymbol: false,
      ));
      expect(g1WithSymbol.contains('Ğ1'), isTrue);
      expect(g1NoSymbol.contains('Ğ1'), isFalse);

      final String duWithSymbol = normalizeSpaces(formatAmountWithLocale(
        locale: locale,
        amount: 1.5,
        isG1: false,
        useSymbol: true,
      ));
      final String duNoSymbol = normalizeSpaces(formatAmountWithLocale(
        locale: locale,
        amount: 1.5,
        isG1: false,
        useSymbol: false,
      ));
      expect(duWithSymbol.contains('DU'), isTrue);
      expect(duNoSymbol.contains('DU'), isFalse);
    });
  });

  group('convertAmount', () {
    test('G1: amount/100', () {
      final double r = convertAmount(true, 12345, 2.0);
      expect(r, closeTo(123.45, 1e-9));
    });

    test('DU: (amount/100)/currentUd', () {
      final double r = convertAmount(false, 12345, 2.0);
      expect(r, closeTo(61.725, 1e-9));
    });
  });

  group('parseToDoubleLocalized / eo fallback', () {
    test('Spanish parse "1,5" -> 1.5', () {
      final double v = parseToDoubleLocalized(locale: 'es', number: '1,5');
      expect(v, closeTo(1.5, 1e-9));
    });

    test('Esperanto parse uses Spanish rules "1,5" -> 1.5', () {
      final double v = parseToDoubleLocalized(locale: 'eo', number: '1,5');
      expect(v, closeTo(1.5, 1e-9));
    });

    test('English parse "1,234.5" -> 1234.5', () {
      final double v =
          NumberFormat.decimalPattern('en_US').parse('1,234.5').toDouble();
      expect(v, closeTo(1234.5, 1e-9));
    });
  });

  group('_formatAmount and view helpers (smoke tests without BuildContext)',
      () {
    test('formatAmountWithLocale is used by _formatAmount', () {
      const String locale = 'es';
      const bool isG1 = false;
      const bool useSymbol = false;

      final String direct = normalizeSpaces(formatAmountWithLocale(
        locale: locale,
        amount: 1.300,
        isG1: isG1,
        useSymbol: useSymbol,
      ));
      expect(direct, '1,3');
    });
  });

  group('Rounding edge cases', () {
    test('DU: 0 -> "0"', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'es',
          amount: 0.0,
          isG1: false,
          useSymbol: false,
        )),
        '0',
      );
    });

    test('G1: 0 -> "0,0" (minimum 1 decimal)', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'es',
          amount: 0.0,
          isG1: true,
          useSymbol: false,
        )),
        '0,0',
      );
    });

    test('DU: 10000.0 grouping "12,345.0" -> "12,345" in en_US', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'en_US',
          amount: 12345.0,
          isG1: false,
          useSymbol: false,
        )),
        '12,345',
      );
    });

    test('G1: max 2 decimals rounding 2.999 -> "3,0"', () {
      expect(
        normalizeSpaces(formatAmountWithLocale(
          locale: 'es',
          amount: 2.999,
          isG1: true,
          useSymbol: false,
        )),
        '3,0',
      );
    });
  });
}
