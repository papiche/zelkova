import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:durt/durt.dart';

import '../main.dart';

Random createRandom() {
  try {
    return Random.secure();
  } catch (e) {
    return Random();
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

String? parseHost(String endpointUnParsed) {
  try {
    final List<String> parts = endpointUnParsed.split(' ');
    // FIXME (vjrj): figure out if exists a way to detect http or https
    const String protocol = 'https';
    final String lastPart = parts.removeLast();
    String path =
        RegExp(r'^\/[a-zA-Z0-9\-\/]+$').hasMatch(lastPart) ? lastPart : '';

    final String nextToLast = parts[parts.length - 1];
    final String port = lastPart == ''
        ? (RegExp(r'^\/[0-9]$').hasMatch(lastPart) ? lastPart : '443')
        : RegExp(r'^\/[0-9]$').hasMatch(nextToLast)
            ? nextToLast
            : '443';
    final List<String> hostSplited = parts[1].split('/');
    // Process hosts like monnaie-libre.ortie.org/bma/
    final String host = hostSplited[0];
    path = path.isEmpty
        ? ((hostSplited.length > 1 && hostSplited[1].isNotEmpty
                    ? hostSplited[1]
                    : '')
                .isNotEmpty
            ? hostSplited.length > 1 && hostSplited[1].isNotEmpty
                ? '/${hostSplited[1]}'
                : ''
            : path)
        : path;
    //final bool hasIp =
    //  RegExp(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}').hasMatch(parts[2]);
//  final String port = hasIp ? parts[3] : parts[2];
    //final int pathIndex = hasIp ? 4 : 3;
    //final String path = parts.length > pathIndex ? parts[pathIndex] : '';
    final String endpoint = '$protocol://$host:$port$path'.trim();
    return endpoint;
  } catch (e) {
    logger('Cannot parse endpoint $endpointUnParsed');
    return null;
  }
}
