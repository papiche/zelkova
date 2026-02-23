import 'dart:async';
import 'package:get_it/get_it.dart';

import '../g1/distance_precompute.dart';
import '../g1/distance_precompute_provider.dart';
import '../g1/duniter_endpoint_helper.dart';
import '../g1/duniter_indexer_helper.dart' as duniter_indexer;
import '../g1/g1_helper.dart';
import '../g1/g1_v2_helper.dart';
import '../g1/service_manager.dart';
import '../generated/gtest/types/pallet_certification/types/idty_cert_meta.dart';
import '../generated/gtest/types/pallet_identity/types/idty_value.dart';
import '../shared_prefs_helper.dart';
import '../ui/contacts_cache.dart';
import '../ui/in_dev_helper.dart';
import '../ui/logger.dart';
import 'models/app_cubit.dart';
import 'models/cert.dart';
import 'models/contact.dart';
import 'models/contact_wot_info.dart';
import 'models/identity_status.dart';
import 'models/multi_wallet_transaction_cubit.dart';

class WotInfoFetcher {
  static Stream<ContactWotInfo> fetch(
      Contact contact, AppCubit appCubit) async* {
    final bool isV2 = appCubit.isV2;
    final ServiceManager serviceManager = GetIt.instance.get<ServiceManager>();

    // 0. Try to get cached data first to show something immediately
    final Contact? cachedYou = ContactsCache().getCachedContact(contact.pubKey);
    final Contact? cachedMe =
        ContactsCache().getCachedContact(SharedPreferencesHelper().getPubKey());

    if (cachedYou != null || cachedMe != null) {
      yield ContactWotInfo(me: cachedMe ?? contact, you: cachedYou ?? contact);
    }

    // 1. If not V2, we don't support WoT info yet, so we just finish here
    if (!isV2) {
      final Contact me = await serviceManager.current
          .getProfile(SharedPreferencesHelper().getPubKey(), complete: true);
      final Contact you = await serviceManager.current
          .getProfile(contact.pubKey, complete: true);
      yield ContactWotInfo(me: me, you: you)..loaded = true;
      return;
    }

    try {
      final MultiWalletTransactionCubit txsCubit =
          GetIt.instance.get<MultiWalletTransactionCubit>();

      // Parallelize the first calls
      final List<Contact> results = await Future.wait(<Future<Contact>>[
        serviceManager.current.getProfile(contact.pubKey,
            resize: false,
            complete: true,
            baseContact: contact.cloneWithoutIdentity()),
        serviceManager.current.getProfile(SharedPreferencesHelper().getPubKey(),
            resize: false, complete: true),
      ]);
      final Contact you = results[0];
      final Contact me = results[1];
      final ContactWotInfo wotInfo = ContactWotInfo(me: me, you: you);

      if (you.status == null) {
        final bool iAmMember = me.isMember ?? false;
        final BigInt youBalance =
            BigInt.from(txsCubit.balance(contact.pubKey) * 100);
        final bool enoughBalance = youBalance > BigInt.from(200);
        final bool identityUsed =
            await duniter_indexer.getIdentity(address: you.address) != null;
        wotInfo.canCreateIdty = iAmMember && enoughBalance && !identityUsed;
      }
      yield wotInfo;

      // Wrap Polkadot calls in try-catch to avoid failing the whole stream if one node fails
      int currentBlock = 0;
      try {
        currentBlock = await polkadotCurrentBlock();
        wotInfo.currentBlockHeight = currentBlock;
      } catch (e) {
        logger('Error fetching current block: $e');
      }

      if (currentBlock > 0) {
        final bool youAMember = you.isMember ?? false;

        final List<dynamic> identityInfoResults =
            await Future.wait(<Future<dynamic>>[
          if (youAMember)
            polkadotIdentity(you).catchError((Object e) => null)
          else
            Future<void>.value(),
          if (youAMember)
            polkadotIdtyCertMeta(you).catchError((Object e) => null)
          else
            Future<void>.value(),
          polkadotIdentity(me).catchError((Object e) => null),
          polkadotIdtyCertMeta(me).catchError((Object e) => null),
        ]);

        final IdtyValue? youIdty =
            youAMember ? identityInfoResults[0] as IdtyValue? : null;
        final IdtyCertMeta? youCertMeta =
            youAMember ? identityInfoResults[1] as IdtyCertMeta? : null;
        final IdtyValue? myIdty = identityInfoResults[2] as IdtyValue?;
        final IdtyCertMeta? idtyCertMeta =
            identityInfoResults[3] as IdtyCertMeta?;

        if (youIdty != null && youCertMeta != null) {
          wotInfo.youCanCertOn = estimateDateFromBlock(
              futureBlock: youCertMeta.nextIssuableOn,
              currentBlockHeight: currentBlock);
        }

        if (myIdty != null && idtyCertMeta != null) {
          final bool reachedMaxByIssuer =
              idtyCertMeta.issuedCount >= getMaxByIssuer();
          wotInfo.meReachedMaxByIssuer = reachedMaxByIssuer;

          final bool meCanCertYou =
              myIdty.nextCreatableIdentityOn < currentBlock &&
                  idtyCertMeta.nextIssuableOn < currentBlock &&
                  !reachedMaxByIssuer;
          wotInfo.meCanCertYou = meCanCertYou;

          if (!meCanCertYou) {
            final int nextBlock =
                myIdty.nextCreatableIdentityOn > idtyCertMeta.nextIssuableOn
                    ? myIdty.nextCreatableIdentityOn
                    : idtyCertMeta.nextIssuableOn;

            if (nextBlock > currentBlock && !reachedMaxByIssuer) {
              wotInfo.meCanCertYouOn = estimateDateFromBlock(
                  futureBlock: nextBlock, currentBlockHeight: currentBlock);
            }
          }
        } else {
          wotInfo.meCanCertYou = false;
          wotInfo.meReachedMaxByIssuer = false;
        }

        wotInfo.waitingForCerts = you.certsReceived != null &&
            you.certsReceived!.length <
                polkadotConstants().wot.minCertForMembership;

        final int? membershipExpireOn = you.expireOn;
        if (membershipExpireOn != null) {
          wotInfo.expireOn = estimateDateFromBlock(
              futureBlock: membershipExpireOn,
              currentBlockHeight: currentBlock);
        }

        if (membershipExpireOn != null &&
            wotInfo.isme &&
            wotInfo.waitingForCerts == false &&
            (you.status == IdentityStatus.MEMBER ||
                you.status == IdentityStatus.NOTMEMBER ||
                you.status == IdentityStatus.UNVALIDATED)) {
          wotInfo.canCalcDistance = you.expireOn == null ||
              (membershipExpireOn +
                      polkadotConstants().membership.membershipRenewalPeriod <
                  currentBlock +
                      polkadotConstants().membership.membershipPeriod);
        } else {
          wotInfo.canCalcDistance = false;
        }

        wotInfo.canCalcDistanceFor = !wotInfo.isme &&
            wotInfo.waitingForCerts != null &&
            !wotInfo.waitingForCerts!;

        wotInfo.meAlreadyCertYou = you.certsReceived != null &&
            you.certsReceived!.isNotEmpty &&
            you.certsReceived!
                .any((Cert cert) => cert.issuerId.pubKey == me.pubKey);

        yield wotInfo;

        DistancePrecompute? distancePrecompute =
            appCubit.state.distancePrecompute;
        if (distancePrecompute == null) {
          try {
            distancePrecompute =
                await DistancePrecomputeProvider().fetchDistancePrecompute();
            if (distancePrecompute != null) {
              appCubit.setDistancePreCompute(distancePrecompute);
            }
          } catch (e) {
            logger('Error fetching distance precompute: $e');
          }
        }
        if (you.index != null && distancePrecompute != null) {
          final int distRuleReached =
              distancePrecompute.results[you.index] ?? 0;
          final int refereesCount = distancePrecompute.refereesCount;
          final double distRuleRatio =
              refereesCount > 0 ? distRuleReached / refereesCount : 0.0;
          const double distThreshold = 0.8;
          wotInfo.distRuleOk = distRuleRatio > distThreshold;
          wotInfo.distRuleRatio = distRuleRatio;
        }
      }
      wotInfo.loaded = true;
      yield wotInfo;
    } catch (e) {
      logger('Error in WotInfoFetcher.fetch: $e');
      yield ContactWotInfo(me: contact, you: contact)..loaded = true;
    }
  }

  static DateTime estimateDateFromBlock(
      {required int futureBlock, required int currentBlockHeight}) {
    const int millisPerBlock = 6000;
    final int diff = futureBlock - currentBlockHeight;
    return DateTime.now().add(Duration(milliseconds: diff * millisPerBlock));
  }
}
