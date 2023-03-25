import 'dart:convert';
import 'dart:typed_data';

import 'package:durt/durt.dart';
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
  });

  test('validate pub keys', () {
    expect(validateKey('FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm'),
        equals(true));

    expect(validateKey('BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'),
        equals(true));
  });

  test('validate qr uris', () {
    const String publicKey = 'FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm';
    final String uriA = getQrUri(publicKey, '10');
    final PaymentState? payA = parseScannedUri(uriA);
    expect(payA!.amount, equals(10));
    expect(payA.publicKey, equals(publicKey));

    final String uriB = getQrUri(publicKey);
    final PaymentState? payB = parseScannedUri(uriB);
    expect(payB!.amount, equals(null));
    expect(payB.publicKey, equals(publicKey));

    final PaymentState? payC = parseScannedUri(publicKey);
    expect(payC!.amount, equals(null));
    expect(payC.publicKey, equals(publicKey));
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
}
