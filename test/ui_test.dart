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
}
