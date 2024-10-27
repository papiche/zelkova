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
