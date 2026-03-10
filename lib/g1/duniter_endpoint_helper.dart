import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/provider.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ss58/ss58.dart';

import '../data/models/contact.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../data/models/stored_account.dart';
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import 'g1_v2_helper.dart';
import 'network_types.dart' as tuples;
import 'network_types.dart';
import 'node_check_result.dart';
import 'pay_result.dart';
import 'sign_and_send.dart';

const Duration defPolkadotTimeout = Duration(seconds: 20);

Future<NodeCheckResult> testEndPointV2(String node,
    [Duration timeout = defPolkadotTimeout]) async {
  final Stopwatch stopwatch = Stopwatch()..start();

  final Uri uri = parseNodeUrl(node);
  final Provider provider;
  if (uri.scheme == 'ws' || uri.scheme == 'wss') {
    provider = WsProvider(uri, autoConnect: false);
  } else {
    provider = Provider.fromUri(uri);
  }

  try {
    // Neutralize orphaned future to prevent uncaught state errors after timeout
    await provider.connect().catchError((Object e) {
      // loggerDev('Handled orphaned connection error in testEndPointV2: $e');
    }).timeout(timeout);

    final Gtest polkadot = Gtest(provider);
    final int currentBlockNumber =
        await polkadot.query.system.number().timeout(timeout) - 1;

    // Retrieve genesis hash (block 0)
    final H256 genesisHashH256 =
        await polkadot.query.system.blockHash(0).timeout(timeout);
    final String genesisHash = genesisHashH256
        .map((int byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();

    stopwatch.stop();
    final NodeCheckResult nodeCheckResult = NodeCheckResult(
        latency: stopwatch.elapsed,
        currentBlock: currentBlockNumber,
        genesisHash: genesisHash);
    return nodeCheckResult;
  } catch (e) {
    loggerDev('⚠ testEndPointV2 failed for $node: $e');
    rethrow;
  } finally {
    try {
      await provider.disconnect();
    } catch (_) {}
  }
}

Uri parseNodeUrl(String url) {
  final Uri parsedUri = Uri.parse(url);
  return parsedUri;
}

Future<T> executeOnPolkadotNodes<T>(
    Future<T> Function(Node node, Provider provider, Gtest polkadot) operation,
    {bool retry = true,
    Duration timeout = defPolkadotTimeout,
    // Set to false for operations that return a SignAndSendResult whose stream
    // keeps the provider alive via signAndSend's own safeDisconnect callback.
    // If true (default), the provider is disconnected in the finally block.
    bool disconnectAfter = true}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  loggerDev('executeOnPolkadotNodes: Trying ${nodes.length} nodes');
  Exception? lastError;

  for (int i = 0; i < nodes.length; i++) {
    final Node node = nodes[i];
    final int nodesLeft = nodes.length - i;
    loggerDev('executeOnPolkadotNode: ${node.url} ($nodesLeft remaining)');
    final Uri uri = parseNodeUrl(node.url);
    final Provider provider;
    if (uri.scheme == 'ws' || uri.scheme == 'wss') {
      provider = WsProvider(uri, autoConnect: false);
    } else {
      provider = Provider.fromUri(uri);
    }

    try {
      // Neutralize orphaned future to prevent uncaught state errors after timeout
      await provider.connect().catchError((Object e) {
        // Silently handle orphaned connection errors
      }).timeout(timeout);

      final Gtest polkadot = Gtest(provider);

      final T result =
          await operation(node, provider, polkadot).timeout(timeout);
      loggerDev('executeOnPolkadotNode: Success on ${node.url}');
      return result; // If the operation is successful, return the result
    } catch (e) {
      lastError = Exception(e.toString());
      NodeManager().increaseNodeErrors(NodeType.endpoint, node,
          cause: 'Endpoint operation failed: $e');
      loggerDev(
          'executeOnPolkadotNode: Failed - ${node.url}. Trying next node...',
          error: e);
      if (!retry) {
        loggerDev('executeOnPolkadotNode: Retry disabled, rethrowing error');
        rethrow;
      }
    } finally {
      // Only disconnect here for read-only operations. For signAndSend-based
      // operations (disconnectAfter: false) the provider must stay alive until
      // the stream closes and signAndSend calls its own safeDisconnect.
      if (disconnectAfter) {
        try {
          await provider.disconnect();
        } catch (_) {}
      }
    }
  }

  // Throw the last error if available, otherwise a generic message
  if (lastError != null) {
    loggerDev('executeOnPolkadotNodes: All nodes failed');
    throw lastError;
  }
  loggerDev('executeOnPolkadotNodes: All nodes failed with no error captured');
  throw Exception('All nodes failed to execute the operation: $operation');
}

Future<IdtyValue?> polkadotIdentity(Contact contact) async {
  return executeOnPolkadotNodes<IdtyValue?>(
      (Node node, Provider provider, Gtest polkadot) async {
    if (contact.index == null) {
      return null;
    }
    return polkadot.query.identity.identities(contact.index!);
  });
}

Future<int> polkadotCurrentBlock() async {
  return executeOnPolkadotNodes<int>(
      (Node node, Provider provider, Gtest polkadot) async {
    return polkadot.query.system.number();
  });
}

Future<IdtyCertMeta?> polkadotIdtyCertMeta(Contact contact) async {
  return executeOnPolkadotNodes<IdtyCertMeta?>(
      (Node node, Provider provider, Gtest polkadot) async {
    if (contact.index == null) {
      return null;
    }
    return polkadot.query.certification.storageIdtyCertMeta(contact.index!);
  });
}

Future<MembershipData?> polkadortMembershipData(Contact contact) async {
  return executeOnPolkadotNodes<MembershipData?>(
      (Node node, Provider provider, Gtest polkadot) async {
    if (contact.index == null) {
      return null;
    }
    return polkadot.query.membership.membership(contact.index!);
  });
}

@Deprecated('Use getHistoryAndBalanceV2 instead')
Future<BigInt?> getBalanceV2Deprecated(
    {required String address, Duration timeout = defPolkadotTimeout}) async {
  return executeOnPolkadotNodes<BigInt?>(
      (Node node, Provider provider, Gtest polkadot) async {
    final Address account = Address.decode(address);
    final Uint8List pubkey = account.pubkey;
    final AccountInfo accountInfo =
        await polkadot.query.system.account(pubkey).timeout(timeout);
    loggerDev(
        'Fetching balance for $address in node ${node.url} gives ${accountInfo.data.free}');
    return accountInfo.data.free;
  });
}

Future<SignAndSendResult> requestDistanceEvaluationFor(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes<SignAndSendResult>(
      (Node node, Provider provider, Gtest polkadot) async {
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
  }, disconnectAfter: false);
}

Future<SignAndSendResult> requestDistanceEvaluation(
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes<SignAndSendResult>(
      (Node node, Provider provider, Gtest polkadot) async {
    // distance rule has been evaluated positively locally on web of trust at block storage.distance.evaluationBlock()
    // TODO(vjrj): Implement this
    // polkadot.query.distance.evaluationBlock();
    // Error to show too:
    // Distance already in evaluation
    final RuntimeCall call = polkadot.tx.distance.requestDistanceEvaluation();
    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  }, disconnectAfter: false);
}

Future<SignAndSendResult> createIdentity(
    {required Contact you, Duration timeout = defPolkadotTimeout}) async {
  try {
    loggerDev('Starting createIdentity for: ${you.address}');
    final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
    loggerDev('Wallet (signer): ${wallet.address}');

    return await executeOnPolkadotNodes<SignAndSendResult>(
      (Node node, Provider provider, Gtest polkadot) async {
        loggerDev('createIdentity: Using node ${node.url}');
        try {
          // createIdentity creates identity for the account specified in ownerKey
          // you = the person whose identity we're creating (the owner of the new identity)
          // wallet = the person signing the transaction (who is creating the identity)
          final RuntimeCall call = polkadot.tx.identity
              .createIdentity(ownerKey: Address.decode(you.address).pubkey);
          loggerDev('RuntimeCall created for createIdentity');

          final SignAndSendResult result = await signAndSend(
            node,
            provider,
            polkadot,
            wallet,
            call,
            messageTransformer: _defaultResultTransformer,
          );
          loggerDev('createIdentity result received');
          return result;
        } catch (e, st) {
          loggerDev('Error in createIdentity operation',
              error: e, stackTrace: st);
          rethrow;
        }
      },
      timeout: timeout,
      disconnectAfter: false,
    );
  } catch (e, st) {
    loggerDev('Critical error in createIdentity', error: e, stackTrace: st);
    rethrow;
  }
}

Future<SignAndSendResult> confirmIdentity(String identityName,
    {Duration timeout = defPolkadotTimeout}) async {
  try {
    loggerDev('Starting confirmIdentity with name: $identityName');
    final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
    loggerDev('Wallet loaded: ${wallet.address}');

    return await executeOnPolkadotNodes<SignAndSendResult>(
      (Node node, Provider provider, Gtest polkadot) async {
        loggerDev('confirmIdentity: Using node ${node.url}');
        try {
          final Uint8List encodedName = utf8.encode(identityName);
          loggerDev(
              'Encoded identity name: $identityName (${encodedName.length} bytes)');

          final RuntimeCall call = polkadot.tx.identity.confirmIdentity(
            idtyName: encodedName,
          );
          loggerDev('RuntimeCall created for confirmIdentity');

          final SignAndSendResult result = await signAndSend(
            node,
            provider,
            polkadot,
            wallet,
            call,
            messageTransformer: _defaultResultTransformer,
          );
          loggerDev('confirmIdentity result received');
          return result;
        } catch (e, st) {
          loggerDev('Error in confirmIdentity operation',
              error: e, stackTrace: st);
          rethrow;
        }
      },
      timeout: timeout,
      disconnectAfter: false,
    );
  } catch (e, st) {
    loggerDev('Critical error in confirmIdentity', error: e, stackTrace: st);
    rethrow;
  }
}

Future<SignAndSendResult> certify(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
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
  }, disconnectAfter: false);
}

Constants polkadotConstants() {
  return Constants();
}

Future<PayResult> payV2({
  required List<String> to,
  required double amount,
  String? comment,
}) async {
  loggerDev(
      'payV2: Starting payment to ${to.length} recipient(s), amount: $amount');
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  loggerDev('payV2: Wallet address: ${wallet.address}');
  final List<String> addresses = <String>[];
  final StreamController<String> progressController =
      StreamController<String>();

  for (final String dest in to) {
    try {
      loggerDev('payV2: Converting pubkey to address: $dest');
      addresses.add(
          isValidV2Address(dest) ? dest : addressFromV1PubkeyFaiSafe(dest));
      loggerDev('payV2: Converted to address: ${addresses.last}');
    } catch (e) {
      loggerDev('payV2: Error converting pubkey $dest to address: $e');
      progressController
          .add(tr('Error converting pubkey $dest to address: $e'));
      progressController.close();
      return PayResult(
        message: tr('Error converting pubkey $dest to address: $e'),
        progressStream: progressController.stream,
      );
    }
  }
  loggerDev('payV2: Calling executeOnPolkadotNodes...');
  return executeOnPolkadotNodes(retry: false, disconnectAfter: false,
      (Node node, Provider provider, Gtest polkadot) async {
    loggerDev(
        'payV2: Inside executeOnPolkadotNodes callback for node ${node.url}');
    RuntimeCall transferCall;

    if (addresses.length > 1 || comment != null) {
      loggerDev(
          'payV2: Creating batch transaction (${addresses.length} addresses, comment: ${comment != null})');
      final List<RuntimeCall> batchCalls = <RuntimeCall>[];

      for (final String address in addresses) {
        final Id multiAddress =
            const $MultiAddress().id(Address.decode(address).pubkey);
        batchCalls.add(
          polkadot.tx.balances.transferKeepAlive(
            dest: multiAddress,
            value: BigInt.from((amount * 100).round()),
          ),
        );
      }
      if (comment != null && comment.isNotEmpty) {
        batchCalls.add(polkadot.tx.system
            .remarkWithEvent(remark: Uint8List.fromList(utf8.encode(comment))));
      }

      transferCall = polkadot.tx.utility.batch(calls: batchCalls);
      loggerDev(
          'payV2: Batch transaction created with ${batchCalls.length} calls');
    } else {
      // No comment, one receiver
      loggerDev('payV2: Creating simple transfer transaction');
      final Id multiAddress =
          const $MultiAddress().id(Address.decode(addresses.first).pubkey);
      transferCall = polkadot.tx.balances.transferKeepAlive(
        dest: multiAddress,
        value: BigInt.from(amount * 100),
      );
      loggerDev('payV2: Simple transfer transaction created');
    }

    loggerDev('payV2: Calling signAndSend...');
    final SignAndSendResult result = await signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      transferCall,
      messageTransformer: _paymentResultTransformer,
    );
    loggerDev('payV2: signAndSend completed');

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

String _batchResultTransformer(String statusType) {
  return _resultTransformer('op_batch', statusType, 'op_batch_successful');
}

String _transferIdentityResultTransformer(String statusType) {
  return _resultTransformer(
      'transfer_identity', statusType, 'transfer_identity_successful');
}

String _resultTransformer(String suffix, String statusType, String success) {
  final Map<String, String> messages = <String, String>{
    'finalized': tr(success),
    'ready': tr('${suffix}_ready'),
    'inBlock': tr('${suffix}_in_block'),
    'broadcast': tr('${suffix}_broadcast'),
    'dropped': tr('${suffix}_dropped'),
    'invalid': tr('op_invalid'),
    'usurped': tr('${suffix}_usurped'),
    'future': tr('${suffix}_processing'),
  };

  String result = messages[statusType] ?? tr('${suffix}_processing');

  if (statusType == 'future' || statusType == 'broadcast') {
    if (suffix == 'op_batch' || suffix == 'transfer_identity') {
      result += '\n${tr('op_batch_wait_hint')}';
    }
  }

  return result;
}

Future<SignAndSendResult> renew(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
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
  }, disconnectAfter: false);
}

Future<SignAndSendResult> renewCert(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
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
  }, disconnectAfter: false);
}

Future<SignAndSendResult> revokeIdentity(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
    final Uint8List pubkeyBytes = Address.decode(wallet.address).pubkey;
    final H256 genesisHashH256 = await polkadot.query.system.blockHash(0);
    final String genesisHashHex = genesisHashH256
        .map((int byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    final Uint8List genesisHash = hexToU8a(genesisHashHex);
    // Domain separation
    final List<int> prefix = 'revo'.codeUnits;
    final ByteData idtyIndexBytes = ByteData(4)
      ..setInt32(0, idtyIndex, Endian.little);

    final Uint8List messageToSign = Uint8List.fromList(<int>[
      ...prefix,
      ...genesisHash,
      ...idtyIndexBytes.buffer.asUint8List()
    ]);

    final Uint8List signatureBytes = wallet.sign(messageToSign);

    final RuntimeCall call = polkadot.tx.identity.revokeIdentity(
      idtyIndex: idtyIndex,
      revocationKey: pubkeyBytes,
      revocationSig: const $MultiSignature().ed25519(signatureBytes.toList()),
    );

    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      call,
      messageTransformer: _defaultResultTransformer,
    );
  }, disconnectAfter: false);
}

Future<SignAndSendResult> changeOwnerKey(String newOwnerAddress,
    {Duration timeout = defPolkadotTimeout, bool withBalance = true}) async {
  final KeyPair currentWallet = await SharedPreferencesHelper().getKeyPair();

  // Find the new owner account in stored accounts
  final StoredAccount? newOwnerAccount = _findAccountByAddress(newOwnerAddress);
  if (newOwnerAccount == null) {
    throw Exception(
        'The new owner address is not available in your accounts. Please add it first.');
  }

  // Get the keypair for the new owner account
  final KeyPair newOwnerWallet =
      await SharedPreferencesHelper().getKeyPair(null, newOwnerAccount);

  try {
    return await executeOnPolkadotNodes(
        (Node node, Provider provider, Gtest polkadot) async {
      // Get the current identity index from current wallet
      final Uint8List currentPubkeyBytes =
          Address.decode(currentWallet.address).pubkey;
      final int? idtyIndex =
          await polkadot.query.identity.identityIndexOf(currentPubkeyBytes);

      if (idtyIndex == null) {
        throw Exception('Current address has no identity to migrate.');
      }

      // Get the new owner's public key
      final String ss58Address = isValidV2Address(newOwnerAddress)
          ? newOwnerAddress
          : addressFromV1PubkeyFaiSafe(newOwnerAddress);
      final Uint8List newOwnerPubkeyBytes = Address.decode(ss58Address).pubkey;

      // Get genesis hash for the payload
      final H256 genesisHashH256 = await polkadot.query.system.blockHash(0);
      final String genesisHashHex = genesisHashH256
          .map((int byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join();
      final Uint8List genesisHash = hexToU8a(genesisHashHex);

      // Create the message that the NEW owner must sign
      // Payload = 'icok' + genesisHash + idtyIndex + oldPubkey
      final List<int> prefix = 'icok'.codeUnits;
      final ByteData idtyIndexBytes = ByteData(4)
        ..setInt32(0, idtyIndex, Endian.little);

      final Uint8List messageToSign = Uint8List.fromList(<int>[
        ...prefix,
        ...genesisHash,
        ...idtyIndexBytes.buffer.asUint8List(),
        ...currentWallet.publicKey.bytes
      ]);

      // Sign with the NEW owner's keypair
      final Uint8List signature = newOwnerWallet.sign(messageToSign);

      final RuntimeCall changeOwnerCall = polkadot.tx.identity.changeOwnerKey(
        newKey: newOwnerPubkeyBytes,
        newKeySig: const $MultiSignature().ed25519(signature.toList()),
      );

      // Build a batched transaction: claimUds + transferAll + changeOwnerKey.
      // Order matters for runtime 1100+: transferAll must run before changeOwnerKey.
      final List<RuntimeCall> calls = <RuntimeCall>[];

      // Claim unclaimed UDs before migrating (they would be lost otherwise)
      try {
        final IdtyValue? idtyValue =
            await polkadot.query.identity.identities(idtyIndex);
        if (idtyValue != null &&
            idtyValue.status.toString().contains('member')) {
          calls.add(polkadot.tx.universalDividend.claimUds());
        }
      } catch (e) {
        loggerDev('Warning: Could not check for unclaimed UDs', error: e);
      }

      // Transfer all balance to the new owner account
      if (withBalance) {
        final Id multiAddress =
            const $MultiAddress().id(Address.decode(newOwnerAddress).pubkey);
        calls.add(polkadot.tx.balances.transferAll(
          dest: multiAddress,
          keepAlive: false,
        ));
      }

      calls.add(changeOwnerCall);

      final RuntimeCall finalCall = calls.length > 1
          ? polkadot.tx.utility.batchAll(calls: calls)
          : calls.first;

      return signAndSend(
        node,
        provider,
        polkadot,
        currentWallet,
        finalCall,
        messageTransformer: _transferIdentityResultTransformer,
      );
    }, disconnectAfter: false);
  } catch (e) {
    // Create a SignAndSendResult with the error in the progress stream
    final StreamController<String> errorController = StreamController<String>();
    errorController.add(e.toString());
    errorController.close();
    return SignAndSendResult(progressStream: errorController.stream);
  }
}

// Helper function to find an account by address
StoredAccount? _findAccountByAddress(String address) {
  try {
    final List<StoredAccount> allAccounts = SharedPreferencesHelper().accounts;

    for (final StoredAccount account in allAccounts) {
      if (account.contact.address == address) {
        return account;
      }
    }
    return null;
  } catch (e) {
    loggerDev('Error checking for stored account', error: e);
    return null;
  }
}

Future<SignAndSendResult> transferAllWOT(String toAddress,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
    final String ss58Address = isValidV2Address(toAddress)
        ? toAddress
        : addressFromV1PubkeyFaiSafe(toAddress);
    final Id multiAddress =
        const $MultiAddress().id(Address.decode(ss58Address).pubkey);

    // Get balance to check for unclaimed UDs
    final Uint8List pubkey = Address.decode(wallet.address).pubkey;
    final int? idtyIndex =
        await polkadot.query.identity.identityIndexOf(pubkey);

    final List<RuntimeCall> calls = <RuntimeCall>[];

    // If member, try to claim UDs first
    if (idtyIndex != null) {
      try {
        final IdtyValue? idtyValue =
            await polkadot.query.identity.identities(idtyIndex);
        if (idtyValue != null &&
            idtyValue.status.toString().contains('member')) {
          calls.add(polkadot.tx.universalDividend.claimUds());
        }
      } catch (e) {
        loggerDev('Warning: Could not check for unclaimed UDs', error: e);
      }
    }

    // Add the transfer all call
    calls.add(polkadot.tx.balances.transferAll(
      dest: multiAddress,
      keepAlive: false,
    ));

    RuntimeCall finalCall;
    if (calls.length > 1) {
      finalCall = polkadot.tx.utility.batchAll(calls: calls);
    } else {
      finalCall = calls.first;
    }

    return signAndSend(
      node,
      provider,
      polkadot,
      wallet,
      finalCall,
      messageTransformer: _batchResultTransformer,
    );
  }, disconnectAfter: false);
}

Future<SignAndSendResult> revoke(
    int idtyIndex, List<int> revocationKey, MultiSignature revocationSig,
    {Duration timeout = defPolkadotTimeout}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
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
  }, disconnectAfter: false);
}

Future<double> currentUniversalDividendV2() async {
  return executeOnPolkadotNodes(
      (Node node, Provider provider, Gtest polkadot) async {
    try {
      final BigInt currentUd =
          await polkadot.query.universalDividend.currentUd();
      loggerDev('Current Universal Dividend: $currentUd');
      return currentUd.toDouble() / 100;
    } catch (e, stacktrace) {
      loggerDev('Error fetching current UD', error: e, stackTrace: stacktrace);
      rethrow;
    }
  });
}

Future<double> calculateBalanceFromEndPoint(
    {required String address, Duration timeout = defPolkadotTimeout}) async {
  return executeOnPolkadotNodes<double>(
      (Node node, Provider provider, Gtest polkadot) async {
    try {
      final Address accountAddress = Address.decode(address);
      final Uint8List pubkey = accountAddress.pubkey;

      final AccountInfo accountInfo =
          await polkadot.query.system.account(pubkey).timeout(timeout);

      final BigInt free = accountInfo.data.free;
      final BigInt reserved = accountInfo.data.reserved;

      loggerDev(
          'Balance for $address in node ${node.url}: free=$free, reserved=$reserved');

      // Calculate unclaimed UDs if member
      BigInt unclaimedUds = BigInt.zero;

      try {
        // 1. Get identity index from public key
        final int? idtyIndex = await polkadot.query.identity
            .identityIndexOf(pubkey)
            .timeout(timeout);

        if (idtyIndex != null) {
          // 2. Get identity data
          final IdtyValue? idtyValue = await polkadot.query.identity
              .identities(idtyIndex)
              .timeout(timeout);

          if (idtyValue != null) {
            // 3. Check membership status
            final MembershipData? membershipData = await polkadot
                .query.membership
                .membership(idtyIndex)
                .timeout(timeout);

            // Only calculate UDs if member and has firstEligibleUd
            if (membershipData != null &&
                idtyValue.status.toString().contains('member')) {
              final int firstEligibleUd = idtyValue.data.firstEligibleUd;

              if (firstEligibleUd != null && firstEligibleUd > 0) {
                // 4. Get current UD
                final BigInt currentUd = await polkadot.query.universalDividend
                    .currentUd()
                    .timeout(timeout);
                final int currentUdIndex = await polkadot
                    .query.universalDividend
                    .currentUdIndex()
                    .timeout(timeout);

                loggerDev(
                    'Member: idtyIndex=$idtyIndex, firstEligibleUd=$firstEligibleUd, currentUdIndex=$currentUdIndex, currentUd=$currentUd');

                // Calculate pending UDs based on historical reevaluations
                if (currentUdIndex > firstEligibleUd) {
                  // Get reevaluation history
                  final List<tuples.Tuple2<int, BigInt>> pastReevals =
                      await polkadot.query.universalDividend
                          .pastReevals()
                          .timeout(timeout);

                  int tempCurrentUdIndex = currentUdIndex;
                  for (final tuples.Tuple2<int, BigInt> revalEntry
                      in pastReevals.reversed) {
                    final int udReevalIndex = revalEntry.value0;
                    final BigInt udReevalValue = revalEntry.value1;

                    if (udReevalIndex <= firstEligibleUd) {
                      // Calculate from firstEligibleUd to current
                      final int count = tempCurrentUdIndex - firstEligibleUd;
                      if (count > 0) {
                        unclaimedUds += BigInt.from(count) * udReevalValue;
                      }
                      break;
                    } else {
                      // Calculate from this reevaluation to next
                      final int count = tempCurrentUdIndex - udReevalIndex;
                      if (count > 0) {
                        unclaimedUds += BigInt.from(count) * udReevalValue;
                      }
                      tempCurrentUdIndex = udReevalIndex;
                    }
                  }

                  loggerDev('Unclaimed UDs for $address: $unclaimedUds');
                }
              }
            }
          }
        }
      } catch (e, stacktrace) {
        // If error calculating UDs, it's not critical, continue with balance without UDs
        loggerDev('Warning: Could not calculate unclaimed UDs for $address',
            error: e, stackTrace: stacktrace);
      }

      final BigInt totalBalance = free + unclaimedUds;
      return totalBalance.toDouble();
    } catch (e, stacktrace) {
      loggerDev('Error calculating wallet balance for $address',
          error: e, stackTrace: stacktrace);
      rethrow;
    }
  }, timeout: timeout);
}
