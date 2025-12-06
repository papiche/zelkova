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
import '../generated/gtest/gtest.dart';
import '../generated/gtest/types/frame_system/account_info.dart';
import '../generated/gtest/types/gtest_runtime/runtime_call.dart';
import '../generated/gtest/types/pallet_certification/types/idty_cert_meta.dart';
import '../generated/gtest/types/pallet_identity/types/idty_value.dart';
import '../generated/gtest/types/sp_membership/membership_data.dart';
import '../generated/gtest/types/sp_runtime/multi_signature.dart';
import '../generated/gtest/types/sp_runtime/multiaddress/multi_address.dart';
import '../generated/gtest/types/tuples.dart' as tuples;
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import 'g1_v2_helper.dart';
import 'node_check_result.dart';
import 'pay_result.dart';
import 'sign_and_send.dart';

const Duration defPolkadotTimeout = Duration(seconds: 20);

Future<NodeCheckResult> testEndPointV2(String node,
    [Duration timeout = defPolkadotTimeout]) async {
  final Stopwatch stopwatch = Stopwatch()..start();

  final Provider provider = Provider.fromUri(parseNodeUrl(node));
  final Gtest polkadot = Gtest(provider);
  final int currentBlockNumber =
      await polkadot.query.system.number().timeout(defPolkadotTimeout) - 1;
  stopwatch.stop();
  final NodeCheckResult nodeCheckResult = NodeCheckResult(
      latency: stopwatch.elapsed, currentBlock: currentBlockNumber);
  return nodeCheckResult;
}

Uri parseNodeUrl(String url) {
  final Uri parsedUri = Uri.parse(url);
  return parsedUri;
}

Future<T> executeOnPolkadotNodes<T>(
    Future<T> Function(Node node, Provider provider, Gtest polkadot) operation,
    {bool retry = true,
    Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);

  for (final Node node in nodes) {
    loggerDev('executeOnPolkadotNode: ${node.url}');
    try {
      final Provider provider = Provider.fromUri(parseNodeUrl(node.url));
      final Gtest polkadot = Gtest(provider);

      final T result =
          await operation(node, provider, polkadot).timeout(timeout);
      return result; // If the operation is successful, return the result
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.endpoint, node,
          cause: 'Endpoint operation failed: $e');
      loggerDev('Error in node ${node.url}', error: e, stackTrace: stacktrace);
      if (!retry) {
        rethrow;
      }
    }
  }

  throw Exception('All nodes failed to execute the operation: $operation');
  // If all nodes fail, throw an exception
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
  });
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
  });
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
  });
}

Constants polkadotConstants() {
  final Provider provider =
      Provider.fromUri(parseNodeUrl(NodeManager().endpointNodes.first.url));
  final Gtest polkadot = Gtest(provider);
  return polkadot.constant;
}

Future<PayResult> payV2({
  required List<String> to,
  required double amount,
  String? comment,
}) async {
  final KeyPair wallet = await SharedPreferencesHelper().getKeyPair();
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
      (Node node, Provider provider, Gtest polkadot) async {
    RuntimeCall transferCall;

    if (addresses.length > 1 || comment != null) {
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
    } else {
      // No comment, one receiver
      final Id multiAddress =
          const $MultiAddress().id(Address.decode(addresses.first).pubkey);
      transferCall = polkadot.tx.balances.transferKeepAlive(
        dest: multiAddress,
        value: BigInt.from(amount * 100),
      );
    }

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
  });
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
  });
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
