import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/ui/ui_helpers.dart';

void main() {
  test('localizedParseToDouble parses a localized double string correctly', () {
    const String doubleString = '1.234,56';
    final double parsedDouble =
        parseToDoubleLocalized(locale: 'es', number: doubleString);
    expect(parsedDouble, equals(1234.56));
  });

  test('valid and invalid comments', () {
    const List<String> invalidText = <String>['á', '`e', 'ç', 'ñ', ','];
    const List<String> validText = <String>[
      'ab c de',
      'a b c d e',
      'a-b',
      'a_b',
      'a%',
      'a & b'
    ];
    for (final String text in invalidText) {
      expect(basicEnglishCharsRegExp.hasMatch(text), equals(false),
          reason: 'Failed $text');
    }
    for (final String text in validText) {
      expect(basicEnglishCharsRegExp.hasMatch(text), equals(true),
          reason: 'Failed $text');
    }
  });

  test('Valid decimal number - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '123.45');
    expect(result, null);
  });

  test('Valid decimal number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '123,45');
    expect(result, null);
  });

  test('Empty amount - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '');
    expect(result, null);
  });

  test('Amount starts with separator - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: ',45');
    expect(result, null);
  });

  test('Negative number - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '-123.45');
    expect(result, 'enter_a_positive_number');
  });

  test('Invalid number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '12a,45');
    expect(result, 'enter_a_valid_number');
  });

  test('Invalid number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '0.45');
    expect(result, 'enter_a_valid_number');
  });

  test('Invalid number - en', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en', amount: '0,45');
    expect(result, 'enter_a_valid_number');
  });
}
