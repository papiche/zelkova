import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/ui/ui_helpers.dart';

void main() {
  test('Test calculate function with integers', () {
    final double result =
        calculate(textInTerminal: '1 + 2 + 3', decimalSep: ',');
    expect(result, equals(6));
  });

  test('Test calculate function with decimals', () {
    final double result =
        calculate(textInTerminal: '1.5 + 2.5', decimalSep: '.');
    expect(result, equals(4));
  });

  test('Test calculate function with negative numbers', () {
    final double result = calculate(textInTerminal: '1 + 2,5', decimalSep: ',');
    expect(result, equals(3.5));
  });

  test('Test calculate function with invalid numbers', () {
    final double result =
        calculate(textInTerminal: '1,1 + 3,1', decimalSep: ',');
    expect(result, equals(4.2));
  });

  test('Test calculate function with invalid numbers', () {
    final double result =
        calculate(textInTerminal: ',1 + 3,1', decimalSep: ',');
    expect(result, equals(3.2));
  });
}
