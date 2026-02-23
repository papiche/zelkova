import 'dart:async' as sign_and_send;
import 'dart:typed_data';

import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import '../data/models/node.dart';
import '../generated/gtest/gtest.dart';
import '../generated/gtest/types/frame_system/event_record.dart'
    as system_event_record;
import '../generated/gtest/types/frame_system/pallet/event.dart'
    as system_event;
import '../generated/gtest/types/frame_system/phase.dart' as system_phase;
import '../generated/gtest/types/gtest_runtime/runtime_call.dart';
import '../generated/gtest/types/gtest_runtime/runtime_event.dart'
    as runtime_event;
import '../generated/gtest/types/primitive_types/h256.dart';
import '../generated/gtest/types/sp_runtime/dispatch_error.dart' as sp_runtime;
import '../ui/logger.dart';
import 'duniter_endpoint_helper.dart';

class SignAndSendResult {
  SignAndSendResult({
    this.node,
    required this.progressStream,
    this.cancelled = false,
  });

  final Node? node;
  final Stream<String> progressStream;
  final bool cancelled;
}

Future<SignAndSendResult> signAndSend(Node node, Provider provider,
    Gtest polkadot, KeyPair wallet, RuntimeCall call,
    {required String Function(String statusType) messageTransformer,
    Duration timeout = defPolkadotTimeout}) async {
  final sign_and_send.StreamController<String> progressController =
      sign_and_send.StreamController<String>();

  bool disconnected = false;
  bool progressClosed = false;

  Future<void> safeCloseProgress() async {
    if (!progressClosed) {
      progressClosed = true;
      try {
        await progressController.close();
      } catch (e) {
        loggerDev('Error closing progressController: $e');
      }
    }
  }

  Future<void> safeDisconnect() async {
    if (!disconnected) {
      disconnected = true;
      try {
        // Small delay to let any in-flight WebSocket frames drain before
        // closing the subscription controllers. This prevents the
        // "Cannot add new events after calling close" uncaught zone error
        // that polkadart throws when buffered messages arrive after disconnect.
        await Future<void>.delayed(const Duration(milliseconds: 300));
        await provider.disconnect();
      } catch (e) {
        loggerDev('Error during safeDisconnect: $e');
      }
    }
  }

  // Use runZonedGuarded to absorb any uncaught zone errors thrown by
  // polkadart's internal WebSocket listener after we close subscriptions.
  sign_and_send.runZonedGuarded(() async {
    try {
      loggerDev('signAndSend: Starting transaction for ${wallet.address}');
      progressController.add(messageTransformer('building_transaction'));

      loggerDev('signAndSend: Getting runtime version');
      final RuntimeVersion runtimeVersion =
          await polkadot.rpc.state.getRuntimeVersion();
      loggerDev('signAndSend: Getting current block number');
      final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
      loggerDev('signAndSend: Current block number: $currentBlockNumber');
      final H256 currentBlockHash =
          await polkadot.query.system.blockHash(currentBlockNumber);
      loggerDev('signAndSend: Getting nonce for ${wallet.address}');
      final int nonce =
          await polkadot.rpc.system.accountNextIndex(wallet.address);
      loggerDev('signAndSend: Nonce: $nonce');
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

      loggerDev('signAndSend: Signing payload');
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

      loggerDev('signAndSend: Submitting transaction');
      progressController.add(messageTransformer('submitting_transaction'));

      await author.submitAndWatchExtrinsic(
        extrinsic,
        (ExtrinsicStatus status) async {
          loggerDev('signAndSend: Received status: ${status.type}');
          if (progressClosed) {
            loggerDev(
                'signAndSend: Progress already closed, skipping status ${status.type}');
            return;
          }

          final String transformedMessage = messageTransformer(status.type);
          progressController.add(transformedMessage);

          if (status.type == 'finalized' || status.type == 'inBlock') {
            final String? blockHash = status.value as String?;
            loggerDev(
                'signAndSend: Transaction ${status.type} in block: $blockHash');
            if (blockHash != null) {
              final String? errorKey = await _checkExtrinsicSuccess(
                  provider, polkadot, blockHash, extrinsic);
              if (errorKey != null) {
                loggerDev(
                    'signAndSend: Extrinsic failed with error: $errorKey');
                if (!progressClosed) {
                  progressController.addError(messageTransformer(errorKey));
                }
                await safeCloseProgress();
                await safeDisconnect();
                return;
              }
            }
          }

          if (<String>[
            'finalized',
            'dropped',
            'invalid',
            'usurped',
          ].contains(status.type)) {
            loggerDev('signAndSend: Final status reached: ${status.type}');
            await safeCloseProgress();
            await safeDisconnect();
          }
        },
      ).timeout(timeout, onTimeout: () {
        loggerDev('signAndSend: Timeout waiting for transaction confirmation');
        throw sign_and_send.TimeoutException(
            'Transaction confirmation timeout', timeout);
      });
    } catch (e, stacktrace) {
      final String errorMessage = messageTransformer('error');
      loggerDev('signAndSend: Error occurred',
          error: e, stackTrace: stacktrace);
      if (!progressClosed) {
        progressController.addError(errorMessage);
      }
      await safeCloseProgress();
      await safeDisconnect();
    }
  }, (Object error, StackTrace stack) {
    // Absorb uncaught zone errors from polkadart's internal WebSocket listener,
    // especially "Cannot add new events after calling close" which fires when
    // buffered WebSocket messages arrive after we've already disconnected.
    loggerDev('Absorbed polkadart zone error: $error');
    // Ensure the dialog closes even if we get a zone error
    if (!progressClosed) {
      safeCloseProgress();
    }
  });

  return SignAndSendResult(
    node: node,
    progressStream: progressController.stream,
  );
}

Future<String?> _checkExtrinsicSuccess(Provider provider, Gtest polkadot,
    String blockHash, Uint8List extrinsic) async {
  try {
    final Map<String, dynamic> blockRes =
        (await provider.send('chain_getBlock', <dynamic>[blockHash])).result
            as Map<String, dynamic>;
    final String extrinsicHex = '0x${encodeHex(extrinsic)}';
    final Map<String, dynamic> block =
        blockRes['block'] as Map<String, dynamic>;
    final List<Object?> extrinsics = block['extrinsics'] as List<Object?>;
    final int index = extrinsics.indexOf(extrinsicHex);

    if (index != -1) {
      final List<system_event_record.EventRecord> events =
          await polkadot.query.system.events(at: decodeHex(blockHash));
      for (final system_event_record.EventRecord event in events) {
        if (event.phase is system_phase.ApplyExtrinsic &&
            (event.phase as system_phase.ApplyExtrinsic).value0 == index) {
          final runtime_event.RuntimeEvent runtimeEvent = event.event;
          if (runtimeEvent is runtime_event.System) {
            final system_event.Event systemEvent = runtimeEvent.value0;
            if (systemEvent is system_event.ExtrinsicFailed) {
              final sp_runtime.DispatchError dispatchError =
                  systemEvent.dispatchError;
              loggerDev(
                  'Extrinsic failed with DispatchError: ${dispatchError.toJson()}');
              return 'extrinsic_failed';
            }
          }
        }
      }
    }
  } catch (e) {
    loggerDev('Error checking extrinsic success', error: e);
  }
  return null;
}
