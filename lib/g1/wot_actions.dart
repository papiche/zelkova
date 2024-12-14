import 'dart:async';
import 'dart:typed_data';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/extrinsic/extrinsic_payload.dart';
import 'package:polkadart/extrinsic/signature_type.dart';
import 'package:polkadart/extrinsic/signing_payload.dart';
import 'package:polkadart/primitives/primitives.dart';
import 'package:polkadart/provider.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ss58/ss58.dart';

import '../data/models/identity_status.dart';
import '../data/models/menu_action.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../generated/gdev/gdev.dart';
import '../generated/gdev/types/gdev_runtime/runtime_call.dart';
import '../generated/gdev/types/primitive_types/h256.dart';
import '../shared_prefs_helper.dart';
import '../ui/logger.dart';
import 'g1_helper.dart';
import 'g1_v2_helper_others.dart';

Future<String> createIdentity({Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  final Completer<String> result = Completer<String>();

  for (final Node node in nodes) {
    try {
/*
      final Provider provider = Provider.fromUri(parseNodeUrl(node.url));

      final Gdev polkadot = Gdev(provider);
      final RuntimeCall rt = polkadot.tx.identity
          .createIdentity(ownerKey: Address.decode(wallet.address).pubkey);
      final AuthorApi<Provider> author = AuthorApi<Provider>(provider);
      final Uint8List sign = wallet.sign(rt.encode());

*/
      final Provider provider = Provider.fromUri(parseNodeUrl(node.url));
      final Gdev polkadot = Gdev(provider);

      final RuntimeVersion runtimeVersion =
          await polkadot.rpc.state.getRuntimeVersion();
      final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
      final H256 genesisHash = await polkadot.query.system.blockHash(0);
      final int nonce =
          await polkadot.rpc.system.accountNextIndex(wallet.address);
      final int safeBlockNumber =
          currentBlockNumber > 0 ? currentBlockNumber - 1 : 0;
      assert(safeBlockNumber >= 0 && safeBlockNumber <= 0xFFFFFFFF,
          'Block number out of range: $safeBlockNumber');
      final H256 currentBlockHash =
          await polkadot.query.system.blockHash(safeBlockNumber);

      final RuntimeCall createIdentityCall =
          polkadot.tx.identity.createIdentity(
        ownerKey: Address.decode(wallet.address).pubkey,
      );

      final Uint8List encodedCall = createIdentityCall.encode();

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

      await author.submitAndWatchExtrinsic(extrinsic, (ExtrinsicStatus status) {
        switch (status.type) {
          case 'finalized':
            result.complete('');
            break;
          case 'dropped':
            result.complete(tr('op_dropped'));
            break;
          case 'invalid':
            result.complete(tr('op_invalid'));
            break;
          case 'usurped':
            result.complete(tr('op_usurped'));
            break;
          case 'future':
            break;
          case 'ready':
            break;
          case 'inBlock':
            break;
          case 'broadcast':
            break;
          default:
            result.complete('Unexpected transaction status: ${status.type}.');
            loggerDev('Unexpected transaction status: ${status.type}.');
            break;
        }
      }).timeout(timeout);

      return result.future;
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.endpoint, node);
      loggerDev('Error creating identity in node ${node.url}',
          error: e, stackTrace: stacktrace);
    }
    continue;
  }
  return 'Error creating identity';
}

Future<String> confirmIdentity(String identityName,
    {Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  final Completer<String> result = Completer<String>();

  for (final Node node in nodes) {
    try {
      final Provider provider = Provider.fromUri(parseNodeUrl(node.url));

      final Gdev polkadot = Gdev(provider);
      final RuntimeCall rt = polkadot.tx.identity
          .confirmIdentity(idtyName: identityName.codeUnits);
      final AuthorApi<Provider> author = AuthorApi<Provider>(provider);
      final Uint8List sign = wallet.sign(rt.encode());
      await author.submitAndWatchExtrinsic(sign, (ExtrinsicStatus status) {
        switch (status.type) {
          case 'finalized':
            result.complete('');
            break;
          case 'dropped':
            result.complete(tr('op_dropped'));
            break;
          case 'invalid':
            result.complete(tr('op_invalid'));
            break;
          case 'usurped':
            result.complete(tr('op_usurped'));
            break;
          case 'future':
            break;
          case 'ready':
            break;
          case 'inBlock':
            break;
          case 'broadcast':
            break;
          default:
            result.complete('Unexpected transaction status: ${status.type}.');
            loggerDev('Unexpected transaction status: ${status.type}.');
            break;
        }
      }).timeout(timeout);
      return await result.future;
    } catch (e, stacktrace) {
      NodeManager().increaseNodeErrors(NodeType.endpoint, node);
      loggerDev('Error confirming identity in node ${node.url}',
          error: e, stackTrace: stacktrace);
    }
    continue;
  }
  return 'Error confirming identity';
}

List<MenuAction> getWotMenuActions(bool isMe, IdentityStatus? status) {
  final List<MenuAction> actions = <MenuAction>[];

  switch (status) {
    case IdentityStatus.MEMBER:
      if (isMe) {
        actions.addAll(<MenuAction>[
          MenuAction(
            name: 'Renew Membership',
            icon: Icons.refresh,
            action: () {
              loggerDev('Renewing Membership');
              return confirmIdentity('');
            },
          ),
          MenuAction(
            name: 'Revoke Membership',
            icon: Icons.cancel,
            action: () {
              loggerDev('Revoking Membership');
              return Future<String>.value('');
            },
          ),
        ]);
      } else {
        actions.add(
          MenuAction(
            name: 'Certify Member',
            icon: Icons.verified,
            action: () {
              loggerDev('Certifying Member');
              return Future<String>.value('');
            },
          ),
        );
      }
      break;
    case IdentityStatus.NOTMEMBER:
      if (!isMe) {
        actions.add(
          MenuAction(
            name: 'Invite to Membership',
            icon: Icons.group_add,
            action: () {
              loggerDev('Inviting to Membership');
              return Future<String>.value('');
            },
          ),
        );
      }
      break;

    case IdentityStatus.REMOVED:
      break;

    case IdentityStatus.REVOKED:
      break;

    case IdentityStatus.UNCONFIRMED:
      break;

    case IdentityStatus.UNVALIDATED:
      break;
    case null:
      if (isMe) {
        actions.add(
          MenuAction(
            name: tr('wot_create_identity'),
            icon: Icons.verified_user_outlined,
            action: () {
              return createIdentity();
            },
          ),
        );
      }
  }

  return actions;
}
