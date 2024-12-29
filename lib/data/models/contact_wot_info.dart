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
  bool? waitingForCerts;

  @override
  String toString() {
    return 'ContactWotInfo{me: ${humanizeContact('', me)}, you: ${humanizeContact('', you)}, canCert: $canCert, canCreateIdty: $canCreateIdty}, waitingForCert: $waitingForCerts}';
  }
}
