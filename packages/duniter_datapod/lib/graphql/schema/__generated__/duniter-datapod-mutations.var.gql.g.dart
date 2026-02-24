// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-datapod-mutations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteProfileVars> _$gDeleteProfileVarsSerializer =
    _$GDeleteProfileVarsSerializer();
Serializer<GMigrateProfileVars> _$gMigrateProfileVarsSerializer =
    _$GMigrateProfileVarsSerializer();
Serializer<GUpdateProfileVars> _$gUpdateProfileVarsSerializer =
    _$GUpdateProfileVarsSerializer();

class _$GDeleteProfileVarsSerializer
    implements StructuredSerializer<GDeleteProfileVars> {
  @override
  final Iterable<Type> types = const [GDeleteProfileVars, _$GDeleteProfileVars];
  @override
  final String wireName = 'GDeleteProfileVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'signature',
      serializers.serialize(object.signature,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'signature':
          result.signature = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMigrateProfileVarsSerializer
    implements StructuredSerializer<GMigrateProfileVars> {
  @override
  final Iterable<Type> types = const [
    GMigrateProfileVars,
    _$GMigrateProfileVars
  ];
  @override
  final String wireName = 'GMigrateProfileVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMigrateProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'addressNew',
      serializers.serialize(object.addressNew,
          specifiedType: const FullType(String)),
      'addressOld',
      serializers.serialize(object.addressOld,
          specifiedType: const FullType(String)),
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'signature',
      serializers.serialize(object.signature,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMigrateProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMigrateProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'addressNew':
          result.addressNew = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'addressOld':
          result.addressOld = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'signature':
          result.signature = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileVarsSerializer
    implements StructuredSerializer<GUpdateProfileVars> {
  @override
  final Iterable<Type> types = const [GUpdateProfileVars, _$GUpdateProfileVars];
  @override
  final String wireName = 'GUpdateProfileVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'hash',
      serializers.serialize(object.hash, specifiedType: const FullType(String)),
      'signature',
      serializers.serialize(object.signature,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.avatarBase64;
    if (value != null) {
      result
        ..add('avatarBase64')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.geoloc;
    if (value != null) {
      result
        ..add('geoloc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GGeolocInput)));
    }
    value = object.socials;
    if (value != null) {
      result
        ..add('socials')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(_i2.GSocialInput)])));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'avatarBase64':
          result.avatarBase64 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'geoloc':
          result.geoloc.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GGeolocInput))!
              as _i2.GGeolocInput);
          break;
        case 'hash':
          result.hash = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'signature':
          result.signature = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'socials':
          result.socials.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(_i2.GSocialInput)]))!
              as BuiltList<Object?>);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteProfileVars extends GDeleteProfileVars {
  @override
  final String address;
  @override
  final String hash;
  @override
  final String signature;

  factory _$GDeleteProfileVars(
          [void Function(GDeleteProfileVarsBuilder)? updates]) =>
      (GDeleteProfileVarsBuilder()..update(updates))._build();

  _$GDeleteProfileVars._(
      {required this.address, required this.hash, required this.signature})
      : super._();
  @override
  GDeleteProfileVars rebuild(
          void Function(GDeleteProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteProfileVarsBuilder toBuilder() =>
      GDeleteProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteProfileVars &&
        address == other.address &&
        hash == other.hash &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteProfileVars')
          ..add('address', address)
          ..add('hash', hash)
          ..add('signature', signature))
        .toString();
  }
}

class GDeleteProfileVarsBuilder
    implements Builder<GDeleteProfileVars, GDeleteProfileVarsBuilder> {
  _$GDeleteProfileVars? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  GDeleteProfileVarsBuilder();

  GDeleteProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _hash = $v.hash;
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteProfileVars other) {
    _$v = other as _$GDeleteProfileVars;
  }

  @override
  void update(void Function(GDeleteProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteProfileVars build() => _build();

  _$GDeleteProfileVars _build() {
    final _$result = _$v ??
        _$GDeleteProfileVars._(
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'GDeleteProfileVars', 'address'),
          hash: BuiltValueNullFieldError.checkNotNull(
              hash, r'GDeleteProfileVars', 'hash'),
          signature: BuiltValueNullFieldError.checkNotNull(
              signature, r'GDeleteProfileVars', 'signature'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMigrateProfileVars extends GMigrateProfileVars {
  @override
  final String addressNew;
  @override
  final String addressOld;
  @override
  final String hash;
  @override
  final String signature;

  factory _$GMigrateProfileVars(
          [void Function(GMigrateProfileVarsBuilder)? updates]) =>
      (GMigrateProfileVarsBuilder()..update(updates))._build();

  _$GMigrateProfileVars._(
      {required this.addressNew,
      required this.addressOld,
      required this.hash,
      required this.signature})
      : super._();
  @override
  GMigrateProfileVars rebuild(
          void Function(GMigrateProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMigrateProfileVarsBuilder toBuilder() =>
      GMigrateProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMigrateProfileVars &&
        addressNew == other.addressNew &&
        addressOld == other.addressOld &&
        hash == other.hash &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, addressNew.hashCode);
    _$hash = $jc(_$hash, addressOld.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMigrateProfileVars')
          ..add('addressNew', addressNew)
          ..add('addressOld', addressOld)
          ..add('hash', hash)
          ..add('signature', signature))
        .toString();
  }
}

class GMigrateProfileVarsBuilder
    implements Builder<GMigrateProfileVars, GMigrateProfileVarsBuilder> {
  _$GMigrateProfileVars? _$v;

  String? _addressNew;
  String? get addressNew => _$this._addressNew;
  set addressNew(String? addressNew) => _$this._addressNew = addressNew;

  String? _addressOld;
  String? get addressOld => _$this._addressOld;
  set addressOld(String? addressOld) => _$this._addressOld = addressOld;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  GMigrateProfileVarsBuilder();

  GMigrateProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _addressNew = $v.addressNew;
      _addressOld = $v.addressOld;
      _hash = $v.hash;
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMigrateProfileVars other) {
    _$v = other as _$GMigrateProfileVars;
  }

  @override
  void update(void Function(GMigrateProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMigrateProfileVars build() => _build();

  _$GMigrateProfileVars _build() {
    final _$result = _$v ??
        _$GMigrateProfileVars._(
          addressNew: BuiltValueNullFieldError.checkNotNull(
              addressNew, r'GMigrateProfileVars', 'addressNew'),
          addressOld: BuiltValueNullFieldError.checkNotNull(
              addressOld, r'GMigrateProfileVars', 'addressOld'),
          hash: BuiltValueNullFieldError.checkNotNull(
              hash, r'GMigrateProfileVars', 'hash'),
          signature: BuiltValueNullFieldError.checkNotNull(
              signature, r'GMigrateProfileVars', 'signature'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileVars extends GUpdateProfileVars {
  @override
  final String address;
  @override
  final String? avatarBase64;
  @override
  final String? city;
  @override
  final String? description;
  @override
  final _i2.GGeolocInput? geoloc;
  @override
  final String hash;
  @override
  final String signature;
  @override
  final BuiltList<_i2.GSocialInput>? socials;
  @override
  final String? title;

  factory _$GUpdateProfileVars(
          [void Function(GUpdateProfileVarsBuilder)? updates]) =>
      (GUpdateProfileVarsBuilder()..update(updates))._build();

  _$GUpdateProfileVars._(
      {required this.address,
      this.avatarBase64,
      this.city,
      this.description,
      this.geoloc,
      required this.hash,
      required this.signature,
      this.socials,
      this.title})
      : super._();
  @override
  GUpdateProfileVars rebuild(
          void Function(GUpdateProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileVarsBuilder toBuilder() =>
      GUpdateProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileVars &&
        address == other.address &&
        avatarBase64 == other.avatarBase64 &&
        city == other.city &&
        description == other.description &&
        geoloc == other.geoloc &&
        hash == other.hash &&
        signature == other.signature &&
        socials == other.socials &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, avatarBase64.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, geoloc.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jc(_$hash, socials.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileVars')
          ..add('address', address)
          ..add('avatarBase64', avatarBase64)
          ..add('city', city)
          ..add('description', description)
          ..add('geoloc', geoloc)
          ..add('hash', hash)
          ..add('signature', signature)
          ..add('socials', socials)
          ..add('title', title))
        .toString();
  }
}

class GUpdateProfileVarsBuilder
    implements Builder<GUpdateProfileVars, GUpdateProfileVarsBuilder> {
  _$GUpdateProfileVars? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _avatarBase64;
  String? get avatarBase64 => _$this._avatarBase64;
  set avatarBase64(String? avatarBase64) => _$this._avatarBase64 = avatarBase64;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  _i2.GGeolocInputBuilder? _geoloc;
  _i2.GGeolocInputBuilder get geoloc =>
      _$this._geoloc ??= _i2.GGeolocInputBuilder();
  set geoloc(_i2.GGeolocInputBuilder? geoloc) => _$this._geoloc = geoloc;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  ListBuilder<_i2.GSocialInput>? _socials;
  ListBuilder<_i2.GSocialInput> get socials =>
      _$this._socials ??= ListBuilder<_i2.GSocialInput>();
  set socials(ListBuilder<_i2.GSocialInput>? socials) =>
      _$this._socials = socials;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GUpdateProfileVarsBuilder();

  GUpdateProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _avatarBase64 = $v.avatarBase64;
      _city = $v.city;
      _description = $v.description;
      _geoloc = $v.geoloc?.toBuilder();
      _hash = $v.hash;
      _signature = $v.signature;
      _socials = $v.socials?.toBuilder();
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileVars other) {
    _$v = other as _$GUpdateProfileVars;
  }

  @override
  void update(void Function(GUpdateProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileVars build() => _build();

  _$GUpdateProfileVars _build() {
    _$GUpdateProfileVars _$result;
    try {
      _$result = _$v ??
          _$GUpdateProfileVars._(
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'GUpdateProfileVars', 'address'),
            avatarBase64: avatarBase64,
            city: city,
            description: description,
            geoloc: _geoloc?.build(),
            hash: BuiltValueNullFieldError.checkNotNull(
                hash, r'GUpdateProfileVars', 'hash'),
            signature: BuiltValueNullFieldError.checkNotNull(
                signature, r'GUpdateProfileVars', 'signature'),
            socials: _socials?.build(),
            title: title,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'geoloc';
        _geoloc?.build();

        _$failedField = 'socials';
        _socials?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUpdateProfileVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
