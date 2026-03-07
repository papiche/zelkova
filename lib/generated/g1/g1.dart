// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i36;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/account.dart' as _i32;
import 'pallets/atomic_swap.dart' as _i27;
import 'pallets/authority_discovery.dart' as _i18;
import 'pallets/authority_members.dart' as _i11;
import 'pallets/authorship.dart' as _i12;
import 'pallets/babe.dart' as _i4;
import 'pallets/balances.dart' as _i6;
import 'pallets/certification.dart' as _i25;
import 'pallets/distance.dart' as _i26;
import 'pallets/grandpa.dart' as _i16;
import 'pallets/historical.dart' as _i14;
import 'pallets/identity.dart' as _i23;
import 'pallets/im_online.dart' as _i17;
import 'pallets/membership.dart' as _i24;
import 'pallets/multisig.dart' as _i28;
import 'pallets/offences.dart' as _i13;
import 'pallets/oneshot_account.dart' as _i8;
import 'pallets/preimage.dart' as _i20;
import 'pallets/provide_randomness.dart' as _i29;
import 'pallets/proxy.dart' as _i30;
import 'pallets/quota.dart' as _i9;
import 'pallets/scheduler.dart' as _i3;
import 'pallets/session.dart' as _i15;
import 'pallets/smith_members.dart' as _i10;
import 'pallets/sudo.dart' as _i19;
import 'pallets/system.dart' as _i2;
import 'pallets/technical_committee.dart' as _i21;
import 'pallets/timestamp.dart' as _i5;
import 'pallets/transaction_payment.dart' as _i7;
import 'pallets/treasury.dart' as _i31;
import 'pallets/universal_dividend.dart' as _i22;
import 'pallets/upgrade_origin.dart' as _i33;
import 'pallets/utility.dart' as _i34;
import 'pallets/wot.dart' as _i35;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        scheduler = _i3.Queries(api),
        babe = _i4.Queries(api),
        timestamp = _i5.Queries(api),
        balances = _i6.Queries(api),
        transactionPayment = _i7.Queries(api),
        oneshotAccount = _i8.Queries(api),
        quota = _i9.Queries(api),
        smithMembers = _i10.Queries(api),
        authorityMembers = _i11.Queries(api),
        authorship = _i12.Queries(api),
        offences = _i13.Queries(api),
        historical = _i14.Queries(api),
        session = _i15.Queries(api),
        grandpa = _i16.Queries(api),
        imOnline = _i17.Queries(api),
        authorityDiscovery = _i18.Queries(api),
        sudo = _i19.Queries(api),
        preimage = _i20.Queries(api),
        technicalCommittee = _i21.Queries(api),
        universalDividend = _i22.Queries(api),
        identity = _i23.Queries(api),
        membership = _i24.Queries(api),
        certification = _i25.Queries(api),
        distance = _i26.Queries(api),
        atomicSwap = _i27.Queries(api),
        multisig = _i28.Queries(api),
        provideRandomness = _i29.Queries(api),
        proxy = _i30.Queries(api),
        treasury = _i31.Queries(api);

  final _i2.Queries system;

  final _i3.Queries scheduler;

  final _i4.Queries babe;

  final _i5.Queries timestamp;

  final _i6.Queries balances;

  final _i7.Queries transactionPayment;

  final _i8.Queries oneshotAccount;

  final _i9.Queries quota;

  final _i10.Queries smithMembers;

  final _i11.Queries authorityMembers;

  final _i12.Queries authorship;

  final _i13.Queries offences;

  final _i14.Queries historical;

  final _i15.Queries session;

  final _i16.Queries grandpa;

  final _i17.Queries imOnline;

  final _i18.Queries authorityDiscovery;

  final _i19.Queries sudo;

  final _i20.Queries preimage;

  final _i21.Queries technicalCommittee;

  final _i22.Queries universalDividend;

  final _i23.Queries identity;

  final _i24.Queries membership;

  final _i25.Queries certification;

  final _i26.Queries distance;

  final _i27.Queries atomicSwap;

  final _i28.Queries multisig;

  final _i29.Queries provideRandomness;

  final _i30.Queries proxy;

  final _i31.Queries treasury;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i32.Txs account = _i32.Txs();

  final _i3.Txs scheduler = _i3.Txs();

  final _i4.Txs babe = _i4.Txs();

  final _i5.Txs timestamp = _i5.Txs();

  final _i6.Txs balances = _i6.Txs();

  final _i8.Txs oneshotAccount = _i8.Txs();

  final _i10.Txs smithMembers = _i10.Txs();

  final _i11.Txs authorityMembers = _i11.Txs();

  final _i15.Txs session = _i15.Txs();

  final _i16.Txs grandpa = _i16.Txs();

  final _i17.Txs imOnline = _i17.Txs();

  final _i19.Txs sudo = _i19.Txs();

  final _i33.Txs upgradeOrigin = _i33.Txs();

  final _i20.Txs preimage = _i20.Txs();

  final _i21.Txs technicalCommittee = _i21.Txs();

  final _i22.Txs universalDividend = _i22.Txs();

  final _i23.Txs identity = _i23.Txs();

  final _i25.Txs certification = _i25.Txs();

  final _i26.Txs distance = _i26.Txs();

  final _i27.Txs atomicSwap = _i27.Txs();

  final _i28.Txs multisig = _i28.Txs();

  final _i29.Txs provideRandomness = _i29.Txs();

  final _i30.Txs proxy = _i30.Txs();

  final _i34.Txs utility = _i34.Txs();

  final _i31.Txs treasury = _i31.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i3.Constants scheduler = _i3.Constants();

  final _i4.Constants babe = _i4.Constants();

  final _i5.Constants timestamp = _i5.Constants();

  final _i6.Constants balances = _i6.Constants();

  final _i7.Constants transactionPayment = _i7.Constants();

  final _i9.Constants quota = _i9.Constants();

  final _i10.Constants smithMembers = _i10.Constants();

  final _i11.Constants authorityMembers = _i11.Constants();

  final _i16.Constants grandpa = _i16.Constants();

  final _i17.Constants imOnline = _i17.Constants();

  final _i21.Constants technicalCommittee = _i21.Constants();

  final _i22.Constants universalDividend = _i22.Constants();

  final _i35.Constants wot = _i35.Constants();

  final _i23.Constants identity = _i23.Constants();

  final _i24.Constants membership = _i24.Constants();

  final _i25.Constants certification = _i25.Constants();

  final _i26.Constants distance = _i26.Constants();

  final _i27.Constants atomicSwap = _i27.Constants();

  final _i28.Constants multisig = _i28.Constants();

  final _i29.Constants provideRandomness = _i29.Constants();

  final _i30.Constants proxy = _i30.Constants();

  final _i34.Constants utility = _i34.Constants();

  final _i31.Constants treasury = _i31.Constants();
}

class Rpc {
  const Rpc({
    required this.state,
    required this.system,
  });

  final _i1.StateApi state;

  final _i1.SystemApi system;
}

class Registry {
  Registry();

  final int extrinsicVersion = 4;

  List getSignedExtensionTypes() {
    return [
      'CheckMortality',
      'CheckNonce',
      'ChargeTransactionPayment',
      'CheckMetadataHash'
    ];
  }

  List getSignedExtensionExtra() {
    return [
      'CheckSpecVersion',
      'CheckTxVersion',
      'CheckGenesis',
      'CheckMortality',
      'CheckMetadataHash'
    ];
  }
}

class G1 {
  G1._(
    this._provider,
    this.rpc,
  )   : query = Queries(rpc.state),
        constant = Constants(),
        tx = Extrinsics(),
        registry = Registry();

  factory G1(_i1.Provider provider) {
    final rpc = Rpc(
      state: _i1.StateApi(provider),
      system: _i1.SystemApi(provider),
    );
    return G1._(
      provider,
      rpc,
    );
  }

  factory G1.url(Uri url) {
    final provider = _i1.Provider.fromUri(url);
    return G1(provider);
  }

  final _i1.Provider _provider;

  final Queries query;

  final Constants constant;

  final Rpc rpc;

  final Extrinsics tx;

  final Registry registry;

  _i36.Future connect() async {
    return await _provider.connect();
  }

  _i36.Future disconnect() async {
    return await _provider.disconnect();
  }
}
