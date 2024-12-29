import 'contact.dart';
import 'identity_status.dart';

class ContactWotInfo {
  ContactWotInfo({
    required this.me,
    required this.you,
  });

  final Contact me;
  final Contact you;
  bool? canCert;
  bool? canCreateIdty;

  bool get isMe {
    return me.pubKey == you.pubKey;
  }

  bool get isMember {
    return you.status == IdentityStatus.MEMBER;
  }

  bool get iAmMember {
    return me.status == IdentityStatus.MEMBER;
  }
}
