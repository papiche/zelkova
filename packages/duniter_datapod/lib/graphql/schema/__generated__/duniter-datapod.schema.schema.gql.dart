// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i2;
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i3;

part 'duniter-datapod.schema.schema.gql.g.dart';

class Gcursor_ordering extends EnumClass {
  const Gcursor_ordering._(String name) : super(name);

  static const Gcursor_ordering ASC = _$gcursorOrderingASC;

  static const Gcursor_ordering DESC = _$gcursorOrderingDESC;

  static Serializer<Gcursor_ordering> get serializer =>
      _$gcursorOrderingSerializer;

  static BuiltSet<Gcursor_ordering> get values => _$gcursorOrderingValues;

  static Gcursor_ordering valueOf(String name) =>
      _$gcursorOrderingValueOf(name);
}

abstract class GGeolocInput
    implements Built<GGeolocInput, GGeolocInputBuilder> {
  GGeolocInput._();

  factory GGeolocInput([void Function(GGeolocInputBuilder b) updates]) =
      _$GGeolocInput;

  double get latitude;
  double get longitude;
  static Serializer<GGeolocInput> get serializer => _$gGeolocInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGeolocInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGeolocInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGeolocInput.serializer,
        json,
      );
}

abstract class Gjsonb_cast_exp
    implements Built<Gjsonb_cast_exp, Gjsonb_cast_expBuilder> {
  Gjsonb_cast_exp._();

  factory Gjsonb_cast_exp([void Function(Gjsonb_cast_expBuilder b) updates]) =
      _$Gjsonb_cast_exp;

  @BuiltValueField(wireName: 'String')
  GString_comparison_exp? get GString;
  static Serializer<Gjsonb_cast_exp> get serializer =>
      _$gjsonbCastExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gjsonb_cast_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gjsonb_cast_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gjsonb_cast_exp.serializer,
        json,
      );
}

abstract class Gjsonb_comparison_exp
    implements Built<Gjsonb_comparison_exp, Gjsonb_comparison_expBuilder> {
  Gjsonb_comparison_exp._();

  factory Gjsonb_comparison_exp(
          [void Function(Gjsonb_comparison_expBuilder b) updates]) =
      _$Gjsonb_comparison_exp;

  @BuiltValueField(wireName: '_cast')
  Gjsonb_cast_exp? get G_cast;
  @BuiltValueField(wireName: '_contained_in')
  _i2.JsonObject? get G_contained_in;
  @BuiltValueField(wireName: '_contains')
  _i2.JsonObject? get G_contains;
  @BuiltValueField(wireName: '_eq')
  _i2.JsonObject? get G_eq;
  @BuiltValueField(wireName: '_gt')
  _i2.JsonObject? get G_gt;
  @BuiltValueField(wireName: '_gte')
  _i2.JsonObject? get G_gte;
  @BuiltValueField(wireName: '_has_key')
  String? get G_has_key;
  @BuiltValueField(wireName: '_has_keys_all')
  BuiltList<String>? get G_has_keys_all;
  @BuiltValueField(wireName: '_has_keys_any')
  BuiltList<String>? get G_has_keys_any;
  @BuiltValueField(wireName: '_in')
  BuiltList<_i2.JsonObject>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  _i2.JsonObject? get G_lt;
  @BuiltValueField(wireName: '_lte')
  _i2.JsonObject? get G_lte;
  @BuiltValueField(wireName: '_neq')
  _i2.JsonObject? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<_i2.JsonObject>? get G_nin;
  static Serializer<Gjsonb_comparison_exp> get serializer =>
      _$gjsonbComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gjsonb_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gjsonb_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gjsonb_comparison_exp.serializer,
        json,
      );
}

class Gorder_by extends EnumClass {
  const Gorder_by._(String name) : super(name);

  static const Gorder_by asc = _$gorderByasc;

  static const Gorder_by asc_nulls_first = _$gorderByasc_nulls_first;

  static const Gorder_by asc_nulls_last = _$gorderByasc_nulls_last;

  static const Gorder_by desc = _$gorderBydesc;

  static const Gorder_by desc_nulls_first = _$gorderBydesc_nulls_first;

  static const Gorder_by desc_nulls_last = _$gorderBydesc_nulls_last;

  static Serializer<Gorder_by> get serializer => _$gorderBySerializer;

  static BuiltSet<Gorder_by> get values => _$gorderByValues;

  static Gorder_by valueOf(String name) => _$gorderByValueOf(name);
}

abstract class Gpoint implements Built<Gpoint, GpointBuilder> {
  Gpoint._();

  factory Gpoint([String? value]) =>
      _$Gpoint((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gpoint> get serializer =>
      _i3.DefaultScalarSerializer<Gpoint>(
          (Object serialized) => Gpoint((serialized as String?)));
}

abstract class Gpoint_comparison_exp
    implements Built<Gpoint_comparison_exp, Gpoint_comparison_expBuilder> {
  Gpoint_comparison_exp._();

  factory Gpoint_comparison_exp(
          [void Function(Gpoint_comparison_expBuilder b) updates]) =
      _$Gpoint_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  Gpoint? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gpoint? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gpoint? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gpoint>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  Gpoint? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gpoint? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gpoint? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gpoint>? get G_nin;
  static Serializer<Gpoint_comparison_exp> get serializer =>
      _$gpointComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gpoint_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gpoint_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gpoint_comparison_exp.serializer,
        json,
      );
}

abstract class Gprofiles_bool_exp
    implements Built<Gprofiles_bool_exp, Gprofiles_bool_expBuilder> {
  Gprofiles_bool_exp._();

  factory Gprofiles_bool_exp(
          [void Function(Gprofiles_bool_expBuilder b) updates]) =
      _$Gprofiles_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gprofiles_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gprofiles_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gprofiles_bool_exp>? get G_or;
  GString_comparison_exp? get avatar;
  GString_comparison_exp? get city;
  GString_comparison_exp? get data_cid;
  GString_comparison_exp? get description;
  Gpoint_comparison_exp? get geoloc;
  GString_comparison_exp? get index_request_cid;
  GString_comparison_exp? get pubkey;
  Gjsonb_comparison_exp? get socials;
  Gtimestamp_comparison_exp? get time;
  GString_comparison_exp? get title;
  static Serializer<Gprofiles_bool_exp> get serializer =>
      _$gprofilesBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gprofiles_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gprofiles_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gprofiles_bool_exp.serializer,
        json,
      );
}

abstract class Gprofiles_order_by
    implements Built<Gprofiles_order_by, Gprofiles_order_byBuilder> {
  Gprofiles_order_by._();

  factory Gprofiles_order_by(
          [void Function(Gprofiles_order_byBuilder b) updates]) =
      _$Gprofiles_order_by;

  Gorder_by? get avatar;
  Gorder_by? get city;
  Gorder_by? get data_cid;
  Gorder_by? get description;
  Gorder_by? get geoloc;
  Gorder_by? get index_request_cid;
  Gorder_by? get pubkey;
  Gorder_by? get socials;
  Gorder_by? get time;
  Gorder_by? get title;
  static Serializer<Gprofiles_order_by> get serializer =>
      _$gprofilesOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gprofiles_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gprofiles_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gprofiles_order_by.serializer,
        json,
      );
}

class Gprofiles_select_column extends EnumClass {
  const Gprofiles_select_column._(String name) : super(name);

  static const Gprofiles_select_column avatar = _$gprofilesSelectColumnavatar;

  static const Gprofiles_select_column city = _$gprofilesSelectColumncity;

  static const Gprofiles_select_column data_cid =
      _$gprofilesSelectColumndata_cid;

  static const Gprofiles_select_column description =
      _$gprofilesSelectColumndescription;

  static const Gprofiles_select_column geoloc = _$gprofilesSelectColumngeoloc;

  static const Gprofiles_select_column index_request_cid =
      _$gprofilesSelectColumnindex_request_cid;

  static const Gprofiles_select_column pubkey = _$gprofilesSelectColumnpubkey;

  static const Gprofiles_select_column socials = _$gprofilesSelectColumnsocials;

  static const Gprofiles_select_column time = _$gprofilesSelectColumntime;

  static const Gprofiles_select_column title = _$gprofilesSelectColumntitle;

  static Serializer<Gprofiles_select_column> get serializer =>
      _$gprofilesSelectColumnSerializer;

  static BuiltSet<Gprofiles_select_column> get values =>
      _$gprofilesSelectColumnValues;

  static Gprofiles_select_column valueOf(String name) =>
      _$gprofilesSelectColumnValueOf(name);
}

abstract class Gprofiles_stream_cursor_input
    implements
        Built<Gprofiles_stream_cursor_input,
            Gprofiles_stream_cursor_inputBuilder> {
  Gprofiles_stream_cursor_input._();

  factory Gprofiles_stream_cursor_input(
          [void Function(Gprofiles_stream_cursor_inputBuilder b) updates]) =
      _$Gprofiles_stream_cursor_input;

  Gprofiles_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gprofiles_stream_cursor_input> get serializer =>
      _$gprofilesStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gprofiles_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gprofiles_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gprofiles_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gprofiles_stream_cursor_value_input
    implements
        Built<Gprofiles_stream_cursor_value_input,
            Gprofiles_stream_cursor_value_inputBuilder> {
  Gprofiles_stream_cursor_value_input._();

  factory Gprofiles_stream_cursor_value_input(
      [void Function(Gprofiles_stream_cursor_value_inputBuilder b)
          updates]) = _$Gprofiles_stream_cursor_value_input;

  String? get avatar;
  String? get city;
  String? get data_cid;
  String? get description;
  Gpoint? get geoloc;
  String? get index_request_cid;
  String? get pubkey;
  _i2.JsonObject? get socials;
  Gtimestamp? get time;
  String? get title;
  static Serializer<Gprofiles_stream_cursor_value_input> get serializer =>
      _$gprofilesStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gprofiles_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gprofiles_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gprofiles_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class GSocialInput
    implements Built<GSocialInput, GSocialInputBuilder> {
  GSocialInput._();

  factory GSocialInput([void Function(GSocialInputBuilder b) updates]) =
      _$GSocialInput;

  String? get type;
  String get url;
  static Serializer<GSocialInput> get serializer => _$gSocialInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSocialInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSocialInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSocialInput.serializer,
        json,
      );
}

abstract class GString_comparison_exp
    implements Built<GString_comparison_exp, GString_comparison_expBuilder> {
  GString_comparison_exp._();

  factory GString_comparison_exp(
          [void Function(GString_comparison_expBuilder b) updates]) =
      _$GString_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  String? get G_eq;
  @BuiltValueField(wireName: '_gt')
  String? get G_gt;
  @BuiltValueField(wireName: '_gte')
  String? get G_gte;
  @BuiltValueField(wireName: '_ilike')
  String? get G_ilike;
  @BuiltValueField(wireName: '_in')
  BuiltList<String>? get G_in;
  @BuiltValueField(wireName: '_iregex')
  String? get G_iregex;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_like')
  String? get G_like;
  @BuiltValueField(wireName: '_lt')
  String? get G_lt;
  @BuiltValueField(wireName: '_lte')
  String? get G_lte;
  @BuiltValueField(wireName: '_neq')
  String? get G_neq;
  @BuiltValueField(wireName: '_nilike')
  String? get G_nilike;
  @BuiltValueField(wireName: '_nin')
  BuiltList<String>? get G_nin;
  @BuiltValueField(wireName: '_niregex')
  String? get G_niregex;
  @BuiltValueField(wireName: '_nlike')
  String? get G_nlike;
  @BuiltValueField(wireName: '_nregex')
  String? get G_nregex;
  @BuiltValueField(wireName: '_nsimilar')
  String? get G_nsimilar;
  @BuiltValueField(wireName: '_regex')
  String? get G_regex;
  @BuiltValueField(wireName: '_similar')
  String? get G_similar;
  static Serializer<GString_comparison_exp> get serializer =>
      _$gStringComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GString_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GString_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GString_comparison_exp.serializer,
        json,
      );
}

abstract class Gtimestamp implements Built<Gtimestamp, GtimestampBuilder> {
  Gtimestamp._();

  factory Gtimestamp([String? value]) =>
      _$Gtimestamp((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gtimestamp> get serializer =>
      _i3.DefaultScalarSerializer<Gtimestamp>(
          (Object serialized) => Gtimestamp((serialized as String?)));
}

abstract class Gtimestamp_comparison_exp
    implements
        Built<Gtimestamp_comparison_exp, Gtimestamp_comparison_expBuilder> {
  Gtimestamp_comparison_exp._();

  factory Gtimestamp_comparison_exp(
          [void Function(Gtimestamp_comparison_expBuilder b) updates]) =
      _$Gtimestamp_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  Gtimestamp? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gtimestamp? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gtimestamp? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gtimestamp>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  Gtimestamp? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gtimestamp? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gtimestamp? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gtimestamp>? get G_nin;
  static Serializer<Gtimestamp_comparison_exp> get serializer =>
      _$gtimestampComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtimestamp_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtimestamp_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtimestamp_comparison_exp.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};
