// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ginkgo/graphql/__generated__/serializers.gql.dart' as _i1;
import 'package:gql_code_builder/src/serializers/default_scalar_serializer.dart'
    as _i2;

part 'duniter-indexer.schema.gql.g.dart';

abstract class Gaccount_bool_exp
    implements Built<Gaccount_bool_exp, Gaccount_bool_expBuilder> {
  Gaccount_bool_exp._();

  factory Gaccount_bool_exp([Function(Gaccount_bool_expBuilder b) updates]) =
      _$Gaccount_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gaccount_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gaccount_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gaccount_bool_exp>? get G_or;
  Gblock_bool_exp? get block;
  Gtimestamptz_comparison_exp? get created_at;
  GInt_comparison_exp? get created_on;
  GBoolean_comparison_exp? get has_identity;
  Gidentity_bool_exp? get identity;
  Gtimestamptz_comparison_exp? get killed_at;
  GInt_comparison_exp? get killed_on;
  GString_comparison_exp? get pubkey;
  Gtransaction_bool_exp? get transactions_issued;
  Gtransaction_aggregate_bool_exp? get transactions_issued_aggregate;
  Gtransaction_bool_exp? get transactions_received;
  Gtransaction_aggregate_bool_exp? get transactions_received_aggregate;
  static Serializer<Gaccount_bool_exp> get serializer =>
      _$gaccountBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gaccount_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gaccount_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gaccount_bool_exp.serializer,
        json,
      );
}

abstract class Gaccount_order_by
    implements Built<Gaccount_order_by, Gaccount_order_byBuilder> {
  Gaccount_order_by._();

  factory Gaccount_order_by([Function(Gaccount_order_byBuilder b) updates]) =
      _$Gaccount_order_by;

  Gblock_order_by? get block;
  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get has_identity;
  Gidentity_order_by? get identity;
  Gorder_by? get killed_at;
  Gorder_by? get killed_on;
  Gorder_by? get pubkey;
  Gtransaction_aggregate_order_by? get transactions_issued_aggregate;
  Gtransaction_aggregate_order_by? get transactions_received_aggregate;
  static Serializer<Gaccount_order_by> get serializer =>
      _$gaccountOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gaccount_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gaccount_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gaccount_order_by.serializer,
        json,
      );
}

class Gaccount_select_column extends EnumClass {
  const Gaccount_select_column._(String name) : super(name);

  static const Gaccount_select_column created_at =
      _$gaccountSelectColumncreated_at;

  static const Gaccount_select_column created_on =
      _$gaccountSelectColumncreated_on;

  static const Gaccount_select_column killed_at =
      _$gaccountSelectColumnkilled_at;

  static const Gaccount_select_column killed_on =
      _$gaccountSelectColumnkilled_on;

  static const Gaccount_select_column pubkey = _$gaccountSelectColumnpubkey;

  static Serializer<Gaccount_select_column> get serializer =>
      _$gaccountSelectColumnSerializer;

  static BuiltSet<Gaccount_select_column> get values =>
      _$gaccountSelectColumnValues;

  static Gaccount_select_column valueOf(String name) =>
      _$gaccountSelectColumnValueOf(name);
}

abstract class Gaccount_stream_cursor_input
    implements
        Built<Gaccount_stream_cursor_input,
            Gaccount_stream_cursor_inputBuilder> {
  Gaccount_stream_cursor_input._();

  factory Gaccount_stream_cursor_input(
          [Function(Gaccount_stream_cursor_inputBuilder b) updates]) =
      _$Gaccount_stream_cursor_input;

  Gaccount_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gaccount_stream_cursor_input> get serializer =>
      _$gaccountStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gaccount_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gaccount_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gaccount_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gaccount_stream_cursor_value_input
    implements
        Built<Gaccount_stream_cursor_value_input,
            Gaccount_stream_cursor_value_inputBuilder> {
  Gaccount_stream_cursor_value_input._();

  factory Gaccount_stream_cursor_value_input(
          [Function(Gaccount_stream_cursor_value_inputBuilder b) updates]) =
      _$Gaccount_stream_cursor_value_input;

  Gtimestamptz? get created_at;
  int? get created_on;
  Gtimestamptz? get killed_at;
  int? get killed_on;
  String? get pubkey;
  static Serializer<Gaccount_stream_cursor_value_input> get serializer =>
      _$gaccountStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gaccount_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gaccount_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gaccount_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gblock_bool_exp
    implements Built<Gblock_bool_exp, Gblock_bool_expBuilder> {
  Gblock_bool_exp._();

  factory Gblock_bool_exp([Function(Gblock_bool_expBuilder b) updates]) =
      _$Gblock_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gblock_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gblock_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gblock_bool_exp>? get G_or;
  Gtimestamp_comparison_exp? get created_at;
  Gjsonb_comparison_exp? get data;
  GString_comparison_exp? get hash;
  GInt_comparison_exp? get number;
  static Serializer<Gblock_bool_exp> get serializer =>
      _$gblockBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gblock_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gblock_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gblock_bool_exp.serializer,
        json,
      );
}

abstract class Gblock_order_by
    implements Built<Gblock_order_by, Gblock_order_byBuilder> {
  Gblock_order_by._();

  factory Gblock_order_by([Function(Gblock_order_byBuilder b) updates]) =
      _$Gblock_order_by;

  Gorder_by? get created_at;
  Gorder_by? get data;
  Gorder_by? get hash;
  Gorder_by? get number;
  static Serializer<Gblock_order_by> get serializer =>
      _$gblockOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gblock_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gblock_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gblock_order_by.serializer,
        json,
      );
}

class Gblock_select_column extends EnumClass {
  const Gblock_select_column._(String name) : super(name);

  static const Gblock_select_column created_at = _$gblockSelectColumncreated_at;

  static const Gblock_select_column data = _$gblockSelectColumndata;

  static const Gblock_select_column hash = _$gblockSelectColumnhash;

  static const Gblock_select_column number = _$gblockSelectColumnnumber;

  static Serializer<Gblock_select_column> get serializer =>
      _$gblockSelectColumnSerializer;

  static BuiltSet<Gblock_select_column> get values =>
      _$gblockSelectColumnValues;

  static Gblock_select_column valueOf(String name) =>
      _$gblockSelectColumnValueOf(name);
}

abstract class Gblock_stream_cursor_input
    implements
        Built<Gblock_stream_cursor_input, Gblock_stream_cursor_inputBuilder> {
  Gblock_stream_cursor_input._();

  factory Gblock_stream_cursor_input(
          [Function(Gblock_stream_cursor_inputBuilder b) updates]) =
      _$Gblock_stream_cursor_input;

  Gblock_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gblock_stream_cursor_input> get serializer =>
      _$gblockStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gblock_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gblock_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gblock_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gblock_stream_cursor_value_input
    implements
        Built<Gblock_stream_cursor_value_input,
            Gblock_stream_cursor_value_inputBuilder> {
  Gblock_stream_cursor_value_input._();

  factory Gblock_stream_cursor_value_input(
          [Function(Gblock_stream_cursor_value_inputBuilder b) updates]) =
      _$Gblock_stream_cursor_value_input;

  Gtimestamp? get created_at;
  Gjsonb? get data;
  String? get hash;
  int? get number;
  static Serializer<Gblock_stream_cursor_value_input> get serializer =>
      _$gblockStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gblock_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gblock_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gblock_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class GBoolean_comparison_exp
    implements Built<GBoolean_comparison_exp, GBoolean_comparison_expBuilder> {
  GBoolean_comparison_exp._();

  factory GBoolean_comparison_exp(
          [Function(GBoolean_comparison_expBuilder b) updates]) =
      _$GBoolean_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  bool? get G_eq;
  @BuiltValueField(wireName: '_gt')
  bool? get G_gt;
  @BuiltValueField(wireName: '_gte')
  bool? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<bool>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  bool? get G_lt;
  @BuiltValueField(wireName: '_lte')
  bool? get G_lte;
  @BuiltValueField(wireName: '_neq')
  bool? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<bool>? get G_nin;
  static Serializer<GBoolean_comparison_exp> get serializer =>
      _$gBooleanComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBoolean_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBoolean_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBoolean_comparison_exp.serializer,
        json,
      );
}

abstract class Gcertification_aggregate_bool_exp
    implements
        Built<Gcertification_aggregate_bool_exp,
            Gcertification_aggregate_bool_expBuilder> {
  Gcertification_aggregate_bool_exp._();

  factory Gcertification_aggregate_bool_exp(
          [Function(Gcertification_aggregate_bool_expBuilder b) updates]) =
      _$Gcertification_aggregate_bool_exp;

  Gcertification_aggregate_bool_exp_count? get count;
  static Serializer<Gcertification_aggregate_bool_exp> get serializer =>
      _$gcertificationAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_aggregate_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_aggregate_bool_exp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_aggregate_bool_exp.serializer,
        json,
      );
}

abstract class Gcertification_aggregate_bool_exp_count
    implements
        Built<Gcertification_aggregate_bool_exp_count,
            Gcertification_aggregate_bool_exp_countBuilder> {
  Gcertification_aggregate_bool_exp_count._();

  factory Gcertification_aggregate_bool_exp_count(
      [Function(Gcertification_aggregate_bool_exp_countBuilder b)
          updates]) = _$Gcertification_aggregate_bool_exp_count;

  BuiltList<Gcertification_select_column>? get arguments;
  bool? get distinct;
  Gcertification_bool_exp? get filter;
  GInt_comparison_exp get predicate;
  static Serializer<Gcertification_aggregate_bool_exp_count> get serializer =>
      _$gcertificationAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_aggregate_bool_exp_count.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_aggregate_bool_exp_count? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_aggregate_bool_exp_count.serializer,
        json,
      );
}

abstract class Gcertification_aggregate_order_by
    implements
        Built<Gcertification_aggregate_order_by,
            Gcertification_aggregate_order_byBuilder> {
  Gcertification_aggregate_order_by._();

  factory Gcertification_aggregate_order_by(
          [Function(Gcertification_aggregate_order_byBuilder b) updates]) =
      _$Gcertification_aggregate_order_by;

  Gcertification_avg_order_by? get avg;
  Gorder_by? get count;
  Gcertification_max_order_by? get max;
  Gcertification_min_order_by? get min;
  Gcertification_stddev_order_by? get stddev;
  Gcertification_stddev_pop_order_by? get stddev_pop;
  Gcertification_stddev_samp_order_by? get stddev_samp;
  Gcertification_sum_order_by? get sum;
  Gcertification_var_pop_order_by? get var_pop;
  Gcertification_var_samp_order_by? get var_samp;
  Gcertification_variance_order_by? get variance;
  static Serializer<Gcertification_aggregate_order_by> get serializer =>
      _$gcertificationAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_aggregate_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_aggregate_order_by.serializer,
        json,
      );
}

abstract class Gcertification_avg_order_by
    implements
        Built<Gcertification_avg_order_by, Gcertification_avg_order_byBuilder> {
  Gcertification_avg_order_by._();

  factory Gcertification_avg_order_by(
          [Function(Gcertification_avg_order_byBuilder b) updates]) =
      _$Gcertification_avg_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_avg_order_by> get serializer =>
      _$gcertificationAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_avg_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_avg_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_avg_order_by.serializer,
        json,
      );
}

abstract class Gcertification_bool_exp
    implements Built<Gcertification_bool_exp, Gcertification_bool_expBuilder> {
  Gcertification_bool_exp._();

  factory Gcertification_bool_exp(
          [Function(Gcertification_bool_expBuilder b) updates]) =
      _$Gcertification_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gcertification_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gcertification_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gcertification_bool_exp>? get G_or;
  Gtimestamptz_comparison_exp? get created_at;
  GInt_comparison_exp? get created_on;
  Gblock_bool_exp? get created_on_block;
  Gidentity_bool_exp? get issuer;
  GInt_comparison_exp? get issuer_index;
  Gidentity_bool_exp? get receiver;
  GInt_comparison_exp? get receiver_index;
  static Serializer<Gcertification_bool_exp> get serializer =>
      _$gcertificationBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_bool_exp.serializer,
        json,
      );
}

abstract class Gcertification_max_order_by
    implements
        Built<Gcertification_max_order_by, Gcertification_max_order_byBuilder> {
  Gcertification_max_order_by._();

  factory Gcertification_max_order_by(
          [Function(Gcertification_max_order_byBuilder b) updates]) =
      _$Gcertification_max_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_max_order_by> get serializer =>
      _$gcertificationMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_max_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_max_order_by.serializer,
        json,
      );
}

abstract class Gcertification_min_order_by
    implements
        Built<Gcertification_min_order_by, Gcertification_min_order_byBuilder> {
  Gcertification_min_order_by._();

  factory Gcertification_min_order_by(
          [Function(Gcertification_min_order_byBuilder b) updates]) =
      _$Gcertification_min_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_min_order_by> get serializer =>
      _$gcertificationMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_min_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_min_order_by.serializer,
        json,
      );
}

abstract class Gcertification_order_by
    implements Built<Gcertification_order_by, Gcertification_order_byBuilder> {
  Gcertification_order_by._();

  factory Gcertification_order_by(
          [Function(Gcertification_order_byBuilder b) updates]) =
      _$Gcertification_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gblock_order_by? get created_on_block;
  Gidentity_order_by? get issuer;
  Gorder_by? get issuer_index;
  Gidentity_order_by? get receiver;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_order_by> get serializer =>
      _$gcertificationOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_order_by.serializer,
        json,
      );
}

class Gcertification_select_column extends EnumClass {
  const Gcertification_select_column._(String name) : super(name);

  static const Gcertification_select_column created_at =
      _$gcertificationSelectColumncreated_at;

  static const Gcertification_select_column created_on =
      _$gcertificationSelectColumncreated_on;

  static const Gcertification_select_column issuer_index =
      _$gcertificationSelectColumnissuer_index;

  static const Gcertification_select_column receiver_index =
      _$gcertificationSelectColumnreceiver_index;

  static Serializer<Gcertification_select_column> get serializer =>
      _$gcertificationSelectColumnSerializer;

  static BuiltSet<Gcertification_select_column> get values =>
      _$gcertificationSelectColumnValues;

  static Gcertification_select_column valueOf(String name) =>
      _$gcertificationSelectColumnValueOf(name);
}

abstract class Gcertification_stddev_order_by
    implements
        Built<Gcertification_stddev_order_by,
            Gcertification_stddev_order_byBuilder> {
  Gcertification_stddev_order_by._();

  factory Gcertification_stddev_order_by(
          [Function(Gcertification_stddev_order_byBuilder b) updates]) =
      _$Gcertification_stddev_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_stddev_order_by> get serializer =>
      _$gcertificationStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_stddev_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_stddev_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_stddev_order_by.serializer,
        json,
      );
}

abstract class Gcertification_stddev_pop_order_by
    implements
        Built<Gcertification_stddev_pop_order_by,
            Gcertification_stddev_pop_order_byBuilder> {
  Gcertification_stddev_pop_order_by._();

  factory Gcertification_stddev_pop_order_by(
          [Function(Gcertification_stddev_pop_order_byBuilder b) updates]) =
      _$Gcertification_stddev_pop_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_stddev_pop_order_by> get serializer =>
      _$gcertificationStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_stddev_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_stddev_pop_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_stddev_pop_order_by.serializer,
        json,
      );
}

abstract class Gcertification_stddev_samp_order_by
    implements
        Built<Gcertification_stddev_samp_order_by,
            Gcertification_stddev_samp_order_byBuilder> {
  Gcertification_stddev_samp_order_by._();

  factory Gcertification_stddev_samp_order_by(
          [Function(Gcertification_stddev_samp_order_byBuilder b) updates]) =
      _$Gcertification_stddev_samp_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_stddev_samp_order_by> get serializer =>
      _$gcertificationStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_stddev_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_stddev_samp_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_stddev_samp_order_by.serializer,
        json,
      );
}

abstract class Gcertification_stream_cursor_input
    implements
        Built<Gcertification_stream_cursor_input,
            Gcertification_stream_cursor_inputBuilder> {
  Gcertification_stream_cursor_input._();

  factory Gcertification_stream_cursor_input(
          [Function(Gcertification_stream_cursor_inputBuilder b) updates]) =
      _$Gcertification_stream_cursor_input;

  Gcertification_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gcertification_stream_cursor_input> get serializer =>
      _$gcertificationStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_stream_cursor_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gcertification_stream_cursor_value_input
    implements
        Built<Gcertification_stream_cursor_value_input,
            Gcertification_stream_cursor_value_inputBuilder> {
  Gcertification_stream_cursor_value_input._();

  factory Gcertification_stream_cursor_value_input(
      [Function(Gcertification_stream_cursor_value_inputBuilder b)
          updates]) = _$Gcertification_stream_cursor_value_input;

  Gtimestamptz? get created_at;
  int? get created_on;
  int? get issuer_index;
  int? get receiver_index;
  static Serializer<Gcertification_stream_cursor_value_input> get serializer =>
      _$gcertificationStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gcertification_sum_order_by
    implements
        Built<Gcertification_sum_order_by, Gcertification_sum_order_byBuilder> {
  Gcertification_sum_order_by._();

  factory Gcertification_sum_order_by(
          [Function(Gcertification_sum_order_byBuilder b) updates]) =
      _$Gcertification_sum_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_sum_order_by> get serializer =>
      _$gcertificationSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_sum_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_sum_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_sum_order_by.serializer,
        json,
      );
}

abstract class Gcertification_var_pop_order_by
    implements
        Built<Gcertification_var_pop_order_by,
            Gcertification_var_pop_order_byBuilder> {
  Gcertification_var_pop_order_by._();

  factory Gcertification_var_pop_order_by(
          [Function(Gcertification_var_pop_order_byBuilder b) updates]) =
      _$Gcertification_var_pop_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_var_pop_order_by> get serializer =>
      _$gcertificationVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_var_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_var_pop_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_var_pop_order_by.serializer,
        json,
      );
}

abstract class Gcertification_var_samp_order_by
    implements
        Built<Gcertification_var_samp_order_by,
            Gcertification_var_samp_order_byBuilder> {
  Gcertification_var_samp_order_by._();

  factory Gcertification_var_samp_order_by(
          [Function(Gcertification_var_samp_order_byBuilder b) updates]) =
      _$Gcertification_var_samp_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_var_samp_order_by> get serializer =>
      _$gcertificationVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_var_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_var_samp_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_var_samp_order_by.serializer,
        json,
      );
}

abstract class Gcertification_variance_order_by
    implements
        Built<Gcertification_variance_order_by,
            Gcertification_variance_order_byBuilder> {
  Gcertification_variance_order_by._();

  factory Gcertification_variance_order_by(
          [Function(Gcertification_variance_order_byBuilder b) updates]) =
      _$Gcertification_variance_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gcertification_variance_order_by> get serializer =>
      _$gcertificationVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gcertification_variance_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gcertification_variance_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gcertification_variance_order_by.serializer,
        json,
      );
}

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

abstract class Gdate implements Built<Gdate, GdateBuilder> {
  Gdate._();

  factory Gdate([String? value]) =>
      _$Gdate((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gdate> get serializer => _i2.DefaultScalarSerializer<Gdate>(
      (Object serialized) => Gdate((serialized as String?)));
}

abstract class GFloat_comparison_exp
    implements Built<GFloat_comparison_exp, GFloat_comparison_expBuilder> {
  GFloat_comparison_exp._();

  factory GFloat_comparison_exp(
          [Function(GFloat_comparison_expBuilder b) updates]) =
      _$GFloat_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  double? get G_eq;
  @BuiltValueField(wireName: '_gt')
  double? get G_gt;
  @BuiltValueField(wireName: '_gte')
  double? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<double>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  double? get G_lt;
  @BuiltValueField(wireName: '_lte')
  double? get G_lte;
  @BuiltValueField(wireName: '_neq')
  double? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<double>? get G_nin;
  static Serializer<GFloat_comparison_exp> get serializer =>
      _$gFloatComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFloat_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFloat_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFloat_comparison_exp.serializer,
        json,
      );
}

abstract class Gidentity_bool_exp
    implements Built<Gidentity_bool_exp, Gidentity_bool_expBuilder> {
  Gidentity_bool_exp._();

  factory Gidentity_bool_exp([Function(Gidentity_bool_expBuilder b) updates]) =
      _$Gidentity_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gidentity_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gidentity_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gidentity_bool_exp>? get G_or;
  Gaccount_bool_exp? get account;
  Gcertification_bool_exp? get cert_issued;
  Gcertification_aggregate_bool_exp? get cert_issued_aggregate;
  Gcertification_bool_exp? get cert_received;
  Gcertification_aggregate_bool_exp? get cert_received_aggregate;
  Gtimestamptz_comparison_exp? get confirmed_at;
  GInt_comparison_exp? get confirmed_on;
  Gblock_bool_exp? get confirmed_on_block;
  GInt_comparison_exp? get created_on;
  Gblock_bool_exp? get created_on_block;
  GInt_comparison_exp? get index;
  GString_comparison_exp? get name;
  GString_comparison_exp? get pubkey;
  Gtimestamptz_comparison_exp? get revoked_at;
  GInt_comparison_exp? get revoked_on;
  Gblock_bool_exp? get revoked_on_block;
  Gtimestamptz_comparison_exp? get validated_at;
  GInt_comparison_exp? get validated_on;
  Gblock_bool_exp? get validated_on_block;
  static Serializer<Gidentity_bool_exp> get serializer =>
      _$gidentityBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gidentity_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gidentity_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gidentity_bool_exp.serializer,
        json,
      );
}

abstract class Gidentity_order_by
    implements Built<Gidentity_order_by, Gidentity_order_byBuilder> {
  Gidentity_order_by._();

  factory Gidentity_order_by([Function(Gidentity_order_byBuilder b) updates]) =
      _$Gidentity_order_by;

  Gaccount_order_by? get account;
  Gcertification_aggregate_order_by? get cert_issued_aggregate;
  Gcertification_aggregate_order_by? get cert_received_aggregate;
  Gorder_by? get confirmed_at;
  Gorder_by? get confirmed_on;
  Gblock_order_by? get confirmed_on_block;
  Gorder_by? get created_on;
  Gblock_order_by? get created_on_block;
  Gorder_by? get index;
  Gorder_by? get name;
  Gorder_by? get pubkey;
  Gorder_by? get revoked_at;
  Gorder_by? get revoked_on;
  Gblock_order_by? get revoked_on_block;
  Gorder_by? get validated_at;
  Gorder_by? get validated_on;
  Gblock_order_by? get validated_on_block;
  static Serializer<Gidentity_order_by> get serializer =>
      _$gidentityOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gidentity_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gidentity_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gidentity_order_by.serializer,
        json,
      );
}

class Gidentity_select_column extends EnumClass {
  const Gidentity_select_column._(String name) : super(name);

  static const Gidentity_select_column confirmed_at =
      _$gidentitySelectColumnconfirmed_at;

  static const Gidentity_select_column confirmed_on =
      _$gidentitySelectColumnconfirmed_on;

  static const Gidentity_select_column created_on =
      _$gidentitySelectColumncreated_on;

  static const Gidentity_select_column index = _$gidentitySelectColumnindex;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gidentity_select_column Gname = _$gidentitySelectColumnGname;

  static const Gidentity_select_column pubkey = _$gidentitySelectColumnpubkey;

  static const Gidentity_select_column revoked_at =
      _$gidentitySelectColumnrevoked_at;

  static const Gidentity_select_column revoked_on =
      _$gidentitySelectColumnrevoked_on;

  static const Gidentity_select_column validated_at =
      _$gidentitySelectColumnvalidated_at;

  static const Gidentity_select_column validated_on =
      _$gidentitySelectColumnvalidated_on;

  static Serializer<Gidentity_select_column> get serializer =>
      _$gidentitySelectColumnSerializer;

  static BuiltSet<Gidentity_select_column> get values =>
      _$gidentitySelectColumnValues;

  static Gidentity_select_column valueOf(String name) =>
      _$gidentitySelectColumnValueOf(name);
}

abstract class Gidentity_stream_cursor_input
    implements
        Built<Gidentity_stream_cursor_input,
            Gidentity_stream_cursor_inputBuilder> {
  Gidentity_stream_cursor_input._();

  factory Gidentity_stream_cursor_input(
          [Function(Gidentity_stream_cursor_inputBuilder b) updates]) =
      _$Gidentity_stream_cursor_input;

  Gidentity_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gidentity_stream_cursor_input> get serializer =>
      _$gidentityStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gidentity_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gidentity_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gidentity_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gidentity_stream_cursor_value_input
    implements
        Built<Gidentity_stream_cursor_value_input,
            Gidentity_stream_cursor_value_inputBuilder> {
  Gidentity_stream_cursor_value_input._();

  factory Gidentity_stream_cursor_value_input(
          [Function(Gidentity_stream_cursor_value_inputBuilder b) updates]) =
      _$Gidentity_stream_cursor_value_input;

  Gtimestamptz? get confirmed_at;
  int? get confirmed_on;
  int? get created_on;
  int? get index;
  String? get name;
  String? get pubkey;
  Gtimestamptz? get revoked_at;
  int? get revoked_on;
  Gtimestamptz? get validated_at;
  int? get validated_on;
  static Serializer<Gidentity_stream_cursor_value_input> get serializer =>
      _$gidentityStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gidentity_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gidentity_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gidentity_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class GInt_comparison_exp
    implements Built<GInt_comparison_exp, GInt_comparison_expBuilder> {
  GInt_comparison_exp._();

  factory GInt_comparison_exp(
      [Function(GInt_comparison_expBuilder b) updates]) = _$GInt_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  int? get G_eq;
  @BuiltValueField(wireName: '_gt')
  int? get G_gt;
  @BuiltValueField(wireName: '_gte')
  int? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<int>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  int? get G_lt;
  @BuiltValueField(wireName: '_lte')
  int? get G_lte;
  @BuiltValueField(wireName: '_neq')
  int? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<int>? get G_nin;
  static Serializer<GInt_comparison_exp> get serializer =>
      _$gIntComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GInt_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GInt_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GInt_comparison_exp.serializer,
        json,
      );
}

abstract class Gjsonb implements Built<Gjsonb, GjsonbBuilder> {
  Gjsonb._();

  factory Gjsonb([String? value]) =>
      _$Gjsonb((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gjsonb> get serializer =>
      _i2.DefaultScalarSerializer<Gjsonb>(
          (Object serialized) => Gjsonb((serialized as String?)));
}

abstract class Gjsonb_cast_exp
    implements Built<Gjsonb_cast_exp, Gjsonb_cast_expBuilder> {
  Gjsonb_cast_exp._();

  factory Gjsonb_cast_exp([Function(Gjsonb_cast_expBuilder b) updates]) =
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
          [Function(Gjsonb_comparison_expBuilder b) updates]) =
      _$Gjsonb_comparison_exp;

  @BuiltValueField(wireName: '_cast')
  Gjsonb_cast_exp? get G_cast;
  @BuiltValueField(wireName: '_contained_in')
  Gjsonb? get G_contained_in;
  @BuiltValueField(wireName: '_contains')
  Gjsonb? get G_contains;
  @BuiltValueField(wireName: '_eq')
  Gjsonb? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gjsonb? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gjsonb? get G_gte;
  @BuiltValueField(wireName: '_has_key')
  String? get G_has_key;
  @BuiltValueField(wireName: '_has_keys_all')
  BuiltList<String>? get G_has_keys_all;
  @BuiltValueField(wireName: '_has_keys_any')
  BuiltList<String>? get G_has_keys_any;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gjsonb>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  Gjsonb? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gjsonb? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gjsonb? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gjsonb>? get G_nin;
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

abstract class Gparameters_bool_exp
    implements Built<Gparameters_bool_exp, Gparameters_bool_expBuilder> {
  Gparameters_bool_exp._();

  factory Gparameters_bool_exp(
          [Function(Gparameters_bool_expBuilder b) updates]) =
      _$Gparameters_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gparameters_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gparameters_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gparameters_bool_exp>? get G_or;
  GString_comparison_exp? get key;
  Gjsonb_comparison_exp? get value;
  static Serializer<Gparameters_bool_exp> get serializer =>
      _$gparametersBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gparameters_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gparameters_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gparameters_bool_exp.serializer,
        json,
      );
}

abstract class Gparameters_order_by
    implements Built<Gparameters_order_by, Gparameters_order_byBuilder> {
  Gparameters_order_by._();

  factory Gparameters_order_by(
          [Function(Gparameters_order_byBuilder b) updates]) =
      _$Gparameters_order_by;

  Gorder_by? get key;
  Gorder_by? get value;
  static Serializer<Gparameters_order_by> get serializer =>
      _$gparametersOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gparameters_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gparameters_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gparameters_order_by.serializer,
        json,
      );
}

class Gparameters_select_column extends EnumClass {
  const Gparameters_select_column._(String name) : super(name);

  static const Gparameters_select_column key = _$gparametersSelectColumnkey;

  static const Gparameters_select_column value = _$gparametersSelectColumnvalue;

  static Serializer<Gparameters_select_column> get serializer =>
      _$gparametersSelectColumnSerializer;

  static BuiltSet<Gparameters_select_column> get values =>
      _$gparametersSelectColumnValues;

  static Gparameters_select_column valueOf(String name) =>
      _$gparametersSelectColumnValueOf(name);
}

abstract class Gparameters_stream_cursor_input
    implements
        Built<Gparameters_stream_cursor_input,
            Gparameters_stream_cursor_inputBuilder> {
  Gparameters_stream_cursor_input._();

  factory Gparameters_stream_cursor_input(
          [Function(Gparameters_stream_cursor_inputBuilder b) updates]) =
      _$Gparameters_stream_cursor_input;

  Gparameters_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gparameters_stream_cursor_input> get serializer =>
      _$gparametersStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gparameters_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gparameters_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gparameters_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gparameters_stream_cursor_value_input
    implements
        Built<Gparameters_stream_cursor_value_input,
            Gparameters_stream_cursor_value_inputBuilder> {
  Gparameters_stream_cursor_value_input._();

  factory Gparameters_stream_cursor_value_input(
          [Function(Gparameters_stream_cursor_value_inputBuilder b) updates]) =
      _$Gparameters_stream_cursor_value_input;

  String? get key;
  Gjsonb? get value;
  static Serializer<Gparameters_stream_cursor_value_input> get serializer =>
      _$gparametersStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gparameters_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gparameters_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gparameters_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gsearch_identity_args
    implements Built<Gsearch_identity_args, Gsearch_identity_argsBuilder> {
  Gsearch_identity_args._();

  factory Gsearch_identity_args(
          [Function(Gsearch_identity_argsBuilder b) updates]) =
      _$Gsearch_identity_args;

  String? get name;
  static Serializer<Gsearch_identity_args> get serializer =>
      _$gsearchIdentityArgsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsearch_identity_args.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsearch_identity_args? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsearch_identity_args.serializer,
        json,
      );
}

abstract class Gsmith_bool_exp
    implements Built<Gsmith_bool_exp, Gsmith_bool_expBuilder> {
  Gsmith_bool_exp._();

  factory Gsmith_bool_exp([Function(Gsmith_bool_expBuilder b) updates]) =
      _$Gsmith_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gsmith_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gsmith_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gsmith_bool_exp>? get G_or;
  Gsmith_cert_bool_exp? get cert_issued;
  Gsmith_cert_aggregate_bool_exp? get cert_issued_aggregate;
  Gsmith_cert_bool_exp? get cert_received;
  Gsmith_cert_aggregate_bool_exp? get cert_received_aggregate;
  Gidentity_bool_exp? get identity;
  GInt_comparison_exp? get idty_index;
  static Serializer<Gsmith_bool_exp> get serializer =>
      _$gsmithBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_bool_exp.serializer,
        json,
      );
}

abstract class Gsmith_cert_aggregate_bool_exp
    implements
        Built<Gsmith_cert_aggregate_bool_exp,
            Gsmith_cert_aggregate_bool_expBuilder> {
  Gsmith_cert_aggregate_bool_exp._();

  factory Gsmith_cert_aggregate_bool_exp(
          [Function(Gsmith_cert_aggregate_bool_expBuilder b) updates]) =
      _$Gsmith_cert_aggregate_bool_exp;

  Gsmith_cert_aggregate_bool_exp_count? get count;
  static Serializer<Gsmith_cert_aggregate_bool_exp> get serializer =>
      _$gsmithCertAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_aggregate_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_aggregate_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_aggregate_bool_exp.serializer,
        json,
      );
}

abstract class Gsmith_cert_aggregate_bool_exp_count
    implements
        Built<Gsmith_cert_aggregate_bool_exp_count,
            Gsmith_cert_aggregate_bool_exp_countBuilder> {
  Gsmith_cert_aggregate_bool_exp_count._();

  factory Gsmith_cert_aggregate_bool_exp_count(
          [Function(Gsmith_cert_aggregate_bool_exp_countBuilder b) updates]) =
      _$Gsmith_cert_aggregate_bool_exp_count;

  BuiltList<Gsmith_cert_select_column>? get arguments;
  bool? get distinct;
  Gsmith_cert_bool_exp? get filter;
  GInt_comparison_exp get predicate;
  static Serializer<Gsmith_cert_aggregate_bool_exp_count> get serializer =>
      _$gsmithCertAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_aggregate_bool_exp_count.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_aggregate_bool_exp_count? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_aggregate_bool_exp_count.serializer,
        json,
      );
}

abstract class Gsmith_cert_aggregate_order_by
    implements
        Built<Gsmith_cert_aggregate_order_by,
            Gsmith_cert_aggregate_order_byBuilder> {
  Gsmith_cert_aggregate_order_by._();

  factory Gsmith_cert_aggregate_order_by(
          [Function(Gsmith_cert_aggregate_order_byBuilder b) updates]) =
      _$Gsmith_cert_aggregate_order_by;

  Gsmith_cert_avg_order_by? get avg;
  Gorder_by? get count;
  Gsmith_cert_max_order_by? get max;
  Gsmith_cert_min_order_by? get min;
  Gsmith_cert_stddev_order_by? get stddev;
  Gsmith_cert_stddev_pop_order_by? get stddev_pop;
  Gsmith_cert_stddev_samp_order_by? get stddev_samp;
  Gsmith_cert_sum_order_by? get sum;
  Gsmith_cert_var_pop_order_by? get var_pop;
  Gsmith_cert_var_samp_order_by? get var_samp;
  Gsmith_cert_variance_order_by? get variance;
  static Serializer<Gsmith_cert_aggregate_order_by> get serializer =>
      _$gsmithCertAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_aggregate_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_aggregate_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_avg_order_by
    implements
        Built<Gsmith_cert_avg_order_by, Gsmith_cert_avg_order_byBuilder> {
  Gsmith_cert_avg_order_by._();

  factory Gsmith_cert_avg_order_by(
          [Function(Gsmith_cert_avg_order_byBuilder b) updates]) =
      _$Gsmith_cert_avg_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_avg_order_by> get serializer =>
      _$gsmithCertAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_avg_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_avg_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_avg_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_bool_exp
    implements Built<Gsmith_cert_bool_exp, Gsmith_cert_bool_expBuilder> {
  Gsmith_cert_bool_exp._();

  factory Gsmith_cert_bool_exp(
          [Function(Gsmith_cert_bool_expBuilder b) updates]) =
      _$Gsmith_cert_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gsmith_cert_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gsmith_cert_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gsmith_cert_bool_exp>? get G_or;
  Gtimestamptz_comparison_exp? get created_at;
  GInt_comparison_exp? get created_on;
  Gblock_bool_exp? get created_on_block;
  Gsmith_bool_exp? get issuer;
  GInt_comparison_exp? get issuer_index;
  Gsmith_bool_exp? get receiver;
  GInt_comparison_exp? get receiver_index;
  static Serializer<Gsmith_cert_bool_exp> get serializer =>
      _$gsmithCertBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_bool_exp.serializer,
        json,
      );
}

abstract class Gsmith_cert_max_order_by
    implements
        Built<Gsmith_cert_max_order_by, Gsmith_cert_max_order_byBuilder> {
  Gsmith_cert_max_order_by._();

  factory Gsmith_cert_max_order_by(
          [Function(Gsmith_cert_max_order_byBuilder b) updates]) =
      _$Gsmith_cert_max_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_max_order_by> get serializer =>
      _$gsmithCertMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_max_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_max_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_min_order_by
    implements
        Built<Gsmith_cert_min_order_by, Gsmith_cert_min_order_byBuilder> {
  Gsmith_cert_min_order_by._();

  factory Gsmith_cert_min_order_by(
          [Function(Gsmith_cert_min_order_byBuilder b) updates]) =
      _$Gsmith_cert_min_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_min_order_by> get serializer =>
      _$gsmithCertMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_min_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_min_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_order_by
    implements Built<Gsmith_cert_order_by, Gsmith_cert_order_byBuilder> {
  Gsmith_cert_order_by._();

  factory Gsmith_cert_order_by(
          [Function(Gsmith_cert_order_byBuilder b) updates]) =
      _$Gsmith_cert_order_by;

  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gblock_order_by? get created_on_block;
  Gsmith_order_by? get issuer;
  Gorder_by? get issuer_index;
  Gsmith_order_by? get receiver;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_order_by> get serializer =>
      _$gsmithCertOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_order_by.serializer,
        json,
      );
}

class Gsmith_cert_select_column extends EnumClass {
  const Gsmith_cert_select_column._(String name) : super(name);

  static const Gsmith_cert_select_column created_at =
      _$gsmithCertSelectColumncreated_at;

  static const Gsmith_cert_select_column created_on =
      _$gsmithCertSelectColumncreated_on;

  static const Gsmith_cert_select_column issuer_index =
      _$gsmithCertSelectColumnissuer_index;

  static const Gsmith_cert_select_column receiver_index =
      _$gsmithCertSelectColumnreceiver_index;

  static Serializer<Gsmith_cert_select_column> get serializer =>
      _$gsmithCertSelectColumnSerializer;

  static BuiltSet<Gsmith_cert_select_column> get values =>
      _$gsmithCertSelectColumnValues;

  static Gsmith_cert_select_column valueOf(String name) =>
      _$gsmithCertSelectColumnValueOf(name);
}

abstract class Gsmith_cert_stddev_order_by
    implements
        Built<Gsmith_cert_stddev_order_by, Gsmith_cert_stddev_order_byBuilder> {
  Gsmith_cert_stddev_order_by._();

  factory Gsmith_cert_stddev_order_by(
          [Function(Gsmith_cert_stddev_order_byBuilder b) updates]) =
      _$Gsmith_cert_stddev_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_stddev_order_by> get serializer =>
      _$gsmithCertStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_stddev_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_stddev_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_stddev_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_stddev_pop_order_by
    implements
        Built<Gsmith_cert_stddev_pop_order_by,
            Gsmith_cert_stddev_pop_order_byBuilder> {
  Gsmith_cert_stddev_pop_order_by._();

  factory Gsmith_cert_stddev_pop_order_by(
          [Function(Gsmith_cert_stddev_pop_order_byBuilder b) updates]) =
      _$Gsmith_cert_stddev_pop_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_stddev_pop_order_by> get serializer =>
      _$gsmithCertStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_stddev_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_stddev_pop_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_stddev_pop_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_stddev_samp_order_by
    implements
        Built<Gsmith_cert_stddev_samp_order_by,
            Gsmith_cert_stddev_samp_order_byBuilder> {
  Gsmith_cert_stddev_samp_order_by._();

  factory Gsmith_cert_stddev_samp_order_by(
          [Function(Gsmith_cert_stddev_samp_order_byBuilder b) updates]) =
      _$Gsmith_cert_stddev_samp_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_stddev_samp_order_by> get serializer =>
      _$gsmithCertStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_stddev_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_stddev_samp_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_stddev_samp_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_stream_cursor_input
    implements
        Built<Gsmith_cert_stream_cursor_input,
            Gsmith_cert_stream_cursor_inputBuilder> {
  Gsmith_cert_stream_cursor_input._();

  factory Gsmith_cert_stream_cursor_input(
          [Function(Gsmith_cert_stream_cursor_inputBuilder b) updates]) =
      _$Gsmith_cert_stream_cursor_input;

  Gsmith_cert_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gsmith_cert_stream_cursor_input> get serializer =>
      _$gsmithCertStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gsmith_cert_stream_cursor_value_input
    implements
        Built<Gsmith_cert_stream_cursor_value_input,
            Gsmith_cert_stream_cursor_value_inputBuilder> {
  Gsmith_cert_stream_cursor_value_input._();

  factory Gsmith_cert_stream_cursor_value_input(
          [Function(Gsmith_cert_stream_cursor_value_inputBuilder b) updates]) =
      _$Gsmith_cert_stream_cursor_value_input;

  Gtimestamptz? get created_at;
  int? get created_on;
  int? get issuer_index;
  int? get receiver_index;
  static Serializer<Gsmith_cert_stream_cursor_value_input> get serializer =>
      _$gsmithCertStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gsmith_cert_sum_order_by
    implements
        Built<Gsmith_cert_sum_order_by, Gsmith_cert_sum_order_byBuilder> {
  Gsmith_cert_sum_order_by._();

  factory Gsmith_cert_sum_order_by(
          [Function(Gsmith_cert_sum_order_byBuilder b) updates]) =
      _$Gsmith_cert_sum_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_sum_order_by> get serializer =>
      _$gsmithCertSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_sum_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_sum_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_sum_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_var_pop_order_by
    implements
        Built<Gsmith_cert_var_pop_order_by,
            Gsmith_cert_var_pop_order_byBuilder> {
  Gsmith_cert_var_pop_order_by._();

  factory Gsmith_cert_var_pop_order_by(
          [Function(Gsmith_cert_var_pop_order_byBuilder b) updates]) =
      _$Gsmith_cert_var_pop_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_var_pop_order_by> get serializer =>
      _$gsmithCertVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_var_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_var_pop_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_var_pop_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_var_samp_order_by
    implements
        Built<Gsmith_cert_var_samp_order_by,
            Gsmith_cert_var_samp_order_byBuilder> {
  Gsmith_cert_var_samp_order_by._();

  factory Gsmith_cert_var_samp_order_by(
          [Function(Gsmith_cert_var_samp_order_byBuilder b) updates]) =
      _$Gsmith_cert_var_samp_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_var_samp_order_by> get serializer =>
      _$gsmithCertVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_var_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_var_samp_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_var_samp_order_by.serializer,
        json,
      );
}

abstract class Gsmith_cert_variance_order_by
    implements
        Built<Gsmith_cert_variance_order_by,
            Gsmith_cert_variance_order_byBuilder> {
  Gsmith_cert_variance_order_by._();

  factory Gsmith_cert_variance_order_by(
          [Function(Gsmith_cert_variance_order_byBuilder b) updates]) =
      _$Gsmith_cert_variance_order_by;

  Gorder_by? get created_on;
  Gorder_by? get issuer_index;
  Gorder_by? get receiver_index;
  static Serializer<Gsmith_cert_variance_order_by> get serializer =>
      _$gsmithCertVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_cert_variance_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_cert_variance_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_cert_variance_order_by.serializer,
        json,
      );
}

abstract class Gsmith_order_by
    implements Built<Gsmith_order_by, Gsmith_order_byBuilder> {
  Gsmith_order_by._();

  factory Gsmith_order_by([Function(Gsmith_order_byBuilder b) updates]) =
      _$Gsmith_order_by;

  Gsmith_cert_aggregate_order_by? get cert_issued_aggregate;
  Gsmith_cert_aggregate_order_by? get cert_received_aggregate;
  Gidentity_order_by? get identity;
  Gorder_by? get idty_index;
  static Serializer<Gsmith_order_by> get serializer =>
      _$gsmithOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_order_by.serializer,
        json,
      );
}

class Gsmith_select_column extends EnumClass {
  const Gsmith_select_column._(String name) : super(name);

  static const Gsmith_select_column idty_index = _$gsmithSelectColumnidty_index;

  static Serializer<Gsmith_select_column> get serializer =>
      _$gsmithSelectColumnSerializer;

  static BuiltSet<Gsmith_select_column> get values =>
      _$gsmithSelectColumnValues;

  static Gsmith_select_column valueOf(String name) =>
      _$gsmithSelectColumnValueOf(name);
}

abstract class Gsmith_stream_cursor_input
    implements
        Built<Gsmith_stream_cursor_input, Gsmith_stream_cursor_inputBuilder> {
  Gsmith_stream_cursor_input._();

  factory Gsmith_stream_cursor_input(
          [Function(Gsmith_stream_cursor_inputBuilder b) updates]) =
      _$Gsmith_stream_cursor_input;

  Gsmith_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gsmith_stream_cursor_input> get serializer =>
      _$gsmithStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_stream_cursor_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gsmith_stream_cursor_value_input
    implements
        Built<Gsmith_stream_cursor_value_input,
            Gsmith_stream_cursor_value_inputBuilder> {
  Gsmith_stream_cursor_value_input._();

  factory Gsmith_stream_cursor_value_input(
          [Function(Gsmith_stream_cursor_value_inputBuilder b) updates]) =
      _$Gsmith_stream_cursor_value_input;

  int? get idty_index;
  static Serializer<Gsmith_stream_cursor_value_input> get serializer =>
      _$gsmithStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gsmith_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gsmith_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gsmith_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class GString_comparison_exp
    implements Built<GString_comparison_exp, GString_comparison_expBuilder> {
  GString_comparison_exp._();

  factory GString_comparison_exp(
          [Function(GString_comparison_expBuilder b) updates]) =
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

abstract class Gtime_period
    implements Built<Gtime_period, Gtime_periodBuilder> {
  Gtime_period._();

  factory Gtime_period([String? value]) =>
      _$Gtime_period((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gtime_period> get serializer =>
      _i2.DefaultScalarSerializer<Gtime_period>(
          (Object serialized) => Gtime_period((serialized as String?)));
}

abstract class Gtimestamp implements Built<Gtimestamp, GtimestampBuilder> {
  Gtimestamp._();

  factory Gtimestamp([String? value]) =>
      _$Gtimestamp((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gtimestamp> get serializer =>
      _i2.DefaultScalarSerializer<Gtimestamp>(
          (Object serialized) => Gtimestamp((serialized as String?)));
}

abstract class Gtimestamp_comparison_exp
    implements
        Built<Gtimestamp_comparison_exp, Gtimestamp_comparison_expBuilder> {
  Gtimestamp_comparison_exp._();

  factory Gtimestamp_comparison_exp(
          [Function(Gtimestamp_comparison_expBuilder b) updates]) =
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

abstract class Gtimestamptz
    implements Built<Gtimestamptz, GtimestamptzBuilder> {
  Gtimestamptz._();

  factory Gtimestamptz([String? value]) =>
      _$Gtimestamptz((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gtimestamptz> get serializer =>
      _i2.DefaultScalarSerializer<Gtimestamptz>(
          (Object serialized) => Gtimestamptz((serialized as String?)));
}

abstract class Gtimestamptz_comparison_exp
    implements
        Built<Gtimestamptz_comparison_exp, Gtimestamptz_comparison_expBuilder> {
  Gtimestamptz_comparison_exp._();

  factory Gtimestamptz_comparison_exp(
          [Function(Gtimestamptz_comparison_expBuilder b) updates]) =
      _$Gtimestamptz_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  Gtimestamptz? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gtimestamptz? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gtimestamptz? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gtimestamptz>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  Gtimestamptz? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gtimestamptz? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gtimestamptz? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gtimestamptz>? get G_nin;
  static Serializer<Gtimestamptz_comparison_exp> get serializer =>
      _$gtimestamptzComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtimestamptz_comparison_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtimestamptz_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtimestamptz_comparison_exp.serializer,
        json,
      );
}

abstract class Gtransaction_aggregate_bool_exp
    implements
        Built<Gtransaction_aggregate_bool_exp,
            Gtransaction_aggregate_bool_expBuilder> {
  Gtransaction_aggregate_bool_exp._();

  factory Gtransaction_aggregate_bool_exp(
          [Function(Gtransaction_aggregate_bool_expBuilder b) updates]) =
      _$Gtransaction_aggregate_bool_exp;

  Gtransaction_aggregate_bool_exp_count? get count;
  static Serializer<Gtransaction_aggregate_bool_exp> get serializer =>
      _$gtransactionAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_aggregate_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_aggregate_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_aggregate_bool_exp.serializer,
        json,
      );
}

abstract class Gtransaction_aggregate_bool_exp_count
    implements
        Built<Gtransaction_aggregate_bool_exp_count,
            Gtransaction_aggregate_bool_exp_countBuilder> {
  Gtransaction_aggregate_bool_exp_count._();

  factory Gtransaction_aggregate_bool_exp_count(
          [Function(Gtransaction_aggregate_bool_exp_countBuilder b) updates]) =
      _$Gtransaction_aggregate_bool_exp_count;

  BuiltList<Gtransaction_select_column>? get arguments;
  bool? get distinct;
  Gtransaction_bool_exp? get filter;
  GInt_comparison_exp get predicate;
  static Serializer<Gtransaction_aggregate_bool_exp_count> get serializer =>
      _$gtransactionAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_aggregate_bool_exp_count.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_aggregate_bool_exp_count? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_aggregate_bool_exp_count.serializer,
        json,
      );
}

abstract class Gtransaction_aggregate_order_by
    implements
        Built<Gtransaction_aggregate_order_by,
            Gtransaction_aggregate_order_byBuilder> {
  Gtransaction_aggregate_order_by._();

  factory Gtransaction_aggregate_order_by(
          [Function(Gtransaction_aggregate_order_byBuilder b) updates]) =
      _$Gtransaction_aggregate_order_by;

  Gtransaction_avg_order_by? get avg;
  Gorder_by? get count;
  Gtransaction_max_order_by? get max;
  Gtransaction_min_order_by? get min;
  Gtransaction_stddev_order_by? get stddev;
  Gtransaction_stddev_pop_order_by? get stddev_pop;
  Gtransaction_stddev_samp_order_by? get stddev_samp;
  Gtransaction_sum_order_by? get sum;
  Gtransaction_var_pop_order_by? get var_pop;
  Gtransaction_var_samp_order_by? get var_samp;
  Gtransaction_variance_order_by? get variance;
  static Serializer<Gtransaction_aggregate_order_by> get serializer =>
      _$gtransactionAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_aggregate_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_aggregate_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_avg_order_by
    implements
        Built<Gtransaction_avg_order_by, Gtransaction_avg_order_byBuilder> {
  Gtransaction_avg_order_by._();

  factory Gtransaction_avg_order_by(
          [Function(Gtransaction_avg_order_byBuilder b) updates]) =
      _$Gtransaction_avg_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_avg_order_by> get serializer =>
      _$gtransactionAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_avg_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_avg_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_avg_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_bool_exp
    implements Built<Gtransaction_bool_exp, Gtransaction_bool_expBuilder> {
  Gtransaction_bool_exp._();

  factory Gtransaction_bool_exp(
          [Function(Gtransaction_bool_expBuilder b) updates]) =
      _$Gtransaction_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gtransaction_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gtransaction_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gtransaction_bool_exp>? get G_or;
  GFloat_comparison_exp? get amount;
  GString_comparison_exp? get comment;
  Gtimestamptz_comparison_exp? get created_at;
  GInt_comparison_exp? get created_on;
  Gblock_bool_exp? get created_on_block;
  GInt_comparison_exp? get id;
  Gaccount_bool_exp? get issuer;
  GString_comparison_exp? get issuer_pubkey;
  Gaccount_bool_exp? get receiver;
  GString_comparison_exp? get receiver_pubkey;
  static Serializer<Gtransaction_bool_exp> get serializer =>
      _$gtransactionBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_bool_exp.serializer,
        json,
      );
}

abstract class Gtransaction_max_order_by
    implements
        Built<Gtransaction_max_order_by, Gtransaction_max_order_byBuilder> {
  Gtransaction_max_order_by._();

  factory Gtransaction_max_order_by(
          [Function(Gtransaction_max_order_byBuilder b) updates]) =
      _$Gtransaction_max_order_by;

  Gorder_by? get amount;
  Gorder_by? get comment;
  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get id;
  Gorder_by? get issuer_pubkey;
  Gorder_by? get receiver_pubkey;
  static Serializer<Gtransaction_max_order_by> get serializer =>
      _$gtransactionMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_max_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_max_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_min_order_by
    implements
        Built<Gtransaction_min_order_by, Gtransaction_min_order_byBuilder> {
  Gtransaction_min_order_by._();

  factory Gtransaction_min_order_by(
          [Function(Gtransaction_min_order_byBuilder b) updates]) =
      _$Gtransaction_min_order_by;

  Gorder_by? get amount;
  Gorder_by? get comment;
  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gorder_by? get id;
  Gorder_by? get issuer_pubkey;
  Gorder_by? get receiver_pubkey;
  static Serializer<Gtransaction_min_order_by> get serializer =>
      _$gtransactionMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_min_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_min_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_order_by
    implements Built<Gtransaction_order_by, Gtransaction_order_byBuilder> {
  Gtransaction_order_by._();

  factory Gtransaction_order_by(
          [Function(Gtransaction_order_byBuilder b) updates]) =
      _$Gtransaction_order_by;

  Gorder_by? get amount;
  Gorder_by? get comment;
  Gorder_by? get created_at;
  Gorder_by? get created_on;
  Gblock_order_by? get created_on_block;
  Gorder_by? get id;
  Gaccount_order_by? get issuer;
  Gorder_by? get issuer_pubkey;
  Gaccount_order_by? get receiver;
  Gorder_by? get receiver_pubkey;
  static Serializer<Gtransaction_order_by> get serializer =>
      _$gtransactionOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_order_by.serializer,
        json,
      );
}

class Gtransaction_select_column extends EnumClass {
  const Gtransaction_select_column._(String name) : super(name);

  static const Gtransaction_select_column amount =
      _$gtransactionSelectColumnamount;

  static const Gtransaction_select_column comment =
      _$gtransactionSelectColumncomment;

  static const Gtransaction_select_column created_at =
      _$gtransactionSelectColumncreated_at;

  static const Gtransaction_select_column created_on =
      _$gtransactionSelectColumncreated_on;

  static const Gtransaction_select_column id = _$gtransactionSelectColumnid;

  static const Gtransaction_select_column issuer_pubkey =
      _$gtransactionSelectColumnissuer_pubkey;

  static const Gtransaction_select_column receiver_pubkey =
      _$gtransactionSelectColumnreceiver_pubkey;

  static Serializer<Gtransaction_select_column> get serializer =>
      _$gtransactionSelectColumnSerializer;

  static BuiltSet<Gtransaction_select_column> get values =>
      _$gtransactionSelectColumnValues;

  static Gtransaction_select_column valueOf(String name) =>
      _$gtransactionSelectColumnValueOf(name);
}

abstract class Gtransaction_stddev_order_by
    implements
        Built<Gtransaction_stddev_order_by,
            Gtransaction_stddev_order_byBuilder> {
  Gtransaction_stddev_order_by._();

  factory Gtransaction_stddev_order_by(
          [Function(Gtransaction_stddev_order_byBuilder b) updates]) =
      _$Gtransaction_stddev_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_stddev_order_by> get serializer =>
      _$gtransactionStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_stddev_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_stddev_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_stddev_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_stddev_pop_order_by
    implements
        Built<Gtransaction_stddev_pop_order_by,
            Gtransaction_stddev_pop_order_byBuilder> {
  Gtransaction_stddev_pop_order_by._();

  factory Gtransaction_stddev_pop_order_by(
          [Function(Gtransaction_stddev_pop_order_byBuilder b) updates]) =
      _$Gtransaction_stddev_pop_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_stddev_pop_order_by> get serializer =>
      _$gtransactionStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_stddev_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_stddev_pop_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_stddev_pop_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_stddev_samp_order_by
    implements
        Built<Gtransaction_stddev_samp_order_by,
            Gtransaction_stddev_samp_order_byBuilder> {
  Gtransaction_stddev_samp_order_by._();

  factory Gtransaction_stddev_samp_order_by(
          [Function(Gtransaction_stddev_samp_order_byBuilder b) updates]) =
      _$Gtransaction_stddev_samp_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_stddev_samp_order_by> get serializer =>
      _$gtransactionStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_stddev_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_stddev_samp_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_stddev_samp_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_stream_cursor_input
    implements
        Built<Gtransaction_stream_cursor_input,
            Gtransaction_stream_cursor_inputBuilder> {
  Gtransaction_stream_cursor_input._();

  factory Gtransaction_stream_cursor_input(
          [Function(Gtransaction_stream_cursor_inputBuilder b) updates]) =
      _$Gtransaction_stream_cursor_input;

  Gtransaction_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gtransaction_stream_cursor_input> get serializer =>
      _$gtransactionStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_stream_cursor_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gtransaction_stream_cursor_value_input
    implements
        Built<Gtransaction_stream_cursor_value_input,
            Gtransaction_stream_cursor_value_inputBuilder> {
  Gtransaction_stream_cursor_value_input._();

  factory Gtransaction_stream_cursor_value_input(
          [Function(Gtransaction_stream_cursor_value_inputBuilder b) updates]) =
      _$Gtransaction_stream_cursor_value_input;

  double? get amount;
  String? get comment;
  Gtimestamptz? get created_at;
  int? get created_on;
  int? get id;
  String? get issuer_pubkey;
  String? get receiver_pubkey;
  static Serializer<Gtransaction_stream_cursor_value_input> get serializer =>
      _$gtransactionStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gtransaction_sum_order_by
    implements
        Built<Gtransaction_sum_order_by, Gtransaction_sum_order_byBuilder> {
  Gtransaction_sum_order_by._();

  factory Gtransaction_sum_order_by(
          [Function(Gtransaction_sum_order_byBuilder b) updates]) =
      _$Gtransaction_sum_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_sum_order_by> get serializer =>
      _$gtransactionSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_sum_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_sum_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_sum_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_timeserie_args
    implements
        Built<Gtransaction_timeserie_args, Gtransaction_timeserie_argsBuilder> {
  Gtransaction_timeserie_args._();

  factory Gtransaction_timeserie_args(
          [Function(Gtransaction_timeserie_argsBuilder b) updates]) =
      _$Gtransaction_timeserie_args;

  Gdate? get from;
  String? get issuer_pk;
  Gtime_period? get period;
  String? get receiver_pk;
  Gdate? get to;
  static Serializer<Gtransaction_timeserie_args> get serializer =>
      _$gtransactionTimeserieArgsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_timeserie_args.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_timeserie_args? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_timeserie_args.serializer,
        json,
      );
}

abstract class Gtransaction_timeserie_tmp_bool_exp
    implements
        Built<Gtransaction_timeserie_tmp_bool_exp,
            Gtransaction_timeserie_tmp_bool_expBuilder> {
  Gtransaction_timeserie_tmp_bool_exp._();

  factory Gtransaction_timeserie_tmp_bool_exp(
          [Function(Gtransaction_timeserie_tmp_bool_expBuilder b) updates]) =
      _$Gtransaction_timeserie_tmp_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gtransaction_timeserie_tmp_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gtransaction_timeserie_tmp_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gtransaction_timeserie_tmp_bool_exp>? get G_or;
  GFloat_comparison_exp? get amount;
  Gtimestamptz_comparison_exp? get date;
  static Serializer<Gtransaction_timeserie_tmp_bool_exp> get serializer =>
      _$gtransactionTimeserieTmpBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_timeserie_tmp_bool_exp.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_timeserie_tmp_bool_exp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_timeserie_tmp_bool_exp.serializer,
        json,
      );
}

abstract class Gtransaction_timeserie_tmp_order_by
    implements
        Built<Gtransaction_timeserie_tmp_order_by,
            Gtransaction_timeserie_tmp_order_byBuilder> {
  Gtransaction_timeserie_tmp_order_by._();

  factory Gtransaction_timeserie_tmp_order_by(
          [Function(Gtransaction_timeserie_tmp_order_byBuilder b) updates]) =
      _$Gtransaction_timeserie_tmp_order_by;

  Gorder_by? get amount;
  Gorder_by? get date;
  static Serializer<Gtransaction_timeserie_tmp_order_by> get serializer =>
      _$gtransactionTimeserieTmpOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_timeserie_tmp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_timeserie_tmp_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_timeserie_tmp_order_by.serializer,
        json,
      );
}

class Gtransaction_timeserie_tmp_select_column extends EnumClass {
  const Gtransaction_timeserie_tmp_select_column._(String name) : super(name);

  static const Gtransaction_timeserie_tmp_select_column amount =
      _$gtransactionTimeserieTmpSelectColumnamount;

  static const Gtransaction_timeserie_tmp_select_column date =
      _$gtransactionTimeserieTmpSelectColumndate;

  static Serializer<Gtransaction_timeserie_tmp_select_column> get serializer =>
      _$gtransactionTimeserieTmpSelectColumnSerializer;

  static BuiltSet<Gtransaction_timeserie_tmp_select_column> get values =>
      _$gtransactionTimeserieTmpSelectColumnValues;

  static Gtransaction_timeserie_tmp_select_column valueOf(String name) =>
      _$gtransactionTimeserieTmpSelectColumnValueOf(name);
}

abstract class Gtransaction_timeserie_tmp_stream_cursor_input
    implements
        Built<Gtransaction_timeserie_tmp_stream_cursor_input,
            Gtransaction_timeserie_tmp_stream_cursor_inputBuilder> {
  Gtransaction_timeserie_tmp_stream_cursor_input._();

  factory Gtransaction_timeserie_tmp_stream_cursor_input(
      [Function(Gtransaction_timeserie_tmp_stream_cursor_inputBuilder b)
          updates]) = _$Gtransaction_timeserie_tmp_stream_cursor_input;

  Gtransaction_timeserie_tmp_stream_cursor_value_input get initial_value;
  Gcursor_ordering? get ordering;
  static Serializer<Gtransaction_timeserie_tmp_stream_cursor_input>
      get serializer => _$gtransactionTimeserieTmpStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_timeserie_tmp_stream_cursor_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_timeserie_tmp_stream_cursor_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_timeserie_tmp_stream_cursor_input.serializer,
        json,
      );
}

abstract class Gtransaction_timeserie_tmp_stream_cursor_value_input
    implements
        Built<Gtransaction_timeserie_tmp_stream_cursor_value_input,
            Gtransaction_timeserie_tmp_stream_cursor_value_inputBuilder> {
  Gtransaction_timeserie_tmp_stream_cursor_value_input._();

  factory Gtransaction_timeserie_tmp_stream_cursor_value_input(
      [Function(Gtransaction_timeserie_tmp_stream_cursor_value_inputBuilder b)
          updates]) = _$Gtransaction_timeserie_tmp_stream_cursor_value_input;

  double? get amount;
  Gtimestamptz? get date;
  static Serializer<Gtransaction_timeserie_tmp_stream_cursor_value_input>
      get serializer =>
          _$gtransactionTimeserieTmpStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_timeserie_tmp_stream_cursor_value_input.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_timeserie_tmp_stream_cursor_value_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_timeserie_tmp_stream_cursor_value_input.serializer,
        json,
      );
}

abstract class Gtransaction_var_pop_order_by
    implements
        Built<Gtransaction_var_pop_order_by,
            Gtransaction_var_pop_order_byBuilder> {
  Gtransaction_var_pop_order_by._();

  factory Gtransaction_var_pop_order_by(
          [Function(Gtransaction_var_pop_order_byBuilder b) updates]) =
      _$Gtransaction_var_pop_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_var_pop_order_by> get serializer =>
      _$gtransactionVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_var_pop_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_var_pop_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_var_pop_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_var_samp_order_by
    implements
        Built<Gtransaction_var_samp_order_by,
            Gtransaction_var_samp_order_byBuilder> {
  Gtransaction_var_samp_order_by._();

  factory Gtransaction_var_samp_order_by(
          [Function(Gtransaction_var_samp_order_byBuilder b) updates]) =
      _$Gtransaction_var_samp_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_var_samp_order_by> get serializer =>
      _$gtransactionVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_var_samp_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_var_samp_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_var_samp_order_by.serializer,
        json,
      );
}

abstract class Gtransaction_variance_order_by
    implements
        Built<Gtransaction_variance_order_by,
            Gtransaction_variance_order_byBuilder> {
  Gtransaction_variance_order_by._();

  factory Gtransaction_variance_order_by(
          [Function(Gtransaction_variance_order_byBuilder b) updates]) =
      _$Gtransaction_variance_order_by;

  Gorder_by? get amount;
  Gorder_by? get created_on;
  Gorder_by? get id;
  static Serializer<Gtransaction_variance_order_by> get serializer =>
      _$gtransactionVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        Gtransaction_variance_order_by.serializer,
        this,
      ) as Map<String, dynamic>);

  static Gtransaction_variance_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        Gtransaction_variance_order_by.serializer,
        json,
      );
}

const possibleTypesMap = {};
