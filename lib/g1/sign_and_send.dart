import 'dart:async' as sign_and_send;
import 'dart:typed_data';

import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../data/models/node.dart';
import '../generated/gtest/gtest.dart';
import '../generated/gtest/types/gtest_runtime/runtime_call.dart';
import '../generated/gtest/types/primitive_types/h256.dart';
import '../ui/logger.dart';
import 'duniter_endpoint_helper.dart';

class SignAndSendResult {
  SignAndSendResult({
    this.node,
    required this.progressStream,
  });

  final Node? node;
  final Stream<String> progressStream;
}

Future<SignAndSendResult> signAndSend(Node node, Provider provider,
    Gtest polkadot, KeyPair wallet, RuntimeCall call,
    {required String Function(String statusType) messageTransformer,
    Duration timeout = defPolkadotTimeout}) async {
  final sign_and_send.StreamController<String> progressController =
      sign_and_send.StreamController<String>();

  try {
    progressController.add(messageTransformer('building_transaction'));

    final RuntimeVersion runtimeVersion =
        await polkadot.rpc.state.getRuntimeVersion();
    final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
    final H256 currentBlockHash =
        await polkadot.query.system.blockHash(currentBlockNumber);
    final int nonce =
        await polkadot.rpc.system.accountNextIndex(wallet.address);
    final H256 genesisHash = await polkadot.query.system.blockHash(0);

    final Uint8List encodedCall = call.encode();

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
            tip: 0)
        .encode(polkadot.registry, SignatureType.ed25519);

    final AuthorApi<Provider> author = AuthorApi<Provider>(provider);

    progressController.add(messageTransformer('submitting_transaction'));

    await author.submitAndWatchExtrinsic(
      extrinsic,
      (ExtrinsicStatus status) {
        final String transformedMessage = messageTransformer(status.type);
        progressController.add(transformedMessage);

        if (<String>[
          'finalized',
          'dropped',
          'invalid',
          'usurped',
        ].contains(status.type)) {
          progressController.close();
        }
      },
    ).timeout(timeout);
  } catch (e, stacktrace) {
    final String errorMessage = messageTransformer('error');
    progressController.addError(errorMessage);
    loggerDev(errorMessage, error: e, stackTrace: stacktrace);
    progressController.close();
  }

  return SignAndSendResult(
    node: node,
    progressStream: progressController.stream,
  );
}
