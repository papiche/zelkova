import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../data/models/contact.dart';
import '../data/models/payment_state.dart';

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
  endpointUnParsed = endpointUnParsed.replaceFirst('GVA S', 'GVA_S');
  try {
    final List<String> parts = endpointUnParsed.split(' ');
    // FIXME (vjrj): figure out if exists a way to detect http or https
    const String protocol = 'https';
    final String lastPart = parts.removeLast();
    String path =
        RegExp(r'^\/[a-zA-Z0-9\-\/]+$').hasMatch(lastPart) ? lastPart : '';

    final String nextToLast = parts[parts.length - 1];
    /* print(lastPart);
    print(path);
    print(nextToLast); */
    String port = path == ''
        ? (RegExp(r'^[0-9]+$').hasMatch(lastPart) ? lastPart : '443')
        : RegExp(r'^[0-9]+$').hasMatch(nextToLast)
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
    if (endpointUnParsed.endsWith('gva')) {
      path = '/gva';
    }
    if (port == '443') {
      port = '';
    } else {
      port = ':$port';
    }
    final String endpoint = '$protocol://$host$port$path'.trim();
    return endpoint;
  } catch (e, stacktrace) {
    Sentry.captureException(e, stackTrace: stacktrace);
    // Don't do this here or tests will fail
    // logger('Cannot parse endpoint $endpointUnParsed');
    return null;
  }
}

bool validateKey(String pubKey) {
  return RegExp(
          r'^[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{43,44}$')
      .hasMatch(pubKey);
}

String getQrUri(String destinationPublicKey, [String amountString = '0']) {
  final double amount = double.tryParse(amountString) ?? 0.0;

  String uri;
  if (amount > 0) {
    // there is something like this in other clients?
    uri = 'duniter:key/$destinationPublicKey?amount=$amount';
  } else {
    uri = destinationPublicKey;
  }
  return uri;
}

PaymentState? parseScannedUri(String qr) {
  final RegExp regexKeyAmount = RegExp(r'duniter:key/(\w+)\?amount=([\d.]+)');
  final RegExpMatch? matchKeyAmount = regexKeyAmount.firstMatch(qr);

  if (matchKeyAmount != null) {
    final String publicKey = matchKeyAmount.group(1)!;
    final double amount = double.parse(matchKeyAmount.group(2)!);
    return PaymentState(contact: Contact(pubKey: publicKey), amount: amount);
  }

  // Match no amount
  final RegExp regexKey = RegExp(r'duniter:key/(\w+)');
  final RegExpMatch? matchKey = regexKey.firstMatch(qr);
  if (matchKey != null) {
    final String publicKey = matchKey.group(1)!;
    return PaymentState(contact: Contact(pubKey: publicKey));
  }

  // Match key only
  if (validateKey(qr)) {
    return PaymentState(contact: Contact(pubKey: qr));
  }

  return null;
}

final IV _iv = encrypt.IV.fromLength(16);

Map<String, String> encryptJsonForExport(String jsonString, String password) {
  final Uint8List plainText = Uint8List.fromList(utf8.encode(jsonString));
  final encrypt.Encrypted encrypted = encrypt.Encrypter(
          encrypt.AES(encrypt.Key.fromUtf8(password.padRight(32))))
      .encryptBytes(plainText, iv: _iv);
  final Map<String, String> jsonData = <String, String>{
    'key': base64Encode(encrypted.bytes)
  };
  return jsonData;
}

Map<String, dynamic> decryptJsonForImport(
    String keyEncrypted, String password) {
  final String decrypted = encrypt.Encrypter(
          encrypt.AES(encrypt.Key.fromUtf8(password.padRight(32))))
      .decrypt64(keyEncrypted, iv: _iv);
  return jsonDecode(decrypted) as Map<String, dynamic>;
}
