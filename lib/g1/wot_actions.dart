import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/models/contact_wot_info.dart';
import '../data/models/identity_status.dart';
import '../data/models/menu_action.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'g1_v2_helper_others.dart';

List<MenuAction> getWotMenuActions(
    BuildContext context, bool isMe, ContactWotInfo wotInfo) {
  final List<MenuAction> actions = <MenuAction>[];
  final IdentityStatus? status = wotInfo.you.status;
  if (inDevelopment) {
    actions.add(
      MenuAction(
        name: 'isMe: $isMe $wotInfo',
        icon: Icons.info,
        action: () {
          return Future<String>.value('');
        },
      ),
    );
  }
  switch (status) {
    case IdentityStatus.MEMBER:
      if (isMe) {
        actions.addAll(<MenuAction>[
          MenuAction(
            name: tr('renew_membership'),
            icon: Icons.refresh,
            action: () {
              loggerDev('Renewing Membership');
              return Future<String>.value('');
            },
          ),
          MenuAction(
            name: tr('revoke_membership'),
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
            name: tr('confirm_identity'),
            icon: Icons.verified,
            action: () {
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
                                  content: Text(tr('invalid_identity_name'))),
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
        name: tr('request_distance_evaluation'),
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
        name: tr('certify'),
        icon: Icons.verified,
        action: () {
          loggerDev('Certifying Member');
          return Future<String>.value('');
        },
      ),
    );
  }
}
