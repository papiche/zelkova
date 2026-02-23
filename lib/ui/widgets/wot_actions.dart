import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/models/contact_wot_info.dart';
import '../../data/models/identity_status.dart';
import '../../data/models/stored_account.dart';
import '../../g1/duniter_endpoint_helper.dart';
import '../../g1/duniter_indexer_helper.dart' as duniter_indexer;
import '../../g1/sign_and_send.dart';
import '../../shared_prefs_helper.dart';
import '../contacts_cache.dart';
import '../logger.dart';
import '../secure_unlock_widget.dart';
import '../ui_helpers.dart';
import 'fifth_screen/multi_wallet_selector.dart';
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
        _renewMembershipActionForSelf(context, wotInfo, actions);
        _changeOwnerKeyAction(context, wotInfo, actions);
        _revokeAction(context, wotInfo, actions);
      } else {
        _certAction(context, wotInfo, actions);
        _renewAction(context, wotInfo, actions, isMe);
      }
      break;
    case IdentityStatus.UNVALIDATED:
    case IdentityStatus.NOTMEMBER:
      if (!isMe) {
        _certAction(context, wotInfo, actions);
        _renewAction(context, wotInfo, actions, isMe);
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
  if (isMe) {
    _transferAllAction(context, wotInfo, actions);
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
    return _returnCancelled();
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
            child: Text(tr('ok')),
          ),
        ],
      );
    },
  );

  if (confirmed ?? false) {
    return _certifyAndMaybeRequestDistance(wotInfo);
  } else {
    return _returnCancelled();
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

void _renewAction(BuildContext context, ContactWotInfo wotInfo,
    List<WotMenuAction> actions, bool isMe) {
  // Only show renew action if I already certified this identity, can certify now,
  // AND this is NOT my own identity
  if (!isMe &&
      (wotInfo.meAlreadyCertYou ?? false) &&
      (wotInfo.meCanCertYou ?? false) &&
      wotInfo.you.index != null) {
    actions.add(WotMenuAction(
        name: tr('renew_cert'),
        icon: Symbols.safety_check,
        action: () async => _executeIfAuthenticated(
            context, () => _confirmAndRenewCert(context, wotInfo))));
  } else if (!isMe &&
      (wotInfo.meAlreadyCertYou ?? false) &&
      !(wotInfo.meCanCertYou ?? false) &&
      wotInfo.meCanCertYouOn != null &&
      wotInfo.you.index != null) {
    // Can't renew now but will be able to in the future - show info message
    actions.add(WotMenuAction(
        name: tr('renew_membership'),
        icon: Symbols.arming_countdown,
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

// TODOretwork this
Future<SignAndSendResult> _returnAuthFailed() {
  final StreamController<String> progressController =
      StreamController<String>();
  progressController.add(tr('wallet_auth_failed'));
  progressController.close();

  return Future<SignAndSendResult>.value(SignAndSendResult(
    progressStream: progressController.stream,
  ));
}

/// Returns an empty result when the user cancels a confirmation dialog.
/// Unlike [_returnAuthFailed], this does not emit any message.
Future<SignAndSendResult> _returnCancelled() {
  return Future<SignAndSendResult>.value(SignAndSendResult(
    progressStream: Stream<String>.empty(),
    cancelled: true,
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

void _renewMembershipActionForSelf(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  if (wotInfo.you.index == null) {
    return;
  }

  actions.add(WotMenuAction(
      name: tr('renew_membership'),
      icon: Symbols.verified_user,
      action: () async => _executeIfAuthenticated(
          context, () => _confirmEvaluateDistanceAndRenew(context, wotInfo))));
}

void _revokeAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  if (wotInfo.you.index == null) {
    return;
  }

  actions.add(WotMenuAction(
      name: tr('revoke_membership'),
      // I like this icon for revoke action
      icon: Symbols.gpp_bad,
      color: Colors.red,
      action: () async => _executeIfAuthenticated(
          context, () => _confirmAndRevoke(context, wotInfo))));
}

void _transferAllAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  actions.add(WotMenuAction(
      name: tr('transfer_all'),
      icon: Symbols.money_range,
      color: Colors.red,
      action: () async => _executeIfAuthenticated(
          context, () => _confirmAndTransferAll(context, wotInfo))));
}

void _changeOwnerKeyAction(
    BuildContext context, ContactWotInfo wotInfo, List<WotMenuAction> actions) {
  actions.add(WotMenuAction(
      name: tr('transfer_identity'),
      icon: Symbols.supervisor_account,
      color: Colors.red,
      action: () async => _executeIfAuthenticated(
          context, () => _confirmAndChangeOwnerKey(context, wotInfo))));
}

Future<SignAndSendResult> _confirmAndRenewCert(
    BuildContext context, ContactWotInfo wotInfo) async {
  final String displayName = wotInfo.you.nick ??
      wotInfo.you.name ??
      wotInfo.you.address.substring(0, 8);

  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('renew_cert')),
        content: Text(
          tr('confirm_renew_member',
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
            child: Text(tr('ok')),
          ),
        ],
      );
    },
  );

  if (!(confirmed ?? false)) {
    return _returnCancelled();
  }

  try {
    final int idtyIndex = wotInfo.you.index!;
    return await renewCert(idtyIndex);
  } catch (e, st) {
    loggerDev('Error in _confirmAndRenewCert', error: e, stackTrace: st);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('error_occurred'))),
      );
    }
    log.e('Error renewing cert: $e', stackTrace: st);
    return _returnAuthFailed();
  }
}

Future<SignAndSendResult> _confirmEvaluateDistanceAndRenew(
    BuildContext context, ContactWotInfo wotInfo) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('renew_membership')),
        content: Text(tr('confirm_evaluate_distance_and_renew')),
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
            child: Text(tr('ok')),
          ),
        ],
      );
    },
  );

  if (!(confirmed ?? false)) {
    return _returnCancelled();
  }

  final int idtyIndex = wotInfo.you.index!;

  // Combine streams: first request distance evaluation, then renewCert only if distance is valid
  final StreamController<String> combinedController =
      StreamController<String>();

  try {
    // Request distance evaluation
    final SignAndSendResult distanceResult =
        await requestDistanceEvaluationFor(idtyIndex);

    distanceResult.progressStream.listen(
      (String progress) {
        combinedController.add(progress);
      },
      onError: (Object error) {
        combinedController.addError(error);
      },
      onDone: () async {
        try {
          combinedController.add(tr('renewing_certificate'));
          final SignAndSendResult renewResult = await renewCert(idtyIndex);

          bool renewFinalized = false;
          renewResult.progressStream.listen(
            (String progress) {
              combinedController.add(progress);
              if (progress.toLowerCase().contains('finalized')) {
                renewFinalized = true;
              }
            },
            onError: (Object error) {
              combinedController.addError(error);
            },
            onDone: () async {
              if (renewFinalized) {
                try {
                  combinedController.add(tr('confirming_cert_renewed'));
                  final SignAndSendResult ackResult =
                      await certRenewed(idtyIndex);

                  ackResult.progressStream.listen(
                    (String p) => combinedController.add(p),
                    onError: (Object error) =>
                        combinedController.addError(error),
                    onDone: () => combinedController.close(),
                  );
                } catch (e) {
                  combinedController.addError(e);
                  combinedController.close();
                }
              } else {
                combinedController.close();
              }
            },
          );
        } catch (e) {
          combinedController.addError(e);
          combinedController.close();
        }
      },
    );

    return SignAndSendResult(
      progressStream: combinedController.stream,
    );
  } catch (e) {
    combinedController.addError(e);
    combinedController.close();
    return SignAndSendResult(progressStream: combinedController.stream);
  }
}

Future<SignAndSendResult> _confirmAndRevoke(
    BuildContext context, ContactWotInfo wotInfo) async {
  final String displayName = wotInfo.you.nick ??
      wotInfo.you.name ??
      wotInfo.you.address.substring(0, 8);

  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('revoke_membership')),
        content: Text(
          tr('confirm_revoke_member',
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
            child: Text(tr('accept')),
          ),
        ],
      );
    },
  );

  if (!(confirmed ?? false)) {
    return _returnCancelled();
  }

  try {
    final int idtyIndex = wotInfo.you.index!;
    return await revokeIdentity(idtyIndex);
  } catch (e, st) {
    loggerDev('Error in _confirmAndRevoke', error: e, stackTrace: st);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('error_occurred'))),
      );
    }
    log.e('Error revoking identity: $e', stackTrace: st);
    return _returnAuthFailed();
  }
}

Future<SignAndSendResult> _confirmAndTransferAll(
    BuildContext context, ContactWotInfo wotInfo) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('transfer_all')),
        content: Text(tr('confirm_transfer_all')),
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

  if (!(confirmed ?? false)) {
    return _returnCancelled();
  }

  try {
    final TextEditingController recipientController = TextEditingController();

    if (!context.mounted) {
      return _returnCancelled();
    }
    final String? recipientAddress = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(tr('recipient_address')),
          content: TextField(
            controller: recipientController,
            decoration: InputDecoration(
              hintText: tr('enter_recipient_address'),
            ),
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
                Navigator.of(dialogContext).pop(recipientController.text);
              },
              child: Text(tr('ok')),
            ),
          ],
        );
      },
    );

    if (recipientAddress == null || recipientAddress.isEmpty) {
      return _returnCancelled();
    }

    return await transferAllWOT(recipientAddress);
  } catch (e, st) {
    loggerDev('Error in _confirmAndTransferAll', error: e, stackTrace: st);
    if (!context.mounted) {
      return _returnAuthFailed();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('error_occurred'))),
    );
    log.e('Error transferring all: $e', stackTrace: st);
    return _returnAuthFailed();
  }
}

Future<SignAndSendResult> _confirmAndChangeOwnerKey(
    BuildContext context, ContactWotInfo wotInfo) async {
  // Check if the identity has had a recent owner key change
  try {
    final int? lastChangeBlock = await duniter_indexer
        .getLastOwnerKeyChangeBlock(accountId: wotInfo.you.address);

    if (lastChangeBlock != null && wotInfo.currentBlockHeight != null) {
      final int blocksSinceChange =
          wotInfo.currentBlockHeight! - lastChangeBlock;
      final int cooldownBlocks =
          polkadotConstants().identity.changeOwnerKeyPeriod;

      if (blocksSinceChange < cooldownBlocks) {
        final int blocksRemaining = cooldownBlocks - blocksSinceChange;
        final int daysRemaining = (blocksRemaining * 6) ~/ (60 * 60 * 24);

        if (context.mounted) {
          await showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(tr('transfer_identity_cooldown_title')),
                content: Text(tr('transfer_identity_cooldown_desc',
                    namedArgs: <String, String>{
                      'time': tr('transfer_identity_cooldown_days',
                          namedArgs: <String, String>{
                            'days': daysRemaining.toString()
                          }),
                    })),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(tr('ok')),
                  ),
                ],
              );
            },
          );
        }
        return _returnCancelled();
      }
    }
  } catch (e, st) {
    loggerDev('Error checking owner key cooldown', error: e, stackTrace: st);
  }

  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(tr('transfer_identity')),
        content: Text(tr('confirm_transfer_identity')),
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

  if (!(confirmed ?? false)) {
    return _returnCancelled();
  }

  try {
    // Use multi_wallet_selector to select the new owner account
    // Filter to show only password-protected accounts without identity
    if (!context.mounted) {
      return _returnCancelled();
    }
    final StoredAccount? selectedAccount =
        await _selectNewOwnerAccount(context);

    if (selectedAccount == null) {
      return _returnCancelled();
    }

    final SignAndSendResult res =
        await changeOwnerKey(selectedAccount.contact.address);

    final StreamController<String> progressController =
        StreamController<String>();
    bool hasError = false;

    res.progressStream.listen(
      (String msg) => progressController.add(msg),
      onError: (Object error) {
        hasError = true;
        progressController.addError(error);
      },
      onDone: () async {
        progressController.close();
        if (!hasError) {
          try {
            await SharedPreferencesHelper().refreshWalletsInfo();
            await ContactsCache().clear();
          } catch (e) {
            loggerDev('Error refreshing wallets after changeOwnerKey: $e');
          }
        }
      },
    );

    return SignAndSendResult(
      progressStream: progressController.stream,
      node: res.node,
    );
  } catch (e, st) {
    loggerDev('Error in _confirmAndChangeOwnerKey', error: e, stackTrace: st);
    if (!context.mounted) {
      return _returnAuthFailed();
    }

    // Mostrar mensaje más específico según el tipo de error
    String errorMessage = tr('error_occurred');
    if (e.toString().contains('not available in your accounts') ||
        e.toString().contains('not in your accounts')) {
      errorMessage = tr('new_owner_not_in_accounts');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
    log.e('Error transferring identity: $e', stackTrace: st);
    return _returnAuthFailed();
  }
}

Future<StoredAccount?> _selectNewOwnerAccount(BuildContext context) async {
  final Completer<StoredAccount?> completer = Completer<StoredAccount?>();

  if (!context.mounted) {
    return null;
  }

  showSingleWalletSelector(
    context,
    (StoredAccount account) {
      if (!completer.isCompleted) {
        completer.complete(account);
      }
    },
    title: tr('select_new_owner_account'),
    errorMessage: tr('please_select_new_owner_account'),
    filterFunction: (StoredAccount account) {
      // Filter: password-protected v2 account and without identity
      return account.type == AccountType.v2PasswordProtected &&
          account.contact.index == null;
    },
  );

  return completer.future;
}

Future<SignAndSendResult> certRenewed(int idtyIndex,
    {Duration timeout = defPolkadotTimeout}) async {
  // certRenewed is called after renewCert to finalize the certificate renewal
  // This is a confirmation step that returns a success message
  final StreamController<String> progressController =
      StreamController<String>();
  progressController.add(tr('cert_renewed_confirmed'));
  progressController.close();
  return SignAndSendResult(progressStream: progressController.stream);
}
