import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:pointycastle/export.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

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
  final String address = keyring.encodeAddress(pubkeyByte);
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
  keyring.add(keypair);
  return keyring;
}

Keyring keyringFromSeed(Uint8List seed) {
  final Keyring keyring = Keyring();
  final KeyPair keypair = KeyPair.sr25519.fromSeed(seed);
  keyring.add(keypair);
  return keyring;
}

class AuthDataV1 {
  AuthDataV1(this.password, this.salt);

  String password;
  String salt;
}

class AuthDataV2 {
  AuthDataV2(this.mnemonic, this.meta);

  String mnemonic;
  String meta;
}

class AuthData {
  AuthData({this.v1, this.v2});

  AuthDataV1? v1;
  AuthDataV2? v2;
}

Future<KeyPair> createPair(AuthData data, Keyring keyring) async {
  if (data.v1 != null) {
    final List<int> password = data.v1!.password.codeUnits;
    final String salt = data.v1!.salt;
    final Uint8List passwordU8a = Uint8List.fromList(password);
    final Uint8List saltU8a = Uint8List.fromList(salt.codeUnits);
    final Scrypt scrypt = Scrypt()
      ..init(ScryptParameters(4096, 16, 1, 32, saltU8a));
    final Uint8List seedBytes = scrypt.process(passwordU8a);
    final String seedHex = Base58Encode(seedBytes);
    final KeyPair keyPair = await keyring.fromUri(seedHex,
        password: data.v1!.password, keyPairType: KeyPairType.ed25519);
    return keyPair;
  } else if (data.v2 != null) {
    final KeyPair keyPair = await keyring.fromUri(data.v2!.mnemonic,
        password: data.v2!.meta, keyPairType: KeyPairType.sr25519);
    return keyPair;
  } else {
    throw Exception('Data format not recognized');
  }
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
  final String mnemonic = generateMnemonic(lang: lang);
  return mnemonic;
}

// From:
// https://polkadot.js.org/docs/keyring/start/create
Future<KeyPair> addPair() async {
  final String mnemonic = mnemonicGenerate();
  final Keyring keyring = Keyring();
  // create & add the pair to the keyring with the type
  // TODOAdd some additional metadata as in polkadot-js

  final KeyPair pair =
      await keyring.fromUri(mnemonic, keyPairType: KeyPairType.sr25519);

  return pair;
}
/*
Future<Map<String, dynamic>> createAccount(
    AuthData data, Keyring keyring) async {
  final KeyPair pair = await createPair(data, keyring);
  final String? publicKeyV1 = pair.keyPairType == KeyPairType.ed25519
      ? Base58Encode(pair.publicKey.bytes)
      : null;

  final String name = data.v2?.meta ??
      (publicKeyV1 != null
          ? formatPubkey(publicKeyV1)
          : formatAddress(pair.address));


  Map<String, dynamic> accountMeta = {
    'name': name,
    'publicKeyV1': publicKeyV1,
    'genesisHash':
    ...data.v2?.meta ?? {}
  };

  Account account = Account(pair.address, pair.publicKey, accountMeta);
  pair.setMeta(account.meta);

  return {'pair': pair, 'account': account};
}

String formatAddress(String value) {
  if (value.isEmpty) {
    return '';
  }
  if (value.length < 12) {
    return '?';
  }
  return '${value.substring(0, 6)}\u2026${value.substring(value.length - 6)}';
}

String formatPubkey(String value) {
  if (value.isEmpty) {
    return '';
  }
  if (value.length < 12) {
    return '?';
  }
  return '${value.substring(0, 4)}\u2026${value.substring(value.length - 4)}';
}
*/
