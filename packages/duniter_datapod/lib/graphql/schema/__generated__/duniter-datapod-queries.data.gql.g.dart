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
Serializer<GGetProfilesByAddressData> _$gGetProfilesByAddressDataSerializer =
    new _$GGetProfilesByAddressDataSerializer();
Serializer<GGetProfilesByAddressData_profiles>
    _$gGetProfilesByAddressDataProfilesSerializer =
    new _$GGetProfilesByAddressData_profilesSerializer();
Serializer<GGetProfileCountData> _$gGetProfileCountDataSerializer =
    new _$GGetProfileCountDataSerializer();
Serializer<GGetProfileCountData_profiles_aggregate>
    _$gGetProfileCountDataProfilesAggregateSerializer =
    new _$GGetProfileCountData_profiles_aggregateSerializer();
Serializer<GGetProfileCountData_profiles_aggregate_aggregate>
    _$gGetProfileCountDataProfilesAggregateAggregateSerializer =
    new _$GGetProfileCountData_profiles_aggregate_aggregateSerializer();
Serializer<GSearchProfileByTermData> _$gSearchProfileByTermDataSerializer =
    new _$GSearchProfileByTermDataSerializer();
Serializer<GSearchProfileByTermData_profiles>
    _$gSearchProfileByTermDataProfilesSerializer =
    new _$GSearchProfileByTermData_profilesSerializer();
Serializer<GSearchProfilesData> _$gSearchProfilesDataSerializer =
    new _$GSearchProfilesDataSerializer();
Serializer<GSearchProfilesData_profiles>
    _$gSearchProfilesDataProfilesSerializer =
    new _$GSearchProfilesData_profilesSerializer();

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

class _$GGetProfilesByAddressDataSerializer
    implements StructuredSerializer<GGetProfilesByAddressData> {
  @override
  final Iterable<Type> types = const [
    GGetProfilesByAddressData,
    _$GGetProfilesByAddressData
  ];
  @override
  final String wireName = 'GGetProfilesByAddressData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfilesByAddressData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'profiles',
      serializers.serialize(object.profiles,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GGetProfilesByAddressData_profiles)])),
    ];

    return result;
  }

  @override
  GGetProfilesByAddressData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfilesByAddressDataBuilder();

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
                const FullType(GGetProfilesByAddressData_profiles)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfilesByAddressData_profilesSerializer
    implements StructuredSerializer<GGetProfilesByAddressData_profiles> {
  @override
  final Iterable<Type> types = const [
    GGetProfilesByAddressData_profiles,
    _$GGetProfilesByAddressData_profiles
  ];
  @override
  final String wireName = 'GGetProfilesByAddressData_profiles';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfilesByAddressData_profiles object,
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
  GGetProfilesByAddressData_profiles deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfilesByAddressData_profilesBuilder();

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

class _$GSearchProfileByTermDataSerializer
    implements StructuredSerializer<GSearchProfileByTermData> {
  @override
  final Iterable<Type> types = const [
    GSearchProfileByTermData,
    _$GSearchProfileByTermData
  ];
  @override
  final String wireName = 'GSearchProfileByTermData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfileByTermData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'profiles',
      serializers.serialize(object.profiles,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GSearchProfileByTermData_profiles)])),
    ];

    return result;
  }

  @override
  GSearchProfileByTermData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfileByTermDataBuilder();

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
                const FullType(GSearchProfileByTermData_profiles)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchProfileByTermData_profilesSerializer
    implements StructuredSerializer<GSearchProfileByTermData_profiles> {
  @override
  final Iterable<Type> types = const [
    GSearchProfileByTermData_profiles,
    _$GSearchProfileByTermData_profiles
  ];
  @override
  final String wireName = 'GSearchProfileByTermData_profiles';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfileByTermData_profiles object,
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
  GSearchProfileByTermData_profiles deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfileByTermData_profilesBuilder();

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

class _$GSearchProfilesDataSerializer
    implements StructuredSerializer<GSearchProfilesData> {
  @override
  final Iterable<Type> types = const [
    GSearchProfilesData,
    _$GSearchProfilesData
  ];
  @override
  final String wireName = 'GSearchProfilesData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfilesData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'profiles',
      serializers.serialize(object.profiles,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GSearchProfilesData_profiles)])),
    ];

    return result;
  }

  @override
  GSearchProfilesData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfilesDataBuilder();

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
                const FullType(GSearchProfilesData_profiles)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchProfilesData_profilesSerializer
    implements StructuredSerializer<GSearchProfilesData_profiles> {
  @override
  final Iterable<Type> types = const [
    GSearchProfilesData_profiles,
    _$GSearchProfilesData_profiles
  ];
  @override
  final String wireName = 'GSearchProfilesData_profiles';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfilesData_profiles object,
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
  GSearchProfilesData_profiles deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfilesData_profilesBuilder();

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

class _$GGetProfilesByAddressData extends GGetProfilesByAddressData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetProfilesByAddressData_profiles> profiles;

  factory _$GGetProfilesByAddressData(
          [void Function(GGetProfilesByAddressDataBuilder)? updates]) =>
      (new GGetProfilesByAddressDataBuilder()..update(updates))._build();

  _$GGetProfilesByAddressData._(
      {required this.G__typename, required this.profiles})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetProfilesByAddressData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        profiles, r'GGetProfilesByAddressData', 'profiles');
  }

  @override
  GGetProfilesByAddressData rebuild(
          void Function(GGetProfilesByAddressDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfilesByAddressDataBuilder toBuilder() =>
      new GGetProfilesByAddressDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfilesByAddressData &&
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
    return (newBuiltValueToStringHelper(r'GGetProfilesByAddressData')
          ..add('G__typename', G__typename)
          ..add('profiles', profiles))
        .toString();
  }
}

class GGetProfilesByAddressDataBuilder
    implements
        Builder<GGetProfilesByAddressData, GGetProfilesByAddressDataBuilder> {
  _$GGetProfilesByAddressData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetProfilesByAddressData_profiles>? _profiles;
  ListBuilder<GGetProfilesByAddressData_profiles> get profiles =>
      _$this._profiles ??=
          new ListBuilder<GGetProfilesByAddressData_profiles>();
  set profiles(ListBuilder<GGetProfilesByAddressData_profiles>? profiles) =>
      _$this._profiles = profiles;

  GGetProfilesByAddressDataBuilder() {
    GGetProfilesByAddressData._initializeBuilder(this);
  }

  GGetProfilesByAddressDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _profiles = $v.profiles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfilesByAddressData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfilesByAddressData;
  }

  @override
  void update(void Function(GGetProfilesByAddressDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfilesByAddressData build() => _build();

  _$GGetProfilesByAddressData _build() {
    _$GGetProfilesByAddressData _$result;
    try {
      _$result = _$v ??
          new _$GGetProfilesByAddressData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetProfilesByAddressData', 'G__typename'),
              profiles: profiles.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfilesByAddressData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfilesByAddressData_profiles
    extends GGetProfilesByAddressData_profiles {
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

  factory _$GGetProfilesByAddressData_profiles(
          [void Function(GGetProfilesByAddressData_profilesBuilder)?
              updates]) =>
      (new GGetProfilesByAddressData_profilesBuilder()..update(updates))
          ._build();

  _$GGetProfilesByAddressData_profiles._(
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
        G__typename, r'GGetProfilesByAddressData_profiles', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GGetProfilesByAddressData_profiles', 'pubkey');
    BuiltValueNullFieldError.checkNotNull(index_request_cid,
        r'GGetProfilesByAddressData_profiles', 'index_request_cid');
    BuiltValueNullFieldError.checkNotNull(
        time, r'GGetProfilesByAddressData_profiles', 'time');
  }

  @override
  GGetProfilesByAddressData_profiles rebuild(
          void Function(GGetProfilesByAddressData_profilesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfilesByAddressData_profilesBuilder toBuilder() =>
      new GGetProfilesByAddressData_profilesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfilesByAddressData_profiles &&
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
    return (newBuiltValueToStringHelper(r'GGetProfilesByAddressData_profiles')
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

class GGetProfilesByAddressData_profilesBuilder
    implements
        Builder<GGetProfilesByAddressData_profiles,
            GGetProfilesByAddressData_profilesBuilder> {
  _$GGetProfilesByAddressData_profiles? _$v;

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

  GGetProfilesByAddressData_profilesBuilder() {
    GGetProfilesByAddressData_profiles._initializeBuilder(this);
  }

  GGetProfilesByAddressData_profilesBuilder get _$this {
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
  void replace(GGetProfilesByAddressData_profiles other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfilesByAddressData_profiles;
  }

  @override
  void update(
      void Function(GGetProfilesByAddressData_profilesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfilesByAddressData_profiles build() => _build();

  _$GGetProfilesByAddressData_profiles _build() {
    _$GGetProfilesByAddressData_profiles _$result;
    try {
      _$result = _$v ??
          new _$GGetProfilesByAddressData_profiles._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetProfilesByAddressData_profiles', 'G__typename'),
              avatar: avatar,
              pubkey: BuiltValueNullFieldError.checkNotNull(
                  pubkey, r'GGetProfilesByAddressData_profiles', 'pubkey'),
              description: description,
              title: title,
              city: city,
              data_cid: data_cid,
              geoloc: _geoloc?.build(),
              index_request_cid: BuiltValueNullFieldError.checkNotNull(
                  index_request_cid,
                  r'GGetProfilesByAddressData_profiles',
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
            r'GGetProfilesByAddressData_profiles', _$failedField, e.toString());
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

class _$GSearchProfileByTermData extends GSearchProfileByTermData {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchProfileByTermData_profiles> profiles;

  factory _$GSearchProfileByTermData(
          [void Function(GSearchProfileByTermDataBuilder)? updates]) =>
      (new GSearchProfileByTermDataBuilder()..update(updates))._build();

  _$GSearchProfileByTermData._(
      {required this.G__typename, required this.profiles})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchProfileByTermData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        profiles, r'GSearchProfileByTermData', 'profiles');
  }

  @override
  GSearchProfileByTermData rebuild(
          void Function(GSearchProfileByTermDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfileByTermDataBuilder toBuilder() =>
      new GSearchProfileByTermDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfileByTermData &&
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
    return (newBuiltValueToStringHelper(r'GSearchProfileByTermData')
          ..add('G__typename', G__typename)
          ..add('profiles', profiles))
        .toString();
  }
}

class GSearchProfileByTermDataBuilder
    implements
        Builder<GSearchProfileByTermData, GSearchProfileByTermDataBuilder> {
  _$GSearchProfileByTermData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchProfileByTermData_profiles>? _profiles;
  ListBuilder<GSearchProfileByTermData_profiles> get profiles =>
      _$this._profiles ??= new ListBuilder<GSearchProfileByTermData_profiles>();
  set profiles(ListBuilder<GSearchProfileByTermData_profiles>? profiles) =>
      _$this._profiles = profiles;

  GSearchProfileByTermDataBuilder() {
    GSearchProfileByTermData._initializeBuilder(this);
  }

  GSearchProfileByTermDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _profiles = $v.profiles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchProfileByTermData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfileByTermData;
  }

  @override
  void update(void Function(GSearchProfileByTermDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfileByTermData build() => _build();

  _$GSearchProfileByTermData _build() {
    _$GSearchProfileByTermData _$result;
    try {
      _$result = _$v ??
          new _$GSearchProfileByTermData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSearchProfileByTermData', 'G__typename'),
              profiles: profiles.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSearchProfileByTermData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchProfileByTermData_profiles
    extends GSearchProfileByTermData_profiles {
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

  factory _$GSearchProfileByTermData_profiles(
          [void Function(GSearchProfileByTermData_profilesBuilder)? updates]) =>
      (new GSearchProfileByTermData_profilesBuilder()..update(updates))
          ._build();

  _$GSearchProfileByTermData_profiles._(
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
        G__typename, r'GSearchProfileByTermData_profiles', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GSearchProfileByTermData_profiles', 'pubkey');
    BuiltValueNullFieldError.checkNotNull(index_request_cid,
        r'GSearchProfileByTermData_profiles', 'index_request_cid');
    BuiltValueNullFieldError.checkNotNull(
        time, r'GSearchProfileByTermData_profiles', 'time');
  }

  @override
  GSearchProfileByTermData_profiles rebuild(
          void Function(GSearchProfileByTermData_profilesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfileByTermData_profilesBuilder toBuilder() =>
      new GSearchProfileByTermData_profilesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfileByTermData_profiles &&
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
    return (newBuiltValueToStringHelper(r'GSearchProfileByTermData_profiles')
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

class GSearchProfileByTermData_profilesBuilder
    implements
        Builder<GSearchProfileByTermData_profiles,
            GSearchProfileByTermData_profilesBuilder> {
  _$GSearchProfileByTermData_profiles? _$v;

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

  GSearchProfileByTermData_profilesBuilder() {
    GSearchProfileByTermData_profiles._initializeBuilder(this);
  }

  GSearchProfileByTermData_profilesBuilder get _$this {
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
  void replace(GSearchProfileByTermData_profiles other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfileByTermData_profiles;
  }

  @override
  void update(
      void Function(GSearchProfileByTermData_profilesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfileByTermData_profiles build() => _build();

  _$GSearchProfileByTermData_profiles _build() {
    _$GSearchProfileByTermData_profiles _$result;
    try {
      _$result = _$v ??
          new _$GSearchProfileByTermData_profiles._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GSearchProfileByTermData_profiles', 'G__typename'),
              avatar: avatar,
              pubkey: BuiltValueNullFieldError.checkNotNull(
                  pubkey, r'GSearchProfileByTermData_profiles', 'pubkey'),
              description: description,
              title: title,
              city: city,
              data_cid: data_cid,
              geoloc: _geoloc?.build(),
              index_request_cid: BuiltValueNullFieldError.checkNotNull(
                  index_request_cid,
                  r'GSearchProfileByTermData_profiles',
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
            r'GSearchProfileByTermData_profiles', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchProfilesData extends GSearchProfilesData {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchProfilesData_profiles> profiles;

  factory _$GSearchProfilesData(
          [void Function(GSearchProfilesDataBuilder)? updates]) =>
      (new GSearchProfilesDataBuilder()..update(updates))._build();

  _$GSearchProfilesData._({required this.G__typename, required this.profiles})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchProfilesData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        profiles, r'GSearchProfilesData', 'profiles');
  }

  @override
  GSearchProfilesData rebuild(
          void Function(GSearchProfilesDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfilesDataBuilder toBuilder() =>
      new GSearchProfilesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfilesData &&
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
    return (newBuiltValueToStringHelper(r'GSearchProfilesData')
          ..add('G__typename', G__typename)
          ..add('profiles', profiles))
        .toString();
  }
}

class GSearchProfilesDataBuilder
    implements Builder<GSearchProfilesData, GSearchProfilesDataBuilder> {
  _$GSearchProfilesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchProfilesData_profiles>? _profiles;
  ListBuilder<GSearchProfilesData_profiles> get profiles =>
      _$this._profiles ??= new ListBuilder<GSearchProfilesData_profiles>();
  set profiles(ListBuilder<GSearchProfilesData_profiles>? profiles) =>
      _$this._profiles = profiles;

  GSearchProfilesDataBuilder() {
    GSearchProfilesData._initializeBuilder(this);
  }

  GSearchProfilesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _profiles = $v.profiles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchProfilesData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfilesData;
  }

  @override
  void update(void Function(GSearchProfilesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfilesData build() => _build();

  _$GSearchProfilesData _build() {
    _$GSearchProfilesData _$result;
    try {
      _$result = _$v ??
          new _$GSearchProfilesData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSearchProfilesData', 'G__typename'),
              profiles: profiles.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profiles';
        profiles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSearchProfilesData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchProfilesData_profiles extends GSearchProfilesData_profiles {
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

  factory _$GSearchProfilesData_profiles(
          [void Function(GSearchProfilesData_profilesBuilder)? updates]) =>
      (new GSearchProfilesData_profilesBuilder()..update(updates))._build();

  _$GSearchProfilesData_profiles._(
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
        G__typename, r'GSearchProfilesData_profiles', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GSearchProfilesData_profiles', 'pubkey');
    BuiltValueNullFieldError.checkNotNull(index_request_cid,
        r'GSearchProfilesData_profiles', 'index_request_cid');
    BuiltValueNullFieldError.checkNotNull(
        time, r'GSearchProfilesData_profiles', 'time');
  }

  @override
  GSearchProfilesData_profiles rebuild(
          void Function(GSearchProfilesData_profilesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfilesData_profilesBuilder toBuilder() =>
      new GSearchProfilesData_profilesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfilesData_profiles &&
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
    return (newBuiltValueToStringHelper(r'GSearchProfilesData_profiles')
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

class GSearchProfilesData_profilesBuilder
    implements
        Builder<GSearchProfilesData_profiles,
            GSearchProfilesData_profilesBuilder> {
  _$GSearchProfilesData_profiles? _$v;

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

  GSearchProfilesData_profilesBuilder() {
    GSearchProfilesData_profiles._initializeBuilder(this);
  }

  GSearchProfilesData_profilesBuilder get _$this {
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
  void replace(GSearchProfilesData_profiles other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfilesData_profiles;
  }

  @override
  void update(void Function(GSearchProfilesData_profilesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfilesData_profiles build() => _build();

  _$GSearchProfilesData_profiles _build() {
    _$GSearchProfilesData_profiles _$result;
    try {
      _$result = _$v ??
          new _$GSearchProfilesData_profiles._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSearchProfilesData_profiles', 'G__typename'),
              avatar: avatar,
              pubkey: BuiltValueNullFieldError.checkNotNull(
                  pubkey, r'GSearchProfilesData_profiles', 'pubkey'),
              description: description,
              title: title,
              city: city,
              data_cid: data_cid,
              geoloc: _geoloc?.build(),
              index_request_cid: BuiltValueNullFieldError.checkNotNull(
                  index_request_cid,
                  r'GSearchProfilesData_profiles',
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
            r'GSearchProfilesData_profiles', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
