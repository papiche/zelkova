// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i7;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i10;
import '../types/pallet_preimage/old_request_status.dart' as _i4;
import '../types/pallet_preimage/pallet/call.dart' as _i11;
import '../types/pallet_preimage/request_status.dart' as _i5;
import '../types/primitive_types/h256.dart' as _i3;
import '../types/tuples.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.H256, _i4.OldRequestStatus> _statusFor =
      const _i2.StorageMap<_i3.H256, _i4.OldRequestStatus>(
    prefix: 'Preimage',
    storage: 'StatusFor',
    valueCodec: _i4.OldRequestStatus.codec,
    hasher: _i2.StorageHasher.identity(_i3.H256Codec()),
  );

  final _i2.StorageMap<_i3.H256, _i5.RequestStatus> _requestStatusFor =
      const _i2.StorageMap<_i3.H256, _i5.RequestStatus>(
    prefix: 'Preimage',
    storage: 'RequestStatusFor',
    valueCodec: _i5.RequestStatus.codec,
    hasher: _i2.StorageHasher.identity(_i3.H256Codec()),
  );

  final _i2.StorageMap<_i6.Tuple2<_i3.H256, int>, List<int>> _preimageFor =
      const _i2.StorageMap<_i6.Tuple2<_i3.H256, int>, List<int>>(
    prefix: 'Preimage',
    storage: 'PreimageFor',
    valueCodec: _i7.U8SequenceCodec.codec,
    hasher: _i2.StorageHasher.identity(_i6.Tuple2Codec<_i3.H256, int>(
      _i3.H256Codec(),
      _i7.U32Codec.codec,
    )),
  );

  /// The request status of a given hash.
  _i8.Future<_i4.OldRequestStatus?> statusFor(
    _i3.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _statusFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _statusFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The request status of a given hash.
  _i8.Future<_i5.RequestStatus?> requestStatusFor(
    _i3.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _requestStatusFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestStatusFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i8.Future<List<int>?> preimageFor(
    _i6.Tuple2<_i3.H256, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _preimageFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _preimageFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The request status of a given hash.
  _i8.Future<List<_i4.OldRequestStatus?>> multiStatusFor(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _statusFor.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _statusFor.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// The request status of a given hash.
  _i8.Future<List<_i5.RequestStatus?>> multiRequestStatusFor(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _requestStatusFor.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _requestStatusFor.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  _i8.Future<List<List<int>?>> multiPreimageFor(
    List<_i6.Tuple2<_i3.H256, int>> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _preimageFor.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _preimageFor.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `statusFor`.
  _i9.Uint8List statusForKey(_i3.H256 key1) {
    final hashedKey = _statusFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `requestStatusFor`.
  _i9.Uint8List requestStatusForKey(_i3.H256 key1) {
    final hashedKey = _requestStatusFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `preimageFor`.
  _i9.Uint8List preimageForKey(_i6.Tuple2<_i3.H256, int> key1) {
    final hashedKey = _preimageFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `statusFor`.
  _i9.Uint8List statusForMapPrefix() {
    final hashedKey = _statusFor.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `requestStatusFor`.
  _i9.Uint8List requestStatusForMapPrefix() {
    final hashedKey = _requestStatusFor.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `preimageFor`.
  _i9.Uint8List preimageForMapPrefix() {
    final hashedKey = _preimageFor.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Register a preimage on-chain.
  ///
  /// If the preimage was previously requested, no fees or deposits are taken for providing
  /// the preimage. Otherwise, a deposit is taken proportional to the size of the preimage.
  _i10.Preimage notePreimage({required List<int> bytes}) {
    return _i10.Preimage(_i11.NotePreimage(bytes: bytes));
  }

  /// Clear an unrequested preimage from the runtime storage.
  ///
  /// If `len` is provided, then it will be a much cheaper operation.
  ///
  /// - `hash`: The hash of the preimage to be removed from the store.
  /// - `len`: The length of the preimage of `hash`.
  _i10.Preimage unnotePreimage({required _i3.H256 hash}) {
    return _i10.Preimage(_i11.UnnotePreimage(hash: hash));
  }

  /// Request a preimage be uploaded to the chain without paying any fees or deposits.
  ///
  /// If the preimage requests has already been provided on-chain, we unreserve any deposit
  /// a user may have paid, and take the control of the preimage out of their hands.
  _i10.Preimage requestPreimage({required _i3.H256 hash}) {
    return _i10.Preimage(_i11.RequestPreimage(hash: hash));
  }

  /// Clear a previously made request for a preimage.
  ///
  /// NOTE: THIS MUST NOT BE CALLED ON `hash` MORE TIMES THAN `request_preimage`.
  _i10.Preimage unrequestPreimage({required _i3.H256 hash}) {
    return _i10.Preimage(_i11.UnrequestPreimage(hash: hash));
  }

  /// Ensure that the bulk of pre-images is upgraded.
  ///
  /// The caller pays no fee if at least 90% of pre-images were successfully updated.
  _i10.Preimage ensureUpdated({required List<_i3.H256> hashes}) {
    return _i10.Preimage(_i11.EnsureUpdated(hashes: hashes));
  }
}
