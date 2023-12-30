import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:durt/durt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../data/models/contact.dart';
import '../data/models/payment_state.dart';
import '../data/models/transaction.dart';
import '../data/models/utxo.dart';
import '../ui/logger.dart';
import '../ui/pay_helper.dart';
import '../ui/ui_helpers.dart';

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
    Sentry.captureMessage("Error $e trying to parse '$endpointUnParsed'");
    Sentry.captureException(e, stackTrace: stacktrace);
    return null;
  }
}

bool validateKeys(List<Contact> contacts) {
  if (contacts.isEmpty) {
    return false;
  }
  for (final Contact contact in contacts) {
    if (!validateKey(contact.pubKey)) {
      return false;
    }
  }
  return true;
}

bool validateKey(String pubKey) {
  final RegExp regex = RegExp(
    r'^[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{43,44}(:([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{3}))?$',
  );

  if (!regex.hasMatch(pubKey)) {
    return false;
  }

  final List<String> parts = pubKey.split(':');
  final String publicKeyPart = parts[0];

  if (parts.length == 2) {
    final String checksumPart = parts[1];

    if (pkChecksum(publicKeyPart) != checksumPart) {
      return false;
    }
  }

  return true;
}

String getFullPubKey(String pubKey) {
  if (pubKey.contains(':')) {
    return pubKey;
  } else {
    return '$pubKey:${pkChecksum(pubKey)}';
  }
}

String pkChecksum(String pubkey) {
  List<int> signpkInt8;

  // Remove leading '1'
  if (pubkey.length == 44 && pubkey.startsWith('1')) {
    signpkInt8 = Base58Decode(pubkey.substring(1));
  } else {
    signpkInt8 = Base58Decode(pubkey);
  }

  // Double SHA256 hash
  final Digest firstHash = sha256.convert(signpkInt8);
  final Digest secondHash = sha256.convert(firstHash.bytes);

  // Base58 encode and take the first 3 characters
  final String checksum = Base58Encode(secondHash.bytes).substring(0, 3);

  return checksum;
}

String getQrUri(
    {required String pubKey, String locale = 'en', String amount = '0'}) {
  double amountD;
  try {
    amountD = parseToDoubleLocalized(locale: locale, number: amount);
  } catch (e) {
    amountD = 0;
  }

  String uri;
  if (amountD > 0) {
    // there is something like this in other clients?
    uri = 'june://$pubKey?amount=$amountD';
  } else {
    uri = pubKey;
  }
  return uri;
}

PaymentState? parseScannedUri(String qrOrig) {
  final String qr = Uri.decodeFull(qrOrig);
  final RegExp regexKeyCommentAmount = RegExp(
      r'(duniter\:key|june\:\/)/(\w+(:\w{3})?)\?(comment=([^&]+))&amount=([\d.,]+)');
  final RegExp regexKeyAmountComment = RegExp(
      r'(duniter\:key|june\:\/)/(\w+(:\w{3})?)\?(amount=([\d.,]+))&comment=([^&]+)');
  final RegExp regexKeyComment =
      RegExp(r'(duniter\:key|june\:\/)/(\w+(:\w{3})?)\?comment=([^&]+)');
  final RegExp regexKeyAmount =
      RegExp(r'(duniter\:key|june\:\/)/(\w+(:\w{3})?)\?amount=([\d.,]+)');
  final RegExp regexKey = RegExp(r'(duniter\:key|june\:\/)/(\w+(:\w{3})?)');

  final RegExpMatch? matchKeyCommentAmount =
      regexKeyCommentAmount.firstMatch(qr);

  final RegExpMatch? matchKeyAmountComment =
      regexKeyAmountComment.firstMatch(qr);

  final RegExpMatch? matchKeyComment = regexKeyComment.firstMatch(qr);

  if (matchKeyCommentAmount != null && matchKeyAmountComment == null) {
    final String publicKey = matchKeyCommentAmount.group(2)!;
    final String? comment = matchKeyCommentAmount.group(5);
    final double amount = parseToDoubleLocalized(
        locale: 'en',
        number: matchKeyCommentAmount.group(6)!.replaceAll(',', '.'));
    return PaymentState(
        contacts: <Contact>[Contact(pubKey: publicKey)],
        amount: amount,
        comment: cleanComment(comment));
  }

  if (matchKeyAmountComment != null) {
    final String publicKey = matchKeyAmountComment.group(2)!;
    final String? comment = matchKeyAmountComment.group(6);
    final double amount = parseToDoubleLocalized(
        locale: 'en',
        number: matchKeyAmountComment.group(5)!.replaceAll(',', '.'));
    return PaymentState(
        contacts: <Contact>[Contact(pubKey: publicKey)],
        amount: amount,
        comment: cleanComment(comment));
  }

  if (matchKeyComment != null) {
    final String publicKey = matchKeyComment.group(2)!;
    final String? comment = matchKeyComment.group(4);
    return PaymentState(
        contacts: <Contact>[Contact(pubKey: publicKey)],
        comment: cleanComment(comment));
  }

  final RegExpMatch? matchKeyAmount = regexKeyAmount.firstMatch(qr);

  if (matchKeyAmount != null) {
    final String publicKey = matchKeyAmount.group(2)!;
    final double amount = double.parse(matchKeyAmount.group(4)!);
    return PaymentState(
        contacts: <Contact>[Contact(pubKey: publicKey)], amount: amount);
  }

  final RegExpMatch? matchKey = regexKey.firstMatch(qr);
  if (matchKey != null) {
    final String publicKey = matchKey.group(2)!;
    return PaymentState(contacts: <Contact>[Contact(pubKey: publicKey)]);
  }

  // Match key only
  if (validateKey(qr)) {
    return PaymentState(contacts: <Contact>[Contact(pubKey: qr)]);
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

const Duration wrongNodeDuration = Duration(days: 2);

bool areDatesClose(DateTime date1, DateTime date2, Duration threshold) {
  return date1.difference(date2).abs() <= threshold;
}

double toG1(double amount, bool isG1, double currentUd) {
  return isG1 ? amount : amount * currentUd;
}

int toCG1(double amount) => (amount.toPrecision(2) * 100).toInt();

// From durt
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

String extractPublicKey(String key) => key.split(':')[0];

String normalizeQuery(String initialQuery) {
  String query = initialQuery;
  if (validateKey(query)) {
    // Is a pubKey
    query = extractPublicKey(initialQuery);
  }
  return query;
}

final RegExp regex = RegExp(
  r'[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{43,44}(:([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{3}))?',
);

List<Contact> parseMultipleKeys(String inputText) {
  final List<Contact> contacts = <Contact>[];
  final Iterable<RegExpMatch> allMatches = regex.allMatches(inputText);
  loggerDev('matches: ${allMatches.length}');
  for (final RegExpMatch match in allMatches) {
    final String? publicKey = match.group(0);
    if (publicKey != null) {
      contacts.add(Contact(pubKey: publicKey));
    }
  }
  return contacts;
}

List<List<Utxo>> sliceUtxos(List<Utxo> utxos, {int sliceSize = 40}) {
  final List<List<Utxo>> slices = <List<Utxo>>[];

  for (int i = 0; i < utxos.length; i += sliceSize) {
    final int end =
        (i + sliceSize < utxos.length) ? i + sliceSize : utxos.length;
    slices.add(utxos.sublist(i, end));
  }

  return slices;
}

double truncBase(double amount, int base) {
  final num p = pow(10, base);
  if (amount < p) {
    return 0;
  }
  return (amount / p).truncateToDouble() * p;
}

String genTxKey(Transaction t) {
  final List<Contact> sortedRecipients = t.recipientsWithoutCashBack
    ..sort((Contact a, Contact b) => a.pubKey.compareTo(b.pubKey));
  final String toId =
      '${sortedRecipients.map((Contact c) => extractPublicKey(c.pubKey)).join('-')}-${t.comment}-${t.amount}';
  return 'from:${extractPublicKey(t.from.pubKey)}-to:$toId';
}

bool compareRecipientListsByKey(List<Contact> list1, List<Contact> list2) {
  if (list1.length != list2.length) {
    return false;
  }

  list1.sort((Contact a, Contact b) => a.pubKey.compareTo(b.pubKey));
  list2.sort((Contact a, Contact b) => a.pubKey.compareTo(b.pubKey));

  for (int i = 0; i < list1.length; i++) {
    if (!list1[i].keyEqual(list2[i])) {
      return false;
    }
  }

  return true;
}

List<Transaction> lastTx(List<Transaction> origTxs) {
  return origTxs
      .where((Transaction tx) =>
          areDatesClose(DateTime.now(), tx.time, paymentTimeRange))
      .toList();
}
