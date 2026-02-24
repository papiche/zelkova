// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i3;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/opaque/session_keys.dart' as _i9;
import '../types/gtest_runtime/runtime_call.dart' as _i7;
import '../types/pallet_authority_members/pallet/call.dart' as _i8;
import '../types/pallet_authority_members/types/member_data.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<int>> _incomingAuthorities =
      const _i2.StorageValue<List<int>>(
    prefix: 'AuthorityMembers',
    storage: 'IncomingAuthorities',
    valueCodec: _i3.U32SequenceCodec.codec,
  );

  final _i2.StorageValue<List<int>> _onlineAuthorities =
      const _i2.StorageValue<List<int>>(
    prefix: 'AuthorityMembers',
    storage: 'OnlineAuthorities',
    valueCodec: _i3.U32SequenceCodec.codec,
  );

  final _i2.StorageValue<List<int>> _outgoingAuthorities =
      const _i2.StorageValue<List<int>>(
    prefix: 'AuthorityMembers',
    storage: 'OutgoingAuthorities',
    valueCodec: _i3.U32SequenceCodec.codec,
  );

  final _i2.StorageMap<int, _i4.MemberData> _members =
      const _i2.StorageMap<int, _i4.MemberData>(
    prefix: 'AuthorityMembers',
    storage: 'Members',
    valueCodec: _i4.MemberData.codec,
    hasher: _i2.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  final _i2.StorageValue<List<int>> _blacklist =
      const _i2.StorageValue<List<int>>(
    prefix: 'AuthorityMembers',
    storage: 'Blacklist',
    valueCodec: _i3.U32SequenceCodec.codec,
  );

  /// The incoming authorities.
  _i5.Future<List<int>> incomingAuthorities({_i1.BlockHash? at}) async {
    final hashedKey = _incomingAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _incomingAuthorities.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The online authorities.
  _i5.Future<List<int>> onlineAuthorities({_i1.BlockHash? at}) async {
    final hashedKey = _onlineAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _onlineAuthorities.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The outgoing authorities.
  _i5.Future<List<int>> outgoingAuthorities({_i1.BlockHash? at}) async {
    final hashedKey = _outgoingAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _outgoingAuthorities.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The member data.
  _i5.Future<_i4.MemberData?> members(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _members.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The blacklisted authorities.
  _i5.Future<List<int>> blacklist({_i1.BlockHash? at}) async {
    final hashedKey = _blacklist.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _blacklist.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The member data.
  _i5.Future<List<_i4.MemberData?>> multiMembers(
    List<int> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys = keys.map((key) => _members.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _members.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `incomingAuthorities`.
  _i6.Uint8List incomingAuthoritiesKey() {
    final hashedKey = _incomingAuthorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `onlineAuthorities`.
  _i6.Uint8List onlineAuthoritiesKey() {
    final hashedKey = _onlineAuthorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `outgoingAuthorities`.
  _i6.Uint8List outgoingAuthoritiesKey() {
    final hashedKey = _outgoingAuthorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `members`.
  _i6.Uint8List membersKey(int key1) {
    final hashedKey = _members.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `blacklist`.
  _i6.Uint8List blacklistKey() {
    final hashedKey = _blacklist.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `members`.
  _i6.Uint8List membersMapPrefix() {
    final hashedKey = _members.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Request to leave the set of validators two sessions later.
  _i7.AuthorityMembers goOffline() {
    return _i7.AuthorityMembers(_i8.GoOffline());
  }

  /// Request to join the set of validators two sessions later.
  _i7.AuthorityMembers goOnline() {
    return _i7.AuthorityMembers(_i8.GoOnline());
  }

  /// Declare new session keys to replace current ones.
  _i7.AuthorityMembers setSessionKeys({required _i9.SessionKeys keys}) {
    return _i7.AuthorityMembers(_i8.SetSessionKeys(keys: keys));
  }

  /// Remove a member from the set of validators.
  _i7.AuthorityMembers removeMember({required int memberId}) {
    return _i7.AuthorityMembers(_i8.RemoveMember(memberId: memberId));
  }

  /// Remove a member from the blacklist.
  /// remove an identity from the blacklist
  _i7.AuthorityMembers removeMemberFromBlacklist({required int memberId}) {
    return _i7.AuthorityMembers(
        _i8.RemoveMemberFromBlacklist(memberId: memberId));
  }
}

class Constants {
  Constants();

  /// Maximum number of authorities allowed.
  final int maxAuthorities = 32;
}
