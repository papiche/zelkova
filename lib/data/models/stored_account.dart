import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';
import 'wallet_themes.dart';

part 'stored_account.g.dart';

@JsonSerializable()
@CopyWith()
class StoredAccount {
  StoredAccount({
    required this.pubKey,
    required this.index,
    required this.contact,
    required this.theme,
    this.seed,
    this.seedEnc,
    this.derivationParentId,
  });

  factory StoredAccount.fromJson(Map<String, dynamic> json) =>
      _$StoredAccountFromJson(json);

  final String pubKey; // ID primary key
  final int index;

  /// Public Contact information (pubkey, name, certificates)
  final Contact contact;

  /// Visual theme
  final WalletTheme theme;

  /// Unencrypted seed if the account is not protected, null if protected
  final String? seed;

  /// Encrypted (base64) seed if the account is protected, null if unprotected
  final String? seedEnc;

  /// If the account was derived from another, this field contains the ID of the root account
  final String? derivationParentId;

  Map<String, dynamic> toJson() => _$StoredAccountToJson(this);
}
