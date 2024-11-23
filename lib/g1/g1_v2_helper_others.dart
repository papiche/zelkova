import 'dart:typed_data';

import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:durt/durt.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:pointycastle/export.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ss58/ss58.dart';
import 'package:tuple/tuple.dart' as tp;

import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../generated/gdev/gdev.dart';
import '../generated/gdev/types/frame_system/account_info.dart';
import '../generated/gdev/types/gdev_runtime/runtime_call.dart';
import '../generated/gdev/types/primitive_types/h256.dart';
import '../generated/gdev/types/sp_runtime/multiaddress/multi_address.dart';
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'api.dart';
import 'g1_helper.dart';

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

class AuthDataV1 {
  AuthDataV1(this.password, this.salt);

  String password;
  String salt;
}

class AuthDataV2 {
  AuthDataV2(this.mnemonic, this.meta);

  String mnemonic;
  String meta;
}

class AuthData {
  AuthData({this.v1, this.v2});

  AuthDataV1? v1;
  AuthDataV2? v2;
}

Future<KeyPair> createPair(AuthData data, Keyring keyring) async {
  if (data.v1 != null) {
    final List<int> password = data.v1!.password.codeUnits;
    final String salt = data.v1!.salt;
    final Uint8List passwordU8a = Uint8List.fromList(password);
    final Uint8List saltU8a = Uint8List.fromList(salt.codeUnits);
    final Scrypt scrypt = Scrypt()
      ..init(ScryptParameters(4096, 16, 1, 32, saltU8a));
    final Uint8List seedBytes = scrypt.process(passwordU8a);
    final String seedHex = Base58Encode(seedBytes);
    final KeyPair keyPair = await keyring.fromUri(seedHex,
        password: data.v1!.password, keyPairType: KeyPairType.ed25519);
    return keyPair;
  } else if (data.v2 != null) {
    final KeyPair keyPair = await keyring.fromUri(data.v2!.mnemonic,
        password: data.v2!.meta, keyPairType: KeyPairType.sr25519);
    return keyPair;
  } else {
    throw Exception('Data format not recognized');
  }
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
  final String mnemonic = generateMnemonic(lang: lang);
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
/*
Future<Map<String, dynamic>> createAccount(
    AuthData data, Keyring keyring) async {
  final KeyPair pair = await createPair(data, keyring);
  final String? publicKeyV1 = pair.keyPairType == KeyPairType.ed25519
      ? Base58Encode(pair.publicKey.bytes)
      : null;

  final String name = data.v2?.meta ??
      (publicKeyV1 != null
          ? formatPubkey(publicKeyV1)
          : formatAddress(pair.address));


  Map<String, dynamic> accountMeta = {
    'name': name,
    'publicKeyV1': publicKeyV1,
    'genesisHash':
    ...data.v2?.meta ?? {}
  };

  Account account = Account(pair.address, pair.publicKey, accountMeta);
  pair.setMeta(account.meta);

  return {'pair': pair, 'account': account};
}

String formatAddress(String value) {
  if (value.isEmpty) {
    return '';
  }
  if (value.length < 12) {
    return '?';
  }
  return '${value.substring(0, 6)}\u2026${value.substring(value.length - 6)}';
}

String formatPubkey(String value) {
  if (value.isEmpty) {
    return '';
  }
  if (value.length < 12) {
    return '?';
  }
  return '${value.substring(0, 4)}\u2026${value.substring(value.length - 4)}';
}
*/

Future<RpcResponse<dynamic, dynamic>?> queryPolkadartNode({
  required String nodeUri,
  required String queryMethod,
  required List<dynamic> params,
  required Duration timeout,
}) async {
  try {
    final Provider polkadot = Provider.fromUri(Uri.parse(nodeUri));
    final RpcResponse<dynamic, dynamic> response =
        await polkadot.send(queryMethod, params).timeout(timeout);
    // await polkadot.disconnect();
    return response;
  } catch (e) {
    loggerDev(
        'Error querying polkadot method $queryMethod node $nodeUri with error: ${removeNewlines(e.toString())}');
    return null;
  }
}

Future<BigInt?> getBalanceV2(
    {required String address, Duration timeout = defPolkadotTimeout}) async {
  for (final Node node in NodeManager().getBestNodes(NodeType.endpoint)) {
    try {
      final Address account = Address.decode(address);
      final Provider polkadot = Provider.fromUri(ensurePortInWsUrl(node.url));
      final AccountInfo accountInfo = await Gdev(polkadot)
          .query
          .system
          .account(account.pubkey)
          .timeout(timeout);
      return accountInfo.data.free;
    } catch (e, stacktrace) {
      loggerDev(
          'Error fetching balance for $address in node ${node.url}: $e $stacktrace');
    }
    continue;
  }
  return null;
}

Future<tp.Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalanceV2(
  String pubKeyRaw, {
  int? pageSize = 10,
  int? from,
  int? to,
  String? cursor,
}) async {
  final String address = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  final BigInt? balance = await getBalanceV2(address: address);

  if (balance == null) {
    throw Exception('Error fetching balance for $address');
  }

  loggerDev('Fetching history and balance for $address gives balance $balance');

  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    try {
      final ferry.Client client =
          await initDuniterIndexerClient(node.url, GetIt.instance<HiveStore>());

      loggerDev('Fetching history for $address in node ${node.url}');

      final GGetHistoryAndBalanceReq request =
          GGetHistoryAndBalanceReq((GGetHistoryAndBalanceReqBuilder b) => b
            ..vars.accountId = address
            ..vars.limit = pageSize
            ..vars.offset = cursor != null ? int.parse(cursor) : 0);

      final ferry.OperationResponse<GGetHistoryAndBalanceData,
              GGetHistoryAndBalanceVars> response =
          await client.request(request).first;

      if (response.hasErrors) {
        throw Exception('Error fetching data: ${response.graphqlErrors}');
      }

      final Map<String, dynamic>? data = response.data?.toJson();
      if (data != null) {
        data['balance'] = balance;
      }
      return tp.Tuple2<Map<String, dynamic>?, Node>(data, node);
    } catch (e, stackTrace) {
      loggerDev(
          'Error fetching history for $address in node ${node.url}: $e, $stackTrace');
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

Future<PayResult> payV2({
  required List<String> to,
  required double amount,
  String? comment,
}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();

  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);

  final String from = addressFromV1Pubkey(walletV1.pubkey);
  final List<String> addresses = <String>[];
  for (final String dest in to) {
    try {
      addresses.add(addressFromV1PubkeyFaiSafe(dest));
    } catch (e) {
      loggerDev('Error converting pubkey $dest to address: $e');
      rethrow;
    }
  }

  for (final Node node in NodeManager().getBestNodes(NodeType.endpoint)) {
    try {
      loggerDev(
          'Starting payment from $from to ${addresses.join(', ')} for a total of $amount');

      final Provider provider = Provider.fromUri(ensurePortInWsUrl(node.url));
      final Gdev polkadot = Gdev(provider);

      // From: https://polkadart.dev/guides/make-transfer/
      // Get information necessary to build a proper extrinsic
      final RuntimeVersion runtimeVersion =
          await polkadot.rpc.state.getRuntimeVersion();
      final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
      final H256 currentBlockHash =
          await polkadot.query.system.blockHash(currentBlockNumber);
      final H256 genesisHash = await polkadot.query.system.blockHash(0);
      final int nonce =
          await polkadot.rpc.system.accountNextIndex(wallet.address);

      // Make the encoded call
      final Id multiAddress =
          const $MultiAddress().id(Address.decode(addresses.first).pubkey);
      final RuntimeCall transferCall = polkadot.tx.balances
          .transferKeepAlive(dest: multiAddress, value: BigInt.from(amount));
      final Uint8List encodedCall = transferCall.encode();

      // Make the payload
      final Uint8List payload = SigningPayload(
              method: encodedCall,
              specVersion: runtimeVersion.specVersion,
              transactionVersion: runtimeVersion.transactionVersion,
              genesisHash: encodeHex(genesisHash),
              blockHash: encodeHex(currentBlockHash),
              blockNumber: currentBlockNumber,
              eraPeriod: 64,
              nonce: nonce,
              tip: 0)
          .encode(polkadot.registry);

      // Sign the payload and build the final extrinsic
      final Uint8List signature = wallet.sign(payload);
      final Uint8List extrinsic = ExtrinsicPayload(
        signer: wallet.bytes(),
        method: encodedCall,
        signature: signature,
        eraPeriod: 64,
        blockNumber: currentBlockNumber,
        nonce: nonce,
        tip: 0,
      ).encode(polkadot.registry, SignatureType.ed25519);

      // Send the extrinsic to the blockchain
      final AuthorApi<Provider> author = AuthorApi<Provider>(provider);
      await author.submitAndWatchExtrinsic(extrinsic, (ExtrinsicStatus data) {
        loggerDev(
            ' ===========================================  ${data.type} ${data.value}');
      });

      loggerDev(
          'Payment of $amount successful to addresses: ${addresses.join(', ')}');
      // pay_helper is expecting this to be success
      return PayResult(
        message: 'success',
        node: node,
      );
    } catch (e) {
      loggerDev(
          'Error in payment for ${addresses.join(', ')} in node ${node.url}: $e');
    }
  }

  return PayResult(
    message: 'Payment failed on all available nodes.',
  );
}

Uri ensurePortInWsUrl(String url) {
  final Uri parsedUri = Uri.parse(url);
  return parsedUri;

  /*
  if (parsedUri.scheme == 'wss') {
    return Uri(
      scheme: 'wss', // Force this
      host: parsedUri.host,
      port: parsedUri.hasPort ? parsedUri.port : 443,
      path: parsedUri.path,
    );
  }

  throw Exception('Unsupported scheme: ${parsedUri.scheme}'); */
}
