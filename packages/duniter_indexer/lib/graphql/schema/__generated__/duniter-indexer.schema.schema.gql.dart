// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart' as _i3;
import 'package:built_value/serializer.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;

part 'duniter-indexer.schema.schema.gql.g.dart';

abstract class GAccountAggregateBoolExp
    implements
        Built<GAccountAggregateBoolExp, GAccountAggregateBoolExpBuilder> {
  GAccountAggregateBoolExp._();

  factory GAccountAggregateBoolExp(
          [void Function(GAccountAggregateBoolExpBuilder b) updates]) =
      _$GAccountAggregateBoolExp;

  GaccountAggregateBoolExpBool_and? get bool_and;
  GaccountAggregateBoolExpBool_or? get bool_or;
  GaccountAggregateBoolExpCount? get count;
  static Serializer<GAccountAggregateBoolExp> get serializer =>
      _$gAccountAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountAggregateBoolExp.serializer,
        json,
      );
}

abstract class GaccountAggregateBoolExpBool_and
    implements
        Built<GaccountAggregateBoolExpBool_and,
            GaccountAggregateBoolExpBool_andBuilder> {
  GaccountAggregateBoolExpBool_and._();

  factory GaccountAggregateBoolExpBool_and(
          [void Function(GaccountAggregateBoolExpBool_andBuilder b) updates]) =
      _$GaccountAggregateBoolExpBool_and;

  GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns
      get arguments;
  bool? get distinct;
  GAccountBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GaccountAggregateBoolExpBool_and> get serializer =>
      _$gaccountAggregateBoolExpBoolAndSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GaccountAggregateBoolExpBool_and.serializer,
        this,
      ) as Map<String, dynamic>);

  static GaccountAggregateBoolExpBool_and? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GaccountAggregateBoolExpBool_and.serializer,
        json,
      );
}

abstract class GaccountAggregateBoolExpBool_or
    implements
        Built<GaccountAggregateBoolExpBool_or,
            GaccountAggregateBoolExpBool_orBuilder> {
  GaccountAggregateBoolExpBool_or._();

  factory GaccountAggregateBoolExpBool_or(
          [void Function(GaccountAggregateBoolExpBool_orBuilder b) updates]) =
      _$GaccountAggregateBoolExpBool_or;

  GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns
      get arguments;
  bool? get distinct;
  GAccountBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GaccountAggregateBoolExpBool_or> get serializer =>
      _$gaccountAggregateBoolExpBoolOrSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GaccountAggregateBoolExpBool_or.serializer,
        this,
      ) as Map<String, dynamic>);

  static GaccountAggregateBoolExpBool_or? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GaccountAggregateBoolExpBool_or.serializer,
        json,
      );
}

abstract class GaccountAggregateBoolExpCount
    implements
        Built<GaccountAggregateBoolExpCount,
            GaccountAggregateBoolExpCountBuilder> {
  GaccountAggregateBoolExpCount._();

  factory GaccountAggregateBoolExpCount(
          [void Function(GaccountAggregateBoolExpCountBuilder b) updates]) =
      _$GaccountAggregateBoolExpCount;

  BuiltList<GAccountSelectColumn>? get arguments;
  bool? get distinct;
  GAccountBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GaccountAggregateBoolExpCount> get serializer =>
      _$gaccountAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GaccountAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GaccountAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GaccountAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GAccountAggregateOrderBy
    implements
        Built<GAccountAggregateOrderBy, GAccountAggregateOrderByBuilder> {
  GAccountAggregateOrderBy._();

  factory GAccountAggregateOrderBy(
          [void Function(GAccountAggregateOrderByBuilder b) updates]) =
      _$GAccountAggregateOrderBy;

  GAccountAvgOrderBy? get avg;
  GOrderBy? get count;
  GAccountMaxOrderBy? get max;
  GAccountMinOrderBy? get min;
  GAccountStddevOrderBy? get stddev;
  GAccountStddevPopOrderBy? get stddevPop;
  GAccountStddevSampOrderBy? get stddevSamp;
  GAccountSumOrderBy? get sum;
  GAccountVarPopOrderBy? get varPop;
  GAccountVarSampOrderBy? get varSamp;
  GAccountVarianceOrderBy? get variance;
  static Serializer<GAccountAggregateOrderBy> get serializer =>
      _$gAccountAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountAggregateOrderBy.serializer,
        json,
      );
}

abstract class GAccountAvgOrderBy
    implements Built<GAccountAvgOrderBy, GAccountAvgOrderByBuilder> {
  GAccountAvgOrderBy._();

  factory GAccountAvgOrderBy(
          [void Function(GAccountAvgOrderByBuilder b) updates]) =
      _$GAccountAvgOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountAvgOrderBy> get serializer =>
      _$gAccountAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountAvgOrderBy.serializer,
        json,
      );
}

abstract class GAccountBoolExp
    implements Built<GAccountBoolExp, GAccountBoolExpBuilder> {
  GAccountBoolExp._();

  factory GAccountBoolExp([void Function(GAccountBoolExpBuilder b) updates]) =
      _$GAccountBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GAccountBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GAccountBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GAccountBoolExp>? get G_or;
  GNumericComparisonExp? get balance;
  GTxCommentBoolExp? get commentsIssued;
  GTxCommentAggregateBoolExp? get commentsIssuedAggregate;
  GIntComparisonExp? get createdOn;
  GStringComparisonExp? get id;
  GIdentityBoolExp? get identity;
  GBooleanComparisonExp? get isActive;
  GIdentityBoolExp? get linkedIdentity;
  GStringComparisonExp? get linkedIdentityId;
  GIdentityBoolExp? get removedIdentities;
  GIdentityAggregateBoolExp? get removedIdentitiesAggregate;
  GTransferBoolExp? get transfersIssued;
  GTransferAggregateBoolExp? get transfersIssuedAggregate;
  GTransferBoolExp? get transfersReceived;
  GTransferAggregateBoolExp? get transfersReceivedAggregate;
  GChangeOwnerKeyBoolExp? get wasIdentity;
  GChangeOwnerKeyAggregateBoolExp? get wasIdentityAggregate;
  static Serializer<GAccountBoolExp> get serializer =>
      _$gAccountBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBoolExp.serializer,
        json,
      );
}

abstract class GAccountMaxOrderBy
    implements Built<GAccountMaxOrderBy, GAccountMaxOrderByBuilder> {
  GAccountMaxOrderBy._();

  factory GAccountMaxOrderBy(
          [void Function(GAccountMaxOrderByBuilder b) updates]) =
      _$GAccountMaxOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  GOrderBy? get id;
  GOrderBy? get linkedIdentityId;
  static Serializer<GAccountMaxOrderBy> get serializer =>
      _$gAccountMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountMaxOrderBy.serializer,
        json,
      );
}

abstract class GAccountMinOrderBy
    implements Built<GAccountMinOrderBy, GAccountMinOrderByBuilder> {
  GAccountMinOrderBy._();

  factory GAccountMinOrderBy(
          [void Function(GAccountMinOrderByBuilder b) updates]) =
      _$GAccountMinOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  GOrderBy? get id;
  GOrderBy? get linkedIdentityId;
  static Serializer<GAccountMinOrderBy> get serializer =>
      _$gAccountMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountMinOrderBy.serializer,
        json,
      );
}

abstract class GAccountOrderBy
    implements Built<GAccountOrderBy, GAccountOrderByBuilder> {
  GAccountOrderBy._();

  factory GAccountOrderBy([void Function(GAccountOrderByBuilder b) updates]) =
      _$GAccountOrderBy;

  GOrderBy? get balance;
  GTxCommentAggregateOrderBy? get commentsIssuedAggregate;
  GOrderBy? get createdOn;
  GOrderBy? get id;
  GIdentityOrderBy? get identity;
  GOrderBy? get isActive;
  GIdentityOrderBy? get linkedIdentity;
  GOrderBy? get linkedIdentityId;
  GIdentityAggregateOrderBy? get removedIdentitiesAggregate;
  GTransferAggregateOrderBy? get transfersIssuedAggregate;
  GTransferAggregateOrderBy? get transfersReceivedAggregate;
  GChangeOwnerKeyAggregateOrderBy? get wasIdentityAggregate;
  static Serializer<GAccountOrderBy> get serializer =>
      _$gAccountOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountOrderBy.serializer,
        json,
      );
}

class GAccountSelectColumn extends EnumClass {
  const GAccountSelectColumn._(String name) : super(name);

  static const GAccountSelectColumn balance = _$gAccountSelectColumnbalance;

  static const GAccountSelectColumn createdOn = _$gAccountSelectColumncreatedOn;

  static const GAccountSelectColumn id = _$gAccountSelectColumnid;

  static const GAccountSelectColumn isActive = _$gAccountSelectColumnisActive;

  static const GAccountSelectColumn linkedIdentityId =
      _$gAccountSelectColumnlinkedIdentityId;

  static Serializer<GAccountSelectColumn> get serializer =>
      _$gAccountSelectColumnSerializer;

  static BuiltSet<GAccountSelectColumn> get values =>
      _$gAccountSelectColumnValues;

  static GAccountSelectColumn valueOf(String name) =>
      _$gAccountSelectColumnValueOf(name);
}

class GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns
    extends EnumClass {
  const GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns._(
      String name)
      : super(name);

  static const GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns
      isActive =
      _$gAccountSelectColumnAccountAggregateBoolExpBoolAndArgumentsColumnsisActive;

  static Serializer<
          GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns>
      get serializer =>
          _$gAccountSelectColumnAccountAggregateBoolExpBoolAndArgumentsColumnsSerializer;

  static BuiltSet<
          GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns>
      get values =>
          _$gAccountSelectColumnAccountAggregateBoolExpBoolAndArgumentsColumnsValues;

  static GAccountSelectColumnAccountAggregateBoolExpBool_andArgumentsColumns
      valueOf(String name) =>
          _$gAccountSelectColumnAccountAggregateBoolExpBoolAndArgumentsColumnsValueOf(
              name);
}

class GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns
    extends EnumClass {
  const GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns._(
      String name)
      : super(name);

  static const GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns
      isActive =
      _$gAccountSelectColumnAccountAggregateBoolExpBoolOrArgumentsColumnsisActive;

  static Serializer<
          GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns>
      get serializer =>
          _$gAccountSelectColumnAccountAggregateBoolExpBoolOrArgumentsColumnsSerializer;

  static BuiltSet<
          GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns>
      get values =>
          _$gAccountSelectColumnAccountAggregateBoolExpBoolOrArgumentsColumnsValues;

  static GAccountSelectColumnAccountAggregateBoolExpBool_orArgumentsColumns valueOf(
          String name) =>
      _$gAccountSelectColumnAccountAggregateBoolExpBoolOrArgumentsColumnsValueOf(
          name);
}

abstract class GAccountStddevOrderBy
    implements Built<GAccountStddevOrderBy, GAccountStddevOrderByBuilder> {
  GAccountStddevOrderBy._();

  factory GAccountStddevOrderBy(
          [void Function(GAccountStddevOrderByBuilder b) updates]) =
      _$GAccountStddevOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountStddevOrderBy> get serializer =>
      _$gAccountStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountStddevOrderBy.serializer,
        json,
      );
}

abstract class GAccountStddevPopOrderBy
    implements
        Built<GAccountStddevPopOrderBy, GAccountStddevPopOrderByBuilder> {
  GAccountStddevPopOrderBy._();

  factory GAccountStddevPopOrderBy(
          [void Function(GAccountStddevPopOrderByBuilder b) updates]) =
      _$GAccountStddevPopOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountStddevPopOrderBy> get serializer =>
      _$gAccountStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GAccountStddevSampOrderBy
    implements
        Built<GAccountStddevSampOrderBy, GAccountStddevSampOrderByBuilder> {
  GAccountStddevSampOrderBy._();

  factory GAccountStddevSampOrderBy(
          [void Function(GAccountStddevSampOrderByBuilder b) updates]) =
      _$GAccountStddevSampOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountStddevSampOrderBy> get serializer =>
      _$gAccountStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GAccountStreamCursorInput
    implements
        Built<GAccountStreamCursorInput, GAccountStreamCursorInputBuilder> {
  GAccountStreamCursorInput._();

  factory GAccountStreamCursorInput(
          [void Function(GAccountStreamCursorInputBuilder b) updates]) =
      _$GAccountStreamCursorInput;

  GAccountStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GAccountStreamCursorInput> get serializer =>
      _$gAccountStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountStreamCursorInput.serializer,
        json,
      );
}

abstract class GAccountStreamCursorValueInput
    implements
        Built<GAccountStreamCursorValueInput,
            GAccountStreamCursorValueInputBuilder> {
  GAccountStreamCursorValueInput._();

  factory GAccountStreamCursorValueInput(
          [void Function(GAccountStreamCursorValueInputBuilder b) updates]) =
      _$GAccountStreamCursorValueInput;

  int? get balance;
  int? get createdOn;
  String? get id;
  bool? get isActive;
  String? get linkedIdentityId;
  static Serializer<GAccountStreamCursorValueInput> get serializer =>
      _$gAccountStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GAccountSumOrderBy
    implements Built<GAccountSumOrderBy, GAccountSumOrderByBuilder> {
  GAccountSumOrderBy._();

  factory GAccountSumOrderBy(
          [void Function(GAccountSumOrderByBuilder b) updates]) =
      _$GAccountSumOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountSumOrderBy> get serializer =>
      _$gAccountSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountSumOrderBy.serializer,
        json,
      );
}

abstract class GAccountVarianceOrderBy
    implements Built<GAccountVarianceOrderBy, GAccountVarianceOrderByBuilder> {
  GAccountVarianceOrderBy._();

  factory GAccountVarianceOrderBy(
          [void Function(GAccountVarianceOrderByBuilder b) updates]) =
      _$GAccountVarianceOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountVarianceOrderBy> get serializer =>
      _$gAccountVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountVarianceOrderBy.serializer,
        json,
      );
}

abstract class GAccountVarPopOrderBy
    implements Built<GAccountVarPopOrderBy, GAccountVarPopOrderByBuilder> {
  GAccountVarPopOrderBy._();

  factory GAccountVarPopOrderBy(
          [void Function(GAccountVarPopOrderByBuilder b) updates]) =
      _$GAccountVarPopOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountVarPopOrderBy> get serializer =>
      _$gAccountVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountVarPopOrderBy.serializer,
        json,
      );
}

abstract class GAccountVarSampOrderBy
    implements Built<GAccountVarSampOrderBy, GAccountVarSampOrderByBuilder> {
  GAccountVarSampOrderBy._();

  factory GAccountVarSampOrderBy(
          [void Function(GAccountVarSampOrderByBuilder b) updates]) =
      _$GAccountVarSampOrderBy;

  GOrderBy? get balance;
  GOrderBy? get createdOn;
  static Serializer<GAccountVarSampOrderBy> get serializer =>
      _$gAccountVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountVarSampOrderBy.serializer,
        json,
      );
}

abstract class GBlockBoolExp
    implements Built<GBlockBoolExp, GBlockBoolExpBuilder> {
  GBlockBoolExp._();

  factory GBlockBoolExp([void Function(GBlockBoolExpBuilder b) updates]) =
      _$GBlockBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GBlockBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GBlockBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GBlockBoolExp>? get G_or;
  GCallBoolExp? get calls;
  GCallAggregateBoolExp? get callsAggregate;
  GIntComparisonExp? get callsCount;
  GEventBoolExp? get events;
  GEventAggregateBoolExp? get eventsAggregate;
  GIntComparisonExp? get eventsCount;
  GExtrinsicBoolExp? get extrinsics;
  GExtrinsicAggregateBoolExp? get extrinsicsAggregate;
  GIntComparisonExp? get extrinsicsCount;
  GByteaComparisonExp? get extrinsicsicRoot;
  GByteaComparisonExp? get hash;
  GIntComparisonExp? get height;
  GStringComparisonExp? get id;
  GStringComparisonExp? get implName;
  GIntComparisonExp? get implVersion;
  GByteaComparisonExp? get parentHash;
  GStringComparisonExp? get specName;
  GIntComparisonExp? get specVersion;
  GByteaComparisonExp? get stateRoot;
  GTimestamptzComparisonExp? get timestamp;
  GByteaComparisonExp? get validator;
  static Serializer<GBlockBoolExp> get serializer => _$gBlockBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockBoolExp.serializer,
        json,
      );
}

abstract class GBlockOrderBy
    implements Built<GBlockOrderBy, GBlockOrderByBuilder> {
  GBlockOrderBy._();

  factory GBlockOrderBy([void Function(GBlockOrderByBuilder b) updates]) =
      _$GBlockOrderBy;

  GCallAggregateOrderBy? get callsAggregate;
  GOrderBy? get callsCount;
  GEventAggregateOrderBy? get eventsAggregate;
  GOrderBy? get eventsCount;
  GExtrinsicAggregateOrderBy? get extrinsicsAggregate;
  GOrderBy? get extrinsicsCount;
  GOrderBy? get extrinsicsicRoot;
  GOrderBy? get hash;
  GOrderBy? get height;
  GOrderBy? get id;
  GOrderBy? get implName;
  GOrderBy? get implVersion;
  GOrderBy? get parentHash;
  GOrderBy? get specName;
  GOrderBy? get specVersion;
  GOrderBy? get stateRoot;
  GOrderBy? get timestamp;
  GOrderBy? get validator;
  static Serializer<GBlockOrderBy> get serializer => _$gBlockOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockOrderBy.serializer,
        json,
      );
}

class GBlockSelectColumn extends EnumClass {
  const GBlockSelectColumn._(String name) : super(name);

  static const GBlockSelectColumn callsCount = _$gBlockSelectColumncallsCount;

  static const GBlockSelectColumn eventsCount = _$gBlockSelectColumneventsCount;

  static const GBlockSelectColumn extrinsicsCount =
      _$gBlockSelectColumnextrinsicsCount;

  static const GBlockSelectColumn extrinsicsicRoot =
      _$gBlockSelectColumnextrinsicsicRoot;

  static const GBlockSelectColumn hash = _$gBlockSelectColumnhash;

  static const GBlockSelectColumn height = _$gBlockSelectColumnheight;

  static const GBlockSelectColumn id = _$gBlockSelectColumnid;

  static const GBlockSelectColumn implName = _$gBlockSelectColumnimplName;

  static const GBlockSelectColumn implVersion = _$gBlockSelectColumnimplVersion;

  static const GBlockSelectColumn parentHash = _$gBlockSelectColumnparentHash;

  static const GBlockSelectColumn specName = _$gBlockSelectColumnspecName;

  static const GBlockSelectColumn specVersion = _$gBlockSelectColumnspecVersion;

  static const GBlockSelectColumn stateRoot = _$gBlockSelectColumnstateRoot;

  static const GBlockSelectColumn timestamp = _$gBlockSelectColumntimestamp;

  static const GBlockSelectColumn validator = _$gBlockSelectColumnvalidator;

  static Serializer<GBlockSelectColumn> get serializer =>
      _$gBlockSelectColumnSerializer;

  static BuiltSet<GBlockSelectColumn> get values => _$gBlockSelectColumnValues;

  static GBlockSelectColumn valueOf(String name) =>
      _$gBlockSelectColumnValueOf(name);
}

abstract class GBlockStreamCursorInput
    implements Built<GBlockStreamCursorInput, GBlockStreamCursorInputBuilder> {
  GBlockStreamCursorInput._();

  factory GBlockStreamCursorInput(
          [void Function(GBlockStreamCursorInputBuilder b) updates]) =
      _$GBlockStreamCursorInput;

  GBlockStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GBlockStreamCursorInput> get serializer =>
      _$gBlockStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockStreamCursorInput.serializer,
        json,
      );
}

abstract class GBlockStreamCursorValueInput
    implements
        Built<GBlockStreamCursorValueInput,
            GBlockStreamCursorValueInputBuilder> {
  GBlockStreamCursorValueInput._();

  factory GBlockStreamCursorValueInput(
          [void Function(GBlockStreamCursorValueInputBuilder b) updates]) =
      _$GBlockStreamCursorValueInput;

  int? get callsCount;
  int? get eventsCount;
  int? get extrinsicsCount;
  Gbytea? get extrinsicsicRoot;
  Gbytea? get hash;
  int? get height;
  String? get id;
  String? get implName;
  int? get implVersion;
  Gbytea? get parentHash;
  String? get specName;
  int? get specVersion;
  Gbytea? get stateRoot;
  Gtimestamptz? get timestamp;
  Gbytea? get validator;
  static Serializer<GBlockStreamCursorValueInput> get serializer =>
      _$gBlockStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GBooleanComparisonExp
    implements Built<GBooleanComparisonExp, GBooleanComparisonExpBuilder> {
  GBooleanComparisonExp._();

  factory GBooleanComparisonExp(
          [void Function(GBooleanComparisonExpBuilder b) updates]) =
      _$GBooleanComparisonExp;

  @BuiltValueField(wireName: '_eq')
  bool? get G_eq;
  @BuiltValueField(wireName: '_gt')
  bool? get G_gt;
  @BuiltValueField(wireName: '_gte')
  bool? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<bool>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  bool? get G_lt;
  @BuiltValueField(wireName: '_lte')
  bool? get G_lte;
  @BuiltValueField(wireName: '_neq')
  bool? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<bool>? get G_nin;
  static Serializer<GBooleanComparisonExp> get serializer =>
      _$gBooleanComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBooleanComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBooleanComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBooleanComparisonExp.serializer,
        json,
      );
}

abstract class Gbytea implements Built<Gbytea, GbyteaBuilder> {
  Gbytea._();

  factory Gbytea([String? value]) =>
      _$Gbytea((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<Gbytea> get serializer =>
      _i2.DefaultScalarSerializer<Gbytea>(
          (Object serialized) => Gbytea((serialized as String?)));
}

abstract class GByteaComparisonExp
    implements Built<GByteaComparisonExp, GByteaComparisonExpBuilder> {
  GByteaComparisonExp._();

  factory GByteaComparisonExp(
          [void Function(GByteaComparisonExpBuilder b) updates]) =
      _$GByteaComparisonExp;

  @BuiltValueField(wireName: '_eq')
  Gbytea? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gbytea? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gbytea? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gbytea>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  Gbytea? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gbytea? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gbytea? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gbytea>? get G_nin;
  static Serializer<GByteaComparisonExp> get serializer =>
      _$gByteaComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GByteaComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GByteaComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GByteaComparisonExp.serializer,
        json,
      );
}

abstract class GCallAggregateBoolExp
    implements Built<GCallAggregateBoolExp, GCallAggregateBoolExpBuilder> {
  GCallAggregateBoolExp._();

  factory GCallAggregateBoolExp(
          [void Function(GCallAggregateBoolExpBuilder b) updates]) =
      _$GCallAggregateBoolExp;

  GcallAggregateBoolExpBool_and? get bool_and;
  GcallAggregateBoolExpBool_or? get bool_or;
  GcallAggregateBoolExpCount? get count;
  static Serializer<GCallAggregateBoolExp> get serializer =>
      _$gCallAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallAggregateBoolExp.serializer,
        json,
      );
}

abstract class GcallAggregateBoolExpBool_and
    implements
        Built<GcallAggregateBoolExpBool_and,
            GcallAggregateBoolExpBool_andBuilder> {
  GcallAggregateBoolExpBool_and._();

  factory GcallAggregateBoolExpBool_and(
          [void Function(GcallAggregateBoolExpBool_andBuilder b) updates]) =
      _$GcallAggregateBoolExpBool_and;

  GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns get arguments;
  bool? get distinct;
  GCallBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GcallAggregateBoolExpBool_and> get serializer =>
      _$gcallAggregateBoolExpBoolAndSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcallAggregateBoolExpBool_and.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcallAggregateBoolExpBool_and? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcallAggregateBoolExpBool_and.serializer,
        json,
      );
}

abstract class GcallAggregateBoolExpBool_or
    implements
        Built<GcallAggregateBoolExpBool_or,
            GcallAggregateBoolExpBool_orBuilder> {
  GcallAggregateBoolExpBool_or._();

  factory GcallAggregateBoolExpBool_or(
          [void Function(GcallAggregateBoolExpBool_orBuilder b) updates]) =
      _$GcallAggregateBoolExpBool_or;

  GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns get arguments;
  bool? get distinct;
  GCallBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GcallAggregateBoolExpBool_or> get serializer =>
      _$gcallAggregateBoolExpBoolOrSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcallAggregateBoolExpBool_or.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcallAggregateBoolExpBool_or? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcallAggregateBoolExpBool_or.serializer,
        json,
      );
}

abstract class GcallAggregateBoolExpCount
    implements
        Built<GcallAggregateBoolExpCount, GcallAggregateBoolExpCountBuilder> {
  GcallAggregateBoolExpCount._();

  factory GcallAggregateBoolExpCount(
          [void Function(GcallAggregateBoolExpCountBuilder b) updates]) =
      _$GcallAggregateBoolExpCount;

  BuiltList<GCallSelectColumn>? get arguments;
  bool? get distinct;
  GCallBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GcallAggregateBoolExpCount> get serializer =>
      _$gcallAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcallAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcallAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcallAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GCallAggregateOrderBy
    implements Built<GCallAggregateOrderBy, GCallAggregateOrderByBuilder> {
  GCallAggregateOrderBy._();

  factory GCallAggregateOrderBy(
          [void Function(GCallAggregateOrderByBuilder b) updates]) =
      _$GCallAggregateOrderBy;

  GOrderBy? get count;
  GCallMaxOrderBy? get max;
  GCallMinOrderBy? get min;
  static Serializer<GCallAggregateOrderBy> get serializer =>
      _$gCallAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallAggregateOrderBy.serializer,
        json,
      );
}

abstract class GCallBoolExp
    implements Built<GCallBoolExp, GCallBoolExpBuilder> {
  GCallBoolExp._();

  factory GCallBoolExp([void Function(GCallBoolExpBuilder b) updates]) =
      _$GCallBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GCallBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GCallBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GCallBoolExp>? get G_or;
  GIntArrayComparisonExp? get address;
  GJsonbComparisonExp? get args;
  GStringArrayComparisonExp? get argsStr;
  GBlockBoolExp? get block;
  GStringComparisonExp? get blockId;
  GJsonbComparisonExp? get error;
  GEventBoolExp? get events;
  GEventAggregateBoolExp? get eventsAggregate;
  GExtrinsicBoolExp? get extrinsic;
  GStringComparisonExp? get extrinsicId;
  GStringComparisonExp? get id;
  GStringComparisonExp? get name;
  GStringComparisonExp? get pallet;
  GCallBoolExp? get parent;
  GStringComparisonExp? get parentId;
  GCallBoolExp? get subcalls;
  GCallAggregateBoolExp? get subcallsAggregate;
  GBooleanComparisonExp? get success;
  static Serializer<GCallBoolExp> get serializer => _$gCallBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallBoolExp.serializer,
        json,
      );
}

abstract class GCallMaxOrderBy
    implements Built<GCallMaxOrderBy, GCallMaxOrderByBuilder> {
  GCallMaxOrderBy._();

  factory GCallMaxOrderBy([void Function(GCallMaxOrderByBuilder b) updates]) =
      _$GCallMaxOrderBy;

  GOrderBy? get address;
  GOrderBy? get argsStr;
  GOrderBy? get blockId;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GOrderBy? get parentId;
  static Serializer<GCallMaxOrderBy> get serializer =>
      _$gCallMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallMaxOrderBy.serializer,
        json,
      );
}

abstract class GCallMinOrderBy
    implements Built<GCallMinOrderBy, GCallMinOrderByBuilder> {
  GCallMinOrderBy._();

  factory GCallMinOrderBy([void Function(GCallMinOrderByBuilder b) updates]) =
      _$GCallMinOrderBy;

  GOrderBy? get address;
  GOrderBy? get argsStr;
  GOrderBy? get blockId;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GOrderBy? get parentId;
  static Serializer<GCallMinOrderBy> get serializer =>
      _$gCallMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallMinOrderBy.serializer,
        json,
      );
}

abstract class GCallOrderBy
    implements Built<GCallOrderBy, GCallOrderByBuilder> {
  GCallOrderBy._();

  factory GCallOrderBy([void Function(GCallOrderByBuilder b) updates]) =
      _$GCallOrderBy;

  GOrderBy? get address;
  GOrderBy? get args;
  GOrderBy? get argsStr;
  GBlockOrderBy? get block;
  GOrderBy? get blockId;
  GOrderBy? get error;
  GEventAggregateOrderBy? get eventsAggregate;
  GExtrinsicOrderBy? get extrinsic;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GCallOrderBy? get parent;
  GOrderBy? get parentId;
  GCallAggregateOrderBy? get subcallsAggregate;
  GOrderBy? get success;
  static Serializer<GCallOrderBy> get serializer => _$gCallOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallOrderBy.serializer,
        json,
      );
}

class GCallSelectColumn extends EnumClass {
  const GCallSelectColumn._(String name) : super(name);

  static const GCallSelectColumn address = _$gCallSelectColumnaddress;

  static const GCallSelectColumn args = _$gCallSelectColumnargs;

  static const GCallSelectColumn argsStr = _$gCallSelectColumnargsStr;

  static const GCallSelectColumn blockId = _$gCallSelectColumnblockId;

  static const GCallSelectColumn error = _$gCallSelectColumnerror;

  static const GCallSelectColumn extrinsicId = _$gCallSelectColumnextrinsicId;

  static const GCallSelectColumn id = _$gCallSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const GCallSelectColumn Gname = _$gCallSelectColumnGname;

  static const GCallSelectColumn pallet = _$gCallSelectColumnpallet;

  static const GCallSelectColumn parentId = _$gCallSelectColumnparentId;

  static const GCallSelectColumn success = _$gCallSelectColumnsuccess;

  static Serializer<GCallSelectColumn> get serializer =>
      _$gCallSelectColumnSerializer;

  static BuiltSet<GCallSelectColumn> get values => _$gCallSelectColumnValues;

  static GCallSelectColumn valueOf(String name) =>
      _$gCallSelectColumnValueOf(name);
}

class GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns
    extends EnumClass {
  const GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns._(
      String name)
      : super(name);

  static const GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns
      success =
      _$gCallSelectColumnCallAggregateBoolExpBoolAndArgumentsColumnssuccess;

  static Serializer<
          GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns>
      get serializer =>
          _$gCallSelectColumnCallAggregateBoolExpBoolAndArgumentsColumnsSerializer;

  static BuiltSet<GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns>
      get values =>
          _$gCallSelectColumnCallAggregateBoolExpBoolAndArgumentsColumnsValues;

  static GCallSelectColumnCallAggregateBoolExpBool_andArgumentsColumns valueOf(
          String name) =>
      _$gCallSelectColumnCallAggregateBoolExpBoolAndArgumentsColumnsValueOf(
          name);
}

class GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns
    extends EnumClass {
  const GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns._(
      String name)
      : super(name);

  static const GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns
      success =
      _$gCallSelectColumnCallAggregateBoolExpBoolOrArgumentsColumnssuccess;

  static Serializer<
          GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns>
      get serializer =>
          _$gCallSelectColumnCallAggregateBoolExpBoolOrArgumentsColumnsSerializer;

  static BuiltSet<GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns>
      get values =>
          _$gCallSelectColumnCallAggregateBoolExpBoolOrArgumentsColumnsValues;

  static GCallSelectColumnCallAggregateBoolExpBool_orArgumentsColumns valueOf(
          String name) =>
      _$gCallSelectColumnCallAggregateBoolExpBoolOrArgumentsColumnsValueOf(
          name);
}

abstract class GCallStreamCursorInput
    implements Built<GCallStreamCursorInput, GCallStreamCursorInputBuilder> {
  GCallStreamCursorInput._();

  factory GCallStreamCursorInput(
          [void Function(GCallStreamCursorInputBuilder b) updates]) =
      _$GCallStreamCursorInput;

  GCallStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GCallStreamCursorInput> get serializer =>
      _$gCallStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallStreamCursorInput.serializer,
        json,
      );
}

abstract class GCallStreamCursorValueInput
    implements
        Built<GCallStreamCursorValueInput, GCallStreamCursorValueInputBuilder> {
  GCallStreamCursorValueInput._();

  factory GCallStreamCursorValueInput(
          [void Function(GCallStreamCursorValueInputBuilder b) updates]) =
      _$GCallStreamCursorValueInput;

  BuiltList<int>? get address;
  _i3.JsonObject? get args;
  BuiltList<String>? get argsStr;
  String? get blockId;
  _i3.JsonObject? get error;
  String? get extrinsicId;
  String? get id;
  String? get name;
  String? get pallet;
  String? get parentId;
  bool? get success;
  static Serializer<GCallStreamCursorValueInput> get serializer =>
      _$gCallStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GCertAggregateBoolExp
    implements Built<GCertAggregateBoolExp, GCertAggregateBoolExpBuilder> {
  GCertAggregateBoolExp._();

  factory GCertAggregateBoolExp(
          [void Function(GCertAggregateBoolExpBuilder b) updates]) =
      _$GCertAggregateBoolExp;

  GcertAggregateBoolExpBool_and? get bool_and;
  GcertAggregateBoolExpBool_or? get bool_or;
  GcertAggregateBoolExpCount? get count;
  static Serializer<GCertAggregateBoolExp> get serializer =>
      _$gCertAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertAggregateBoolExp.serializer,
        json,
      );
}

abstract class GcertAggregateBoolExpBool_and
    implements
        Built<GcertAggregateBoolExpBool_and,
            GcertAggregateBoolExpBool_andBuilder> {
  GcertAggregateBoolExpBool_and._();

  factory GcertAggregateBoolExpBool_and(
          [void Function(GcertAggregateBoolExpBool_andBuilder b) updates]) =
      _$GcertAggregateBoolExpBool_and;

  GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns get arguments;
  bool? get distinct;
  GCertBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GcertAggregateBoolExpBool_and> get serializer =>
      _$gcertAggregateBoolExpBoolAndSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcertAggregateBoolExpBool_and.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcertAggregateBoolExpBool_and? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcertAggregateBoolExpBool_and.serializer,
        json,
      );
}

abstract class GcertAggregateBoolExpBool_or
    implements
        Built<GcertAggregateBoolExpBool_or,
            GcertAggregateBoolExpBool_orBuilder> {
  GcertAggregateBoolExpBool_or._();

  factory GcertAggregateBoolExpBool_or(
          [void Function(GcertAggregateBoolExpBool_orBuilder b) updates]) =
      _$GcertAggregateBoolExpBool_or;

  GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns get arguments;
  bool? get distinct;
  GCertBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GcertAggregateBoolExpBool_or> get serializer =>
      _$gcertAggregateBoolExpBoolOrSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcertAggregateBoolExpBool_or.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcertAggregateBoolExpBool_or? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcertAggregateBoolExpBool_or.serializer,
        json,
      );
}

abstract class GcertAggregateBoolExpCount
    implements
        Built<GcertAggregateBoolExpCount, GcertAggregateBoolExpCountBuilder> {
  GcertAggregateBoolExpCount._();

  factory GcertAggregateBoolExpCount(
          [void Function(GcertAggregateBoolExpCountBuilder b) updates]) =
      _$GcertAggregateBoolExpCount;

  BuiltList<GCertSelectColumn>? get arguments;
  bool? get distinct;
  GCertBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GcertAggregateBoolExpCount> get serializer =>
      _$gcertAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcertAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcertAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcertAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GCertAggregateOrderBy
    implements Built<GCertAggregateOrderBy, GCertAggregateOrderByBuilder> {
  GCertAggregateOrderBy._();

  factory GCertAggregateOrderBy(
          [void Function(GCertAggregateOrderByBuilder b) updates]) =
      _$GCertAggregateOrderBy;

  GCertAvgOrderBy? get avg;
  GOrderBy? get count;
  GCertMaxOrderBy? get max;
  GCertMinOrderBy? get min;
  GCertStddevOrderBy? get stddev;
  GCertStddevPopOrderBy? get stddevPop;
  GCertStddevSampOrderBy? get stddevSamp;
  GCertSumOrderBy? get sum;
  GCertVarPopOrderBy? get varPop;
  GCertVarSampOrderBy? get varSamp;
  GCertVarianceOrderBy? get variance;
  static Serializer<GCertAggregateOrderBy> get serializer =>
      _$gCertAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertAggregateOrderBy.serializer,
        json,
      );
}

abstract class GCertAvgOrderBy
    implements Built<GCertAvgOrderBy, GCertAvgOrderByBuilder> {
  GCertAvgOrderBy._();

  factory GCertAvgOrderBy([void Function(GCertAvgOrderByBuilder b) updates]) =
      _$GCertAvgOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertAvgOrderBy> get serializer =>
      _$gCertAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertAvgOrderBy.serializer,
        json,
      );
}

abstract class GCertBoolExp
    implements Built<GCertBoolExp, GCertBoolExpBuilder> {
  GCertBoolExp._();

  factory GCertBoolExp([void Function(GCertBoolExpBuilder b) updates]) =
      _$GCertBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GCertBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GCertBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GCertBoolExp>? get G_or;
  GCertEventBoolExp? get certHistory;
  GCertEventAggregateBoolExp? get certHistoryAggregate;
  GEventBoolExp? get createdIn;
  GStringComparisonExp? get createdInId;
  GIntComparisonExp? get createdOn;
  GIntComparisonExp? get expireOn;
  GStringComparisonExp? get id;
  GBooleanComparisonExp? get isActive;
  GIdentityBoolExp? get issuer;
  GStringComparisonExp? get issuerId;
  GIdentityBoolExp? get receiver;
  GStringComparisonExp? get receiverId;
  GEventBoolExp? get updatedIn;
  GStringComparisonExp? get updatedInId;
  GIntComparisonExp? get updatedOn;
  static Serializer<GCertBoolExp> get serializer => _$gCertBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertBoolExp.serializer,
        json,
      );
}

abstract class GCertEventAggregateBoolExp
    implements
        Built<GCertEventAggregateBoolExp, GCertEventAggregateBoolExpBuilder> {
  GCertEventAggregateBoolExp._();

  factory GCertEventAggregateBoolExp(
          [void Function(GCertEventAggregateBoolExpBuilder b) updates]) =
      _$GCertEventAggregateBoolExp;

  GcertEventAggregateBoolExpCount? get count;
  static Serializer<GCertEventAggregateBoolExp> get serializer =>
      _$gCertEventAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventAggregateBoolExp.serializer,
        json,
      );
}

abstract class GcertEventAggregateBoolExpCount
    implements
        Built<GcertEventAggregateBoolExpCount,
            GcertEventAggregateBoolExpCountBuilder> {
  GcertEventAggregateBoolExpCount._();

  factory GcertEventAggregateBoolExpCount(
          [void Function(GcertEventAggregateBoolExpCountBuilder b) updates]) =
      _$GcertEventAggregateBoolExpCount;

  BuiltList<GCertEventSelectColumn>? get arguments;
  bool? get distinct;
  GCertEventBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GcertEventAggregateBoolExpCount> get serializer =>
      _$gcertEventAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GcertEventAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GcertEventAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GcertEventAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GCertEventAggregateOrderBy
    implements
        Built<GCertEventAggregateOrderBy, GCertEventAggregateOrderByBuilder> {
  GCertEventAggregateOrderBy._();

  factory GCertEventAggregateOrderBy(
          [void Function(GCertEventAggregateOrderByBuilder b) updates]) =
      _$GCertEventAggregateOrderBy;

  GCertEventAvgOrderBy? get avg;
  GOrderBy? get count;
  GCertEventMaxOrderBy? get max;
  GCertEventMinOrderBy? get min;
  GCertEventStddevOrderBy? get stddev;
  GCertEventStddevPopOrderBy? get stddevPop;
  GCertEventStddevSampOrderBy? get stddevSamp;
  GCertEventSumOrderBy? get sum;
  GCertEventVarPopOrderBy? get varPop;
  GCertEventVarSampOrderBy? get varSamp;
  GCertEventVarianceOrderBy? get variance;
  static Serializer<GCertEventAggregateOrderBy> get serializer =>
      _$gCertEventAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventAggregateOrderBy.serializer,
        json,
      );
}

abstract class GCertEventAvgOrderBy
    implements Built<GCertEventAvgOrderBy, GCertEventAvgOrderByBuilder> {
  GCertEventAvgOrderBy._();

  factory GCertEventAvgOrderBy(
          [void Function(GCertEventAvgOrderByBuilder b) updates]) =
      _$GCertEventAvgOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventAvgOrderBy> get serializer =>
      _$gCertEventAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventAvgOrderBy.serializer,
        json,
      );
}

abstract class GCertEventBoolExp
    implements Built<GCertEventBoolExp, GCertEventBoolExpBuilder> {
  GCertEventBoolExp._();

  factory GCertEventBoolExp(
          [void Function(GCertEventBoolExpBuilder b) updates]) =
      _$GCertEventBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GCertEventBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GCertEventBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GCertEventBoolExp>? get G_or;
  GIntComparisonExp? get blockNumber;
  GCertBoolExp? get cert;
  GStringComparisonExp? get certId;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get eventType;
  GStringComparisonExp? get id;
  static Serializer<GCertEventBoolExp> get serializer =>
      _$gCertEventBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventBoolExp.serializer,
        json,
      );
}

abstract class GCertEventMaxOrderBy
    implements Built<GCertEventMaxOrderBy, GCertEventMaxOrderByBuilder> {
  GCertEventMaxOrderBy._();

  factory GCertEventMaxOrderBy(
          [void Function(GCertEventMaxOrderByBuilder b) updates]) =
      _$GCertEventMaxOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get certId;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  static Serializer<GCertEventMaxOrderBy> get serializer =>
      _$gCertEventMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventMaxOrderBy.serializer,
        json,
      );
}

abstract class GCertEventMinOrderBy
    implements Built<GCertEventMinOrderBy, GCertEventMinOrderByBuilder> {
  GCertEventMinOrderBy._();

  factory GCertEventMinOrderBy(
          [void Function(GCertEventMinOrderByBuilder b) updates]) =
      _$GCertEventMinOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get certId;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  static Serializer<GCertEventMinOrderBy> get serializer =>
      _$gCertEventMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventMinOrderBy.serializer,
        json,
      );
}

abstract class GCertEventOrderBy
    implements Built<GCertEventOrderBy, GCertEventOrderByBuilder> {
  GCertEventOrderBy._();

  factory GCertEventOrderBy(
          [void Function(GCertEventOrderByBuilder b) updates]) =
      _$GCertEventOrderBy;

  GOrderBy? get blockNumber;
  GCertOrderBy? get cert;
  GOrderBy? get certId;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  static Serializer<GCertEventOrderBy> get serializer =>
      _$gCertEventOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventOrderBy.serializer,
        json,
      );
}

class GCertEventSelectColumn extends EnumClass {
  const GCertEventSelectColumn._(String name) : super(name);

  static const GCertEventSelectColumn blockNumber =
      _$gCertEventSelectColumnblockNumber;

  static const GCertEventSelectColumn certId = _$gCertEventSelectColumncertId;

  static const GCertEventSelectColumn eventId = _$gCertEventSelectColumneventId;

  static const GCertEventSelectColumn eventType =
      _$gCertEventSelectColumneventType;

  static const GCertEventSelectColumn id = _$gCertEventSelectColumnid;

  static Serializer<GCertEventSelectColumn> get serializer =>
      _$gCertEventSelectColumnSerializer;

  static BuiltSet<GCertEventSelectColumn> get values =>
      _$gCertEventSelectColumnValues;

  static GCertEventSelectColumn valueOf(String name) =>
      _$gCertEventSelectColumnValueOf(name);
}

abstract class GCertEventStddevOrderBy
    implements Built<GCertEventStddevOrderBy, GCertEventStddevOrderByBuilder> {
  GCertEventStddevOrderBy._();

  factory GCertEventStddevOrderBy(
          [void Function(GCertEventStddevOrderByBuilder b) updates]) =
      _$GCertEventStddevOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventStddevOrderBy> get serializer =>
      _$gCertEventStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventStddevOrderBy.serializer,
        json,
      );
}

abstract class GCertEventStddevPopOrderBy
    implements
        Built<GCertEventStddevPopOrderBy, GCertEventStddevPopOrderByBuilder> {
  GCertEventStddevPopOrderBy._();

  factory GCertEventStddevPopOrderBy(
          [void Function(GCertEventStddevPopOrderByBuilder b) updates]) =
      _$GCertEventStddevPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventStddevPopOrderBy> get serializer =>
      _$gCertEventStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GCertEventStddevSampOrderBy
    implements
        Built<GCertEventStddevSampOrderBy, GCertEventStddevSampOrderByBuilder> {
  GCertEventStddevSampOrderBy._();

  factory GCertEventStddevSampOrderBy(
          [void Function(GCertEventStddevSampOrderByBuilder b) updates]) =
      _$GCertEventStddevSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventStddevSampOrderBy> get serializer =>
      _$gCertEventStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GCertEventStreamCursorInput
    implements
        Built<GCertEventStreamCursorInput, GCertEventStreamCursorInputBuilder> {
  GCertEventStreamCursorInput._();

  factory GCertEventStreamCursorInput(
          [void Function(GCertEventStreamCursorInputBuilder b) updates]) =
      _$GCertEventStreamCursorInput;

  GCertEventStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GCertEventStreamCursorInput> get serializer =>
      _$gCertEventStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventStreamCursorInput.serializer,
        json,
      );
}

abstract class GCertEventStreamCursorValueInput
    implements
        Built<GCertEventStreamCursorValueInput,
            GCertEventStreamCursorValueInputBuilder> {
  GCertEventStreamCursorValueInput._();

  factory GCertEventStreamCursorValueInput(
          [void Function(GCertEventStreamCursorValueInputBuilder b) updates]) =
      _$GCertEventStreamCursorValueInput;

  int? get blockNumber;
  String? get certId;
  String? get eventId;
  String? get eventType;
  String? get id;
  static Serializer<GCertEventStreamCursorValueInput> get serializer =>
      _$gCertEventStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GCertEventSumOrderBy
    implements Built<GCertEventSumOrderBy, GCertEventSumOrderByBuilder> {
  GCertEventSumOrderBy._();

  factory GCertEventSumOrderBy(
          [void Function(GCertEventSumOrderByBuilder b) updates]) =
      _$GCertEventSumOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventSumOrderBy> get serializer =>
      _$gCertEventSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventSumOrderBy.serializer,
        json,
      );
}

abstract class GCertEventVarianceOrderBy
    implements
        Built<GCertEventVarianceOrderBy, GCertEventVarianceOrderByBuilder> {
  GCertEventVarianceOrderBy._();

  factory GCertEventVarianceOrderBy(
          [void Function(GCertEventVarianceOrderByBuilder b) updates]) =
      _$GCertEventVarianceOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventVarianceOrderBy> get serializer =>
      _$gCertEventVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventVarianceOrderBy.serializer,
        json,
      );
}

abstract class GCertEventVarPopOrderBy
    implements Built<GCertEventVarPopOrderBy, GCertEventVarPopOrderByBuilder> {
  GCertEventVarPopOrderBy._();

  factory GCertEventVarPopOrderBy(
          [void Function(GCertEventVarPopOrderByBuilder b) updates]) =
      _$GCertEventVarPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventVarPopOrderBy> get serializer =>
      _$gCertEventVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventVarPopOrderBy.serializer,
        json,
      );
}

abstract class GCertEventVarSampOrderBy
    implements
        Built<GCertEventVarSampOrderBy, GCertEventVarSampOrderByBuilder> {
  GCertEventVarSampOrderBy._();

  factory GCertEventVarSampOrderBy(
          [void Function(GCertEventVarSampOrderByBuilder b) updates]) =
      _$GCertEventVarSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GCertEventVarSampOrderBy> get serializer =>
      _$gCertEventVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventVarSampOrderBy.serializer,
        json,
      );
}

abstract class GCertMaxOrderBy
    implements Built<GCertMaxOrderBy, GCertMaxOrderByBuilder> {
  GCertMaxOrderBy._();

  factory GCertMaxOrderBy([void Function(GCertMaxOrderByBuilder b) updates]) =
      _$GCertMaxOrderBy;

  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get id;
  GOrderBy? get issuerId;
  GOrderBy? get receiverId;
  GOrderBy? get updatedInId;
  GOrderBy? get updatedOn;
  static Serializer<GCertMaxOrderBy> get serializer =>
      _$gCertMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertMaxOrderBy.serializer,
        json,
      );
}

abstract class GCertMinOrderBy
    implements Built<GCertMinOrderBy, GCertMinOrderByBuilder> {
  GCertMinOrderBy._();

  factory GCertMinOrderBy([void Function(GCertMinOrderByBuilder b) updates]) =
      _$GCertMinOrderBy;

  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get id;
  GOrderBy? get issuerId;
  GOrderBy? get receiverId;
  GOrderBy? get updatedInId;
  GOrderBy? get updatedOn;
  static Serializer<GCertMinOrderBy> get serializer =>
      _$gCertMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertMinOrderBy.serializer,
        json,
      );
}

abstract class GCertOrderBy
    implements Built<GCertOrderBy, GCertOrderByBuilder> {
  GCertOrderBy._();

  factory GCertOrderBy([void Function(GCertOrderByBuilder b) updates]) =
      _$GCertOrderBy;

  GCertEventAggregateOrderBy? get certHistoryAggregate;
  GEventOrderBy? get createdIn;
  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get id;
  GOrderBy? get isActive;
  GIdentityOrderBy? get issuer;
  GOrderBy? get issuerId;
  GIdentityOrderBy? get receiver;
  GOrderBy? get receiverId;
  GEventOrderBy? get updatedIn;
  GOrderBy? get updatedInId;
  GOrderBy? get updatedOn;
  static Serializer<GCertOrderBy> get serializer => _$gCertOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertOrderBy.serializer,
        json,
      );
}

class GCertSelectColumn extends EnumClass {
  const GCertSelectColumn._(String name) : super(name);

  static const GCertSelectColumn createdInId = _$gCertSelectColumncreatedInId;

  static const GCertSelectColumn createdOn = _$gCertSelectColumncreatedOn;

  static const GCertSelectColumn expireOn = _$gCertSelectColumnexpireOn;

  static const GCertSelectColumn id = _$gCertSelectColumnid;

  static const GCertSelectColumn isActive = _$gCertSelectColumnisActive;

  static const GCertSelectColumn issuerId = _$gCertSelectColumnissuerId;

  static const GCertSelectColumn receiverId = _$gCertSelectColumnreceiverId;

  static const GCertSelectColumn updatedInId = _$gCertSelectColumnupdatedInId;

  static const GCertSelectColumn updatedOn = _$gCertSelectColumnupdatedOn;

  static Serializer<GCertSelectColumn> get serializer =>
      _$gCertSelectColumnSerializer;

  static BuiltSet<GCertSelectColumn> get values => _$gCertSelectColumnValues;

  static GCertSelectColumn valueOf(String name) =>
      _$gCertSelectColumnValueOf(name);
}

class GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns
    extends EnumClass {
  const GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns._(
      String name)
      : super(name);

  static const GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns
      isActive =
      _$gCertSelectColumnCertAggregateBoolExpBoolAndArgumentsColumnsisActive;

  static Serializer<
          GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns>
      get serializer =>
          _$gCertSelectColumnCertAggregateBoolExpBoolAndArgumentsColumnsSerializer;

  static BuiltSet<GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns>
      get values =>
          _$gCertSelectColumnCertAggregateBoolExpBoolAndArgumentsColumnsValues;

  static GCertSelectColumnCertAggregateBoolExpBool_andArgumentsColumns valueOf(
          String name) =>
      _$gCertSelectColumnCertAggregateBoolExpBoolAndArgumentsColumnsValueOf(
          name);
}

class GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns
    extends EnumClass {
  const GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns._(
      String name)
      : super(name);

  static const GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns
      isActive =
      _$gCertSelectColumnCertAggregateBoolExpBoolOrArgumentsColumnsisActive;

  static Serializer<
          GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns>
      get serializer =>
          _$gCertSelectColumnCertAggregateBoolExpBoolOrArgumentsColumnsSerializer;

  static BuiltSet<GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns>
      get values =>
          _$gCertSelectColumnCertAggregateBoolExpBoolOrArgumentsColumnsValues;

  static GCertSelectColumnCertAggregateBoolExpBool_orArgumentsColumns valueOf(
          String name) =>
      _$gCertSelectColumnCertAggregateBoolExpBoolOrArgumentsColumnsValueOf(
          name);
}

abstract class GCertStddevOrderBy
    implements Built<GCertStddevOrderBy, GCertStddevOrderByBuilder> {
  GCertStddevOrderBy._();

  factory GCertStddevOrderBy(
          [void Function(GCertStddevOrderByBuilder b) updates]) =
      _$GCertStddevOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertStddevOrderBy> get serializer =>
      _$gCertStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertStddevOrderBy.serializer,
        json,
      );
}

abstract class GCertStddevPopOrderBy
    implements Built<GCertStddevPopOrderBy, GCertStddevPopOrderByBuilder> {
  GCertStddevPopOrderBy._();

  factory GCertStddevPopOrderBy(
          [void Function(GCertStddevPopOrderByBuilder b) updates]) =
      _$GCertStddevPopOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertStddevPopOrderBy> get serializer =>
      _$gCertStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GCertStddevSampOrderBy
    implements Built<GCertStddevSampOrderBy, GCertStddevSampOrderByBuilder> {
  GCertStddevSampOrderBy._();

  factory GCertStddevSampOrderBy(
          [void Function(GCertStddevSampOrderByBuilder b) updates]) =
      _$GCertStddevSampOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertStddevSampOrderBy> get serializer =>
      _$gCertStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GCertStreamCursorInput
    implements Built<GCertStreamCursorInput, GCertStreamCursorInputBuilder> {
  GCertStreamCursorInput._();

  factory GCertStreamCursorInput(
          [void Function(GCertStreamCursorInputBuilder b) updates]) =
      _$GCertStreamCursorInput;

  GCertStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GCertStreamCursorInput> get serializer =>
      _$gCertStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertStreamCursorInput.serializer,
        json,
      );
}

abstract class GCertStreamCursorValueInput
    implements
        Built<GCertStreamCursorValueInput, GCertStreamCursorValueInputBuilder> {
  GCertStreamCursorValueInput._();

  factory GCertStreamCursorValueInput(
          [void Function(GCertStreamCursorValueInputBuilder b) updates]) =
      _$GCertStreamCursorValueInput;

  String? get createdInId;
  int? get createdOn;
  int? get expireOn;
  String? get id;
  bool? get isActive;
  String? get issuerId;
  String? get receiverId;
  String? get updatedInId;
  int? get updatedOn;
  static Serializer<GCertStreamCursorValueInput> get serializer =>
      _$gCertStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GCertSumOrderBy
    implements Built<GCertSumOrderBy, GCertSumOrderByBuilder> {
  GCertSumOrderBy._();

  factory GCertSumOrderBy([void Function(GCertSumOrderByBuilder b) updates]) =
      _$GCertSumOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertSumOrderBy> get serializer =>
      _$gCertSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertSumOrderBy.serializer,
        json,
      );
}

abstract class GCertVarianceOrderBy
    implements Built<GCertVarianceOrderBy, GCertVarianceOrderByBuilder> {
  GCertVarianceOrderBy._();

  factory GCertVarianceOrderBy(
          [void Function(GCertVarianceOrderByBuilder b) updates]) =
      _$GCertVarianceOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertVarianceOrderBy> get serializer =>
      _$gCertVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertVarianceOrderBy.serializer,
        json,
      );
}

abstract class GCertVarPopOrderBy
    implements Built<GCertVarPopOrderBy, GCertVarPopOrderByBuilder> {
  GCertVarPopOrderBy._();

  factory GCertVarPopOrderBy(
          [void Function(GCertVarPopOrderByBuilder b) updates]) =
      _$GCertVarPopOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertVarPopOrderBy> get serializer =>
      _$gCertVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertVarPopOrderBy.serializer,
        json,
      );
}

abstract class GCertVarSampOrderBy
    implements Built<GCertVarSampOrderBy, GCertVarSampOrderByBuilder> {
  GCertVarSampOrderBy._();

  factory GCertVarSampOrderBy(
          [void Function(GCertVarSampOrderByBuilder b) updates]) =
      _$GCertVarSampOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get updatedOn;
  static Serializer<GCertVarSampOrderBy> get serializer =>
      _$gCertVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertVarSampOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyAggregateBoolExp
    implements
        Built<GChangeOwnerKeyAggregateBoolExp,
            GChangeOwnerKeyAggregateBoolExpBuilder> {
  GChangeOwnerKeyAggregateBoolExp._();

  factory GChangeOwnerKeyAggregateBoolExp(
          [void Function(GChangeOwnerKeyAggregateBoolExpBuilder b) updates]) =
      _$GChangeOwnerKeyAggregateBoolExp;

  GchangeOwnerKeyAggregateBoolExpCount? get count;
  static Serializer<GChangeOwnerKeyAggregateBoolExp> get serializer =>
      _$gChangeOwnerKeyAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyAggregateBoolExp.serializer,
        json,
      );
}

abstract class GchangeOwnerKeyAggregateBoolExpCount
    implements
        Built<GchangeOwnerKeyAggregateBoolExpCount,
            GchangeOwnerKeyAggregateBoolExpCountBuilder> {
  GchangeOwnerKeyAggregateBoolExpCount._();

  factory GchangeOwnerKeyAggregateBoolExpCount(
      [void Function(GchangeOwnerKeyAggregateBoolExpCountBuilder b)
          updates]) = _$GchangeOwnerKeyAggregateBoolExpCount;

  BuiltList<GChangeOwnerKeySelectColumn>? get arguments;
  bool? get distinct;
  GChangeOwnerKeyBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GchangeOwnerKeyAggregateBoolExpCount> get serializer =>
      _$gchangeOwnerKeyAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GchangeOwnerKeyAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GchangeOwnerKeyAggregateBoolExpCount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GchangeOwnerKeyAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyAggregateOrderBy
    implements
        Built<GChangeOwnerKeyAggregateOrderBy,
            GChangeOwnerKeyAggregateOrderByBuilder> {
  GChangeOwnerKeyAggregateOrderBy._();

  factory GChangeOwnerKeyAggregateOrderBy(
          [void Function(GChangeOwnerKeyAggregateOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyAggregateOrderBy;

  GChangeOwnerKeyAvgOrderBy? get avg;
  GOrderBy? get count;
  GChangeOwnerKeyMaxOrderBy? get max;
  GChangeOwnerKeyMinOrderBy? get min;
  GChangeOwnerKeyStddevOrderBy? get stddev;
  GChangeOwnerKeyStddevPopOrderBy? get stddevPop;
  GChangeOwnerKeyStddevSampOrderBy? get stddevSamp;
  GChangeOwnerKeySumOrderBy? get sum;
  GChangeOwnerKeyVarPopOrderBy? get varPop;
  GChangeOwnerKeyVarSampOrderBy? get varSamp;
  GChangeOwnerKeyVarianceOrderBy? get variance;
  static Serializer<GChangeOwnerKeyAggregateOrderBy> get serializer =>
      _$gChangeOwnerKeyAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyAggregateOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyAvgOrderBy
    implements
        Built<GChangeOwnerKeyAvgOrderBy, GChangeOwnerKeyAvgOrderByBuilder> {
  GChangeOwnerKeyAvgOrderBy._();

  factory GChangeOwnerKeyAvgOrderBy(
          [void Function(GChangeOwnerKeyAvgOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyAvgOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyAvgOrderBy> get serializer =>
      _$gChangeOwnerKeyAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyAvgOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyBoolExp
    implements Built<GChangeOwnerKeyBoolExp, GChangeOwnerKeyBoolExpBuilder> {
  GChangeOwnerKeyBoolExp._();

  factory GChangeOwnerKeyBoolExp(
          [void Function(GChangeOwnerKeyBoolExpBuilder b) updates]) =
      _$GChangeOwnerKeyBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GChangeOwnerKeyBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GChangeOwnerKeyBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GChangeOwnerKeyBoolExp>? get G_or;
  GIntComparisonExp? get blockNumber;
  GStringComparisonExp? get id;
  GIdentityBoolExp? get identity;
  GStringComparisonExp? get identityId;
  GAccountBoolExp? get next;
  GStringComparisonExp? get nextId;
  GAccountBoolExp? get previous;
  GStringComparisonExp? get previousId;
  static Serializer<GChangeOwnerKeyBoolExp> get serializer =>
      _$gChangeOwnerKeyBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyBoolExp.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyMaxOrderBy
    implements
        Built<GChangeOwnerKeyMaxOrderBy, GChangeOwnerKeyMaxOrderByBuilder> {
  GChangeOwnerKeyMaxOrderBy._();

  factory GChangeOwnerKeyMaxOrderBy(
          [void Function(GChangeOwnerKeyMaxOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyMaxOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get id;
  GOrderBy? get identityId;
  GOrderBy? get nextId;
  GOrderBy? get previousId;
  static Serializer<GChangeOwnerKeyMaxOrderBy> get serializer =>
      _$gChangeOwnerKeyMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyMaxOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyMinOrderBy
    implements
        Built<GChangeOwnerKeyMinOrderBy, GChangeOwnerKeyMinOrderByBuilder> {
  GChangeOwnerKeyMinOrderBy._();

  factory GChangeOwnerKeyMinOrderBy(
          [void Function(GChangeOwnerKeyMinOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyMinOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get id;
  GOrderBy? get identityId;
  GOrderBy? get nextId;
  GOrderBy? get previousId;
  static Serializer<GChangeOwnerKeyMinOrderBy> get serializer =>
      _$gChangeOwnerKeyMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyMinOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyOrderBy
    implements Built<GChangeOwnerKeyOrderBy, GChangeOwnerKeyOrderByBuilder> {
  GChangeOwnerKeyOrderBy._();

  factory GChangeOwnerKeyOrderBy(
          [void Function(GChangeOwnerKeyOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get id;
  GIdentityOrderBy? get identity;
  GOrderBy? get identityId;
  GAccountOrderBy? get next;
  GOrderBy? get nextId;
  GAccountOrderBy? get previous;
  GOrderBy? get previousId;
  static Serializer<GChangeOwnerKeyOrderBy> get serializer =>
      _$gChangeOwnerKeyOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyOrderBy.serializer,
        json,
      );
}

class GChangeOwnerKeySelectColumn extends EnumClass {
  const GChangeOwnerKeySelectColumn._(String name) : super(name);

  static const GChangeOwnerKeySelectColumn blockNumber =
      _$gChangeOwnerKeySelectColumnblockNumber;

  static const GChangeOwnerKeySelectColumn id = _$gChangeOwnerKeySelectColumnid;

  static const GChangeOwnerKeySelectColumn identityId =
      _$gChangeOwnerKeySelectColumnidentityId;

  static const GChangeOwnerKeySelectColumn nextId =
      _$gChangeOwnerKeySelectColumnnextId;

  static const GChangeOwnerKeySelectColumn previousId =
      _$gChangeOwnerKeySelectColumnpreviousId;

  static Serializer<GChangeOwnerKeySelectColumn> get serializer =>
      _$gChangeOwnerKeySelectColumnSerializer;

  static BuiltSet<GChangeOwnerKeySelectColumn> get values =>
      _$gChangeOwnerKeySelectColumnValues;

  static GChangeOwnerKeySelectColumn valueOf(String name) =>
      _$gChangeOwnerKeySelectColumnValueOf(name);
}

abstract class GChangeOwnerKeyStddevOrderBy
    implements
        Built<GChangeOwnerKeyStddevOrderBy,
            GChangeOwnerKeyStddevOrderByBuilder> {
  GChangeOwnerKeyStddevOrderBy._();

  factory GChangeOwnerKeyStddevOrderBy(
          [void Function(GChangeOwnerKeyStddevOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyStddevOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyStddevOrderBy> get serializer =>
      _$gChangeOwnerKeyStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyStddevOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyStddevPopOrderBy
    implements
        Built<GChangeOwnerKeyStddevPopOrderBy,
            GChangeOwnerKeyStddevPopOrderByBuilder> {
  GChangeOwnerKeyStddevPopOrderBy._();

  factory GChangeOwnerKeyStddevPopOrderBy(
          [void Function(GChangeOwnerKeyStddevPopOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyStddevPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyStddevPopOrderBy> get serializer =>
      _$gChangeOwnerKeyStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyStddevSampOrderBy
    implements
        Built<GChangeOwnerKeyStddevSampOrderBy,
            GChangeOwnerKeyStddevSampOrderByBuilder> {
  GChangeOwnerKeyStddevSampOrderBy._();

  factory GChangeOwnerKeyStddevSampOrderBy(
          [void Function(GChangeOwnerKeyStddevSampOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyStddevSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyStddevSampOrderBy> get serializer =>
      _$gChangeOwnerKeyStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyStddevSampOrderBy? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyStreamCursorInput
    implements
        Built<GChangeOwnerKeyStreamCursorInput,
            GChangeOwnerKeyStreamCursorInputBuilder> {
  GChangeOwnerKeyStreamCursorInput._();

  factory GChangeOwnerKeyStreamCursorInput(
          [void Function(GChangeOwnerKeyStreamCursorInputBuilder b) updates]) =
      _$GChangeOwnerKeyStreamCursorInput;

  GChangeOwnerKeyStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GChangeOwnerKeyStreamCursorInput> get serializer =>
      _$gChangeOwnerKeyStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyStreamCursorInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyStreamCursorInput.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyStreamCursorValueInput
    implements
        Built<GChangeOwnerKeyStreamCursorValueInput,
            GChangeOwnerKeyStreamCursorValueInputBuilder> {
  GChangeOwnerKeyStreamCursorValueInput._();

  factory GChangeOwnerKeyStreamCursorValueInput(
      [void Function(GChangeOwnerKeyStreamCursorValueInputBuilder b)
          updates]) = _$GChangeOwnerKeyStreamCursorValueInput;

  int? get blockNumber;
  String? get id;
  String? get identityId;
  String? get nextId;
  String? get previousId;
  static Serializer<GChangeOwnerKeyStreamCursorValueInput> get serializer =>
      _$gChangeOwnerKeyStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GChangeOwnerKeySumOrderBy
    implements
        Built<GChangeOwnerKeySumOrderBy, GChangeOwnerKeySumOrderByBuilder> {
  GChangeOwnerKeySumOrderBy._();

  factory GChangeOwnerKeySumOrderBy(
          [void Function(GChangeOwnerKeySumOrderByBuilder b) updates]) =
      _$GChangeOwnerKeySumOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeySumOrderBy> get serializer =>
      _$gChangeOwnerKeySumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeySumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeySumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeySumOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyVarianceOrderBy
    implements
        Built<GChangeOwnerKeyVarianceOrderBy,
            GChangeOwnerKeyVarianceOrderByBuilder> {
  GChangeOwnerKeyVarianceOrderBy._();

  factory GChangeOwnerKeyVarianceOrderBy(
          [void Function(GChangeOwnerKeyVarianceOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyVarianceOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyVarianceOrderBy> get serializer =>
      _$gChangeOwnerKeyVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyVarianceOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyVarPopOrderBy
    implements
        Built<GChangeOwnerKeyVarPopOrderBy,
            GChangeOwnerKeyVarPopOrderByBuilder> {
  GChangeOwnerKeyVarPopOrderBy._();

  factory GChangeOwnerKeyVarPopOrderBy(
          [void Function(GChangeOwnerKeyVarPopOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyVarPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyVarPopOrderBy> get serializer =>
      _$gChangeOwnerKeyVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyVarPopOrderBy.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyVarSampOrderBy
    implements
        Built<GChangeOwnerKeyVarSampOrderBy,
            GChangeOwnerKeyVarSampOrderByBuilder> {
  GChangeOwnerKeyVarSampOrderBy._();

  factory GChangeOwnerKeyVarSampOrderBy(
          [void Function(GChangeOwnerKeyVarSampOrderByBuilder b) updates]) =
      _$GChangeOwnerKeyVarSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GChangeOwnerKeyVarSampOrderBy> get serializer =>
      _$gChangeOwnerKeyVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyVarSampOrderBy.serializer,
        json,
      );
}

class GCursorOrdering extends EnumClass {
  const GCursorOrdering._(String name) : super(name);

  static const GCursorOrdering ASC = _$gCursorOrderingASC;

  static const GCursorOrdering DESC = _$gCursorOrderingDESC;

  static Serializer<GCursorOrdering> get serializer =>
      _$gCursorOrderingSerializer;

  static BuiltSet<GCursorOrdering> get values => _$gCursorOrderingValues;

  static GCursorOrdering valueOf(String name) => _$gCursorOrderingValueOf(name);
}

abstract class GEventAggregateBoolExp
    implements Built<GEventAggregateBoolExp, GEventAggregateBoolExpBuilder> {
  GEventAggregateBoolExp._();

  factory GEventAggregateBoolExp(
          [void Function(GEventAggregateBoolExpBuilder b) updates]) =
      _$GEventAggregateBoolExp;

  GeventAggregateBoolExpCount? get count;
  static Serializer<GEventAggregateBoolExp> get serializer =>
      _$gEventAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventAggregateBoolExp.serializer,
        json,
      );
}

abstract class GeventAggregateBoolExpCount
    implements
        Built<GeventAggregateBoolExpCount, GeventAggregateBoolExpCountBuilder> {
  GeventAggregateBoolExpCount._();

  factory GeventAggregateBoolExpCount(
          [void Function(GeventAggregateBoolExpCountBuilder b) updates]) =
      _$GeventAggregateBoolExpCount;

  BuiltList<GEventSelectColumn>? get arguments;
  bool? get distinct;
  GEventBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GeventAggregateBoolExpCount> get serializer =>
      _$geventAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GeventAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GeventAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GeventAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GEventAggregateOrderBy
    implements Built<GEventAggregateOrderBy, GEventAggregateOrderByBuilder> {
  GEventAggregateOrderBy._();

  factory GEventAggregateOrderBy(
          [void Function(GEventAggregateOrderByBuilder b) updates]) =
      _$GEventAggregateOrderBy;

  GEventAvgOrderBy? get avg;
  GOrderBy? get count;
  GEventMaxOrderBy? get max;
  GEventMinOrderBy? get min;
  GEventStddevOrderBy? get stddev;
  GEventStddevPopOrderBy? get stddevPop;
  GEventStddevSampOrderBy? get stddevSamp;
  GEventSumOrderBy? get sum;
  GEventVarPopOrderBy? get varPop;
  GEventVarSampOrderBy? get varSamp;
  GEventVarianceOrderBy? get variance;
  static Serializer<GEventAggregateOrderBy> get serializer =>
      _$gEventAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventAggregateOrderBy.serializer,
        json,
      );
}

abstract class GEventAvgOrderBy
    implements Built<GEventAvgOrderBy, GEventAvgOrderByBuilder> {
  GEventAvgOrderBy._();

  factory GEventAvgOrderBy([void Function(GEventAvgOrderByBuilder b) updates]) =
      _$GEventAvgOrderBy;

  GOrderBy? get index;
  static Serializer<GEventAvgOrderBy> get serializer =>
      _$gEventAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventAvgOrderBy.serializer,
        json,
      );
}

abstract class GEventBoolExp
    implements Built<GEventBoolExp, GEventBoolExpBuilder> {
  GEventBoolExp._();

  factory GEventBoolExp([void Function(GEventBoolExpBuilder b) updates]) =
      _$GEventBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GEventBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GEventBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GEventBoolExp>? get G_or;
  GJsonbComparisonExp? get args;
  GStringArrayComparisonExp? get argsStr;
  GBlockBoolExp? get block;
  GStringComparisonExp? get blockId;
  GCallBoolExp? get call;
  GStringComparisonExp? get callId;
  GExtrinsicBoolExp? get extrinsic;
  GStringComparisonExp? get extrinsicId;
  GStringComparisonExp? get id;
  GIntComparisonExp? get index;
  GStringComparisonExp? get name;
  GStringComparisonExp? get pallet;
  GStringComparisonExp? get phase;
  static Serializer<GEventBoolExp> get serializer => _$gEventBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventBoolExp.serializer,
        json,
      );
}

abstract class GEventMaxOrderBy
    implements Built<GEventMaxOrderBy, GEventMaxOrderByBuilder> {
  GEventMaxOrderBy._();

  factory GEventMaxOrderBy([void Function(GEventMaxOrderByBuilder b) updates]) =
      _$GEventMaxOrderBy;

  GOrderBy? get argsStr;
  GOrderBy? get blockId;
  GOrderBy? get callId;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GOrderBy? get phase;
  static Serializer<GEventMaxOrderBy> get serializer =>
      _$gEventMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventMaxOrderBy.serializer,
        json,
      );
}

abstract class GEventMinOrderBy
    implements Built<GEventMinOrderBy, GEventMinOrderByBuilder> {
  GEventMinOrderBy._();

  factory GEventMinOrderBy([void Function(GEventMinOrderByBuilder b) updates]) =
      _$GEventMinOrderBy;

  GOrderBy? get argsStr;
  GOrderBy? get blockId;
  GOrderBy? get callId;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GOrderBy? get phase;
  static Serializer<GEventMinOrderBy> get serializer =>
      _$gEventMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventMinOrderBy.serializer,
        json,
      );
}

abstract class GEventOrderBy
    implements Built<GEventOrderBy, GEventOrderByBuilder> {
  GEventOrderBy._();

  factory GEventOrderBy([void Function(GEventOrderByBuilder b) updates]) =
      _$GEventOrderBy;

  GOrderBy? get args;
  GOrderBy? get argsStr;
  GBlockOrderBy? get block;
  GOrderBy? get blockId;
  GCallOrderBy? get call;
  GOrderBy? get callId;
  GExtrinsicOrderBy? get extrinsic;
  GOrderBy? get extrinsicId;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get name;
  GOrderBy? get pallet;
  GOrderBy? get phase;
  static Serializer<GEventOrderBy> get serializer => _$gEventOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventOrderBy.serializer,
        json,
      );
}

class GEventSelectColumn extends EnumClass {
  const GEventSelectColumn._(String name) : super(name);

  static const GEventSelectColumn args = _$gEventSelectColumnargs;

  static const GEventSelectColumn argsStr = _$gEventSelectColumnargsStr;

  static const GEventSelectColumn blockId = _$gEventSelectColumnblockId;

  static const GEventSelectColumn callId = _$gEventSelectColumncallId;

  static const GEventSelectColumn extrinsicId = _$gEventSelectColumnextrinsicId;

  static const GEventSelectColumn id = _$gEventSelectColumnid;

  static const GEventSelectColumn index = _$gEventSelectColumnindex;

  @BuiltValueEnumConst(wireName: 'name')
  static const GEventSelectColumn Gname = _$gEventSelectColumnGname;

  static const GEventSelectColumn pallet = _$gEventSelectColumnpallet;

  static const GEventSelectColumn phase = _$gEventSelectColumnphase;

  static Serializer<GEventSelectColumn> get serializer =>
      _$gEventSelectColumnSerializer;

  static BuiltSet<GEventSelectColumn> get values => _$gEventSelectColumnValues;

  static GEventSelectColumn valueOf(String name) =>
      _$gEventSelectColumnValueOf(name);
}

abstract class GEventStddevOrderBy
    implements Built<GEventStddevOrderBy, GEventStddevOrderByBuilder> {
  GEventStddevOrderBy._();

  factory GEventStddevOrderBy(
          [void Function(GEventStddevOrderByBuilder b) updates]) =
      _$GEventStddevOrderBy;

  GOrderBy? get index;
  static Serializer<GEventStddevOrderBy> get serializer =>
      _$gEventStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventStddevOrderBy.serializer,
        json,
      );
}

abstract class GEventStddevPopOrderBy
    implements Built<GEventStddevPopOrderBy, GEventStddevPopOrderByBuilder> {
  GEventStddevPopOrderBy._();

  factory GEventStddevPopOrderBy(
          [void Function(GEventStddevPopOrderByBuilder b) updates]) =
      _$GEventStddevPopOrderBy;

  GOrderBy? get index;
  static Serializer<GEventStddevPopOrderBy> get serializer =>
      _$gEventStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GEventStddevSampOrderBy
    implements Built<GEventStddevSampOrderBy, GEventStddevSampOrderByBuilder> {
  GEventStddevSampOrderBy._();

  factory GEventStddevSampOrderBy(
          [void Function(GEventStddevSampOrderByBuilder b) updates]) =
      _$GEventStddevSampOrderBy;

  GOrderBy? get index;
  static Serializer<GEventStddevSampOrderBy> get serializer =>
      _$gEventStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GEventStreamCursorInput
    implements Built<GEventStreamCursorInput, GEventStreamCursorInputBuilder> {
  GEventStreamCursorInput._();

  factory GEventStreamCursorInput(
          [void Function(GEventStreamCursorInputBuilder b) updates]) =
      _$GEventStreamCursorInput;

  GEventStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GEventStreamCursorInput> get serializer =>
      _$gEventStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventStreamCursorInput.serializer,
        json,
      );
}

abstract class GEventStreamCursorValueInput
    implements
        Built<GEventStreamCursorValueInput,
            GEventStreamCursorValueInputBuilder> {
  GEventStreamCursorValueInput._();

  factory GEventStreamCursorValueInput(
          [void Function(GEventStreamCursorValueInputBuilder b) updates]) =
      _$GEventStreamCursorValueInput;

  _i3.JsonObject? get args;
  BuiltList<String>? get argsStr;
  String? get blockId;
  String? get callId;
  String? get extrinsicId;
  String? get id;
  int? get index;
  String? get name;
  String? get pallet;
  String? get phase;
  static Serializer<GEventStreamCursorValueInput> get serializer =>
      _$gEventStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GEventSumOrderBy
    implements Built<GEventSumOrderBy, GEventSumOrderByBuilder> {
  GEventSumOrderBy._();

  factory GEventSumOrderBy([void Function(GEventSumOrderByBuilder b) updates]) =
      _$GEventSumOrderBy;

  GOrderBy? get index;
  static Serializer<GEventSumOrderBy> get serializer =>
      _$gEventSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventSumOrderBy.serializer,
        json,
      );
}

abstract class GEventVarianceOrderBy
    implements Built<GEventVarianceOrderBy, GEventVarianceOrderByBuilder> {
  GEventVarianceOrderBy._();

  factory GEventVarianceOrderBy(
          [void Function(GEventVarianceOrderByBuilder b) updates]) =
      _$GEventVarianceOrderBy;

  GOrderBy? get index;
  static Serializer<GEventVarianceOrderBy> get serializer =>
      _$gEventVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventVarianceOrderBy.serializer,
        json,
      );
}

abstract class GEventVarPopOrderBy
    implements Built<GEventVarPopOrderBy, GEventVarPopOrderByBuilder> {
  GEventVarPopOrderBy._();

  factory GEventVarPopOrderBy(
          [void Function(GEventVarPopOrderByBuilder b) updates]) =
      _$GEventVarPopOrderBy;

  GOrderBy? get index;
  static Serializer<GEventVarPopOrderBy> get serializer =>
      _$gEventVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventVarPopOrderBy.serializer,
        json,
      );
}

abstract class GEventVarSampOrderBy
    implements Built<GEventVarSampOrderBy, GEventVarSampOrderByBuilder> {
  GEventVarSampOrderBy._();

  factory GEventVarSampOrderBy(
          [void Function(GEventVarSampOrderByBuilder b) updates]) =
      _$GEventVarSampOrderBy;

  GOrderBy? get index;
  static Serializer<GEventVarSampOrderBy> get serializer =>
      _$gEventVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventVarSampOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicAggregateBoolExp
    implements
        Built<GExtrinsicAggregateBoolExp, GExtrinsicAggregateBoolExpBuilder> {
  GExtrinsicAggregateBoolExp._();

  factory GExtrinsicAggregateBoolExp(
          [void Function(GExtrinsicAggregateBoolExpBuilder b) updates]) =
      _$GExtrinsicAggregateBoolExp;

  GextrinsicAggregateBoolExpBool_and? get bool_and;
  GextrinsicAggregateBoolExpBool_or? get bool_or;
  GextrinsicAggregateBoolExpCount? get count;
  static Serializer<GExtrinsicAggregateBoolExp> get serializer =>
      _$gExtrinsicAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicAggregateBoolExp.serializer,
        json,
      );
}

abstract class GextrinsicAggregateBoolExpBool_and
    implements
        Built<GextrinsicAggregateBoolExpBool_and,
            GextrinsicAggregateBoolExpBool_andBuilder> {
  GextrinsicAggregateBoolExpBool_and._();

  factory GextrinsicAggregateBoolExpBool_and(
      [void Function(GextrinsicAggregateBoolExpBool_andBuilder b)
          updates]) = _$GextrinsicAggregateBoolExpBool_and;

  GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns
      get arguments;
  bool? get distinct;
  GExtrinsicBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GextrinsicAggregateBoolExpBool_and> get serializer =>
      _$gextrinsicAggregateBoolExpBoolAndSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GextrinsicAggregateBoolExpBool_and.serializer,
        this,
      ) as Map<String, dynamic>);

  static GextrinsicAggregateBoolExpBool_and? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GextrinsicAggregateBoolExpBool_and.serializer,
        json,
      );
}

abstract class GextrinsicAggregateBoolExpBool_or
    implements
        Built<GextrinsicAggregateBoolExpBool_or,
            GextrinsicAggregateBoolExpBool_orBuilder> {
  GextrinsicAggregateBoolExpBool_or._();

  factory GextrinsicAggregateBoolExpBool_or(
          [void Function(GextrinsicAggregateBoolExpBool_orBuilder b) updates]) =
      _$GextrinsicAggregateBoolExpBool_or;

  GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns
      get arguments;
  bool? get distinct;
  GExtrinsicBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GextrinsicAggregateBoolExpBool_or> get serializer =>
      _$gextrinsicAggregateBoolExpBoolOrSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GextrinsicAggregateBoolExpBool_or.serializer,
        this,
      ) as Map<String, dynamic>);

  static GextrinsicAggregateBoolExpBool_or? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GextrinsicAggregateBoolExpBool_or.serializer,
        json,
      );
}

abstract class GextrinsicAggregateBoolExpCount
    implements
        Built<GextrinsicAggregateBoolExpCount,
            GextrinsicAggregateBoolExpCountBuilder> {
  GextrinsicAggregateBoolExpCount._();

  factory GextrinsicAggregateBoolExpCount(
          [void Function(GextrinsicAggregateBoolExpCountBuilder b) updates]) =
      _$GextrinsicAggregateBoolExpCount;

  BuiltList<GExtrinsicSelectColumn>? get arguments;
  bool? get distinct;
  GExtrinsicBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GextrinsicAggregateBoolExpCount> get serializer =>
      _$gextrinsicAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GextrinsicAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GextrinsicAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GextrinsicAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GExtrinsicAggregateOrderBy
    implements
        Built<GExtrinsicAggregateOrderBy, GExtrinsicAggregateOrderByBuilder> {
  GExtrinsicAggregateOrderBy._();

  factory GExtrinsicAggregateOrderBy(
          [void Function(GExtrinsicAggregateOrderByBuilder b) updates]) =
      _$GExtrinsicAggregateOrderBy;

  GExtrinsicAvgOrderBy? get avg;
  GOrderBy? get count;
  GExtrinsicMaxOrderBy? get max;
  GExtrinsicMinOrderBy? get min;
  GExtrinsicStddevOrderBy? get stddev;
  GExtrinsicStddevPopOrderBy? get stddevPop;
  GExtrinsicStddevSampOrderBy? get stddevSamp;
  GExtrinsicSumOrderBy? get sum;
  GExtrinsicVarPopOrderBy? get varPop;
  GExtrinsicVarSampOrderBy? get varSamp;
  GExtrinsicVarianceOrderBy? get variance;
  static Serializer<GExtrinsicAggregateOrderBy> get serializer =>
      _$gExtrinsicAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicAggregateOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicAvgOrderBy
    implements Built<GExtrinsicAvgOrderBy, GExtrinsicAvgOrderByBuilder> {
  GExtrinsicAvgOrderBy._();

  factory GExtrinsicAvgOrderBy(
          [void Function(GExtrinsicAvgOrderByBuilder b) updates]) =
      _$GExtrinsicAvgOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicAvgOrderBy> get serializer =>
      _$gExtrinsicAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicAvgOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicBoolExp
    implements Built<GExtrinsicBoolExp, GExtrinsicBoolExpBuilder> {
  GExtrinsicBoolExp._();

  factory GExtrinsicBoolExp(
          [void Function(GExtrinsicBoolExpBuilder b) updates]) =
      _$GExtrinsicBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GExtrinsicBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GExtrinsicBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GExtrinsicBoolExp>? get G_or;
  GBlockBoolExp? get block;
  GStringComparisonExp? get blockId;
  GCallBoolExp? get call;
  GStringComparisonExp? get callId;
  GCallBoolExp? get calls;
  GCallAggregateBoolExp? get callsAggregate;
  GJsonbComparisonExp? get error;
  GEventBoolExp? get events;
  GEventAggregateBoolExp? get eventsAggregate;
  GNumericComparisonExp? get fee;
  GByteaComparisonExp? get hash;
  GStringComparisonExp? get id;
  GIntComparisonExp? get index;
  GJsonbComparisonExp? get signature;
  GBooleanComparisonExp? get success;
  GNumericComparisonExp? get tip;
  GIntComparisonExp? get version;
  static Serializer<GExtrinsicBoolExp> get serializer =>
      _$gExtrinsicBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicBoolExp.serializer,
        json,
      );
}

abstract class GExtrinsicMaxOrderBy
    implements Built<GExtrinsicMaxOrderBy, GExtrinsicMaxOrderByBuilder> {
  GExtrinsicMaxOrderBy._();

  factory GExtrinsicMaxOrderBy(
          [void Function(GExtrinsicMaxOrderByBuilder b) updates]) =
      _$GExtrinsicMaxOrderBy;

  GOrderBy? get blockId;
  GOrderBy? get callId;
  GOrderBy? get fee;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicMaxOrderBy> get serializer =>
      _$gExtrinsicMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicMaxOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicMinOrderBy
    implements Built<GExtrinsicMinOrderBy, GExtrinsicMinOrderByBuilder> {
  GExtrinsicMinOrderBy._();

  factory GExtrinsicMinOrderBy(
          [void Function(GExtrinsicMinOrderByBuilder b) updates]) =
      _$GExtrinsicMinOrderBy;

  GOrderBy? get blockId;
  GOrderBy? get callId;
  GOrderBy? get fee;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicMinOrderBy> get serializer =>
      _$gExtrinsicMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicMinOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicOrderBy
    implements Built<GExtrinsicOrderBy, GExtrinsicOrderByBuilder> {
  GExtrinsicOrderBy._();

  factory GExtrinsicOrderBy(
          [void Function(GExtrinsicOrderByBuilder b) updates]) =
      _$GExtrinsicOrderBy;

  GBlockOrderBy? get block;
  GOrderBy? get blockId;
  GCallOrderBy? get call;
  GOrderBy? get callId;
  GCallAggregateOrderBy? get callsAggregate;
  GOrderBy? get error;
  GEventAggregateOrderBy? get eventsAggregate;
  GOrderBy? get fee;
  GOrderBy? get hash;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get signature;
  GOrderBy? get success;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicOrderBy> get serializer =>
      _$gExtrinsicOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicOrderBy.serializer,
        json,
      );
}

class GExtrinsicSelectColumn extends EnumClass {
  const GExtrinsicSelectColumn._(String name) : super(name);

  static const GExtrinsicSelectColumn blockId = _$gExtrinsicSelectColumnblockId;

  static const GExtrinsicSelectColumn callId = _$gExtrinsicSelectColumncallId;

  static const GExtrinsicSelectColumn error = _$gExtrinsicSelectColumnerror;

  static const GExtrinsicSelectColumn fee = _$gExtrinsicSelectColumnfee;

  static const GExtrinsicSelectColumn hash = _$gExtrinsicSelectColumnhash;

  static const GExtrinsicSelectColumn id = _$gExtrinsicSelectColumnid;

  static const GExtrinsicSelectColumn index = _$gExtrinsicSelectColumnindex;

  static const GExtrinsicSelectColumn signature =
      _$gExtrinsicSelectColumnsignature;

  static const GExtrinsicSelectColumn success = _$gExtrinsicSelectColumnsuccess;

  static const GExtrinsicSelectColumn tip = _$gExtrinsicSelectColumntip;

  static const GExtrinsicSelectColumn version = _$gExtrinsicSelectColumnversion;

  static Serializer<GExtrinsicSelectColumn> get serializer =>
      _$gExtrinsicSelectColumnSerializer;

  static BuiltSet<GExtrinsicSelectColumn> get values =>
      _$gExtrinsicSelectColumnValues;

  static GExtrinsicSelectColumn valueOf(String name) =>
      _$gExtrinsicSelectColumnValueOf(name);
}

class GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns
    extends EnumClass {
  const GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns._(
      String name)
      : super(name);

  static const GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns
      success =
      _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolAndArgumentsColumnssuccess;

  static Serializer<
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns>
      get serializer =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolAndArgumentsColumnsSerializer;

  static BuiltSet<
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns>
      get values =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolAndArgumentsColumnsValues;

  static GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_andArgumentsColumns
      valueOf(String name) =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolAndArgumentsColumnsValueOf(
              name);
}

class GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns
    extends EnumClass {
  const GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns._(
      String name)
      : super(name);

  static const GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns
      success =
      _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolOrArgumentsColumnssuccess;

  static Serializer<
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns>
      get serializer =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolOrArgumentsColumnsSerializer;

  static BuiltSet<
          GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns>
      get values =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolOrArgumentsColumnsValues;

  static GExtrinsicSelectColumnExtrinsicAggregateBoolExpBool_orArgumentsColumns
      valueOf(String name) =>
          _$gExtrinsicSelectColumnExtrinsicAggregateBoolExpBoolOrArgumentsColumnsValueOf(
              name);
}

abstract class GExtrinsicStddevOrderBy
    implements Built<GExtrinsicStddevOrderBy, GExtrinsicStddevOrderByBuilder> {
  GExtrinsicStddevOrderBy._();

  factory GExtrinsicStddevOrderBy(
          [void Function(GExtrinsicStddevOrderByBuilder b) updates]) =
      _$GExtrinsicStddevOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicStddevOrderBy> get serializer =>
      _$gExtrinsicStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicStddevOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicStddevPopOrderBy
    implements
        Built<GExtrinsicStddevPopOrderBy, GExtrinsicStddevPopOrderByBuilder> {
  GExtrinsicStddevPopOrderBy._();

  factory GExtrinsicStddevPopOrderBy(
          [void Function(GExtrinsicStddevPopOrderByBuilder b) updates]) =
      _$GExtrinsicStddevPopOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicStddevPopOrderBy> get serializer =>
      _$gExtrinsicStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicStddevSampOrderBy
    implements
        Built<GExtrinsicStddevSampOrderBy, GExtrinsicStddevSampOrderByBuilder> {
  GExtrinsicStddevSampOrderBy._();

  factory GExtrinsicStddevSampOrderBy(
          [void Function(GExtrinsicStddevSampOrderByBuilder b) updates]) =
      _$GExtrinsicStddevSampOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicStddevSampOrderBy> get serializer =>
      _$gExtrinsicStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicStreamCursorInput
    implements
        Built<GExtrinsicStreamCursorInput, GExtrinsicStreamCursorInputBuilder> {
  GExtrinsicStreamCursorInput._();

  factory GExtrinsicStreamCursorInput(
          [void Function(GExtrinsicStreamCursorInputBuilder b) updates]) =
      _$GExtrinsicStreamCursorInput;

  GExtrinsicStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GExtrinsicStreamCursorInput> get serializer =>
      _$gExtrinsicStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicStreamCursorInput.serializer,
        json,
      );
}

abstract class GExtrinsicStreamCursorValueInput
    implements
        Built<GExtrinsicStreamCursorValueInput,
            GExtrinsicStreamCursorValueInputBuilder> {
  GExtrinsicStreamCursorValueInput._();

  factory GExtrinsicStreamCursorValueInput(
          [void Function(GExtrinsicStreamCursorValueInputBuilder b) updates]) =
      _$GExtrinsicStreamCursorValueInput;

  String? get blockId;
  String? get callId;
  _i3.JsonObject? get error;
  int? get fee;
  Gbytea? get hash;
  String? get id;
  int? get index;
  _i3.JsonObject? get signature;
  bool? get success;
  int? get tip;
  int? get version;
  static Serializer<GExtrinsicStreamCursorValueInput> get serializer =>
      _$gExtrinsicStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GExtrinsicSumOrderBy
    implements Built<GExtrinsicSumOrderBy, GExtrinsicSumOrderByBuilder> {
  GExtrinsicSumOrderBy._();

  factory GExtrinsicSumOrderBy(
          [void Function(GExtrinsicSumOrderByBuilder b) updates]) =
      _$GExtrinsicSumOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicSumOrderBy> get serializer =>
      _$gExtrinsicSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicSumOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicVarianceOrderBy
    implements
        Built<GExtrinsicVarianceOrderBy, GExtrinsicVarianceOrderByBuilder> {
  GExtrinsicVarianceOrderBy._();

  factory GExtrinsicVarianceOrderBy(
          [void Function(GExtrinsicVarianceOrderByBuilder b) updates]) =
      _$GExtrinsicVarianceOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicVarianceOrderBy> get serializer =>
      _$gExtrinsicVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicVarianceOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicVarPopOrderBy
    implements Built<GExtrinsicVarPopOrderBy, GExtrinsicVarPopOrderByBuilder> {
  GExtrinsicVarPopOrderBy._();

  factory GExtrinsicVarPopOrderBy(
          [void Function(GExtrinsicVarPopOrderByBuilder b) updates]) =
      _$GExtrinsicVarPopOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicVarPopOrderBy> get serializer =>
      _$gExtrinsicVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicVarPopOrderBy.serializer,
        json,
      );
}

abstract class GExtrinsicVarSampOrderBy
    implements
        Built<GExtrinsicVarSampOrderBy, GExtrinsicVarSampOrderByBuilder> {
  GExtrinsicVarSampOrderBy._();

  factory GExtrinsicVarSampOrderBy(
          [void Function(GExtrinsicVarSampOrderByBuilder b) updates]) =
      _$GExtrinsicVarSampOrderBy;

  GOrderBy? get fee;
  GOrderBy? get index;
  GOrderBy? get tip;
  GOrderBy? get version;
  static Serializer<GExtrinsicVarSampOrderBy> get serializer =>
      _$gExtrinsicVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicVarSampOrderBy.serializer,
        json,
      );
}

abstract class GIdentityAggregateBoolExp
    implements
        Built<GIdentityAggregateBoolExp, GIdentityAggregateBoolExpBuilder> {
  GIdentityAggregateBoolExp._();

  factory GIdentityAggregateBoolExp(
          [void Function(GIdentityAggregateBoolExpBuilder b) updates]) =
      _$GIdentityAggregateBoolExp;

  GidentityAggregateBoolExpBool_and? get bool_and;
  GidentityAggregateBoolExpBool_or? get bool_or;
  GidentityAggregateBoolExpCount? get count;
  static Serializer<GIdentityAggregateBoolExp> get serializer =>
      _$gIdentityAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityAggregateBoolExp.serializer,
        json,
      );
}

abstract class GidentityAggregateBoolExpBool_and
    implements
        Built<GidentityAggregateBoolExpBool_and,
            GidentityAggregateBoolExpBool_andBuilder> {
  GidentityAggregateBoolExpBool_and._();

  factory GidentityAggregateBoolExpBool_and(
          [void Function(GidentityAggregateBoolExpBool_andBuilder b) updates]) =
      _$GidentityAggregateBoolExpBool_and;

  GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns
      get arguments;
  bool? get distinct;
  GIdentityBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GidentityAggregateBoolExpBool_and> get serializer =>
      _$gidentityAggregateBoolExpBoolAndSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GidentityAggregateBoolExpBool_and.serializer,
        this,
      ) as Map<String, dynamic>);

  static GidentityAggregateBoolExpBool_and? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GidentityAggregateBoolExpBool_and.serializer,
        json,
      );
}

abstract class GidentityAggregateBoolExpBool_or
    implements
        Built<GidentityAggregateBoolExpBool_or,
            GidentityAggregateBoolExpBool_orBuilder> {
  GidentityAggregateBoolExpBool_or._();

  factory GidentityAggregateBoolExpBool_or(
          [void Function(GidentityAggregateBoolExpBool_orBuilder b) updates]) =
      _$GidentityAggregateBoolExpBool_or;

  GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns
      get arguments;
  bool? get distinct;
  GIdentityBoolExp? get filter;
  GBooleanComparisonExp get predicate;
  static Serializer<GidentityAggregateBoolExpBool_or> get serializer =>
      _$gidentityAggregateBoolExpBoolOrSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GidentityAggregateBoolExpBool_or.serializer,
        this,
      ) as Map<String, dynamic>);

  static GidentityAggregateBoolExpBool_or? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GidentityAggregateBoolExpBool_or.serializer,
        json,
      );
}

abstract class GidentityAggregateBoolExpCount
    implements
        Built<GidentityAggregateBoolExpCount,
            GidentityAggregateBoolExpCountBuilder> {
  GidentityAggregateBoolExpCount._();

  factory GidentityAggregateBoolExpCount(
          [void Function(GidentityAggregateBoolExpCountBuilder b) updates]) =
      _$GidentityAggregateBoolExpCount;

  BuiltList<GIdentitySelectColumn>? get arguments;
  bool? get distinct;
  GIdentityBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GidentityAggregateBoolExpCount> get serializer =>
      _$gidentityAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GidentityAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GidentityAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GidentityAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GIdentityAggregateOrderBy
    implements
        Built<GIdentityAggregateOrderBy, GIdentityAggregateOrderByBuilder> {
  GIdentityAggregateOrderBy._();

  factory GIdentityAggregateOrderBy(
          [void Function(GIdentityAggregateOrderByBuilder b) updates]) =
      _$GIdentityAggregateOrderBy;

  GIdentityAvgOrderBy? get avg;
  GOrderBy? get count;
  GIdentityMaxOrderBy? get max;
  GIdentityMinOrderBy? get min;
  GIdentityStddevOrderBy? get stddev;
  GIdentityStddevPopOrderBy? get stddevPop;
  GIdentityStddevSampOrderBy? get stddevSamp;
  GIdentitySumOrderBy? get sum;
  GIdentityVarPopOrderBy? get varPop;
  GIdentityVarSampOrderBy? get varSamp;
  GIdentityVarianceOrderBy? get variance;
  static Serializer<GIdentityAggregateOrderBy> get serializer =>
      _$gIdentityAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityAggregateOrderBy.serializer,
        json,
      );
}

abstract class GIdentityAvgOrderBy
    implements Built<GIdentityAvgOrderBy, GIdentityAvgOrderByBuilder> {
  GIdentityAvgOrderBy._();

  factory GIdentityAvgOrderBy(
          [void Function(GIdentityAvgOrderByBuilder b) updates]) =
      _$GIdentityAvgOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityAvgOrderBy> get serializer =>
      _$gIdentityAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityAvgOrderBy.serializer,
        json,
      );
}

abstract class GIdentityBoolExp
    implements Built<GIdentityBoolExp, GIdentityBoolExpBuilder> {
  GIdentityBoolExp._();

  factory GIdentityBoolExp([void Function(GIdentityBoolExpBuilder b) updates]) =
      _$GIdentityBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GIdentityBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GIdentityBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GIdentityBoolExp>? get G_or;
  GAccountBoolExp? get account;
  GStringComparisonExp? get accountId;
  GAccountBoolExp? get accountRemoved;
  GStringComparisonExp? get accountRemovedId;
  GCertBoolExp? get certIssued;
  GCertAggregateBoolExp? get certIssuedAggregate;
  GCertBoolExp? get certReceived;
  GCertAggregateBoolExp? get certReceivedAggregate;
  GEventBoolExp? get createdIn;
  GStringComparisonExp? get createdInId;
  GIntComparisonExp? get createdOn;
  GIntComparisonExp? get expireOn;
  GIntComparisonExp? get firstEligibleUd;
  GStringComparisonExp? get id;
  GIntComparisonExp? get index;
  GBooleanComparisonExp? get isMember;
  GIntComparisonExp? get lastChangeOn;
  GAccountBoolExp? get linkedAccount;
  GAccountAggregateBoolExp? get linkedAccountAggregate;
  GMembershipEventBoolExp? get membershipHistory;
  GMembershipEventAggregateBoolExp? get membershipHistoryAggregate;
  GStringComparisonExp? get name;
  GChangeOwnerKeyBoolExp? get ownerKeyChange;
  GChangeOwnerKeyAggregateBoolExp? get ownerKeyChangeAggregate;
  GSmithBoolExp? get smith;
  GStringComparisonExp? get status;
  static Serializer<GIdentityBoolExp> get serializer =>
      _$gIdentityBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityBoolExp.serializer,
        json,
      );
}

abstract class GIdentityMaxOrderBy
    implements Built<GIdentityMaxOrderBy, GIdentityMaxOrderByBuilder> {
  GIdentityMaxOrderBy._();

  factory GIdentityMaxOrderBy(
          [void Function(GIdentityMaxOrderByBuilder b) updates]) =
      _$GIdentityMaxOrderBy;

  GOrderBy? get accountId;
  GOrderBy? get accountRemovedId;
  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  GOrderBy? get name;
  GOrderBy? get status;
  static Serializer<GIdentityMaxOrderBy> get serializer =>
      _$gIdentityMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityMaxOrderBy.serializer,
        json,
      );
}

abstract class GIdentityMinOrderBy
    implements Built<GIdentityMinOrderBy, GIdentityMinOrderByBuilder> {
  GIdentityMinOrderBy._();

  factory GIdentityMinOrderBy(
          [void Function(GIdentityMinOrderByBuilder b) updates]) =
      _$GIdentityMinOrderBy;

  GOrderBy? get accountId;
  GOrderBy? get accountRemovedId;
  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  GOrderBy? get name;
  GOrderBy? get status;
  static Serializer<GIdentityMinOrderBy> get serializer =>
      _$gIdentityMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityMinOrderBy.serializer,
        json,
      );
}

abstract class GIdentityOrderBy
    implements Built<GIdentityOrderBy, GIdentityOrderByBuilder> {
  GIdentityOrderBy._();

  factory GIdentityOrderBy([void Function(GIdentityOrderByBuilder b) updates]) =
      _$GIdentityOrderBy;

  GAccountOrderBy? get account;
  GOrderBy? get accountId;
  GAccountOrderBy? get accountRemoved;
  GOrderBy? get accountRemovedId;
  GCertAggregateOrderBy? get certIssuedAggregate;
  GCertAggregateOrderBy? get certReceivedAggregate;
  GEventOrderBy? get createdIn;
  GOrderBy? get createdInId;
  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get isMember;
  GOrderBy? get lastChangeOn;
  GAccountAggregateOrderBy? get linkedAccountAggregate;
  GMembershipEventAggregateOrderBy? get membershipHistoryAggregate;
  GOrderBy? get name;
  GChangeOwnerKeyAggregateOrderBy? get ownerKeyChangeAggregate;
  GSmithOrderBy? get smith;
  GOrderBy? get status;
  static Serializer<GIdentityOrderBy> get serializer =>
      _$gIdentityOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityOrderBy.serializer,
        json,
      );
}

class GIdentitySelectColumn extends EnumClass {
  const GIdentitySelectColumn._(String name) : super(name);

  static const GIdentitySelectColumn accountId =
      _$gIdentitySelectColumnaccountId;

  static const GIdentitySelectColumn accountRemovedId =
      _$gIdentitySelectColumnaccountRemovedId;

  static const GIdentitySelectColumn createdInId =
      _$gIdentitySelectColumncreatedInId;

  static const GIdentitySelectColumn createdOn =
      _$gIdentitySelectColumncreatedOn;

  static const GIdentitySelectColumn expireOn = _$gIdentitySelectColumnexpireOn;

  static const GIdentitySelectColumn firstEligibleUd =
      _$gIdentitySelectColumnfirstEligibleUd;

  static const GIdentitySelectColumn id = _$gIdentitySelectColumnid;

  static const GIdentitySelectColumn index = _$gIdentitySelectColumnindex;

  static const GIdentitySelectColumn isMember = _$gIdentitySelectColumnisMember;

  static const GIdentitySelectColumn lastChangeOn =
      _$gIdentitySelectColumnlastChangeOn;

  @BuiltValueEnumConst(wireName: 'name')
  static const GIdentitySelectColumn Gname = _$gIdentitySelectColumnGname;

  static const GIdentitySelectColumn status = _$gIdentitySelectColumnstatus;

  static Serializer<GIdentitySelectColumn> get serializer =>
      _$gIdentitySelectColumnSerializer;

  static BuiltSet<GIdentitySelectColumn> get values =>
      _$gIdentitySelectColumnValues;

  static GIdentitySelectColumn valueOf(String name) =>
      _$gIdentitySelectColumnValueOf(name);
}

class GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns
    extends EnumClass {
  const GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns._(
      String name)
      : super(name);

  static const GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns
      isMember =
      _$gIdentitySelectColumnIdentityAggregateBoolExpBoolAndArgumentsColumnsisMember;

  static Serializer<
          GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns>
      get serializer =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolAndArgumentsColumnsSerializer;

  static BuiltSet<
          GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns>
      get values =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolAndArgumentsColumnsValues;

  static GIdentitySelectColumnIdentityAggregateBoolExpBool_andArgumentsColumns
      valueOf(String name) =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolAndArgumentsColumnsValueOf(
              name);
}

class GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns
    extends EnumClass {
  const GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns._(
      String name)
      : super(name);

  static const GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns
      isMember =
      _$gIdentitySelectColumnIdentityAggregateBoolExpBoolOrArgumentsColumnsisMember;

  static Serializer<
          GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns>
      get serializer =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolOrArgumentsColumnsSerializer;

  static BuiltSet<
          GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns>
      get values =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolOrArgumentsColumnsValues;

  static GIdentitySelectColumnIdentityAggregateBoolExpBool_orArgumentsColumns
      valueOf(String name) =>
          _$gIdentitySelectColumnIdentityAggregateBoolExpBoolOrArgumentsColumnsValueOf(
              name);
}

abstract class GIdentityStddevOrderBy
    implements Built<GIdentityStddevOrderBy, GIdentityStddevOrderByBuilder> {
  GIdentityStddevOrderBy._();

  factory GIdentityStddevOrderBy(
          [void Function(GIdentityStddevOrderByBuilder b) updates]) =
      _$GIdentityStddevOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityStddevOrderBy> get serializer =>
      _$gIdentityStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityStddevOrderBy.serializer,
        json,
      );
}

abstract class GIdentityStddevPopOrderBy
    implements
        Built<GIdentityStddevPopOrderBy, GIdentityStddevPopOrderByBuilder> {
  GIdentityStddevPopOrderBy._();

  factory GIdentityStddevPopOrderBy(
          [void Function(GIdentityStddevPopOrderByBuilder b) updates]) =
      _$GIdentityStddevPopOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityStddevPopOrderBy> get serializer =>
      _$gIdentityStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GIdentityStddevSampOrderBy
    implements
        Built<GIdentityStddevSampOrderBy, GIdentityStddevSampOrderByBuilder> {
  GIdentityStddevSampOrderBy._();

  factory GIdentityStddevSampOrderBy(
          [void Function(GIdentityStddevSampOrderByBuilder b) updates]) =
      _$GIdentityStddevSampOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityStddevSampOrderBy> get serializer =>
      _$gIdentityStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GIdentityStreamCursorInput
    implements
        Built<GIdentityStreamCursorInput, GIdentityStreamCursorInputBuilder> {
  GIdentityStreamCursorInput._();

  factory GIdentityStreamCursorInput(
          [void Function(GIdentityStreamCursorInputBuilder b) updates]) =
      _$GIdentityStreamCursorInput;

  GIdentityStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GIdentityStreamCursorInput> get serializer =>
      _$gIdentityStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityStreamCursorInput.serializer,
        json,
      );
}

abstract class GIdentityStreamCursorValueInput
    implements
        Built<GIdentityStreamCursorValueInput,
            GIdentityStreamCursorValueInputBuilder> {
  GIdentityStreamCursorValueInput._();

  factory GIdentityStreamCursorValueInput(
          [void Function(GIdentityStreamCursorValueInputBuilder b) updates]) =
      _$GIdentityStreamCursorValueInput;

  String? get accountId;
  String? get accountRemovedId;
  String? get createdInId;
  int? get createdOn;
  int? get expireOn;
  int? get firstEligibleUd;
  String? get id;
  int? get index;
  bool? get isMember;
  int? get lastChangeOn;
  String? get name;
  String? get status;
  static Serializer<GIdentityStreamCursorValueInput> get serializer =>
      _$gIdentityStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GIdentitySumOrderBy
    implements Built<GIdentitySumOrderBy, GIdentitySumOrderByBuilder> {
  GIdentitySumOrderBy._();

  factory GIdentitySumOrderBy(
          [void Function(GIdentitySumOrderByBuilder b) updates]) =
      _$GIdentitySumOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentitySumOrderBy> get serializer =>
      _$gIdentitySumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitySumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitySumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitySumOrderBy.serializer,
        json,
      );
}

abstract class GIdentityVarianceOrderBy
    implements
        Built<GIdentityVarianceOrderBy, GIdentityVarianceOrderByBuilder> {
  GIdentityVarianceOrderBy._();

  factory GIdentityVarianceOrderBy(
          [void Function(GIdentityVarianceOrderByBuilder b) updates]) =
      _$GIdentityVarianceOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityVarianceOrderBy> get serializer =>
      _$gIdentityVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityVarianceOrderBy.serializer,
        json,
      );
}

abstract class GIdentityVarPopOrderBy
    implements Built<GIdentityVarPopOrderBy, GIdentityVarPopOrderByBuilder> {
  GIdentityVarPopOrderBy._();

  factory GIdentityVarPopOrderBy(
          [void Function(GIdentityVarPopOrderByBuilder b) updates]) =
      _$GIdentityVarPopOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityVarPopOrderBy> get serializer =>
      _$gIdentityVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityVarPopOrderBy.serializer,
        json,
      );
}

abstract class GIdentityVarSampOrderBy
    implements Built<GIdentityVarSampOrderBy, GIdentityVarSampOrderByBuilder> {
  GIdentityVarSampOrderBy._();

  factory GIdentityVarSampOrderBy(
          [void Function(GIdentityVarSampOrderByBuilder b) updates]) =
      _$GIdentityVarSampOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get expireOn;
  GOrderBy? get firstEligibleUd;
  GOrderBy? get index;
  GOrderBy? get lastChangeOn;
  static Serializer<GIdentityVarSampOrderBy> get serializer =>
      _$gIdentityVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityVarSampOrderBy.serializer,
        json,
      );
}

abstract class GIntArrayComparisonExp
    implements Built<GIntArrayComparisonExp, GIntArrayComparisonExpBuilder> {
  GIntArrayComparisonExp._();

  factory GIntArrayComparisonExp(
          [void Function(GIntArrayComparisonExpBuilder b) updates]) =
      _$GIntArrayComparisonExp;

  @BuiltValueField(wireName: '_containedIn')
  BuiltList<int>? get G_containedIn;
  @BuiltValueField(wireName: '_contains')
  BuiltList<int>? get G_contains;
  @BuiltValueField(wireName: '_eq')
  BuiltList<int>? get G_eq;
  @BuiltValueField(wireName: '_gt')
  BuiltList<int>? get G_gt;
  @BuiltValueField(wireName: '_gte')
  BuiltList<int>? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<BuiltList<int>>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  BuiltList<int>? get G_lt;
  @BuiltValueField(wireName: '_lte')
  BuiltList<int>? get G_lte;
  @BuiltValueField(wireName: '_neq')
  BuiltList<int>? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<BuiltList<int>>? get G_nin;
  static Serializer<GIntArrayComparisonExp> get serializer =>
      _$gIntArrayComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIntArrayComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIntArrayComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIntArrayComparisonExp.serializer,
        json,
      );
}

abstract class GIntComparisonExp
    implements Built<GIntComparisonExp, GIntComparisonExpBuilder> {
  GIntComparisonExp._();

  factory GIntComparisonExp(
          [void Function(GIntComparisonExpBuilder b) updates]) =
      _$GIntComparisonExp;

  @BuiltValueField(wireName: '_eq')
  int? get G_eq;
  @BuiltValueField(wireName: '_gt')
  int? get G_gt;
  @BuiltValueField(wireName: '_gte')
  int? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<int>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  int? get G_lt;
  @BuiltValueField(wireName: '_lte')
  int? get G_lte;
  @BuiltValueField(wireName: '_neq')
  int? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<int>? get G_nin;
  static Serializer<GIntComparisonExp> get serializer =>
      _$gIntComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIntComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIntComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIntComparisonExp.serializer,
        json,
      );
}

abstract class GItemsCounterBoolExp
    implements Built<GItemsCounterBoolExp, GItemsCounterBoolExpBuilder> {
  GItemsCounterBoolExp._();

  factory GItemsCounterBoolExp(
          [void Function(GItemsCounterBoolExpBuilder b) updates]) =
      _$GItemsCounterBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GItemsCounterBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GItemsCounterBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GItemsCounterBoolExp>? get G_or;
  GStringComparisonExp? get id;
  GStringComparisonExp? get level;
  GIntComparisonExp? get total;
  GStringComparisonExp? get type;
  static Serializer<GItemsCounterBoolExp> get serializer =>
      _$gItemsCounterBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterBoolExp.serializer,
        json,
      );
}

abstract class GItemsCounterOrderBy
    implements Built<GItemsCounterOrderBy, GItemsCounterOrderByBuilder> {
  GItemsCounterOrderBy._();

  factory GItemsCounterOrderBy(
          [void Function(GItemsCounterOrderByBuilder b) updates]) =
      _$GItemsCounterOrderBy;

  GOrderBy? get id;
  GOrderBy? get level;
  GOrderBy? get total;
  GOrderBy? get type;
  static Serializer<GItemsCounterOrderBy> get serializer =>
      _$gItemsCounterOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterOrderBy.serializer,
        json,
      );
}

class GItemsCounterSelectColumn extends EnumClass {
  const GItemsCounterSelectColumn._(String name) : super(name);

  static const GItemsCounterSelectColumn id = _$gItemsCounterSelectColumnid;

  static const GItemsCounterSelectColumn level =
      _$gItemsCounterSelectColumnlevel;

  static const GItemsCounterSelectColumn total =
      _$gItemsCounterSelectColumntotal;

  static const GItemsCounterSelectColumn type = _$gItemsCounterSelectColumntype;

  static Serializer<GItemsCounterSelectColumn> get serializer =>
      _$gItemsCounterSelectColumnSerializer;

  static BuiltSet<GItemsCounterSelectColumn> get values =>
      _$gItemsCounterSelectColumnValues;

  static GItemsCounterSelectColumn valueOf(String name) =>
      _$gItemsCounterSelectColumnValueOf(name);
}

abstract class GItemsCounterStreamCursorInput
    implements
        Built<GItemsCounterStreamCursorInput,
            GItemsCounterStreamCursorInputBuilder> {
  GItemsCounterStreamCursorInput._();

  factory GItemsCounterStreamCursorInput(
          [void Function(GItemsCounterStreamCursorInputBuilder b) updates]) =
      _$GItemsCounterStreamCursorInput;

  GItemsCounterStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GItemsCounterStreamCursorInput> get serializer =>
      _$gItemsCounterStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterStreamCursorInput.serializer,
        json,
      );
}

abstract class GItemsCounterStreamCursorValueInput
    implements
        Built<GItemsCounterStreamCursorValueInput,
            GItemsCounterStreamCursorValueInputBuilder> {
  GItemsCounterStreamCursorValueInput._();

  factory GItemsCounterStreamCursorValueInput(
      [void Function(GItemsCounterStreamCursorValueInputBuilder b)
          updates]) = _$GItemsCounterStreamCursorValueInput;

  String? get id;
  String? get level;
  int? get total;
  String? get type;
  static Serializer<GItemsCounterStreamCursorValueInput> get serializer =>
      _$gItemsCounterStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GJsonbCastExp
    implements Built<GJsonbCastExp, GJsonbCastExpBuilder> {
  GJsonbCastExp._();

  factory GJsonbCastExp([void Function(GJsonbCastExpBuilder b) updates]) =
      _$GJsonbCastExp;

  @BuiltValueField(wireName: 'String')
  GStringComparisonExp? get GString;
  static Serializer<GJsonbCastExp> get serializer => _$gJsonbCastExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GJsonbCastExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GJsonbCastExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GJsonbCastExp.serializer,
        json,
      );
}

abstract class GJsonbComparisonExp
    implements Built<GJsonbComparisonExp, GJsonbComparisonExpBuilder> {
  GJsonbComparisonExp._();

  factory GJsonbComparisonExp(
          [void Function(GJsonbComparisonExpBuilder b) updates]) =
      _$GJsonbComparisonExp;

  @BuiltValueField(wireName: '_cast')
  GJsonbCastExp? get G_cast;
  @BuiltValueField(wireName: '_containedIn')
  _i3.JsonObject? get G_containedIn;
  @BuiltValueField(wireName: '_contains')
  _i3.JsonObject? get G_contains;
  @BuiltValueField(wireName: '_eq')
  _i3.JsonObject? get G_eq;
  @BuiltValueField(wireName: '_gt')
  _i3.JsonObject? get G_gt;
  @BuiltValueField(wireName: '_gte')
  _i3.JsonObject? get G_gte;
  @BuiltValueField(wireName: '_hasKey')
  String? get G_hasKey;
  @BuiltValueField(wireName: '_hasKeysAll')
  BuiltList<String>? get G_hasKeysAll;
  @BuiltValueField(wireName: '_hasKeysAny')
  BuiltList<String>? get G_hasKeysAny;
  @BuiltValueField(wireName: '_in')
  BuiltList<_i3.JsonObject>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  _i3.JsonObject? get G_lt;
  @BuiltValueField(wireName: '_lte')
  _i3.JsonObject? get G_lte;
  @BuiltValueField(wireName: '_neq')
  _i3.JsonObject? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<_i3.JsonObject>? get G_nin;
  static Serializer<GJsonbComparisonExp> get serializer =>
      _$gJsonbComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GJsonbComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GJsonbComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GJsonbComparisonExp.serializer,
        json,
      );
}

abstract class GMembershipEventAggregateBoolExp
    implements
        Built<GMembershipEventAggregateBoolExp,
            GMembershipEventAggregateBoolExpBuilder> {
  GMembershipEventAggregateBoolExp._();

  factory GMembershipEventAggregateBoolExp(
          [void Function(GMembershipEventAggregateBoolExpBuilder b) updates]) =
      _$GMembershipEventAggregateBoolExp;

  GmembershipEventAggregateBoolExpCount? get count;
  static Serializer<GMembershipEventAggregateBoolExp> get serializer =>
      _$gMembershipEventAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventAggregateBoolExp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventAggregateBoolExp.serializer,
        json,
      );
}

abstract class GmembershipEventAggregateBoolExpCount
    implements
        Built<GmembershipEventAggregateBoolExpCount,
            GmembershipEventAggregateBoolExpCountBuilder> {
  GmembershipEventAggregateBoolExpCount._();

  factory GmembershipEventAggregateBoolExpCount(
      [void Function(GmembershipEventAggregateBoolExpCountBuilder b)
          updates]) = _$GmembershipEventAggregateBoolExpCount;

  BuiltList<GMembershipEventSelectColumn>? get arguments;
  bool? get distinct;
  GMembershipEventBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GmembershipEventAggregateBoolExpCount> get serializer =>
      _$gmembershipEventAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GmembershipEventAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GmembershipEventAggregateBoolExpCount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GmembershipEventAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GMembershipEventAggregateOrderBy
    implements
        Built<GMembershipEventAggregateOrderBy,
            GMembershipEventAggregateOrderByBuilder> {
  GMembershipEventAggregateOrderBy._();

  factory GMembershipEventAggregateOrderBy(
          [void Function(GMembershipEventAggregateOrderByBuilder b) updates]) =
      _$GMembershipEventAggregateOrderBy;

  GMembershipEventAvgOrderBy? get avg;
  GOrderBy? get count;
  GMembershipEventMaxOrderBy? get max;
  GMembershipEventMinOrderBy? get min;
  GMembershipEventStddevOrderBy? get stddev;
  GMembershipEventStddevPopOrderBy? get stddevPop;
  GMembershipEventStddevSampOrderBy? get stddevSamp;
  GMembershipEventSumOrderBy? get sum;
  GMembershipEventVarPopOrderBy? get varPop;
  GMembershipEventVarSampOrderBy? get varSamp;
  GMembershipEventVarianceOrderBy? get variance;
  static Serializer<GMembershipEventAggregateOrderBy> get serializer =>
      _$gMembershipEventAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventAggregateOrderBy? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventAggregateOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventAvgOrderBy
    implements
        Built<GMembershipEventAvgOrderBy, GMembershipEventAvgOrderByBuilder> {
  GMembershipEventAvgOrderBy._();

  factory GMembershipEventAvgOrderBy(
          [void Function(GMembershipEventAvgOrderByBuilder b) updates]) =
      _$GMembershipEventAvgOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventAvgOrderBy> get serializer =>
      _$gMembershipEventAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventAvgOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventBoolExp
    implements Built<GMembershipEventBoolExp, GMembershipEventBoolExpBuilder> {
  GMembershipEventBoolExp._();

  factory GMembershipEventBoolExp(
          [void Function(GMembershipEventBoolExpBuilder b) updates]) =
      _$GMembershipEventBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GMembershipEventBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GMembershipEventBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GMembershipEventBoolExp>? get G_or;
  GIntComparisonExp? get blockNumber;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get eventType;
  GStringComparisonExp? get id;
  GIdentityBoolExp? get identity;
  GStringComparisonExp? get identityId;
  static Serializer<GMembershipEventBoolExp> get serializer =>
      _$gMembershipEventBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventBoolExp.serializer,
        json,
      );
}

abstract class GMembershipEventMaxOrderBy
    implements
        Built<GMembershipEventMaxOrderBy, GMembershipEventMaxOrderByBuilder> {
  GMembershipEventMaxOrderBy._();

  factory GMembershipEventMaxOrderBy(
          [void Function(GMembershipEventMaxOrderByBuilder b) updates]) =
      _$GMembershipEventMaxOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GOrderBy? get identityId;
  static Serializer<GMembershipEventMaxOrderBy> get serializer =>
      _$gMembershipEventMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventMaxOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventMinOrderBy
    implements
        Built<GMembershipEventMinOrderBy, GMembershipEventMinOrderByBuilder> {
  GMembershipEventMinOrderBy._();

  factory GMembershipEventMinOrderBy(
          [void Function(GMembershipEventMinOrderByBuilder b) updates]) =
      _$GMembershipEventMinOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GOrderBy? get identityId;
  static Serializer<GMembershipEventMinOrderBy> get serializer =>
      _$gMembershipEventMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventMinOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventOrderBy
    implements Built<GMembershipEventOrderBy, GMembershipEventOrderByBuilder> {
  GMembershipEventOrderBy._();

  factory GMembershipEventOrderBy(
          [void Function(GMembershipEventOrderByBuilder b) updates]) =
      _$GMembershipEventOrderBy;

  GOrderBy? get blockNumber;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GIdentityOrderBy? get identity;
  GOrderBy? get identityId;
  static Serializer<GMembershipEventOrderBy> get serializer =>
      _$gMembershipEventOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventOrderBy.serializer,
        json,
      );
}

class GMembershipEventSelectColumn extends EnumClass {
  const GMembershipEventSelectColumn._(String name) : super(name);

  static const GMembershipEventSelectColumn blockNumber =
      _$gMembershipEventSelectColumnblockNumber;

  static const GMembershipEventSelectColumn eventId =
      _$gMembershipEventSelectColumneventId;

  static const GMembershipEventSelectColumn eventType =
      _$gMembershipEventSelectColumneventType;

  static const GMembershipEventSelectColumn id =
      _$gMembershipEventSelectColumnid;

  static const GMembershipEventSelectColumn identityId =
      _$gMembershipEventSelectColumnidentityId;

  static Serializer<GMembershipEventSelectColumn> get serializer =>
      _$gMembershipEventSelectColumnSerializer;

  static BuiltSet<GMembershipEventSelectColumn> get values =>
      _$gMembershipEventSelectColumnValues;

  static GMembershipEventSelectColumn valueOf(String name) =>
      _$gMembershipEventSelectColumnValueOf(name);
}

abstract class GMembershipEventStddevOrderBy
    implements
        Built<GMembershipEventStddevOrderBy,
            GMembershipEventStddevOrderByBuilder> {
  GMembershipEventStddevOrderBy._();

  factory GMembershipEventStddevOrderBy(
          [void Function(GMembershipEventStddevOrderByBuilder b) updates]) =
      _$GMembershipEventStddevOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventStddevOrderBy> get serializer =>
      _$gMembershipEventStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventStddevOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventStddevPopOrderBy
    implements
        Built<GMembershipEventStddevPopOrderBy,
            GMembershipEventStddevPopOrderByBuilder> {
  GMembershipEventStddevPopOrderBy._();

  factory GMembershipEventStddevPopOrderBy(
          [void Function(GMembershipEventStddevPopOrderByBuilder b) updates]) =
      _$GMembershipEventStddevPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventStddevPopOrderBy> get serializer =>
      _$gMembershipEventStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventStddevPopOrderBy? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventStddevSampOrderBy
    implements
        Built<GMembershipEventStddevSampOrderBy,
            GMembershipEventStddevSampOrderByBuilder> {
  GMembershipEventStddevSampOrderBy._();

  factory GMembershipEventStddevSampOrderBy(
          [void Function(GMembershipEventStddevSampOrderByBuilder b) updates]) =
      _$GMembershipEventStddevSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventStddevSampOrderBy> get serializer =>
      _$gMembershipEventStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventStddevSampOrderBy? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventStreamCursorInput
    implements
        Built<GMembershipEventStreamCursorInput,
            GMembershipEventStreamCursorInputBuilder> {
  GMembershipEventStreamCursorInput._();

  factory GMembershipEventStreamCursorInput(
          [void Function(GMembershipEventStreamCursorInputBuilder b) updates]) =
      _$GMembershipEventStreamCursorInput;

  GMembershipEventStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GMembershipEventStreamCursorInput> get serializer =>
      _$gMembershipEventStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventStreamCursorInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventStreamCursorInput.serializer,
        json,
      );
}

abstract class GMembershipEventStreamCursorValueInput
    implements
        Built<GMembershipEventStreamCursorValueInput,
            GMembershipEventStreamCursorValueInputBuilder> {
  GMembershipEventStreamCursorValueInput._();

  factory GMembershipEventStreamCursorValueInput(
      [void Function(GMembershipEventStreamCursorValueInputBuilder b)
          updates]) = _$GMembershipEventStreamCursorValueInput;

  int? get blockNumber;
  String? get eventId;
  String? get eventType;
  String? get id;
  String? get identityId;
  static Serializer<GMembershipEventStreamCursorValueInput> get serializer =>
      _$gMembershipEventStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GMembershipEventSumOrderBy
    implements
        Built<GMembershipEventSumOrderBy, GMembershipEventSumOrderByBuilder> {
  GMembershipEventSumOrderBy._();

  factory GMembershipEventSumOrderBy(
          [void Function(GMembershipEventSumOrderByBuilder b) updates]) =
      _$GMembershipEventSumOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventSumOrderBy> get serializer =>
      _$gMembershipEventSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventSumOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventVarianceOrderBy
    implements
        Built<GMembershipEventVarianceOrderBy,
            GMembershipEventVarianceOrderByBuilder> {
  GMembershipEventVarianceOrderBy._();

  factory GMembershipEventVarianceOrderBy(
          [void Function(GMembershipEventVarianceOrderByBuilder b) updates]) =
      _$GMembershipEventVarianceOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventVarianceOrderBy> get serializer =>
      _$gMembershipEventVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventVarianceOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventVarPopOrderBy
    implements
        Built<GMembershipEventVarPopOrderBy,
            GMembershipEventVarPopOrderByBuilder> {
  GMembershipEventVarPopOrderBy._();

  factory GMembershipEventVarPopOrderBy(
          [void Function(GMembershipEventVarPopOrderByBuilder b) updates]) =
      _$GMembershipEventVarPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventVarPopOrderBy> get serializer =>
      _$gMembershipEventVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventVarPopOrderBy.serializer,
        json,
      );
}

abstract class GMembershipEventVarSampOrderBy
    implements
        Built<GMembershipEventVarSampOrderBy,
            GMembershipEventVarSampOrderByBuilder> {
  GMembershipEventVarSampOrderBy._();

  factory GMembershipEventVarSampOrderBy(
          [void Function(GMembershipEventVarSampOrderByBuilder b) updates]) =
      _$GMembershipEventVarSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GMembershipEventVarSampOrderBy> get serializer =>
      _$gMembershipEventVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventVarSampOrderBy.serializer,
        json,
      );
}

abstract class GNumericComparisonExp
    implements Built<GNumericComparisonExp, GNumericComparisonExpBuilder> {
  GNumericComparisonExp._();

  factory GNumericComparisonExp(
          [void Function(GNumericComparisonExpBuilder b) updates]) =
      _$GNumericComparisonExp;

  @BuiltValueField(wireName: '_eq')
  int? get G_eq;
  @BuiltValueField(wireName: '_gt')
  int? get G_gt;
  @BuiltValueField(wireName: '_gte')
  int? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<int>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  int? get G_lt;
  @BuiltValueField(wireName: '_lte')
  int? get G_lte;
  @BuiltValueField(wireName: '_neq')
  int? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<int>? get G_nin;
  static Serializer<GNumericComparisonExp> get serializer =>
      _$gNumericComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNumericComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNumericComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNumericComparisonExp.serializer,
        json,
      );
}

class GOrderBy extends EnumClass {
  const GOrderBy._(String name) : super(name);

  static const GOrderBy ASC = _$gOrderByASC;

  static const GOrderBy ASC_NULLS_FIRST = _$gOrderByASC_NULLS_FIRST;

  static const GOrderBy ASC_NULLS_LAST = _$gOrderByASC_NULLS_LAST;

  static const GOrderBy DESC = _$gOrderByDESC;

  static const GOrderBy DESC_NULLS_FIRST = _$gOrderByDESC_NULLS_FIRST;

  static const GOrderBy DESC_NULLS_LAST = _$gOrderByDESC_NULLS_LAST;

  static Serializer<GOrderBy> get serializer => _$gOrderBySerializer;

  static BuiltSet<GOrderBy> get values => _$gOrderByValues;

  static GOrderBy valueOf(String name) => _$gOrderByValueOf(name);
}

abstract class GPopulationHistoryBoolExp
    implements
        Built<GPopulationHistoryBoolExp, GPopulationHistoryBoolExpBuilder> {
  GPopulationHistoryBoolExp._();

  factory GPopulationHistoryBoolExp(
          [void Function(GPopulationHistoryBoolExpBuilder b) updates]) =
      _$GPopulationHistoryBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GPopulationHistoryBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GPopulationHistoryBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GPopulationHistoryBoolExp>? get G_or;
  GIntComparisonExp? get activeAccountCount;
  GIntComparisonExp? get blockNumber;
  GStringComparisonExp? get id;
  GIntComparisonExp? get memberCount;
  GIntComparisonExp? get smithCount;
  static Serializer<GPopulationHistoryBoolExp> get serializer =>
      _$gPopulationHistoryBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryBoolExp.serializer,
        json,
      );
}

abstract class GPopulationHistoryOrderBy
    implements
        Built<GPopulationHistoryOrderBy, GPopulationHistoryOrderByBuilder> {
  GPopulationHistoryOrderBy._();

  factory GPopulationHistoryOrderBy(
          [void Function(GPopulationHistoryOrderByBuilder b) updates]) =
      _$GPopulationHistoryOrderBy;

  GOrderBy? get activeAccountCount;
  GOrderBy? get blockNumber;
  GOrderBy? get id;
  GOrderBy? get memberCount;
  GOrderBy? get smithCount;
  static Serializer<GPopulationHistoryOrderBy> get serializer =>
      _$gPopulationHistoryOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryOrderBy.serializer,
        json,
      );
}

class GPopulationHistorySelectColumn extends EnumClass {
  const GPopulationHistorySelectColumn._(String name) : super(name);

  static const GPopulationHistorySelectColumn activeAccountCount =
      _$gPopulationHistorySelectColumnactiveAccountCount;

  static const GPopulationHistorySelectColumn blockNumber =
      _$gPopulationHistorySelectColumnblockNumber;

  static const GPopulationHistorySelectColumn id =
      _$gPopulationHistorySelectColumnid;

  static const GPopulationHistorySelectColumn memberCount =
      _$gPopulationHistorySelectColumnmemberCount;

  static const GPopulationHistorySelectColumn smithCount =
      _$gPopulationHistorySelectColumnsmithCount;

  static Serializer<GPopulationHistorySelectColumn> get serializer =>
      _$gPopulationHistorySelectColumnSerializer;

  static BuiltSet<GPopulationHistorySelectColumn> get values =>
      _$gPopulationHistorySelectColumnValues;

  static GPopulationHistorySelectColumn valueOf(String name) =>
      _$gPopulationHistorySelectColumnValueOf(name);
}

abstract class GPopulationHistoryStreamCursorInput
    implements
        Built<GPopulationHistoryStreamCursorInput,
            GPopulationHistoryStreamCursorInputBuilder> {
  GPopulationHistoryStreamCursorInput._();

  factory GPopulationHistoryStreamCursorInput(
      [void Function(GPopulationHistoryStreamCursorInputBuilder b)
          updates]) = _$GPopulationHistoryStreamCursorInput;

  GPopulationHistoryStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GPopulationHistoryStreamCursorInput> get serializer =>
      _$gPopulationHistoryStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryStreamCursorInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryStreamCursorInput.serializer,
        json,
      );
}

abstract class GPopulationHistoryStreamCursorValueInput
    implements
        Built<GPopulationHistoryStreamCursorValueInput,
            GPopulationHistoryStreamCursorValueInputBuilder> {
  GPopulationHistoryStreamCursorValueInput._();

  factory GPopulationHistoryStreamCursorValueInput(
      [void Function(GPopulationHistoryStreamCursorValueInputBuilder b)
          updates]) = _$GPopulationHistoryStreamCursorValueInput;

  int? get activeAccountCount;
  int? get blockNumber;
  String? get id;
  int? get memberCount;
  int? get smithCount;
  static Serializer<GPopulationHistoryStreamCursorValueInput> get serializer =>
      _$gPopulationHistoryStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GSmithBoolExp
    implements Built<GSmithBoolExp, GSmithBoolExpBuilder> {
  GSmithBoolExp._();

  factory GSmithBoolExp([void Function(GSmithBoolExpBuilder b) updates]) =
      _$GSmithBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GSmithBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GSmithBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GSmithBoolExp>? get G_or;
  GIntComparisonExp? get forged;
  GStringComparisonExp? get id;
  GIdentityBoolExp? get identity;
  GStringComparisonExp? get identityId;
  GIntComparisonExp? get index;
  GIntComparisonExp? get lastChanged;
  GIntComparisonExp? get lastForged;
  GSmithCertBoolExp? get smithCertIssued;
  GSmithCertAggregateBoolExp? get smithCertIssuedAggregate;
  GSmithCertBoolExp? get smithCertReceived;
  GSmithCertAggregateBoolExp? get smithCertReceivedAggregate;
  GSmithEventBoolExp? get smithHistory;
  GSmithEventAggregateBoolExp? get smithHistoryAggregate;
  GStringComparisonExp? get smithStatus;
  static Serializer<GSmithBoolExp> get serializer => _$gSmithBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithBoolExp.serializer,
        json,
      );
}

abstract class GSmithCertAggregateBoolExp
    implements
        Built<GSmithCertAggregateBoolExp, GSmithCertAggregateBoolExpBuilder> {
  GSmithCertAggregateBoolExp._();

  factory GSmithCertAggregateBoolExp(
          [void Function(GSmithCertAggregateBoolExpBuilder b) updates]) =
      _$GSmithCertAggregateBoolExp;

  GsmithCertAggregateBoolExpCount? get count;
  static Serializer<GSmithCertAggregateBoolExp> get serializer =>
      _$gSmithCertAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertAggregateBoolExp.serializer,
        json,
      );
}

abstract class GsmithCertAggregateBoolExpCount
    implements
        Built<GsmithCertAggregateBoolExpCount,
            GsmithCertAggregateBoolExpCountBuilder> {
  GsmithCertAggregateBoolExpCount._();

  factory GsmithCertAggregateBoolExpCount(
          [void Function(GsmithCertAggregateBoolExpCountBuilder b) updates]) =
      _$GsmithCertAggregateBoolExpCount;

  BuiltList<GSmithCertSelectColumn>? get arguments;
  bool? get distinct;
  GSmithCertBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GsmithCertAggregateBoolExpCount> get serializer =>
      _$gsmithCertAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GsmithCertAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsmithCertAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GsmithCertAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GSmithCertAggregateOrderBy
    implements
        Built<GSmithCertAggregateOrderBy, GSmithCertAggregateOrderByBuilder> {
  GSmithCertAggregateOrderBy._();

  factory GSmithCertAggregateOrderBy(
          [void Function(GSmithCertAggregateOrderByBuilder b) updates]) =
      _$GSmithCertAggregateOrderBy;

  GSmithCertAvgOrderBy? get avg;
  GOrderBy? get count;
  GSmithCertMaxOrderBy? get max;
  GSmithCertMinOrderBy? get min;
  GSmithCertStddevOrderBy? get stddev;
  GSmithCertStddevPopOrderBy? get stddevPop;
  GSmithCertStddevSampOrderBy? get stddevSamp;
  GSmithCertSumOrderBy? get sum;
  GSmithCertVarPopOrderBy? get varPop;
  GSmithCertVarSampOrderBy? get varSamp;
  GSmithCertVarianceOrderBy? get variance;
  static Serializer<GSmithCertAggregateOrderBy> get serializer =>
      _$gSmithCertAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertAggregateOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertAvgOrderBy
    implements Built<GSmithCertAvgOrderBy, GSmithCertAvgOrderByBuilder> {
  GSmithCertAvgOrderBy._();

  factory GSmithCertAvgOrderBy(
          [void Function(GSmithCertAvgOrderByBuilder b) updates]) =
      _$GSmithCertAvgOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertAvgOrderBy> get serializer =>
      _$gSmithCertAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertAvgOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertBoolExp
    implements Built<GSmithCertBoolExp, GSmithCertBoolExpBuilder> {
  GSmithCertBoolExp._();

  factory GSmithCertBoolExp(
          [void Function(GSmithCertBoolExpBuilder b) updates]) =
      _$GSmithCertBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GSmithCertBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GSmithCertBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GSmithCertBoolExp>? get G_or;
  GIntComparisonExp? get createdOn;
  GStringComparisonExp? get id;
  GSmithBoolExp? get issuer;
  GStringComparisonExp? get issuerId;
  GSmithBoolExp? get receiver;
  GStringComparisonExp? get receiverId;
  static Serializer<GSmithCertBoolExp> get serializer =>
      _$gSmithCertBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertBoolExp.serializer,
        json,
      );
}

abstract class GSmithCertMaxOrderBy
    implements Built<GSmithCertMaxOrderBy, GSmithCertMaxOrderByBuilder> {
  GSmithCertMaxOrderBy._();

  factory GSmithCertMaxOrderBy(
          [void Function(GSmithCertMaxOrderByBuilder b) updates]) =
      _$GSmithCertMaxOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get id;
  GOrderBy? get issuerId;
  GOrderBy? get receiverId;
  static Serializer<GSmithCertMaxOrderBy> get serializer =>
      _$gSmithCertMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertMaxOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertMinOrderBy
    implements Built<GSmithCertMinOrderBy, GSmithCertMinOrderByBuilder> {
  GSmithCertMinOrderBy._();

  factory GSmithCertMinOrderBy(
          [void Function(GSmithCertMinOrderByBuilder b) updates]) =
      _$GSmithCertMinOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get id;
  GOrderBy? get issuerId;
  GOrderBy? get receiverId;
  static Serializer<GSmithCertMinOrderBy> get serializer =>
      _$gSmithCertMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertMinOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertOrderBy
    implements Built<GSmithCertOrderBy, GSmithCertOrderByBuilder> {
  GSmithCertOrderBy._();

  factory GSmithCertOrderBy(
          [void Function(GSmithCertOrderByBuilder b) updates]) =
      _$GSmithCertOrderBy;

  GOrderBy? get createdOn;
  GOrderBy? get id;
  GSmithOrderBy? get issuer;
  GOrderBy? get issuerId;
  GSmithOrderBy? get receiver;
  GOrderBy? get receiverId;
  static Serializer<GSmithCertOrderBy> get serializer =>
      _$gSmithCertOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertOrderBy.serializer,
        json,
      );
}

class GSmithCertSelectColumn extends EnumClass {
  const GSmithCertSelectColumn._(String name) : super(name);

  static const GSmithCertSelectColumn createdOn =
      _$gSmithCertSelectColumncreatedOn;

  static const GSmithCertSelectColumn id = _$gSmithCertSelectColumnid;

  static const GSmithCertSelectColumn issuerId =
      _$gSmithCertSelectColumnissuerId;

  static const GSmithCertSelectColumn receiverId =
      _$gSmithCertSelectColumnreceiverId;

  static Serializer<GSmithCertSelectColumn> get serializer =>
      _$gSmithCertSelectColumnSerializer;

  static BuiltSet<GSmithCertSelectColumn> get values =>
      _$gSmithCertSelectColumnValues;

  static GSmithCertSelectColumn valueOf(String name) =>
      _$gSmithCertSelectColumnValueOf(name);
}

abstract class GSmithCertStddevOrderBy
    implements Built<GSmithCertStddevOrderBy, GSmithCertStddevOrderByBuilder> {
  GSmithCertStddevOrderBy._();

  factory GSmithCertStddevOrderBy(
          [void Function(GSmithCertStddevOrderByBuilder b) updates]) =
      _$GSmithCertStddevOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertStddevOrderBy> get serializer =>
      _$gSmithCertStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertStddevOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertStddevPopOrderBy
    implements
        Built<GSmithCertStddevPopOrderBy, GSmithCertStddevPopOrderByBuilder> {
  GSmithCertStddevPopOrderBy._();

  factory GSmithCertStddevPopOrderBy(
          [void Function(GSmithCertStddevPopOrderByBuilder b) updates]) =
      _$GSmithCertStddevPopOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertStddevPopOrderBy> get serializer =>
      _$gSmithCertStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertStddevSampOrderBy
    implements
        Built<GSmithCertStddevSampOrderBy, GSmithCertStddevSampOrderByBuilder> {
  GSmithCertStddevSampOrderBy._();

  factory GSmithCertStddevSampOrderBy(
          [void Function(GSmithCertStddevSampOrderByBuilder b) updates]) =
      _$GSmithCertStddevSampOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertStddevSampOrderBy> get serializer =>
      _$gSmithCertStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertStreamCursorInput
    implements
        Built<GSmithCertStreamCursorInput, GSmithCertStreamCursorInputBuilder> {
  GSmithCertStreamCursorInput._();

  factory GSmithCertStreamCursorInput(
          [void Function(GSmithCertStreamCursorInputBuilder b) updates]) =
      _$GSmithCertStreamCursorInput;

  GSmithCertStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GSmithCertStreamCursorInput> get serializer =>
      _$gSmithCertStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertStreamCursorInput.serializer,
        json,
      );
}

abstract class GSmithCertStreamCursorValueInput
    implements
        Built<GSmithCertStreamCursorValueInput,
            GSmithCertStreamCursorValueInputBuilder> {
  GSmithCertStreamCursorValueInput._();

  factory GSmithCertStreamCursorValueInput(
          [void Function(GSmithCertStreamCursorValueInputBuilder b) updates]) =
      _$GSmithCertStreamCursorValueInput;

  int? get createdOn;
  String? get id;
  String? get issuerId;
  String? get receiverId;
  static Serializer<GSmithCertStreamCursorValueInput> get serializer =>
      _$gSmithCertStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GSmithCertSumOrderBy
    implements Built<GSmithCertSumOrderBy, GSmithCertSumOrderByBuilder> {
  GSmithCertSumOrderBy._();

  factory GSmithCertSumOrderBy(
          [void Function(GSmithCertSumOrderByBuilder b) updates]) =
      _$GSmithCertSumOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertSumOrderBy> get serializer =>
      _$gSmithCertSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertSumOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertVarianceOrderBy
    implements
        Built<GSmithCertVarianceOrderBy, GSmithCertVarianceOrderByBuilder> {
  GSmithCertVarianceOrderBy._();

  factory GSmithCertVarianceOrderBy(
          [void Function(GSmithCertVarianceOrderByBuilder b) updates]) =
      _$GSmithCertVarianceOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertVarianceOrderBy> get serializer =>
      _$gSmithCertVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertVarianceOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertVarPopOrderBy
    implements Built<GSmithCertVarPopOrderBy, GSmithCertVarPopOrderByBuilder> {
  GSmithCertVarPopOrderBy._();

  factory GSmithCertVarPopOrderBy(
          [void Function(GSmithCertVarPopOrderByBuilder b) updates]) =
      _$GSmithCertVarPopOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertVarPopOrderBy> get serializer =>
      _$gSmithCertVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertVarPopOrderBy.serializer,
        json,
      );
}

abstract class GSmithCertVarSampOrderBy
    implements
        Built<GSmithCertVarSampOrderBy, GSmithCertVarSampOrderByBuilder> {
  GSmithCertVarSampOrderBy._();

  factory GSmithCertVarSampOrderBy(
          [void Function(GSmithCertVarSampOrderByBuilder b) updates]) =
      _$GSmithCertVarSampOrderBy;

  GOrderBy? get createdOn;
  static Serializer<GSmithCertVarSampOrderBy> get serializer =>
      _$gSmithCertVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertVarSampOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventAggregateBoolExp
    implements
        Built<GSmithEventAggregateBoolExp, GSmithEventAggregateBoolExpBuilder> {
  GSmithEventAggregateBoolExp._();

  factory GSmithEventAggregateBoolExp(
          [void Function(GSmithEventAggregateBoolExpBuilder b) updates]) =
      _$GSmithEventAggregateBoolExp;

  GsmithEventAggregateBoolExpCount? get count;
  static Serializer<GSmithEventAggregateBoolExp> get serializer =>
      _$gSmithEventAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventAggregateBoolExp.serializer,
        json,
      );
}

abstract class GsmithEventAggregateBoolExpCount
    implements
        Built<GsmithEventAggregateBoolExpCount,
            GsmithEventAggregateBoolExpCountBuilder> {
  GsmithEventAggregateBoolExpCount._();

  factory GsmithEventAggregateBoolExpCount(
          [void Function(GsmithEventAggregateBoolExpCountBuilder b) updates]) =
      _$GsmithEventAggregateBoolExpCount;

  BuiltList<GSmithEventSelectColumn>? get arguments;
  bool? get distinct;
  GSmithEventBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GsmithEventAggregateBoolExpCount> get serializer =>
      _$gsmithEventAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GsmithEventAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsmithEventAggregateBoolExpCount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GsmithEventAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GSmithEventAggregateOrderBy
    implements
        Built<GSmithEventAggregateOrderBy, GSmithEventAggregateOrderByBuilder> {
  GSmithEventAggregateOrderBy._();

  factory GSmithEventAggregateOrderBy(
          [void Function(GSmithEventAggregateOrderByBuilder b) updates]) =
      _$GSmithEventAggregateOrderBy;

  GSmithEventAvgOrderBy? get avg;
  GOrderBy? get count;
  GSmithEventMaxOrderBy? get max;
  GSmithEventMinOrderBy? get min;
  GSmithEventStddevOrderBy? get stddev;
  GSmithEventStddevPopOrderBy? get stddevPop;
  GSmithEventStddevSampOrderBy? get stddevSamp;
  GSmithEventSumOrderBy? get sum;
  GSmithEventVarPopOrderBy? get varPop;
  GSmithEventVarSampOrderBy? get varSamp;
  GSmithEventVarianceOrderBy? get variance;
  static Serializer<GSmithEventAggregateOrderBy> get serializer =>
      _$gSmithEventAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventAggregateOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventAvgOrderBy
    implements Built<GSmithEventAvgOrderBy, GSmithEventAvgOrderByBuilder> {
  GSmithEventAvgOrderBy._();

  factory GSmithEventAvgOrderBy(
          [void Function(GSmithEventAvgOrderByBuilder b) updates]) =
      _$GSmithEventAvgOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventAvgOrderBy> get serializer =>
      _$gSmithEventAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventAvgOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventBoolExp
    implements Built<GSmithEventBoolExp, GSmithEventBoolExpBuilder> {
  GSmithEventBoolExp._();

  factory GSmithEventBoolExp(
          [void Function(GSmithEventBoolExpBuilder b) updates]) =
      _$GSmithEventBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GSmithEventBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GSmithEventBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GSmithEventBoolExp>? get G_or;
  GIntComparisonExp? get blockNumber;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get eventType;
  GStringComparisonExp? get id;
  GSmithBoolExp? get smith;
  GStringComparisonExp? get smithId;
  static Serializer<GSmithEventBoolExp> get serializer =>
      _$gSmithEventBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventBoolExp.serializer,
        json,
      );
}

abstract class GSmithEventMaxOrderBy
    implements Built<GSmithEventMaxOrderBy, GSmithEventMaxOrderByBuilder> {
  GSmithEventMaxOrderBy._();

  factory GSmithEventMaxOrderBy(
          [void Function(GSmithEventMaxOrderByBuilder b) updates]) =
      _$GSmithEventMaxOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GOrderBy? get smithId;
  static Serializer<GSmithEventMaxOrderBy> get serializer =>
      _$gSmithEventMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventMaxOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventMinOrderBy
    implements Built<GSmithEventMinOrderBy, GSmithEventMinOrderByBuilder> {
  GSmithEventMinOrderBy._();

  factory GSmithEventMinOrderBy(
          [void Function(GSmithEventMinOrderByBuilder b) updates]) =
      _$GSmithEventMinOrderBy;

  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GOrderBy? get smithId;
  static Serializer<GSmithEventMinOrderBy> get serializer =>
      _$gSmithEventMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventMinOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventOrderBy
    implements Built<GSmithEventOrderBy, GSmithEventOrderByBuilder> {
  GSmithEventOrderBy._();

  factory GSmithEventOrderBy(
          [void Function(GSmithEventOrderByBuilder b) updates]) =
      _$GSmithEventOrderBy;

  GOrderBy? get blockNumber;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get eventType;
  GOrderBy? get id;
  GSmithOrderBy? get smith;
  GOrderBy? get smithId;
  static Serializer<GSmithEventOrderBy> get serializer =>
      _$gSmithEventOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventOrderBy.serializer,
        json,
      );
}

class GSmithEventSelectColumn extends EnumClass {
  const GSmithEventSelectColumn._(String name) : super(name);

  static const GSmithEventSelectColumn blockNumber =
      _$gSmithEventSelectColumnblockNumber;

  static const GSmithEventSelectColumn eventId =
      _$gSmithEventSelectColumneventId;

  static const GSmithEventSelectColumn eventType =
      _$gSmithEventSelectColumneventType;

  static const GSmithEventSelectColumn id = _$gSmithEventSelectColumnid;

  static const GSmithEventSelectColumn smithId =
      _$gSmithEventSelectColumnsmithId;

  static Serializer<GSmithEventSelectColumn> get serializer =>
      _$gSmithEventSelectColumnSerializer;

  static BuiltSet<GSmithEventSelectColumn> get values =>
      _$gSmithEventSelectColumnValues;

  static GSmithEventSelectColumn valueOf(String name) =>
      _$gSmithEventSelectColumnValueOf(name);
}

abstract class GSmithEventStddevOrderBy
    implements
        Built<GSmithEventStddevOrderBy, GSmithEventStddevOrderByBuilder> {
  GSmithEventStddevOrderBy._();

  factory GSmithEventStddevOrderBy(
          [void Function(GSmithEventStddevOrderByBuilder b) updates]) =
      _$GSmithEventStddevOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventStddevOrderBy> get serializer =>
      _$gSmithEventStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventStddevOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventStddevPopOrderBy
    implements
        Built<GSmithEventStddevPopOrderBy, GSmithEventStddevPopOrderByBuilder> {
  GSmithEventStddevPopOrderBy._();

  factory GSmithEventStddevPopOrderBy(
          [void Function(GSmithEventStddevPopOrderByBuilder b) updates]) =
      _$GSmithEventStddevPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventStddevPopOrderBy> get serializer =>
      _$gSmithEventStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventStddevSampOrderBy
    implements
        Built<GSmithEventStddevSampOrderBy,
            GSmithEventStddevSampOrderByBuilder> {
  GSmithEventStddevSampOrderBy._();

  factory GSmithEventStddevSampOrderBy(
          [void Function(GSmithEventStddevSampOrderByBuilder b) updates]) =
      _$GSmithEventStddevSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventStddevSampOrderBy> get serializer =>
      _$gSmithEventStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventStreamCursorInput
    implements
        Built<GSmithEventStreamCursorInput,
            GSmithEventStreamCursorInputBuilder> {
  GSmithEventStreamCursorInput._();

  factory GSmithEventStreamCursorInput(
          [void Function(GSmithEventStreamCursorInputBuilder b) updates]) =
      _$GSmithEventStreamCursorInput;

  GSmithEventStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GSmithEventStreamCursorInput> get serializer =>
      _$gSmithEventStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventStreamCursorInput.serializer,
        json,
      );
}

abstract class GSmithEventStreamCursorValueInput
    implements
        Built<GSmithEventStreamCursorValueInput,
            GSmithEventStreamCursorValueInputBuilder> {
  GSmithEventStreamCursorValueInput._();

  factory GSmithEventStreamCursorValueInput(
          [void Function(GSmithEventStreamCursorValueInputBuilder b) updates]) =
      _$GSmithEventStreamCursorValueInput;

  int? get blockNumber;
  String? get eventId;
  String? get eventType;
  String? get id;
  String? get smithId;
  static Serializer<GSmithEventStreamCursorValueInput> get serializer =>
      _$gSmithEventStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GSmithEventSumOrderBy
    implements Built<GSmithEventSumOrderBy, GSmithEventSumOrderByBuilder> {
  GSmithEventSumOrderBy._();

  factory GSmithEventSumOrderBy(
          [void Function(GSmithEventSumOrderByBuilder b) updates]) =
      _$GSmithEventSumOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventSumOrderBy> get serializer =>
      _$gSmithEventSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventSumOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventVarianceOrderBy
    implements
        Built<GSmithEventVarianceOrderBy, GSmithEventVarianceOrderByBuilder> {
  GSmithEventVarianceOrderBy._();

  factory GSmithEventVarianceOrderBy(
          [void Function(GSmithEventVarianceOrderByBuilder b) updates]) =
      _$GSmithEventVarianceOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventVarianceOrderBy> get serializer =>
      _$gSmithEventVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventVarianceOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventVarPopOrderBy
    implements
        Built<GSmithEventVarPopOrderBy, GSmithEventVarPopOrderByBuilder> {
  GSmithEventVarPopOrderBy._();

  factory GSmithEventVarPopOrderBy(
          [void Function(GSmithEventVarPopOrderByBuilder b) updates]) =
      _$GSmithEventVarPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventVarPopOrderBy> get serializer =>
      _$gSmithEventVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventVarPopOrderBy.serializer,
        json,
      );
}

abstract class GSmithEventVarSampOrderBy
    implements
        Built<GSmithEventVarSampOrderBy, GSmithEventVarSampOrderByBuilder> {
  GSmithEventVarSampOrderBy._();

  factory GSmithEventVarSampOrderBy(
          [void Function(GSmithEventVarSampOrderByBuilder b) updates]) =
      _$GSmithEventVarSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GSmithEventVarSampOrderBy> get serializer =>
      _$gSmithEventVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventVarSampOrderBy.serializer,
        json,
      );
}

abstract class GSmithOrderBy
    implements Built<GSmithOrderBy, GSmithOrderByBuilder> {
  GSmithOrderBy._();

  factory GSmithOrderBy([void Function(GSmithOrderByBuilder b) updates]) =
      _$GSmithOrderBy;

  GOrderBy? get forged;
  GOrderBy? get id;
  GIdentityOrderBy? get identity;
  GOrderBy? get identityId;
  GOrderBy? get index;
  GOrderBy? get lastChanged;
  GOrderBy? get lastForged;
  GSmithCertAggregateOrderBy? get smithCertIssuedAggregate;
  GSmithCertAggregateOrderBy? get smithCertReceivedAggregate;
  GSmithEventAggregateOrderBy? get smithHistoryAggregate;
  GOrderBy? get smithStatus;
  static Serializer<GSmithOrderBy> get serializer => _$gSmithOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithOrderBy.serializer,
        json,
      );
}

class GSmithSelectColumn extends EnumClass {
  const GSmithSelectColumn._(String name) : super(name);

  static const GSmithSelectColumn forged = _$gSmithSelectColumnforged;

  static const GSmithSelectColumn id = _$gSmithSelectColumnid;

  static const GSmithSelectColumn identityId = _$gSmithSelectColumnidentityId;

  static const GSmithSelectColumn index = _$gSmithSelectColumnindex;

  static const GSmithSelectColumn lastChanged = _$gSmithSelectColumnlastChanged;

  static const GSmithSelectColumn lastForged = _$gSmithSelectColumnlastForged;

  static const GSmithSelectColumn smithStatus = _$gSmithSelectColumnsmithStatus;

  static Serializer<GSmithSelectColumn> get serializer =>
      _$gSmithSelectColumnSerializer;

  static BuiltSet<GSmithSelectColumn> get values => _$gSmithSelectColumnValues;

  static GSmithSelectColumn valueOf(String name) =>
      _$gSmithSelectColumnValueOf(name);
}

abstract class GSmithStreamCursorInput
    implements Built<GSmithStreamCursorInput, GSmithStreamCursorInputBuilder> {
  GSmithStreamCursorInput._();

  factory GSmithStreamCursorInput(
          [void Function(GSmithStreamCursorInputBuilder b) updates]) =
      _$GSmithStreamCursorInput;

  GSmithStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GSmithStreamCursorInput> get serializer =>
      _$gSmithStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithStreamCursorInput.serializer,
        json,
      );
}

abstract class GSmithStreamCursorValueInput
    implements
        Built<GSmithStreamCursorValueInput,
            GSmithStreamCursorValueInputBuilder> {
  GSmithStreamCursorValueInput._();

  factory GSmithStreamCursorValueInput(
          [void Function(GSmithStreamCursorValueInputBuilder b) updates]) =
      _$GSmithStreamCursorValueInput;

  int? get forged;
  String? get id;
  String? get identityId;
  int? get index;
  int? get lastChanged;
  int? get lastForged;
  String? get smithStatus;
  static Serializer<GSmithStreamCursorValueInput> get serializer =>
      _$gSmithStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GStringArrayComparisonExp
    implements
        Built<GStringArrayComparisonExp, GStringArrayComparisonExpBuilder> {
  GStringArrayComparisonExp._();

  factory GStringArrayComparisonExp(
          [void Function(GStringArrayComparisonExpBuilder b) updates]) =
      _$GStringArrayComparisonExp;

  @BuiltValueField(wireName: '_containedIn')
  BuiltList<String>? get G_containedIn;
  @BuiltValueField(wireName: '_contains')
  BuiltList<String>? get G_contains;
  @BuiltValueField(wireName: '_eq')
  BuiltList<String>? get G_eq;
  @BuiltValueField(wireName: '_gt')
  BuiltList<String>? get G_gt;
  @BuiltValueField(wireName: '_gte')
  BuiltList<String>? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<BuiltList<String>>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  BuiltList<String>? get G_lt;
  @BuiltValueField(wireName: '_lte')
  BuiltList<String>? get G_lte;
  @BuiltValueField(wireName: '_neq')
  BuiltList<String>? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<BuiltList<String>>? get G_nin;
  static Serializer<GStringArrayComparisonExp> get serializer =>
      _$gStringArrayComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GStringArrayComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GStringArrayComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GStringArrayComparisonExp.serializer,
        json,
      );
}

abstract class GStringComparisonExp
    implements Built<GStringComparisonExp, GStringComparisonExpBuilder> {
  GStringComparisonExp._();

  factory GStringComparisonExp(
          [void Function(GStringComparisonExpBuilder b) updates]) =
      _$GStringComparisonExp;

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
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
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
  static Serializer<GStringComparisonExp> get serializer =>
      _$gStringComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GStringComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GStringComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GStringComparisonExp.serializer,
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

abstract class GTimestamptzComparisonExp
    implements
        Built<GTimestamptzComparisonExp, GTimestamptzComparisonExpBuilder> {
  GTimestamptzComparisonExp._();

  factory GTimestamptzComparisonExp(
          [void Function(GTimestamptzComparisonExpBuilder b) updates]) =
      _$GTimestamptzComparisonExp;

  @BuiltValueField(wireName: '_eq')
  Gtimestamptz? get G_eq;
  @BuiltValueField(wireName: '_gt')
  Gtimestamptz? get G_gt;
  @BuiltValueField(wireName: '_gte')
  Gtimestamptz? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gtimestamptz>? get G_in;
  @BuiltValueField(wireName: '_isNull')
  bool? get G_isNull;
  @BuiltValueField(wireName: '_lt')
  Gtimestamptz? get G_lt;
  @BuiltValueField(wireName: '_lte')
  Gtimestamptz? get G_lte;
  @BuiltValueField(wireName: '_neq')
  Gtimestamptz? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gtimestamptz>? get G_nin;
  static Serializer<GTimestamptzComparisonExp> get serializer =>
      _$gTimestamptzComparisonExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTimestamptzComparisonExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTimestamptzComparisonExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTimestamptzComparisonExp.serializer,
        json,
      );
}

abstract class GTransferAggregateBoolExp
    implements
        Built<GTransferAggregateBoolExp, GTransferAggregateBoolExpBuilder> {
  GTransferAggregateBoolExp._();

  factory GTransferAggregateBoolExp(
          [void Function(GTransferAggregateBoolExpBuilder b) updates]) =
      _$GTransferAggregateBoolExp;

  GtransferAggregateBoolExpCount? get count;
  static Serializer<GTransferAggregateBoolExp> get serializer =>
      _$gTransferAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferAggregateBoolExp.serializer,
        json,
      );
}

abstract class GtransferAggregateBoolExpCount
    implements
        Built<GtransferAggregateBoolExpCount,
            GtransferAggregateBoolExpCountBuilder> {
  GtransferAggregateBoolExpCount._();

  factory GtransferAggregateBoolExpCount(
          [void Function(GtransferAggregateBoolExpCountBuilder b) updates]) =
      _$GtransferAggregateBoolExpCount;

  BuiltList<GTransferSelectColumn>? get arguments;
  bool? get distinct;
  GTransferBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GtransferAggregateBoolExpCount> get serializer =>
      _$gtransferAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GtransferAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GtransferAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GtransferAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GTransferAggregateOrderBy
    implements
        Built<GTransferAggregateOrderBy, GTransferAggregateOrderByBuilder> {
  GTransferAggregateOrderBy._();

  factory GTransferAggregateOrderBy(
          [void Function(GTransferAggregateOrderByBuilder b) updates]) =
      _$GTransferAggregateOrderBy;

  GTransferAvgOrderBy? get avg;
  GOrderBy? get count;
  GTransferMaxOrderBy? get max;
  GTransferMinOrderBy? get min;
  GTransferStddevOrderBy? get stddev;
  GTransferStddevPopOrderBy? get stddevPop;
  GTransferStddevSampOrderBy? get stddevSamp;
  GTransferSumOrderBy? get sum;
  GTransferVarPopOrderBy? get varPop;
  GTransferVarSampOrderBy? get varSamp;
  GTransferVarianceOrderBy? get variance;
  static Serializer<GTransferAggregateOrderBy> get serializer =>
      _$gTransferAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferAggregateOrderBy.serializer,
        json,
      );
}

abstract class GTransferAvgOrderBy
    implements Built<GTransferAvgOrderBy, GTransferAvgOrderByBuilder> {
  GTransferAvgOrderBy._();

  factory GTransferAvgOrderBy(
          [void Function(GTransferAvgOrderByBuilder b) updates]) =
      _$GTransferAvgOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferAvgOrderBy> get serializer =>
      _$gTransferAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferAvgOrderBy.serializer,
        json,
      );
}

abstract class GTransferBoolExp
    implements Built<GTransferBoolExp, GTransferBoolExpBuilder> {
  GTransferBoolExp._();

  factory GTransferBoolExp([void Function(GTransferBoolExpBuilder b) updates]) =
      _$GTransferBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GTransferBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GTransferBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GTransferBoolExp>? get G_or;
  GNumericComparisonExp? get amount;
  GIntComparisonExp? get blockNumber;
  GTxCommentBoolExp? get comment;
  GStringComparisonExp? get commentId;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GAccountBoolExp? get from;
  GStringComparisonExp? get fromId;
  GStringComparisonExp? get id;
  GTimestamptzComparisonExp? get timestamp;
  GAccountBoolExp? get to;
  GStringComparisonExp? get toId;
  static Serializer<GTransferBoolExp> get serializer =>
      _$gTransferBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferBoolExp.serializer,
        json,
      );
}

abstract class GTransferMaxOrderBy
    implements Built<GTransferMaxOrderBy, GTransferMaxOrderByBuilder> {
  GTransferMaxOrderBy._();

  factory GTransferMaxOrderBy(
          [void Function(GTransferMaxOrderByBuilder b) updates]) =
      _$GTransferMaxOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  GOrderBy? get commentId;
  GOrderBy? get eventId;
  GOrderBy? get fromId;
  GOrderBy? get id;
  GOrderBy? get timestamp;
  GOrderBy? get toId;
  static Serializer<GTransferMaxOrderBy> get serializer =>
      _$gTransferMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferMaxOrderBy.serializer,
        json,
      );
}

abstract class GTransferMinOrderBy
    implements Built<GTransferMinOrderBy, GTransferMinOrderByBuilder> {
  GTransferMinOrderBy._();

  factory GTransferMinOrderBy(
          [void Function(GTransferMinOrderByBuilder b) updates]) =
      _$GTransferMinOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  GOrderBy? get commentId;
  GOrderBy? get eventId;
  GOrderBy? get fromId;
  GOrderBy? get id;
  GOrderBy? get timestamp;
  GOrderBy? get toId;
  static Serializer<GTransferMinOrderBy> get serializer =>
      _$gTransferMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferMinOrderBy.serializer,
        json,
      );
}

abstract class GTransferOrderBy
    implements Built<GTransferOrderBy, GTransferOrderByBuilder> {
  GTransferOrderBy._();

  factory GTransferOrderBy([void Function(GTransferOrderByBuilder b) updates]) =
      _$GTransferOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  GTxCommentOrderBy? get comment;
  GOrderBy? get commentId;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GAccountOrderBy? get from;
  GOrderBy? get fromId;
  GOrderBy? get id;
  GOrderBy? get timestamp;
  GAccountOrderBy? get to;
  GOrderBy? get toId;
  static Serializer<GTransferOrderBy> get serializer =>
      _$gTransferOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferOrderBy.serializer,
        json,
      );
}

class GTransferSelectColumn extends EnumClass {
  const GTransferSelectColumn._(String name) : super(name);

  static const GTransferSelectColumn amount = _$gTransferSelectColumnamount;

  static const GTransferSelectColumn blockNumber =
      _$gTransferSelectColumnblockNumber;

  static const GTransferSelectColumn commentId =
      _$gTransferSelectColumncommentId;

  static const GTransferSelectColumn eventId = _$gTransferSelectColumneventId;

  static const GTransferSelectColumn fromId = _$gTransferSelectColumnfromId;

  static const GTransferSelectColumn id = _$gTransferSelectColumnid;

  static const GTransferSelectColumn timestamp =
      _$gTransferSelectColumntimestamp;

  static const GTransferSelectColumn toId = _$gTransferSelectColumntoId;

  static Serializer<GTransferSelectColumn> get serializer =>
      _$gTransferSelectColumnSerializer;

  static BuiltSet<GTransferSelectColumn> get values =>
      _$gTransferSelectColumnValues;

  static GTransferSelectColumn valueOf(String name) =>
      _$gTransferSelectColumnValueOf(name);
}

abstract class GTransferStddevOrderBy
    implements Built<GTransferStddevOrderBy, GTransferStddevOrderByBuilder> {
  GTransferStddevOrderBy._();

  factory GTransferStddevOrderBy(
          [void Function(GTransferStddevOrderByBuilder b) updates]) =
      _$GTransferStddevOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferStddevOrderBy> get serializer =>
      _$gTransferStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferStddevOrderBy.serializer,
        json,
      );
}

abstract class GTransferStddevPopOrderBy
    implements
        Built<GTransferStddevPopOrderBy, GTransferStddevPopOrderByBuilder> {
  GTransferStddevPopOrderBy._();

  factory GTransferStddevPopOrderBy(
          [void Function(GTransferStddevPopOrderByBuilder b) updates]) =
      _$GTransferStddevPopOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferStddevPopOrderBy> get serializer =>
      _$gTransferStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GTransferStddevSampOrderBy
    implements
        Built<GTransferStddevSampOrderBy, GTransferStddevSampOrderByBuilder> {
  GTransferStddevSampOrderBy._();

  factory GTransferStddevSampOrderBy(
          [void Function(GTransferStddevSampOrderByBuilder b) updates]) =
      _$GTransferStddevSampOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferStddevSampOrderBy> get serializer =>
      _$gTransferStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GTransferStreamCursorInput
    implements
        Built<GTransferStreamCursorInput, GTransferStreamCursorInputBuilder> {
  GTransferStreamCursorInput._();

  factory GTransferStreamCursorInput(
          [void Function(GTransferStreamCursorInputBuilder b) updates]) =
      _$GTransferStreamCursorInput;

  GTransferStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GTransferStreamCursorInput> get serializer =>
      _$gTransferStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferStreamCursorInput.serializer,
        json,
      );
}

abstract class GTransferStreamCursorValueInput
    implements
        Built<GTransferStreamCursorValueInput,
            GTransferStreamCursorValueInputBuilder> {
  GTransferStreamCursorValueInput._();

  factory GTransferStreamCursorValueInput(
          [void Function(GTransferStreamCursorValueInputBuilder b) updates]) =
      _$GTransferStreamCursorValueInput;

  int? get amount;
  int? get blockNumber;
  String? get commentId;
  String? get eventId;
  String? get fromId;
  String? get id;
  Gtimestamptz? get timestamp;
  String? get toId;
  static Serializer<GTransferStreamCursorValueInput> get serializer =>
      _$gTransferStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GTransferSumOrderBy
    implements Built<GTransferSumOrderBy, GTransferSumOrderByBuilder> {
  GTransferSumOrderBy._();

  factory GTransferSumOrderBy(
          [void Function(GTransferSumOrderByBuilder b) updates]) =
      _$GTransferSumOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferSumOrderBy> get serializer =>
      _$gTransferSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferSumOrderBy.serializer,
        json,
      );
}

abstract class GTransferVarianceOrderBy
    implements
        Built<GTransferVarianceOrderBy, GTransferVarianceOrderByBuilder> {
  GTransferVarianceOrderBy._();

  factory GTransferVarianceOrderBy(
          [void Function(GTransferVarianceOrderByBuilder b) updates]) =
      _$GTransferVarianceOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferVarianceOrderBy> get serializer =>
      _$gTransferVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferVarianceOrderBy.serializer,
        json,
      );
}

abstract class GTransferVarPopOrderBy
    implements Built<GTransferVarPopOrderBy, GTransferVarPopOrderByBuilder> {
  GTransferVarPopOrderBy._();

  factory GTransferVarPopOrderBy(
          [void Function(GTransferVarPopOrderByBuilder b) updates]) =
      _$GTransferVarPopOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferVarPopOrderBy> get serializer =>
      _$gTransferVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferVarPopOrderBy.serializer,
        json,
      );
}

abstract class GTransferVarSampOrderBy
    implements Built<GTransferVarSampOrderBy, GTransferVarSampOrderByBuilder> {
  GTransferVarSampOrderBy._();

  factory GTransferVarSampOrderBy(
          [void Function(GTransferVarSampOrderByBuilder b) updates]) =
      _$GTransferVarSampOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  static Serializer<GTransferVarSampOrderBy> get serializer =>
      _$gTransferVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferVarSampOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentAggregateBoolExp
    implements
        Built<GTxCommentAggregateBoolExp, GTxCommentAggregateBoolExpBuilder> {
  GTxCommentAggregateBoolExp._();

  factory GTxCommentAggregateBoolExp(
          [void Function(GTxCommentAggregateBoolExpBuilder b) updates]) =
      _$GTxCommentAggregateBoolExp;

  GtxCommentAggregateBoolExpCount? get count;
  static Serializer<GTxCommentAggregateBoolExp> get serializer =>
      _$gTxCommentAggregateBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentAggregateBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentAggregateBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentAggregateBoolExp.serializer,
        json,
      );
}

abstract class GtxCommentAggregateBoolExpCount
    implements
        Built<GtxCommentAggregateBoolExpCount,
            GtxCommentAggregateBoolExpCountBuilder> {
  GtxCommentAggregateBoolExpCount._();

  factory GtxCommentAggregateBoolExpCount(
          [void Function(GtxCommentAggregateBoolExpCountBuilder b) updates]) =
      _$GtxCommentAggregateBoolExpCount;

  BuiltList<GTxCommentSelectColumn>? get arguments;
  bool? get distinct;
  GTxCommentBoolExp? get filter;
  GIntComparisonExp get predicate;
  static Serializer<GtxCommentAggregateBoolExpCount> get serializer =>
      _$gtxCommentAggregateBoolExpCountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GtxCommentAggregateBoolExpCount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GtxCommentAggregateBoolExpCount? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GtxCommentAggregateBoolExpCount.serializer,
        json,
      );
}

abstract class GTxCommentAggregateOrderBy
    implements
        Built<GTxCommentAggregateOrderBy, GTxCommentAggregateOrderByBuilder> {
  GTxCommentAggregateOrderBy._();

  factory GTxCommentAggregateOrderBy(
          [void Function(GTxCommentAggregateOrderByBuilder b) updates]) =
      _$GTxCommentAggregateOrderBy;

  GTxCommentAvgOrderBy? get avg;
  GOrderBy? get count;
  GTxCommentMaxOrderBy? get max;
  GTxCommentMinOrderBy? get min;
  GTxCommentStddevOrderBy? get stddev;
  GTxCommentStddevPopOrderBy? get stddevPop;
  GTxCommentStddevSampOrderBy? get stddevSamp;
  GTxCommentSumOrderBy? get sum;
  GTxCommentVarPopOrderBy? get varPop;
  GTxCommentVarSampOrderBy? get varSamp;
  GTxCommentVarianceOrderBy? get variance;
  static Serializer<GTxCommentAggregateOrderBy> get serializer =>
      _$gTxCommentAggregateOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentAggregateOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentAggregateOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentAggregateOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentAvgOrderBy
    implements Built<GTxCommentAvgOrderBy, GTxCommentAvgOrderByBuilder> {
  GTxCommentAvgOrderBy._();

  factory GTxCommentAvgOrderBy(
          [void Function(GTxCommentAvgOrderByBuilder b) updates]) =
      _$GTxCommentAvgOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentAvgOrderBy> get serializer =>
      _$gTxCommentAvgOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentAvgOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentAvgOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentAvgOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentBoolExp
    implements Built<GTxCommentBoolExp, GTxCommentBoolExpBuilder> {
  GTxCommentBoolExp._();

  factory GTxCommentBoolExp(
          [void Function(GTxCommentBoolExpBuilder b) updates]) =
      _$GTxCommentBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GTxCommentBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GTxCommentBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GTxCommentBoolExp>? get G_or;
  GAccountBoolExp? get author;
  GStringComparisonExp? get authorId;
  GIntComparisonExp? get blockNumber;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get hash;
  GStringComparisonExp? get id;
  GStringComparisonExp? get remark;
  GByteaComparisonExp? get remarkBytes;
  GStringComparisonExp? get type;
  static Serializer<GTxCommentBoolExp> get serializer =>
      _$gTxCommentBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentBoolExp.serializer,
        json,
      );
}

abstract class GTxCommentMaxOrderBy
    implements Built<GTxCommentMaxOrderBy, GTxCommentMaxOrderByBuilder> {
  GTxCommentMaxOrderBy._();

  factory GTxCommentMaxOrderBy(
          [void Function(GTxCommentMaxOrderByBuilder b) updates]) =
      _$GTxCommentMaxOrderBy;

  GOrderBy? get authorId;
  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get hash;
  GOrderBy? get id;
  GOrderBy? get remark;
  GOrderBy? get type;
  static Serializer<GTxCommentMaxOrderBy> get serializer =>
      _$gTxCommentMaxOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentMaxOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentMaxOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentMaxOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentMinOrderBy
    implements Built<GTxCommentMinOrderBy, GTxCommentMinOrderByBuilder> {
  GTxCommentMinOrderBy._();

  factory GTxCommentMinOrderBy(
          [void Function(GTxCommentMinOrderByBuilder b) updates]) =
      _$GTxCommentMinOrderBy;

  GOrderBy? get authorId;
  GOrderBy? get blockNumber;
  GOrderBy? get eventId;
  GOrderBy? get hash;
  GOrderBy? get id;
  GOrderBy? get remark;
  GOrderBy? get type;
  static Serializer<GTxCommentMinOrderBy> get serializer =>
      _$gTxCommentMinOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentMinOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentMinOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentMinOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentOrderBy
    implements Built<GTxCommentOrderBy, GTxCommentOrderByBuilder> {
  GTxCommentOrderBy._();

  factory GTxCommentOrderBy(
          [void Function(GTxCommentOrderByBuilder b) updates]) =
      _$GTxCommentOrderBy;

  GAccountOrderBy? get author;
  GOrderBy? get authorId;
  GOrderBy? get blockNumber;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get hash;
  GOrderBy? get id;
  GOrderBy? get remark;
  GOrderBy? get remarkBytes;
  GOrderBy? get type;
  static Serializer<GTxCommentOrderBy> get serializer =>
      _$gTxCommentOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentOrderBy.serializer,
        json,
      );
}

class GTxCommentSelectColumn extends EnumClass {
  const GTxCommentSelectColumn._(String name) : super(name);

  static const GTxCommentSelectColumn authorId =
      _$gTxCommentSelectColumnauthorId;

  static const GTxCommentSelectColumn blockNumber =
      _$gTxCommentSelectColumnblockNumber;

  static const GTxCommentSelectColumn eventId = _$gTxCommentSelectColumneventId;

  static const GTxCommentSelectColumn hash = _$gTxCommentSelectColumnhash;

  static const GTxCommentSelectColumn id = _$gTxCommentSelectColumnid;

  static const GTxCommentSelectColumn remark = _$gTxCommentSelectColumnremark;

  static const GTxCommentSelectColumn remarkBytes =
      _$gTxCommentSelectColumnremarkBytes;

  static const GTxCommentSelectColumn type = _$gTxCommentSelectColumntype;

  static Serializer<GTxCommentSelectColumn> get serializer =>
      _$gTxCommentSelectColumnSerializer;

  static BuiltSet<GTxCommentSelectColumn> get values =>
      _$gTxCommentSelectColumnValues;

  static GTxCommentSelectColumn valueOf(String name) =>
      _$gTxCommentSelectColumnValueOf(name);
}

abstract class GTxCommentStddevOrderBy
    implements Built<GTxCommentStddevOrderBy, GTxCommentStddevOrderByBuilder> {
  GTxCommentStddevOrderBy._();

  factory GTxCommentStddevOrderBy(
          [void Function(GTxCommentStddevOrderByBuilder b) updates]) =
      _$GTxCommentStddevOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentStddevOrderBy> get serializer =>
      _$gTxCommentStddevOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentStddevOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentStddevOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentStddevOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentStddevPopOrderBy
    implements
        Built<GTxCommentStddevPopOrderBy, GTxCommentStddevPopOrderByBuilder> {
  GTxCommentStddevPopOrderBy._();

  factory GTxCommentStddevPopOrderBy(
          [void Function(GTxCommentStddevPopOrderByBuilder b) updates]) =
      _$GTxCommentStddevPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentStddevPopOrderBy> get serializer =>
      _$gTxCommentStddevPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentStddevPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentStddevPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentStddevPopOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentStddevSampOrderBy
    implements
        Built<GTxCommentStddevSampOrderBy, GTxCommentStddevSampOrderByBuilder> {
  GTxCommentStddevSampOrderBy._();

  factory GTxCommentStddevSampOrderBy(
          [void Function(GTxCommentStddevSampOrderByBuilder b) updates]) =
      _$GTxCommentStddevSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentStddevSampOrderBy> get serializer =>
      _$gTxCommentStddevSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentStddevSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentStddevSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentStddevSampOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentStreamCursorInput
    implements
        Built<GTxCommentStreamCursorInput, GTxCommentStreamCursorInputBuilder> {
  GTxCommentStreamCursorInput._();

  factory GTxCommentStreamCursorInput(
          [void Function(GTxCommentStreamCursorInputBuilder b) updates]) =
      _$GTxCommentStreamCursorInput;

  GTxCommentStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GTxCommentStreamCursorInput> get serializer =>
      _$gTxCommentStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentStreamCursorInput.serializer,
        json,
      );
}

abstract class GTxCommentStreamCursorValueInput
    implements
        Built<GTxCommentStreamCursorValueInput,
            GTxCommentStreamCursorValueInputBuilder> {
  GTxCommentStreamCursorValueInput._();

  factory GTxCommentStreamCursorValueInput(
          [void Function(GTxCommentStreamCursorValueInputBuilder b) updates]) =
      _$GTxCommentStreamCursorValueInput;

  String? get authorId;
  int? get blockNumber;
  String? get eventId;
  String? get hash;
  String? get id;
  String? get remark;
  Gbytea? get remarkBytes;
  String? get type;
  static Serializer<GTxCommentStreamCursorValueInput> get serializer =>
      _$gTxCommentStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GTxCommentSumOrderBy
    implements Built<GTxCommentSumOrderBy, GTxCommentSumOrderByBuilder> {
  GTxCommentSumOrderBy._();

  factory GTxCommentSumOrderBy(
          [void Function(GTxCommentSumOrderByBuilder b) updates]) =
      _$GTxCommentSumOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentSumOrderBy> get serializer =>
      _$gTxCommentSumOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentSumOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentSumOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentSumOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentVarianceOrderBy
    implements
        Built<GTxCommentVarianceOrderBy, GTxCommentVarianceOrderByBuilder> {
  GTxCommentVarianceOrderBy._();

  factory GTxCommentVarianceOrderBy(
          [void Function(GTxCommentVarianceOrderByBuilder b) updates]) =
      _$GTxCommentVarianceOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentVarianceOrderBy> get serializer =>
      _$gTxCommentVarianceOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentVarianceOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentVarianceOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentVarianceOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentVarPopOrderBy
    implements Built<GTxCommentVarPopOrderBy, GTxCommentVarPopOrderByBuilder> {
  GTxCommentVarPopOrderBy._();

  factory GTxCommentVarPopOrderBy(
          [void Function(GTxCommentVarPopOrderByBuilder b) updates]) =
      _$GTxCommentVarPopOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentVarPopOrderBy> get serializer =>
      _$gTxCommentVarPopOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentVarPopOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentVarPopOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentVarPopOrderBy.serializer,
        json,
      );
}

abstract class GTxCommentVarSampOrderBy
    implements
        Built<GTxCommentVarSampOrderBy, GTxCommentVarSampOrderByBuilder> {
  GTxCommentVarSampOrderBy._();

  factory GTxCommentVarSampOrderBy(
          [void Function(GTxCommentVarSampOrderByBuilder b) updates]) =
      _$GTxCommentVarSampOrderBy;

  GOrderBy? get blockNumber;
  static Serializer<GTxCommentVarSampOrderBy> get serializer =>
      _$gTxCommentVarSampOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentVarSampOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentVarSampOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentVarSampOrderBy.serializer,
        json,
      );
}

abstract class GUdHistoryBoolExp
    implements Built<GUdHistoryBoolExp, GUdHistoryBoolExpBuilder> {
  GUdHistoryBoolExp._();

  factory GUdHistoryBoolExp(
          [void Function(GUdHistoryBoolExpBuilder b) updates]) =
      _$GUdHistoryBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GUdHistoryBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GUdHistoryBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GUdHistoryBoolExp>? get G_or;
  GNumericComparisonExp? get amount;
  GIntComparisonExp? get blockNumber;
  GStringComparisonExp? get id;
  GIdentityBoolExp? get identity;
  GStringComparisonExp? get identityId;
  GTimestamptzComparisonExp? get timestamp;
  static Serializer<GUdHistoryBoolExp> get serializer =>
      _$gUdHistoryBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryBoolExp.serializer,
        json,
      );
}

abstract class GUdHistoryOrderBy
    implements Built<GUdHistoryOrderBy, GUdHistoryOrderByBuilder> {
  GUdHistoryOrderBy._();

  factory GUdHistoryOrderBy(
          [void Function(GUdHistoryOrderByBuilder b) updates]) =
      _$GUdHistoryOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  GOrderBy? get id;
  GIdentityOrderBy? get identity;
  GOrderBy? get identityId;
  GOrderBy? get timestamp;
  static Serializer<GUdHistoryOrderBy> get serializer =>
      _$gUdHistoryOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryOrderBy.serializer,
        json,
      );
}

class GUdHistorySelectColumn extends EnumClass {
  const GUdHistorySelectColumn._(String name) : super(name);

  static const GUdHistorySelectColumn amount = _$gUdHistorySelectColumnamount;

  static const GUdHistorySelectColumn blockNumber =
      _$gUdHistorySelectColumnblockNumber;

  static const GUdHistorySelectColumn id = _$gUdHistorySelectColumnid;

  static const GUdHistorySelectColumn identityId =
      _$gUdHistorySelectColumnidentityId;

  static const GUdHistorySelectColumn timestamp =
      _$gUdHistorySelectColumntimestamp;

  static Serializer<GUdHistorySelectColumn> get serializer =>
      _$gUdHistorySelectColumnSerializer;

  static BuiltSet<GUdHistorySelectColumn> get values =>
      _$gUdHistorySelectColumnValues;

  static GUdHistorySelectColumn valueOf(String name) =>
      _$gUdHistorySelectColumnValueOf(name);
}

abstract class GUdHistoryStreamCursorInput
    implements
        Built<GUdHistoryStreamCursorInput, GUdHistoryStreamCursorInputBuilder> {
  GUdHistoryStreamCursorInput._();

  factory GUdHistoryStreamCursorInput(
          [void Function(GUdHistoryStreamCursorInputBuilder b) updates]) =
      _$GUdHistoryStreamCursorInput;

  GUdHistoryStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GUdHistoryStreamCursorInput> get serializer =>
      _$gUdHistoryStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryStreamCursorInput.serializer,
        json,
      );
}

abstract class GUdHistoryStreamCursorValueInput
    implements
        Built<GUdHistoryStreamCursorValueInput,
            GUdHistoryStreamCursorValueInputBuilder> {
  GUdHistoryStreamCursorValueInput._();

  factory GUdHistoryStreamCursorValueInput(
          [void Function(GUdHistoryStreamCursorValueInputBuilder b) updates]) =
      _$GUdHistoryStreamCursorValueInput;

  int? get amount;
  int? get blockNumber;
  String? get id;
  String? get identityId;
  Gtimestamptz? get timestamp;
  static Serializer<GUdHistoryStreamCursorValueInput> get serializer =>
      _$gUdHistoryStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GUdReevalBoolExp
    implements Built<GUdReevalBoolExp, GUdReevalBoolExpBuilder> {
  GUdReevalBoolExp._();

  factory GUdReevalBoolExp([void Function(GUdReevalBoolExpBuilder b) updates]) =
      _$GUdReevalBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GUdReevalBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GUdReevalBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GUdReevalBoolExp>? get G_or;
  GIntComparisonExp? get blockNumber;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get id;
  GIntComparisonExp? get membersCount;
  GNumericComparisonExp? get monetaryMass;
  GNumericComparisonExp? get newUdAmount;
  GTimestamptzComparisonExp? get timestamp;
  GIntComparisonExp? get udIndex;
  static Serializer<GUdReevalBoolExp> get serializer =>
      _$gUdReevalBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalBoolExp.serializer,
        json,
      );
}

abstract class GUdReevalOrderBy
    implements Built<GUdReevalOrderBy, GUdReevalOrderByBuilder> {
  GUdReevalOrderBy._();

  factory GUdReevalOrderBy([void Function(GUdReevalOrderByBuilder b) updates]) =
      _$GUdReevalOrderBy;

  GOrderBy? get blockNumber;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get id;
  GOrderBy? get membersCount;
  GOrderBy? get monetaryMass;
  GOrderBy? get newUdAmount;
  GOrderBy? get timestamp;
  GOrderBy? get udIndex;
  static Serializer<GUdReevalOrderBy> get serializer =>
      _$gUdReevalOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalOrderBy.serializer,
        json,
      );
}

class GUdReevalSelectColumn extends EnumClass {
  const GUdReevalSelectColumn._(String name) : super(name);

  static const GUdReevalSelectColumn blockNumber =
      _$gUdReevalSelectColumnblockNumber;

  static const GUdReevalSelectColumn eventId = _$gUdReevalSelectColumneventId;

  static const GUdReevalSelectColumn id = _$gUdReevalSelectColumnid;

  static const GUdReevalSelectColumn membersCount =
      _$gUdReevalSelectColumnmembersCount;

  static const GUdReevalSelectColumn monetaryMass =
      _$gUdReevalSelectColumnmonetaryMass;

  static const GUdReevalSelectColumn newUdAmount =
      _$gUdReevalSelectColumnnewUdAmount;

  static const GUdReevalSelectColumn timestamp =
      _$gUdReevalSelectColumntimestamp;

  static const GUdReevalSelectColumn udIndex = _$gUdReevalSelectColumnudIndex;

  static Serializer<GUdReevalSelectColumn> get serializer =>
      _$gUdReevalSelectColumnSerializer;

  static BuiltSet<GUdReevalSelectColumn> get values =>
      _$gUdReevalSelectColumnValues;

  static GUdReevalSelectColumn valueOf(String name) =>
      _$gUdReevalSelectColumnValueOf(name);
}

abstract class GUdReevalStreamCursorInput
    implements
        Built<GUdReevalStreamCursorInput, GUdReevalStreamCursorInputBuilder> {
  GUdReevalStreamCursorInput._();

  factory GUdReevalStreamCursorInput(
          [void Function(GUdReevalStreamCursorInputBuilder b) updates]) =
      _$GUdReevalStreamCursorInput;

  GUdReevalStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GUdReevalStreamCursorInput> get serializer =>
      _$gUdReevalStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalStreamCursorInput.serializer,
        json,
      );
}

abstract class GUdReevalStreamCursorValueInput
    implements
        Built<GUdReevalStreamCursorValueInput,
            GUdReevalStreamCursorValueInputBuilder> {
  GUdReevalStreamCursorValueInput._();

  factory GUdReevalStreamCursorValueInput(
          [void Function(GUdReevalStreamCursorValueInputBuilder b) updates]) =
      _$GUdReevalStreamCursorValueInput;

  int? get blockNumber;
  String? get eventId;
  String? get id;
  int? get membersCount;
  int? get monetaryMass;
  int? get newUdAmount;
  Gtimestamptz? get timestamp;
  int? get udIndex;
  static Serializer<GUdReevalStreamCursorValueInput> get serializer =>
      _$gUdReevalStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalStreamCursorValueInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GUniversalDividendBoolExp
    implements
        Built<GUniversalDividendBoolExp, GUniversalDividendBoolExpBuilder> {
  GUniversalDividendBoolExp._();

  factory GUniversalDividendBoolExp(
          [void Function(GUniversalDividendBoolExpBuilder b) updates]) =
      _$GUniversalDividendBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GUniversalDividendBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GUniversalDividendBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GUniversalDividendBoolExp>? get G_or;
  GNumericComparisonExp? get amount;
  GIntComparisonExp? get blockNumber;
  GEventBoolExp? get event;
  GStringComparisonExp? get eventId;
  GStringComparisonExp? get id;
  GIntComparisonExp? get index;
  GIntComparisonExp? get membersCount;
  GNumericComparisonExp? get monetaryMass;
  GTimestamptzComparisonExp? get timestamp;
  static Serializer<GUniversalDividendBoolExp> get serializer =>
      _$gUniversalDividendBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendBoolExp.serializer,
        json,
      );
}

abstract class GUniversalDividendOrderBy
    implements
        Built<GUniversalDividendOrderBy, GUniversalDividendOrderByBuilder> {
  GUniversalDividendOrderBy._();

  factory GUniversalDividendOrderBy(
          [void Function(GUniversalDividendOrderByBuilder b) updates]) =
      _$GUniversalDividendOrderBy;

  GOrderBy? get amount;
  GOrderBy? get blockNumber;
  GEventOrderBy? get event;
  GOrderBy? get eventId;
  GOrderBy? get id;
  GOrderBy? get index;
  GOrderBy? get membersCount;
  GOrderBy? get monetaryMass;
  GOrderBy? get timestamp;
  static Serializer<GUniversalDividendOrderBy> get serializer =>
      _$gUniversalDividendOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendOrderBy.serializer,
        json,
      );
}

class GUniversalDividendSelectColumn extends EnumClass {
  const GUniversalDividendSelectColumn._(String name) : super(name);

  static const GUniversalDividendSelectColumn amount =
      _$gUniversalDividendSelectColumnamount;

  static const GUniversalDividendSelectColumn blockNumber =
      _$gUniversalDividendSelectColumnblockNumber;

  static const GUniversalDividendSelectColumn eventId =
      _$gUniversalDividendSelectColumneventId;

  static const GUniversalDividendSelectColumn id =
      _$gUniversalDividendSelectColumnid;

  static const GUniversalDividendSelectColumn index =
      _$gUniversalDividendSelectColumnindex;

  static const GUniversalDividendSelectColumn membersCount =
      _$gUniversalDividendSelectColumnmembersCount;

  static const GUniversalDividendSelectColumn monetaryMass =
      _$gUniversalDividendSelectColumnmonetaryMass;

  static const GUniversalDividendSelectColumn timestamp =
      _$gUniversalDividendSelectColumntimestamp;

  static Serializer<GUniversalDividendSelectColumn> get serializer =>
      _$gUniversalDividendSelectColumnSerializer;

  static BuiltSet<GUniversalDividendSelectColumn> get values =>
      _$gUniversalDividendSelectColumnValues;

  static GUniversalDividendSelectColumn valueOf(String name) =>
      _$gUniversalDividendSelectColumnValueOf(name);
}

abstract class GUniversalDividendStreamCursorInput
    implements
        Built<GUniversalDividendStreamCursorInput,
            GUniversalDividendStreamCursorInputBuilder> {
  GUniversalDividendStreamCursorInput._();

  factory GUniversalDividendStreamCursorInput(
      [void Function(GUniversalDividendStreamCursorInputBuilder b)
          updates]) = _$GUniversalDividendStreamCursorInput;

  GUniversalDividendStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GUniversalDividendStreamCursorInput> get serializer =>
      _$gUniversalDividendStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendStreamCursorInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendStreamCursorInput.serializer,
        json,
      );
}

abstract class GUniversalDividendStreamCursorValueInput
    implements
        Built<GUniversalDividendStreamCursorValueInput,
            GUniversalDividendStreamCursorValueInputBuilder> {
  GUniversalDividendStreamCursorValueInput._();

  factory GUniversalDividendStreamCursorValueInput(
      [void Function(GUniversalDividendStreamCursorValueInputBuilder b)
          updates]) = _$GUniversalDividendStreamCursorValueInput;

  int? get amount;
  int? get blockNumber;
  String? get eventId;
  String? get id;
  int? get index;
  int? get membersCount;
  int? get monetaryMass;
  Gtimestamptz? get timestamp;
  static Serializer<GUniversalDividendStreamCursorValueInput> get serializer =>
      _$gUniversalDividendStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendStreamCursorValueInput.serializer,
        json,
      );
}

abstract class GValidatorBoolExp
    implements Built<GValidatorBoolExp, GValidatorBoolExpBuilder> {
  GValidatorBoolExp._();

  factory GValidatorBoolExp(
          [void Function(GValidatorBoolExpBuilder b) updates]) =
      _$GValidatorBoolExp;

  @BuiltValueField(wireName: '_and')
  BuiltList<GValidatorBoolExp>? get G_and;
  @BuiltValueField(wireName: '_not')
  GValidatorBoolExp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<GValidatorBoolExp>? get G_or;
  GStringComparisonExp? get id;
  GIntComparisonExp? get index;
  static Serializer<GValidatorBoolExp> get serializer =>
      _$gValidatorBoolExpSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorBoolExp.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorBoolExp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorBoolExp.serializer,
        json,
      );
}

abstract class GValidatorOrderBy
    implements Built<GValidatorOrderBy, GValidatorOrderByBuilder> {
  GValidatorOrderBy._();

  factory GValidatorOrderBy(
          [void Function(GValidatorOrderByBuilder b) updates]) =
      _$GValidatorOrderBy;

  GOrderBy? get id;
  GOrderBy? get index;
  static Serializer<GValidatorOrderBy> get serializer =>
      _$gValidatorOrderBySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorOrderBy.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorOrderBy? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorOrderBy.serializer,
        json,
      );
}

class GValidatorSelectColumn extends EnumClass {
  const GValidatorSelectColumn._(String name) : super(name);

  static const GValidatorSelectColumn id = _$gValidatorSelectColumnid;

  static const GValidatorSelectColumn index = _$gValidatorSelectColumnindex;

  static Serializer<GValidatorSelectColumn> get serializer =>
      _$gValidatorSelectColumnSerializer;

  static BuiltSet<GValidatorSelectColumn> get values =>
      _$gValidatorSelectColumnValues;

  static GValidatorSelectColumn valueOf(String name) =>
      _$gValidatorSelectColumnValueOf(name);
}

abstract class GValidatorStreamCursorInput
    implements
        Built<GValidatorStreamCursorInput, GValidatorStreamCursorInputBuilder> {
  GValidatorStreamCursorInput._();

  factory GValidatorStreamCursorInput(
          [void Function(GValidatorStreamCursorInputBuilder b) updates]) =
      _$GValidatorStreamCursorInput;

  GValidatorStreamCursorValueInput get initialValue;
  GCursorOrdering? get ordering;
  static Serializer<GValidatorStreamCursorInput> get serializer =>
      _$gValidatorStreamCursorInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorStreamCursorInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorStreamCursorInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorStreamCursorInput.serializer,
        json,
      );
}

abstract class GValidatorStreamCursorValueInput
    implements
        Built<GValidatorStreamCursorValueInput,
            GValidatorStreamCursorValueInputBuilder> {
  GValidatorStreamCursorValueInput._();

  factory GValidatorStreamCursorValueInput(
          [void Function(GValidatorStreamCursorValueInputBuilder b) updates]) =
      _$GValidatorStreamCursorValueInput;

  String? get id;
  int? get index;
  static Serializer<GValidatorStreamCursorValueInput> get serializer =>
      _$gValidatorStreamCursorValueInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorStreamCursorValueInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorStreamCursorValueInput? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorStreamCursorValueInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};
