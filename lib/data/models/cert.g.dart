// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cert.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CertCWProxy {
  Cert id(String id);

  Cert issuerId(Contact issuerId);

  Cert receiverId(Contact receiverId);

  Cert createdOn(int createdOn);

  Cert expireOn(int expireOn);

  Cert isActive(bool isActive);

  Cert updatedOn(int updatedOn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Cert(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Cert(...).copyWith(id: 12, name: "My name")
  /// ````
  Cert call({
    String id,
    Contact issuerId,
    Contact receiverId,
    int createdOn,
    int expireOn,
    bool isActive,
    int updatedOn,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCert.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCert.copyWith.fieldName(...)`
class _$CertCWProxyImpl implements _$CertCWProxy {
  const _$CertCWProxyImpl(this._value);

  final Cert _value;

  @override
  Cert id(String id) => this(id: id);

  @override
  Cert issuerId(Contact issuerId) => this(issuerId: issuerId);

  @override
  Cert receiverId(Contact receiverId) => this(receiverId: receiverId);

  @override
  Cert createdOn(int createdOn) => this(createdOn: createdOn);

  @override
  Cert expireOn(int expireOn) => this(expireOn: expireOn);

  @override
  Cert isActive(bool isActive) => this(isActive: isActive);

  @override
  Cert updatedOn(int updatedOn) => this(updatedOn: updatedOn);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Cert(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Cert(...).copyWith(id: 12, name: "My name")
  /// ````
  Cert call({
    Object? id = const $CopyWithPlaceholder(),
    Object? issuerId = const $CopyWithPlaceholder(),
    Object? receiverId = const $CopyWithPlaceholder(),
    Object? createdOn = const $CopyWithPlaceholder(),
    Object? expireOn = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? updatedOn = const $CopyWithPlaceholder(),
  }) {
    return Cert(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      issuerId: issuerId == const $CopyWithPlaceholder()
          ? _value.issuerId
          // ignore: cast_nullable_to_non_nullable
          : issuerId as Contact,
      receiverId: receiverId == const $CopyWithPlaceholder()
          ? _value.receiverId
          // ignore: cast_nullable_to_non_nullable
          : receiverId as Contact,
      createdOn: createdOn == const $CopyWithPlaceholder()
          ? _value.createdOn
          // ignore: cast_nullable_to_non_nullable
          : createdOn as int,
      expireOn: expireOn == const $CopyWithPlaceholder()
          ? _value.expireOn
          // ignore: cast_nullable_to_non_nullable
          : expireOn as int,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      updatedOn: updatedOn == const $CopyWithPlaceholder()
          ? _value.updatedOn
          // ignore: cast_nullable_to_non_nullable
          : updatedOn as int,
    );
  }
}

extension $CertCopyWith on Cert {
  /// Returns a callable class that can be used as follows: `instanceOfCert.copyWith(...)` or like so:`instanceOfCert.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CertCWProxy get copyWith => _$CertCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cert _$CertFromJson(Map<String, dynamic> json) => Cert(
      id: json['id'] as String,
      issuerId: Contact.fromJson(json['issuerId'] as Map<String, dynamic>),
      receiverId: Contact.fromJson(json['receiverId'] as Map<String, dynamic>),
      createdOn: (json['createdOn'] as num).toInt(),
      expireOn: (json['expireOn'] as num).toInt(),
      isActive: json['isActive'] as bool,
      updatedOn: (json['updatedOn'] as num).toInt(),
    );

Map<String, dynamic> _$CertToJson(Cert instance) => <String, dynamic>{
      'id': instance.id,
      'issuerId': instance.issuerId,
      'receiverId': instance.receiverId,
      'createdOn': instance.createdOn,
      'expireOn': instance.expireOn,
      'isActive': instance.isActive,
      'updatedOn': instance.updatedOn,
    };
