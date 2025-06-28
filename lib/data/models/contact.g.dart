// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactCWProxy {
  Contact nick(String? nick);

  Contact pubKey(String pubKey);

  Contact address(String? address);

  Contact avatar(Uint8List? avatar);

  Contact avatarCid(String? avatarCid);

  Contact notes(String? notes);

  Contact name(String? name);

  Contact description(String? description);

  Contact city(String? city);

  Contact dataCid(String? dataCid);

  Contact geoLoc(LatLng? geoLoc);

  Contact indexRequestCid(String? indexRequestCid);

  Contact socials(List<Map<String, String>>? socials);

  Contact time(DateTime? time);

  Contact certsIssued(List<Cert>? certsIssued);

  Contact certsReceived(List<Cert>? certsReceived);

  Contact status(IdentityStatus? status);

  Contact isMember(bool? isMember);

  Contact createdOn(int? createdOn);

  Contact index(int? index);

  Contact expireOn(int? expireOn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Contact(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    String? nick,
    String? pubKey,
    String? address,
    Uint8List? avatar,
    String? avatarCid,
    String? notes,
    String? name,
    String? description,
    String? city,
    String? dataCid,
    LatLng? geoLoc,
    String? indexRequestCid,
    List<Map<String, String>>? socials,
    DateTime? time,
    List<Cert>? certsIssued,
    List<Cert>? certsReceived,
    IdentityStatus? status,
    bool? isMember,
    int? createdOn,
    int? index,
    int? expireOn,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfContact.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfContact.copyWith.fieldName(...)`
class _$ContactCWProxyImpl implements _$ContactCWProxy {
  const _$ContactCWProxyImpl(this._value);

  final Contact _value;

  @override
  Contact nick(String? nick) => this(nick: nick);

  @override
  Contact pubKey(String pubKey) => this(pubKey: pubKey);

  @override
  Contact address(String? address) => this(address: address);

  @override
  Contact avatar(Uint8List? avatar) => this(avatar: avatar);

  @override
  Contact avatarCid(String? avatarCid) => this(avatarCid: avatarCid);

  @override
  Contact notes(String? notes) => this(notes: notes);

  @override
  Contact name(String? name) => this(name: name);

  @override
  Contact description(String? description) => this(description: description);

  @override
  Contact city(String? city) => this(city: city);

  @override
  Contact dataCid(String? dataCid) => this(dataCid: dataCid);

  @override
  Contact geoLoc(LatLng? geoLoc) => this(geoLoc: geoLoc);

  @override
  Contact indexRequestCid(String? indexRequestCid) =>
      this(indexRequestCid: indexRequestCid);

  @override
  Contact socials(List<Map<String, String>>? socials) => this(socials: socials);

  @override
  Contact time(DateTime? time) => this(time: time);

  @override
  Contact certsIssued(List<Cert>? certsIssued) =>
      this(certsIssued: certsIssued);

  @override
  Contact certsReceived(List<Cert>? certsReceived) =>
      this(certsReceived: certsReceived);

  @override
  Contact status(IdentityStatus? status) => this(status: status);

  @override
  Contact isMember(bool? isMember) => this(isMember: isMember);

  @override
  Contact createdOn(int? createdOn) => this(createdOn: createdOn);

  @override
  Contact index(int? index) => this(index: index);

  @override
  Contact expireOn(int? expireOn) => this(expireOn: expireOn);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Contact(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    Object? nick = const $CopyWithPlaceholder(),
    Object? pubKey = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? avatar = const $CopyWithPlaceholder(),
    Object? avatarCid = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? dataCid = const $CopyWithPlaceholder(),
    Object? geoLoc = const $CopyWithPlaceholder(),
    Object? indexRequestCid = const $CopyWithPlaceholder(),
    Object? socials = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? certsIssued = const $CopyWithPlaceholder(),
    Object? certsReceived = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? isMember = const $CopyWithPlaceholder(),
    Object? createdOn = const $CopyWithPlaceholder(),
    Object? index = const $CopyWithPlaceholder(),
    Object? expireOn = const $CopyWithPlaceholder(),
  }) {
    return Contact(
      nick: nick == const $CopyWithPlaceholder()
          ? _value.nick
          // ignore: cast_nullable_to_non_nullable
          : nick as String?,
      pubKey: pubKey == const $CopyWithPlaceholder() || pubKey == null
          ? _value.pubKey
          // ignore: cast_nullable_to_non_nullable
          : pubKey as String,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      avatar: avatar == const $CopyWithPlaceholder()
          ? _value.avatar
          // ignore: cast_nullable_to_non_nullable
          : avatar as Uint8List?,
      avatarCid: avatarCid == const $CopyWithPlaceholder()
          ? _value.avatarCid
          // ignore: cast_nullable_to_non_nullable
          : avatarCid as String?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String?,
      dataCid: dataCid == const $CopyWithPlaceholder()
          ? _value.dataCid
          // ignore: cast_nullable_to_non_nullable
          : dataCid as String?,
      geoLoc: geoLoc == const $CopyWithPlaceholder()
          ? _value.geoLoc
          // ignore: cast_nullable_to_non_nullable
          : geoLoc as LatLng?,
      indexRequestCid: indexRequestCid == const $CopyWithPlaceholder()
          ? _value.indexRequestCid
          // ignore: cast_nullable_to_non_nullable
          : indexRequestCid as String?,
      socials: socials == const $CopyWithPlaceholder()
          ? _value.socials
          // ignore: cast_nullable_to_non_nullable
          : socials as List<Map<String, String>>?,
      time: time == const $CopyWithPlaceholder()
          ? _value.time
          // ignore: cast_nullable_to_non_nullable
          : time as DateTime?,
      certsIssued: certsIssued == const $CopyWithPlaceholder()
          ? _value.certsIssued
          // ignore: cast_nullable_to_non_nullable
          : certsIssued as List<Cert>?,
      certsReceived: certsReceived == const $CopyWithPlaceholder()
          ? _value.certsReceived
          // ignore: cast_nullable_to_non_nullable
          : certsReceived as List<Cert>?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as IdentityStatus?,
      isMember: isMember == const $CopyWithPlaceholder()
          ? _value.isMember
          // ignore: cast_nullable_to_non_nullable
          : isMember as bool?,
      createdOn: createdOn == const $CopyWithPlaceholder()
          ? _value.createdOn
          // ignore: cast_nullable_to_non_nullable
          : createdOn as int?,
      index: index == const $CopyWithPlaceholder()
          ? _value.index
          // ignore: cast_nullable_to_non_nullable
          : index as int?,
      expireOn: expireOn == const $CopyWithPlaceholder()
          ? _value.expireOn
          // ignore: cast_nullable_to_non_nullable
          : expireOn as int?,
    );
  }
}

extension $ContactCopyWith on Contact {
  /// Returns a callable class that can be used as follows: `instanceOfContact.copyWith(...)` or like so:`instanceOfContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactCWProxy get copyWith => _$ContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      nick: json['nick'] as String?,
      pubKey: json['pubKey'] as String,
      address: json['address'] as String?,
      avatar: uIntFromList(json['avatar']),
      avatarCid: json['avatarCid'] as String?,
      notes: json['notes'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      city: json['city'] as String?,
      dataCid: json['dataCid'] as String?,
      geoLoc: json['geoLoc'] == null
          ? null
          : LatLng.fromJson(json['geoLoc'] as Map<String, dynamic>),
      indexRequestCid: json['indexRequestCid'] as String?,
      socials: (json['socials'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      certsIssued: (json['certsIssued'] as List<dynamic>?)
          ?.map((e) => Cert.fromJson(e as Map<String, dynamic>))
          .toList(),
      certsReceived: (json['certsReceived'] as List<dynamic>?)
          ?.map((e) => Cert.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecodeNullable(_$IdentityStatusEnumMap, json['status']),
      isMember: json['isMember'] as bool?,
      createdOn: (json['createdOn'] as num?)?.toInt(),
      index: (json['index'] as num?)?.toInt(),
      expireOn: (json['expireOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'nick': instance.nick,
      'pubKey': instance.pubKey,
      'address': instance.address,
      'avatar': uIntToList(instance.avatar),
      'notes': instance.notes,
      'name': instance.name,
      'avatarCid': instance.avatarCid,
      'description': instance.description,
      'city': instance.city,
      'dataCid': instance.dataCid,
      'geoLoc': instance.geoLoc,
      'indexRequestCid': instance.indexRequestCid,
      'socials': instance.socials,
      'time': instance.time?.toIso8601String(),
      'certsReceived': instance.certsReceived,
      'certsIssued': instance.certsIssued,
      'status': _$IdentityStatusEnumMap[instance.status],
      'isMember': instance.isMember,
      'createdOn': instance.createdOn,
      'expireOn': instance.expireOn,
      'index': instance.index,
    };

const _$IdentityStatusEnumMap = {
  IdentityStatus.MEMBER: 'MEMBER',
  IdentityStatus.NOTMEMBER: 'NOTMEMBER',
  IdentityStatus.REMOVED: 'REMOVED',
  IdentityStatus.REVOKED: 'REVOKED',
  IdentityStatus.UNCONFIRMED: 'UNCONFIRMED',
  IdentityStatus.UNVALIDATED: 'UNVALIDATED',
};
