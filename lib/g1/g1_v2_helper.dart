import 'dart:typed_data';

import 'package:polkadart_keyring/polkadart_keyring.dart';

Uint8List hexToU8a(String hexString) {
  hexString = hexString.startsWith('0x') ? hexString.substring(2) : hexString;
  if (hexString.length % 2 != 0) {
    hexString = '0$hexString';
  }

  return Uint8List.fromList(List<int>.generate(hexString.length ~/ 2, (int i) {
    return int.parse(hexString.substring(i * 2, i * 2 + 2), radix: 16);
  }));
}

bool isHex(String value, [int bitLength = -1]) {
  final RegExp hexRegEx = RegExp(r'^0x[a-fA-F0-9]+$');

  return hexRegEx.hasMatch(value) &&
      (bitLength == -1 || value.length == 2 + bitLength ~/ 4);
}

// From:
// https://polkadot.js.org/docs/util-crypto/examples/validate-address/
bool isValidV2Address(String address) {
  try {
    final Keyring keyring = Keyring();
    keyring.encodeAddress(
        isHex(address) ? hexToU8a(address) : keyring.decodeAddress(address));
    return true;
  } catch (error) {
    return false;
  }
}
