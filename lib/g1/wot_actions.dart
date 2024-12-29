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

import '../data/models/contact.dart';
import '../data/models/contact_wot_info.dart';
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

Future<String> requestDistanceEvaluation(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  final Completer<String> result = Completer<String>();

  return executeOnNodes<String>(
      (Node node, Provider provider, Gdev gdev) async {
    // distance rule has been evaluated positively locally on web of trust at block storage.distance.evaluationBlock()
    // TODO(vjrj): Implement this
    // gdev.query.distance.evaluationBlock();
    final RuntimeCall call =
        gdev.tx.distance.requestDistanceEvaluationFor(target: idtyIndex);
    return signAndSend(gdev, wallet, call, provider, result, timeout);
  });
}

Future<String> signAndSend(Gdev polkadot, KeyPair wallet, RuntimeCall call,
    Provider provider, Completer<String> result, Duration timeout) async {
  final RuntimeVersion runtimeVersion =
      await polkadot.rpc.state.getRuntimeVersion();
  final int currentBlockNumber = (await polkadot.query.system.number()) - 1;
  final H256 currentBlockHash =
      await polkadot.query.system.blockHash(currentBlockNumber);
  final int nonce = await polkadot.rpc.system.accountNextIndex(wallet.address);

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
}

Future<String> createIdentity(
    {required Contact you, Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  final Completer<String> result = Completer<String>();
  return executeOnNodes((Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call = polkadot.tx.identity.createIdentity(
      ownerKey: Address.decode(you.address).pubkey,
    );

    return signAndSend(polkadot, wallet, call, provider, result, timeout);
  });
}

Future<String> confirmIdentity(String identityName,
    {Duration timeout = defPolkadotTimeout}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.endpoint);
  nodes.shuffle();
  final CesiumWallet walletV1 = await SharedPreferencesHelper().getWallet();
  final KeyPair wallet = KeyPair.ed25519.fromSeed(walletV1.seed);
  final Completer<String> result = Completer<String>();
  return executeOnNodes((Node node, Provider provider, Gdev polkadot) async {
    final RuntimeCall call =
        polkadot.tx.identity.confirmIdentity(idtyName: identityName.codeUnits);
    return signAndSend(polkadot, wallet, call, provider, result, timeout);
  });
}

List<MenuAction> getWotMenuActions(
    BuildContext context, bool isMe, ContactWotInfo wotInfo) {
  final List<MenuAction> actions = <MenuAction>[];
  final IdentityStatus? status = wotInfo.you.status;

  switch (status) {
    case IdentityStatus.MEMBER:
      if (isMe) {
        actions.addAll(<MenuAction>[
          MenuAction(
            name: 'Renew Membership',
            icon: Icons.refresh,
            action: () {
              loggerDev('Renewing Membership');
              return Future<String>.value('');
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
        _certAction(wotInfo, actions);
      }
      break;
    case IdentityStatus.UNVALIDATED:
    case IdentityStatus.NOTMEMBER:
      if (!isMe) {
        _certAction(wotInfo, actions);
        _requestDistanceAction(wotInfo.you.index, actions);
      } else {
        _requestDistanceAction(wotInfo.me.index, actions);
      }
      break;

    case IdentityStatus.REMOVED:
      break;

    case IdentityStatus.REVOKED:
      break;

    case IdentityStatus.UNCONFIRMED:
      if (isMe) {
        actions.add(
          MenuAction(
            name: 'Confirm Identity',
            icon: Icons.verified,
            action: () {
              final TextEditingController controller = TextEditingController();
              final RegExp validateIdtyName = RegExp(r'^[a-zA-Z0-9_-]{1,42}$');

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Identity'),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: 'Identity Name'),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(tr('cancel')),
                      ),
                      TextButton(
                        onPressed: () {
                          final String input = controller.text.trim();

                          if (validateIdtyName.hasMatch(input)) {
                            Navigator.of(context).pop();
                            confirmIdentity(input).then((String result) {
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result)),
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(tr('Invalid identity name'))),
                            );
                          }
                        },
                        child: Text(tr('ok')),
                      ),
                    ],
                  );
                },
              );
              // FIXME(vjrj): Implement this better
              return Future<String>.value('');
            },
          ),
        );
      }
      break;

    case null:
      if (!isMe && (wotInfo.canCreateIdty ?? false)) {
        actions.add(
          MenuAction(
            name: tr('wot_create_identity'),
            icon: Icons.verified_user_outlined,
            action: () {
              return createIdentity(you: wotInfo.you);
            },
          ),
        );
      }
  }

  return actions;
}

void _requestDistanceAction(int? idtyIndex, List<MenuAction> actions) {
  if (idtyIndex != null) {
    actions.add(MenuAction(
        name: 'Request Distance Evaluation',
        icon: Icons.social_distance,
        action: () {
          return requestDistanceEvaluation(idtyIndex);
        }));
  }
}

void _certAction(ContactWotInfo wotInfo, List<MenuAction> actions) {
  if (wotInfo.canCert ?? false) {
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
}
