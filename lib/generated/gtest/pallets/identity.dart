// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/gtest_runtime/runtime_call.dart' as _i8;
import '../types/pallet_identity/pallet/call.dart' as _i9;
import '../types/pallet_identity/types/idty_name.dart' as _i5;
import '../types/pallet_identity/types/idty_value.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/sp_runtime/multi_signature.dart' as _i10;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<int, _i2.IdtyValue> _identities =
      const _i1.StorageMap<int, _i2.IdtyValue>(
    prefix: 'Identity',
    storage: 'Identities',
    valueCodec: _i2.IdtyValue.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  final _i1.StorageValue<int> _counterForIdentities =
      const _i1.StorageValue<int>(
    prefix: 'Identity',
    storage: 'CounterForIdentities',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageMap<_i4.AccountId32, int> _identityIndexOf =
      const _i1.StorageMap<_i4.AccountId32, int>(
    prefix: 'Identity',
    storage: 'IdentityIndexOf',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageMap<_i5.IdtyName, int> _identitiesNames =
      const _i1.StorageMap<_i5.IdtyName, int>(
    prefix: 'Identity',
    storage: 'IdentitiesNames',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i5.IdtyNameCodec()),
  );

  final _i1.StorageValue<int> _nextIdtyIndex = const _i1.StorageValue<int>(
    prefix: 'Identity',
    storage: 'NextIdtyIndex',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageMap<int, List<int>> _identityChangeSchedule =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'Identity',
    storage: 'IdentityChangeSchedule',
    valueCodec: _i3.U32SequenceCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U32Codec.codec),
  );

  /// The identity value for each identity.
  _i6.Future<_i2.IdtyValue?> identities(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _identities.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _identities.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i6.Future<int> counterForIdentities({_i1.BlockHash? at}) async {
    final hashedKey = _counterForIdentities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForIdentities.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The identity associated with each account.
  _i6.Future<int?> identityIndexOf(
    _i4.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _identityIndexOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _identityIndexOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The name associated with each identity.
  _i6.Future<int?> identitiesNames(
    _i5.IdtyName key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _identitiesNames.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _identitiesNames.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The identity index to assign to the next created identity.
  _i6.Future<int> nextIdtyIndex({_i1.BlockHash? at}) async {
    final hashedKey = _nextIdtyIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextIdtyIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The identities to remove at a given block.
  _i6.Future<List<int>> identityChangeSchedule(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _identityChangeSchedule.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _identityChangeSchedule.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Returns the storage key for `identities`.
  _i7.Uint8List identitiesKey(int key1) {
    final hashedKey = _identities.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForIdentities`.
  _i7.Uint8List counterForIdentitiesKey() {
    final hashedKey = _counterForIdentities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `identityIndexOf`.
  _i7.Uint8List identityIndexOfKey(_i4.AccountId32 key1) {
    final hashedKey = _identityIndexOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `identitiesNames`.
  _i7.Uint8List identitiesNamesKey(_i5.IdtyName key1) {
    final hashedKey = _identitiesNames.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nextIdtyIndex`.
  _i7.Uint8List nextIdtyIndexKey() {
    final hashedKey = _nextIdtyIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `identityChangeSchedule`.
  _i7.Uint8List identityChangeScheduleKey(int key1) {
    final hashedKey = _identityChangeSchedule.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `identities`.
  _i7.Uint8List identitiesMapPrefix() {
    final hashedKey = _identities.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `identityIndexOf`.
  _i7.Uint8List identityIndexOfMapPrefix() {
    final hashedKey = _identityIndexOf.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `identitiesNames`.
  _i7.Uint8List identitiesNamesMapPrefix() {
    final hashedKey = _identitiesNames.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `identityChangeSchedule`.
  _i7.Uint8List identityChangeScheduleMapPrefix() {
    final hashedKey = _identityChangeSchedule.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Create an identity for an existing account
  ///
  /// - `owner_key`: the public key corresponding to the identity to be created
  ///
  /// The origin must be allowed to create an identity.
  _i8.RuntimeCall createIdentity({required _i4.AccountId32 ownerKey}) {
    final _call = _i9.Call.values.createIdentity(ownerKey: ownerKey);
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Confirm the creation of an identity and give it a name
  ///
  /// - `idty_name`: the name uniquely associated to this identity. Must match the validation rules defined by the runtime.
  ///
  /// The identity must have been created using `create_identity` before it can be confirmed.
  _i8.RuntimeCall confirmIdentity({required _i5.IdtyName idtyName}) {
    final _call = _i9.Call.values.confirmIdentity(idtyName: idtyName);
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Change identity owner key.
  ///
  /// - `new_key`: the new owner key.
  /// - `new_key_sig`: the signature of the encoded form of `IdtyIndexAccountIdPayload`.
  ///                 Must be signed by `new_key`.
  ///
  /// The origin should be the old identity owner key.
  _i8.RuntimeCall changeOwnerKey({
    required _i4.AccountId32 newKey,
    required _i10.MultiSignature newKeySig,
  }) {
    final _call = _i9.Call.values.changeOwnerKey(
      newKey: newKey,
      newKeySig: newKeySig,
    );
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Revoke an identity using a revocation signature
  ///
  /// - `idty_index`: the index of the identity to be revoked.
  /// - `revocation_key`: the key used to sign the revocation payload.
  /// - `revocation_sig`: the signature of the encoded form of `RevocationPayload`.
  ///                    Must be signed by `revocation_key`.
  ///
  /// Any signed origin can execute this call.
  _i8.RuntimeCall revokeIdentity({
    required int idtyIndex,
    required _i4.AccountId32 revocationKey,
    required _i10.MultiSignature revocationSig,
  }) {
    final _call = _i9.Call.values.revokeIdentity(
      idtyIndex: idtyIndex,
      revocationKey: revocationKey,
      revocationSig: revocationSig,
    );
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Revoke an identity using a legacy (DUBP) revocation document
  ///
  /// - `revocation document`: the full-length revocation document, signature included
  ///
  /// Any signed origin can execute this call.
  _i8.RuntimeCall revokeIdentityLegacy(
      {required List<int> revocationDocument}) {
    final _call = _i9.Call.values
        .revokeIdentityLegacy(revocationDocument: revocationDocument);
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Remove identity names from storage.
  ///
  /// This function allows a privileged root origin to remove multiple identity names from storage
  /// in bulk.
  ///
  /// - `origin` - The origin of the call. It must be root.
  /// - `names` - A vector containing the identity names to be removed from storage.
  _i8.RuntimeCall pruneItemIdentitiesNames(
      {required List<_i5.IdtyName> names}) {
    final _call = _i9.Call.values.pruneItemIdentitiesNames(names: names);
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Change sufficient reference count for a given key.
  ///
  /// This function allows a privileged root origin to increment or decrement the sufficient
  /// reference count associated with a specified owner key.
  ///
  /// - `origin` - The origin of the call. It must be root.
  /// - `owner_key` - The account whose sufficient reference count will be modified.
  /// - `inc` - A boolean indicating whether to increment (`true`) or decrement (`false`) the count.
  ///
  _i8.RuntimeCall fixSufficients({
    required _i4.AccountId32 ownerKey,
    required bool inc,
  }) {
    final _call = _i9.Call.values.fixSufficients(
      ownerKey: ownerKey,
      inc: inc,
    );
    return _i8.RuntimeCall.values.identity(_call);
  }

  /// Link an account to an identity.
  ///
  /// This function links a specified account to an identity, requiring both the account and the
  /// identity to sign the operation.
  ///
  /// - `origin` - The origin of the call, which must have an associated identity index.
  /// - `account_id` - The account ID to link, which must sign the payload.
  /// - `payload_sig` - The signature with the linked identity.
  _i8.RuntimeCall linkAccount({
    required _i4.AccountId32 accountId,
    required _i10.MultiSignature payloadSig,
  }) {
    final _call = _i9.Call.values.linkAccount(
      accountId: accountId,
      payloadSig: payloadSig,
    );
    return _i8.RuntimeCall.values.identity(_call);
  }
}

class Constants {
  Constants();

  /// The period during which the owner can confirm the new identity.
  final int confirmPeriod = 876600;

  /// The period during which the identity has to be validated to become a member.
  final int validationPeriod = 876600;

  /// The period before which an identity that lost membership is automatically revoked.
  final int autorevocationPeriod = 5259600;

  /// The period after which a revoked identity is removed and the keys are freed.
  final int deletionPeriod = 52596000;

  /// The minimum duration between two owner key changes to prevent identity theft.
  final int changeOwnerKeyPeriod = 438300;

  /// The minimum duration between the creation of two identities by the same creator.
  /// Should be greater than or equal to the certification period defined in the certification pallet.
  final int idtyCreationPeriod = 14400;
}
