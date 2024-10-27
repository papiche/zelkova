// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-datapod-queries.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetProfileByAddressData> _$gGetProfileByAddressDataSerializer =
    new _$GGetProfileByAddressDataSerializer();
Serializer<GGetProfileByAddressData_profiles>
    _$gGetProfileByAddressDataProfilesSerializer =
    new _$GGetProfileByAddressData_profilesSerializer();
Serializer<GGetProfileCountData> _$gGetProfileCountDataSerializer =
    new _$GGetProfileCountDataSerializer();
Serializer<GGetProfileCountData_profiles_aggregate>
    _$gGetProfileCountDataProfilesAggregateSerializer =
    new _$GGetProfileCountData_profiles_aggregateSerializer();
Serializer<GGetProfileCountData_profiles_aggregate_aggregate>
    _$gGetProfileCountDataProfilesAggregateAggregateSerializer =
    new _$GGetProfileCountData_profiles_aggregate_aggregateSerializer();

class _$GGetProfileByAddressDataSerializer
    implements StructuredSerializer<GGetProfileByAddressData> {
  @override
  final Iterable<Type> types = const [
    GGetProfileByAddressData,
    _$GGetProfileByAddressData
  ];
  @override
  final String wireName = 'GGetProfileByAddressData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileByAddressData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'profiles',
      serializers.serialize(object.profiles,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GGetProfileByAddressData_profiles)])),
    ];

    return result;
  }

  @override
  GGetProfileByAddressData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfileByAddressDataBuilder();

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
        case 'profiles':
          result.profiles.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GGetProfileByAddressData_profiles)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileByAddressData_profilesSerializer
    implements StructuredSerializer<GGetProfileByAddressData_profiles> {
  @override
  final Iterable<Type> types = const [
    GGetProfileByAddressData_profiles,
    _$GGetProfileByAddressData_profiles
  ];
  @override
  final String wireName = 'GGetProfileByAddressData_profiles';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileByAddressData_profiles object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pubkey',
      serializers.serialize(object.pubkey,
          specifiedType: const FullType(String)),
      'index_request_cid',
      serializers.serialize(object.index_request_cid,
          specifiedType: const FullType(String)),
      'time',
      serializers.serialize(object.time,
          specifiedType: const FullType(_i2.Gtimestamp)),
    ];
    Object? value;
    value = object.avatar;
    if (value != null) {
      result
        ..add('avatar')
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
    value = object.title;
    if (value != null) {
      result
        ..add('title')
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
    value = object.data_cid;
    if (value != null) {
      result
        ..add('data_cid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.geoloc;
    if (value != null) {
      result
        ..add('geoloc')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.Gpoint)));
    }
    value = object.socials;
    if (value != null) {
      result
        ..add('socials')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.JsonObject)));
    }
    return result;
  }

  @override
  GGetProfileByAddressData_profiles deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfileByAddressData_profilesBuilder();

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
        case 'avatar':
          result.avatar = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pubkey':
          result.pubkey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'data_cid':
          result.data_cid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'geoloc':
          result.geoloc.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.Gpoint))! as _i2.Gpoint);
          break;
        case 'index_request_cid':
          result.index_request_cid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'socials':
          result.socials = serializers.deserialize(value,
              specifiedType: const FullType(_i3.JsonObject)) as _i3.JsonObject?;
          break;
        case 'time':
          result.time.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.Gtimestamp))!
              as _i2.Gtimestamp);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileCountDataSerializer
    implements StructuredSerializer<GGetProfileCountData> {
  @override
  final Iterable<Type> types = const [
    GGetProfileCountData,
    _$GGetProfileCountData
  ];
  @override
  final String wireName = 'GGetProfileCountData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileCountData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'profiles_aggregate',
      serializers.serialize(object.profiles_aggregate,
          specifiedType:
              const FullType(GGetProfileCountData_profiles_aggregate)),
    ];

    return result;
  }

  @override
  GGetProfileCountData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfileCountDataBuilder();

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
        case 'profiles_aggregate':
          result.profiles_aggregate.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GGetProfileCountData_profiles_aggregate))!
              as GGetProfileCountData_profiles_aggregate);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileCountData_profiles_aggregateSerializer
    implements StructuredSerializer<GGetProfileCountData_profiles_aggregate> {
  @override
  final Iterable<Type> types = const [
    GGetProfileCountData_profiles_aggregate,
    _$GGetProfileCountData_profiles_aggregate
  ];
  @override
  final String wireName = 'GGetProfileCountData_profiles_aggregate';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileCountData_profiles_aggregate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.aggregate;
    if (value != null) {
      result
        ..add('aggregate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetProfileCountData_profiles_aggregate_aggregate)));
    }
    return result;
  }

  @override
  GGetProfileCountData_profiles_aggregate deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfileCountData_profiles_aggregateBuilder();

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
        case 'aggregate':
          result.aggregate.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetProfileCountData_profiles_aggregate_aggregate))!
              as GGetProfileCountData_profiles_aggregate_aggregate);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileCountData_profiles_aggregate_aggregateSerializer
    implements
        StructuredSerializer<
            GGetProfileCountData_profiles_aggregate_aggregate> {
  @override
  final Iterable<Type> types = const [
    GGetProfileCountData_profiles_aggregate_aggregate,
    _$GGetProfileCountData_profiles_aggregate_aggregate
  ];
  @override
  final String wireName = 'GGetProfileCountData_profiles_aggregate_aggregate';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetProfileCountData_profiles_aggregate_aggregate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GGetProfileCountData_profiles_aggregate_aggregate deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetProfileCountData_profiles_aggregate_aggregateBuilder();

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
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileByAddressData extends GGetProfileByAddressData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetProfileByAddressData_profiles> profiles;

  factory _$GGetProfileByAddressData(
          [void Function(GGetProfileByAddressDataBuilder)? updates]) =>
      (new GGetProfileByAddressDataBuilder()..update(updates))._build();

  _$GGetProfileByAddressData._(
      {required this.G__typename, required this.profiles})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetProfileByAddressData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        profiles, r'GGetProfileByAddressData', 'profiles');
  }

  @override
  GGetProfileByAddressData rebuild(
          void Function(GGetProfileByAddressDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileByAddressDataBuilder toBuilder() =>
      new GGetProfileByAddressDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileByAddressData &&
        G__typename == other.G__typename &&
        profiles == other.profiles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, profiles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetProfileByAddressData')
          ..add('G__typename', G__typename)
          ..add('profiles', profiles))
        .toString();
  }
}

class GGetProfileByAddressDataBuilder
    implements
        Builder<GGetProfileByAddressData, GGetProfileByAddressDataBuilder> {
  _$GGetProfileByAddressData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetProfileByAddressData_profiles>? _profiles;
  ListBuilder<GGetProfileByAddressData_profiles> get profiles =>
      _$this._profiles ??= new ListBuilder<GGetProfileByAddressData_profiles>();
  set profiles(ListBuilder<GGetProfileByAddressData_profiles>? profiles) =>
      _$this._profiles = profiles;

  GGetProfileByAddressDataBuilder() {
    GGetProfileByAddressData._initializeBuilder(this);
  }

  GGetProfileByAddressDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _profiles = $v.profiles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileByAddressData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileByAddressData;
  }

  @override
  void update(void Function(GGetProfileByAddressDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileByAddressData build() => _build();

  _$GGetProfileByAddressData _build() {
    _$GGetProfileByAddressData _$result;
    try {
      _$result = _$v ??
          new _$GGetProfileByAddressData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetProfileByAddressData', 'G__typename'),
              profiles: profiles.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfileByAddressData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfileByAddressData_profiles
    extends GGetProfileByAddressData_profiles {
  @override
  final String G__typename;
  @override
  final String? avatar;
  @override
  final String pubkey;
  @override
  final String? description;
  @override
  final String? title;
  @override
  final String? city;
  @override
  final String? data_cid;
  @override
  final _i2.Gpoint? geoloc;
  @override
  final String index_request_cid;
  @override
  final _i3.JsonObject? socials;
  @override
  final _i2.Gtimestamp time;

  factory _$GGetProfileByAddressData_profiles(
          [void Function(GGetProfileByAddressData_profilesBuilder)? updates]) =>
      (new GGetProfileByAddressData_profilesBuilder()..update(updates))
          ._build();

  _$GGetProfileByAddressData_profiles._(
      {required this.G__typename,
      this.avatar,
      required this.pubkey,
      this.description,
      this.title,
      this.city,
      this.data_cid,
      this.geoloc,
      required this.index_request_cid,
      this.socials,
      required this.time})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetProfileByAddressData_profiles', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GGetProfileByAddressData_profiles', 'pubkey');
    BuiltValueNullFieldError.checkNotNull(index_request_cid,
        r'GGetProfileByAddressData_profiles', 'index_request_cid');
    BuiltValueNullFieldError.checkNotNull(
        time, r'GGetProfileByAddressData_profiles', 'time');
  }

  @override
  GGetProfileByAddressData_profiles rebuild(
          void Function(GGetProfileByAddressData_profilesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileByAddressData_profilesBuilder toBuilder() =>
      new GGetProfileByAddressData_profilesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileByAddressData_profiles &&
        G__typename == other.G__typename &&
        avatar == other.avatar &&
        pubkey == other.pubkey &&
        description == other.description &&
        title == other.title &&
        city == other.city &&
        data_cid == other.data_cid &&
        geoloc == other.geoloc &&
        index_request_cid == other.index_request_cid &&
        socials == other.socials &&
        time == other.time;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jc(_$hash, pubkey.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, data_cid.hashCode);
    _$hash = $jc(_$hash, geoloc.hashCode);
    _$hash = $jc(_$hash, index_request_cid.hashCode);
    _$hash = $jc(_$hash, socials.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetProfileByAddressData_profiles')
          ..add('G__typename', G__typename)
          ..add('avatar', avatar)
          ..add('pubkey', pubkey)
          ..add('description', description)
          ..add('title', title)
          ..add('city', city)
          ..add('data_cid', data_cid)
          ..add('geoloc', geoloc)
          ..add('index_request_cid', index_request_cid)
          ..add('socials', socials)
          ..add('time', time))
        .toString();
  }
}

class GGetProfileByAddressData_profilesBuilder
    implements
        Builder<GGetProfileByAddressData_profiles,
            GGetProfileByAddressData_profilesBuilder> {
  _$GGetProfileByAddressData_profiles? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _pubkey;
  String? get pubkey => _$this._pubkey;
  set pubkey(String? pubkey) => _$this._pubkey = pubkey;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _data_cid;
  String? get data_cid => _$this._data_cid;
  set data_cid(String? data_cid) => _$this._data_cid = data_cid;

  _i2.GpointBuilder? _geoloc;
  _i2.GpointBuilder get geoloc => _$this._geoloc ??= new _i2.GpointBuilder();
  set geoloc(_i2.GpointBuilder? geoloc) => _$this._geoloc = geoloc;

  String? _index_request_cid;
  String? get index_request_cid => _$this._index_request_cid;
  set index_request_cid(String? index_request_cid) =>
      _$this._index_request_cid = index_request_cid;

  _i3.JsonObject? _socials;
  _i3.JsonObject? get socials => _$this._socials;
  set socials(_i3.JsonObject? socials) => _$this._socials = socials;

  _i2.GtimestampBuilder? _time;
  _i2.GtimestampBuilder get time =>
      _$this._time ??= new _i2.GtimestampBuilder();
  set time(_i2.GtimestampBuilder? time) => _$this._time = time;

  GGetProfileByAddressData_profilesBuilder() {
    GGetProfileByAddressData_profiles._initializeBuilder(this);
  }

  GGetProfileByAddressData_profilesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _avatar = $v.avatar;
      _pubkey = $v.pubkey;
      _description = $v.description;
      _title = $v.title;
      _city = $v.city;
      _data_cid = $v.data_cid;
      _geoloc = $v.geoloc?.toBuilder();
      _index_request_cid = $v.index_request_cid;
      _socials = $v.socials;
      _time = $v.time.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileByAddressData_profiles other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileByAddressData_profiles;
  }

  @override
  void update(
      void Function(GGetProfileByAddressData_profilesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileByAddressData_profiles build() => _build();

  _$GGetProfileByAddressData_profiles _build() {
    _$GGetProfileByAddressData_profiles _$result;
    try {
      _$result = _$v ??
          new _$GGetProfileByAddressData_profiles._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetProfileByAddressData_profiles', 'G__typename'),
              avatar: avatar,
              pubkey: BuiltValueNullFieldError.checkNotNull(
                  pubkey, r'GGetProfileByAddressData_profiles', 'pubkey'),
              description: description,
              title: title,
              city: city,
              data_cid: data_cid,
              geoloc: _geoloc?.build(),
              index_request_cid: BuiltValueNullFieldError.checkNotNull(
                  index_request_cid,
                  r'GGetProfileByAddressData_profiles',
                  'index_request_cid'),
              socials: socials,
              time: time.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'geoloc';
        _geoloc?.build();

        _$failedField = 'time';
        time.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfileByAddressData_profiles', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfileCountData extends GGetProfileCountData {
  @override
  final String G__typename;
  @override
  final GGetProfileCountData_profiles_aggregate profiles_aggregate;

  factory _$GGetProfileCountData(
          [void Function(GGetProfileCountDataBuilder)? updates]) =>
      (new GGetProfileCountDataBuilder()..update(updates))._build();

  _$GGetProfileCountData._(
      {required this.G__typename, required this.profiles_aggregate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetProfileCountData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        profiles_aggregate, r'GGetProfileCountData', 'profiles_aggregate');
  }

  @override
  GGetProfileCountData rebuild(
          void Function(GGetProfileCountDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileCountDataBuilder toBuilder() =>
      new GGetProfileCountDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileCountData &&
        G__typename == other.G__typename &&
        profiles_aggregate == other.profiles_aggregate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, profiles_aggregate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetProfileCountData')
          ..add('G__typename', G__typename)
          ..add('profiles_aggregate', profiles_aggregate))
        .toString();
  }
}

class GGetProfileCountDataBuilder
    implements Builder<GGetProfileCountData, GGetProfileCountDataBuilder> {
  _$GGetProfileCountData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetProfileCountData_profiles_aggregateBuilder? _profiles_aggregate;
  GGetProfileCountData_profiles_aggregateBuilder get profiles_aggregate =>
      _$this._profiles_aggregate ??=
          new GGetProfileCountData_profiles_aggregateBuilder();
  set profiles_aggregate(
          GGetProfileCountData_profiles_aggregateBuilder? profiles_aggregate) =>
      _$this._profiles_aggregate = profiles_aggregate;

  GGetProfileCountDataBuilder() {
    GGetProfileCountData._initializeBuilder(this);
  }

  GGetProfileCountDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _profiles_aggregate = $v.profiles_aggregate.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileCountData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileCountData;
  }

  @override
  void update(void Function(GGetProfileCountDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileCountData build() => _build();

  _$GGetProfileCountData _build() {
    _$GGetProfileCountData _$result;
    try {
      _$result = _$v ??
          new _$GGetProfileCountData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetProfileCountData', 'G__typename'),
              profiles_aggregate: profiles_aggregate.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profiles_aggregate';
        profiles_aggregate.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfileCountData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfileCountData_profiles_aggregate
    extends GGetProfileCountData_profiles_aggregate {
  @override
  final String G__typename;
  @override
  final GGetProfileCountData_profiles_aggregate_aggregate? aggregate;

  factory _$GGetProfileCountData_profiles_aggregate(
          [void Function(GGetProfileCountData_profiles_aggregateBuilder)?
              updates]) =>
      (new GGetProfileCountData_profiles_aggregateBuilder()..update(updates))
          ._build();

  _$GGetProfileCountData_profiles_aggregate._(
      {required this.G__typename, this.aggregate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetProfileCountData_profiles_aggregate', 'G__typename');
  }

  @override
  GGetProfileCountData_profiles_aggregate rebuild(
          void Function(GGetProfileCountData_profiles_aggregateBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileCountData_profiles_aggregateBuilder toBuilder() =>
      new GGetProfileCountData_profiles_aggregateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileCountData_profiles_aggregate &&
        G__typename == other.G__typename &&
        aggregate == other.aggregate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, aggregate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetProfileCountData_profiles_aggregate')
          ..add('G__typename', G__typename)
          ..add('aggregate', aggregate))
        .toString();
  }
}

class GGetProfileCountData_profiles_aggregateBuilder
    implements
        Builder<GGetProfileCountData_profiles_aggregate,
            GGetProfileCountData_profiles_aggregateBuilder> {
  _$GGetProfileCountData_profiles_aggregate? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetProfileCountData_profiles_aggregate_aggregateBuilder? _aggregate;
  GGetProfileCountData_profiles_aggregate_aggregateBuilder get aggregate =>
      _$this._aggregate ??=
          new GGetProfileCountData_profiles_aggregate_aggregateBuilder();
  set aggregate(
          GGetProfileCountData_profiles_aggregate_aggregateBuilder?
              aggregate) =>
      _$this._aggregate = aggregate;

  GGetProfileCountData_profiles_aggregateBuilder() {
    GGetProfileCountData_profiles_aggregate._initializeBuilder(this);
  }

  GGetProfileCountData_profiles_aggregateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _aggregate = $v.aggregate?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileCountData_profiles_aggregate other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileCountData_profiles_aggregate;
  }

  @override
  void update(
      void Function(GGetProfileCountData_profiles_aggregateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileCountData_profiles_aggregate build() => _build();

  _$GGetProfileCountData_profiles_aggregate _build() {
    _$GGetProfileCountData_profiles_aggregate _$result;
    try {
      _$result = _$v ??
          new _$GGetProfileCountData_profiles_aggregate._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetProfileCountData_profiles_aggregate', 'G__typename'),
              aggregate: _aggregate?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'aggregate';
        _aggregate?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfileCountData_profiles_aggregate',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfileCountData_profiles_aggregate_aggregate
    extends GGetProfileCountData_profiles_aggregate_aggregate {
  @override
  final String G__typename;
  @override
  final int count;

  factory _$GGetProfileCountData_profiles_aggregate_aggregate(
          [void Function(
                  GGetProfileCountData_profiles_aggregate_aggregateBuilder)?
              updates]) =>
      (new GGetProfileCountData_profiles_aggregate_aggregateBuilder()
            ..update(updates))
          ._build();

  _$GGetProfileCountData_profiles_aggregate_aggregate._(
      {required this.G__typename, required this.count})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GGetProfileCountData_profiles_aggregate_aggregate', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GGetProfileCountData_profiles_aggregate_aggregate', 'count');
  }

  @override
  GGetProfileCountData_profiles_aggregate_aggregate rebuild(
          void Function(
                  GGetProfileCountData_profiles_aggregate_aggregateBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileCountData_profiles_aggregate_aggregateBuilder toBuilder() =>
      new GGetProfileCountData_profiles_aggregate_aggregateBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileCountData_profiles_aggregate_aggregate &&
        G__typename == other.G__typename &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetProfileCountData_profiles_aggregate_aggregate')
          ..add('G__typename', G__typename)
          ..add('count', count))
        .toString();
  }
}

class GGetProfileCountData_profiles_aggregate_aggregateBuilder
    implements
        Builder<GGetProfileCountData_profiles_aggregate_aggregate,
            GGetProfileCountData_profiles_aggregate_aggregateBuilder> {
  _$GGetProfileCountData_profiles_aggregate_aggregate? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  GGetProfileCountData_profiles_aggregate_aggregateBuilder() {
    GGetProfileCountData_profiles_aggregate_aggregate._initializeBuilder(this);
  }

  GGetProfileCountData_profiles_aggregate_aggregateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileCountData_profiles_aggregate_aggregate other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileCountData_profiles_aggregate_aggregate;
  }

  @override
  void update(
      void Function(GGetProfileCountData_profiles_aggregate_aggregateBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileCountData_profiles_aggregate_aggregate build() => _build();

  _$GGetProfileCountData_profiles_aggregate_aggregate _build() {
    final _$result = _$v ??
        new _$GGetProfileCountData_profiles_aggregate_aggregate._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetProfileCountData_profiles_aggregate_aggregate',
                'G__typename'),
            count: BuiltValueNullFieldError.checkNotNull(count,
                r'GGetProfileCountData_profiles_aggregate_aggregate', 'count'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
