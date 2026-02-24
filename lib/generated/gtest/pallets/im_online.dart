// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i3;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i8;
import '../types/pallet_im_online/heartbeat.dart' as _i9;
import '../types/pallet_im_online/pallet/call.dart' as _i11;
import '../types/pallet_im_online/sr25519/app_sr25519/public.dart' as _i4;
import '../types/pallet_im_online/sr25519/app_sr25519/signature.dart' as _i10;
import '../types/sp_core/crypto/account_id32.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<int> _heartbeatAfter = const _i2.StorageValue<int>(
    prefix: 'ImOnline',
    storage: 'HeartbeatAfter',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i2.StorageValue<List<_i4.Public>> _keys =
      const _i2.StorageValue<List<_i4.Public>>(
    prefix: 'ImOnline',
    storage: 'Keys',
    valueCodec: _i3.SequenceCodec<_i4.Public>(_i4.PublicCodec()),
  );

  final _i2.StorageDoubleMap<int, int, bool> _receivedHeartbeats =
      const _i2.StorageDoubleMap<int, int, bool>(
    prefix: 'ImOnline',
    storage: 'ReceivedHeartbeats',
    valueCodec: _i3.BoolCodec.codec,
    hasher1: _i2.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
    hasher2: _i2.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  final _i2.StorageDoubleMap<int, _i5.AccountId32, int> _authoredBlocks =
      const _i2.StorageDoubleMap<int, _i5.AccountId32, int>(
    prefix: 'ImOnline',
    storage: 'AuthoredBlocks',
    valueCodec: _i3.U32Codec.codec,
    hasher1: _i2.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
    hasher2: _i2.StorageHasher.twoxx64Concat(_i5.AccountId32Codec()),
  );

  /// The block number after which it's ok to send heartbeats in the current
  /// session.
  ///
  /// At the beginning of each session we set this to a value that should fall
  /// roughly in the middle of the session duration. The idea is to first wait for
  /// the validators to produce a block in the current session, so that the
  /// heartbeat later on will not be necessary.
  ///
  /// This value will only be used as a fallback if we fail to get a proper session
  /// progress estimate from `NextSessionRotation`, as those estimates should be
  /// more accurate then the value we calculate for `HeartbeatAfter`.
  _i6.Future<int> heartbeatAfter({_i1.BlockHash? at}) async {
    final hashedKey = _heartbeatAfter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _heartbeatAfter.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The current set of keys that may issue a heartbeat.
  _i6.Future<List<_i4.Public>> keys({_i1.BlockHash? at}) async {
    final hashedKey = _keys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _keys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// For each session index, we keep a mapping of `SessionIndex` and `AuthIndex`.
  _i6.Future<bool?> receivedHeartbeats(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _receivedHeartbeats.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _receivedHeartbeats.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// For each session index, we keep a mapping of `ValidatorId<T>` to the
  /// number of blocks authored by the given authority.
  _i6.Future<int> authoredBlocks(
    int key1,
    _i5.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _authoredBlocks.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authoredBlocks.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Returns the storage key for `heartbeatAfter`.
  _i7.Uint8List heartbeatAfterKey() {
    final hashedKey = _heartbeatAfter.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `keys`.
  _i7.Uint8List keysKey() {
    final hashedKey = _keys.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `receivedHeartbeats`.
  _i7.Uint8List receivedHeartbeatsKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _receivedHeartbeats.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `authoredBlocks`.
  _i7.Uint8List authoredBlocksKey(
    int key1,
    _i5.AccountId32 key2,
  ) {
    final hashedKey = _authoredBlocks.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `receivedHeartbeats`.
  _i7.Uint8List receivedHeartbeatsMapPrefix(int key1) {
    final hashedKey = _receivedHeartbeats.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `authoredBlocks`.
  _i7.Uint8List authoredBlocksMapPrefix(int key1) {
    final hashedKey = _authoredBlocks.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// ## Complexity:
  /// - `O(K)` where K is length of `Keys` (heartbeat.validators_len)
  ///  - `O(K)`: decoding of length `K`
  _i8.ImOnline heartbeat({
    required _i9.Heartbeat heartbeat,
    required _i10.Signature signature,
  }) {
    return _i8.ImOnline(_i11.Heartbeat(
      heartbeat: heartbeat,
      signature: signature,
    ));
  }
}

class Constants {
  Constants();

  /// A configuration for base priority of unsigned transactions.
  ///
  /// This is exposed so that it can be tuned for particular runtime, when
  /// multiple pallets send unsigned transactions.
  final BigInt unsignedPriority = BigInt.parse(
    '18446744073709551615',
    radix: 10,
  );
}
