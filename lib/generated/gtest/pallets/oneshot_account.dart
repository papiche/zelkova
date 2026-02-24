// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i7;
import '../types/pallet_oneshot_account/pallet/call.dart' as _i9;
import '../types/pallet_oneshot_account/types/account.dart' as _i10;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageMap<_i3.AccountId32, BigInt> _oneshotAccounts =
      const _i2.StorageMap<_i3.AccountId32, BigInt>(
    prefix: 'OneshotAccount',
    storage: 'OneshotAccounts',
    valueCodec: _i4.U64Codec.codec,
    hasher: _i2.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  /// The balance for each oneshot account.
  _i5.Future<BigInt?> oneshotAccounts(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _oneshotAccounts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _oneshotAccounts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The balance for each oneshot account.
  _i5.Future<List<BigInt?>> multiOneshotAccounts(
    List<_i3.AccountId32> keys, {
    _i1.BlockHash? at,
  }) async {
    final hashedKeys =
        keys.map((key) => _oneshotAccounts.hashedKeyFor(key)).toList();
    final bytes = await __api.queryStorageAt(
      hashedKeys,
      at: at,
    );
    if (bytes.isNotEmpty) {
      return bytes.first.changes
          .map((v) => _oneshotAccounts.decodeValue(v.key))
          .toList();
    }
    return []; /* Nullable */
  }

  /// Returns the storage key for `oneshotAccounts`.
  _i6.Uint8List oneshotAccountsKey(_i3.AccountId32 key1) {
    final hashedKey = _oneshotAccounts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `oneshotAccounts`.
  _i6.Uint8List oneshotAccountsMapPrefix() {
    final hashedKey = _oneshotAccounts.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Create an account that can only be consumed once
  ///
  /// - `dest`: The oneshot account to be created.
  /// - `balance`: The balance to be transfered to this oneshot account.
  ///
  /// Origin account is kept alive.
  _i7.OneshotAccount createOneshotAccount({
    required _i8.MultiAddress dest,
    required BigInt value,
  }) {
    return _i7.OneshotAccount(_i9.CreateOneshotAccount(
      dest: dest,
      value: value,
    ));
  }

  /// Consume a oneshot account and transfer its balance to an account
  ///
  /// - `block_height`: Must be a recent block number. The limit is `BlockHashCount` in the past. (this is to prevent replay attacks)
  /// - `dest`: The destination account.
  /// - `dest_is_oneshot`: If set to `true`, then a oneshot account is created at `dest`. Else, `dest` has to be an existing account.
  _i7.OneshotAccount consumeOneshotAccount({
    required int blockHeight,
    required _i10.Account dest,
  }) {
    return _i7.OneshotAccount(_i9.ConsumeOneshotAccount(
      blockHeight: blockHeight,
      dest: dest,
    ));
  }

  /// Consume a oneshot account then transfer some amount to an account,
  /// and the remaining amount to another account.
  ///
  /// - `block_height`: Must be a recent block number.
  ///  The limit is `BlockHashCount` in the past. (this is to prevent replay attacks)
  /// - `dest`: The destination account.
  /// - `dest_is_oneshot`: If set to `true`, then a oneshot account is created at `dest`. Else, `dest` has to be an existing account.
  /// - `dest2`: The second destination account.
  /// - `dest2_is_oneshot`: If set to `true`, then a oneshot account is created at `dest2`. Else, `dest2` has to be an existing account.
  /// - `balance1`: The amount transfered to `dest`, the leftover being transfered to `dest2`.
  _i7.OneshotAccount consumeOneshotAccountWithRemaining({
    required int blockHeight,
    required _i10.Account dest,
    required _i10.Account remainingTo,
    required BigInt balance,
  }) {
    return _i7.OneshotAccount(_i9.ConsumeOneshotAccountWithRemaining(
      blockHeight: blockHeight,
      dest: dest,
      remainingTo: remainingTo,
      balance: balance,
    ));
  }
}
