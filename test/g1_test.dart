import 'dart:convert';
import 'dart:math';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/payment_state.dart';
import 'package:ginkgo/g1/g1_helper.dart';

void main() {
  test('Test serialization and deserialization of UInt8List seeds', () {
    final Uint8List seed = generateUintSeed();
    final String sSeed = seedToString(seed);

    final Uint8List seedRestored = seedFromString(sSeed);
    expect(seed, equals(seedRestored));
    final CesiumWallet wallet = generateCesiumWallet(seed);
    final CesiumWallet walletRestored = generateCesiumWallet(seedRestored);
    expect(wallet.pubkey, equals(walletRestored.pubkey));
    expect(wallet.seed, equals(walletRestored.seed));
    expect(wallet.rootKey, equals(walletRestored.rootKey));
  });

  test('parse different networks/peers BMAS', () {
    expect(
        parseHost('BMAS g1.texu.es 7443'), equals('https://g1.texu.es:7443'));
    expect(
        parseHost('BMAS g1.duniter.org 443'), equals('https://g1.duniter.org'));
    expect(parseHost('BMAS g1.leprette.fr 443 /bma'),
        equals('https://g1.leprette.fr/bma'));
    expect(parseHost('BMAS g1-vijitatman.es 212.227.41.252 443'),
        equals('https://g1-vijitatman.es'));
    expect(
        parseHost(
            'BMAS monnaie-libre.ortie.org/bma/ 192.168.1.35 2a01:cb0d:5c2:fa00:21e:68ff:feab:389a 443'),
        equals('https://monnaie-libre.ortie.org/bma'));
  });

  test('parse different networks/peers GVA S', () {
    expect(parseHost('GVA S duniter.master.aya.autissier.net 443 gva'),
        equals('https://duniter.master.aya.autissier.net/gva'));
    expect(parseHost('GVA S g1-test-dev.pini.fr 443 gva'),
        equals('https://g1-test-dev.pini.fr/gva'));
  });

  test('validate pub keys', () {
    expect(validateKey('FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm'),
        equals(true));

    expect(validateKey('BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'),
        equals(true));

    expect(validateKey('naU6XunXd1LSSfsHu3aNk8ZqgSosKQcvEQz8F2KaRAy'),
        equals(true));
  });

  test('validate qr uris', () {
    const String publicKey = 'FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm';
    final String uriA = getQrUri(pubKey: publicKey, amount: '10');
    final PaymentState? payA = parseScannedUri(uriA);
    expect(payA!.amount, equals(10), reason: 'amount should be 10 in $uriA');
    expect(payA.contact!.pubKey, equals(publicKey));

    final String uriB = getQrUri(pubKey: publicKey);
    final PaymentState? payB = parseScannedUri(uriB);
    expect(payB!.amount, equals(null));
    expect(payB.contact!.pubKey, equals(publicKey));

    final PaymentState? payC = parseScannedUri(publicKey);
    expect(payC!.amount, equals(null));
    expect(payC.contact!.pubKey, equals(publicKey));

    final String uriD = getQrUri(pubKey: publicKey, amount: '10.10');
    final PaymentState? payD = parseScannedUri(uriD);
    expect(payD!.amount, equals(10.10));
    expect(payD.contact!.pubKey, equals(publicKey));

    final String uriE =
        getQrUri(pubKey: publicKey, amount: '10,10', locale: 'es');
    final PaymentState? payE = parseScannedUri(uriE);
    expect(payE!.amount, equals(10.10));
    expect(payE.contact!.pubKey, equals(publicKey));

    const String uriF = 'june://$publicKey?amount=100';
    final PaymentState? payF = parseScannedUri(uriF);
    expect(payF!.amount, equals(100));
    expect(payF.contact!.pubKey, equals(publicKey));

    const String uriJ =
        'june://$publicKey?comment=GCHANGE:AYDI9JPOVIL9ZVG-PNCU&amount=100';
    final PaymentState? payJ = parseScannedUri(uriJ);
    expect(payJ!.comment, equals('GCHANGE:AYDI9JPOVIL9ZVG-PNCU'));
    expect(payJ!.amount, equals(100));
    expect(payJ.contact!.pubKey, equals(publicKey));
  });

  test('encrypt/decrypt of keys', () {
    const String pass = '1234';
    const String wrongPass = '1235';
    final Map<String, String> sample = <String, String>{
      'public': 'some public',
      'private': 'some private'
    };
    final Map<String, String> encSample =
        encryptJsonForExport(jsonEncode(sample), pass);
    final String encJson = encSample['key']!;
    expect(encJson.isNotEmpty, equals(true));

    final Map<String, dynamic> decrypted = decryptJsonForImport(encJson, pass);
    expect(decrypted['public'], equals('some public'));
    expect(decrypted['private'], equals('some private'));

    try {
      // test wrong pass
      decryptJsonForImport(encJson, wrongPass);
    } catch (e) {
      expect(e, isArgumentError);
    }
  });
  test('encrypt/decrypt of keys', () {
    final Random random = Random();
    for (int i = 0; i < 50; i++) {
      final String pass = _generateRandomPatternPassword(random);
      final String wrongPass = _generateRandomPatternPassword(random);

      final Uint8List seed = generateUintSeed();
      final CesiumWallet wallet = generateCesiumWallet(seed);

      final Map<String, String> sample = <String, String>{
        'pubKey': wallet.pubkey,
        'seed': seedToString(wallet.seed)
      };

      final Map<String, String> encSample =
          encryptJsonForExport(jsonEncode(sample), pass);
      final String encJson = encSample['key']!;
      expect(encJson.isNotEmpty, equals(true));

      final Map<String, dynamic> decrypted =
          decryptJsonForImport(encJson, pass);
      expect(decrypted['pubKey'], equals(sample['pubKey']));
      expect(decrypted['seed'], equals(sample['seed']));

      try {
        // test wrong pass
        decryptJsonForImport(encJson, wrongPass);
      } on ArgumentError catch (e) {
        expect(e, isArgumentError);
      } catch (e) {
        if (kDebugMode) {
          print(
              'encjson: $encJson and wrongPass: $wrongPass correct pass: $pass');
        }
        // rethrow;
      }
    }
  });
}

String _generateRandomPatternPassword(Random random) {
  final int length = random.nextInt(8) + 2; // Password length between 2 and 9.
  final Set<int> digits = <int>{1, 2, 3, 4, 5, 6, 7, 8, 9};
  final List<int> passwordDigits = <int>[];
  for (int i = 0; i < length; i++) {
    final int selectedDigit = digits.elementAt(random.nextInt(digits.length));
    passwordDigits.add(selectedDigit);
    digits.remove(selectedDigit);
  }
  return passwordDigits.join();
}
