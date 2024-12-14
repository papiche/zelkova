import '../../ui/logger.dart';

enum IdentityStatus {
  MEMBER,
  NOTMEMBER,
  REMOVED,
  REVOKED,
  UNCONFIRMED,
  UNVALIDATED
}

IdentityStatus? parseIdentityStatus(String? state) {
  switch (state?.toUpperCase()) {
    case 'MEMBER':
      return IdentityStatus.MEMBER;
    case 'NOTMEMBER':
      return IdentityStatus.NOTMEMBER;
    case 'REMOVED':
      return IdentityStatus.REMOVED;
    case 'REVOKED':
      return IdentityStatus.REVOKED;
    case 'UNCONFIRMED':
      return IdentityStatus.UNCONFIRMED;
    case 'UNVALIDATED':
      return IdentityStatus.UNVALIDATED;
    default:
      if (state != null) {
        log.e('Unknown identity state: $state');
      }
      return null;
  }
}
