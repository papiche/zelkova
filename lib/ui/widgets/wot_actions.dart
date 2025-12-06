import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/contact_wot_info.dart';
import '../../data/models/identity_status.dart';
import '../../g1/duniter_endpoint_helper.dart';
import '../../g1/sign_and_send.dart';
import '../logger.dart';
import '../secure_unlock_widget.dart';
import '../ui_helpers.dart';
import 'wot_menu_action.dart';

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
        _requestDistanceAction(context, actions, wotInfo);
        // revoke
      } else {
        _certAction(context, wotInfo, actions);
        _renewAction(context, wotInfo, actions);
      }
      break;
    case IdentityStatus.UNVALIDATED:
    case IdentityStatus.NOTMEMBER:
      if (!isMe) {
        _certAction(context, wotInfo, actions);
        _renewAction(context, wotInfo, actions);
        _requestDistanceActionFor(context, wotInfo.you.index, actions, wotInfo);
      } else {
        _requestDistanceAction(context, actions, wotInfo);
      }
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
            action: () async => _executeIfAuthenticated(
                context, () => _confirmAndSetIdentity(context)),
          ),
        );
      }
      break;

    case null:
      if (!isMe &&
          (wotInfo.canCreateIdty ?? false) &&
          wotInfo.meCanCertYouOn == null) {
        // Can create identity now
        actions.add(
          WotMenuAction(
              name: tr('wot_create_identity'),
              icon: Icons.verified_user_outlined,
              action: () async => _executeIfAuthenticated(
                  context, () => createIdentity(you: wotInfo.you))),
        );
      } else if (!isMe &&
          (wotInfo.canCreateIdty ?? false) &&
          wotInfo.meCanCertYouOn != null) {
        // Can't create identity now but can in the future - show info message
        actions.add(WotMenuAction(
            name: tr('wot_create_identity'),
            icon: Icons.verified_user_outlined,
            action: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    tr('can_certify_in_days', namedArgs: <String, String>{
                      'days': humanizeCanCertOnDay(context, wotInfo)
                    }),
                  ),
                ),
              );
              return Future<SignAndSendResult>.value(
                  SignAndSendResult(progressStream: Stream<String>.value('')));
            }));
      }
  }

  logger.info(
      'getWotMenuActions: isMe: $isMe wotInfo: $wotInfo,  actions(${actions.length}): $actions');
  return actions;
}

void _requestDistanceAction(
    BuildContext context, List<WotMenuAction> actions, ContactWotInfo info) {
  if (info.canCalcDistance ?? false) {
    actions.add(WotMenuAction(
        name: tr('request_distance_evaluation'),
        icon: Icons.social_distance,
        action: () async => _executeIfAuthenticated(
            context, () => requestDistanceEvaluation())));
  }
}

void _requestDistanceActionFor(BuildContext context, int? idtyIndex,
    List<WotMenuAction> actions, ContactWotInfo info) {
  if (idtyIndex != null && (info.canCalcDistanceFor ?? false)) {
    actions.add(WotMenuAction(
        name: tr('request_distance_evaluation'),
        icon: Icons.social_distance,
        action: () async => _executeIfAuthenticated(
            context, () => requestDistanceEvaluationFor(idtyIndex))));
  }
}

void _certAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  // Always show cert action if I haven't certified yet and the contact has an index
  if (!(wotInfo.meAlreadyCertYou ?? false) && wotInfo.you.index != null) {
    if (wotInfo.meCanCertYou ?? false) {
      // I can certify now - show enabled action
      actions.add(WotMenuAction(
          name: tr('certify_member'),
          icon: Icons.verified,
          action: () async => _executeIfAuthenticated(
              context, () => _confirmAndCertify(context, wotInfo))));
    } else if (wotInfo.meCanCertYouOn != null) {
      // I can't certify now, but I will be able to in the future - show info message
      actions.add(WotMenuAction(
          name: tr('certify_member'),
          icon: Icons.verified,
          action: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  tr('can_certify_in_days', namedArgs: <String, String>{
                    'days': humanizeCanCertOnDay(context, wotInfo)
                  }),
                ),
              ),
            );
            return Future<SignAndSendResult>.value(
                SignAndSendResult(progressStream: Stream<String>.value('')));
          }));
    } else if (wotInfo.meReachedMaxByIssuer ?? false) {
      // I can't certify because I've reached maxByIssuer limit - show disabled info
      actions.add(WotMenuAction(
          name: tr('certify_member'),
          icon: Icons.verified,
          action: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('cannot_certify_reached_limit')),
              ),
            );
            return Future<SignAndSendResult>.value(
                SignAndSendResult(progressStream: Stream<String>.value('')));
          }));
    }
  }
}

Future<SignAndSendResult> _confirmAndSetIdentity(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  final RegExp validateIdtyName = RegExp(r'^[a-zA-Z0-9_-]{1,42}$');

  final String? input = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('confirm_identity')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: tr('identity_name_hint')),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(tr('cancel')),
          ),
          TextButton(
            onPressed: () {
              final String inputText = controller.text.trim();
              if (validateIdtyName.hasMatch(inputText)) {
                Navigator.of(dialogContext).pop(inputText);
              } else {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(content: Text(tr('invalid_identity_name'))),
                );
              }
            },
            child: Text(tr('ok')),
          ),
        ],
      );
    },
  );

  if (input == null || input.isEmpty) {
    loggerDev('Identity confirmation cancelled by user');
    return _returnAuthFailed();
  }

  try {
    loggerDev('Calling confirmIdentity with name: $input');
    final SignAndSendResult result = await confirmIdentity(input);
    loggerDev(
        'confirmIdentity returned result, progressStream: ${result.progressStream}');
    return result;
  } catch (e, st) {
    loggerDev('Error in _confirmAndSetIdentity', error: e, stackTrace: st);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('error_occurred'))),
      );
    }
    log.e('Error confirming identity: $e', stackTrace: st);
    return _returnAuthFailed();
  }
}

Future<SignAndSendResult> _confirmAndCertify(
    BuildContext context, ContactWotInfo wotInfo) async {
  // Get the display name (nick or name or address)
  final String displayName = wotInfo.you.nick ??
      wotInfo.you.name ??
      wotInfo.you.address.substring(0, 8);

  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('certify_member')),
        content: Text(
          tr('confirm_certify_member',
              namedArgs: <String, String>{'nick': displayName}),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false);
            },
            child: Text(tr('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
            child: Text(tr('yes')),
          ),
        ],
      );
    },
  );

  if (confirmed ?? false) {
    return _certifyAndMaybeRequestDistance(wotInfo);
  } else {
    return _returnAuthFailed();
  }
}

Future<SignAndSendResult> _certifyAndMaybeRequestDistance(
    ContactWotInfo wotInfo) async {
  final int idtyIndex = wotInfo.you.index!;

  // Check if this certification will make the person reach minCertForMembership
  final int currentCerts = wotInfo.you.certsReceived?.length ?? 0;
  final int minCerts = polkadotConstants().wot.minCertForMembership;
  final bool willReachMembership = currentCerts == (minCerts - 1);

  logger.info(
      'Certifying idtyIndex: $idtyIndex, currentCerts: $currentCerts, minCerts: $minCerts, willReachMembership: $willReachMembership');

  // Perform the certification
  final SignAndSendResult certResult = await certify(idtyIndex);

  if (willReachMembership) {
    // Create a new stream controller to combine both operations
    final StreamController<String> combinedController =
        StreamController<String>();

    // Listen to the certification progress
    bool finalized = false;
    certResult.progressStream.listen(
      (String progress) {
        combinedController.add(progress);

        // Check if certification was finalized successfully
        if (progress.contains('finalized') ||
            progress.toLowerCase().contains('finalized')) {
          finalized = true;
        }
      },
      onError: (Object error) {
        combinedController.addError(error);
        combinedController.close();
      },
      onDone: () async {
        // After certification is done, request distance if it was successful
        if (finalized) {
          try {
            logger.info(
                'Certification finalized successfully. Requesting distance evaluation for idtyIndex: $idtyIndex');
            combinedController.add(tr('requesting_distance_evaluation'));

            final SignAndSendResult distanceResult =
                await requestDistanceEvaluationFor(idtyIndex);

            // Forward distance calculation progress
            distanceResult.progressStream.listen(
              (String progress) {
                combinedController.add(progress);
              },
              onError: (Object error) {
                combinedController.addError(error);
              },
              onDone: () {
                combinedController.close();
              },
            );
          } catch (e) {
            log.e(
                'Error requesting distance evaluation after certification: $e');
            combinedController.addError(tr('error_requesting_distance'));
            combinedController.close();
          }
        } else {
          combinedController.close();
        }
      },
    );

    return SignAndSendResult(
      node: certResult.node,
      progressStream: combinedController.stream,
    );
  }

  // If not reaching membership, just return the certification result
  return certResult;
}

void _renewAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  if ((wotInfo.meCanCertYou ?? false) &&
      (wotInfo.meAlreadyCertYou ?? false) &&
      wotInfo.you.index != null) {
    actions.add(WotMenuAction(
        name: tr('renew_membership'),
        icon: Icons.refresh_outlined,
        action: () async =>
            _executeIfAuthenticated(context, () => renew(wotInfo.you.index!))));
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
  progressController.add(tr('wallet_auth_failed'));
  progressController.close();

  return Future<SignAndSendResult>.value(SignAndSendResult(
    progressStream: progressController.stream,
  ));
}

String humanizeCanCertOnDay(BuildContext context, ContactWotInfo wotInfo) {
  return humanizeTimeFuture(
        context.locale.languageCode,
        (wotInfo.meCanCertYouOn!.millisecondsSinceEpoch -
                DateTime.now().millisecondsSinceEpoch) ~/
            1000,
      ) ??
      '';
}
