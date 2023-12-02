import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/ui/ui_helpers.dart';

void main() {
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
      const String publicAddress = 'your_public_address';
      const Contact contact = Contact(pubKey: 'your_public_address');
      final String result =
          humanizeContact(publicAddress, contact, false, false, tr);
      expect(result, 'your_wallet');
    });

    test('Should return contact title if pubKey does not match publicAddress',
        () {
      const String publicAddress = 'your_public_address';
      const Contact contact =
          Contact(pubKey: 'other_public_address', name: 'John Doe');
      final String result = humanizeContact(publicAddress, contact);
      expect(result, 'John Doe');
    });

    test('Should return contact title with pubKey if addKey is true', () {
      const String publicAddress = 'your_public_address';
      const Contact contact =
          Contact(pubKey: 'other_public_address', name: 'John Doe');
      final String result = humanizeContact(publicAddress, contact, true);
      expect(result, 'John Doe (🔑 othe…ress)');
    });

    test(
        'Should return pubKey if addKey is true but title is the same as pubKey',
        () {
      const String publicAddress = 'other_public_address';
      const Contact contact = Contact(pubKey: 'your_public_address');
      final String result = humanizeContact(publicAddress, contact, true);
      expect(result, '🔑 your…ress');
    });
  });

  group('Contact', () {
    test('Should return correct title when name and nick are both provided',
        () {
      const Contact contact =
          Contact(pubKey: 'your_public_address', name: 'John', nick: 'JD');
      final String result = contact.title;
      expect(result, 'John (JD)');
    });

    test('Should return name when name and nick are the same', () {
      const Contact contact =
          Contact(pubKey: 'your_public_address', name: 'John', nick: 'John');
      final String result = contact.title;
      expect(result, 'John');
    });

    test('Should return name when name is provided and nick is null', () {
      const Contact contact =
          Contact(pubKey: 'your_public_address', name: 'John');
      final String result = contact.title;
      expect(result, 'John');
    });

    test('Should return nick when nick is provided and name is null', () {
      const Contact contact =
          Contact(pubKey: 'your_public_address', nick: 'JD');
      final String result = contact.title;
      expect(result, 'JD');
    });

    test(
        'Should return humanized pubKey when neither name nor nick is provided',
        () {
      const Contact contact = Contact(pubKey: 'your_public_address');
      final String result = contact.title;
      expect(result, '🔑 your…ress');
    });

    test('Should return subtitle when nick or name is provided', () {
      const Contact contact =
          Contact(pubKey: 'your_public_address', nick: 'JD');
      final String? result = contact.subtitle;
      expect(result, '🔑 your…ress');
    });

    test('Should return null subtitle when neither nick nor name is provided',
        () {
      const Contact contact = Contact(pubKey: 'your_public_address');
      final String? result = contact.subtitle;
      expect(result, isNull);
    });
  });
}
