import 'dart:typed_data' show Uint8List;

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'contact.dart';
import 'model_utils.dart';
import 'wallet_themes.dart';

part 'stored_account.g.dart';

enum AccountType {
  v1PasswordLess,
  v1PasswordProtected,
  v2PasswordLess,
  v2PasswordProtected
}

@JsonSerializable()
@CopyWith()
class StoredAccount {
  StoredAccount(
      {required this.pubKey,
      required this.contact,
      required this.theme,
      required this.type,
      this.seed,
      this.derivationPath,
      this.derivationParentId});

  factory StoredAccount.fromJson(Map<String, dynamic> json) =>
      _$StoredAccountFromJson(json);

  final String pubKey; // ID primary key
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
}
