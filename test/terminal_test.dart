import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/ui/ui_helpers.dart';

void main() {
  group('calculate function with integers', () {
    test('should sum simple integers', () {
      final double result =
          calculate(textInTerminal: '1 + 2 + 3', decimalSep: ',');
      expect(result, equals(6));
    });

    test('should sum integers with comma separator', () {
      final double result =
          calculate(textInTerminal: '10 + 20 + 30', decimalSep: ',');
      expect(result, equals(60));
    });

    test('should handle single integer', () {
      final double result = calculate(textInTerminal: '42', decimalSep: ',');
      expect(result, equals(42));
    });
  });

  group('calculate function with decimals', () {
    test('should sum decimals with dot separator', () {
      final double result =
          calculate(textInTerminal: '1.5 + 2.5', decimalSep: '.');
      expect(result, equals(4));
    });

    test('should sum decimals with comma separator', () {
      final double result =
          calculate(textInTerminal: '1,5 + 2,5', decimalSep: ',');
      expect(result, equals(4));
    });

    test('should handle mixed integers and decimals', () {
      final double result =
          calculate(textInTerminal: '1 + 2,5', decimalSep: ',');
      expect(result, equals(3.5));
    });

    test('should handle multiple decimals in sum', () {
      final double result =
          calculate(textInTerminal: '1,1 + 3,1', decimalSep: ',');
      expect(result, equals(4.2));
    });

    test('should handle decimal starting with separator', () {
      final double result =
          calculate(textInTerminal: ',1 + 3,1', decimalSep: ',');
      expect(result, equals(3.2));
    });

    test('should handle three decimal numbers', () {
      final double result =
          calculate(textInTerminal: '1,5 + 2,3 + 0,7', decimalSep: ',');
      expect(result, equals(4.5));
    });

    test('should handle decimals with two decimal places', () {
      final double result =
          calculate(textInTerminal: '10,25 + 5,50 + 3,75', decimalSep: ',');
      expect(result, equals(19.5));
    });

    test('should handle decimals with dot separator and multiple places', () {
      final double result =
          calculate(textInTerminal: '10.25 + 5.50 + 3.75', decimalSep: '.');
      expect(result, equals(19.5));
    });
  });

  group('calculate function edge cases', () {
    test('should handle empty string', () {
      final double result = calculate(textInTerminal: '', decimalSep: ',');
      expect(result, equals(0));
    });

    test('should handle single decimal separator', () {
      final double result = calculate(textInTerminal: ',', decimalSep: ',');
      expect(result, equals(0));
    });

    test('should handle only plus signs', () {
      final double result = calculate(textInTerminal: '+++', decimalSep: ',');
      expect(result, equals(0));
    });

    test('should handle very small decimals', () {
      final double result =
          calculate(textInTerminal: '0,01 + 0,02 + 0,03', decimalSep: ',');
      expect(result, closeTo(0.06, 0.0001));
    });

    test('should handle large numbers', () {
      final double result =
          calculate(textInTerminal: '1000,50 + 2000,75', decimalSep: ',');
      expect(result, equals(3001.25));
    });
  });

  group('calculate function with spaces', () {
    test('should handle numbers with spaces', () {
      final double result =
          calculate(textInTerminal: '1 + 2 + 3', decimalSep: ',');
      expect(result, equals(6));
    });

    test('should handle numbers without spaces', () {
      final double result = calculate(textInTerminal: '1+2+3', decimalSep: ',');
      expect(result, equals(6));
    });

    test('should handle numbers with multiple spaces', () {
      final double result =
          calculate(textInTerminal: '1  +  2  +  3', decimalSep: ',');
      expect(result, equals(6));
    });
  });
}
