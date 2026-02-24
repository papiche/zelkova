// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/pallet_quota/pallet/quota.dart' as _i3;
import '../types/pallet_quota/pallet/refund.dart' as _i5;
import '../types/sp_core/crypto/account_id32.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<int, _i3.Quota> _idtyQuota =
      const _i2.StorageMap<int, _i3.Quota>(
    prefix: 'Quota',
    storage: 'IdtyQuota',
    valueCodec: _i3.Quota.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  final _i2.StorageValue<List<_i5.Refund>> _refundQueue =
      const _i2.StorageValue<List<_i5.Refund>>(
    prefix: 'Quota',
    storage: 'RefundQueue',
    valueCodec: _i4.SequenceCodec<_i5.Refund>(_i5.Refund.codec),
  );

  /// The quota for each identity.
  _i6.Future<_i3.Quota?> idtyQuota(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _idtyQuota.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _idtyQuota.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The fees waiting to be refunded.
  _i6.Future<List<_i5.Refund>> refundQueue({_i1.BlockHash? at}) async {
    final hashedKey = _refundQueue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _refundQueue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The quota for each identity.
  _i6.Future<List<_i3.Quota?>> multiIdtyQuota(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _idtyQuota.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _idtyQuota.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `idtyQuota`.
  _i7.Uint8List idtyQuotaKey(int key1) {
    final hashedKey = _idtyQuota.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `refundQueue`.
  _i7.Uint8List refundQueueKey() {
    final hashedKey = _refundQueue.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `idtyQuota`.
  _i7.Uint8List idtyQuotaMapPrefix() {
    final hashedKey = _idtyQuota.mapPrefix();
    return hashedKey;
  }
}

class Constants {
  Constants();

  /// Account used to refund fees.
  final _i8.AccountId32 refundAccount = const <int>[
    109,
    111,
    100,
    108,
    112,
    121,
    47,
    116,
    114,
    115,
    114,
    121,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
}
