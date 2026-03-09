import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/crypto/cesium_wallet.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';
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
        'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM',
      ],
      <String>[
        'DU7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZ',
        'g1PAf1Dg6NAtsece62shM98dgmGiCF36PDJjfJ86aCYhe78XP',
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
        keyring.fromSeed(seed, keyPairType: KeyPairType.ed25519);
    keypair.ss58Format = 4450;
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

    final List<int> devSeed =
        await SubstrateBip39.ed25519.seedFromUri(devMnemonic);
    final Uint8List devSeedU8a = Uint8List.fromList(devSeed);
    final CesiumWallet wallet2 = CesiumWallet.fromSeed(devSeedU8a);
    expect(wallet2.pubkey, equals(expectedV1PubKeyEd));
  });

  test('sign and verify', () async {
    // https://polkadart.dev/keyring-signer/sign-verify/
    const String messageS = 'lorem ipsum dolor sit amet';
    final Uint8List message = Uint8List.fromList(utf8.encode(messageS));
    final Keyring keyring = Keyring();
    const String password = 'devtest';
    final CesiumWallet walletV1 = CesiumWallet(password, password);
    final KeyPair keyPair2 = KeyPair.ed25519.fromSeed(walletV1.seed);

    keyring.add(keyPair2);
    final KeyPair keypair = keyring.getByPublicKey(keyPair2.publicKey.bytes);
    final Uint8List signature = keypair.sign(message);

    final bool isVerified = keypair.verify(message, signature);
    expect(isVerified, true);
  });

  test('test mnemonic to pubkey', () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';
    expect(mnemonic.split(' ').length, 12);
    expect(isValidMnemonic(mnemonic), true);
    // pubkey should be: 5EHgWw2Af1pnoc7f1A8bfmM97W3DAYW8xr82RfhLL9oAabAe
    final Keyring keyring = Keyring();
    final KeyPair keypair =
        await keyring.fromMnemonic(mnemonic, keyPairType: KeyPairType.sr25519);
    expect(keypair.address, '5EHgWw2Af1pnoc7f1A8bfmM97W3DAYW8xr82RfhLL9oAabAe');
    final KeyPair keypair2 =
        await keyring.fromMnemonic(mnemonic, keyPairType: KeyPairType.ed25519);
    expect(
        keypair2.address, '5ErKjJLUyc8TTU2vNKrj5UciogZho2MDawb6nN2KG44aU1aB');
  });

  test('mnemonic to stored account', () async {
    const String mnemonic =
        'legal winner thank year wave sausage worth useful legal winner thank yellow';
    final Uint8List a = mnemonicToStore(mnemonic);
    final String b = storeToMnemonic(a);
    expect(mnemonic, equals(b));
  });

  group('decodeHexToText', () {
    test('should decode valid UTF-8 string', () {
      const String hex = '48656c6c6f20576f726c64'; // "Hello World"
      expect(decodeHexToText(hex), 'Hello World');
    });

    test(r'should decode hex with \x prefix', () {
      const String hex = r'\x48\x65\x6c\x6c\x6f'; // "Hello"
      expect(decodeHexToText(hex), 'Hello');
    });

    test('should decode accented characters like Resumé', () {
      const String hex = '526573756dc3a9'; // Resumé
      expect(decodeHexToText(hex), 'Resumé');
    });

    test('should fallback to Latin-1 when UTF-8 fails', () {
      const String hex = '5465737420e1'; // "Test á" (á in Latin-1)
      expect(decodeHexToText(hex), 'Test á');
    });

    test('should fallback to malformed UTF-8 if needed', () {
      const String hex = '54657374ff54657374'; // Invalid byte in middle
      final String result = decodeHexToText(hex);
      expect(result.contains('Test'), isTrue);
    });

    test('should return empty string on empty input', () {
      expect(decodeHexToText(''), '');
    });

    test('should return empty string on null input', () {
      expect(decodeHexToText(null), '');
    });

    test('should return original input on invalid hex', () {
      const String invalid = 'zz1234';
      expect(decodeHexToText(invalid), invalid);
    });

    test('should decode UTF-8 string with emoji and symbols', () {
      const String hex = '48656c6c6f20f09f9a80e29c94'; // "Hello 🚀✔"
      expect(decodeHexToText(hex), 'Hello 🚀✔');
    });

    test('should decode Chinese characters', () {
      const String hex = 'e4b8ade69687'; // 中文 (Chinese)
      expect(decodeHexToText(hex), '中文');
    });

    test('should decode mixed ASCII and Chinese', () {
      const String hex = '48656c6c6f20e4b8ade69687'; // "Hello 中文"
      expect(decodeHexToText(hex), 'Hello 中文');
    });

    test('should decode Japanese characters', () {
      const String hex = 'e38182e38184e38186'; // あいう (Hiragana)
      expect(decodeHexToText(hex), 'あいう');
    });

    test('should decode Arabic characters', () {
      const String hex = 'd8b3d984d8a7d985'; // سلام (salaam)
      expect(decodeHexToText(hex), 'سلام');
    });

    test('should decode emoji-only string', () {
      const String hex = 'f09f9a80f09f8c9f'; // 🚀🌟
      expect(decodeHexToText(hex), '🚀🌟');
    });

    test('should decode long multi-language string', () {
      const String hex =
          '48656c6c6f2c20e4b8ade69687e38182e38184e38186d8b3d984d8a7d985f09f9a80';
      // "Hello, 中文あいうسلام🚀"
      expect(decodeHexToText(hex), 'Hello, 中文あいうسلام🚀');
    });

    test('should ignore odd-length hex strings safely', () {
      const String hex = '48656c6c6f2'; // Missing one digit
      final String result = decodeHexToText(hex);
      expect(result.contains('Hell'), isTrue); // partial decode
    });

    test('should return original input if all bytes are invalid', () {
      const String hex = 'zzzzzz';
      expect(decodeHexToText(hex), hex);
    });
  });

  test(
      'deriveKeyPairWithPath should generate different keys for different paths',
      () async {
    const String devMnemonic =
        'drama dream insane parrot train corn steak latin voice extend fragile concert';

    final KeyPair rootKp = await deriveKeyPairCompat(devMnemonic);
    final String rootAddress = rootKp.address;

    final KeyPair derived0 = await deriveKeyPairWithPath(devMnemonic, 0);
    final KeyPair derived1 = await deriveKeyPairWithPath(devMnemonic, 1);

    expect(derived0.address, isNot(equals(rootAddress)));
    expect(derived1.address, isNot(equals(rootAddress)));
    expect(derived0.address, isNot(equals(derived1.address)));

    // Derive same path should be deterministic
    final KeyPair derived0b = await deriveKeyPairWithPath(devMnemonic, 0);
    expect(derived0.address, equals(derived0b.address));
  });
}
