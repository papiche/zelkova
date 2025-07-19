// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/gtest_runtime/runtime_call.dart' as _i1;
import '../types/pallet_upgrade_origin/pallet/call.dart' as _i2;
import '../types/sp_weights/weight_v2/weight.dart' as _i3;

class Txs {
  const Txs();

  /// Dispatches a function call from root origin.
  ///
  /// The weight of this call is defined by the caller.
  _i1.RuntimeCall dispatchAsRoot({required _i1.RuntimeCall call}) {
    final _call = _i2.Call.values.dispatchAsRoot(call: call);
    return _i1.RuntimeCall.values.upgradeOrigin(_call);
  }

  /// Dispatches a function call from root origin.
  /// This function does not check the weight of the call, and instead allows the
  /// caller to specify the weight of the call.
  ///
  /// The weight of this call is defined by the caller.
  _i1.RuntimeCall dispatchAsRootUncheckedWeight({
    required _i1.RuntimeCall call,
    required _i3.Weight weight,
  }) {
    final _call = _i2.Call.values.dispatchAsRootUncheckedWeight(
      call: call,
      weight: weight,
    );
    return _i1.RuntimeCall.values.upgradeOrigin(_call);
  }
}
