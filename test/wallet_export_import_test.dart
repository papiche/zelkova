import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/wallet_themes.dart';
import 'package:zelkova/g1/crypto/cesium_wallet.dart';
import 'package:zelkova/g1/g1_helper.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

void main() {
  group('Wallet Export/Import Tests', () {
    const String testPattern = '12345678';

    test('Export and import V1 password-less wallet', () {
      // Given - Create a V1 password-less wallet
      final Uint8List seedBytes = generateUintSeed();
      final String seed = seedToString(seedBytes);
      final CesiumWallet wallet = generateCesiumWallet(seedBytes);
      final String pubKey = wallet.pubkey;

      final Map<String, dynamic> walletData = <String, dynamic>{
        'pubKey': pubKey,
        'seed': seed,
        'name': 'Test V1 PasswordLess Wallet',
      };

      // Create export data structure
      final Map<String, dynamic> exportData = <String, dynamic>{
        'cesiumCards': jsonEncode(<Map<String, dynamic>>[walletData]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and import
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['cesiumCards'], isNotNull);

      final List<dynamic> importedCards =
          jsonDecode(decrypted['cesiumCards'] as String) as List<dynamic>;
      expect(importedCards.length, equals(1));

      final Map<String, dynamic> importedWallet =
          importedCards[0] as Map<String, dynamic>;
      expect(importedWallet['pubKey'], equals(pubKey));
      expect(importedWallet['seed'], equals(seed));
      expect(importedWallet['name'], equals('Test V1 PasswordLess Wallet'));
    });

    test('Export and import V1 password-protected wallet', () {
      // Given - Create a V1 password-protected wallet (seed is empty)
      const String pubKey = '6JgGvDDBu8XWL89BTvzHCfVmJWbSRfBNb1ZK4dQW6fNK';
      final Map<String, dynamic> walletData = <String, dynamic>{
        'pubKey': pubKey,
        'seed': '', // Empty seed indicates password-protected
        'name': 'Test V1 PasswordProtected Wallet',
      };

      // Create export data structure
      final Map<String, dynamic> exportData = <String, dynamic>{
        'cesiumCards': jsonEncode(<Map<String, dynamic>>[walletData]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and import
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['cesiumCards'], isNotNull);

      final List<dynamic> importedCards =
          jsonDecode(decrypted['cesiumCards'] as String) as List<dynamic>;
      expect(importedCards.length, equals(1));

      final Map<String, dynamic> importedWallet =
          importedCards[0] as Map<String, dynamic>;
      expect(importedWallet['pubKey'], equals(pubKey));
      expect(importedWallet['seed'], equals(''));
      expect(
        importedWallet['name'],
        equals('Test V1 PasswordProtected Wallet'),
      );
    });

    test('Export and import V2 password-less wallet', () async {
      // Given - Create a V2 password-less wallet
      const String mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      final KeyPair kp = await deriveKeyPairCompat(mnemonic);
      final String address = kp.address;
      final String pubKey = v1pubkeyFromAddress(address);

      final Map<String, dynamic> v2WalletData = <String, dynamic>{
        'pubKey': pubKey,
        'address': address,
        'name': 'Test V2 PasswordLess Wallet',
        'type': 'v2PasswordLess',
        'mnemonic': mnemonic,
        'derivationPath': null,
        'derivationParentId': null,
        'theme': WalletThemes.theme1.toJson(),
      };

      // Create export data structure
      final Map<String, dynamic> exportData = <String, dynamic>{
        'v2Wallets': jsonEncode(<Map<String, dynamic>>[v2WalletData]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and import
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['v2Wallets'], isNotNull);

      final List<dynamic> importedWallets =
          jsonDecode(decrypted['v2Wallets'] as String) as List<dynamic>;
      expect(importedWallets.length, equals(1));

      final Map<String, dynamic> importedWallet =
          importedWallets[0] as Map<String, dynamic>;
      expect(importedWallet['pubKey'], equals(pubKey));
      expect(importedWallet['address'], equals(address));
      expect(importedWallet['mnemonic'], equals(mnemonic));
      expect(importedWallet['type'], equals('v2PasswordLess'));
      expect(importedWallet['name'], equals('Test V2 PasswordLess Wallet'));
    });

    test('Export and import V2 password-protected wallet', () async {
      // Given - Create a V2 password-protected wallet
      const String mnemonic =
          'legal winner thank year wave sausage worth useful legal winner thank yellow';
      final KeyPair kp = await deriveKeyPairCompat(mnemonic);
      final String address = kp.address;
      final String pubKey = v1pubkeyFromAddress(address);

      final Map<String, dynamic> v2WalletData = <String, dynamic>{
        'pubKey': pubKey,
        'address': address,
        'name': 'Test V2 PasswordProtected Wallet',
        'type': 'v2PasswordProtected',
        'mnemonic': mnemonic,
        'derivationPath': null,
        'derivationParentId': null,
        'theme': WalletThemes.theme1.toJson(),
      };

      // Create export data structure
      final Map<String, dynamic> exportData = <String, dynamic>{
        'v2Wallets': jsonEncode(<Map<String, dynamic>>[v2WalletData]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and import
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['v2Wallets'], isNotNull);

      final List<dynamic> importedWallets =
          jsonDecode(decrypted['v2Wallets'] as String) as List<dynamic>;
      expect(importedWallets.length, equals(1));

      final Map<String, dynamic> importedWallet =
          importedWallets[0] as Map<String, dynamic>;
      expect(importedWallet['pubKey'], equals(pubKey));
      expect(importedWallet['address'], equals(address));
      expect(importedWallet['mnemonic'], equals(mnemonic));
      expect(importedWallet['type'], equals('v2PasswordProtected'));
      expect(
        importedWallet['name'],
        equals('Test V2 PasswordProtected Wallet'),
      );
    });

    test('Export and import mixed wallet types (V1 + V2)', () async {
      // Given - Create multiple wallets of different types
      // V1 password-less
      final Uint8List v1SeedBytes = generateUintSeed();
      final String v1Seed = seedToString(v1SeedBytes);
      final CesiumWallet v1Wallet = generateCesiumWallet(v1SeedBytes);
      final String v1PubKey = v1Wallet.pubkey;
      final Map<String, dynamic> v1WalletData = <String, dynamic>{
        'pubKey': v1PubKey,
        'seed': v1Seed,
        'name': 'V1 Wallet in Mixed Export',
      };

      // V1 password-protected
      const String v1ProtectedPubKey =
          '6SvSMyZSTUFtKo8BJEN959xRX4ze9K3WT7SBK9tqR5vh';
      final Map<String, dynamic> v1ProtectedData = <String, dynamic>{
        'pubKey': v1ProtectedPubKey,
        'seed': '',
        'name': 'V1 Protected in Mixed Export',
      };

      // V2 password-less
      const String v2Mnemonic =
          'letter advice cage absurd amount doctor acoustic avoid letter advice cage above';
      final KeyPair v2Kp = await deriveKeyPairCompat(v2Mnemonic);
      final String v2Address = v2Kp.address;
      final String v2PubKey = v1pubkeyFromAddress(v2Address);

      final Map<String, dynamic> v2WalletData = <String, dynamic>{
        'pubKey': v2PubKey,
        'address': v2Address,
        'name': 'V2 Wallet in Mixed Export',
        'type': 'v2PasswordLess',
        'mnemonic': v2Mnemonic,
        'derivationPath': null,
        'derivationParentId': null,
        'theme': WalletThemes.theme2.toJson(),
      };

      // V2 password-protected
      const String v2ProtectedMnemonic =
          'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong';
      final KeyPair v2ProtectedKp = await deriveKeyPairCompat(
        v2ProtectedMnemonic,
      );
      final String v2ProtectedAddress = v2ProtectedKp.address;
      final String v2ProtectedPubKey = v1pubkeyFromAddress(v2ProtectedAddress);

      final Map<String, dynamic> v2ProtectedData = <String, dynamic>{
        'pubKey': v2ProtectedPubKey,
        'address': v2ProtectedAddress,
        'name': 'V2 Protected in Mixed Export',
        'type': 'v2PasswordProtected',
        'mnemonic': v2ProtectedMnemonic,
        'derivationPath': null,
        'derivationParentId': null,
        'theme': WalletThemes.theme3.toJson(),
      };

      // Create export data structure with both V1 and V2 wallets
      final Map<String, dynamic> exportData = <String, dynamic>{
        'cesiumCards': jsonEncode(<Map<String, dynamic>>[
          v1WalletData,
          v1ProtectedData,
        ]),
        'v2Wallets': jsonEncode(<Map<String, dynamic>>[
          v2WalletData,
          v2ProtectedData,
        ]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and import
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );

      // Verify V1 wallets
      expect(decrypted['cesiumCards'], isNotNull);
      final List<dynamic> importedV1Cards =
          jsonDecode(decrypted['cesiumCards'] as String) as List<dynamic>;
      expect(importedV1Cards.length, equals(2));

      final Map<String, dynamic> importedV1Wallet =
          importedV1Cards[0] as Map<String, dynamic>;
      expect(importedV1Wallet['pubKey'], equals(v1PubKey));
      expect(importedV1Wallet['seed'], equals(v1Seed));

      final Map<String, dynamic> importedV1Protected =
          importedV1Cards[1] as Map<String, dynamic>;
      expect(importedV1Protected['pubKey'], equals(v1ProtectedPubKey));
      expect(importedV1Protected['seed'], equals(''));

      // Verify V2 wallets
      expect(decrypted['v2Wallets'], isNotNull);
      final List<dynamic> importedV2Wallets =
          jsonDecode(decrypted['v2Wallets'] as String) as List<dynamic>;
      expect(importedV2Wallets.length, equals(2));

      final Map<String, dynamic> importedV2Wallet =
          importedV2Wallets[0] as Map<String, dynamic>;
      expect(importedV2Wallet['pubKey'], equals(v2PubKey));
      expect(importedV2Wallet['mnemonic'], equals(v2Mnemonic));
      expect(importedV2Wallet['type'], equals('v2PasswordLess'));

      final Map<String, dynamic> importedV2Protected =
          importedV2Wallets[1] as Map<String, dynamic>;
      expect(importedV2Protected['pubKey'], equals(v2ProtectedPubKey));
      expect(importedV2Protected['mnemonic'], equals(v2ProtectedMnemonic));
      expect(importedV2Protected['type'], equals('v2PasswordProtected'));
    });

    test('Export with empty wallet lists should not create keys', () {
      // Given - Empty export
      final Map<String, dynamic> exportData = <String, dynamic>{};

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt and verify empty
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['cesiumCards'], isNull);
      expect(decrypted['v2Wallets'], isNull);
    });

    test('Decrypt with wrong pattern should fail', () {
      // Given
      final Uint8List seedBytes = generateUintSeed();
      final String seed = seedToString(seedBytes);
      final CesiumWallet wallet = generateCesiumWallet(seedBytes);
      final String pubKey = wallet.pubkey;
      final Map<String, dynamic> walletData = <String, dynamic>{
        'pubKey': pubKey,
        'seed': seed,
      };

      final Map<String, dynamic> exportData = <String, dynamic>{
        'cesiumCards': jsonEncode(<Map<String, dynamic>>[walletData]),
      };

      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // When/Then - Try to decrypt with wrong pattern
      expect(
        () => decryptJsonForImport(keyEncrypted, 'wrongpattern'),
        throwsA(isA<Error>()),
      );
    });

    test('Import malformed V2 wallet data should handle gracefully', () {
      // Given - Create malformed V2 wallet data (missing mnemonic)
      final Map<String, dynamic> malformedV2Data = <String, dynamic>{
        'pubKey': '6SvSMyZSTUFtKo8BJEN959xRX4ze9K3WT7SBK9tqR5vh',
        'address': '5EYCAe5ijiYfyeZ2JJCGq56LmPyNRAKzpG4QkoQkkQNB5e6Z',
        'name': 'Malformed V2 Wallet',
        'type': 'v2PasswordLess',
        // Missing 'mnemonic' field
      };

      final Map<String, dynamic> exportData = <String, dynamic>{
        'v2Wallets': jsonEncode(<Map<String, dynamic>>[malformedV2Data]),
      };

      // When - Export and encrypt
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;

      // Then - Decrypt should succeed but data is malformed
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );
      expect(decrypted['v2Wallets'], isNotNull);

      final List<dynamic> importedWallets =
          jsonDecode(decrypted['v2Wallets'] as String) as List<dynamic>;
      expect(importedWallets.length, equals(1));

      final Map<String, dynamic> importedWallet =
          importedWallets[0] as Map<String, dynamic>;
      expect(importedWallet['mnemonic'], isNull);
    });

    test('Validate mnemonic in exported V2 wallet', () async {
      // Given
      const String validMnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      expect(isValidMnemonic(validMnemonic), isTrue);

      final KeyPair kp = await deriveKeyPairCompat(validMnemonic);
      final String address = kp.address;
      final String pubKey = v1pubkeyFromAddress(address);

      final Map<String, dynamic> v2WalletData = <String, dynamic>{
        'pubKey': pubKey,
        'address': address,
        'name': 'Valid Mnemonic Wallet',
        'type': 'v2PasswordLess',
        'mnemonic': validMnemonic,
      };

      final Map<String, dynamic> exportData = <String, dynamic>{
        'v2Wallets': jsonEncode(<Map<String, dynamic>>[v2WalletData]),
      };

      // When
      final String exportJson = jsonEncode(exportData);
      final Map<String, String> encrypted = encryptJsonForExport(
        exportJson,
        testPattern,
      );
      final String keyEncrypted = encrypted['key']!;
      final Map<String, dynamic> decrypted = decryptJsonForImport(
        keyEncrypted,
        testPattern,
      );

      final List<dynamic> importedWallets =
          jsonDecode(decrypted['v2Wallets'] as String) as List<dynamic>;
      final Map<String, dynamic> importedWallet =
          importedWallets[0] as Map<String, dynamic>;
      final String importedMnemonic = importedWallet['mnemonic'] as String;

      // Then
      expect(isValidMnemonic(importedMnemonic), isTrue);
      expect(importedMnemonic, equals(validMnemonic));
    });
  });
}
