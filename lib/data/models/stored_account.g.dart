// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_account.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StoredAccountCWProxy {
  StoredAccount pubKey(String pubKey);

  StoredAccount index(int index);

  StoredAccount contact(Contact contact);

  StoredAccount theme(WalletTheme theme);

  StoredAccount seed(String? seed);

  StoredAccount seedEnc(String? seedEnc);

  StoredAccount derivationParentId(String? derivationParentId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoredAccount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoredAccount(...).copyWith(id: 12, name: "My name")
  /// ````
  StoredAccount call({
    String? pubKey,
    int? index,
    Contact? contact,
    WalletTheme? theme,
    String? seed,
    String? seedEnc,
    String? derivationParentId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStoredAccount.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStoredAccount.copyWith.fieldName(...)`
class _$StoredAccountCWProxyImpl implements _$StoredAccountCWProxy {
  const _$StoredAccountCWProxyImpl(this._value);

  final StoredAccount _value;

  @override
  StoredAccount pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  StoredAccount index(int index) => this(index: index);

  @override
  StoredAccount contact(Contact contact) => this(contact: contact);

  @override
  StoredAccount theme(WalletTheme theme) => this(theme: theme);

  @override
  StoredAccount seed(String? seed) => this(seed: seed);

  @override
  StoredAccount seedEnc(String? seedEnc) => this(seedEnc: seedEnc);

  @override
  StoredAccount derivationParentId(String? derivationParentId) =>
      this(derivationParentId: derivationParentId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StoredAccount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StoredAccount(...).copyWith(id: 12, name: "My name")
  /// ````
  StoredAccount call({
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? index = const $CopyWithPlaceholder(),
    Object? contact = const $CopyWithPlaceholder(),
    Object? theme = const $CopyWithPlaceholder(),
    Object? seed = const $CopyWithPlaceholder(),
    Object? seedEnc = const $CopyWithPlaceholder(),
    Object? derivationParentId = const $CopyWithPlaceholder(),
  }) {
    return StoredAccount(
      pubKey: pubKey == const $CopyWithPlaceholder() || pubKey == null
          ? _value.pubKey
          // ignore: cast_nullable_to_non_nullable
          : pubKey as String,
      index: index == const $CopyWithPlaceholder() || index == null
          ? _value.index
          // ignore: cast_nullable_to_non_nullable
          : index as int,
      contact: contact == const $CopyWithPlaceholder() || contact == null
          ? _value.contact
          // ignore: cast_nullable_to_non_nullable
          : contact as Contact,
      theme: theme == const $CopyWithPlaceholder() || theme == null
          ? _value.theme
          // ignore: cast_nullable_to_non_nullable
          : theme as WalletTheme,
      seed: seed == const $CopyWithPlaceholder()
          ? _value.seed
          // ignore: cast_nullable_to_non_nullable
          : seed as String?,
      seedEnc: seedEnc == const $CopyWithPlaceholder()
          ? _value.seedEnc
          // ignore: cast_nullable_to_non_nullable
          : seedEnc as String?,
      derivationParentId: derivationParentId == const $CopyWithPlaceholder()
          ? _value.derivationParentId
          // ignore: cast_nullable_to_non_nullable
          : derivationParentId as String?,
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
      index: (json['index'] as num).toInt(),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      theme: WalletTheme.fromJson(json['theme'] as Map<String, dynamic>),
      seed: json['seed'] as String?,
      seedEnc: json['seedEnc'] as String?,
      derivationParentId: json['derivationParentId'] as String?,
    );

Map<String, dynamic> _$StoredAccountToJson(StoredAccount instance) =>
    <String, dynamic>{
      'pubKey': instance.pubKey,
      'index': instance.index,
      'contact': instance.contact,
      'theme': instance.theme,
      'seed': instance.seed,
      'seedEnc': instance.seedEnc,
      'derivationParentId': instance.derivationParentId,
    };
