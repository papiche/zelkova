// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i3;
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod.schema.schema.gql.dart'
    as _i2;
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-datapod-queries.data.gql.g.dart';

abstract class GGetProfileByAddressData
    implements
        Built<GGetProfileByAddressData, GGetProfileByAddressDataBuilder> {
  GGetProfileByAddressData._();

  factory GGetProfileByAddressData(
          [void Function(GGetProfileByAddressDataBuilder b) updates]) =
      _$GGetProfileByAddressData;

  static void _initializeBuilder(GGetProfileByAddressDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetProfileByAddressData_profiles> get profiles;
  static Serializer<GGetProfileByAddressData> get serializer =>
      _$gGetProfileByAddressDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileByAddressData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileByAddressData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileByAddressData.serializer,
        json,
      );
}

abstract class GGetProfileByAddressData_profiles
    implements
        Built<GGetProfileByAddressData_profiles,
            GGetProfileByAddressData_profilesBuilder> {
  GGetProfileByAddressData_profiles._();

  factory GGetProfileByAddressData_profiles(
          [void Function(GGetProfileByAddressData_profilesBuilder b) updates]) =
      _$GGetProfileByAddressData_profiles;

  static void _initializeBuilder(GGetProfileByAddressData_profilesBuilder b) =>
      b..G__typename = 'profiles';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get avatar;
  String get pubkey;
  String? get description;
  String? get title;
  String? get city;
  String? get data_cid;
  _i2.Gpoint? get geoloc;
  String get index_request_cid;
  _i3.JsonObject? get socials;
  _i2.Gtimestamp get time;
  static Serializer<GGetProfileByAddressData_profiles> get serializer =>
      _$gGetProfileByAddressDataProfilesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileByAddressData_profiles.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileByAddressData_profiles? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileByAddressData_profiles.serializer,
        json,
      );
}

abstract class GGetProfilesByAddressData
    implements
        Built<GGetProfilesByAddressData, GGetProfilesByAddressDataBuilder> {
  GGetProfilesByAddressData._();

  factory GGetProfilesByAddressData(
          [void Function(GGetProfilesByAddressDataBuilder b) updates]) =
      _$GGetProfilesByAddressData;

  static void _initializeBuilder(GGetProfilesByAddressDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetProfilesByAddressData_profiles> get profiles;
  static Serializer<GGetProfilesByAddressData> get serializer =>
      _$gGetProfilesByAddressDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfilesByAddressData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfilesByAddressData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfilesByAddressData.serializer,
        json,
      );
}

abstract class GGetProfilesByAddressData_profiles
    implements
        Built<GGetProfilesByAddressData_profiles,
            GGetProfilesByAddressData_profilesBuilder> {
  GGetProfilesByAddressData_profiles._();

  factory GGetProfilesByAddressData_profiles(
      [void Function(GGetProfilesByAddressData_profilesBuilder b)
          updates]) = _$GGetProfilesByAddressData_profiles;

  static void _initializeBuilder(GGetProfilesByAddressData_profilesBuilder b) =>
      b..G__typename = 'profiles';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get avatar;
  String get pubkey;
  String? get description;
  String? get title;
  String? get city;
  String? get data_cid;
  _i2.Gpoint? get geoloc;
  String get index_request_cid;
  _i3.JsonObject? get socials;
  _i2.Gtimestamp get time;
  static Serializer<GGetProfilesByAddressData_profiles> get serializer =>
      _$gGetProfilesByAddressDataProfilesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfilesByAddressData_profiles.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfilesByAddressData_profiles? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfilesByAddressData_profiles.serializer,
        json,
      );
}

abstract class GGetProfileCountData
    implements Built<GGetProfileCountData, GGetProfileCountDataBuilder> {
  GGetProfileCountData._();

  factory GGetProfileCountData(
          [void Function(GGetProfileCountDataBuilder b) updates]) =
      _$GGetProfileCountData;

  static void _initializeBuilder(GGetProfileCountDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetProfileCountData_profiles_aggregate get profiles_aggregate;
  static Serializer<GGetProfileCountData> get serializer =>
      _$gGetProfileCountDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileCountData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileCountData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileCountData.serializer,
        json,
      );
}

abstract class GGetProfileCountData_profiles_aggregate
    implements
        Built<GGetProfileCountData_profiles_aggregate,
            GGetProfileCountData_profiles_aggregateBuilder> {
  GGetProfileCountData_profiles_aggregate._();

  factory GGetProfileCountData_profiles_aggregate(
      [void Function(GGetProfileCountData_profiles_aggregateBuilder b)
          updates]) = _$GGetProfileCountData_profiles_aggregate;

  static void _initializeBuilder(
          GGetProfileCountData_profiles_aggregateBuilder b) =>
      b..G__typename = 'profiles_aggregate';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetProfileCountData_profiles_aggregate_aggregate? get aggregate;
  static Serializer<GGetProfileCountData_profiles_aggregate> get serializer =>
      _$gGetProfileCountDataProfilesAggregateSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileCountData_profiles_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileCountData_profiles_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileCountData_profiles_aggregate.serializer,
        json,
      );
}

abstract class GGetProfileCountData_profiles_aggregate_aggregate
    implements
        Built<GGetProfileCountData_profiles_aggregate_aggregate,
            GGetProfileCountData_profiles_aggregate_aggregateBuilder> {
  GGetProfileCountData_profiles_aggregate_aggregate._();

  factory GGetProfileCountData_profiles_aggregate_aggregate(
      [void Function(GGetProfileCountData_profiles_aggregate_aggregateBuilder b)
          updates]) = _$GGetProfileCountData_profiles_aggregate_aggregate;

  static void _initializeBuilder(
          GGetProfileCountData_profiles_aggregate_aggregateBuilder b) =>
      b..G__typename = 'profiles_aggregate_fields';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get count;
  static Serializer<GGetProfileCountData_profiles_aggregate_aggregate>
      get serializer =>
          _$gGetProfileCountDataProfilesAggregateAggregateSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileCountData_profiles_aggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileCountData_profiles_aggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileCountData_profiles_aggregate_aggregate.serializer,
        json,
      );
}

abstract class GSearchProfileByTermData
    implements
        Built<GSearchProfileByTermData, GSearchProfileByTermDataBuilder> {
  GSearchProfileByTermData._();

  factory GSearchProfileByTermData(
          [void Function(GSearchProfileByTermDataBuilder b) updates]) =
      _$GSearchProfileByTermData;

  static void _initializeBuilder(GSearchProfileByTermDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchProfileByTermData_profiles> get profiles;
  static Serializer<GSearchProfileByTermData> get serializer =>
      _$gSearchProfileByTermDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfileByTermData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfileByTermData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfileByTermData.serializer,
        json,
      );
}

abstract class GSearchProfileByTermData_profiles
    implements
        Built<GSearchProfileByTermData_profiles,
            GSearchProfileByTermData_profilesBuilder> {
  GSearchProfileByTermData_profiles._();

  factory GSearchProfileByTermData_profiles(
          [void Function(GSearchProfileByTermData_profilesBuilder b) updates]) =
      _$GSearchProfileByTermData_profiles;

  static void _initializeBuilder(GSearchProfileByTermData_profilesBuilder b) =>
      b..G__typename = 'profiles';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get avatar;
  String get pubkey;
  String? get description;
  String? get title;
  String? get city;
  String? get data_cid;
  _i2.Gpoint? get geoloc;
  String get index_request_cid;
  _i3.JsonObject? get socials;
  _i2.Gtimestamp get time;
  static Serializer<GSearchProfileByTermData_profiles> get serializer =>
      _$gSearchProfileByTermDataProfilesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfileByTermData_profiles.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfileByTermData_profiles? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfileByTermData_profiles.serializer,
        json,
      );
}

abstract class GSearchProfilesData
    implements Built<GSearchProfilesData, GSearchProfilesDataBuilder> {
  GSearchProfilesData._();

  factory GSearchProfilesData(
          [void Function(GSearchProfilesDataBuilder b) updates]) =
      _$GSearchProfilesData;

  static void _initializeBuilder(GSearchProfilesDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchProfilesData_profiles> get profiles;
  static Serializer<GSearchProfilesData> get serializer =>
      _$gSearchProfilesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfilesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfilesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfilesData.serializer,
        json,
      );
}

abstract class GSearchProfilesData_profiles
    implements
        Built<GSearchProfilesData_profiles,
            GSearchProfilesData_profilesBuilder> {
  GSearchProfilesData_profiles._();

  factory GSearchProfilesData_profiles(
          [void Function(GSearchProfilesData_profilesBuilder b) updates]) =
      _$GSearchProfilesData_profiles;

  static void _initializeBuilder(GSearchProfilesData_profilesBuilder b) =>
      b..G__typename = 'profiles';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get avatar;
  String get pubkey;
  String? get description;
  String? get title;
  String? get city;
  String? get data_cid;
  _i2.Gpoint? get geoloc;
  String get index_request_cid;
  _i3.JsonObject? get socials;
  _i2.Gtimestamp get time;
  static Serializer<GSearchProfilesData_profiles> get serializer =>
      _$gSearchProfilesDataProfilesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfilesData_profiles.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfilesData_profiles? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfilesData_profiles.serializer,
        json,
      );
}
