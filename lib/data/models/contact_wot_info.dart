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

  bool? canCert;
  bool? canCreateIdty;
  bool? canCalcDistance;
  bool? canCalcDistanceFor;
  bool? waitingForCerts;
  bool? alreadyCert;
  DateTime? canCertOn;
  DateTime? expireOn;
  bool? distRuleOk;
  double? distRuleRatio;
  int? currentBlockHeight;
  bool loaded = false;

  bool get isme => isMe(you, me.pubKey);

  @override
  String toString() {
    return 'ContactWotInfo{me: ${humanizeContact('', me)}, you: ${humanizeContact('', you)}, canCert: $canCert, canCreateIdty: $canCreateIdty}, waitingForCert: $waitingForCerts}';
  }

  @override
  List<Object?> get props => <Object?>[
        me,
        you,
        canCert,
        canCreateIdty,
        canCalcDistance,
        canCalcDistanceFor,
        waitingForCerts,
        alreadyCert,
        canCertOn,
        expireOn,
        distRuleOk,
        distRuleRatio,
        currentBlockHeight,
        loaded
      ];
}
