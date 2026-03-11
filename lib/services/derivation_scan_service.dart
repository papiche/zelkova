import 'dart:isolate';

import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../g1/duniter_endpoint_helper.dart';
import '../g1/g1_v2_helper.dart';
import '../ui/logger.dart';

class _KeypairGenerationArgs {
  const _KeypairGenerationArgs({
    required this.mnemonic,
    required this.derivations,
    required this.ss58Prefix,
    required this.keyPairType,
  });

  final String mnemonic;
  final List<int> derivations;
  final int ss58Prefix;
  final KeyPairType keyPairType;
}

class KeypairResult {
  const KeypairResult({
    required this.address,
    required this.pubKey,
    required this.derivation,
  });

  final String address;
  final String pubKey;
  final int derivation;
}

Future<List<KeypairResult>> _generateKeypairsInIsolate(
    _KeypairGenerationArgs args) async {
  final Keyring keyring = Keyring();
  final List<KeypairResult> results = <KeypairResult>[];

  // Try parsing english mnemonic in case original fails
  final String englishMnemonic = toEnglishMnemonic(args.mnemonic);

  for (final int derivation in args.derivations) {
    String uri = '${args.mnemonic}//$derivation';
    KeyPair kp;
    try {
      kp = await keyring.fromUri(uri, keyPairType: args.keyPairType);
    } catch (_) {
      uri = '$englishMnemonic//$derivation';
      kp = await keyring.fromUri(uri, keyPairType: args.keyPairType);
    }
    kp.ss58Format = args.ss58Prefix;
    final String address = kp.address;
    final String pubKey = v1pubkeyFromAddress(address);
    results.add(KeypairResult(
      address: address,
      pubKey: pubKey,
      derivation: derivation,
    ));
  }

  return results;
}

class DerivationScanService {
  /// Static flag to skip network checks during testing
  static bool skipNetworkCheck = false;

  /// Scans derivation paths 0 to [maxDerivations] - 1.
  /// Returns a map of index -> KeypairResult containing only those with balance > 0.
  ///
  /// If [skipNetworkCheck] is true, this method will skip balance verification
  /// and return an empty map immediately (useful for testing).
  Future<Map<int, KeypairResult>> scanDerivations(
    String mnemonic, {
    int maxDerivations = 30,
    int ss58Prefix = 4450,
  }) async {
    // In testing or offline mode, skip network calls
    if (skipNetworkCheck) {
      return <int, KeypairResult>{};
    }

    try {
      final List<int> derivationNumbers =
          List<int>.generate(maxDerivations, (int i) => i);

      final _KeypairGenerationArgs args = _KeypairGenerationArgs(
        mnemonic: mnemonic,
        derivations: derivationNumbers,
        ss58Prefix: ss58Prefix,
        keyPairType: KeyPairType.ed25519,
      );

      final List<KeypairResult> keypairResults =
          await Isolate.run(() => _generateKeypairsInIsolate(args));

      final Map<int, KeypairResult> validDerivations = <int, KeypairResult>{};

      for (final KeypairResult result in keypairResults) {
        final double balance = await calculateBalanceFromEndPoint(
          address: result.address,
        );
        if (balance > 0) {
          validDerivations[result.derivation] = result;
        }
      }

      return validDerivations;
    } catch (e) {
      logger('Error scanning derivations: $e');
      return <int, KeypairResult>{};
    }
  }
}
