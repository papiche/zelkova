import 'dart:async';
import 'dart:typed_data';

import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:durt/durt.dart' as durt;
import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ss58/ss58.dart';
import 'package:tuple/tuple.dart' as tp;

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../generated/gdev/gdev.dart';
import '../generated/gdev/types/frame_system/account_info.dart';
import '../generated/gdev/types/gdev_runtime/runtime_call.dart';
import '../generated/gdev/types/pallet_certification/types/idty_cert_meta.dart';
import '../generated/gdev/types/pallet_identity/types/idty_value.dart';
import '../generated/gdev/types/sp_runtime/multi_signature.dart';
import '../generated/gdev/types/sp_runtime/multiaddress/multi_address.dart';
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import 'g1_helper.dart';
import 'pay_result.dart';
import 'sing_and_send.dart';

// From:
// https://polkadot.js.org/docs/util-crypto/examples/validate-address/
bool isValidV2Address(String address) {
  try {
    final Keyring keyring = Keyring();
    keyring.encodeAddress(
        isHex(address) ? hexToU8a(address) : keyring.decodeAddress(address));
    return true;
  } catch (error) {
    return false;
  }
}

Uint8List hexToU8a(String hexString) {
  hexString = hexString.startsWith('0x') ? hexString.substring(2) : hexString;
  if (hexString.length % 2 != 0) {
    hexString = '0$hexString';
  }
  return Uint8List.fromList(List<int>.generate(hexString.length ~/ 2, (int i) {
    return int.parse(hexString.substring(i * 2, i * 2 + 2), radix: 16);
  }));
}

bool isHex(String value, [int bitLength = -1]) {
  final RegExp hexRegEx = RegExp(r'^0x[a-fA-F0-9]+$');

  return hexRegEx.hasMatch(value) &&
      (bitLength == -1 || value.length == 2 + bitLength ~/ 4);
}

String addressFromV1Pubkey(String pubkey) {
  final Keyring keyring = Keyring();
  final List<int> pubkeyByte = Base58Decode(pubkey);
  final String address = keyring.encodeAddress(pubkeyByte);
  return address;
}

String v1pubkeyFromAddress(String address) {
  final Keyring keyring = Keyring();
  final Uint8List publicKeyBytes = keyring.decodeAddress(address);
  final String publicKey = Base58Encode(publicKeyBytes);
  return publicKey;
}

Keyring keyringFromV1Seed(Uint8List seed) {
  final Keyring keyring = Keyring();
  final KeyPair keypair = KeyPair.ed25519.fromSeed(seed);
  keyring.add(keypair);
  return keyring;
}

Keyring keyringFromSeed(Uint8List seed) {
  final Keyring keyring = Keyring();
  final KeyPair keypair = KeyPair.sr25519.fromSeed(seed);
  keyring.add(keypair);
  return keyring;
}

// From durt
String mnemonicGenerate({String lang = 'english'}) {
  final List<String> supportedLanguages = <String>[
    'english',
    'french',
    'italian',
    'spanish'
  ];
  if (!supportedLanguages.contains(lang)) {
    throw ArgumentError('Unsupported language');
  }
  final String mnemonic = durt.generateMnemonic(lang: lang);
  return mnemonic;
}

// From:
// https://polkadot.js.org/docs/keyring/start/create
Future<KeyPair> addPair() async {
  final String mnemonic = mnemonicGenerate();
  final Keyring keyring = Keyring();
  // create & add the pair to the keyring with the type
  // TODOAdd some additional metadata as in polkadot-js

  final KeyPair pair =
      await keyring.fromUri(mnemonic, keyPairType: KeyPairType.sr25519);

  return pair;
}

Future<T> executeOnPolkadotNodes<T>(
    Future<T> Function(Node node, Provider provider, Gdev polkadot) operation,
    {bool retry = true,
    Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();

  for (final Node node in nodes) {
    try {
      final Provider provider = Provider.fromUri(parseNodeUrl(node.url));
      final Gdev polkadot = Gdev(provider);

      final T result =
          await operation(node, provider, polkadot).timeout(timeout);
      return result; // If the operation is successful, return the result
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.endpoint, node);
      loggerDev('Error in node ${node.url}', error: e, stackTrace: stacktrace);
      if (!retry) {
        rethrow;
      }
    }
  }

  throw Exception(
      'All nodes failed to execute the operation'); // If all nodes fail, throw an exception
}

Future<IdtyValue?> polkadotIdentity(Contact contact) async {
  return executeOnPolkadotNodes<IdtyValue?>(
      (Node node, Provider provider, Gdev polkadot) async {
    if (contact.index == null) {
      return null;
    }
    return polkadot.query.identity.identities(contact.index!);
  });
}

Future<int> polkadotCurrentBlock() async {
  return executeOnPolkadotNodes<int>(
      (Node node, Provider provider, Gdev polkadot) async {
    return polkadot.query.system.number();
  });
}

Future<IdtyCertMeta?> polkadotIdtyCertMeta(Contact contact) async {
  return executeOnPolkadotNodes<IdtyCertMeta?>(
      (Node node, Provider provider, Gdev polkadot) async {
    if (contact.index == null) {
      return null;
    }
    return polkadot.query.certification.storageIdtyCertMeta(contact.index!);
  });
}

Future<BigInt?> getBalanceV2(
    {required String address, Duration timeout = defPolkadotTimeout}) async {
  return executeOnPolkadotNodes<BigInt?>(
      (Node node, Provider provider, Gdev polkadot) async {
    final Address account = Address.decode(address);
    final Uint8List pubkey = account.pubkey;
    final AccountInfo accountInfo =
        await polkadot.query.system.account(pubkey).timeout(timeout);
    loggerDev(
        'Fetching balance for $address in node ${node.url} gives ${accountInfo.data.free}');
    return accountInfo.data.free;
  });
}

Future<tp.Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalanceV2(
    String pubKeyRaw,
    {int? pageSize = 10,
    int? from,
    int? to,
    String? cursor,
    required bool isConnected}) async {
  final String address = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  final BigInt? balance = await getBalanceV2(address: address);

  if (balance == null) {
    throw Exception('Error fetching balance for $pubKeyRaw/$address');
  }

  loggerDev('Fetching balance for $pubKeyRaw/$address gives $balance');

  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    try {
      // Force for testing
      // node = Node(url: 'https://squid.polkadot.coinduf.eu/v1/graphql');
      final ferry.Client client =
          await initDuniterIndexerClient(node.url, GetIt.instance<HiveStore>());

      loggerDev('Fetching history for $pubKeyRaw/$address in node ${node.url}');

      final GAccountTransactionsReq request =
          GAccountTransactionsReq((GAccountTransactionsReqBuilder b) => b
            ..fetchPolicy =
                isConnected ? FetchPolicy.NetworkOnly : FetchPolicy.CacheFirst
            ..vars.accountId = address
            ..vars.limit = pageSize
            ..vars.offset = int.parse(cursor ?? '0'));

      final ferry
          .OperationResponse<GAccountTransactionsData, GAccountTransactionsVars>
          response = await client.request(request).first;

      if (response.hasErrors) {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node);
        loggerDev(
            'Error fetching data: ${response.graphqlErrors} for $pubKeyRaw/$address in node ${node.url}',
            error: response.graphqlErrors);
        throw Exception('Error fetching data: ${response.graphqlErrors}');
      }

      final Map<String, dynamic>? data = response.data?.toJson();
      if (data != null) {
        data['balance'] = balance;
      }
      loggerDev('Fetched history for $pubKeyRaw/$address in node ${node.url}');
      return tp.Tuple2<Map<String, dynamic>?, Node>(data, node);
    } catch (e, stackTrace) {
      loggerDev(
          'Error fetching history for$pubKeyRaw/$address in node ${node.url}',
          error: e,
          stackTrace: stackTrace);
    }
  }
  return const tp.Tuple2<Map<String, dynamic>?, Node>(null, Node(url: ''));
}

String addressFromV1PubkeyFaiSafe(String pubKeyRaw) {
  try {
    return addressFromV1Pubkey(extractPublicKey(pubKeyRaw));
  } catch (e) {
    loggerDev('Error converting pubkey $pubKeyRaw to address: $e');
    rethrow;
  }
}

Uri parseNodeUrl(String url) {
  final Uri parsedUri = Uri.parse(url);
  return parsedUri;
}

Future<SignAndSendResult> requestDistanceEvaluation(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  return executeOnPolkadotNodes<SignAndSendResult>(
      (Node node, Provider provider, Gdev polkadot) async {
    // distance rule has been evaluated positively locally on web of trust at block storage.distance.evaluationBlock()
    // TODO(vjrj): Implement this
    // polkadot.query.distance.evaluationBlock();
    // Error to show too:
    // Distance already in evaluation
    final RuntimeCall call =
        polkadot.tx.distance.requestDistanceEvaluationFor(target: idtyIndex);
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}

Future<SignAndSendResult> createIdentity(
    {required Contact you, Duration timeout = defPolkadotTimeout}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call = polkadot.tx.identity.createIdentity(
      ownerKey: Address.decode(you.address).pubkey,
    );
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}

Future<SignAndSendResult> confirmIdentity(String identityName,
    {Duration timeout = defPolkadotTimeout}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call =
        polkadot.tx.identity.confirmIdentity(idtyName: identityName.codeUnits);
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}

Future<SignAndSendResult> certify(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call =
        polkadot.tx.certification.addCert(receiver: idtyIndex);
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}

Constants polkadotConstants() {
  final Provider provider =
      Provider.fromUri(parseNodeUrl(NodeManager().endpointNodes.first.url));
  final Gdev polkadot = Gdev(provider);
  return polkadot.constant;
}

Future<PayResult> payV2({
  required List<String> to,
  required double amount,
  String? comment,
}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);

  final List<String> addresses = <String>[];
  final StreamController<String> progressController =
      StreamController<String>();

  for (final String dest in to) {
    try {
      addresses.add(addressFromV1PubkeyFaiSafe(dest));
    } catch (e) {
      progressController
          .add(tr('Error converting pubkey $dest to address: $e'));
      progressController.close();
      return PayResult(
        message: tr('Error converting pubkey $dest to address: $e'),
        progressStream: progressController.stream,
      );
    }
  }
  return executeOnPolkadotNodes(retry: false,
      (Node node, Provider provider, Gdev polkadot) async {
    final bool useBatch = addresses.length > 1;
    final RuntimeCall transferCall = useBatch
        ? polkadot.tx.utility.batch(
            calls: addresses.map((String address) {
              final Id multiAddress =
                  const $MultiAddress().id(Address.decode(address).pubkey);
              final RuntimeCall transferCall = polkadot.tx.balances
                  .transferKeepAlive(
                      dest: multiAddress, value: BigInt.from(amount * 100));
              return transferCall;
            }).toList(),
          )
        : polkadot.tx.balances.transferKeepAlive(
            dest: const $MultiAddress()
                .id(Address.decode(addresses.first).pubkey),
            value: BigInt.from(amount * 100));

    final SignAndSendResult result = await signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      transferCall,
      messageTransformer: _paymentResultTransformer,
    );

    return PayResult(
      node: result.node,
      progressStream: result.progressStream,
      message: '',
    );
  });
}

String _paymentResultTransformer(String statusType) {
  return _resultTransformer('tx', statusType, 'payment_successful');
}

String _defaultResultTransformer(String statusType) {
  return _resultTransformer('op', statusType, 'op_successful');
}

String _resultTransformer(String suffix, String statusType, String success) {
  return <String, String>{
        'finalized': tr(success),
        'ready': tr('${suffix}_ready'),
        'inBlock': tr('${suffix}_in_block'),
        'broadcast': tr('${suffix}_broadcast'),
        'dropped': tr('${suffix}_dropped'),
        'invalid': tr('${suffix}_invalid'),
        'usurped': tr('${suffix}_usurped'),
        'future': tr('${suffix}_processing'),
      }[statusType] ??
      tr('${suffix}_processing');
}

Future<SignAndSendResult> renew(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = KeyPair.ed25519
      .fromSeed((await SharedPreferencesHelper().getWallet()).seed);
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call =
        polkadot.tx.certification.renewCert(receiver: idtyIndex);
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}

Future<SignAndSendResult> revoke(
    int idtyIndex, List<int> revocationKey, MultiSignature revocationSig,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = KeyPair.ed25519
      .fromSeed((await SharedPreferencesHelper().getWallet()).seed);
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call = polkadot.tx.identity.revokeIdentity(
        idtyIndex: idtyIndex,
        revocationKey: revocationKey,
        revocationSig: revocationSig);
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  });
}
