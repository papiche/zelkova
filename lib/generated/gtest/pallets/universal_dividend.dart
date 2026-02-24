// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i3;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/gtest_runtime/runtime_call.dart' as _i7;
import '../types/pallet_universal_dividend/pallet/call.dart' as _i8;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i10;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i9;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<BigInt> _currentUd = const _i2.StorageValue<BigInt>(
    prefix: 'UniversalDividend',
    storage: 'CurrentUd',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i2.StorageValue<int> _currentUdIndex = const _i2.StorageValue<int>(
    prefix: 'UniversalDividend',
    storage: 'CurrentUdIndex',
    valueCodec: _i3.U16Codec.codec,
  );

  final _i2.StorageValue<BigInt> _monetaryMass = const _i2.StorageValue<BigInt>(
    prefix: 'UniversalDividend',
    storage: 'MonetaryMass',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i2.StorageValue<BigInt> _nextReeval = const _i2.StorageValue<BigInt>(
    prefix: 'UniversalDividend',
    storage: 'NextReeval',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i2.StorageValue<BigInt> _nextUd = const _i2.StorageValue<BigInt>(
    prefix: 'UniversalDividend',
    storage: 'NextUd',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i2.StorageValue<List<_i4.Tuple2<int, BigInt>>> _pastReevals =
      const _i2.StorageValue<List<_i4.Tuple2<int, BigInt>>>(
    prefix: 'UniversalDividend',
    storage: 'PastReevals',
    valueCodec:
        _i3.SequenceCodec<_i4.Tuple2<int, BigInt>>(_i4.Tuple2Codec<int, BigInt>(
      _i3.U16Codec.codec,
      _i3.U64Codec.codec,
    )),
  );

  /// The current Universal Dividend value.
  _i5.Future<BigInt> currentUd({_i1.BlockHash? at}) async {
    final hashedKey = _currentUd.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentUd.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The current Universal Dividend index.
  _i5.Future<int> currentUdIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentUdIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentUdIndex.decodeValue(bytes);
    }
    return 1; /* Default */
  }

  /// The total quantity of money created by Universal Dividend, excluding potential money destruction.
  _i5.Future<BigInt> monetaryMass({_i1.BlockHash? at}) async {
    final hashedKey = _monetaryMass.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _monetaryMass.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The next Universal Dividend re-evaluation.
  _i5.Future<BigInt?> nextReeval({_i1.BlockHash? at}) async {
    final hashedKey = _nextReeval.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextReeval.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next Universal Dividend creation.
  _i5.Future<BigInt?> nextUd({_i1.BlockHash? at}) async {
    final hashedKey = _nextUd.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextUd.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The past Universal Dividend re-evaluations.
  _i5.Future<List<_i4.Tuple2<int, BigInt>>> pastReevals(
      {_i1.BlockHash? at}) async {
    final hashedKey = _pastReevals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pastReevals.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `currentUd`.
  _i6.Uint8List currentUdKey() {
    final hashedKey = _currentUd.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentUdIndex`.
  _i6.Uint8List currentUdIndexKey() {
    final hashedKey = _currentUdIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `monetaryMass`.
  _i6.Uint8List monetaryMassKey() {
    final hashedKey = _monetaryMass.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextReeval`.
  _i6.Uint8List nextReevalKey() {
    final hashedKey = _nextReeval.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextUd`.
  _i6.Uint8List nextUdKey() {
    final hashedKey = _nextUd.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `pastReevals`.
  _i6.Uint8List pastReevalsKey() {
    final hashedKey = _pastReevals.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Claim Universal Dividends.
  _i7.UniversalDividend claimUds() {
    return _i7.UniversalDividend(_i8.ClaimUds());
  }

  /// Transfer some liquid free balance to another account, in milliUD.
  _i7.UniversalDividend transferUd({
    required _i9.MultiAddress dest,
    required BigInt value,
  }) {
    return _i7.UniversalDividend(_i8.TransferUd(
      dest: dest,
      value: value,
    ));
  }

  /// Transfer some liquid free balance to another account in milliUD and keep the account alive.
  _i7.UniversalDividend transferUdKeepAlive({
    required _i9.MultiAddress dest,
    required BigInt value,
  }) {
    return _i7.UniversalDividend(_i8.TransferUdKeepAlive(
      dest: dest,
      value: value,
    ));
  }
}

class Constants {
  Constants();

  /// Maximum number of past UD revaluations to keep in storage.
  final int maxPastReeval = 160;

  /// Square of the money growth rate per UD reevaluation period.
  final _i10.Perbill squareMoneyGrowthRate = 2381440;

  /// Universal dividend creation period in milliseconds.
  final BigInt udCreationPeriod = BigInt.from(86400000);

  /// Universal dividend reevaluation period in milliseconds.
  final BigInt udReevalPeriod = BigInt.from(15778800000);
}
