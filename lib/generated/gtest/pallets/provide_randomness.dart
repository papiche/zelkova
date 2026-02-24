// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i3;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i7;
import '../types/pallet_provide_randomness/pallet/call.dart' as _i10;
import '../types/pallet_provide_randomness/types/randomness_type.dart' as _i8;
import '../types/pallet_provide_randomness/types/request.dart' as _i4;
import '../types/primitive_types/h256.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<int> _nexEpochHookIn = const _i2.StorageValue<int>(
    prefix: 'ProvideRandomness',
    storage: 'NexEpochHookIn',
    valueCodec: _i3.U8Codec.codec,
  );

  final _i2.StorageValue<BigInt> _requestIdProvider =
      const _i2.StorageValue<BigInt>(
    prefix: 'ProvideRandomness',
    storage: 'RequestIdProvider',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i2.StorageValue<List<_i4.Request>> _requestsReadyAtNextBlock =
      const _i2.StorageValue<List<_i4.Request>>(
    prefix: 'ProvideRandomness',
    storage: 'RequestsReadyAtNextBlock',
    valueCodec: _i3.SequenceCodec<_i4.Request>(_i4.Request.codec),
  );

  final _i2.StorageMap<BigInt, List<_i4.Request>> _requestsReadyAtEpoch =
      const _i2.StorageMap<BigInt, List<_i4.Request>>(
    prefix: 'ProvideRandomness',
    storage: 'RequestsReadyAtEpoch',
    valueCodec: _i3.SequenceCodec<_i4.Request>(_i4.Request.codec),
    hasher: _i2.StorageHasher.twoxx64Concat(_i3.U64Codec.codec),
  );

  final _i2.StorageMap<BigInt, dynamic> _requestsIds =
      const _i2.StorageMap<BigInt, dynamic>(
    prefix: 'ProvideRandomness',
    storage: 'RequestsIds',
    valueCodec: _i3.NullCodec.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i3.U64Codec.codec),
  );

  final _i2.StorageValue<int> _counterForRequestsIds =
      const _i2.StorageValue<int>(
    prefix: 'ProvideRandomness',
    storage: 'CounterForRequestsIds',
    valueCodec: _i3.U32Codec.codec,
  );

  /// The number of blocks before the next epoch.
  _i5.Future<int> nexEpochHookIn({_i1.BlockHash? at}) async {
    final hashedKey = _nexEpochHookIn.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nexEpochHookIn.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The request ID.
  _i5.Future<BigInt> requestIdProvider({_i1.BlockHash? at}) async {
    final hashedKey = _requestIdProvider.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestIdProvider.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The requests that will be fulfilled at the next block.
  _i5.Future<List<_i4.Request>> requestsReadyAtNextBlock(
      {_i1.BlockHash? at}) async {
    final hashedKey = _requestsReadyAtNextBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestsReadyAtNextBlock.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The requests that will be fulfilled at the next epoch.
  _i5.Future<List<_i4.Request>> requestsReadyAtEpoch(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _requestsReadyAtEpoch.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestsReadyAtEpoch.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The requests being processed.
  _i5.Future<dynamic> requestsIds(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _requestsIds.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestsIds.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i5.Future<int> counterForRequestsIds({_i1.BlockHash? at}) async {
    final hashedKey = _counterForRequestsIds.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForRequestsIds.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The requests that will be fulfilled at the next epoch.
  _i5.Future<List<List<_i4.Request>>> multiRequestsReadyAtEpoch(
    List<BigInt> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _requestsReadyAtEpoch.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _requestsReadyAtEpoch.decodeValue(v.key))
          .toList();
    }
    return (keys.map((key) => []).toList()
        as List<List<_i4.Request>>); /* Default */
  }

  /// The requests being processed.
  _i5.Future<List<dynamic>> multiRequestsIds(
    List<BigInt> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _requestsIds.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _requestsIds.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `nexEpochHookIn`.
  _i6.Uint8List nexEpochHookInKey() {
    final hashedKey = _nexEpochHookIn.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `requestIdProvider`.
  _i6.Uint8List requestIdProviderKey() {
    final hashedKey = _requestIdProvider.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `requestsReadyAtNextBlock`.
  _i6.Uint8List requestsReadyAtNextBlockKey() {
    final hashedKey = _requestsReadyAtNextBlock.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `requestsReadyAtEpoch`.
  _i6.Uint8List requestsReadyAtEpochKey(BigInt key1) {
    final hashedKey = _requestsReadyAtEpoch.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `requestsIds`.
  _i6.Uint8List requestsIdsKey(BigInt key1) {
    final hashedKey = _requestsIds.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForRequestsIds`.
  _i6.Uint8List counterForRequestsIdsKey() {
    final hashedKey = _counterForRequestsIds.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `requestsReadyAtEpoch`.
  _i6.Uint8List requestsReadyAtEpochMapPrefix() {
    final hashedKey = _requestsReadyAtEpoch.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `requestsIds`.
  _i6.Uint8List requestsIdsMapPrefix() {
    final hashedKey = _requestsIds.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Request randomness.
  _i7.ProvideRandomness request({
    required _i8.RandomnessType randomnessType,
    required _i9.H256 salt,
  }) {
    return _i7.ProvideRandomness(_i10.Request(
      randomnessType: randomnessType,
      salt: salt,
    ));
  }
}

class Constants {
  Constants();

  /// Maximum number of not yet filled requests.
  final int maxRequests = 100;

  /// The price of a request.
  final BigInt requestPrice = BigInt.from(2000);
}
