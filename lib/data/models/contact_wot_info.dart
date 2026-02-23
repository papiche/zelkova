import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../g1/g1_helper.dart';
import '../../ui/ui_helpers.dart';
import 'contact.dart';

part 'contact_wot_info.g.dart';

@CopyWith()
// ignore: must_be_immutable
class ContactWotInfo extends Equatable {
  ContactWotInfo({
    required this.me,
    required this.you,
  });

  final Contact me;
  final Contact you;

  // About ME certifying YOU
  bool? meCanCertYou;
  DateTime? meCanCertYouOn;
  bool? meAlreadyCertYou;
  bool? meReachedMaxByIssuer;

  // About YOU certifying (in general, not necessarily me)
  DateTime? youCanCertOn;

  // Other fields
  bool? canCreateIdty;
  bool? canCalcDistance;
  bool? canCalcDistanceFor;
  bool? waitingForCerts;
  DateTime? expireOn;
  bool? distRuleOk;
  double? distRuleRatio;
  int? currentBlockHeight;
  bool loaded = false;

  // Identity transfer
  bool? canTransferIdentity;
  int? lastOwnerKeyChangeBlock;

  bool get isme => isMe(you, me.pubKey);

  @override
  String toString() {
    return 'ContactWotInfo{me: ${humanizeContact('', me)}, you: ${humanizeContact('', you)}, meCanCertYou: $meCanCertYou, canCreateIdty: $canCreateIdty}, waitingForCert: $waitingForCerts}';
  }

  @override
  List<Object?> get props => <Object?>[
        me,
        you,
        meCanCertYou,
        meCanCertYouOn,
        meAlreadyCertYou,
        meReachedMaxByIssuer,
        youCanCertOn,
        canCreateIdty,
        canCalcDistance,
        canCalcDistanceFor,
        waitingForCerts,
        expireOn,
        distRuleOk,
        distRuleRatio,
        currentBlockHeight,
        loaded,
        canTransferIdentity,
        lastOwnerKeyChangeBlock,
      ];
}
