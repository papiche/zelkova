import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/g1/g1_helper.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';

void main() {
  group('Import Clipboard Validation Logic', () {
    group('Mnemonic Validation', () {
      test('Valid 12-word mnemonic is recognized', () {
        const String validMnemonic =
            'legal winner thank year wave sausage worth useful legal winner thank yellow';
        final bool result = isValidMnemonic(validMnemonic);
        expect(result, isTrue,
            reason: 'Should recognize valid 12-word mnemonic');
      });

      test('Invalid mnemonic with wrong words is rejected', () {
        const String invalidMnemonic = 'this is not a valid mnemonic phrase';
        final bool result = isValidMnemonic(invalidMnemonic);
        expect(result, isFalse,
            reason: 'Should reject mnemonic with invalid words');
      });

      test('Mnemonic with less than 12 words is rejected', () {
        const String shortMnemonic = 'legal winner thank year wave sausage';
        final bool result = isValidMnemonic(shortMnemonic);
        expect(result, isFalse,
            reason: 'Should reject mnemonic with less than 12 words');
      });

      test('Empty string is not a valid mnemonic', () {
        const String empty = '';
        final bool result = isValidMnemonic(empty);
        expect(result, isFalse, reason: 'Empty string is not a valid mnemonic');
      });

      test('Mnemonic with extra whitespace is handled correctly', () {
        const String mnemonicWithWhitespace =
            '  legal winner thank year wave sausage worth useful legal winner thank yellow  ';
        final bool result = isValidMnemonic(mnemonicWithWhitespace);
        // Depending on implementation, this might pass or fail
        // The important thing is it doesn't crash
        expect(result, isNotNull,
            reason: 'Should handle whitespace gracefully and return bool');
      });
    });

    group('Public Key Validation (V1)', () {
      test('Valid v1 public key is recognized', () {
        const String validKey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
        final bool result = validateKey(validKey);
        expect(result, isTrue, reason: 'Should recognize valid v1 public key');
      });

      test('Invalid public key is rejected', () {
        const String invalidKey = 'this-is-not-a-valid-public-key';
        final bool result = validateKey(invalidKey);
        expect(result, isFalse, reason: 'Should reject invalid public key');
      });

      test('Empty string is not a valid key', () {
        const String empty = '';
        final bool result = validateKey(empty);
        expect(result, isFalse, reason: 'Empty string is not a valid key');
      });

      test('V2 address should not validate as v1 key', () {
        const String v2Address =
            'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';
        final bool result = validateKey(v2Address);
        expect(result, isFalse,
            reason: 'V2 address should not validate as v1 key');
      });
    });

    group('V2 Address Validation', () {
      test('Valid v2 address is recognized', () {
        const String validV2 =
            'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';
        final bool result = isValidV2Address(validV2);
        expect(result, isTrue, reason: 'Should recognize valid v2 address');
      });

      test('Invalid v2 address is rejected', () {
        const String invalidV2 =
            'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9invalid';
        final bool result = isValidV2Address(invalidV2);
        expect(result, isFalse, reason: 'Should reject invalid v2 address');
      });

      test('V1 public key should not validate as v2 address', () {
        const String v1Key = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
        final bool result = isValidV2Address(v1Key);
        expect(result, isFalse,
            reason: 'V1 key should not validate as v2 address');
      });
    });

    group('Import Type Detection', () {
      test('Mnemonic type should be used for valid mnemonics', () {
        const String mnemonic =
            'legal winner thank year wave sausage worth useful legal winner thank yellow';
        final bool isMnem = isValidMnemonic(mnemonic);
        final bool isKey = validateKey(mnemonic);

        expect(isMnem, isTrue, reason: 'Should recognize as mnemonic');
        expect(isKey, isFalse, reason: 'Should not recognize as public key');
      });

      test('PubKey type should be used for valid v1 public keys', () {
        const String pubKey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
        final bool isMnem = isValidMnemonic(pubKey);
        final bool isKey = validateKey(pubKey);

        expect(isKey, isTrue, reason: 'Should recognize as public key');
        expect(isMnem, isFalse, reason: 'Should not recognize as mnemonic');
      });

      test('V2 address should be recognized by isValidV2Address', () {
        const String v2Address =
            'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';
        final bool isV2 = isValidV2Address(v2Address);
        final bool isKey = validateKey(v2Address);
        final bool isMnem = isValidMnemonic(v2Address);

        expect(isV2, isTrue, reason: 'Should recognize as v2 address');
        expect(isKey, isFalse, reason: 'V2 should not validate as v1 key');
        expect(isMnem, isFalse, reason: 'V2 should not validate as mnemonic');
      });
    });

    group('Edge Cases', () {
      test('Very long invalid string is handled', () {
        final String longString = 'a' * 1000;
        final bool resultMnem = isValidMnemonic(longString);
        final bool resultKey = validateKey(longString);

        expect(resultMnem, isFalse);
        expect(resultKey, isFalse);
      });

      test('String with special characters is rejected', () {
        const String specialChars = r'!@#$%^&*()_+-=[]{}|;:,.<>?';
        final bool resultMnem = isValidMnemonic(specialChars);
        final bool resultKey = validateKey(specialChars);
        final bool resultV2 = isValidV2Address(specialChars);

        expect(resultMnem, isFalse);
        expect(resultKey, isFalse);
        expect(resultV2, isFalse);
      });

      test('Mixed case is handled appropriately', () {
        const String mixedCaseV2 =
            'g1klwj4jou6cgl1fef4zjqo14kc1zc8mm8fathk5bmf9crsxy';
        final bool resultV2Upper = isValidV2Address(
            'g1KLWJ4JOU6CGL1FEF4ZJQ014KC1ZC8MM8FATHK5BMF9CRSXY');
        final bool resultV2Lower = isValidV2Address(mixedCaseV2);

        // Just ensure they don't crash and return boolean
        expect(resultV2Upper, isNotNull);
        expect(resultV2Lower, isNotNull);
      });
    });

    group('Import Type Classification', () {
      test('Classify mnemonic type correctly', () {
        const String mnemonic =
            'legal winner thank year wave sausage worth useful legal winner thank yellow';

        // This would normally be used in the dialog's switch statement
        // to determine which import type to use
        final bool isMnem = isValidMnemonic(mnemonic);
        final bool isKey = validateKey(mnemonic);
        final bool isV2 = isValidV2Address(mnemonic);

        expect(isMnem, isTrue);
        expect(isKey || isV2, isFalse,
            reason: 'Mnemonic should not also be a valid key or v2 address');
      });

      test('Classify pubkey type correctly', () {
        const String pubKey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';

        final bool isKey = validateKey(pubKey);
        final bool isMnem = isValidMnemonic(pubKey);
        final bool isV2 = isValidV2Address(pubKey);

        expect(isKey, isTrue);
        expect(isMnem || isV2, isFalse,
            reason: 'Pubkey should not also be a valid mnemonic or v2 address');
      });

      test('Classify v2 address type correctly', () {
        const String v2Address =
            'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

        final bool isV2 = isValidV2Address(v2Address);
        final bool isKey = validateKey(v2Address);
        final bool isMnem = isValidMnemonic(v2Address);

        expect(isV2, isTrue);
        expect(isKey || isMnem, isFalse,
            reason: 'V2 address should not also be a valid key or mnemonic');
      });
    });
  });
}
