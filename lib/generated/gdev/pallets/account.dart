// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/gdev_runtime/runtime_call.dart' as _i1;
import '../types/pallet_duniter_account/pallet/call.dart' as _i2;

class Txs {
  const Txs();

  /// Unlink the identity associated with the account.
  _i1.RuntimeCall unlinkIdentity() {
    final _call = _i2.Call.unlinkIdentity;
    return _i1.RuntimeCall.values.account(_call);
  }
}
