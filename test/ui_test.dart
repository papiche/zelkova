import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/ui/ui_helpers.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  const String testPubKey = '7wnDh2FPdwNW8Dd5JyoJTbspuu8b9QJKps2xAYenefsu';
  const String otherTestPubKey = '7XtCpQSj8HRQxAD7rjZrMJ1knxBm6yx317R7sYzu3Hy6';

  test('localizedParseToDouble parses a localized double string correctly', () {
    const String doubleString = '1.234,56';
    final double parsedDouble =
        parseToDoubleLocalized(locale: 'es', number: doubleString);
    expect(parsedDouble, equals(1234.56));
  });

  test(
      'localizedParseToDouble parses a localized double zero ended string correctly',
      () {
    const String doubleString = '1.234,50';
    final double parsedDouble =
        parseToDoubleLocalized(locale: 'es', number: doubleString);
    expect(parsedDouble, equals(1234.5));
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
  String tr(String s) => s;

  test('Valid decimal number - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '123.45', tr: tr);
    expect(result, null);
  });

  test('Valid decimal number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '123,45', tr: tr);
    expect(result, null);
  });

  test('Empty amount - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '', tr: tr);
    expect(result, null);
  });

  test('Amount starts with separator - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: ',45', tr: tr);
    expect(result, null);
  });

  test('Amount starts with separator - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: ',45', tr: tr);
    expect(result, null);
  });

  test('Amount decimal ends with zero - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '2,40', tr: tr);
    expect(result, null);
  });

  test('Negative number - en_US', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en_US', amount: '-123.45', tr: tr);
    expect(result, 'enter_a_positive_number');
  });

  test('Invalid number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '12a,45', tr: tr);
    expect(result, 'enter_a_valid_number');
  });

  test('Invalid number - es_ES', () {
    final String? result =
        validateDecimal(sep: ',', locale: 'es_ES', amount: '0.45', tr: tr);
    expect(result, 'enter_a_valid_number');
  });

  test('Invalid number - en', () {
    final String? result =
        validateDecimal(sep: '.', locale: 'en', amount: '0,45', tr: tr);
    expect(result, 'enter_a_valid_number');
  });
  group('humanizeContact', () {
    test('Should return "your_wallet" if pubKey matches publicAddress', () {
      const String publicAddress = testPubKey;
      final Contact contact = Contact(pubKey: testPubKey);
      final String result =
          humanizeContact(publicAddress, contact, false, false, tr);
      expect(result, 'your_wallet');
    });

    test('Should return contact title if pubKey does not match publicAddress',
        () {
      const String publicAddress = testPubKey;
      final Contact contact =
          Contact(pubKey: otherTestPubKey, name: 'John Doe');
      final String result = humanizeContact(publicAddress, contact);
      expect(result, 'John Doe');
    });

    test('Should return contact title with pubKey if addKey is true', () {
      const String publicAddress = testPubKey;
      final Contact contact =
          Contact(pubKey: otherTestPubKey, name: 'John Doe');
      final String result = humanizeContact(publicAddress, contact, true);
      expect(result, 'John Doe (🗝 7XtC…3Hy6)');
    });

    test(
        'Should return pubKey if addKey is true but title is the same as pubKey',
        () {
      const String publicAddress = otherTestPubKey;
      final Contact contact = Contact(pubKey: testPubKey);
      final String result = humanizeContact(publicAddress, contact, true);
      expect(result, '🗝 7wnD…efsu');
    });
  });

  group('Contact', () {
    test('Should return correct title when name and nick are both provided',
        () {
      final Contact contact =
          Contact(pubKey: testPubKey, name: 'John', nick: 'JD');
      final String result = contact.title;
      expect(result, 'John (JD)');
    });

    test('Should return name when name and nick are the same', () {
      final Contact contact =
          Contact(pubKey: testPubKey, name: 'John', nick: 'John');
      final String result = contact.title;
      expect(result, 'John');
    });

    test('Should return name when name is provided and nick is null', () {
      final Contact contact = Contact(pubKey: testPubKey, name: 'John');
      final String result = contact.title;
      expect(result, 'John');
    });

    test('Should return nick when nick is provided and name is null', () {
      final Contact contact = Contact(pubKey: testPubKey, nick: 'JD');
      final String result = contact.title;
      expect(result, 'JD');
    });

    test(
        'Should return humanized pubKey when neither name nor nick is provided',
        () {
      final Contact contact = Contact(pubKey: testPubKey);
      final String result = contact.title;
      expect(result, '🗝 7wnD…efsu');
    });

    test('Should return subtitle when nick or name is provided', () {
      final Contact contact = Contact(pubKey: testPubKey, nick: 'JD');
      final String? result = contact.subtitle;
      expect(result, '🗝 7wnD…efsu');
    });

    test('Should return null subtitle when neither nick nor name is provided',
        () {
      final Contact contact = Contact(pubKey: testPubKey);
      final String? result = contact.subtitle;
      expect(result, isNull);
    });

    test('Correct time representation', () async {
      expect(
          humanizeTime(
              DateTime.fromMillisecondsSinceEpoch(1731098308 * 1000,
                  isUtc: true),
              'es',
              DateTime.parse('2024-11-08T20:38:28Z').toLocal()),
          'hace un momento');
      expect(
          humanizeTime(
              DateTime.fromMillisecondsSinceEpoch(1731098308 * 1000,
                  isUtc: true),
              'es',
              DateTime.parse('2024-11-08T20:40:00Z').toLocal()),
          'hace 2 minutos');
      await initializeDateFormatting('es'); // Inicializa el locale 'en'

      expect(
          humanizeTimeFull(
            utcDateTime: DateTime.fromMillisecondsSinceEpoch(1731098308 * 1000,
                isUtc: true),
            locale: 'es',
          ),
          '8/11/2024 21:38');
    });
  });
}
