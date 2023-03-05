import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mondamono/g1/keys_helper.dart';

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
}
