// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i6;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i9;
import '../types/pallet_distance/pallet/call.dart' as _i10;
import '../types/pallet_distance/types/evaluation_pool.dart' as _i3;
import '../types/primitive_types/h256.dart' as _i4;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i12;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/sp_distance/computation_result.dart' as _i11;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<_i3.EvaluationPool> _evaluationPool0 =
      const _i2.StorageValue<_i3.EvaluationPool>(
    prefix: 'Distance',
    storage: 'EvaluationPool0',
    valueCodec: _i3.EvaluationPool.codec,
  );

  final _i2.StorageValue<_i3.EvaluationPool> _evaluationPool1 =
      const _i2.StorageValue<_i3.EvaluationPool>(
    prefix: 'Distance',
    storage: 'EvaluationPool1',
    valueCodec: _i3.EvaluationPool.codec,
  );

  final _i2.StorageValue<_i3.EvaluationPool> _evaluationPool2 =
      const _i2.StorageValue<_i3.EvaluationPool>(
    prefix: 'Distance',
    storage: 'EvaluationPool2',
    valueCodec: _i3.EvaluationPool.codec,
  );

  final _i2.StorageValue<_i4.H256> _evaluationBlock =
      const _i2.StorageValue<_i4.H256>(
    prefix: 'Distance',
    storage: 'EvaluationBlock',
    valueCodec: _i4.H256Codec(),
  );

  final _i2.StorageMap<int, _i5.AccountId32> _pendingEvaluationRequest =
      const _i2.StorageMap<int, _i5.AccountId32>(
    prefix: 'Distance',
    storage: 'PendingEvaluationRequest',
    valueCodec: _i5.AccountId32Codec(),
    hasher: _i2.StorageHasher.twoxx64Concat(_i6.U32Codec.codec),
  );

  final _i2.StorageValue<bool> _didUpdate = const _i2.StorageValue<bool>(
    prefix: 'Distance',
    storage: 'DidUpdate',
    valueCodec: _i6.BoolCodec.codec,
  );

  final _i2.StorageValue<int> _currentPeriodIndex = const _i2.StorageValue<int>(
    prefix: 'Distance',
    storage: 'CurrentPeriodIndex',
    valueCodec: _i6.U32Codec.codec,
  );

  /// The first evaluation pool for distance evaluation queuing identities to evaluate for a given
  /// evaluator account.
  _i7.Future<_i3.EvaluationPool> evaluationPool0({_i1.BlockHash? at}) async {
    final hashedKey = _evaluationPool0.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _evaluationPool0.decodeValue(bytes);
    }
    return _i3.EvaluationPool(
      evaluations: [],
      evaluators: [],
    ); /* Default */
  }

  /// The second evaluation pool for distance evaluation queuing identities to evaluate for a given
  /// evaluator account.
  _i7.Future<_i3.EvaluationPool> evaluationPool1({_i1.BlockHash? at}) async {
    final hashedKey = _evaluationPool1.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _evaluationPool1.decodeValue(bytes);
    }
    return _i3.EvaluationPool(
      evaluations: [],
      evaluators: [],
    ); /* Default */
  }

  /// The third evaluation pool for distance evaluation queuing identities to evaluate for a given
  /// evaluator account.
  _i7.Future<_i3.EvaluationPool> evaluationPool2({_i1.BlockHash? at}) async {
    final hashedKey = _evaluationPool2.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _evaluationPool2.decodeValue(bytes);
    }
    return _i3.EvaluationPool(
      evaluations: [],
      evaluators: [],
    ); /* Default */
  }

  /// The block at which the distance is evaluated.
  _i7.Future<_i4.H256> evaluationBlock({_i1.BlockHash? at}) async {
    final hashedKey = _evaluationBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _evaluationBlock.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// The pending evaluation requesters.
  _i7.Future<_i5.AccountId32?> pendingEvaluationRequest(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pendingEvaluationRequest.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingEvaluationRequest.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Store if the evaluation was updated in this block.
  _i7.Future<bool> didUpdate({_i1.BlockHash? at}) async {
    final hashedKey = _didUpdate.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _didUpdate.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// The current evaluation period index.
  _i7.Future<int> currentPeriodIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentPeriodIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentPeriodIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The pending evaluation requesters.
  _i7.Future<List<_i5.AccountId32?>> multiPendingEvaluationRequest(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _pendingEvaluationRequest.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _pendingEvaluationRequest.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `evaluationPool0`.
  _i8.Uint8List evaluationPool0Key() {
    final hashedKey = _evaluationPool0.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `evaluationPool1`.
  _i8.Uint8List evaluationPool1Key() {
    final hashedKey = _evaluationPool1.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `evaluationPool2`.
  _i8.Uint8List evaluationPool2Key() {
    final hashedKey = _evaluationPool2.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `evaluationBlock`.
  _i8.Uint8List evaluationBlockKey() {
    final hashedKey = _evaluationBlock.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pendingEvaluationRequest`.
  _i8.Uint8List pendingEvaluationRequestKey(int key1) {
    final hashedKey = _pendingEvaluationRequest.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `didUpdate`.
  _i8.Uint8List didUpdateKey() {
    final hashedKey = _didUpdate.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentPeriodIndex`.
  _i8.Uint8List currentPeriodIndexKey() {
    final hashedKey = _currentPeriodIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pendingEvaluationRequest`.
  _i8.Uint8List pendingEvaluationRequestMapPrefix() {
    final hashedKey = _pendingEvaluationRequest.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Request evaluation of the caller's identity distance.
  ///
  /// This function allows the caller to request an evaluation of their distance.
  /// A positive evaluation will lead to claiming or renewing membership, while a negative
  /// evaluation will result in slashing for the caller.
  _i9.Distance requestDistanceEvaluation() {
    return _i9.Distance(_i10.RequestDistanceEvaluation());
  }

  /// Request evaluation of a target identity's distance.
  ///
  /// This function allows the caller to request an evaluation of a specific target identity's distance.
  /// This action is only permitted for unvalidated identities.
  _i9.Distance requestDistanceEvaluationFor({required int target}) {
    return _i9.Distance(_i10.RequestDistanceEvaluationFor(target: target));
  }

  /// Push an evaluation result to the pool.
  ///
  /// This inherent function is called internally by validators to push an evaluation result
  /// to the evaluation pool.
  _i9.Distance updateEvaluation(
      {required _i11.ComputationResult computationResult}) {
    return _i9.Distance(
        _i10.UpdateEvaluation(computationResult: computationResult));
  }

  /// Force push an evaluation result to the pool.
  ///
  /// It is primarily used for testing purposes.
  ///
  /// - `origin`: Must be `Root`.
  _i9.Distance forceUpdateEvaluation({
    required _i5.AccountId32 evaluator,
    required _i11.ComputationResult computationResult,
  }) {
    return _i9.Distance(_i10.ForceUpdateEvaluation(
      evaluator: evaluator,
      computationResult: computationResult,
    ));
  }

  /// Force set the distance evaluation status of an identity.
  ///
  /// It is primarily used for testing purposes.
  ///
  /// - `origin`: Must be `Root`.
  _i9.Distance forceValidDistanceStatus({required int identity}) {
    return _i9.Distance(_i10.ForceValidDistanceStatus(identity: identity));
  }
}

class Constants {
  Constants();

  /// The amount reserved during evaluation.
  final BigInt evaluationPrice = BigInt.from(1000);

  /// The evaluation period in blocks.
  /// Since the evaluation uses 3 pools, the total evaluation time will be 3 * EvaluationPeriod.
  final int evaluationPeriod = 40;

  /// The maximum distance used to define a referee's accessibility.
  /// This value is not used by the runtime but is needed by the client distance oracle.
  final int maxRefereeDistance = 5;

  /// The minimum ratio of accessible referees required.
  final _i12.Perbill minAccessibleReferees = 800000000;
}
