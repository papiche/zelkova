import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
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

final List<Language> supportedMnemonicLanguages = Language.values.toList();

String mnemonicGenerate({Language lang = Language.english}) {
  if (!supportedMnemonicLanguages.contains(lang)) {
    throw ArgumentError('Unsupported language');
  }
  return Mnemonic.generate(lang, length: MnemonicLength.words12).sentence;
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
  } catch (e, s) {
    log.e('Error converting pubkey $pubKeyRaw to address: $e',
        error: e, stackTrace: s);
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

Future<KeyPair> deriveKeyPairCompat(
  String mnemonic, {
  int ss58 = 4450,
  KeyPairType keyPairType = KeyPairType.ed25519,
}) async {
  try {
    final KeyPair kp =
        await Keyring().fromMnemonic(mnemonic, keyPairType: keyPairType);
    kp.ss58Format = ss58;
    return kp;
  } catch (_) {
    final String en = toEnglishMnemonic(mnemonic);
    final KeyPair kp =
        await Keyring().fromMnemonic(en, keyPairType: keyPairType);
    kp.ss58Format = ss58;
    return kp;
  }
}

Future<KeyPair> deriveKeyPairWithPath(
  String mnemonic,
  int derivationIndex, {
  int ss58 = 4450,
  KeyPairType keyPairType = KeyPairType.ed25519,
}) async {
  try {
    final String uri = '$mnemonic//$derivationIndex';
    final KeyPair kp = await Keyring().fromUri(uri, keyPairType: keyPairType);
    kp.ss58Format = ss58;
    return kp;
  } catch (_) {
    final String en = toEnglishMnemonic(mnemonic);
    final String uri = '$en//$derivationIndex';
    final KeyPair kp = await Keyring().fromUri(uri, keyPairType: keyPairType);
    kp.ss58Format = ss58;
    return kp;
  }
}

Language bip39LanguageFromLocale(Locale? locale) {
  final List<Locale> sys = PlatformDispatcher.instance.locales;
  final Locale L = locale ??
      (sys.isNotEmpty ? sys.first : PlatformDispatcher.instance.locale);
  final String lc = L.languageCode.toLowerCase();
  final String cc = (L.countryCode ?? '').toUpperCase();

  if (lc == 'zh') {
    if (cc == 'TW' || cc == 'HK' || cc == 'MO') {
      return Language.traditionalChinese;
    }
    return Language.simplifiedChinese;
  }

  final Map<String, Language> map = <String, Language>{
    'en': Language.english,
    'es': Language.spanish,
    'ast': Language.spanish,
    'ca': Language.spanish,
    'gl': Language.portuguese,
    'pt': Language.portuguese,
    'fr': Language.french,
    'it': Language.italian,
    'cs': Language.czech,
    'ko': Language.korean,
    'ja': Language.japanese,
    'de': Language.english,
    'nl': Language.english,
    'da': Language.english,
    'eu': Language.spanish,
    'eo': Language.english,
  };

  return map[lc] ?? Language.english;
}

bool _parsesAs(Language lang, String sentence) {
  try {
    Mnemonic.fromSentence(sentence.trim(), lang);
    return true;
  } catch (_) {
    return false;
  }
}

bool isValidMnemonic(String sentence) {
  final List<String> words = sentence.trim().split(RegExp(r'\s+'));
  if (words.length != 12) {
    return false;
  }
  final List<Language> langs = supportedMnemonicLanguages;
  for (final Language lang in langs) {
    if (_parsesAs(lang, sentence)) {
      return true;
    }
  }
  return false;
}

Language? detectMnemonicLanguage(String sentence, {List<Language>? languages}) {
  final List<String> words = sentence.trim().split(RegExp(r'\s+'));
  if (words.length != 12) {
    loggerDev('Invalid mnemonic length: ${words.length} words');
    return null;
  }
  final List<Language> langs = languages ?? supportedMnemonicLanguages;
  for (final Language lang in langs) {
    if (_parsesAs(lang, sentence)) {
      return lang;
    }
  }
  return null;
}

String toEnglishMnemonic(String sentence, {List<Language>? languages}) {
  final Language? lang = detectMnemonicLanguage(sentence, languages: languages);
  if (lang == null) {
    throw ArgumentError('Invalid 12-word mnemonic: $sentence');
  }
  final List<int> entropy =
      Mnemonic.fromSentence(sentence.trim(), lang).entropy;
  return Mnemonic(entropy, Language.english).sentence;
}
