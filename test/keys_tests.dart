import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:flutter_test/flutter_test.dart';
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
    expect(parseHost('BMAS g1.duniter.org 443'),
        equals('https://g1.duniter.org:443'));
    expect(parseHost('BMAS g1.leprette.fr 443 /bma'),
        equals('https://g1.leprette.fr:443/bma'));
    expect(parseHost('BMAS g1-vijitatman.es 212.227.41.252 443'),
        equals('https://g1-vijitatman.es:443'));
    expect(
        parseHost(
            'BMAS monnaie-libre.ortie.org/bma/ 192.168.1.35 2a01:cb0d:5c2:fa00:21e:68ff:feab:389a 443'),
        equals('https://monnaie-libre.ortie.org:443/bma'));
    expect(
        parseHost('BMAS g1.texu.es 7443'), equals('https://g1.texu.es:7443'));
  });
}
