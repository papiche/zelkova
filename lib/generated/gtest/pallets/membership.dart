// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/sp_membership/membership_data.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<int, _i3.MembershipData> _membership =
      const _i2.StorageMap<int, _i3.MembershipData>(
    prefix: 'Membership',
    storage: 'Membership',
    valueCodec: _i3.MembershipData.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  final _i2.StorageValue<int> _counterForMembership =
      const _i2.StorageValue<int>(
    prefix: 'Membership',
    storage: 'CounterForMembership',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i2.StorageMap<int, List<int>> _membershipsExpireOn =
      const _i2.StorageMap<int, List<int>>(
    prefix: 'Membership',
    storage: 'MembershipsExpireOn',
    valueCodec: _i4.U32SequenceCodec.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  /// The membership data for each identity.
  _i5.Future<_i3.MembershipData?> membership(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _membership.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _membership.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i5.Future<int> counterForMembership({_i1.BlockHash? at}) async {
    final hashedKey = _counterForMembership.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForMembership.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The identities of memberships to expire at a given block.
  _i5.Future<List<int>> membershipsExpireOn(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _membershipsExpireOn.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _membershipsExpireOn.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The membership data for each identity.
  _i5.Future<List<_i3.MembershipData?>> multiMembership(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _membership.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _membership.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// The identities of memberships to expire at a given block.
  _i5.Future<List<List<int>>> multiMembershipsExpireOn(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _membershipsExpireOn.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _membershipsExpireOn.decodeValue(v.key))
          .toList();
    }
    return keys
        .map((key) => List<int>.filled(
              0,
              0,
              growable: true,
            ))
        .toList(); /* Default */
  }

  /// Returns the storage key for `membership`.
  _i6.Uint8List membershipKey(int key1) {
    final hashedKey = _membership.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForMembership`.
  _i6.Uint8List counterForMembershipKey() {
    final hashedKey = _counterForMembership.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `membershipsExpireOn`.
  _i6.Uint8List membershipsExpireOnKey(int key1) {
    final hashedKey = _membershipsExpireOn.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `membership`.
  _i6.Uint8List membershipMapPrefix() {
    final hashedKey = _membership.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `membershipsExpireOn`.
  _i6.Uint8List membershipsExpireOnMapPrefix() {
    final hashedKey = _membershipsExpireOn.mapPrefix();
    return hashedKey;
  }
}

class Constants {
  Constants();

  /// Maximum lifespan of a single membership (in number of blocks).
  final int membershipPeriod = 5259600;

  /// Minimum delay to wait before renewing membership, i.e., asking for distance evaluation.
  final int membershipRenewalPeriod = 806400;
}
