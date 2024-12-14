import 'dart:async';
import 'dart:typed_data';

import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_base58/fast_base58.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry/ferry.dart';
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
import 'g1_helper.dart';
import 'pay_result.dart';

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

Future<BigInt?> getBalanceV2(
    {required String address, Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();
  for (final Node node in nodes) {
    try {
      final Address account = Address.decode(address);
      final Provider polkadot = Provider.fromUri(parseNodeUrl(node.url));
      final Uint8List pubkey = account.pubkey;
      final AccountInfo accountInfo =
          await Gdev(polkadot).query.system.account(pubkey).timeout(timeout);
      return accountInfo.data.free;
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.endpoint, node);
      loggerDev('Error fetching balance for $address in node ${node.url}',
          error: e, stackTrace: stacktrace);
    }
    continue;
  }
  return null;
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
      // node = Node(url: 'https://squid.gdev.coinduf.eu/v1/graphql');
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

Future<PayResult> payV2({
  required List<String> to,
  required double amount,
  String? comment,
}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);

  // final String from = addressFromV1Pubkey(walletV1.pubkey);
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

  final List<Node> n = NodeManager().getBestNodes(NodeType.endpoint);
  n.shuffle();
  final Node node = n.first;

  final PayResult result = PayResult(
    message: tr('tx_processing'),
    node: node,
    progressStream: progressController.stream,
  );

  try {
    if (inDevelopment) {
      progressController.add('Connecting to node ${node.url}...');
    }

    final Provider provider = Provider.fromUri(parseNodeUrl(node.url));
    final Gdev polkadot = Gdev(provider);

    final RuntimeVersion runtimeVersion =
        await polkadot.rpc.state.getRuntimeVersion();
    final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
    final H256 currentBlockHash =
        await polkadot.query.system.blockHash(currentBlockNumber);
    final H256 genesisHash = await polkadot.query.system.blockHash(0);
    final int nonce =
        await polkadot.rpc.system.accountNextIndex(wallet.address);

    if (inDevelopment) {
      progressController.add('Building transaction...');
    }

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
    final Uint8List encodedCall = transferCall.encode();

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

    progressController.add(tr('Submitting transaction...'));

    final AuthorApi<Provider> author = AuthorApi<Provider>(provider);

    await author.submitAndWatchExtrinsic(
      extrinsic,
      (ExtrinsicStatus data) {
        switch (data.type) {
          case 'finalized':
            progressController.add(tr('payment_successful'));
            progressController.close();
            break;

          case 'dropped':
            progressController.add(tr('tx_dropped'));
            progressController.close();
            break;
          case 'invalid':
            progressController.add(tr('tx_invalid'));
            progressController.close();
            break;
          case 'usurped':
            progressController.add(tr('tx_usurped'));
            progressController.close();
            break;
          case 'future':
            progressController.add(tr('tx_processing'));
            break;
          case 'ready':
            progressController.add(tr('tx_ready'));
            break;
          case 'inBlock':
            progressController.add(tr('tx_in_block'));
            break;
          case 'broadcast':
            progressController.add(tr('tx_broadcast'));
            break;
          default:
            progressController
                .add('Unexpected transaction status: ${data.type}.');
            loggerDev('Unexpected transaction status: ${data.type}.');
            break;
        }
      },
    );
  } catch (e) {
    progressController.add(tr('Error in payment on node ${node.url}: $e'));
    progressController.close();
  }

  return result;
}

Uri parseNodeUrl(String url) {
  final Uri parsedUri = Uri.parse(url);
  return parsedUri;
}
