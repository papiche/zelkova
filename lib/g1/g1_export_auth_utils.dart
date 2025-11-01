import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/pointycastle.dart';

import 'g1_helper.dart';

String generateWif(CesiumWallet wallet) {
  final Uint8List seed = wallet.seed;
  if (seed.length != 32) {
    throw ArgumentError('Private key must be 32 bytes long');
  }
  final List<int> wifData = <int>[0x01];
  wifData.addAll(seed);
  final List<int> doubleHash =
      sha256.convert(sha256.convert(Uint8List.fromList(wifData)).bytes).bytes;
  final List<int> checksum = doubleHash.sublist(0, 2);
  wifData.addAll(checksum);
  return Base58Encode(Uint8List.fromList(wifData));
}

String generateEwif(CesiumWallet wallet, String password) {
  final Uint8List seed = wallet.seed;
  final Uint8List signPk = Uint8List.fromList(Base58Decode(wallet.pubkey));
  final List<int> ewifData = <int>[0x02];
  final List<int> salt =
      sha256.convert(sha256.convert(signPk).bytes).bytes.sublist(0, 4);
  ewifData.addAll(salt);
  final ScryptParameters scryptParams =
      ScryptParameters(16384, 8, 8, 64, Uint8List.fromList(salt));
  final KeyDerivator scrypt = KeyDerivator('scrypt')..init(scryptParams);
  final Uint8List scryptSeed =
      scrypt.process(Uint8List.fromList(password.codeUnits));
  final Uint8List derivedhalf1 = scryptSeed.sublist(0, 32);
  final Uint8List derivedhalf2 = scryptSeed.sublist(32, 64);
  final Uint8List xorHalf1 = Uint8List(16);
  final Uint8List xorHalf2 = Uint8List(16);
  for (int i = 0; i < 16; i++) {
    xorHalf1[i] = seed[i] ^ derivedhalf1[i];
    xorHalf2[i] = seed[i + 16] ^ derivedhalf1[i + 16];
  }

  final Uint8List encryptedHalf1 = encryptAes(xorHalf1, derivedhalf2);
  final Uint8List encryptedHalf2 = encryptAes(xorHalf2, derivedhalf2);

  ewifData.addAll(encryptedHalf1);
  ewifData.addAll(encryptedHalf2);

  final List<int> checksum = sha256
      .convert(sha256.convert(Uint8List.fromList(ewifData)).bytes)
      .bytes
      .sublist(0, 2);
  ewifData.addAll(checksum);

  return Base58Encode(Uint8List.fromList(ewifData));
}

final String keyFileNamePrefix = tr('wallet_key_prefix');

Map<String, String> generatePubSecFile(String pubKey, String secKey) {
  final String fileName = 'g1-$keyFileNamePrefix-$pubKey-PubSec.dunikey';
  final String content = '''
Type: PubSec
Version: 1
pub: $pubKey
sec: $secKey
''';
  return <String, String>{fileName: content};
}

Map<String, String> generateWifFile(String pubKey, String wifData) {
  final String fileName = 'g1-$keyFileNamePrefix-$pubKey-WIF.dunikey';
  final String content = '''
Type: WIF
Version: 1
Data: $wifData
''';
  return <String, String>{fileName: content};
}

Map<String, String> generateEwifFile(String pubKey, String ewifData) {
  final String fileName = 'g1-$keyFileNamePrefix-$pubKey-EWIF.dunikey';
  final String content = '''
Type: EWIF
Version: 1
Data: $ewifData
''';
  return <String, String>{fileName: content};
}

String getPrivKey(CesiumWallet wallet) {
  final Uint8List privKeyComplete =
      Uint8List.fromList(wallet.seed + wallet.rootKey.publicKey);
  return Base58Encode(privKeyComplete);
}

Future<CesiumWallet> parseKeyFile(String fileContent,
    [BuildContext? context, String? password]) async {
  final RegExp typeRegExp = RegExp(r'^Type: (\w+)', multiLine: true);
  final RegExp pubRegExp = RegExp(r'pub: ([a-zA-Z0-9]+)', multiLine: true);
  final RegExp secRegExp = RegExp(r'sec: ([a-zA-Z0-9]+)', multiLine: true);
  final RegExp dataRegExp = RegExp(r'Data: ([a-zA-Z0-9]+)', multiLine: true);

  final Match? typeMatch = typeRegExp.firstMatch(fileContent);
  if (typeMatch == null) {
    throw const FormatException('We cannot detect the type of the file.');
  }

  final String fileType = typeMatch.group(1)!;
  switch (fileType) {
    case 'PubSec':
      return _parsePubSec(fileContent, pubRegExp, secRegExp);
    case 'WIF':
      return _parseWif(fileContent, dataRegExp);
    case 'EWIF':
      return password != null && password.isNotEmpty
          ? _parseEwif(fileContent, password, dataRegExp)
          : _promptPasswordForEwif(context!, fileContent, dataRegExp);
    default:
      throw FormatException('Type $fileType not supported.');
  }
}

Future<CesiumWallet> _promptPasswordForEwif(
    BuildContext context, String fileContent, RegExp dataRegExp) async {
  final TextEditingController passwordController = TextEditingController();
  final String? password = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('enter_password')),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: tr('password'),
            hintText: tr('password_hint'),
          ),
          onSubmitted: (String value) {
            if (value.trim().isNotEmpty) {
              Navigator.of(context).pop(value.trim());
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('cancel')),
          ),
          TextButton(
            onPressed: () {
              final String pwd = passwordController.text.trim();
              if (pwd.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('password_empty_error')),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              Navigator.of(context).pop(pwd);
            },
            child: Text(tr('ok')),
          ),
        ],
      );
    },
  );

  if (password == null || password.isEmpty) {
    throw const FormatException('EWIF file parsing was cancelled.');
  }

  // Show loading dialog during slow EWIF decryption
  if (!context.mounted) {
    throw const FormatException('Context not mounted');
  }

  // Show progress dialog
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(tr('validating_credentials')),
              const SizedBox(height: 8),
              Text(
                tr('ewif_decryption_slow'),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );

  try {
    // Allow UI to update with progress dialog
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final CesiumWallet wallet = _parseEwif(fileContent, password, dataRegExp);

    if (context.mounted) {
      Navigator.of(context).pop(); // Close progress dialog
    }

    return wallet;
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context).pop(); // Close progress dialog
    }
    rethrow;
  }
}

CesiumWallet _parsePubSec(
    String fileContent, RegExp pubRegExp, RegExp secRegExp) {
  final Match? pubMatch = pubRegExp.firstMatch(fileContent);
  final Match? secMatch = secRegExp.firstMatch(fileContent);

  if (pubMatch == null || secMatch == null) {
    throw const FormatException('Missing data in PubSec file.');
  }

  final Uint8List privKeyComplete =
      Uint8List.fromList(Base58Decode(secMatch.group(1)!));

  final Uint8List privKey = privKeyComplete.sublist(0, 32);

  return CesiumWallet.fromSeed(privKey);
}

CesiumWallet _parseWif(String fileContent, RegExp dataRegExp) {
  final Match? dataMatch = dataRegExp.firstMatch(fileContent);
  if (dataMatch == null) {
    throw const FormatException('Missing data in WIF file.');
  }

  final Uint8List wifBytes =
      Uint8List.fromList(Base58Decode(dataMatch.group(1)!));
  final Uint8List privKey =
      wifBytes.sublist(1, 33); // Exclude prefix and checksum

  if (privKey.length != 32) {
    throw FormatException(
        'Private key length is not 32 bytes, found: ${privKey.length}');
  }

  return CesiumWallet.fromSeed(privKey);
}

CesiumWallet _parseEwif(
    String fileContent, String password, RegExp dataRegExp) {
  final Match? dataMatch = dataRegExp.firstMatch(fileContent);
  if (dataMatch == null) {
    throw const FormatException('Wrong data in EWIF file.');
  }

  final Uint8List ewifBytes =
      Uint8List.fromList(Base58Decode(dataMatch.group(1)!));
  final Uint8List salt = ewifBytes.sublist(1, 5);
  final Uint8List encryptedHalf1 = ewifBytes.sublist(5, 21);
  final Uint8List encryptedHalf2 = ewifBytes.sublist(21, 37);

  final ScryptParameters scryptParams = ScryptParameters(16384, 8, 8, 64, salt);
  final KeyDerivator scrypt = KeyDerivator('scrypt')..init(scryptParams);
  final Uint8List scryptSeed =
      scrypt.process(Uint8List.fromList(password.codeUnits));

  final Uint8List derivedhalf1 = scryptSeed.sublist(0, 32);
  final Uint8List derivedhalf2 = scryptSeed.sublist(32, 64);

  final Uint8List decryptedHalf1 = decryptAes(encryptedHalf1, derivedhalf2);
  final Uint8List decryptedHalf2 = decryptAes(encryptedHalf2, derivedhalf2);

  final Uint8List privKey = Uint8List(32);
  for (int i = 0; i < 16; i++) {
    privKey[i] = decryptedHalf1[i] ^ derivedhalf1[i];
    privKey[i + 16] = decryptedHalf2[i] ^ derivedhalf1[i + 16];
  }

  if (privKey.length != 32) {
    throw FormatException(
        'Private key length is not 32 bytes, found: ${privKey.length}');
  }

  return CesiumWallet.fromSeed(privKey);
}
