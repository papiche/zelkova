// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/primitive_types/h256.dart' as _i3;
import '../types/sp_staking/offence/offence_details.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.H256, _i4.OffenceDetails> _reports =
      const _i2.StorageMap<_i3.H256, _i4.OffenceDetails>(
    prefix: 'Offences',
    storage: 'Reports',
    valueCodec: _i4.OffenceDetails.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i3.H256Codec()),
  );

  final _i2.StorageDoubleMap<List<int>, List<int>, List<_i3.H256>>
      _concurrentReportsIndex =
      const _i2.StorageDoubleMap<List<int>, List<int>, List<_i3.H256>>(
    prefix: 'Offences',
    storage: 'ConcurrentReportsIndex',
    valueCodec: _i5.SequenceCodec<_i3.H256>(_i3.H256Codec()),
    hasher1: _i2.StorageHasher.twoxx64Concat(_i5.U8ArrayCodec(16)),
    hasher2: _i2.StorageHasher.twoxx64Concat(_i5.U8SequenceCodec.codec),
  );

  /// The primary structure that holds all offence records keyed by report identifiers.
  _i6.Future<_i4.OffenceDetails?> reports(
    _i3.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reports.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reports.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A vector of reports of the same kind that happened at the same time slot.
  _i6.Future<List<_i3.H256>> concurrentReportsIndex(
    List<int> key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _concurrentReportsIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _concurrentReportsIndex.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The primary structure that holds all offence records keyed by report identifiers.
  _i6.Future<List<_i4.OffenceDetails?>> multiReports(
    List<_i3.H256> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _reports.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _reports.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `reports`.
  _i7.Uint8List reportsKey(_i3.H256 key1) {
    final hashedKey = _reports.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `concurrentReportsIndex`.
  _i7.Uint8List concurrentReportsIndexKey(
    List<int> key1,
    List<int> key2,
  ) {
    final hashedKey = _concurrentReportsIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reports`.
  _i7.Uint8List reportsMapPrefix() {
    final hashedKey = _reports.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `concurrentReportsIndex`.
  _i7.Uint8List concurrentReportsIndexMapPrefix(List<int> key1) {
    final hashedKey = _concurrentReportsIndex.mapPrefix(key1);
    return hashedKey;
  }
}
