// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i5;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i8;
import '../types/pallet_multisig/multisig.dart' as _i4;
import '../types/pallet_multisig/pallet/call.dart' as _i9;
import '../types/pallet_multisig/timepoint.dart' as _i10;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_weights/weight_v2/weight.dart' as _i11;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageDoubleMap<_i3.AccountId32, List<int>, _i4.Multisig>
      _multisigs =
      const _i2.StorageDoubleMap<_i3.AccountId32, List<int>, _i4.Multisig>(
    prefix: 'Multisig',
    storage: 'Multisigs',
    valueCodec: _i4.Multisig.codec,
    hasher1: _i2.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
    hasher2: _i2.StorageHasher.blake2b128Concat(_i5.U8ArrayCodec(32)),
  );

  /// The set of open multisig operations.
  _i6.Future<_i4.Multisig?> multisigs(
    _i3.AccountId32 key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _multisigs.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _multisigs.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `multisigs`.
  _i7.Uint8List multisigsKey(
    _i3.AccountId32 key1,
    List<int> key2,
  ) {
    final hashedKey = _multisigs.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `multisigs`.
  _i7.Uint8List multisigsMapPrefix(_i3.AccountId32 key1) {
    final hashedKey = _multisigs.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Immediately dispatch a multi-signature call using a single approval from the caller.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `other_signatories`: The accounts (other than the sender) who are part of the
  /// multi-signature, but do not participate in the approval process.
  /// - `call`: The call to be executed.
  ///
  /// Result is equivalent to the dispatched result.
  ///
  /// ## Complexity
  /// O(Z + C) where Z is the length of the call and C its execution weight.
  _i8.Multisig asMultiThreshold1({
    required List<_i3.AccountId32> otherSignatories,
    required _i8.RuntimeCall call,
  }) {
    return _i8.Multisig(_i9.AsMultiThreshold1(
      otherSignatories: otherSignatories,
      call: call,
    ));
  }

  /// Register approval for a dispatch to be made from a deterministic composite account if
  /// approved by a total of `threshold - 1` of `other_signatories`.
  ///
  /// If there are enough, then dispatch the call.
  ///
  /// Payment: `DepositBase` will be reserved if this is the first approval, plus
  /// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
  /// is cancelled.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
  /// not the first approval, then it must be `Some`, with the timepoint (block number and
  /// transaction index) of the first approval transaction.
  /// - `call`: The call to be executed.
  ///
  /// NOTE: Unless this is the final approval, you will generally want to use
  /// `approve_as_multi` instead, since it only requires a hash of the call.
  ///
  /// Result is equivalent to the dispatched result if `threshold` is exactly `1`. Otherwise
  /// on success, result is `Ok` and the result from the interior call, if it was executed,
  /// may be found in the deposited `MultisigExecuted` event.
  ///
  /// ## Complexity
  /// - `O(S + Z + Call)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One call encode & hash, both of complexity `O(Z)` where `Z` is tx-len.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - Up to one binary search and insert (`O(logS + S)`).
  /// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
  /// - One event.
  /// - The weight of the `call`.
  /// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
  ///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
  _i8.Multisig asMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    _i10.Timepoint? maybeTimepoint,
    required _i8.RuntimeCall call,
    required _i11.Weight maxWeight,
  }) {
    return _i8.Multisig(_i9.AsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      call: call,
      maxWeight: maxWeight,
    ));
  }

  /// Register approval for a dispatch to be made from a deterministic composite account if
  /// approved by a total of `threshold - 1` of `other_signatories`.
  ///
  /// Payment: `DepositBase` will be reserved if this is the first approval, plus
  /// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
  /// is cancelled.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
  /// not the first approval, then it must be `Some`, with the timepoint (block number and
  /// transaction index) of the first approval transaction.
  /// - `call_hash`: The hash of the call to be executed.
  ///
  /// NOTE: If this is the final approval, you will want to use `as_multi` instead.
  ///
  /// ## Complexity
  /// - `O(S)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - Up to one binary search and insert (`O(logS + S)`).
  /// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
  /// - One event.
  /// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
  ///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
  _i8.Multisig approveAsMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    _i10.Timepoint? maybeTimepoint,
    required List<int> callHash,
    required _i11.Weight maxWeight,
  }) {
    return _i8.Multisig(_i9.ApproveAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      callHash: callHash,
      maxWeight: maxWeight,
    ));
  }

  /// Cancel a pre-existing, on-going multisig transaction. Any deposit reserved previously
  /// for this operation will be unreserved on success.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `timepoint`: The timepoint (block number and transaction index) of the first approval
  /// transaction for this dispatch.
  /// - `call_hash`: The hash of the call to be executed.
  ///
  /// ## Complexity
  /// - `O(S)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - One event.
  /// - I/O: 1 read `O(S)`, one remove.
  /// - Storage: removes one item.
  _i8.Multisig cancelAsMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    required _i10.Timepoint timepoint,
    required List<int> callHash,
  }) {
    return _i8.Multisig(_i9.CancelAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      timepoint: timepoint,
      callHash: callHash,
    ));
  }

  /// Poke the deposit reserved for an existing multisig operation.
  ///
  /// The dispatch origin for this call must be _Signed_ and must be the original depositor of
  /// the multisig operation.
  ///
  /// The transaction fee is waived if the deposit amount has changed.
  ///
  /// - `threshold`: The total number of approvals needed for this multisig.
  /// - `other_signatories`: The accounts (other than the sender) who are part of the
  ///  multisig.
  /// - `call_hash`: The hash of the call this deposit is reserved for.
  ///
  /// Emits `DepositPoked` if successful.
  _i8.Multisig pokeDeposit({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    required List<int> callHash,
  }) {
    return _i8.Multisig(_i9.PokeDeposit(
      threshold: threshold,
      otherSignatories: otherSignatories,
      callHash: callHash,
    ));
  }
}

class Constants {
  Constants();

  /// The base amount of currency needed to reserve for creating a multisig execution or to
  /// store a dispatch call for later.
  ///
  /// This is held for an additional storage item whose value size is
  /// `4 + sizeof((BlockNumber, Balance, AccountId))` bytes and whose key size is
  /// `32 + sizeof(AccountId)` bytes.
  final BigInt depositBase = BigInt.from(100);

  /// The amount of currency needed per unit threshold when creating a multisig execution.
  ///
  /// This is held for adding 32 bytes more into a pre-existing storage value.
  final BigInt depositFactor = BigInt.from(32);

  /// The maximum amount of signatories allowed in the multisig.
  final int maxSignatories = 10;
}
