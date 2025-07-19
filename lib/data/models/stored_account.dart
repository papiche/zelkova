import 'dart:typed_data' show Uint8List;

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../g1/g1_v2_helper.dart';
import 'contact.dart';
import 'legacy_wallet.dart';
import 'model_utils.dart';
import 'wallet_themes.dart';

part 'stored_account.g.dart';

enum AccountType {
  v1PasswordLess,
  v1PasswordProtected,
  v2PasswordLess,
  v2PasswordProtected;

  bool get isV1 =>
      this == AccountType.v1PasswordLess ||
      this == AccountType.v1PasswordProtected;

  bool get isV2 =>
      this == AccountType.v2PasswordLess ||
      this == AccountType.v2PasswordProtected;

  bool get isPasswordLess =>
      this == AccountType.v1PasswordLess || this == AccountType.v2PasswordLess;

  bool get isPasswordProtected =>
      this == AccountType.v1PasswordProtected ||
      this == AccountType.v2PasswordProtected;
}

@JsonSerializable()
@CopyWith()
class StoredAccount {
  StoredAccount(
      {required this.pubKey,
      required this.address,
      required this.contact,
      required this.theme,
      required this.type,
      this.seed,
      this.derivationPath,
      this.derivationParentId});

  factory StoredAccount.fromJson(Map<String, dynamic> json) =>
      _$StoredAccountFromJson(json);

  factory StoredAccount.fromLegacy(LegacyWallet e) {
    return StoredAccount(
      pubKey: e.pubKey,
      address: addressFromV1Pubkey(e.pubKey),
      contact: Contact(pubKey: e.pubKey, name: e.name),
      theme: e.theme,
      type: e.seed.isEmpty
          ? AccountType.v1PasswordProtected
          : AccountType.v1PasswordLess,
    );
  }

  final String pubKey;
  final String address;

  // ID primary key
  final String? derivationPath;

  final AccountType type;

  /// Public Contact information (pubkey, name, certificates)
  final Contact contact;

  /// Visual theme
  final WalletTheme theme;

  @JsonKey(fromJson: uIntFromList, toJson: uIntToList)
  final Uint8List? seed;

  /// If the account was derived from another, this field contains the ID of the root account
  final String? derivationParentId;

  Map<String, dynamic> toJson() => _$StoredAccountToJson(this);

  String get title => contact.titleWithoutAddressOrPubKey;
}
