// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i7;
import '../types/pallet_smith_members/pallet/call.dart' as _i8;
import '../types/pallet_smith_members/types/smith_meta.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<int, _i3.SmithMeta> _smiths =
      const _i2.StorageMap<int, _i3.SmithMeta>(
    prefix: 'SmithMembers',
    storage: 'Smiths',
    valueCodec: _i3.SmithMeta.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  final _i2.StorageMap<int, List<int>> _expiresOn =
      const _i2.StorageMap<int, List<int>>(
    prefix: 'SmithMembers',
    storage: 'ExpiresOn',
    valueCodec: _i4.U32SequenceCodec.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  final _i2.StorageValue<int> _currentSession = const _i2.StorageValue<int>(
    prefix: 'SmithMembers',
    storage: 'CurrentSession',
    valueCodec: _i4.U32Codec.codec,
  );

  /// The Smith metadata for each identity.
  _i5.Future<_i3.SmithMeta?> smiths(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _smiths.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _smiths.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The indexes of Smith to remove at a given session.
  _i5.Future<List<int>?> expiresOn(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _expiresOn.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _expiresOn.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The current session index.
  _i5.Future<int> currentSession({_i1.BlockHash? at}) async {
    final hashedKey = _currentSession.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentSession.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The Smith metadata for each identity.
  _i5.Future<List<_i3.SmithMeta?>> multiSmiths(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _smiths.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _smiths.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// The indexes of Smith to remove at a given session.
  _i5.Future<List<List<int>?>> multiExpiresOn(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _expiresOn.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _expiresOn.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `smiths`.
  _i6.Uint8List smithsKey(int key1) {
    final hashedKey = _smiths.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `expiresOn`.
  _i6.Uint8List expiresOnKey(int key1) {
    final hashedKey = _expiresOn.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `currentSession`.
  _i6.Uint8List currentSessionKey() {
    final hashedKey = _currentSession.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `smiths`.
  _i6.Uint8List smithsMapPrefix() {
    final hashedKey = _smiths.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `expiresOn`.
  _i6.Uint8List expiresOnMapPrefix() {
    final hashedKey = _expiresOn.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Invite a member of the Web of Trust to attempt becoming a Smith.
  _i7.SmithMembers inviteSmith({required int receiver}) {
    return _i7.SmithMembers(_i8.InviteSmith(receiver: receiver));
  }

  /// Accept an invitation to become a Smith (must have been invited first).
  _i7.SmithMembers acceptInvitation() {
    return _i7.SmithMembers(_i8.AcceptInvitation());
  }

  /// Certify an invited Smith, which can lead the certified to become a Smith.
  _i7.SmithMembers certifySmith({required int receiver}) {
    return _i7.SmithMembers(_i8.CertifySmith(receiver: receiver));
  }
}

class Constants {
  Constants();

  /// Maximum number of active certifications per issuer.
  final int maxByIssuer = 100;

  /// Minimum number of certifications required to become a Smith.
  final int minCertForMembership = 3;

  /// Maximum duration of inactivity allowed before a Smith is removed.
  final int smithInactivityMaxDuration = 720;
}
