import 'dart:typed_data';

import 'package:bip39_multi_nullsafety/src/wordlists/spanish.dart' as spanish;
import 'package:durt/src/crypto/cesium_wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';
import 'package:ginkgo/ui/logger.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:substrate_bip39/substrate_bip39.dart';

void main() {
  group('isValidAddress', () {
    test('returns true for valid addresses', () {
      final List<String> validAddresses = <String>[
        '5GrpknVvGGrGH3EFuURXeMrWHvbpj3VfER1oX5jFtuGbfzCE',
        '5FLdosNUhAJ4zW8NKp65yaXEECUwkuNqVRcmjTEsZ8vvkxuP'
      ];

      for (final String address in validAddresses) {
        expect(isValidV2Address(address), isTrue);
      }
    });

    test('returns false for invalid addresses', () {
      final List<String> invalidAddresses = <String>[
        '1G9tTobcmjgjSg2CEGjmFqZBbB3LQ85PhpMXD7NfnKhhJd3',
        '1KjvmrF1uVSaJvmjF1uVSaJF1uVSaJZ9QZ5',
        'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'
      ];

      for (final String address in invalidAddresses) {
        expect(isValidV2Address(address), isFalse);
      }
    });
  });

  test('v1PubKeyToV2 and back', () {
    final List<List<String>> keyPairs = <List<String>>[
      <String>[
        '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH',
        '5DpRqhjEof2WMFoAYTAqqoQzyBH9zRRmAbBZGQm9uZSzNeY6'
      ],
    ];

    for (final List<String> keyPair in keyPairs) {
      final String v1pubkey = keyPair[0];
      final String expectedV2Address = keyPair[1];
      expect(addressFromV1Pubkey(v1pubkey), equals(expectedV2Address));
      expect(isValidV2Address(expectedV2Address), true);
      expect(addressFromV1Pubkey(v1pubkey), equals(expectedV2Address));
      expect(v1pubkeyFromAddress(expectedV2Address), equals(v1pubkey));
    }
  });

  test('generate a v1 wallet and convert to a keypair and back', () async {
    const String secret = 'test';
    const String password = 'test';
    final CesiumWallet wallet = CesiumWallet(secret, password);
    final String v1PubKey = wallet.pubkey;
    final String v2Address = addressFromV1Pubkey(v1PubKey);
    final Uint8List seed = wallet.seed;
    final Keyring keyring = Keyring();
    final KeyPair keypair =
        await keyring.fromSeed(seed, keyPairType: KeyPairType.ed25519);
    expect(keypair.address, equals(v2Address));
  });

  test(
      'generate a keypair via mnemonic and do test with addresses and v1 pubkeys ',
      () async {
    //const String devMnemonic =
    //    'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
    const String devMnemonic =
        'drama dream insane parrot train corn steak latin voice extend fragile concert';
    final Keyring devKeyring = Keyring();
    final KeyPair devKeyPairEd = await devKeyring.fromMnemonic(devMnemonic,
        keyPairType: KeyPairType.ed25519);
    final KeyPair devKeyPairSr = await devKeyring.fromMnemonic(devMnemonic,
        keyPairType: KeyPairType.sr25519);
    const String expectedV2DevAddressSr =
        '5GTy25GQxWinyhAafiwfVqNV3qFCwJkpbcpzkwKu3qk8HoJN';
    const String expectedV2DevAddressEd =
        '5HEwSt1D87Hx161vrqmuCy975y2TFMRqpbja6DcQUNkBLL5b';
    expect(devKeyPairEd.address, equals(expectedV2DevAddressEd));
    expect(devKeyPairSr.address, equals(expectedV2DevAddressSr));
    expect(isValidV2Address(expectedV2DevAddressEd), true);
    const String expectedV1PubKeySr =
        'E6xXZNFciyNfdgqcY7QUm1vQcBgPP3dQZegcj8GGSYgV';
    const String expectedV1PubKeyEd =
        'GQrGV3TeEVvA22jtaEUseyEUMajxgsbGPbE5kNpGi3wi';
    expect(v1pubkeyFromAddress(expectedV2DevAddressEd),
        equals(expectedV1PubKeyEd));
    expect(v1pubkeyFromAddress(expectedV2DevAddressSr),
        equals(expectedV1PubKeySr));

    // No sr25519 seed support yet
    // https://github.com/leonardocustodio/polkadart/issues/448
    final List<int> devSeed =
        await SubstrateBip39.ed25519.seedFromUri(devMnemonic);
    final Uint8List devSeedU8a = Uint8List.fromList(devSeed);
    final CesiumWallet wallet2 = CesiumWallet.fromSeed(devSeedU8a);
    expect(wallet2.pubkey, equals(expectedV1PubKeyEd));
  });

  // Disabled as polkadot does not support spanish mnemonics
  test('Spanish bit39', skip: true, () async {
    final List<String> esMnemonicList =
        mnemonicGenerate(lang: 'spanish').split(' ');

    final Keyring keyring = Keyring();
    final String mnemonic = esMnemonicList.join(' ');
    loggerDev(mnemonic);
    await keyring.fromMnemonic(mnemonic, keyPairType: KeyPairType.sr25519);

    for (final String esWord in esMnemonicList) {
      expect(spanish.WORDLIST.contains(esWord), true);
    }
  });
}
