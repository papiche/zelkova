import 'dart:async';
import 'dart:typed_data';

import 'package:fast_base58/fast_base58.dart';
import 'package:polkadot_dart/polkadot_dart.dart';
import 'package:ss58/ss58.dart';

import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_helper.dart';
import 'polkadot_provider.dart';

bool isValidV2AddressMulti(String address) {
  try {
    SubstrateAddress(address);
    return true;
  } catch (error) {
    return false;
  }
}

String encodeAddress(List<int> key, [int ss58Format = 42]) {
  return Address(prefix: ss58Format, pubkey: Uint8List.fromList(key)).encode();
}

String addressFromV1PubkeyMulti(String pubkeyRaw) {
  final String pubkey = extractPublicKey(pubkeyRaw);
  final List<int> pubkeyBytes = Base58Decode(pubkey);
  final String address = encodeAddress(Uint8List.fromList(pubkeyBytes));
  return address;
}

String v1pubkeyFromAddressMulti(String address) {
  final SubstrateAddress subAddress = SubstrateAddress(address);
  return Base58Encode(subAddress.toBytes());
}

/* Example
/// Creating a provider with custom Substrate HTTP service.
final SubstrateRPC provider =
    SubstrateRPC(MySubstrateHttpService("https://westend-rpc.polkadot.io"));

/// Retrieving genesis hash from the blockchain.
final String? genesisHash =
    await provider.request(const SubstrateRPCChainGetBlockHash(number: 0));

/// Retrieving finalized block hash from the blockchain.
final String blockHash =
    await provider.request(const SubstrateRPCChainChainGetFinalizedHead());

/// Retrieving block header using the block hash.
final SubstrateHeaderResponse blockHeader = await provider
    .request(SubstrateRPCChainChainGetHeader(atBlockHash: blockHash));
*/

/*
final wsProvider = WsProvider(Uri.parse('wss://rpc.polkadot.io'));

await wsProvider.connect();

// Para realizar una solicitud RPC normal
final result = await wsProvider.send('chain_getBlockHash', [0]);

// Para suscribirse a eventos, como nuevos bloques
final blockStream = await wsProvider.subscribe('chain_subscribeNewHeads', []);
blockStream.listen((data) {
  print('New block header: $data');
});
*/

Future<Map<String, dynamic>?> queryPolkadotNode({
  required String nodeUri,
  required String queryMethod,
  required String params,
  required Duration timeout,
}) async {
  try {
    final PolkaDotProvider wsProvider = PolkaDotProvider(Uri.parse(nodeUri));

    final Map<String, dynamic> response =
        await wsProvider.send(queryMethod, params).timeout(timeout);

    await wsProvider.disconnect();

    return response;
  } catch (e) {
    loggerDev(
        'Error querying polkadot method $queryMethod node $nodeUri with error: ${removeNewlines(e.toString())}');
    return null;
  }
}
