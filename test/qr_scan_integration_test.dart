/// Integration tests for QR code scanning functionality.
///
/// This test suite validates the complete QR scanning flow for Ginkgo wallet,
/// covering:
/// - V1 public keys (with and without checksums)
/// - V2 addresses (BIP350 format starting with 'g1')
/// - URI schemes: june:// and duniter:key
/// - URI parameters: amount and comment
/// - Edge cases: localized decimals, special characters, URL encoding
/// - PaymentCubit state management after scanning
///
/// The tests validate both the parsing layer (via `parseScannedUri()`) and
/// the state management layer (via `PaymentCubit`), ensuring the complete
/// workflow from QR scan to payment state update works correctly.

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/payment_cubit.dart';
import 'package:ginkgo/data/models/payment_state.dart';
import 'package:ginkgo/g1/g1_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Mock storage for HydratedBloc
class MockStorage implements Storage {
  final Map<String, dynamic> _storage = <String, dynamic>{};

  @override
  dynamic read(String key) => _storage[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  group('QR Scan Integration Tests - V1 PubKeys', () {
    late PaymentCubit paymentCubit;
    const String v1PubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String v1PubKeyWithChecksum =
        '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH:HCT';

    setUp(() {
      HydratedBloc.storage = MockStorage();
      paymentCubit = PaymentCubit();
    });

    tearDown(() {
      paymentCubit.close();
    });

    test('parseScannedUri - V1 pubkey without URI scheme', () {
      final PaymentState? result = parseScannedUri(v1PubKey);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(result.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, isNull);
      expect(result.comment, '');
    });

    test('parseScannedUri - V1 pubkey with checksum', () {
      final PaymentState? result = parseScannedUri(v1PubKeyWithChecksum);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(extractPublicKey(result.contacts[0].pubKey), equals(v1PubKey));
    });

    test('parseScannedUri - june:// URI with V1 pubkey', () {
      const String uri = 'june://$v1PubKey';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, isNull);
      expect(result.comment, '');
    });

    test('parseScannedUri - june:// URI with V1 pubkey and amount', () {
      const String uri = 'june://$v1PubKey?amount=10.5';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(10.5));
      expect(result.comment, '');
    });

    test('parseScannedUri - june:// URI with V1 pubkey and comment', () {
      const String uri = 'june://$v1PubKey?comment=Test payment';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.comment, equals('Test payment'));
      expect(result.amount, isNull);
    });

    test('parseScannedUri - june:// URI with V1 pubkey, amount and comment',
        () {
      const String uri = 'june://$v1PubKey?amount=25&comment=Test payment';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(25));
      expect(result.comment, equals('Test payment'));
    });

    test(
        'parseScannedUri - june:// URI with V1 pubkey, comment and amount (reversed order)',
        () {
      const String uri = 'june://$v1PubKey?comment=Test payment&amount=25';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(25));
      expect(result.comment, equals('Test payment'));
    });

    test('parseScannedUri - duniter:key URI with V1 pubkey', () {
      const String uri = 'duniter:key/$v1PubKey';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
    });

    test('parseScannedUri - duniter:key URI with V1 pubkey and amount', () {
      const String uri = 'duniter:key/$v1PubKey?amount=15.75';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.amount, equals(15.75));
    });

    test('parseScannedUri - duniter:key URI with V1 pubkey and comment', () {
      const String uri = 'duniter:key/$v1PubKey?comment=Payment reference';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.comment, equals('Payment reference'));
    });

    test('parseScannedUri - URI-encoded june:// with V1 pubkey', () {
      final String uri =
          Uri.encodeFull('june://$v1PubKey?comment=My test comment');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].pubKey, equals(v1PubKey));
      expect(result.comment, equals('My test comment'));
    });
  });

  group('QR Scan Integration Tests - V2 Addresses', () {
    late PaymentCubit paymentCubit;
    // Real v2 address corresponding to v1 pubkey
    const String v2Address1 =
        'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM';
    const String v1PubKey1 = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String v2Address2 =
        'g1PAf1Dg6NAtsece62shM98dgmGiCF36PDJjfJ86aCYhe78XP';
    const String v1PubKey2 = 'DU7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZ';

    setUp(() {
      HydratedBloc.storage = MockStorage();
      paymentCubit = PaymentCubit();
    });

    tearDown(() {
      paymentCubit.close();
    });

    test('parseScannedUri - V2 address without URI scheme', () {
      final PaymentState? result = parseScannedUri(v2Address1);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      // Contact stores v1 pubkey internally, but v2 address in address field
      expect(result.contacts[0].address, equals(v2Address1));
      expect(result.contacts[0].pubKey, equals(v1PubKey1));
      expect(result.amount, isNull);
      expect(result.comment, '');
    });

    test('parseScannedUri - Second V2 address without URI scheme', () {
      final PaymentState? result = parseScannedUri(v2Address2);
      expect(result, isNotNull);
      expect(result!.contacts.length, equals(1));
      expect(result.contacts[0].address, equals(v2Address2));
      expect(result.contacts[0].pubKey, equals(v1PubKey2));
    });

    test('parseScannedUri - june:// URI with V2 address', () {
      const String uri = 'june://$v2Address1';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.contacts[0].pubKey, equals(v1PubKey1));
    });

    test('parseScannedUri - june:// URI with V2 address and amount', () {
      const String uri = 'june://$v2Address2?amount=15.75';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.contacts[0].pubKey, equals(v1PubKey2));
      expect(result.amount, equals(15.75));
    });

    test('parseScannedUri - june:// URI with V2 address and comment', () {
      const String uri = 'june://$v2Address1?comment=Payment for service';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.comment, equals('Payment for service'));
    });

    test('parseScannedUri - june:// URI with V2 address, amount and comment',
        () {
      const String uri = 'june://$v2Address1?amount=50.25&comment=Invoice 123';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
      expect(result.amount, equals(50.25));
      expect(result.comment, equals('Invoice 123'));
    });

    test(
        'parseScannedUri - june:// URI with V2 address, comment and amount (reversed order)',
        () {
      const String uri =
          'june://$v2Address2?comment=Monthly subscription&amount=100';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.amount, equals(100));
      expect(result.comment, equals('Monthly subscription'));
    });

    test('parseScannedUri - duniter:key URI with V2 address', () {
      const String uri = 'duniter:key/$v2Address1';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address1));
    });

    test('parseScannedUri - URI-encoded june:// with V2 address', () {
      final String uri =
          Uri.encodeFull('june://$v2Address2?comment=Special characters test');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.contacts[0].address, equals(v2Address2));
      expect(result.comment, equals('Special characters test'));
    });
  });

  group('QR Scan Integration Tests - Edge Cases and Error Handling', () {
    late PaymentCubit paymentCubit;
    const String v1PubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';

    setUp(() {
      HydratedBloc.storage = MockStorage();
      paymentCubit = PaymentCubit();
    });

    tearDown(() {
      paymentCubit.close();
    });

    test('parseScannedUri - Invalid v1 pubkey returns null', () {
      const String invalidKey = 'invalid_key_123';
      final PaymentState? result = parseScannedUri(invalidKey);
      expect(result, isNull);
    });

    test('parseScannedUri - Empty string returns null', () {
      final PaymentState? result = parseScannedUri('');
      expect(result, isNull);
    });

    test('parseScannedUri - Invalid URI format returns null', () {
      const String invalidUri = 'not-a-valid-uri://something';
      final PaymentState? result = parseScannedUri(invalidUri);
      expect(result, isNull);
    });

    test('parseScannedUri - Too short address returns null', () {
      const String tooShort = '123ABC';
      final PaymentState? result = parseScannedUri(tooShort);
      expect(result, isNull);
    });

    test('parseScannedUri - Localized decimal amounts (comma separator)', () {
      const String uri = 'june://$v1PubKey?amount=10,5';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.amount, equals(10.5));
    });

    test('parseScannedUri - Special characters in comments', () {
      const String uri =
          'june://$v1PubKey?comment=GCHANGE:AYDI9JPOVIL9ZVG-PNCU';
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.comment, equals('GCHANGE:AYDI9JPOVIL9ZVG-PNCU'));
    });

    test('parseScannedUri - URL encoded spaces in comments', () {
      final String uri =
          Uri.encodeFull('june://$v1PubKey?comment=Test with spaces');
      final PaymentState? result = parseScannedUri(uri);
      expect(result, isNotNull);
      expect(result!.comment.contains('Test'), isTrue);
    });
  });

  group('QR Scan Integration Tests - PaymentCubit State Updates', () {
    late PaymentCubit paymentCubit;
    const String v1PubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String v2Address =
        'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM';

    setUp(() {
      HydratedBloc.storage = MockStorage();
      paymentCubit = PaymentCubit();
    });

    tearDown(() {
      paymentCubit.close();
    });

    test('Selecting V1 pubkey updates PaymentCubit correctly', () {
      final PaymentState? parsedPayment = parseScannedUri(v1PubKey);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectUsers(parsedPayment!.contacts);

      expect(paymentCubit.state.contacts.length, equals(1));
      expect(paymentCubit.state.contacts[0].pubKey, equals(v1PubKey));
    });

    test('Selecting V2 address updates PaymentCubit correctly', () {
      final PaymentState? parsedPayment = parseScannedUri(v2Address);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectUsers(parsedPayment!.contacts);

      expect(paymentCubit.state.contacts.length, equals(1));
      expect(paymentCubit.state.contacts[0].address, equals(v2Address));
    });

    test('Selecting contact with amount updates PaymentCubit correctly', () {
      const String uri = 'june://$v1PubKey?amount=25.5';
      final PaymentState? parsedPayment = parseScannedUri(uri);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectKeyAmount(parsedPayment!.contacts[0], 25.5);

      expect(paymentCubit.state.contacts.length, equals(1));
      expect(paymentCubit.state.contacts[0].pubKey, equals(v1PubKey));
      expect(paymentCubit.state.amount, equals(25.5));
    });

    test('Selecting contact with comment updates PaymentCubit correctly', () {
      const String uri = 'june://$v1PubKey?comment=Payment for invoice';
      final PaymentState? parsedPayment = parseScannedUri(uri);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectUsers(parsedPayment!.contacts);
      paymentCubit.setComment(parsedPayment.comment);

      expect(paymentCubit.state.comment, equals('Payment for invoice'));
    });

    test('Complete payment flow with v1, amount and comment', () {
      const String uri = 'june://$v1PubKey?amount=50&comment=Test payment';
      final PaymentState? parsedPayment = parseScannedUri(uri);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectKeyAmount(parsedPayment!.contacts[0], 50);
      paymentCubit.setComment('Test payment');

      expect(paymentCubit.state.contacts.length, equals(1));
      expect(paymentCubit.state.contacts[0].pubKey, equals(v1PubKey));
      expect(paymentCubit.state.amount, equals(50));
      expect(paymentCubit.state.comment, equals('Test payment'));
    });

    test('Complete payment flow with v2 address, amount and comment', () {
      const String uri = 'june://$v2Address?amount=100&comment=Invoice #001';
      final PaymentState? parsedPayment = parseScannedUri(uri);
      expect(parsedPayment, isNotNull);

      paymentCubit.selectKeyAmount(parsedPayment!.contacts[0], 100);
      paymentCubit.setComment('Invoice #001');

      expect(paymentCubit.state.contacts.length, equals(1));
      expect(paymentCubit.state.contacts[0].address, equals(v2Address));
      expect(paymentCubit.state.amount, equals(100));
      expect(paymentCubit.state.comment, equals('Invoice #001'));
    });
  });

  group('QR Scan Integration Tests - Multiple V1 Test Cases', () {
    late PaymentCubit paymentCubit;
    final List<List<String>> testData = <List<String>>[
      <String>['EniaswqLCeWRJfz39VJRQwC6QDbAhkRHV9tn2fjhcrnc', '5i1'],
      <String>['BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5', 'Anr'],
      <String>['78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8', '4VT'],
      <String>['ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY', '9bG'],
      <String>['EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG', 'BJH'],
    ];

    setUp(() {
      HydratedBloc.storage = MockStorage();
      paymentCubit = PaymentCubit();
    });

    tearDown(() {
      paymentCubit.close();
    });

    for (final List<String> data in testData) {
      test('parseScannedUri - V1 pubkey ${data[0]}', () {
        final String pubKey = data[0];
        final PaymentState? result = parseScannedUri(pubKey);
        expect(result, isNotNull);
        expect(result!.contacts[0].pubKey, equals(pubKey));
      });

      test('parseScannedUri - V1 pubkey with checksum ${data[0]}:${data[1]}',
          () {
        final String pubKeyWithChecksum = '${data[0]}:${data[1]}';
        final PaymentState? result = parseScannedUri(pubKeyWithChecksum);
        expect(result, isNotNull);
        expect(extractPublicKey(result!.contacts[0].pubKey), equals(data[0]));
      });

      test('PaymentCubit - V1 pubkey ${data[0]} updates state correctly', () {
        final String pubKey = data[0];
        final PaymentState? parsedPayment = parseScannedUri(pubKey);
        expect(parsedPayment, isNotNull);

        paymentCubit.selectUsers(parsedPayment!.contacts);

        expect(paymentCubit.state.contacts.length, equals(1));
        expect(paymentCubit.state.contacts[0].pubKey, equals(pubKey));
      });
    }
  });
}
