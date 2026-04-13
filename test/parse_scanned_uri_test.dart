import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/payment_state.dart';
import 'package:zelkova/g1/g1_helper.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';

void main() {
  group('parseScannedUri - V1 PubKeys', () {
    const String v1PubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String v1PubKeyWithChecksum =
        '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH:HCT';

    test('should parse v1 pubkey without URI scheme', () {
      final PaymentState? result = parseScannedUri(v1PubKey);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(result.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, isNull);
      expect(result.comment, '');
    });

    test('should parse v1 pubkey with checksum', () {
      final PaymentState? result = parseScannedUri(v1PubKeyWithChecksum);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(extractPublicKey(result.contacts[0].pubKey), equals(v1PubKey));
    });

    test('should parse june:// URI with v1 pubkey', () {
      const String uri = 'june://$v1PubKey';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
    });

    test('should parse june:// URI with v1 pubkey and amount', () {
      const String uri = 'june://$v1PubKey?amount=10.5';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(10.5));
    });

    test('should parse june:// URI with v1 pubkey and comment', () {
      const String uri = 'june://$v1PubKey?comment=Test payment';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.comment, equals('Test payment'));
    });

    test('should parse june:// URI with v1 pubkey, amount and comment', () {
      const String uri = 'june://$v1PubKey?amount=25&comment=Test payment';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(25));
      expect(result.comment, equals('Test payment'));
    });

    test('should parse june:// URI with v1 pubkey, comment and amount', () {
      const String uri = 'june://$v1PubKey?comment=Test payment&amount=25';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(25));
      expect(result.comment, equals('Test payment'));
    });

    test('should parse duniter:key URI with v1 pubkey', () {
      const String uri = 'duniter:key/$v1PubKey';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
    });

    test('should parse URI-encoded june:// with v1 pubkey', () {
      final String uri =
          Uri.encodeFull('june://$v1PubKey?comment=My test comment');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.comment, equals('My test comment'));
    });
  });

  group('parseScannedUri - V2 Addresses', () {
    // Real v2 addresses from v2 tests - these correspond to known v1 pubkeys
    // v1: 6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH
    const String v2Address1 =
        'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM';
    const String v1PubKey1 = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    // v1: DU7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZ
    const String v2Address2 =
        'g1PAf1Dg6NAtsece62shM98dgmGiCF36PDJjfJ86aCYhe78XP';
    const String v1PubKey2 = 'DU7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZ';

    test('should parse v2 address without URI scheme', () {
      final PaymentState? result = parseScannedUri(v2Address1);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      // Contact stores v1 pubkey internally, but v2 address in address field
      expect(result.contacts[0].address, equals(v2Address1));
      expect(result.contacts[0].pubKey, equals(v1PubKey1));
      expect(result.amount, isNull);
      expect(result.comment, '');
    });

    test('should parse second v2 address without URI scheme', () {
      final PaymentState? result = parseScannedUri(v2Address2);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(result.contacts[0].address, equals(v2Address2));
      expect(result.contacts[0].pubKey, equals(v1PubKey2));
    });

    test('should validate v2 addresses are recognized', () {
      expect(isValidV2Address(v2Address1), isTrue);
      expect(isValidV2Address(v2Address2), isTrue);
    });

    test('should parse june:// URI with v2 address', () {
      const String uri = 'june://$v2Address1';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.contacts[0].pubKey, equals(v1PubKey1));
    });

    test('should parse june:// URI with v2 address and amount', () {
      const String uri = 'june://$v2Address2?amount=15.75';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.contacts[0].pubKey, equals(v1PubKey2));
      expect(result.amount, equals(15.75));
    });

    test('should parse june:// URI with v2 address and comment', () {
      const String uri = 'june://$v2Address1?comment=Payment for service';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.comment, equals('Payment for service'));
    });

    test('should parse june:// URI with v2 address, amount and comment', () {
      const String uri = 'june://$v2Address1?amount=50.25&comment=Invoice 123';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.amount, equals(50.25));
      expect(result.comment, equals('Invoice 123'));
    });

    test('should parse june:// URI with v2 address, comment and amount', () {
      const String uri =
          'june://$v2Address2?comment=Monthly subscription&amount=100';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.amount, equals(100));
      expect(result.comment, equals('Monthly subscription'));
    });

    test('should parse duniter:key URI with v2 address', () {
      const String uri = 'duniter:key/$v2Address1';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
    });

    test('should parse URI-encoded june:// with v2 address', () {
      final String uri =
          Uri.encodeFull('june://$v2Address2?comment=Special characters test');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.comment, equals('Special characters test'));
    });
  });

  group('parseScannedUri - V1 to V2 conversion tests', () {
    const String v1PubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String expectedV2Address =
        'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM';

    test('should convert v1 pubkey to v2 address correctly', () {
      final String v2Address = addressFromV1Pubkey(v1PubKey);
      expect(v2Address, equals(expectedV2Address));
    });

    test('should parse both v1 and v2 representations', () {
      final PaymentState? resultV1 = parseScannedUri(v1PubKey);
      final PaymentState? resultV2 = parseScannedUri(expectedV2Address);

      expect(resultV1, isNotNull);
      expect(resultV2, isNotNull);

      // Both should be parseable
      expect(resultV1!.contacts.length, equals(1));
      expect(resultV2!.contacts.length, equals(1));
    });
  });

  group('parseScannedUri - Invalid inputs', () {
    test('should return null for invalid v1 pubkey', () {
      const String invalidKey = 'invalid_key_123';
      final PaymentState? result = parseScannedUri(invalidKey);
      expect(result, isNull);
    });

    test('should return null for empty string', () {
      final PaymentState? result = parseScannedUri('');
      expect(result, isNull);
    });

    test('should return null for invalid URI format', () {
      const String invalidUri = 'not-a-valid-uri://something';
      final PaymentState? result = parseScannedUri(invalidUri);
      expect(result, isNull);
    });

    test('should return null for too short address', () {
      const String tooShort = '123ABC';
      final PaymentState? result = parseScannedUri(tooShort);
      expect(result, isNull);
    });
  });

  group('parseScannedUri - Multiple v1 test cases', () {
    final List<List<String>> testData = <List<String>>[
      <String>['EniaswqLCeWRJfz39VJRQwC6QDbAhkRHV9tn2fjhcrnc', '5i1'],
      <String>['BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5', 'Anr'],
      <String>['78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8', '4VT'],
      <String>['ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY', '9bG'],
      <String>['EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG', 'BJH'],
    ];

    for (final List<String> data in testData) {
      test('should parse v1 pubkey ${data[0]}', () {
        final String pubKey = data[0];
        final PaymentState? result = parseScannedUri(pubKey);
        expect(result, isNotNull);
        expect(result!.contacts[0].pubKey, equals(pubKey));
      });

      test('should parse v1 pubkey with checksum ${data[0]}:${data[1]}', () {
        final String pubKeyWithChecksum = '${data[0]}:${data[1]}';
        final PaymentState? result = parseScannedUri(pubKeyWithChecksum);
        expect(result, isNotNull);
        expect(extractPublicKey(result!.contacts[0].pubKey), equals(data[0]));
      });
    }
  });

  group('parseScannedUri - Edge cases', () {
    test('should handle localized decimal amounts correctly', () {
      const String pubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
      const String uri = 'june://$pubKey?amount=10,5';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.amount, equals(10.5));
    });

    test('should handle special characters in comments', () {
      const String pubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
      const String uri = 'june://$pubKey?comment=GCHANGE:AYDI9JPOVIL9ZVG-PNCU';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.comment, equals('GCHANGE:AYDI9JPOVIL9ZVG-PNCU'));
    });

    test('should handle URL encoded spaces in comments', () {
      const String pubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
      final String uri =
          Uri.encodeFull('june://$pubKey?comment=Test with spaces');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.comment, contains('Test'));
    });
  });
}
