// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_account.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoredAccountCWProxy {
  StoredAccount pubKey(String pubKey);

  StoredAccount address(String address);

  StoredAccount contact(Contact contact);

  StoredAccount theme(WalletTheme theme);

  StoredAccount type(AccountType type);

  StoredAccount seed(Uint8List? seed);

  StoredAccount derivationPath(String? derivationPath);

  StoredAccount derivationParentId(String? derivationParentId);

  StoredAccount lastUsed(int? lastUsed);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoredAccount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoredAccount(...).copyWith(id: 12, name: "My name")
  /// ````
  StoredAccount call({
    String pubKey,
    String address,
    Contact contact,
    WalletTheme theme,
    AccountType type,
    Uint8List? seed,
    String? derivationPath,
    String? derivationParentId,
    int? lastUsed,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStoredAccount.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStoredAccount.copyWith.fieldName(...)`
class _$StoredAccountCWProxyImpl implements _$StoredAccountCWProxy {
  const _$StoredAccountCWProxyImpl(this._value);

  final StoredAccount _value;

  @override
  StoredAccount pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  StoredAccount address(String address) => this(address: address);

  @override
  StoredAccount contact(Contact contact) => this(contact: contact);

  @override
  StoredAccount theme(WalletTheme theme) => this(theme: theme);

  @override
  StoredAccount type(AccountType type) => this(type: type);

  @override
  StoredAccount seed(Uint8List? seed) => this(seed: seed);

  @override
  StoredAccount derivationPath(String? derivationPath) =>
      this(derivationPath: derivationPath);

  @override
  StoredAccount derivationParentId(String? derivationParentId) =>
      this(derivationParentId: derivationParentId);

  @override
  StoredAccount lastUsed(int? lastUsed) => this(lastUsed: lastUsed);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoredAccount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoredAccount(...).copyWith(id: 12, name: "My name")
  /// ````
  StoredAccount call({
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? contact = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? seed = const $CopyWithPlaceholder(),
    Object? derivationPath = const $CopyWithPlaceholder(),
    Object? derivationParentId = const $CopyWithPlaceholder(),
    Object? lastUsed = const $CopyWithPlaceholder(),
  }) {
    return StoredAccount(
      pubKey: pubKey == const $CopyWithPlaceholder()
          ? _value.pubKey
          // ignore: cast_nullable_to_non_nullable
          : pubKey as String,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      contact: contact == const $CopyWithPlaceholder()
          ? _value.contact
          // ignore: cast_nullable_to_non_nullable
          : contact as Contact,
      theme: theme == const $CopyWithPlaceholder()
          ? _value.theme
          // ignore: cast_nullable_to_non_nullable
          : theme as WalletTheme,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as AccountType,
      seed: seed == const $CopyWithPlaceholder()
          ? _value.seed
          // ignore: cast_nullable_to_non_nullable
          : seed as Uint8List?,
      derivationPath: derivationPath == const $CopyWithPlaceholder()
          ? _value.derivationPath
          // ignore: cast_nullable_to_non_nullable
          : derivationPath as String?,
      derivationParentId: derivationParentId == const $CopyWithPlaceholder()
          ? _value.derivationParentId
          // ignore: cast_nullable_to_non_nullable
          : derivationParentId as String?,
      lastUsed: lastUsed == const $CopyWithPlaceholder()
          ? _value.lastUsed
          // ignore: cast_nullable_to_non_nullable
          : lastUsed as int?,
    );
  }
}

extension $StoredAccountCopyWith on StoredAccount {
  /// Returns a callable class that can be used as follows: `instanceOfStoredAccount.copyWith(...)` or like so:`instanceOfStoredAccount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StoredAccountCWProxy get copyWith => _$StoredAccountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredAccount _$StoredAccountFromJson(Map<String, dynamic> json) =>
    StoredAccount(
      pubKey: json['pubKey'] as String,
      address: json['address'] as String,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      theme: WalletTheme.fromJson(json['theme'] as Map<String, dynamic>),
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
      seed: uIntFromList(json['seed']),
      derivationPath: json['derivationPath'] as String?,
      derivationParentId: json['derivationParentId'] as String?,
      lastUsed: (json['lastUsed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoredAccountToJson(StoredAccount instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'address': instance.address,
      'derivationPath': instance.derivationPath,
      'type': _$AccountTypeEnumMap[instance.type]!,
      'contact': instance.contact,
      'theme': instance.theme,
      'seed': uIntToList(instance.seed),
      'derivationParentId': instance.derivationParentId,
      'lastUsed': instance.lastUsed,
    };

const _$AccountTypeEnumMap = {
  AccountType.v1PasswordLess: 'v1PasswordLess',
  AccountType.v1PasswordProtected: 'v1PasswordProtected',
  AccountType.v2PasswordLess: 'v2PasswordLess',
  AccountType.v2PasswordProtected: 'v2PasswordProtected',
};
