// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i6;
import '../types/pallet_sudo/pallet/call.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i9;
import '../types/sp_weights/weight_v2/weight.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<_i3.AccountId32> _key =
      const _i2.StorageValue<_i3.AccountId32>(
    prefix: 'Sudo',
    storage: 'Key',
    valueCodec: _i3.AccountId32Codec(),
  );

  /// The `AccountId` of the sudo key.
  _i4.Future<_i3.AccountId32?> key({_i1.BlockHash? at}) async {
    final hashedKey = _key.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _key.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `key`.
  _i5.Uint8List keyKey() {
    final hashedKey = _key.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Authenticates the sudo key and dispatches a function call with `Root` origin.
  _i6.Sudo sudo({required _i6.RuntimeCall call}) {
    return _i6.Sudo(_i7.Sudo(call: call));
  }

  /// Authenticates the sudo key and dispatches a function call with `Root` origin.
  /// This function does not check the weight of the call, and instead allows the
  /// Sudo user to specify the weight of the call.
  ///
  /// The dispatch origin for this call must be _Signed_.
  _i6.Sudo sudoUncheckedWeight({
    required _i6.RuntimeCall call,
    required _i8.Weight weight,
  }) {
    return _i6.Sudo(_i7.SudoUncheckedWeight(
      call: call,
      weight: weight,
    ));
  }

  /// Authenticates the current sudo key and sets the given AccountId (`new`) as the new sudo
  /// key.
  _i6.Sudo setKey({required _i9.MultiAddress new_}) {
    return _i6.Sudo(_i7.SetKey(new_: new_));
  }

  /// Authenticates the sudo key and dispatches a function call with `Signed` origin from
  /// a given account.
  ///
  /// The dispatch origin for this call must be _Signed_.
  _i6.Sudo sudoAs({
    required _i9.MultiAddress who,
    required _i6.RuntimeCall call,
  }) {
    return _i6.Sudo(_i7.SudoAs(
      who: who,
      call: call,
    ));
  }

  /// Permanently removes the sudo key.
  ///
  /// **This cannot be un-done.**
  _i6.Sudo removeKey() {
    return _i6.Sudo(_i7.RemoveKey());
  }
}
