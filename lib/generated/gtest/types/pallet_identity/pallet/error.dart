// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Identity already confirmed.
  idtyAlreadyConfirmed('IdtyAlreadyConfirmed', 0),

  /// Identity already created.
  idtyAlreadyCreated('IdtyAlreadyCreated', 1),

  /// Identity index not found.
  idtyIndexNotFound('IdtyIndexNotFound', 2),

  /// Identity name already exists.
  idtyNameAlreadyExist('IdtyNameAlreadyExist', 3),

  /// Invalid identity name.
  idtyNameInvalid('IdtyNameInvalid', 4),

  /// Identity not found.
  idtyNotFound('IdtyNotFound', 5),

  /// Invalid payload signature.
  invalidSignature('InvalidSignature', 6),

  /// Key used as validator.
  ownerKeyUsedAsValidator('OwnerKeyUsedAsValidator', 7),

  /// Key in bound period.
  ownerKeyInBound('OwnerKeyInBound', 8),

  /// Invalid revocation key.
  invalidRevocationKey('InvalidRevocationKey', 9),

  /// Issuer is not member and can not perform this action.
  issuerNotMember('IssuerNotMember', 10),

  /// Identity creation period is not respected.
  notRespectIdtyCreationPeriod('NotRespectIdtyCreationPeriod', 11),

  /// Owner key already changed recently.
  ownerKeyAlreadyRecentlyChanged('OwnerKeyAlreadyRecentlyChanged', 12),

  /// Owner key already used.
  ownerKeyAlreadyUsed('OwnerKeyAlreadyUsed', 13),

  /// Reverting to an old key is prohibited.
  prohibitedToRevertToAnOldKey('ProhibitedToRevertToAnOldKey', 14),

  /// Already revoked.
  alreadyRevoked('AlreadyRevoked', 15),

  /// Can not revoke identity that never was member.
  canNotRevokeUnconfirmed('CanNotRevokeUnconfirmed', 16),

  /// Can not revoke identity that never was member.
  canNotRevokeUnvalidated('CanNotRevokeUnvalidated', 17),

  /// Cannot link to an inexisting account.
  accountNotExist('AccountNotExist', 18),

  /// Insufficient balance to create an identity.
  insufficientBalance('InsufficientBalance', 19),

  /// Legacy revocation document format is invalid
  invalidLegacyRevocationFormat('InvalidLegacyRevocationFormat', 20);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.idtyAlreadyConfirmed;
      case 1:
        return Error.idtyAlreadyCreated;
      case 2:
        return Error.idtyIndexNotFound;
      case 3:
        return Error.idtyNameAlreadyExist;
      case 4:
        return Error.idtyNameInvalid;
      case 5:
        return Error.idtyNotFound;
      case 6:
        return Error.invalidSignature;
      case 7:
        return Error.ownerKeyUsedAsValidator;
      case 8:
        return Error.ownerKeyInBound;
      case 9:
        return Error.invalidRevocationKey;
      case 10:
        return Error.issuerNotMember;
      case 11:
        return Error.notRespectIdtyCreationPeriod;
      case 12:
        return Error.ownerKeyAlreadyRecentlyChanged;
      case 13:
        return Error.ownerKeyAlreadyUsed;
      case 14:
        return Error.prohibitedToRevertToAnOldKey;
      case 15:
        return Error.alreadyRevoked;
      case 16:
        return Error.canNotRevokeUnconfirmed;
      case 17:
        return Error.canNotRevokeUnvalidated;
      case 18:
        return Error.accountNotExist;
      case 19:
        return Error.insufficientBalance;
      case 20:
        return Error.invalidLegacyRevocationFormat;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
