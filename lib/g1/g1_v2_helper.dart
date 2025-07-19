import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:durt/durt.dart' as durt;
import 'package:fast_base58/fast_base58.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../ui/logger.dart';
import 'g1_helper.dart';

// From:
// https://polkadot.js.org/docs/util-crypto/examples/validate-address/
bool isValidV2Address(String address) {
  try {
    final Keyring keyring = Keyring();
    keyring.encodeAddress(
        isHex(address) ? hexToU8a(address) : keyring.decodeAddress(address),
        4450);
    return true;
  } catch (error) {
    return false;
  }
}

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

String addressFromV1Pubkey(String pubkey) {
  final Keyring keyring = Keyring();
  final List<int> pubkeyByte = Base58Decode(pubkey);
  final String address = keyring.encodeAddress(pubkeyByte, 4450);
  return address;
}

String v1pubkeyFromAddress(String address) {
  final Keyring keyring = Keyring();
  final Uint8List publicKeyBytes = keyring.decodeAddress(address);
  final String publicKey = Base58Encode(publicKeyBytes);
  return publicKey;
}

Keyring keyringFromV1Seed(Uint8List seed) {
  final Keyring keyring = Keyring();
  final KeyPair keypair = KeyPair.ed25519.fromSeed(seed);
  keypair.ss58Format = 4450;
  keyring.add(keypair);
  return keyring;
}

// From durt
String mnemonicGenerate({String lang = 'english'}) {
  final List<String> supportedLanguages = <String>[
    'english',
    'french',
    'italian',
    'spanish'
  ];
  if (!supportedLanguages.contains(lang)) {
    throw ArgumentError('Unsupported language');
  }
  final String mnemonic = durt.generateMnemonic(lang: lang);
  return mnemonic;
}

// From:
// https://polkadot.js.org/docs/keyring/start/create
Future<KeyPair> createKeyPair() async {
  final String mnemonic = mnemonicGenerate();
  final Keyring keyring = Keyring();
  // create & add the pair to the keyring with the type
  // TODOAdd some additional metadata as in polkadot-js

  final KeyPair pair =
      await keyring.fromUri(mnemonic, keyPairType: KeyPairType.ed25519);
  pair.ss58Format = 4450;
  return pair;
}

String addressFromV1PubkeyFaiSafe(String pubKeyRaw) {
  try {
    return addressFromV1Pubkey(extractPublicKey(pubKeyRaw));
  } catch (e) {
    loggerDev('Error converting pubkey $pubKeyRaw to address: $e');
    rethrow;
  }
}

Uint8List mnemonicToStore(String mnemonic) =>
    Uint8List.fromList(utf8.encode(mnemonic));

String storeToMnemonic(Uint8List storedMnemonic) => utf8.decode(storedMnemonic);

// From https://forum.duniter.org/t/gecko-talks-user-support/9372/490
// Thanks to @poka
String decodeHexToText(String? hexString) {
  if (hexString == null) {
    return '';
  }

  try {
    // Remove any leading backslash-x prefix if present
    final String cleanHex = hexString.replaceAll(r'\x', '');

    // Convert hex string to bytes
    final List<int> bytes = <int>[];
    for (int i = 0; i < cleanHex.length; i += 2) {
      if (i + 1 < cleanHex.length) {
        final String hexByte = cleanHex.substring(i, i + 2);
        final int? byte = int.tryParse(hexByte, radix: 16);
        if (byte == null) {
          // If any byte is invalid, return original input
          return hexString;
        }
        bytes.add(byte);
      }
    }

    // Try UTF-8 first
    try {
      final String result = utf8.decode(bytes);
      // Check if the result contains replacement characters
      if (!result.contains('�')) {
        return result;
      }
    } catch (_) {}

    // If UTF-8 fails or contains replacement characters, try Latin-1
    try {
      final String result = latin1.decode(bytes);
      return result;
    } catch (_) {}

    // If both fail, fallback to UTF-8 with malformed allowed
    final String result = utf8.decode(bytes, allowMalformed: true);
    return result;
  } catch (e) {
    // If decoding fails, return the original string
    log.e('Error decoding hex string: $e');
    return hexString;
  }
}
