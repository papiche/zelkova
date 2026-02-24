// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/primitive_types/h256.dart' as _i4;
import '../types/tuples.dart' as _i3;
import '../types/tuples_1.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<int, _i3.Tuple2<_i4.H256, int>> _historicalSessions =
      const _i2.StorageMap<int, _i3.Tuple2<_i4.H256, int>>(
    prefix: 'Historical',
    storage: 'HistoricalSessions',
    valueCodec: _i3.Tuple2Codec<_i4.H256, int>(
      _i4.H256Codec(),
      _i5.U32Codec.codec,
    ),
    hasher: _i2.StorageHasher.twoxx64Concat(_i5.U32Codec.codec),
  );

  final _i2.StorageValue<_i6.Tuple2<int, int>> _storedRange =
      const _i2.StorageValue<_i6.Tuple2<int, int>>(
    prefix: 'Historical',
    storage: 'StoredRange',
    valueCodec: _i6.Tuple2Codec<int, int>(
      _i5.U32Codec.codec,
      _i5.U32Codec.codec,
    ),
  );

  /// Mapping from historical session indices to session-data root hash and validator count.
  _i7.Future<_i3.Tuple2<_i4.H256, int>?> historicalSessions(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _historicalSessions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _historicalSessions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The range of historical sessions we store. [first, last)
  _i7.Future<_i6.Tuple2<int, int>?> storedRange({_i1.BlockHash? at}) async {
    final hashedKey = _storedRange.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _storedRange.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Mapping from historical session indices to session-data root hash and validator count.
  _i7.Future<List<_i3.Tuple2<_i4.H256, int>?>> multiHistoricalSessions(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _historicalSessions.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _historicalSessions.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `historicalSessions`.
  _i8.Uint8List historicalSessionsKey(int key1) {
    final hashedKey = _historicalSessions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `storedRange`.
  _i8.Uint8List storedRangeKey() {
    final hashedKey = _storedRange.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `historicalSessions`.
  _i8.Uint8List historicalSessionsMapPrefix() {
    final hashedKey = _historicalSessions.mapPrefix();
    return hashedKey;
  }
}
