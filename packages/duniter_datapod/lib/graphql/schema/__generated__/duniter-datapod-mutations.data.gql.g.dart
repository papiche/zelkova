// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-datapod-mutations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteProfileData> _$gDeleteProfileDataSerializer =
    _$GDeleteProfileDataSerializer();
Serializer<GDeleteProfileData_deleteProfile>
    _$gDeleteProfileDataDeleteProfileSerializer =
    _$GDeleteProfileData_deleteProfileSerializer();
Serializer<GMigrateProfileData> _$gMigrateProfileDataSerializer =
    _$GMigrateProfileDataSerializer();
Serializer<GMigrateProfileData_migrateProfile>
    _$gMigrateProfileDataMigrateProfileSerializer =
    _$GMigrateProfileData_migrateProfileSerializer();
Serializer<GUpdateProfileData> _$gUpdateProfileDataSerializer =
    _$GUpdateProfileDataSerializer();
Serializer<GUpdateProfileData_updateProfile>
    _$gUpdateProfileDataUpdateProfileSerializer =
    _$GUpdateProfileData_updateProfileSerializer();

class _$GDeleteProfileDataSerializer
    implements StructuredSerializer<GDeleteProfileData> {
  @override
  final Iterable<Type> types = const [GDeleteProfileData, _$GDeleteProfileData];
  @override
  final String wireName = 'GDeleteProfileData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.deleteProfile;
    if (value != null) {
      result
        ..add('deleteProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GDeleteProfileData_deleteProfile)));
    }
    return result;
  }

  @override
  GDeleteProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteProfileDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'deleteProfile':
          result.deleteProfile.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GDeleteProfileData_deleteProfile))!
              as GDeleteProfileData_deleteProfile);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteProfileData_deleteProfileSerializer
    implements StructuredSerializer<GDeleteProfileData_deleteProfile> {
  @override
  final Iterable<Type> types = const [
    GDeleteProfileData_deleteProfile,
    _$GDeleteProfileData_deleteProfile
  ];
  @override
  final String wireName = 'GDeleteProfileData_deleteProfile';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteProfileData_deleteProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteProfileData_deleteProfile deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteProfileData_deleteProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMigrateProfileDataSerializer
    implements StructuredSerializer<GMigrateProfileData> {
  @override
  final Iterable<Type> types = const [
    GMigrateProfileData,
    _$GMigrateProfileData
  ];
  @override
  final String wireName = 'GMigrateProfileData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMigrateProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.migrateProfile;
    if (value != null) {
      result
        ..add('migrateProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GMigrateProfileData_migrateProfile)));
    }
    return result;
  }

  @override
  GMigrateProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMigrateProfileDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'migrateProfile':
          result.migrateProfile.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GMigrateProfileData_migrateProfile))!
              as GMigrateProfileData_migrateProfile);
          break;
      }
    }

    return result.build();
  }
}

class _$GMigrateProfileData_migrateProfileSerializer
    implements StructuredSerializer<GMigrateProfileData_migrateProfile> {
  @override
  final Iterable<Type> types = const [
    GMigrateProfileData_migrateProfile,
    _$GMigrateProfileData_migrateProfile
  ];
  @override
  final String wireName = 'GMigrateProfileData_migrateProfile';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMigrateProfileData_migrateProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMigrateProfileData_migrateProfile deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMigrateProfileData_migrateProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileDataSerializer
    implements StructuredSerializer<GUpdateProfileData> {
  @override
  final Iterable<Type> types = const [GUpdateProfileData, _$GUpdateProfileData];
  @override
  final String wireName = 'GUpdateProfileData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.updateProfile;
    if (value != null) {
      result
        ..add('updateProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GUpdateProfileData_updateProfile)));
    }
    return result;
  }

  @override
  GUpdateProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateProfileDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'updateProfile':
          result.updateProfile.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateProfileData_updateProfile))!
              as GUpdateProfileData_updateProfile);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfileSerializer
    implements StructuredSerializer<GUpdateProfileData_updateProfile> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile,
    _$GUpdateProfileData_updateProfile
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateProfileData_updateProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateProfileData_updateProfile deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateProfileData_updateProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteProfileData extends GDeleteProfileData {
  @override
  final String G__typename;
  @override
  final GDeleteProfileData_deleteProfile? deleteProfile;

  factory _$GDeleteProfileData(
          [void Function(GDeleteProfileDataBuilder)? updates]) =>
      (GDeleteProfileDataBuilder()..update(updates))._build();

  _$GDeleteProfileData._({required this.G__typename, this.deleteProfile})
      : super._();
  @override
  GDeleteProfileData rebuild(
          void Function(GDeleteProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteProfileDataBuilder toBuilder() =>
      GDeleteProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteProfileData &&
        G__typename == other.G__typename &&
        deleteProfile == other.deleteProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteProfileData')
          ..add('G__typename', G__typename)
          ..add('deleteProfile', deleteProfile))
        .toString();
  }
}

class GDeleteProfileDataBuilder
    implements Builder<GDeleteProfileData, GDeleteProfileDataBuilder> {
  _$GDeleteProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteProfileData_deleteProfileBuilder? _deleteProfile;
  GDeleteProfileData_deleteProfileBuilder get deleteProfile =>
      _$this._deleteProfile ??= GDeleteProfileData_deleteProfileBuilder();
  set deleteProfile(GDeleteProfileData_deleteProfileBuilder? deleteProfile) =>
      _$this._deleteProfile = deleteProfile;

  GDeleteProfileDataBuilder() {
    GDeleteProfileData._initializeBuilder(this);
  }

  GDeleteProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteProfile = $v.deleteProfile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteProfileData other) {
    _$v = other as _$GDeleteProfileData;
  }

  @override
  void update(void Function(GDeleteProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteProfileData build() => _build();

  _$GDeleteProfileData _build() {
    _$GDeleteProfileData _$result;
    try {
      _$result = _$v ??
          _$GDeleteProfileData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GDeleteProfileData', 'G__typename'),
            deleteProfile: _deleteProfile?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'deleteProfile';
        _deleteProfile?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GDeleteProfileData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteProfileData_deleteProfile
    extends GDeleteProfileData_deleteProfile {
  @override
  final String G__typename;
  @override
  final bool success;
  @override
  final String message;

  factory _$GDeleteProfileData_deleteProfile(
          [void Function(GDeleteProfileData_deleteProfileBuilder)? updates]) =>
      (GDeleteProfileData_deleteProfileBuilder()..update(updates))._build();

  _$GDeleteProfileData_deleteProfile._(
      {required this.G__typename, required this.success, required this.message})
      : super._();
  @override
  GDeleteProfileData_deleteProfile rebuild(
          void Function(GDeleteProfileData_deleteProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteProfileData_deleteProfileBuilder toBuilder() =>
      GDeleteProfileData_deleteProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteProfileData_deleteProfile &&
        G__typename == other.G__typename &&
        success == other.success &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteProfileData_deleteProfile')
          ..add('G__typename', G__typename)
          ..add('success', success)
          ..add('message', message))
        .toString();
  }
}

class GDeleteProfileData_deleteProfileBuilder
    implements
        Builder<GDeleteProfileData_deleteProfile,
            GDeleteProfileData_deleteProfileBuilder> {
  _$GDeleteProfileData_deleteProfile? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GDeleteProfileData_deleteProfileBuilder() {
    GDeleteProfileData_deleteProfile._initializeBuilder(this);
  }

  GDeleteProfileData_deleteProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _success = $v.success;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteProfileData_deleteProfile other) {
    _$v = other as _$GDeleteProfileData_deleteProfile;
  }

  @override
  void update(void Function(GDeleteProfileData_deleteProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteProfileData_deleteProfile build() => _build();

  _$GDeleteProfileData_deleteProfile _build() {
    final _$result = _$v ??
        _$GDeleteProfileData_deleteProfile._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GDeleteProfileData_deleteProfile', 'G__typename'),
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'GDeleteProfileData_deleteProfile', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'GDeleteProfileData_deleteProfile', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMigrateProfileData extends GMigrateProfileData {
  @override
  final String G__typename;
  @override
  final GMigrateProfileData_migrateProfile? migrateProfile;

  factory _$GMigrateProfileData(
          [void Function(GMigrateProfileDataBuilder)? updates]) =>
      (GMigrateProfileDataBuilder()..update(updates))._build();

  _$GMigrateProfileData._({required this.G__typename, this.migrateProfile})
      : super._();
  @override
  GMigrateProfileData rebuild(
          void Function(GMigrateProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMigrateProfileDataBuilder toBuilder() =>
      GMigrateProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMigrateProfileData &&
        G__typename == other.G__typename &&
        migrateProfile == other.migrateProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, migrateProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMigrateProfileData')
          ..add('G__typename', G__typename)
          ..add('migrateProfile', migrateProfile))
        .toString();
  }
}

class GMigrateProfileDataBuilder
    implements Builder<GMigrateProfileData, GMigrateProfileDataBuilder> {
  _$GMigrateProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMigrateProfileData_migrateProfileBuilder? _migrateProfile;
  GMigrateProfileData_migrateProfileBuilder get migrateProfile =>
      _$this._migrateProfile ??= GMigrateProfileData_migrateProfileBuilder();
  set migrateProfile(
          GMigrateProfileData_migrateProfileBuilder? migrateProfile) =>
      _$this._migrateProfile = migrateProfile;

  GMigrateProfileDataBuilder() {
    GMigrateProfileData._initializeBuilder(this);
  }

  GMigrateProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _migrateProfile = $v.migrateProfile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMigrateProfileData other) {
    _$v = other as _$GMigrateProfileData;
  }

  @override
  void update(void Function(GMigrateProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMigrateProfileData build() => _build();

  _$GMigrateProfileData _build() {
    _$GMigrateProfileData _$result;
    try {
      _$result = _$v ??
          _$GMigrateProfileData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMigrateProfileData', 'G__typename'),
            migrateProfile: _migrateProfile?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'migrateProfile';
        _migrateProfile?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMigrateProfileData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMigrateProfileData_migrateProfile
    extends GMigrateProfileData_migrateProfile {
  @override
  final String G__typename;
  @override
  final bool success;
  @override
  final String message;

  factory _$GMigrateProfileData_migrateProfile(
          [void Function(GMigrateProfileData_migrateProfileBuilder)?
              updates]) =>
      (GMigrateProfileData_migrateProfileBuilder()..update(updates))._build();

  _$GMigrateProfileData_migrateProfile._(
      {required this.G__typename, required this.success, required this.message})
      : super._();
  @override
  GMigrateProfileData_migrateProfile rebuild(
          void Function(GMigrateProfileData_migrateProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMigrateProfileData_migrateProfileBuilder toBuilder() =>
      GMigrateProfileData_migrateProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMigrateProfileData_migrateProfile &&
        G__typename == other.G__typename &&
        success == other.success &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMigrateProfileData_migrateProfile')
          ..add('G__typename', G__typename)
          ..add('success', success)
          ..add('message', message))
        .toString();
  }
}

class GMigrateProfileData_migrateProfileBuilder
    implements
        Builder<GMigrateProfileData_migrateProfile,
            GMigrateProfileData_migrateProfileBuilder> {
  _$GMigrateProfileData_migrateProfile? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GMigrateProfileData_migrateProfileBuilder() {
    GMigrateProfileData_migrateProfile._initializeBuilder(this);
  }

  GMigrateProfileData_migrateProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _success = $v.success;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMigrateProfileData_migrateProfile other) {
    _$v = other as _$GMigrateProfileData_migrateProfile;
  }

  @override
  void update(
      void Function(GMigrateProfileData_migrateProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMigrateProfileData_migrateProfile build() => _build();

  _$GMigrateProfileData_migrateProfile _build() {
    final _$result = _$v ??
        _$GMigrateProfileData_migrateProfile._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMigrateProfileData_migrateProfile', 'G__typename'),
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'GMigrateProfileData_migrateProfile', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'GMigrateProfileData_migrateProfile', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileData extends GUpdateProfileData {
  @override
  final String G__typename;
  @override
  final GUpdateProfileData_updateProfile? updateProfile;

  factory _$GUpdateProfileData(
          [void Function(GUpdateProfileDataBuilder)? updates]) =>
      (GUpdateProfileDataBuilder()..update(updates))._build();

  _$GUpdateProfileData._({required this.G__typename, this.updateProfile})
      : super._();
  @override
  GUpdateProfileData rebuild(
          void Function(GUpdateProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileDataBuilder toBuilder() =>
      GUpdateProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData &&
        G__typename == other.G__typename &&
        updateProfile == other.updateProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileData')
          ..add('G__typename', G__typename)
          ..add('updateProfile', updateProfile))
        .toString();
  }
}

class GUpdateProfileDataBuilder
    implements Builder<GUpdateProfileData, GUpdateProfileDataBuilder> {
  _$GUpdateProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateProfileData_updateProfileBuilder? _updateProfile;
  GUpdateProfileData_updateProfileBuilder get updateProfile =>
      _$this._updateProfile ??= GUpdateProfileData_updateProfileBuilder();
  set updateProfile(GUpdateProfileData_updateProfileBuilder? updateProfile) =>
      _$this._updateProfile = updateProfile;

  GUpdateProfileDataBuilder() {
    GUpdateProfileData._initializeBuilder(this);
  }

  GUpdateProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateProfile = $v.updateProfile?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData other) {
    _$v = other as _$GUpdateProfileData;
  }

  @override
  void update(void Function(GUpdateProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData build() => _build();

  _$GUpdateProfileData _build() {
    _$GUpdateProfileData _$result;
    try {
      _$result = _$v ??
          _$GUpdateProfileData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUpdateProfileData', 'G__typename'),
            updateProfile: _updateProfile?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateProfile';
        _updateProfile?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUpdateProfileData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileData_updateProfile
    extends GUpdateProfileData_updateProfile {
  @override
  final String G__typename;
  @override
  final bool success;
  @override
  final String message;

  factory _$GUpdateProfileData_updateProfile(
          [void Function(GUpdateProfileData_updateProfileBuilder)? updates]) =>
      (GUpdateProfileData_updateProfileBuilder()..update(updates))._build();

  _$GUpdateProfileData_updateProfile._(
      {required this.G__typename, required this.success, required this.message})
      : super._();
  @override
  GUpdateProfileData_updateProfile rebuild(
          void Function(GUpdateProfileData_updateProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfileBuilder toBuilder() =>
      GUpdateProfileData_updateProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile &&
        G__typename == other.G__typename &&
        success == other.success &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileData_updateProfile')
          ..add('G__typename', G__typename)
          ..add('success', success)
          ..add('message', message))
        .toString();
  }
}

class GUpdateProfileData_updateProfileBuilder
    implements
        Builder<GUpdateProfileData_updateProfile,
            GUpdateProfileData_updateProfileBuilder> {
  _$GUpdateProfileData_updateProfile? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GUpdateProfileData_updateProfileBuilder() {
    GUpdateProfileData_updateProfile._initializeBuilder(this);
  }

  GUpdateProfileData_updateProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _success = $v.success;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData_updateProfile other) {
    _$v = other as _$GUpdateProfileData_updateProfile;
  }

  @override
  void update(void Function(GUpdateProfileData_updateProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile build() => _build();

  _$GUpdateProfileData_updateProfile _build() {
    final _$result = _$v ??
        _$GUpdateProfileData_updateProfile._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUpdateProfileData_updateProfile', 'G__typename'),
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'GUpdateProfileData_updateProfile', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'GUpdateProfileData_updateProfile', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
