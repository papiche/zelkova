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

  Contact notes(String? notes);

  Contact name(String? name);

  Contact avatarCid(String? avatarCid);

  Contact description(String? description);

  Contact city(String? city);

  Contact dataCid(String? dataCid);

  Contact geoLoc(LatLng? geoLoc);

  Contact indexRequestCid(String? indexRequestCid);

  Contact socials(List<Map<String, String>>? socials);

  Contact time(DateTime? time);

  Contact certifiedFrom(List<String>? certifiedFrom);

  Contact certifiedTo(List<String>? certifiedTo);

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
    String? notes,
    String? name,
    String? avatarCid,
    String? description,
    String? city,
    String? dataCid,
    LatLng? geoLoc,
    String? indexRequestCid,
    List<Map<String, String>>? socials,
    DateTime? time,
    List<String>? certifiedFrom,
    List<String>? certifiedTo,
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
  Contact notes(String? notes) => this(notes: notes);

  @override
  Contact name(String? name) => this(name: name);

  @override
  Contact avatarCid(String? avatarCid) => this(avatarCid: avatarCid);

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
  Contact certifiedFrom(List<String>? certifiedFrom) =>
      this(certifiedFrom: certifiedFrom);

  @override
  Contact certifiedTo(List<String>? certifiedTo) =>
      this(certifiedTo: certifiedTo);

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
    Object? notes = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? avatarCid = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? dataCid = const $CopyWithPlaceholder(),
    Object? geoLoc = const $CopyWithPlaceholder(),
    Object? indexRequestCid = const $CopyWithPlaceholder(),
    Object? socials = const $CopyWithPlaceholder(),
    Object? time = const $CopyWithPlaceholder(),
    Object? certifiedFrom = const $CopyWithPlaceholder(),
    Object? certifiedTo = const $CopyWithPlaceholder(),
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
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      avatarCid: avatarCid == const $CopyWithPlaceholder()
          ? _value.avatarCid
          // ignore: cast_nullable_to_non_nullable
          : avatarCid as String?,
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
      certifiedFrom: certifiedFrom == const $CopyWithPlaceholder()
          ? _value.certifiedFrom
          // ignore: cast_nullable_to_non_nullable
          : certifiedFrom as List<String>?,
      certifiedTo: certifiedTo == const $CopyWithPlaceholder()
          ? _value.certifiedTo
          // ignore: cast_nullable_to_non_nullable
          : certifiedTo as List<String>?,
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
      notes: json['notes'] as String?,
      name: json['name'] as String?,
      avatarCid: json['avatarCid'] as String?,
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
      certifiedFrom: (json['certifiedFrom'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      certifiedTo: (json['certifiedTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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
      'certifiedTo': instance.certifiedTo,
      'certifiedFrom': instance.certifiedFrom,
    };
