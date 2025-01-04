import '../../ui/ui_helpers.dart';
import 'contact.dart';

class ContactWotInfo {
  ContactWotInfo({
    required this.me,
    required this.you,
  });

  final Contact me;
  final Contact you;
  bool? canCert;
  bool? canCreateIdty;
  bool? canCalcDistance;
  bool? waitingForCerts;
  bool? alreadyCert;
  DateTime? canCertOn;
  DateTime? expireOn;
  bool? distRuleOk;
  double? distRuleRatio;
  int? currentBlockHeight;

  @override
  String toString() {
    return 'ContactWotInfo{me: ${humanizeContact('', me)}, you: ${humanizeContact('', you)}, canCert: $canCert, canCreateIdty: $canCreateIdty}, waitingForCert: $waitingForCerts}';
  }
}
