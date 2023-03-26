// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactCWProxy {
  Contact nick(String? nick);

  Contact pubKey(String pubKey);

  Contact avatar(Uint8List? avatar);

  Contact notes(String? notes);

  Contact name(String? name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Contact(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Contact(...).copyWith(id: 12, name: "My name")
  /// ````
  Contact call({
    String? nick,
    String? pubKey,
    Uint8List? avatar,
    String? notes,
    String? name,
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
  Contact avatar(Uint8List? avatar) => this(avatar: avatar);

  @override
  Contact notes(String? notes) => this(notes: notes);

  @override
  Contact name(String? name) => this(name: name);

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
    Object? avatar = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
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
      avatar: uIntFromList(json['avatar']),
      notes: json['notes'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'nick': instance.nick,
      'pubKey': instance.pubKey,
      'avatar': uIntToList(instance.avatar),
      'notes': instance.notes,
      'name': instance.name,
    };
