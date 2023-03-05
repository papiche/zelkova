import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';
import 'dart:typed_data';

import 'package:durt/durt.dart';

Random createRandom() {
  if (Platform.isIOS || Platform.isAndroid) {
    final String osVersion = Platform.operatingSystemVersion;

    final int currentYear = DateTime.now().year;
    final int osYear = int.parse(osVersion.split('.')[0]);
    final bool isOldDevice = currentYear - osYear >= 5;

    if (isOldDevice) {
      return Random();
    } else {
      try {
        return Random.secure();
      } catch (e) {
        return Random();
      }
    }
  } else {
    return Random.secure();
  }
}

Uint8List generateUintSeed() {
  final Random random = createRandom();
  return Uint8List.fromList(List<int>.generate(32, (_) => random.nextInt(256)));
}

String seedToString(Uint8List seed) {
  final Uint8List seedsBytes = Uint8List.fromList(seed);
  final String encoded = json.encode(seedsBytes.toList());
  return encoded;
}

CesiumWallet generateCesiumWallet(Uint8List seed) {
  return CesiumWallet.fromSeed(seed);
}

Uint8List seedFromString(String sString) {
  final List<dynamic> list = json.decode(sString) as List<dynamic>;
  final Uint8List bytes =
      Uint8List.fromList(list.map((dynamic e) => e as int).toList());
  return bytes;
}

String generateSalt(int length) {
  final Random random = createRandom();
  const String charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  return List<String>.generate(
      length, (int index) => charset[random.nextInt(charset.length)]).join();
}
