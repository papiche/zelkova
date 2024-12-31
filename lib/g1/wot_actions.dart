import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/models/contact_wot_info.dart';
import '../data/models/identity_status.dart';
import '../data/models/wot_menu_action.dart';
import '../ui/logger.dart';
import '../ui/widgets/cesium_auth_dialog.dart';
import 'g1_v2_helper_others.dart';
import 'sing_and_send.dart';

List<WotMenuAction> getWotMenuActions(
    BuildContext context, bool isMe, ContactWotInfo wotInfo) {
  final List<WotMenuAction> actions = <WotMenuAction>[];
  final IdentityStatus? status = wotInfo.you.status;
  /* if (inDevelopment) {
    actions.add(
      MenuAction(
        name: 'isMe: $isMe $wotInfo',
        icon: Icons.info,
        action: () {
          return Future<String>.value('');
        },
      ),
    );
  } */
  switch (status) {
    case IdentityStatus.MEMBER:
      if (isMe) {
        actions.addAll(<WotMenuAction>[
          WotMenuAction(
            name: tr('renew_membership'),
            icon: Icons.refresh,
            action: () {
              loggerDev('Renewing Membership');
              throw Exception('Not implemented');
            },
          ),
          WotMenuAction(
            name: tr('revoke_membership'),
            icon: Icons.cancel,
            action: () {
              loggerDev('Revoking Membership');
              throw Exception('Not implemented');
            },
          ),
        ]);
      } else {
        _certAction(context, wotInfo, actions);
      }
      break;
    case IdentityStatus.UNVALIDATED:
    case IdentityStatus.NOTMEMBER:
      if (!isMe) {
        _certAction(context, wotInfo, actions);
        _requestDistanceAction(context, wotInfo.you.index, actions);
      }
      _requestDistanceAction(context, wotInfo.me.index, actions);
      break;
    case IdentityStatus.REMOVED:
      break;

    case IdentityStatus.REVOKED:
      break;

    case IdentityStatus.UNCONFIRMED:
      if (isMe) {
        actions.add(
          WotMenuAction(
            name: tr('confirm_identity'),
            icon: Icons.verified,
            action: () {
              final Completer<SignAndSendResult> completer =
                  Completer<SignAndSendResult>();
              final TextEditingController controller = TextEditingController();
              final RegExp validateIdtyName = RegExp(r'^[a-zA-Z0-9_-]{1,42}$');

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(tr('confirm_identity')),
                    content: TextField(
                      controller: controller,
                      decoration:
                          InputDecoration(hintText: tr('identity_name_hint')),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          completer.complete(_returnAuthFailed());
                        },
                        child: Text(tr('cancel')),
                      ),
                      TextButton(
                        onPressed: () async {
                          final String input = controller.text.trim();

                          if (validateIdtyName.hasMatch(input)) {
                            Navigator.of(context).pop();

                            try {
                              final SignAndSendResult result =
                                  await confirmIdentity(input);

                              if (!context.mounted) {
                                completer.complete(_returnAuthFailed());
                                return;
                              }

                              completer.complete(result);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(tr('payment_successful'))),
                              );
                            } catch (e) {
                              final SignAndSendResult errorResult =
                                  SignAndSendResult(
                                progressStream:
                                    Stream<String>.value(e.toString()),
                              );
                              completer.complete(errorResult);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(tr('error_occurred'))),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(tr('invalid_identity_name'))),
                            );
                            completer.complete(_returnAuthFailed());
                          }
                        },
                        child: Text(tr('ok')),
                      ),
                    ],
                  );
                },
              );

              return completer.future;
            },
          ),
        );
      }
      break;

    case null:
      if (!isMe && (wotInfo.canCreateIdty ?? false)) {
        actions.add(
          WotMenuAction(
              name: tr('wot_create_identity'),
              icon: Icons.verified_user_outlined,
              action: () async => _executeIfAuthenticated(
                  context, () => createIdentity(you: wotInfo.you))),
        );
      }
  }

  return actions;
}

void _requestDistanceAction(
    BuildContext context, int? idtyIndex, List<WotMenuAction> actions) {
  if (idtyIndex != null) {
    actions.add(WotMenuAction(
        name: tr('request_distance_evaluation'),
        icon: Icons.social_distance,
        action: () async => _executeIfAuthenticated(
            context, () => requestDistanceEvaluation(idtyIndex))));
  }
}

void _certAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  if ((wotInfo.canCert ?? false) && wotInfo.you.index != null) {
    actions.add(WotMenuAction(
        name: tr('certify_member'),
        icon: Icons.verified,
        action: () async => _executeIfAuthenticated(
            context, () => certify(wotInfo.you.index!))));
  }
}

Future<SignAndSendResult> _executeIfAuthenticated(
  BuildContext context,
  Future<SignAndSendResult> Function() action,
) async {
  final bool hasPass = await walletAuth(context);
  if (!hasPass) {
    if (!context.mounted) {
      return _returnAuthFailed();
    }
    return _returnAuthFailed();
  }
  return action();
}

Future<SignAndSendResult> _returnAuthFailed() {
  final StreamController<String> progressController =
      StreamController<String>();
  progressController.add('wallet_auth_failed');
  progressController.close();

  return Future<SignAndSendResult>.value(SignAndSendResult(
    progressStream: progressController.stream,
  ));
}
