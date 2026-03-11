/// Cesium-compatible wallet implementation for V1 blockchain authentication
///
/// Based on the DURT (Duniter Rust Tools) library implementation:
/// https://git.duniter.org/libs/durt
///
/// This class implements the Cesium wallet format, which derives cryptographic
/// keys from a salt (username) and password using Scrypt key derivation followed
/// by Ed25519 signing key generation. It's used for:
/// - V1 blockchain authentication (password-protected accounts)
/// - Wallet import/export functionality
/// - Cesium Plus profile operations for V1 accounts
///
/// Original implementation authors: Duniter community
///
/// DURT License (GPL-3.0-or-later):
/// Copyright 2021 poka <poka@p2p.legal>
///
/// Durt is free software: you can redistribute it and/or modify
/// it under the terms of the GNU General Public License as published by
/// the Free Software Foundation, either version 3 of the License, or
/// (at your option) any later version.
///
/// Durt is distributed in the hope that it will be useful,
/// but WITHOUT ANY WARRANTY; without even the implied warranty of
/// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
/// GNU General Public License for more details.
///
/// You should have received a copy of the GNU General Public License
/// along with this program. If not, see <http://www.gnu.org/licenses/>.
///
/// Extracted to Ginkgo: March 2026
/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';

import 'package:bip32_ed25519/api.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:pointycastle/pointycastle.dart' as pc;

/// Represents a Cesium wallet with Ed25519 keys derived from salt and password
///
/// The wallet generation process:
/// 1. Encode salt and password as UTF-8 (preserving Unicode characters like em-dash)
/// 2. Use Scrypt with parameters (N=4096, r=16, p=1, dkLen=32) to derive seed
/// 3. Create Ed25519 SigningKey from seed
/// 4. Generate public key and encode as Base58
///
/// Example:
/// ```dart
/// final wallet = CesiumWallet('myusername', 'mypassword');
/// print(wallet.pubkey); // Base58-encoded public key
/// final signature = wallet.sign('document to sign');
/// ```
class CesiumWallet {
  /// Main factory constructor which generates seed and rootKey for the given Cesium salt and password
  ///
  /// Uses Scrypt key derivation to convert salt and password into a 32-byte seed,
  /// then creates an Ed25519 signing key from it.
  ///
  /// Parameters:
  /// - [salt]: Username or arbitrary salt string
  /// - [password]: Password string
  ///
  /// Note: Unicode characters (like em-dash —) are preserved and affect the derivation
  factory CesiumWallet(String salt, String password) {
    final pc.KeyDerivator scrypt = pc.KeyDerivator('scrypt');
    scrypt.init(
      pc.ScryptParameters(
        4096,
        16,
        1,
        32,
        Uint8List.fromList(utf8.encode(salt)),
      ),
    );
    final Uint8List seed =
        scrypt.process(Uint8List.fromList(utf8.encode(password)));
    return CesiumWallet.fromSeed(seed);
  }

  /// Root private constructor used by CesiumWallet factories.
  CesiumWallet._(
      {required this.seed, required this.rootKey, required this.pubkey});

  /// Generate wallet from an existing seed (32 bytes)
  ///
  /// Useful for:
  /// - Recovering a wallet from a known seed
  /// - Importing from seed-based formats
  /// - Testing and key derivation verification
  factory CesiumWallet.fromSeed(Uint8List seed) {
    final SigningKey rootKey = SigningKey(seed: seed);
    final String pubkey = Base58Encode(rootKey.publicKey);
    return CesiumWallet._(seed: seed, rootKey: rootKey, pubkey: pubkey);
  }

  /// The seed derived from salt and password (32 bytes)
  final Uint8List seed;

  /// The Ed25519 signing key derived from seed
  final SigningKey rootKey;

  /// The Base58-encoded public key (44 characters for G1 blockchain)
  final String pubkey;

  /// Generate a valid signature from the wallet's keypair for any message or text document
  ///
  /// The signature is Base64-encoded for transmission and storage.
  ///
  /// Example:
  /// ```dart
  /// final signature = wallet.sign('Important document');
  /// ```
  String sign(String document) {
    return base64Encode(
        rootKey.sign(document.codeUnits.toUint8List()).signature.asTypedList);
  }

  /// Verify if the given signature is valid for the given message or text document
  ///
  /// Parameters:
  /// - [document]: The original signed document
  /// - [signature]: Base64-encoded signature to verify
  ///
  /// Returns: true if signature is valid, false otherwise
  bool verifySign(String document, String signature) {
    try {
      final SignatureBase formattedSignature =
          Signature(base64Decode(signature));
      rootKey.verifyKey.verify(
          signature: formattedSignature,
          message: document.codeUnits.toUint8List());
      return true;
    } catch (e) {
      // pinenacl throws an exception when signature verification fails
      return false;
    }
  }
}
