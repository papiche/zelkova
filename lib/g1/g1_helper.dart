import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:pointycastle/export.dart' as pc;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../data/models/contact.dart';
import '../data/models/payment_state.dart';
import '../data/models/transaction.dart';
import '../ui/currency_helper.dart';
import '../ui/logger.dart';
//import '../ui/pay_helper.dart';
import '../ui/ui_helpers.dart';
import 'crypto/cesium_wallet.dart';
import 'g1_v2_helper.dart';

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
  // We don't store v1 pass protected accounts only a '' as seed
  if (seed.isEmpty) {
    return '';
  }
  final Uint8List seedsBytes = Uint8List.fromList(seed);
  final String encoded = json.encode(seedsBytes.toList());
  return encoded;
}

Uint8List seedFromString(String sString) {
  // We don't store v1 pass protected accounts only a '' as seed
  if (sString.isEmpty) {
    return Uint8List(0);
  }
  final List<dynamic> list = json.decode(sString) as List<dynamic>;
  final Uint8List bytes =
      Uint8List.fromList(list.map((dynamic e) => e as int).toList());
  return bytes;
}

CesiumWallet generateCesiumWallet(Uint8List seed) {
  return CesiumWallet.fromSeed(seed);
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
  final crypto.Digest firstHash = sha256.convert(signpkInt8);
  final crypto.Digest secondHash = sha256.convert(firstHash.bytes);

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

  // Regex patterns that support both v1 pubKeys and v2 addresses
  // v1: 43-44 chars base58, optionally with :XXX checksum
  // v2: addresses starting with 'g1' followed by base58 chars (typically ~48 chars)
  final RegExp regexKeyCommentAmount = RegExp(
      r'(duniter\:key|june\:\/)/([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+(:\w{3})?)\?(comment=([^&]+))&amount=([\d.,]+)');
  final RegExp regexKeyAmountComment = RegExp(
      r'(duniter\:key|june\:\/)/([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+(:\w{3})?)\?(amount=([\d.,]+))&comment=([^&]+)');
  final RegExp regexKeyComment = RegExp(
      r'(duniter\:key|june\:\/)/([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+(:\w{3})?)\?comment=([^&]+)');
  final RegExp regexKeyAmount = RegExp(
      r'(duniter\:key|june\:\/)/([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+(:\w{3})?)\?amount=([\d.,]+)');
  final RegExp regexKey = RegExp(
      r'(duniter\:key|june\:\/)/([123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+(:\w{3})?)');

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
        contacts: <Contact>[createContactFromKey(publicKey)],
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
        contacts: <Contact>[createContactFromKey(publicKey)],
        amount: amount,
        comment: cleanComment(comment));
  }

  if (matchKeyComment != null) {
    final String publicKey = matchKeyComment.group(2)!;
    final String? comment = matchKeyComment.group(4);
    return PaymentState(
        contacts: <Contact>[createContactFromKey(publicKey)],
        comment: cleanComment(comment));
  }

  final RegExpMatch? matchKeyAmount = regexKeyAmount.firstMatch(qr);

  if (matchKeyAmount != null) {
    final String publicKey = matchKeyAmount.group(2)!;
    final double amount = parseToDoubleLocalized(
        locale: 'en', number: matchKeyAmount.group(4)!.replaceAll(',', '.'));
    return PaymentState(
        contacts: <Contact>[createContactFromKey(publicKey)], amount: amount);
  }

  final RegExpMatch? matchKey = regexKey.firstMatch(qr);
  if (matchKey != null) {
    final String publicKey = matchKey.group(2)!;
    return PaymentState(contacts: <Contact>[createContactFromKey(publicKey)]);
  }

  // Match v1 key only
  if (validateKey(qr)) {
    return PaymentState(contacts: <Contact>[createContactFromKey(qr)]);
  }

  // Match v2 address only
  if (isValidV2Address(qr)) {
    return PaymentState(contacts: <Contact>[createContactFromKey(qr)]);
  }

  return null;
}

Map<String, String> encryptJsonForExport(String jsonString, String password) {
  final Uint8List plainText = Uint8List.fromList(utf8.encode(jsonString));
  final Uint8List keyBytes =
      Uint8List.fromList(utf8.encode(password.padRight(32)));

  final pc.PaddedBlockCipher cipher = pc.PaddedBlockCipherImpl(
    pc.PKCS7Padding(),
    pc.SICBlockCipher(16, pc.SICStreamCipher(pc.AESEngine())),
  )..init(
      true,
      pc.PaddedBlockCipherParameters<pc.CipherParameters?,
          pc.CipherParameters?>(
        pc.ParametersWithIV<pc.KeyParameter>(
            pc.KeyParameter(keyBytes), Uint8List(16)),
        null,
      ),
    );

  final Uint8List encrypted = cipher.process(plainText);
  return <String, String>{'key': base64Encode(encrypted)};
}

Map<String, dynamic> decryptJsonForImport(String keyEncrypted, String password,
    [bool debug = false]) {
  try {
    final Uint8List cipherText = base64Decode(keyEncrypted);
    final Uint8List keyBytes =
        Uint8List.fromList(utf8.encode(password.padRight(32)));

    final pc.PaddedBlockCipher cipher = pc.PaddedBlockCipherImpl(
      pc.PKCS7Padding(),
      pc.SICBlockCipher(16, pc.SICStreamCipher(pc.AESEngine())),
    )..init(
        false,
        pc.PaddedBlockCipherParameters<pc.CipherParameters?,
            pc.CipherParameters?>(
          pc.ParametersWithIV<pc.KeyParameter>(
              pc.KeyParameter(keyBytes), Uint8List(16)),
          null,
        ),
      );

    final Uint8List decrypted = cipher.process(cipherText);
    return jsonDecode(utf8.decode(decrypted)) as Map<String, dynamic>;
  } catch (e, stacktrace) {
    if (debug) {
      logger('Decrypt error: $e');
      logger(stacktrace);
    }
    rethrow;
  }
}

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

Set<Contact> parseMultipleKeys(String inputText) {
  final Set<Contact> contacts = <Contact>{};

  // Strategy: Find v2 addresses first, then v1 pubkeys
  // This avoids truncating v2 addresses when extracting 44-char chunks

  // We need to find sequences that could be v2 addresses or v1 pubkeys
  // v2 addresses start with 'g1' are longer (typically 48-50 chars)
  // v1 pubkeys are base58 strings (43-44 chars)

  // Step 1: Use a broader regex to find potential base58 sequences
  // This regex matches any sequence of 1+ base58 characters
  final RegExp baseRegex = RegExp(r'[1-9A-HJ-NP-Za-km-z]+');
  final Iterable<RegExpMatch> potentialMatches =
      baseRegex.allMatches(inputText);

  String textWithV2Removed = inputText;
  int v2Count = 0;

  // First pass: find and validate v2 addresses
  for (final RegExpMatch match in potentialMatches) {
    final String? candidate = match.group(0);
    if (candidate != null &&
        candidate.length >= 48 &&
        isValidV2Address(candidate)) {
      loggerDev('Found v2 address: $candidate');
      v2Count++;
      try {
        contacts.add(Contact.withAddress(
          address: candidate,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        ));
      } catch (e) {
        loggerDev('Error adding v2 $candidate $e');
      }
      // Remove this v2 address from text to avoid extracting parts of it
      textWithV2Removed = textWithV2Removed.replaceFirst(candidate, '');
    }
  }

  // Step 2: Find v1 pubkeys in the remaining text
  final Iterable<RegExpMatch> v1Matches = regex.allMatches(textWithV2Removed);
  loggerDev(
      '[parseMultipleKeys] Found $v2Count v2 addresses, ${v1Matches.length} potential v1 pubkeys');

  for (final RegExpMatch match in v1Matches) {
    final String? publicKey = match.group(0);
    if (publicKey != null && validateKey(publicKey)) {
      loggerDev('Found v1 pubkey: $publicKey');
      try {
        contacts.add(Contact(pubKey: publicKey));
      } catch (e) {
        loggerDev('Error adding v1 $publicKey $e');
      }
    }
  }

  loggerDev('[parseMultipleKeys] Total contacts found: ${contacts.length}');
  return contacts;
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

const Duration paymentTimeRange = Duration(minutes: 60);

List<Transaction> lastTx(List<Transaction> origTxs) {
  return origTxs
      .where((Transaction tx) =>
          areDatesClose(DateTime.now(), tx.time, paymentTimeRange))
      .toList();
}

Uint8List encryptAes(Uint8List data, Uint8List key) {
  final pc.ECBBlockCipher cipher = pc.ECBBlockCipher(pc.AESEngine())
    ..init(true, pc.KeyParameter(key));
  final Uint8List out = Uint8List(data.length);
  for (int i = 0; i < data.length; i += cipher.blockSize) {
    cipher.processBlock(data, i, out, i);
  }
  return out;
}

Uint8List decryptAes(Uint8List encryptedData, Uint8List key) {
  final pc.ECBBlockCipher cipher = pc.ECBBlockCipher(pc.AESEngine())
    ..init(false, pc.KeyParameter(key));
  final Uint8List out = Uint8List(encryptedData.length);
  for (int i = 0; i < encryptedData.length; i += cipher.blockSize) {
    cipher.processBlock(encryptedData, i, out, i);
  }
  return out;
}

// Based on duniter-vue
DateTime estimateDateFromBlock(
    {required int futureBlock, required int currentBlockHeight}) {
  const int millisPerBlock = 6000;
  final int diff = futureBlock - currentBlockHeight;
  return DateTime.now().add(Duration(milliseconds: diff * millisPerBlock));
}

bool isMe(Contact contact, String publicAddress) =>
    extractPublicKey(contact.pubKey) == extractPublicKey(publicAddress);

String humanizePubKey(String rawAddress, [bool minimal = false]) {
  final String address = extractPublicKey(rawAddress);
  return minimal
      ? '\u{1F5DD} ${simplifyPubKey(address).substring(0, 4)}'
      : '\u{1F5DD} ${simplifyPubKey(address)}';
}

String humanizeAddress(String address, [bool minimal = false]) {
  return minimal
      ? ' \u{1F511} ${simplifyPubKey(address).substring(0, 4)}'
      : ' \u{1F511} ${simplifyPubKey(address)}';
}

String simplifyPubKey(String address) => address.length <= 8
    ? 'WRONG ADDRESS'
    : '${address.substring(0, 4)}…${address.substring(address.length - 4)}';

String humanizeFromToPubKey(String publicAddress, String address) {
  if (address == publicAddress) {
    return tr('your_wallet');
  } else {
    return humanizePubKey(address);
  }
}

/// Helper to create a Contact from either v1 pubkey or v2 address
Contact createContactFromKey(String key) {
  // Check if it's a v2 address
  if (isValidV2Address(key)) {
    // It's a v2 address, convert to v1 pubkey
    final String v1PubKey = v1pubkeyFromAddress(key);
    return Contact(pubKey: v1PubKey, address: key);
  } else {
    // It's a v1 pubkey (or should be)
    return Contact(pubKey: key);
  }
}
