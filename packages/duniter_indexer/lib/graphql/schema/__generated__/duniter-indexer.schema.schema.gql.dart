// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;

part 'duniter-indexer.schema.schema.gql.g.dart';

abstract class GAccountCondition
    implements Built<GAccountCondition, GAccountConditionBuilder> {
  GAccountCondition._();

  factory GAccountCondition(
          [void Function(GAccountConditionBuilder b) updates]) =
      _$GAccountCondition;

  String? get id;
  int? get createdOn;
  bool? get isActive;
  GBigFloat? get balance;
  String? get linkedIdentityId;
  static Serializer<GAccountCondition> get serializer =>
      _$gAccountConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountCondition.serializer,
        json,
      );
}

abstract class GAccountFilter
    implements Built<GAccountFilter, GAccountFilterBuilder> {
  GAccountFilter._();

  factory GAccountFilter([void Function(GAccountFilterBuilder b) updates]) =
      _$GAccountFilter;

  GStringFilter? get id;
  GIntFilter? get createdOn;
  GBooleanFilter? get isActive;
  GBigFloatFilter? get balance;
  GStringFilter? get linkedIdentityId;
  GBigFloatFilter? get totalBalance;
  BuiltList<GAccountFilter>? get and;
  BuiltList<GAccountFilter>? get or;
  GAccountFilter? get not;
  static Serializer<GAccountFilter> get serializer =>
      _$gAccountFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFilter.serializer,
        json,
      );
}

class GAccountsOrderBy extends EnumClass {
  const GAccountsOrderBy._(String name) : super(name);

  static const GAccountsOrderBy NATURAL = _$gAccountsOrderByNATURAL;

  static const GAccountsOrderBy ID_ASC = _$gAccountsOrderByID_ASC;

  static const GAccountsOrderBy ID_DESC = _$gAccountsOrderByID_DESC;

  static const GAccountsOrderBy CREATED_ON_ASC =
      _$gAccountsOrderByCREATED_ON_ASC;

  static const GAccountsOrderBy CREATED_ON_DESC =
      _$gAccountsOrderByCREATED_ON_DESC;

  static const GAccountsOrderBy IS_ACTIVE_ASC = _$gAccountsOrderByIS_ACTIVE_ASC;

  static const GAccountsOrderBy IS_ACTIVE_DESC =
      _$gAccountsOrderByIS_ACTIVE_DESC;

  static const GAccountsOrderBy BALANCE_ASC = _$gAccountsOrderByBALANCE_ASC;

  static const GAccountsOrderBy BALANCE_DESC = _$gAccountsOrderByBALANCE_DESC;

  static const GAccountsOrderBy LINKED_IDENTITY_ID_ASC =
      _$gAccountsOrderByLINKED_IDENTITY_ID_ASC;

  static const GAccountsOrderBy LINKED_IDENTITY_ID_DESC =
      _$gAccountsOrderByLINKED_IDENTITY_ID_DESC;

  static const GAccountsOrderBy PRIMARY_KEY_ASC =
      _$gAccountsOrderByPRIMARY_KEY_ASC;

  static const GAccountsOrderBy PRIMARY_KEY_DESC =
      _$gAccountsOrderByPRIMARY_KEY_DESC;

  static Serializer<GAccountsOrderBy> get serializer =>
      _$gAccountsOrderBySerializer;

  static BuiltSet<GAccountsOrderBy> get values => _$gAccountsOrderByValues;

  static GAccountsOrderBy valueOf(String name) =>
      _$gAccountsOrderByValueOf(name);
}

abstract class GBigFloat implements Built<GBigFloat, GBigFloatBuilder> {
  GBigFloat._();

  factory GBigFloat([String? value]) =>
      _$GBigFloat((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GBigFloat> get serializer =>
      _i2.DefaultScalarSerializer<GBigFloat>(
          (Object serialized) => GBigFloat((serialized as String?)));
}

abstract class GBigFloatFilter
    implements Built<GBigFloatFilter, GBigFloatFilterBuilder> {
  GBigFloatFilter._();

  factory GBigFloatFilter([void Function(GBigFloatFilterBuilder b) updates]) =
      _$GBigFloatFilter;

  bool? get isNull;
  GBigFloat? get equalTo;
  GBigFloat? get notEqualTo;
  GBigFloat? get distinctFrom;
  GBigFloat? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<GBigFloat>? get Gin;
  BuiltList<GBigFloat>? get notIn;
  GBigFloat? get lessThan;
  GBigFloat? get lessThanOrEqualTo;
  GBigFloat? get greaterThan;
  GBigFloat? get greaterThanOrEqualTo;
  static Serializer<GBigFloatFilter> get serializer =>
      _$gBigFloatFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBigFloatFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBigFloatFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBigFloatFilter.serializer,
        json,
      );
}

abstract class GBigInt implements Built<GBigInt, GBigIntBuilder> {
  GBigInt._();

  factory GBigInt([String? value]) =>
      _$GBigInt((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GBigInt> get serializer =>
      _i2.DefaultScalarSerializer<GBigInt>(
          (Object serialized) => GBigInt((serialized as String?)));
}

abstract class GBigIntFilter
    implements Built<GBigIntFilter, GBigIntFilterBuilder> {
  GBigIntFilter._();

  factory GBigIntFilter([void Function(GBigIntFilterBuilder b) updates]) =
      _$GBigIntFilter;

  bool? get isNull;
  GBigInt? get equalTo;
  GBigInt? get notEqualTo;
  GBigInt? get distinctFrom;
  GBigInt? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<GBigInt>? get Gin;
  BuiltList<GBigInt>? get notIn;
  GBigInt? get lessThan;
  GBigInt? get lessThanOrEqualTo;
  GBigInt? get greaterThan;
  GBigInt? get greaterThanOrEqualTo;
  static Serializer<GBigIntFilter> get serializer => _$gBigIntFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBigIntFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBigIntFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBigIntFilter.serializer,
        json,
      );
}

abstract class GBlockCondition
    implements Built<GBlockCondition, GBlockConditionBuilder> {
  GBlockCondition._();

  factory GBlockCondition([void Function(GBlockConditionBuilder b) updates]) =
      _$GBlockCondition;

  String? get id;
  int? get height;
  String? get hash;
  String? get parentHash;
  String? get stateRoot;
  String? get extrinsicsicRoot;
  String? get specName;
  int? get specVersion;
  String? get implName;
  int? get implVersion;
  GDatetime? get timestamp;
  String? get validator;
  int? get extrinsicsCount;
  int? get callsCount;
  int? get eventsCount;
  static Serializer<GBlockCondition> get serializer =>
      _$gBlockConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockCondition.serializer,
        json,
      );
}

abstract class GBlockFilter
    implements Built<GBlockFilter, GBlockFilterBuilder> {
  GBlockFilter._();

  factory GBlockFilter([void Function(GBlockFilterBuilder b) updates]) =
      _$GBlockFilter;

  GStringFilter? get id;
  GIntFilter? get height;
  GStringFilter? get specName;
  GIntFilter? get specVersion;
  GStringFilter? get implName;
  GIntFilter? get implVersion;
  GDatetimeFilter? get timestamp;
  GIntFilter? get extrinsicsCount;
  GIntFilter? get callsCount;
  GIntFilter? get eventsCount;
  BuiltList<GBlockFilter>? get and;
  BuiltList<GBlockFilter>? get or;
  GBlockFilter? get not;
  static Serializer<GBlockFilter> get serializer => _$gBlockFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBlockFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBlockFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBlockFilter.serializer,
        json,
      );
}

class GBlocksOrderBy extends EnumClass {
  const GBlocksOrderBy._(String name) : super(name);

  static const GBlocksOrderBy NATURAL = _$gBlocksOrderByNATURAL;

  static const GBlocksOrderBy ID_ASC = _$gBlocksOrderByID_ASC;

  static const GBlocksOrderBy ID_DESC = _$gBlocksOrderByID_DESC;

  static const GBlocksOrderBy HEIGHT_ASC = _$gBlocksOrderByHEIGHT_ASC;

  static const GBlocksOrderBy HEIGHT_DESC = _$gBlocksOrderByHEIGHT_DESC;

  static const GBlocksOrderBy HASH_ASC = _$gBlocksOrderByHASH_ASC;

  static const GBlocksOrderBy HASH_DESC = _$gBlocksOrderByHASH_DESC;

  static const GBlocksOrderBy PARENT_HASH_ASC = _$gBlocksOrderByPARENT_HASH_ASC;

  static const GBlocksOrderBy PARENT_HASH_DESC =
      _$gBlocksOrderByPARENT_HASH_DESC;

  static const GBlocksOrderBy STATE_ROOT_ASC = _$gBlocksOrderBySTATE_ROOT_ASC;

  static const GBlocksOrderBy STATE_ROOT_DESC = _$gBlocksOrderBySTATE_ROOT_DESC;

  static const GBlocksOrderBy EXTRINSICSIC_ROOT_ASC =
      _$gBlocksOrderByEXTRINSICSIC_ROOT_ASC;

  static const GBlocksOrderBy EXTRINSICSIC_ROOT_DESC =
      _$gBlocksOrderByEXTRINSICSIC_ROOT_DESC;

  static const GBlocksOrderBy SPEC_NAME_ASC = _$gBlocksOrderBySPEC_NAME_ASC;

  static const GBlocksOrderBy SPEC_NAME_DESC = _$gBlocksOrderBySPEC_NAME_DESC;

  static const GBlocksOrderBy SPEC_VERSION_ASC =
      _$gBlocksOrderBySPEC_VERSION_ASC;

  static const GBlocksOrderBy SPEC_VERSION_DESC =
      _$gBlocksOrderBySPEC_VERSION_DESC;

  static const GBlocksOrderBy IMPL_NAME_ASC = _$gBlocksOrderByIMPL_NAME_ASC;

  static const GBlocksOrderBy IMPL_NAME_DESC = _$gBlocksOrderByIMPL_NAME_DESC;

  static const GBlocksOrderBy IMPL_VERSION_ASC =
      _$gBlocksOrderByIMPL_VERSION_ASC;

  static const GBlocksOrderBy IMPL_VERSION_DESC =
      _$gBlocksOrderByIMPL_VERSION_DESC;

  static const GBlocksOrderBy TIMESTAMP_ASC = _$gBlocksOrderByTIMESTAMP_ASC;

  static const GBlocksOrderBy TIMESTAMP_DESC = _$gBlocksOrderByTIMESTAMP_DESC;

  static const GBlocksOrderBy VALIDATOR_ASC = _$gBlocksOrderByVALIDATOR_ASC;

  static const GBlocksOrderBy VALIDATOR_DESC = _$gBlocksOrderByVALIDATOR_DESC;

  static const GBlocksOrderBy EXTRINSICS_COUNT_ASC =
      _$gBlocksOrderByEXTRINSICS_COUNT_ASC;

  static const GBlocksOrderBy EXTRINSICS_COUNT_DESC =
      _$gBlocksOrderByEXTRINSICS_COUNT_DESC;

  static const GBlocksOrderBy CALLS_COUNT_ASC = _$gBlocksOrderByCALLS_COUNT_ASC;

  static const GBlocksOrderBy CALLS_COUNT_DESC =
      _$gBlocksOrderByCALLS_COUNT_DESC;

  static const GBlocksOrderBy EVENTS_COUNT_ASC =
      _$gBlocksOrderByEVENTS_COUNT_ASC;

  static const GBlocksOrderBy EVENTS_COUNT_DESC =
      _$gBlocksOrderByEVENTS_COUNT_DESC;

  static const GBlocksOrderBy PRIMARY_KEY_ASC = _$gBlocksOrderByPRIMARY_KEY_ASC;

  static const GBlocksOrderBy PRIMARY_KEY_DESC =
      _$gBlocksOrderByPRIMARY_KEY_DESC;

  static Serializer<GBlocksOrderBy> get serializer =>
      _$gBlocksOrderBySerializer;

  static BuiltSet<GBlocksOrderBy> get values => _$gBlocksOrderByValues;

  static GBlocksOrderBy valueOf(String name) => _$gBlocksOrderByValueOf(name);
}

abstract class GBooleanFilter
    implements Built<GBooleanFilter, GBooleanFilterBuilder> {
  GBooleanFilter._();

  factory GBooleanFilter([void Function(GBooleanFilterBuilder b) updates]) =
      _$GBooleanFilter;

  bool? get isNull;
  bool? get equalTo;
  bool? get notEqualTo;
  bool? get distinctFrom;
  bool? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<bool>? get Gin;
  BuiltList<bool>? get notIn;
  bool? get lessThan;
  bool? get lessThanOrEqualTo;
  bool? get greaterThan;
  bool? get greaterThanOrEqualTo;
  static Serializer<GBooleanFilter> get serializer =>
      _$gBooleanFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GBooleanFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GBooleanFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GBooleanFilter.serializer,
        json,
      );
}

abstract class GCallCondition
    implements Built<GCallCondition, GCallConditionBuilder> {
  GCallCondition._();

  factory GCallCondition([void Function(GCallConditionBuilder b) updates]) =
      _$GCallCondition;

  String? get id;
  BuiltList<int?>? get address;
  bool? get success;
  GJSON? get error;
  String? get pallet;
  String? get name;
  GJSON? get args;
  BuiltList<String?>? get argsStr;
  String? get blockId;
  String? get extrinsicId;
  String? get parentId;
  static Serializer<GCallCondition> get serializer =>
      _$gCallConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallCondition.serializer,
        json,
      );
}

abstract class GCallFilter implements Built<GCallFilter, GCallFilterBuilder> {
  GCallFilter._();

  factory GCallFilter([void Function(GCallFilterBuilder b) updates]) =
      _$GCallFilter;

  GStringFilter? get id;
  GIntListFilter? get address;
  GBooleanFilter? get success;
  GJSONFilter? get error;
  GStringFilter? get pallet;
  GStringFilter? get name;
  GJSONFilter? get args;
  GStringListFilter? get argsStr;
  GStringFilter? get blockId;
  GStringFilter? get extrinsicId;
  GStringFilter? get parentId;
  BuiltList<GCallFilter>? get and;
  BuiltList<GCallFilter>? get or;
  GCallFilter? get not;
  static Serializer<GCallFilter> get serializer => _$gCallFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCallFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCallFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCallFilter.serializer,
        json,
      );
}

class GCallsOrderBy extends EnumClass {
  const GCallsOrderBy._(String name) : super(name);

  static const GCallsOrderBy NATURAL = _$gCallsOrderByNATURAL;

  static const GCallsOrderBy ID_ASC = _$gCallsOrderByID_ASC;

  static const GCallsOrderBy ID_DESC = _$gCallsOrderByID_DESC;

  static const GCallsOrderBy ADDRESS_ASC = _$gCallsOrderByADDRESS_ASC;

  static const GCallsOrderBy ADDRESS_DESC = _$gCallsOrderByADDRESS_DESC;

  static const GCallsOrderBy SUCCESS_ASC = _$gCallsOrderBySUCCESS_ASC;

  static const GCallsOrderBy SUCCESS_DESC = _$gCallsOrderBySUCCESS_DESC;

  static const GCallsOrderBy ERROR_ASC = _$gCallsOrderByERROR_ASC;

  static const GCallsOrderBy ERROR_DESC = _$gCallsOrderByERROR_DESC;

  static const GCallsOrderBy PALLET_ASC = _$gCallsOrderByPALLET_ASC;

  static const GCallsOrderBy PALLET_DESC = _$gCallsOrderByPALLET_DESC;

  static const GCallsOrderBy NAME_ASC = _$gCallsOrderByNAME_ASC;

  static const GCallsOrderBy NAME_DESC = _$gCallsOrderByNAME_DESC;

  static const GCallsOrderBy ARGS_ASC = _$gCallsOrderByARGS_ASC;

  static const GCallsOrderBy ARGS_DESC = _$gCallsOrderByARGS_DESC;

  static const GCallsOrderBy ARGS_STR_ASC = _$gCallsOrderByARGS_STR_ASC;

  static const GCallsOrderBy ARGS_STR_DESC = _$gCallsOrderByARGS_STR_DESC;

  static const GCallsOrderBy BLOCK_ID_ASC = _$gCallsOrderByBLOCK_ID_ASC;

  static const GCallsOrderBy BLOCK_ID_DESC = _$gCallsOrderByBLOCK_ID_DESC;

  static const GCallsOrderBy EXTRINSIC_ID_ASC = _$gCallsOrderByEXTRINSIC_ID_ASC;

  static const GCallsOrderBy EXTRINSIC_ID_DESC =
      _$gCallsOrderByEXTRINSIC_ID_DESC;

  static const GCallsOrderBy PARENT_ID_ASC = _$gCallsOrderByPARENT_ID_ASC;

  static const GCallsOrderBy PARENT_ID_DESC = _$gCallsOrderByPARENT_ID_DESC;

  static const GCallsOrderBy PRIMARY_KEY_ASC = _$gCallsOrderByPRIMARY_KEY_ASC;

  static const GCallsOrderBy PRIMARY_KEY_DESC = _$gCallsOrderByPRIMARY_KEY_DESC;

  static Serializer<GCallsOrderBy> get serializer => _$gCallsOrderBySerializer;

  static BuiltSet<GCallsOrderBy> get values => _$gCallsOrderByValues;

  static GCallsOrderBy valueOf(String name) => _$gCallsOrderByValueOf(name);
}

abstract class GCertCondition
    implements Built<GCertCondition, GCertConditionBuilder> {
  GCertCondition._();

  factory GCertCondition([void Function(GCertConditionBuilder b) updates]) =
      _$GCertCondition;

  String? get id;
  bool? get isActive;
  int? get createdOn;
  int? get updatedOn;
  int? get expireOn;
  String? get issuerId;
  String? get receiverId;
  String? get createdInId;
  String? get updatedInId;
  static Serializer<GCertCondition> get serializer =>
      _$gCertConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertCondition.serializer,
        json,
      );
}

abstract class GCertEventCondition
    implements Built<GCertEventCondition, GCertEventConditionBuilder> {
  GCertEventCondition._();

  factory GCertEventCondition(
          [void Function(GCertEventConditionBuilder b) updates]) =
      _$GCertEventCondition;

  String? get id;
  int? get blockNumber;
  String? get eventType;
  String? get certId;
  String? get eventId;
  static Serializer<GCertEventCondition> get serializer =>
      _$gCertEventConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventCondition.serializer,
        json,
      );
}

abstract class GCertEventFilter
    implements Built<GCertEventFilter, GCertEventFilterBuilder> {
  GCertEventFilter._();

  factory GCertEventFilter([void Function(GCertEventFilterBuilder b) updates]) =
      _$GCertEventFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GStringFilter? get eventType;
  GStringFilter? get certId;
  GStringFilter? get eventId;
  BuiltList<GCertEventFilter>? get and;
  BuiltList<GCertEventFilter>? get or;
  GCertEventFilter? get not;
  static Serializer<GCertEventFilter> get serializer =>
      _$gCertEventFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertEventFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertEventFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertEventFilter.serializer,
        json,
      );
}

class GCertEventsOrderBy extends EnumClass {
  const GCertEventsOrderBy._(String name) : super(name);

  static const GCertEventsOrderBy NATURAL = _$gCertEventsOrderByNATURAL;

  static const GCertEventsOrderBy ID_ASC = _$gCertEventsOrderByID_ASC;

  static const GCertEventsOrderBy ID_DESC = _$gCertEventsOrderByID_DESC;

  static const GCertEventsOrderBy BLOCK_NUMBER_ASC =
      _$gCertEventsOrderByBLOCK_NUMBER_ASC;

  static const GCertEventsOrderBy BLOCK_NUMBER_DESC =
      _$gCertEventsOrderByBLOCK_NUMBER_DESC;

  static const GCertEventsOrderBy EVENT_TYPE_ASC =
      _$gCertEventsOrderByEVENT_TYPE_ASC;

  static const GCertEventsOrderBy EVENT_TYPE_DESC =
      _$gCertEventsOrderByEVENT_TYPE_DESC;

  static const GCertEventsOrderBy CERT_ID_ASC = _$gCertEventsOrderByCERT_ID_ASC;

  static const GCertEventsOrderBy CERT_ID_DESC =
      _$gCertEventsOrderByCERT_ID_DESC;

  static const GCertEventsOrderBy EVENT_ID_ASC =
      _$gCertEventsOrderByEVENT_ID_ASC;

  static const GCertEventsOrderBy EVENT_ID_DESC =
      _$gCertEventsOrderByEVENT_ID_DESC;

  static const GCertEventsOrderBy PRIMARY_KEY_ASC =
      _$gCertEventsOrderByPRIMARY_KEY_ASC;

  static const GCertEventsOrderBy PRIMARY_KEY_DESC =
      _$gCertEventsOrderByPRIMARY_KEY_DESC;

  static Serializer<GCertEventsOrderBy> get serializer =>
      _$gCertEventsOrderBySerializer;

  static BuiltSet<GCertEventsOrderBy> get values => _$gCertEventsOrderByValues;

  static GCertEventsOrderBy valueOf(String name) =>
      _$gCertEventsOrderByValueOf(name);
}

abstract class GCertFilter implements Built<GCertFilter, GCertFilterBuilder> {
  GCertFilter._();

  factory GCertFilter([void Function(GCertFilterBuilder b) updates]) =
      _$GCertFilter;

  GStringFilter? get id;
  GBooleanFilter? get isActive;
  GIntFilter? get createdOn;
  GIntFilter? get updatedOn;
  GIntFilter? get expireOn;
  GStringFilter? get issuerId;
  GStringFilter? get receiverId;
  GStringFilter? get createdInId;
  GStringFilter? get updatedInId;
  BuiltList<GCertFilter>? get and;
  BuiltList<GCertFilter>? get or;
  GCertFilter? get not;
  static Serializer<GCertFilter> get serializer => _$gCertFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFilter.serializer,
        json,
      );
}

class GCertsOrderBy extends EnumClass {
  const GCertsOrderBy._(String name) : super(name);

  static const GCertsOrderBy NATURAL = _$gCertsOrderByNATURAL;

  static const GCertsOrderBy ID_ASC = _$gCertsOrderByID_ASC;

  static const GCertsOrderBy ID_DESC = _$gCertsOrderByID_DESC;

  static const GCertsOrderBy IS_ACTIVE_ASC = _$gCertsOrderByIS_ACTIVE_ASC;

  static const GCertsOrderBy IS_ACTIVE_DESC = _$gCertsOrderByIS_ACTIVE_DESC;

  static const GCertsOrderBy CREATED_ON_ASC = _$gCertsOrderByCREATED_ON_ASC;

  static const GCertsOrderBy CREATED_ON_DESC = _$gCertsOrderByCREATED_ON_DESC;

  static const GCertsOrderBy UPDATED_ON_ASC = _$gCertsOrderByUPDATED_ON_ASC;

  static const GCertsOrderBy UPDATED_ON_DESC = _$gCertsOrderByUPDATED_ON_DESC;

  static const GCertsOrderBy EXPIRE_ON_ASC = _$gCertsOrderByEXPIRE_ON_ASC;

  static const GCertsOrderBy EXPIRE_ON_DESC = _$gCertsOrderByEXPIRE_ON_DESC;

  static const GCertsOrderBy ISSUER_ID_ASC = _$gCertsOrderByISSUER_ID_ASC;

  static const GCertsOrderBy ISSUER_ID_DESC = _$gCertsOrderByISSUER_ID_DESC;

  static const GCertsOrderBy RECEIVER_ID_ASC = _$gCertsOrderByRECEIVER_ID_ASC;

  static const GCertsOrderBy RECEIVER_ID_DESC = _$gCertsOrderByRECEIVER_ID_DESC;

  static const GCertsOrderBy CREATED_IN_ID_ASC =
      _$gCertsOrderByCREATED_IN_ID_ASC;

  static const GCertsOrderBy CREATED_IN_ID_DESC =
      _$gCertsOrderByCREATED_IN_ID_DESC;

  static const GCertsOrderBy UPDATED_IN_ID_ASC =
      _$gCertsOrderByUPDATED_IN_ID_ASC;

  static const GCertsOrderBy UPDATED_IN_ID_DESC =
      _$gCertsOrderByUPDATED_IN_ID_DESC;

  static const GCertsOrderBy PRIMARY_KEY_ASC = _$gCertsOrderByPRIMARY_KEY_ASC;

  static const GCertsOrderBy PRIMARY_KEY_DESC = _$gCertsOrderByPRIMARY_KEY_DESC;

  static Serializer<GCertsOrderBy> get serializer => _$gCertsOrderBySerializer;

  static BuiltSet<GCertsOrderBy> get values => _$gCertsOrderByValues;

  static GCertsOrderBy valueOf(String name) => _$gCertsOrderByValueOf(name);
}

abstract class GChangeOwnerKeyCondition
    implements
        Built<GChangeOwnerKeyCondition, GChangeOwnerKeyConditionBuilder> {
  GChangeOwnerKeyCondition._();

  factory GChangeOwnerKeyCondition(
          [void Function(GChangeOwnerKeyConditionBuilder b) updates]) =
      _$GChangeOwnerKeyCondition;

  String? get id;
  int? get blockNumber;
  String? get identityId;
  String? get previousId;
  String? get nextId;
  static Serializer<GChangeOwnerKeyCondition> get serializer =>
      _$gChangeOwnerKeyConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyCondition.serializer,
        json,
      );
}

abstract class GChangeOwnerKeyFilter
    implements Built<GChangeOwnerKeyFilter, GChangeOwnerKeyFilterBuilder> {
  GChangeOwnerKeyFilter._();

  factory GChangeOwnerKeyFilter(
          [void Function(GChangeOwnerKeyFilterBuilder b) updates]) =
      _$GChangeOwnerKeyFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GStringFilter? get identityId;
  GStringFilter? get previousId;
  GStringFilter? get nextId;
  BuiltList<GChangeOwnerKeyFilter>? get and;
  BuiltList<GChangeOwnerKeyFilter>? get or;
  GChangeOwnerKeyFilter? get not;
  static Serializer<GChangeOwnerKeyFilter> get serializer =>
      _$gChangeOwnerKeyFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangeOwnerKeyFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangeOwnerKeyFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangeOwnerKeyFilter.serializer,
        json,
      );
}

class GChangeOwnerKeysOrderBy extends EnumClass {
  const GChangeOwnerKeysOrderBy._(String name) : super(name);

  static const GChangeOwnerKeysOrderBy NATURAL =
      _$gChangeOwnerKeysOrderByNATURAL;

  static const GChangeOwnerKeysOrderBy ID_ASC = _$gChangeOwnerKeysOrderByID_ASC;

  static const GChangeOwnerKeysOrderBy ID_DESC =
      _$gChangeOwnerKeysOrderByID_DESC;

  static const GChangeOwnerKeysOrderBy BLOCK_NUMBER_ASC =
      _$gChangeOwnerKeysOrderByBLOCK_NUMBER_ASC;

  static const GChangeOwnerKeysOrderBy BLOCK_NUMBER_DESC =
      _$gChangeOwnerKeysOrderByBLOCK_NUMBER_DESC;

  static const GChangeOwnerKeysOrderBy IDENTITY_ID_ASC =
      _$gChangeOwnerKeysOrderByIDENTITY_ID_ASC;

  static const GChangeOwnerKeysOrderBy IDENTITY_ID_DESC =
      _$gChangeOwnerKeysOrderByIDENTITY_ID_DESC;

  static const GChangeOwnerKeysOrderBy PREVIOUS_ID_ASC =
      _$gChangeOwnerKeysOrderByPREVIOUS_ID_ASC;

  static const GChangeOwnerKeysOrderBy PREVIOUS_ID_DESC =
      _$gChangeOwnerKeysOrderByPREVIOUS_ID_DESC;

  static const GChangeOwnerKeysOrderBy NEXT_ID_ASC =
      _$gChangeOwnerKeysOrderByNEXT_ID_ASC;

  static const GChangeOwnerKeysOrderBy NEXT_ID_DESC =
      _$gChangeOwnerKeysOrderByNEXT_ID_DESC;

  static const GChangeOwnerKeysOrderBy PRIMARY_KEY_ASC =
      _$gChangeOwnerKeysOrderByPRIMARY_KEY_ASC;

  static const GChangeOwnerKeysOrderBy PRIMARY_KEY_DESC =
      _$gChangeOwnerKeysOrderByPRIMARY_KEY_DESC;

  static Serializer<GChangeOwnerKeysOrderBy> get serializer =>
      _$gChangeOwnerKeysOrderBySerializer;

  static BuiltSet<GChangeOwnerKeysOrderBy> get values =>
      _$gChangeOwnerKeysOrderByValues;

  static GChangeOwnerKeysOrderBy valueOf(String name) =>
      _$gChangeOwnerKeysOrderByValueOf(name);
}

abstract class GCursor implements Built<GCursor, GCursorBuilder> {
  GCursor._();

  factory GCursor([String? value]) =>
      _$GCursor((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GCursor> get serializer =>
      _i2.DefaultScalarSerializer<GCursor>(
          (Object serialized) => GCursor((serialized as String?)));
}

abstract class GDatetime implements Built<GDatetime, GDatetimeBuilder> {
  GDatetime._();

  factory GDatetime([String? value]) =>
      _$GDatetime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GDatetime> get serializer =>
      _i2.DefaultScalarSerializer<GDatetime>(
          (Object serialized) => GDatetime((serialized as String?)));
}

abstract class GDatetimeFilter
    implements Built<GDatetimeFilter, GDatetimeFilterBuilder> {
  GDatetimeFilter._();

  factory GDatetimeFilter([void Function(GDatetimeFilterBuilder b) updates]) =
      _$GDatetimeFilter;

  bool? get isNull;
  GDatetime? get equalTo;
  GDatetime? get notEqualTo;
  GDatetime? get distinctFrom;
  GDatetime? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<GDatetime>? get Gin;
  BuiltList<GDatetime>? get notIn;
  GDatetime? get lessThan;
  GDatetime? get lessThanOrEqualTo;
  GDatetime? get greaterThan;
  GDatetime? get greaterThanOrEqualTo;
  static Serializer<GDatetimeFilter> get serializer =>
      _$gDatetimeFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDatetimeFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDatetimeFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDatetimeFilter.serializer,
        json,
      );
}

abstract class GEventCondition
    implements Built<GEventCondition, GEventConditionBuilder> {
  GEventCondition._();

  factory GEventCondition([void Function(GEventConditionBuilder b) updates]) =
      _$GEventCondition;

  String? get id;
  int? get index;
  String? get phase;
  String? get pallet;
  String? get name;
  GJSON? get args;
  BuiltList<String?>? get argsStr;
  String? get blockId;
  String? get extrinsicId;
  String? get callId;
  static Serializer<GEventCondition> get serializer =>
      _$gEventConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventCondition.serializer,
        json,
      );
}

abstract class GEventFilter
    implements Built<GEventFilter, GEventFilterBuilder> {
  GEventFilter._();

  factory GEventFilter([void Function(GEventFilterBuilder b) updates]) =
      _$GEventFilter;

  GStringFilter? get id;
  GIntFilter? get index;
  GStringFilter? get phase;
  GStringFilter? get pallet;
  GStringFilter? get name;
  GJSONFilter? get args;
  GStringListFilter? get argsStr;
  GStringFilter? get blockId;
  GStringFilter? get extrinsicId;
  GStringFilter? get callId;
  BuiltList<GEventFilter>? get and;
  BuiltList<GEventFilter>? get or;
  GEventFilter? get not;
  static Serializer<GEventFilter> get serializer => _$gEventFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEventFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEventFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEventFilter.serializer,
        json,
      );
}

class GEventsOrderBy extends EnumClass {
  const GEventsOrderBy._(String name) : super(name);

  static const GEventsOrderBy NATURAL = _$gEventsOrderByNATURAL;

  static const GEventsOrderBy ID_ASC = _$gEventsOrderByID_ASC;

  static const GEventsOrderBy ID_DESC = _$gEventsOrderByID_DESC;

  static const GEventsOrderBy INDEX_ASC = _$gEventsOrderByINDEX_ASC;

  static const GEventsOrderBy INDEX_DESC = _$gEventsOrderByINDEX_DESC;

  static const GEventsOrderBy PHASE_ASC = _$gEventsOrderByPHASE_ASC;

  static const GEventsOrderBy PHASE_DESC = _$gEventsOrderByPHASE_DESC;

  static const GEventsOrderBy PALLET_ASC = _$gEventsOrderByPALLET_ASC;

  static const GEventsOrderBy PALLET_DESC = _$gEventsOrderByPALLET_DESC;

  static const GEventsOrderBy NAME_ASC = _$gEventsOrderByNAME_ASC;

  static const GEventsOrderBy NAME_DESC = _$gEventsOrderByNAME_DESC;

  static const GEventsOrderBy ARGS_ASC = _$gEventsOrderByARGS_ASC;

  static const GEventsOrderBy ARGS_DESC = _$gEventsOrderByARGS_DESC;

  static const GEventsOrderBy ARGS_STR_ASC = _$gEventsOrderByARGS_STR_ASC;

  static const GEventsOrderBy ARGS_STR_DESC = _$gEventsOrderByARGS_STR_DESC;

  static const GEventsOrderBy BLOCK_ID_ASC = _$gEventsOrderByBLOCK_ID_ASC;

  static const GEventsOrderBy BLOCK_ID_DESC = _$gEventsOrderByBLOCK_ID_DESC;

  static const GEventsOrderBy EXTRINSIC_ID_ASC =
      _$gEventsOrderByEXTRINSIC_ID_ASC;

  static const GEventsOrderBy EXTRINSIC_ID_DESC =
      _$gEventsOrderByEXTRINSIC_ID_DESC;

  static const GEventsOrderBy CALL_ID_ASC = _$gEventsOrderByCALL_ID_ASC;

  static const GEventsOrderBy CALL_ID_DESC = _$gEventsOrderByCALL_ID_DESC;

  static const GEventsOrderBy PRIMARY_KEY_ASC = _$gEventsOrderByPRIMARY_KEY_ASC;

  static const GEventsOrderBy PRIMARY_KEY_DESC =
      _$gEventsOrderByPRIMARY_KEY_DESC;

  static Serializer<GEventsOrderBy> get serializer =>
      _$gEventsOrderBySerializer;

  static BuiltSet<GEventsOrderBy> get values => _$gEventsOrderByValues;

  static GEventsOrderBy valueOf(String name) => _$gEventsOrderByValueOf(name);
}

abstract class GExtrinsicCondition
    implements Built<GExtrinsicCondition, GExtrinsicConditionBuilder> {
  GExtrinsicCondition._();

  factory GExtrinsicCondition(
          [void Function(GExtrinsicConditionBuilder b) updates]) =
      _$GExtrinsicCondition;

  String? get id;
  int? get index;
  int? get version;
  GJSON? get signature;
  GBigFloat? get tip;
  GBigFloat? get fee;
  bool? get success;
  GJSON? get error;
  String? get hash;
  String? get blockId;
  String? get callId;
  static Serializer<GExtrinsicCondition> get serializer =>
      _$gExtrinsicConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicCondition.serializer,
        json,
      );
}

abstract class GExtrinsicFilter
    implements Built<GExtrinsicFilter, GExtrinsicFilterBuilder> {
  GExtrinsicFilter._();

  factory GExtrinsicFilter([void Function(GExtrinsicFilterBuilder b) updates]) =
      _$GExtrinsicFilter;

  GStringFilter? get id;
  GIntFilter? get index;
  GIntFilter? get version;
  GJSONFilter? get signature;
  GBigFloatFilter? get tip;
  GBigFloatFilter? get fee;
  GBooleanFilter? get success;
  GJSONFilter? get error;
  GStringFilter? get blockId;
  GStringFilter? get callId;
  BuiltList<GExtrinsicFilter>? get and;
  BuiltList<GExtrinsicFilter>? get or;
  GExtrinsicFilter? get not;
  static Serializer<GExtrinsicFilter> get serializer =>
      _$gExtrinsicFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GExtrinsicFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GExtrinsicFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GExtrinsicFilter.serializer,
        json,
      );
}

class GExtrinsicsOrderBy extends EnumClass {
  const GExtrinsicsOrderBy._(String name) : super(name);

  static const GExtrinsicsOrderBy NATURAL = _$gExtrinsicsOrderByNATURAL;

  static const GExtrinsicsOrderBy ID_ASC = _$gExtrinsicsOrderByID_ASC;

  static const GExtrinsicsOrderBy ID_DESC = _$gExtrinsicsOrderByID_DESC;

  static const GExtrinsicsOrderBy INDEX_ASC = _$gExtrinsicsOrderByINDEX_ASC;

  static const GExtrinsicsOrderBy INDEX_DESC = _$gExtrinsicsOrderByINDEX_DESC;

  static const GExtrinsicsOrderBy VERSION_ASC = _$gExtrinsicsOrderByVERSION_ASC;

  static const GExtrinsicsOrderBy VERSION_DESC =
      _$gExtrinsicsOrderByVERSION_DESC;

  static const GExtrinsicsOrderBy SIGNATURE_ASC =
      _$gExtrinsicsOrderBySIGNATURE_ASC;

  static const GExtrinsicsOrderBy SIGNATURE_DESC =
      _$gExtrinsicsOrderBySIGNATURE_DESC;

  static const GExtrinsicsOrderBy TIP_ASC = _$gExtrinsicsOrderByTIP_ASC;

  static const GExtrinsicsOrderBy TIP_DESC = _$gExtrinsicsOrderByTIP_DESC;

  static const GExtrinsicsOrderBy FEE_ASC = _$gExtrinsicsOrderByFEE_ASC;

  static const GExtrinsicsOrderBy FEE_DESC = _$gExtrinsicsOrderByFEE_DESC;

  static const GExtrinsicsOrderBy SUCCESS_ASC = _$gExtrinsicsOrderBySUCCESS_ASC;

  static const GExtrinsicsOrderBy SUCCESS_DESC =
      _$gExtrinsicsOrderBySUCCESS_DESC;

  static const GExtrinsicsOrderBy ERROR_ASC = _$gExtrinsicsOrderByERROR_ASC;

  static const GExtrinsicsOrderBy ERROR_DESC = _$gExtrinsicsOrderByERROR_DESC;

  static const GExtrinsicsOrderBy HASH_ASC = _$gExtrinsicsOrderByHASH_ASC;

  static const GExtrinsicsOrderBy HASH_DESC = _$gExtrinsicsOrderByHASH_DESC;

  static const GExtrinsicsOrderBy BLOCK_ID_ASC =
      _$gExtrinsicsOrderByBLOCK_ID_ASC;

  static const GExtrinsicsOrderBy BLOCK_ID_DESC =
      _$gExtrinsicsOrderByBLOCK_ID_DESC;

  static const GExtrinsicsOrderBy CALL_ID_ASC = _$gExtrinsicsOrderByCALL_ID_ASC;

  static const GExtrinsicsOrderBy CALL_ID_DESC =
      _$gExtrinsicsOrderByCALL_ID_DESC;

  static const GExtrinsicsOrderBy PRIMARY_KEY_ASC =
      _$gExtrinsicsOrderByPRIMARY_KEY_ASC;

  static const GExtrinsicsOrderBy PRIMARY_KEY_DESC =
      _$gExtrinsicsOrderByPRIMARY_KEY_DESC;

  static Serializer<GExtrinsicsOrderBy> get serializer =>
      _$gExtrinsicsOrderBySerializer;

  static BuiltSet<GExtrinsicsOrderBy> get values => _$gExtrinsicsOrderByValues;

  static GExtrinsicsOrderBy valueOf(String name) =>
      _$gExtrinsicsOrderByValueOf(name);
}

class GIdentitiesOrderBy extends EnumClass {
  const GIdentitiesOrderBy._(String name) : super(name);

  static const GIdentitiesOrderBy NATURAL = _$gIdentitiesOrderByNATURAL;

  static const GIdentitiesOrderBy ID_ASC = _$gIdentitiesOrderByID_ASC;

  static const GIdentitiesOrderBy ID_DESC = _$gIdentitiesOrderByID_DESC;

  static const GIdentitiesOrderBy INDEX_ASC = _$gIdentitiesOrderByINDEX_ASC;

  static const GIdentitiesOrderBy INDEX_DESC = _$gIdentitiesOrderByINDEX_DESC;

  static const GIdentitiesOrderBy NAME_ASC = _$gIdentitiesOrderByNAME_ASC;

  static const GIdentitiesOrderBy NAME_DESC = _$gIdentitiesOrderByNAME_DESC;

  static const GIdentitiesOrderBy STATUS_ASC = _$gIdentitiesOrderBySTATUS_ASC;

  static const GIdentitiesOrderBy STATUS_DESC = _$gIdentitiesOrderBySTATUS_DESC;

  static const GIdentitiesOrderBy CREATED_ON_ASC =
      _$gIdentitiesOrderByCREATED_ON_ASC;

  static const GIdentitiesOrderBy CREATED_ON_DESC =
      _$gIdentitiesOrderByCREATED_ON_DESC;

  static const GIdentitiesOrderBy LAST_CHANGE_ON_ASC =
      _$gIdentitiesOrderByLAST_CHANGE_ON_ASC;

  static const GIdentitiesOrderBy LAST_CHANGE_ON_DESC =
      _$gIdentitiesOrderByLAST_CHANGE_ON_DESC;

  static const GIdentitiesOrderBy IS_MEMBER_ASC =
      _$gIdentitiesOrderByIS_MEMBER_ASC;

  static const GIdentitiesOrderBy IS_MEMBER_DESC =
      _$gIdentitiesOrderByIS_MEMBER_DESC;

  static const GIdentitiesOrderBy EXPIRE_ON_ASC =
      _$gIdentitiesOrderByEXPIRE_ON_ASC;

  static const GIdentitiesOrderBy EXPIRE_ON_DESC =
      _$gIdentitiesOrderByEXPIRE_ON_DESC;

  static const GIdentitiesOrderBy FIRST_ELIGIBLE_UD_ASC =
      _$gIdentitiesOrderByFIRST_ELIGIBLE_UD_ASC;

  static const GIdentitiesOrderBy FIRST_ELIGIBLE_UD_DESC =
      _$gIdentitiesOrderByFIRST_ELIGIBLE_UD_DESC;

  static const GIdentitiesOrderBy ACCOUNT_ID_ASC =
      _$gIdentitiesOrderByACCOUNT_ID_ASC;

  static const GIdentitiesOrderBy ACCOUNT_ID_DESC =
      _$gIdentitiesOrderByACCOUNT_ID_DESC;

  static const GIdentitiesOrderBy ACCOUNT_REMOVED_ID_ASC =
      _$gIdentitiesOrderByACCOUNT_REMOVED_ID_ASC;

  static const GIdentitiesOrderBy ACCOUNT_REMOVED_ID_DESC =
      _$gIdentitiesOrderByACCOUNT_REMOVED_ID_DESC;

  static const GIdentitiesOrderBy CREATED_IN_ID_ASC =
      _$gIdentitiesOrderByCREATED_IN_ID_ASC;

  static const GIdentitiesOrderBy CREATED_IN_ID_DESC =
      _$gIdentitiesOrderByCREATED_IN_ID_DESC;

  static const GIdentitiesOrderBy PRIMARY_KEY_ASC =
      _$gIdentitiesOrderByPRIMARY_KEY_ASC;

  static const GIdentitiesOrderBy PRIMARY_KEY_DESC =
      _$gIdentitiesOrderByPRIMARY_KEY_DESC;

  static Serializer<GIdentitiesOrderBy> get serializer =>
      _$gIdentitiesOrderBySerializer;

  static BuiltSet<GIdentitiesOrderBy> get values => _$gIdentitiesOrderByValues;

  static GIdentitiesOrderBy valueOf(String name) =>
      _$gIdentitiesOrderByValueOf(name);
}

abstract class GIdentityCondition
    implements Built<GIdentityCondition, GIdentityConditionBuilder> {
  GIdentityCondition._();

  factory GIdentityCondition(
          [void Function(GIdentityConditionBuilder b) updates]) =
      _$GIdentityCondition;

  String? get id;
  int? get index;
  String? get name;
  String? get status;
  int? get createdOn;
  int? get lastChangeOn;
  bool? get isMember;
  int? get expireOn;
  int? get firstEligibleUd;
  String? get accountId;
  String? get accountRemovedId;
  String? get createdInId;
  static Serializer<GIdentityCondition> get serializer =>
      _$gIdentityConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityCondition.serializer,
        json,
      );
}

abstract class GIdentityFilter
    implements Built<GIdentityFilter, GIdentityFilterBuilder> {
  GIdentityFilter._();

  factory GIdentityFilter([void Function(GIdentityFilterBuilder b) updates]) =
      _$GIdentityFilter;

  GStringFilter? get id;
  GIntFilter? get index;
  GStringFilter? get name;
  GStringFilter? get status;
  GIntFilter? get createdOn;
  GIntFilter? get lastChangeOn;
  GBooleanFilter? get isMember;
  GIntFilter? get expireOn;
  GIntFilter? get firstEligibleUd;
  GStringFilter? get accountId;
  GStringFilter? get accountRemovedId;
  GStringFilter? get createdInId;
  BuiltList<GIdentityFilter>? get and;
  BuiltList<GIdentityFilter>? get or;
  GIdentityFilter? get not;
  static Serializer<GIdentityFilter> get serializer =>
      _$gIdentityFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFilter.serializer,
        json,
      );
}

abstract class GIntFilter implements Built<GIntFilter, GIntFilterBuilder> {
  GIntFilter._();

  factory GIntFilter([void Function(GIntFilterBuilder b) updates]) =
      _$GIntFilter;

  bool? get isNull;
  int? get equalTo;
  int? get notEqualTo;
  int? get distinctFrom;
  int? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<int>? get Gin;
  BuiltList<int>? get notIn;
  int? get lessThan;
  int? get lessThanOrEqualTo;
  int? get greaterThan;
  int? get greaterThanOrEqualTo;
  static Serializer<GIntFilter> get serializer => _$gIntFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIntFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIntFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIntFilter.serializer,
        json,
      );
}

abstract class GIntListFilter
    implements Built<GIntListFilter, GIntListFilterBuilder> {
  GIntListFilter._();

  factory GIntListFilter([void Function(GIntListFilterBuilder b) updates]) =
      _$GIntListFilter;

  bool? get isNull;
  BuiltList<int?>? get equalTo;
  BuiltList<int?>? get notEqualTo;
  BuiltList<int?>? get distinctFrom;
  BuiltList<int?>? get notDistinctFrom;
  BuiltList<int?>? get lessThan;
  BuiltList<int?>? get lessThanOrEqualTo;
  BuiltList<int?>? get greaterThan;
  BuiltList<int?>? get greaterThanOrEqualTo;
  BuiltList<int?>? get contains;
  BuiltList<int?>? get containedBy;
  BuiltList<int?>? get overlaps;
  int? get anyEqualTo;
  int? get anyNotEqualTo;
  int? get anyLessThan;
  int? get anyLessThanOrEqualTo;
  int? get anyGreaterThan;
  int? get anyGreaterThanOrEqualTo;
  static Serializer<GIntListFilter> get serializer =>
      _$gIntListFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIntListFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIntListFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIntListFilter.serializer,
        json,
      );
}

abstract class GItemsCounterCondition
    implements Built<GItemsCounterCondition, GItemsCounterConditionBuilder> {
  GItemsCounterCondition._();

  factory GItemsCounterCondition(
          [void Function(GItemsCounterConditionBuilder b) updates]) =
      _$GItemsCounterCondition;

  String? get id;
  String? get type;
  String? get level;
  int? get total;
  static Serializer<GItemsCounterCondition> get serializer =>
      _$gItemsCounterConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterCondition.serializer,
        json,
      );
}

abstract class GItemsCounterFilter
    implements Built<GItemsCounterFilter, GItemsCounterFilterBuilder> {
  GItemsCounterFilter._();

  factory GItemsCounterFilter(
          [void Function(GItemsCounterFilterBuilder b) updates]) =
      _$GItemsCounterFilter;

  GStringFilter? get id;
  GStringFilter? get type;
  GStringFilter? get level;
  GIntFilter? get total;
  BuiltList<GItemsCounterFilter>? get and;
  BuiltList<GItemsCounterFilter>? get or;
  GItemsCounterFilter? get not;
  static Serializer<GItemsCounterFilter> get serializer =>
      _$gItemsCounterFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GItemsCounterFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GItemsCounterFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GItemsCounterFilter.serializer,
        json,
      );
}

class GItemsCountersOrderBy extends EnumClass {
  const GItemsCountersOrderBy._(String name) : super(name);

  static const GItemsCountersOrderBy NATURAL = _$gItemsCountersOrderByNATURAL;

  static const GItemsCountersOrderBy ID_ASC = _$gItemsCountersOrderByID_ASC;

  static const GItemsCountersOrderBy ID_DESC = _$gItemsCountersOrderByID_DESC;

  static const GItemsCountersOrderBy TYPE_ASC = _$gItemsCountersOrderByTYPE_ASC;

  static const GItemsCountersOrderBy TYPE_DESC =
      _$gItemsCountersOrderByTYPE_DESC;

  static const GItemsCountersOrderBy LEVEL_ASC =
      _$gItemsCountersOrderByLEVEL_ASC;

  static const GItemsCountersOrderBy LEVEL_DESC =
      _$gItemsCountersOrderByLEVEL_DESC;

  static const GItemsCountersOrderBy TOTAL_ASC =
      _$gItemsCountersOrderByTOTAL_ASC;

  static const GItemsCountersOrderBy TOTAL_DESC =
      _$gItemsCountersOrderByTOTAL_DESC;

  static const GItemsCountersOrderBy PRIMARY_KEY_ASC =
      _$gItemsCountersOrderByPRIMARY_KEY_ASC;

  static const GItemsCountersOrderBy PRIMARY_KEY_DESC =
      _$gItemsCountersOrderByPRIMARY_KEY_DESC;

  static Serializer<GItemsCountersOrderBy> get serializer =>
      _$gItemsCountersOrderBySerializer;

  static BuiltSet<GItemsCountersOrderBy> get values =>
      _$gItemsCountersOrderByValues;

  static GItemsCountersOrderBy valueOf(String name) =>
      _$gItemsCountersOrderByValueOf(name);
}

abstract class GJSON implements Built<GJSON, GJSONBuilder> {
  GJSON._();

  factory GJSON([String? value]) =>
      _$GJSON((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSON> get serializer => _i2.DefaultScalarSerializer<GJSON>(
      (Object serialized) => GJSON((serialized as String?)));
}

abstract class GJSONFilter implements Built<GJSONFilter, GJSONFilterBuilder> {
  GJSONFilter._();

  factory GJSONFilter([void Function(GJSONFilterBuilder b) updates]) =
      _$GJSONFilter;

  bool? get isNull;
  GJSON? get equalTo;
  GJSON? get notEqualTo;
  GJSON? get distinctFrom;
  GJSON? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<GJSON>? get Gin;
  BuiltList<GJSON>? get notIn;
  GJSON? get lessThan;
  GJSON? get lessThanOrEqualTo;
  GJSON? get greaterThan;
  GJSON? get greaterThanOrEqualTo;
  GJSON? get contains;
  String? get containsKey;
  BuiltList<String>? get containsAllKeys;
  BuiltList<String>? get containsAnyKeys;
  GJSON? get containedBy;
  static Serializer<GJSONFilter> get serializer => _$gJSONFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GJSONFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GJSONFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GJSONFilter.serializer,
        json,
      );
}

abstract class GMembershipEventCondition
    implements
        Built<GMembershipEventCondition, GMembershipEventConditionBuilder> {
  GMembershipEventCondition._();

  factory GMembershipEventCondition(
          [void Function(GMembershipEventConditionBuilder b) updates]) =
      _$GMembershipEventCondition;

  String? get id;
  String? get eventType;
  int? get blockNumber;
  String? get identityId;
  String? get eventId;
  static Serializer<GMembershipEventCondition> get serializer =>
      _$gMembershipEventConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventCondition.serializer,
        json,
      );
}

abstract class GMembershipEventFilter
    implements Built<GMembershipEventFilter, GMembershipEventFilterBuilder> {
  GMembershipEventFilter._();

  factory GMembershipEventFilter(
          [void Function(GMembershipEventFilterBuilder b) updates]) =
      _$GMembershipEventFilter;

  GStringFilter? get id;
  GStringFilter? get eventType;
  GIntFilter? get blockNumber;
  GStringFilter? get identityId;
  GStringFilter? get eventId;
  BuiltList<GMembershipEventFilter>? get and;
  BuiltList<GMembershipEventFilter>? get or;
  GMembershipEventFilter? get not;
  static Serializer<GMembershipEventFilter> get serializer =>
      _$gMembershipEventFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMembershipEventFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMembershipEventFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMembershipEventFilter.serializer,
        json,
      );
}

class GMembershipEventsOrderBy extends EnumClass {
  const GMembershipEventsOrderBy._(String name) : super(name);

  static const GMembershipEventsOrderBy NATURAL =
      _$gMembershipEventsOrderByNATURAL;

  static const GMembershipEventsOrderBy ID_ASC =
      _$gMembershipEventsOrderByID_ASC;

  static const GMembershipEventsOrderBy ID_DESC =
      _$gMembershipEventsOrderByID_DESC;

  static const GMembershipEventsOrderBy EVENT_TYPE_ASC =
      _$gMembershipEventsOrderByEVENT_TYPE_ASC;

  static const GMembershipEventsOrderBy EVENT_TYPE_DESC =
      _$gMembershipEventsOrderByEVENT_TYPE_DESC;

  static const GMembershipEventsOrderBy BLOCK_NUMBER_ASC =
      _$gMembershipEventsOrderByBLOCK_NUMBER_ASC;

  static const GMembershipEventsOrderBy BLOCK_NUMBER_DESC =
      _$gMembershipEventsOrderByBLOCK_NUMBER_DESC;

  static const GMembershipEventsOrderBy IDENTITY_ID_ASC =
      _$gMembershipEventsOrderByIDENTITY_ID_ASC;

  static const GMembershipEventsOrderBy IDENTITY_ID_DESC =
      _$gMembershipEventsOrderByIDENTITY_ID_DESC;

  static const GMembershipEventsOrderBy EVENT_ID_ASC =
      _$gMembershipEventsOrderByEVENT_ID_ASC;

  static const GMembershipEventsOrderBy EVENT_ID_DESC =
      _$gMembershipEventsOrderByEVENT_ID_DESC;

  static const GMembershipEventsOrderBy PRIMARY_KEY_ASC =
      _$gMembershipEventsOrderByPRIMARY_KEY_ASC;

  static const GMembershipEventsOrderBy PRIMARY_KEY_DESC =
      _$gMembershipEventsOrderByPRIMARY_KEY_DESC;

  static Serializer<GMembershipEventsOrderBy> get serializer =>
      _$gMembershipEventsOrderBySerializer;

  static BuiltSet<GMembershipEventsOrderBy> get values =>
      _$gMembershipEventsOrderByValues;

  static GMembershipEventsOrderBy valueOf(String name) =>
      _$gMembershipEventsOrderByValueOf(name);
}

abstract class GMigrationCondition
    implements Built<GMigrationCondition, GMigrationConditionBuilder> {
  GMigrationCondition._();

  factory GMigrationCondition(
          [void Function(GMigrationConditionBuilder b) updates]) =
      _$GMigrationCondition;

  int? get id;
  GBigInt? get timestamp;
  String? get name;
  static Serializer<GMigrationCondition> get serializer =>
      _$gMigrationConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMigrationCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMigrationCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMigrationCondition.serializer,
        json,
      );
}

abstract class GMigrationFilter
    implements Built<GMigrationFilter, GMigrationFilterBuilder> {
  GMigrationFilter._();

  factory GMigrationFilter([void Function(GMigrationFilterBuilder b) updates]) =
      _$GMigrationFilter;

  GIntFilter? get id;
  GBigIntFilter? get timestamp;
  GStringFilter? get name;
  BuiltList<GMigrationFilter>? get and;
  BuiltList<GMigrationFilter>? get or;
  GMigrationFilter? get not;
  static Serializer<GMigrationFilter> get serializer =>
      _$gMigrationFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMigrationFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMigrationFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMigrationFilter.serializer,
        json,
      );
}

class GMigrationsOrderBy extends EnumClass {
  const GMigrationsOrderBy._(String name) : super(name);

  static const GMigrationsOrderBy NATURAL = _$gMigrationsOrderByNATURAL;

  static const GMigrationsOrderBy ID_ASC = _$gMigrationsOrderByID_ASC;

  static const GMigrationsOrderBy ID_DESC = _$gMigrationsOrderByID_DESC;

  static const GMigrationsOrderBy TIMESTAMP_ASC =
      _$gMigrationsOrderByTIMESTAMP_ASC;

  static const GMigrationsOrderBy TIMESTAMP_DESC =
      _$gMigrationsOrderByTIMESTAMP_DESC;

  static const GMigrationsOrderBy NAME_ASC = _$gMigrationsOrderByNAME_ASC;

  static const GMigrationsOrderBy NAME_DESC = _$gMigrationsOrderByNAME_DESC;

  static const GMigrationsOrderBy PRIMARY_KEY_ASC =
      _$gMigrationsOrderByPRIMARY_KEY_ASC;

  static const GMigrationsOrderBy PRIMARY_KEY_DESC =
      _$gMigrationsOrderByPRIMARY_KEY_DESC;

  static Serializer<GMigrationsOrderBy> get serializer =>
      _$gMigrationsOrderBySerializer;

  static BuiltSet<GMigrationsOrderBy> get values => _$gMigrationsOrderByValues;

  static GMigrationsOrderBy valueOf(String name) =>
      _$gMigrationsOrderByValueOf(name);
}

class GPopulationHistoriesOrderBy extends EnumClass {
  const GPopulationHistoriesOrderBy._(String name) : super(name);

  static const GPopulationHistoriesOrderBy NATURAL =
      _$gPopulationHistoriesOrderByNATURAL;

  static const GPopulationHistoriesOrderBy ID_ASC =
      _$gPopulationHistoriesOrderByID_ASC;

  static const GPopulationHistoriesOrderBy ID_DESC =
      _$gPopulationHistoriesOrderByID_DESC;

  static const GPopulationHistoriesOrderBy SMITH_COUNT_ASC =
      _$gPopulationHistoriesOrderBySMITH_COUNT_ASC;

  static const GPopulationHistoriesOrderBy SMITH_COUNT_DESC =
      _$gPopulationHistoriesOrderBySMITH_COUNT_DESC;

  static const GPopulationHistoriesOrderBy MEMBER_COUNT_ASC =
      _$gPopulationHistoriesOrderByMEMBER_COUNT_ASC;

  static const GPopulationHistoriesOrderBy MEMBER_COUNT_DESC =
      _$gPopulationHistoriesOrderByMEMBER_COUNT_DESC;

  static const GPopulationHistoriesOrderBy ACTIVE_ACCOUNT_COUNT_ASC =
      _$gPopulationHistoriesOrderByACTIVE_ACCOUNT_COUNT_ASC;

  static const GPopulationHistoriesOrderBy ACTIVE_ACCOUNT_COUNT_DESC =
      _$gPopulationHistoriesOrderByACTIVE_ACCOUNT_COUNT_DESC;

  static const GPopulationHistoriesOrderBy BLOCK_NUMBER_ASC =
      _$gPopulationHistoriesOrderByBLOCK_NUMBER_ASC;

  static const GPopulationHistoriesOrderBy BLOCK_NUMBER_DESC =
      _$gPopulationHistoriesOrderByBLOCK_NUMBER_DESC;

  static const GPopulationHistoriesOrderBy PRIMARY_KEY_ASC =
      _$gPopulationHistoriesOrderByPRIMARY_KEY_ASC;

  static const GPopulationHistoriesOrderBy PRIMARY_KEY_DESC =
      _$gPopulationHistoriesOrderByPRIMARY_KEY_DESC;

  static Serializer<GPopulationHistoriesOrderBy> get serializer =>
      _$gPopulationHistoriesOrderBySerializer;

  static BuiltSet<GPopulationHistoriesOrderBy> get values =>
      _$gPopulationHistoriesOrderByValues;

  static GPopulationHistoriesOrderBy valueOf(String name) =>
      _$gPopulationHistoriesOrderByValueOf(name);
}

abstract class GPopulationHistoryCondition
    implements
        Built<GPopulationHistoryCondition, GPopulationHistoryConditionBuilder> {
  GPopulationHistoryCondition._();

  factory GPopulationHistoryCondition(
          [void Function(GPopulationHistoryConditionBuilder b) updates]) =
      _$GPopulationHistoryCondition;

  String? get id;
  int? get smithCount;
  int? get memberCount;
  int? get activeAccountCount;
  int? get blockNumber;
  static Serializer<GPopulationHistoryCondition> get serializer =>
      _$gPopulationHistoryConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryCondition.serializer,
        json,
      );
}

abstract class GPopulationHistoryFilter
    implements
        Built<GPopulationHistoryFilter, GPopulationHistoryFilterBuilder> {
  GPopulationHistoryFilter._();

  factory GPopulationHistoryFilter(
          [void Function(GPopulationHistoryFilterBuilder b) updates]) =
      _$GPopulationHistoryFilter;

  GStringFilter? get id;
  GIntFilter? get smithCount;
  GIntFilter? get memberCount;
  GIntFilter? get activeAccountCount;
  GIntFilter? get blockNumber;
  BuiltList<GPopulationHistoryFilter>? get and;
  BuiltList<GPopulationHistoryFilter>? get or;
  GPopulationHistoryFilter? get not;
  static Serializer<GPopulationHistoryFilter> get serializer =>
      _$gPopulationHistoryFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPopulationHistoryFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPopulationHistoryFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPopulationHistoryFilter.serializer,
        json,
      );
}

abstract class GSmithCertCondition
    implements Built<GSmithCertCondition, GSmithCertConditionBuilder> {
  GSmithCertCondition._();

  factory GSmithCertCondition(
          [void Function(GSmithCertConditionBuilder b) updates]) =
      _$GSmithCertCondition;

  String? get id;
  int? get createdOn;
  String? get issuerId;
  String? get receiverId;
  static Serializer<GSmithCertCondition> get serializer =>
      _$gSmithCertConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertCondition.serializer,
        json,
      );
}

abstract class GSmithCertFilter
    implements Built<GSmithCertFilter, GSmithCertFilterBuilder> {
  GSmithCertFilter._();

  factory GSmithCertFilter([void Function(GSmithCertFilterBuilder b) updates]) =
      _$GSmithCertFilter;

  GStringFilter? get id;
  GIntFilter? get createdOn;
  GStringFilter? get issuerId;
  GStringFilter? get receiverId;
  BuiltList<GSmithCertFilter>? get and;
  BuiltList<GSmithCertFilter>? get or;
  GSmithCertFilter? get not;
  static Serializer<GSmithCertFilter> get serializer =>
      _$gSmithCertFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertFilter.serializer,
        json,
      );
}

class GSmithCertsOrderBy extends EnumClass {
  const GSmithCertsOrderBy._(String name) : super(name);

  static const GSmithCertsOrderBy NATURAL = _$gSmithCertsOrderByNATURAL;

  static const GSmithCertsOrderBy ID_ASC = _$gSmithCertsOrderByID_ASC;

  static const GSmithCertsOrderBy ID_DESC = _$gSmithCertsOrderByID_DESC;

  static const GSmithCertsOrderBy CREATED_ON_ASC =
      _$gSmithCertsOrderByCREATED_ON_ASC;

  static const GSmithCertsOrderBy CREATED_ON_DESC =
      _$gSmithCertsOrderByCREATED_ON_DESC;

  static const GSmithCertsOrderBy ISSUER_ID_ASC =
      _$gSmithCertsOrderByISSUER_ID_ASC;

  static const GSmithCertsOrderBy ISSUER_ID_DESC =
      _$gSmithCertsOrderByISSUER_ID_DESC;

  static const GSmithCertsOrderBy RECEIVER_ID_ASC =
      _$gSmithCertsOrderByRECEIVER_ID_ASC;

  static const GSmithCertsOrderBy RECEIVER_ID_DESC =
      _$gSmithCertsOrderByRECEIVER_ID_DESC;

  static const GSmithCertsOrderBy PRIMARY_KEY_ASC =
      _$gSmithCertsOrderByPRIMARY_KEY_ASC;

  static const GSmithCertsOrderBy PRIMARY_KEY_DESC =
      _$gSmithCertsOrderByPRIMARY_KEY_DESC;

  static Serializer<GSmithCertsOrderBy> get serializer =>
      _$gSmithCertsOrderBySerializer;

  static BuiltSet<GSmithCertsOrderBy> get values => _$gSmithCertsOrderByValues;

  static GSmithCertsOrderBy valueOf(String name) =>
      _$gSmithCertsOrderByValueOf(name);
}

abstract class GSmithCondition
    implements Built<GSmithCondition, GSmithConditionBuilder> {
  GSmithCondition._();

  factory GSmithCondition([void Function(GSmithConditionBuilder b) updates]) =
      _$GSmithCondition;

  String? get id;
  int? get index;
  String? get smithStatus;
  int? get lastChanged;
  int? get forged;
  int? get lastForged;
  String? get identityId;
  static Serializer<GSmithCondition> get serializer =>
      _$gSmithConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCondition.serializer,
        json,
      );
}

abstract class GSmithEventCondition
    implements Built<GSmithEventCondition, GSmithEventConditionBuilder> {
  GSmithEventCondition._();

  factory GSmithEventCondition(
          [void Function(GSmithEventConditionBuilder b) updates]) =
      _$GSmithEventCondition;

  String? get id;
  String? get eventType;
  int? get blockNumber;
  String? get smithId;
  String? get eventId;
  static Serializer<GSmithEventCondition> get serializer =>
      _$gSmithEventConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventCondition.serializer,
        json,
      );
}

abstract class GSmithEventFilter
    implements Built<GSmithEventFilter, GSmithEventFilterBuilder> {
  GSmithEventFilter._();

  factory GSmithEventFilter(
          [void Function(GSmithEventFilterBuilder b) updates]) =
      _$GSmithEventFilter;

  GStringFilter? get id;
  GStringFilter? get eventType;
  GIntFilter? get blockNumber;
  GStringFilter? get smithId;
  GStringFilter? get eventId;
  BuiltList<GSmithEventFilter>? get and;
  BuiltList<GSmithEventFilter>? get or;
  GSmithEventFilter? get not;
  static Serializer<GSmithEventFilter> get serializer =>
      _$gSmithEventFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithEventFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithEventFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithEventFilter.serializer,
        json,
      );
}

class GSmithEventsOrderBy extends EnumClass {
  const GSmithEventsOrderBy._(String name) : super(name);

  static const GSmithEventsOrderBy NATURAL = _$gSmithEventsOrderByNATURAL;

  static const GSmithEventsOrderBy ID_ASC = _$gSmithEventsOrderByID_ASC;

  static const GSmithEventsOrderBy ID_DESC = _$gSmithEventsOrderByID_DESC;

  static const GSmithEventsOrderBy EVENT_TYPE_ASC =
      _$gSmithEventsOrderByEVENT_TYPE_ASC;

  static const GSmithEventsOrderBy EVENT_TYPE_DESC =
      _$gSmithEventsOrderByEVENT_TYPE_DESC;

  static const GSmithEventsOrderBy BLOCK_NUMBER_ASC =
      _$gSmithEventsOrderByBLOCK_NUMBER_ASC;

  static const GSmithEventsOrderBy BLOCK_NUMBER_DESC =
      _$gSmithEventsOrderByBLOCK_NUMBER_DESC;

  static const GSmithEventsOrderBy SMITH_ID_ASC =
      _$gSmithEventsOrderBySMITH_ID_ASC;

  static const GSmithEventsOrderBy SMITH_ID_DESC =
      _$gSmithEventsOrderBySMITH_ID_DESC;

  static const GSmithEventsOrderBy EVENT_ID_ASC =
      _$gSmithEventsOrderByEVENT_ID_ASC;

  static const GSmithEventsOrderBy EVENT_ID_DESC =
      _$gSmithEventsOrderByEVENT_ID_DESC;

  static const GSmithEventsOrderBy PRIMARY_KEY_ASC =
      _$gSmithEventsOrderByPRIMARY_KEY_ASC;

  static const GSmithEventsOrderBy PRIMARY_KEY_DESC =
      _$gSmithEventsOrderByPRIMARY_KEY_DESC;

  static Serializer<GSmithEventsOrderBy> get serializer =>
      _$gSmithEventsOrderBySerializer;

  static BuiltSet<GSmithEventsOrderBy> get values =>
      _$gSmithEventsOrderByValues;

  static GSmithEventsOrderBy valueOf(String name) =>
      _$gSmithEventsOrderByValueOf(name);
}

abstract class GSmithFilter
    implements Built<GSmithFilter, GSmithFilterBuilder> {
  GSmithFilter._();

  factory GSmithFilter([void Function(GSmithFilterBuilder b) updates]) =
      _$GSmithFilter;

  GStringFilter? get id;
  GIntFilter? get index;
  GStringFilter? get smithStatus;
  GIntFilter? get lastChanged;
  GIntFilter? get forged;
  GIntFilter? get lastForged;
  GStringFilter? get identityId;
  BuiltList<GSmithFilter>? get and;
  BuiltList<GSmithFilter>? get or;
  GSmithFilter? get not;
  static Serializer<GSmithFilter> get serializer => _$gSmithFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFilter.serializer,
        json,
      );
}

class GSmithsOrderBy extends EnumClass {
  const GSmithsOrderBy._(String name) : super(name);

  static const GSmithsOrderBy NATURAL = _$gSmithsOrderByNATURAL;

  static const GSmithsOrderBy ID_ASC = _$gSmithsOrderByID_ASC;

  static const GSmithsOrderBy ID_DESC = _$gSmithsOrderByID_DESC;

  static const GSmithsOrderBy INDEX_ASC = _$gSmithsOrderByINDEX_ASC;

  static const GSmithsOrderBy INDEX_DESC = _$gSmithsOrderByINDEX_DESC;

  static const GSmithsOrderBy SMITH_STATUS_ASC =
      _$gSmithsOrderBySMITH_STATUS_ASC;

  static const GSmithsOrderBy SMITH_STATUS_DESC =
      _$gSmithsOrderBySMITH_STATUS_DESC;

  static const GSmithsOrderBy LAST_CHANGED_ASC =
      _$gSmithsOrderByLAST_CHANGED_ASC;

  static const GSmithsOrderBy LAST_CHANGED_DESC =
      _$gSmithsOrderByLAST_CHANGED_DESC;

  static const GSmithsOrderBy FORGED_ASC = _$gSmithsOrderByFORGED_ASC;

  static const GSmithsOrderBy FORGED_DESC = _$gSmithsOrderByFORGED_DESC;

  static const GSmithsOrderBy LAST_FORGED_ASC = _$gSmithsOrderByLAST_FORGED_ASC;

  static const GSmithsOrderBy LAST_FORGED_DESC =
      _$gSmithsOrderByLAST_FORGED_DESC;

  static const GSmithsOrderBy IDENTITY_ID_ASC = _$gSmithsOrderByIDENTITY_ID_ASC;

  static const GSmithsOrderBy IDENTITY_ID_DESC =
      _$gSmithsOrderByIDENTITY_ID_DESC;

  static const GSmithsOrderBy PRIMARY_KEY_ASC = _$gSmithsOrderByPRIMARY_KEY_ASC;

  static const GSmithsOrderBy PRIMARY_KEY_DESC =
      _$gSmithsOrderByPRIMARY_KEY_DESC;

  static Serializer<GSmithsOrderBy> get serializer =>
      _$gSmithsOrderBySerializer;

  static BuiltSet<GSmithsOrderBy> get values => _$gSmithsOrderByValues;

  static GSmithsOrderBy valueOf(String name) => _$gSmithsOrderByValueOf(name);
}

abstract class GStringFilter
    implements Built<GStringFilter, GStringFilterBuilder> {
  GStringFilter._();

  factory GStringFilter([void Function(GStringFilterBuilder b) updates]) =
      _$GStringFilter;

  bool? get isNull;
  String? get equalTo;
  String? get notEqualTo;
  String? get distinctFrom;
  String? get notDistinctFrom;
  @BuiltValueField(wireName: 'in')
  BuiltList<String>? get Gin;
  BuiltList<String>? get notIn;
  String? get lessThan;
  String? get lessThanOrEqualTo;
  String? get greaterThan;
  String? get greaterThanOrEqualTo;
  String? get includes;
  String? get notIncludes;
  String? get includesInsensitive;
  String? get notIncludesInsensitive;
  String? get startsWith;
  String? get notStartsWith;
  String? get startsWithInsensitive;
  String? get notStartsWithInsensitive;
  String? get endsWith;
  String? get notEndsWith;
  String? get endsWithInsensitive;
  String? get notEndsWithInsensitive;
  String? get like;
  String? get notLike;
  String? get likeInsensitive;
  String? get notLikeInsensitive;
  String? get equalToInsensitive;
  String? get notEqualToInsensitive;
  String? get distinctFromInsensitive;
  String? get notDistinctFromInsensitive;
  BuiltList<String>? get inInsensitive;
  BuiltList<String>? get notInInsensitive;
  String? get lessThanInsensitive;
  String? get lessThanOrEqualToInsensitive;
  String? get greaterThanInsensitive;
  String? get greaterThanOrEqualToInsensitive;
  static Serializer<GStringFilter> get serializer => _$gStringFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GStringFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GStringFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GStringFilter.serializer,
        json,
      );
}

abstract class GStringListFilter
    implements Built<GStringListFilter, GStringListFilterBuilder> {
  GStringListFilter._();

  factory GStringListFilter(
          [void Function(GStringListFilterBuilder b) updates]) =
      _$GStringListFilter;

  bool? get isNull;
  BuiltList<String?>? get equalTo;
  BuiltList<String?>? get notEqualTo;
  BuiltList<String?>? get distinctFrom;
  BuiltList<String?>? get notDistinctFrom;
  BuiltList<String?>? get lessThan;
  BuiltList<String?>? get lessThanOrEqualTo;
  BuiltList<String?>? get greaterThan;
  BuiltList<String?>? get greaterThanOrEqualTo;
  BuiltList<String?>? get contains;
  BuiltList<String?>? get containedBy;
  BuiltList<String?>? get overlaps;
  String? get anyEqualTo;
  String? get anyNotEqualTo;
  String? get anyLessThan;
  String? get anyLessThanOrEqualTo;
  String? get anyGreaterThan;
  String? get anyGreaterThanOrEqualTo;
  static Serializer<GStringListFilter> get serializer =>
      _$gStringListFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GStringListFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GStringListFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GStringListFilter.serializer,
        json,
      );
}

abstract class GTransferCondition
    implements Built<GTransferCondition, GTransferConditionBuilder> {
  GTransferCondition._();

  factory GTransferCondition(
          [void Function(GTransferConditionBuilder b) updates]) =
      _$GTransferCondition;

  String? get id;
  int? get blockNumber;
  GDatetime? get timestamp;
  GBigFloat? get amount;
  String? get fromId;
  String? get toId;
  String? get eventId;
  String? get commentId;
  static Serializer<GTransferCondition> get serializer =>
      _$gTransferConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferCondition.serializer,
        json,
      );
}

abstract class GTransferFilter
    implements Built<GTransferFilter, GTransferFilterBuilder> {
  GTransferFilter._();

  factory GTransferFilter([void Function(GTransferFilterBuilder b) updates]) =
      _$GTransferFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GDatetimeFilter? get timestamp;
  GBigFloatFilter? get amount;
  GStringFilter? get fromId;
  GStringFilter? get toId;
  GStringFilter? get eventId;
  GStringFilter? get commentId;
  BuiltList<GTransferFilter>? get and;
  BuiltList<GTransferFilter>? get or;
  GTransferFilter? get not;
  static Serializer<GTransferFilter> get serializer =>
      _$gTransferFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFilter.serializer,
        json,
      );
}

class GTransfersOrderBy extends EnumClass {
  const GTransfersOrderBy._(String name) : super(name);

  static const GTransfersOrderBy NATURAL = _$gTransfersOrderByNATURAL;

  static const GTransfersOrderBy ID_ASC = _$gTransfersOrderByID_ASC;

  static const GTransfersOrderBy ID_DESC = _$gTransfersOrderByID_DESC;

  static const GTransfersOrderBy BLOCK_NUMBER_ASC =
      _$gTransfersOrderByBLOCK_NUMBER_ASC;

  static const GTransfersOrderBy BLOCK_NUMBER_DESC =
      _$gTransfersOrderByBLOCK_NUMBER_DESC;

  static const GTransfersOrderBy TIMESTAMP_ASC =
      _$gTransfersOrderByTIMESTAMP_ASC;

  static const GTransfersOrderBy TIMESTAMP_DESC =
      _$gTransfersOrderByTIMESTAMP_DESC;

  static const GTransfersOrderBy AMOUNT_ASC = _$gTransfersOrderByAMOUNT_ASC;

  static const GTransfersOrderBy AMOUNT_DESC = _$gTransfersOrderByAMOUNT_DESC;

  static const GTransfersOrderBy FROM_ID_ASC = _$gTransfersOrderByFROM_ID_ASC;

  static const GTransfersOrderBy FROM_ID_DESC = _$gTransfersOrderByFROM_ID_DESC;

  static const GTransfersOrderBy TO_ID_ASC = _$gTransfersOrderByTO_ID_ASC;

  static const GTransfersOrderBy TO_ID_DESC = _$gTransfersOrderByTO_ID_DESC;

  static const GTransfersOrderBy EVENT_ID_ASC = _$gTransfersOrderByEVENT_ID_ASC;

  static const GTransfersOrderBy EVENT_ID_DESC =
      _$gTransfersOrderByEVENT_ID_DESC;

  static const GTransfersOrderBy COMMENT_ID_ASC =
      _$gTransfersOrderByCOMMENT_ID_ASC;

  static const GTransfersOrderBy COMMENT_ID_DESC =
      _$gTransfersOrderByCOMMENT_ID_DESC;

  static const GTransfersOrderBy PRIMARY_KEY_ASC =
      _$gTransfersOrderByPRIMARY_KEY_ASC;

  static const GTransfersOrderBy PRIMARY_KEY_DESC =
      _$gTransfersOrderByPRIMARY_KEY_DESC;

  static Serializer<GTransfersOrderBy> get serializer =>
      _$gTransfersOrderBySerializer;

  static BuiltSet<GTransfersOrderBy> get values => _$gTransfersOrderByValues;

  static GTransfersOrderBy valueOf(String name) =>
      _$gTransfersOrderByValueOf(name);
}

abstract class GTransferWithUdFilter
    implements Built<GTransferWithUdFilter, GTransferWithUdFilterBuilder> {
  GTransferWithUdFilter._();

  factory GTransferWithUdFilter(
          [void Function(GTransferWithUdFilterBuilder b) updates]) =
      _$GTransferWithUdFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GDatetimeFilter? get timestamp;
  GStringFilter? get fromId;
  GStringFilter? get toId;
  GBigFloatFilter? get amount;
  GStringFilter? get eventId;
  GStringFilter? get commentId;
  GBooleanFilter? get isUd;
  GBigFloatFilter? get udAmount;
  GStringFilter? get udIdentityId;
  BuiltList<GTransferWithUdFilter>? get and;
  BuiltList<GTransferWithUdFilter>? get or;
  GTransferWithUdFilter? get not;
  static Serializer<GTransferWithUdFilter> get serializer =>
      _$gTransferWithUdFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferWithUdFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferWithUdFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferWithUdFilter.serializer,
        json,
      );
}

class GTransferWithUdOrderBy extends EnumClass {
  const GTransferWithUdOrderBy._(String name) : super(name);

  static const GTransferWithUdOrderBy BLOCK_NUMBER_ASC =
      _$gTransferWithUdOrderByBLOCK_NUMBER_ASC;

  static const GTransferWithUdOrderBy BLOCK_NUMBER_DESC =
      _$gTransferWithUdOrderByBLOCK_NUMBER_DESC;

  static const GTransferWithUdOrderBy TIMESTAMP_ASC =
      _$gTransferWithUdOrderByTIMESTAMP_ASC;

  static const GTransferWithUdOrderBy TIMESTAMP_DESC =
      _$gTransferWithUdOrderByTIMESTAMP_DESC;

  static const GTransferWithUdOrderBy AMOUNT_ASC =
      _$gTransferWithUdOrderByAMOUNT_ASC;

  static const GTransferWithUdOrderBy AMOUNT_DESC =
      _$gTransferWithUdOrderByAMOUNT_DESC;

  static Serializer<GTransferWithUdOrderBy> get serializer =>
      _$gTransferWithUdOrderBySerializer;

  static BuiltSet<GTransferWithUdOrderBy> get values =>
      _$gTransferWithUdOrderByValues;

  static GTransferWithUdOrderBy valueOf(String name) =>
      _$gTransferWithUdOrderByValueOf(name);
}

abstract class GTxCommentCondition
    implements Built<GTxCommentCondition, GTxCommentConditionBuilder> {
  GTxCommentCondition._();

  factory GTxCommentCondition(
          [void Function(GTxCommentConditionBuilder b) updates]) =
      _$GTxCommentCondition;

  String? get id;
  int? get blockNumber;
  String? get remarkBytes;
  String? get remark;
  String? get hash;
  String? get type;
  String? get authorId;
  String? get eventId;
  static Serializer<GTxCommentCondition> get serializer =>
      _$gTxCommentConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentCondition.serializer,
        json,
      );
}

abstract class GTxCommentFilter
    implements Built<GTxCommentFilter, GTxCommentFilterBuilder> {
  GTxCommentFilter._();

  factory GTxCommentFilter([void Function(GTxCommentFilterBuilder b) updates]) =
      _$GTxCommentFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GStringFilter? get remark;
  GStringFilter? get hash;
  GStringFilter? get type;
  GStringFilter? get authorId;
  GStringFilter? get eventId;
  BuiltList<GTxCommentFilter>? get and;
  BuiltList<GTxCommentFilter>? get or;
  GTxCommentFilter? get not;
  static Serializer<GTxCommentFilter> get serializer =>
      _$gTxCommentFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTxCommentFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTxCommentFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTxCommentFilter.serializer,
        json,
      );
}

class GTxCommentsOrderBy extends EnumClass {
  const GTxCommentsOrderBy._(String name) : super(name);

  static const GTxCommentsOrderBy NATURAL = _$gTxCommentsOrderByNATURAL;

  static const GTxCommentsOrderBy ID_ASC = _$gTxCommentsOrderByID_ASC;

  static const GTxCommentsOrderBy ID_DESC = _$gTxCommentsOrderByID_DESC;

  static const GTxCommentsOrderBy BLOCK_NUMBER_ASC =
      _$gTxCommentsOrderByBLOCK_NUMBER_ASC;

  static const GTxCommentsOrderBy BLOCK_NUMBER_DESC =
      _$gTxCommentsOrderByBLOCK_NUMBER_DESC;

  static const GTxCommentsOrderBy REMARK_BYTES_ASC =
      _$gTxCommentsOrderByREMARK_BYTES_ASC;

  static const GTxCommentsOrderBy REMARK_BYTES_DESC =
      _$gTxCommentsOrderByREMARK_BYTES_DESC;

  static const GTxCommentsOrderBy REMARK_ASC = _$gTxCommentsOrderByREMARK_ASC;

  static const GTxCommentsOrderBy REMARK_DESC = _$gTxCommentsOrderByREMARK_DESC;

  static const GTxCommentsOrderBy HASH_ASC = _$gTxCommentsOrderByHASH_ASC;

  static const GTxCommentsOrderBy HASH_DESC = _$gTxCommentsOrderByHASH_DESC;

  static const GTxCommentsOrderBy TYPE_ASC = _$gTxCommentsOrderByTYPE_ASC;

  static const GTxCommentsOrderBy TYPE_DESC = _$gTxCommentsOrderByTYPE_DESC;

  static const GTxCommentsOrderBy AUTHOR_ID_ASC =
      _$gTxCommentsOrderByAUTHOR_ID_ASC;

  static const GTxCommentsOrderBy AUTHOR_ID_DESC =
      _$gTxCommentsOrderByAUTHOR_ID_DESC;

  static const GTxCommentsOrderBy EVENT_ID_ASC =
      _$gTxCommentsOrderByEVENT_ID_ASC;

  static const GTxCommentsOrderBy EVENT_ID_DESC =
      _$gTxCommentsOrderByEVENT_ID_DESC;

  static const GTxCommentsOrderBy PRIMARY_KEY_ASC =
      _$gTxCommentsOrderByPRIMARY_KEY_ASC;

  static const GTxCommentsOrderBy PRIMARY_KEY_DESC =
      _$gTxCommentsOrderByPRIMARY_KEY_DESC;

  static Serializer<GTxCommentsOrderBy> get serializer =>
      _$gTxCommentsOrderBySerializer;

  static BuiltSet<GTxCommentsOrderBy> get values => _$gTxCommentsOrderByValues;

  static GTxCommentsOrderBy valueOf(String name) =>
      _$gTxCommentsOrderByValueOf(name);
}

class GUdHistoriesOrderBy extends EnumClass {
  const GUdHistoriesOrderBy._(String name) : super(name);

  static const GUdHistoriesOrderBy NATURAL = _$gUdHistoriesOrderByNATURAL;

  static const GUdHistoriesOrderBy ID_ASC = _$gUdHistoriesOrderByID_ASC;

  static const GUdHistoriesOrderBy ID_DESC = _$gUdHistoriesOrderByID_DESC;

  static const GUdHistoriesOrderBy AMOUNT_ASC = _$gUdHistoriesOrderByAMOUNT_ASC;

  static const GUdHistoriesOrderBy AMOUNT_DESC =
      _$gUdHistoriesOrderByAMOUNT_DESC;

  static const GUdHistoriesOrderBy BLOCK_NUMBER_ASC =
      _$gUdHistoriesOrderByBLOCK_NUMBER_ASC;

  static const GUdHistoriesOrderBy BLOCK_NUMBER_DESC =
      _$gUdHistoriesOrderByBLOCK_NUMBER_DESC;

  static const GUdHistoriesOrderBy TIMESTAMP_ASC =
      _$gUdHistoriesOrderByTIMESTAMP_ASC;

  static const GUdHistoriesOrderBy TIMESTAMP_DESC =
      _$gUdHistoriesOrderByTIMESTAMP_DESC;

  static const GUdHistoriesOrderBy IDENTITY_ID_ASC =
      _$gUdHistoriesOrderByIDENTITY_ID_ASC;

  static const GUdHistoriesOrderBy IDENTITY_ID_DESC =
      _$gUdHistoriesOrderByIDENTITY_ID_DESC;

  static const GUdHistoriesOrderBy PRIMARY_KEY_ASC =
      _$gUdHistoriesOrderByPRIMARY_KEY_ASC;

  static const GUdHistoriesOrderBy PRIMARY_KEY_DESC =
      _$gUdHistoriesOrderByPRIMARY_KEY_DESC;

  static Serializer<GUdHistoriesOrderBy> get serializer =>
      _$gUdHistoriesOrderBySerializer;

  static BuiltSet<GUdHistoriesOrderBy> get values =>
      _$gUdHistoriesOrderByValues;

  static GUdHistoriesOrderBy valueOf(String name) =>
      _$gUdHistoriesOrderByValueOf(name);
}

abstract class GUdHistoryCondition
    implements Built<GUdHistoryCondition, GUdHistoryConditionBuilder> {
  GUdHistoryCondition._();

  factory GUdHistoryCondition(
          [void Function(GUdHistoryConditionBuilder b) updates]) =
      _$GUdHistoryCondition;

  String? get id;
  GBigFloat? get amount;
  int? get blockNumber;
  GDatetime? get timestamp;
  String? get identityId;
  static Serializer<GUdHistoryCondition> get serializer =>
      _$gUdHistoryConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryCondition.serializer,
        json,
      );
}

abstract class GUdHistoryFilter
    implements Built<GUdHistoryFilter, GUdHistoryFilterBuilder> {
  GUdHistoryFilter._();

  factory GUdHistoryFilter([void Function(GUdHistoryFilterBuilder b) updates]) =
      _$GUdHistoryFilter;

  GStringFilter? get id;
  GBigFloatFilter? get amount;
  GIntFilter? get blockNumber;
  GDatetimeFilter? get timestamp;
  GStringFilter? get identityId;
  BuiltList<GUdHistoryFilter>? get and;
  BuiltList<GUdHistoryFilter>? get or;
  GUdHistoryFilter? get not;
  static Serializer<GUdHistoryFilter> get serializer =>
      _$gUdHistoryFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdHistoryFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdHistoryFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdHistoryFilter.serializer,
        json,
      );
}

class GUdHistoryOrderBy extends EnumClass {
  const GUdHistoryOrderBy._(String name) : super(name);

  static const GUdHistoryOrderBy BLOCK_NUMBER_ASC =
      _$gUdHistoryOrderByBLOCK_NUMBER_ASC;

  static const GUdHistoryOrderBy BLOCK_NUMBER_DESC =
      _$gUdHistoryOrderByBLOCK_NUMBER_DESC;

  static const GUdHistoryOrderBy TIMESTAMP_ASC =
      _$gUdHistoryOrderByTIMESTAMP_ASC;

  static const GUdHistoryOrderBy TIMESTAMP_DESC =
      _$gUdHistoryOrderByTIMESTAMP_DESC;

  static const GUdHistoryOrderBy AMOUNT_ASC = _$gUdHistoryOrderByAMOUNT_ASC;

  static const GUdHistoryOrderBy AMOUNT_DESC = _$gUdHistoryOrderByAMOUNT_DESC;

  static Serializer<GUdHistoryOrderBy> get serializer =>
      _$gUdHistoryOrderBySerializer;

  static BuiltSet<GUdHistoryOrderBy> get values => _$gUdHistoryOrderByValues;

  static GUdHistoryOrderBy valueOf(String name) =>
      _$gUdHistoryOrderByValueOf(name);
}

abstract class GUdReevalCondition
    implements Built<GUdReevalCondition, GUdReevalConditionBuilder> {
  GUdReevalCondition._();

  factory GUdReevalCondition(
          [void Function(GUdReevalConditionBuilder b) updates]) =
      _$GUdReevalCondition;

  String? get id;
  int? get blockNumber;
  GDatetime? get timestamp;
  GBigFloat? get newUdAmount;
  GBigFloat? get monetaryMass;
  int? get membersCount;
  int? get udIndex;
  String? get eventId;
  static Serializer<GUdReevalCondition> get serializer =>
      _$gUdReevalConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalCondition.serializer,
        json,
      );
}

abstract class GUdReevalFilter
    implements Built<GUdReevalFilter, GUdReevalFilterBuilder> {
  GUdReevalFilter._();

  factory GUdReevalFilter([void Function(GUdReevalFilterBuilder b) updates]) =
      _$GUdReevalFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GDatetimeFilter? get timestamp;
  GBigFloatFilter? get newUdAmount;
  GBigFloatFilter? get monetaryMass;
  GIntFilter? get membersCount;
  GIntFilter? get udIndex;
  GStringFilter? get eventId;
  BuiltList<GUdReevalFilter>? get and;
  BuiltList<GUdReevalFilter>? get or;
  GUdReevalFilter? get not;
  static Serializer<GUdReevalFilter> get serializer =>
      _$gUdReevalFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUdReevalFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUdReevalFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUdReevalFilter.serializer,
        json,
      );
}

class GUdReevalsOrderBy extends EnumClass {
  const GUdReevalsOrderBy._(String name) : super(name);

  static const GUdReevalsOrderBy NATURAL = _$gUdReevalsOrderByNATURAL;

  static const GUdReevalsOrderBy ID_ASC = _$gUdReevalsOrderByID_ASC;

  static const GUdReevalsOrderBy ID_DESC = _$gUdReevalsOrderByID_DESC;

  static const GUdReevalsOrderBy BLOCK_NUMBER_ASC =
      _$gUdReevalsOrderByBLOCK_NUMBER_ASC;

  static const GUdReevalsOrderBy BLOCK_NUMBER_DESC =
      _$gUdReevalsOrderByBLOCK_NUMBER_DESC;

  static const GUdReevalsOrderBy TIMESTAMP_ASC =
      _$gUdReevalsOrderByTIMESTAMP_ASC;

  static const GUdReevalsOrderBy TIMESTAMP_DESC =
      _$gUdReevalsOrderByTIMESTAMP_DESC;

  static const GUdReevalsOrderBy NEW_UD_AMOUNT_ASC =
      _$gUdReevalsOrderByNEW_UD_AMOUNT_ASC;

  static const GUdReevalsOrderBy NEW_UD_AMOUNT_DESC =
      _$gUdReevalsOrderByNEW_UD_AMOUNT_DESC;

  static const GUdReevalsOrderBy MONETARY_MASS_ASC =
      _$gUdReevalsOrderByMONETARY_MASS_ASC;

  static const GUdReevalsOrderBy MONETARY_MASS_DESC =
      _$gUdReevalsOrderByMONETARY_MASS_DESC;

  static const GUdReevalsOrderBy MEMBERS_COUNT_ASC =
      _$gUdReevalsOrderByMEMBERS_COUNT_ASC;

  static const GUdReevalsOrderBy MEMBERS_COUNT_DESC =
      _$gUdReevalsOrderByMEMBERS_COUNT_DESC;

  static const GUdReevalsOrderBy UD_INDEX_ASC = _$gUdReevalsOrderByUD_INDEX_ASC;

  static const GUdReevalsOrderBy UD_INDEX_DESC =
      _$gUdReevalsOrderByUD_INDEX_DESC;

  static const GUdReevalsOrderBy EVENT_ID_ASC = _$gUdReevalsOrderByEVENT_ID_ASC;

  static const GUdReevalsOrderBy EVENT_ID_DESC =
      _$gUdReevalsOrderByEVENT_ID_DESC;

  static const GUdReevalsOrderBy PRIMARY_KEY_ASC =
      _$gUdReevalsOrderByPRIMARY_KEY_ASC;

  static const GUdReevalsOrderBy PRIMARY_KEY_DESC =
      _$gUdReevalsOrderByPRIMARY_KEY_DESC;

  static Serializer<GUdReevalsOrderBy> get serializer =>
      _$gUdReevalsOrderBySerializer;

  static BuiltSet<GUdReevalsOrderBy> get values => _$gUdReevalsOrderByValues;

  static GUdReevalsOrderBy valueOf(String name) =>
      _$gUdReevalsOrderByValueOf(name);
}

abstract class GUniversalDividendCondition
    implements
        Built<GUniversalDividendCondition, GUniversalDividendConditionBuilder> {
  GUniversalDividendCondition._();

  factory GUniversalDividendCondition(
          [void Function(GUniversalDividendConditionBuilder b) updates]) =
      _$GUniversalDividendCondition;

  String? get id;
  int? get blockNumber;
  GDatetime? get timestamp;
  GBigFloat? get amount;
  GBigFloat? get monetaryMass;
  int? get membersCount;
  int? get index;
  String? get eventId;
  static Serializer<GUniversalDividendCondition> get serializer =>
      _$gUniversalDividendConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendCondition.serializer,
        json,
      );
}

abstract class GUniversalDividendFilter
    implements
        Built<GUniversalDividendFilter, GUniversalDividendFilterBuilder> {
  GUniversalDividendFilter._();

  factory GUniversalDividendFilter(
          [void Function(GUniversalDividendFilterBuilder b) updates]) =
      _$GUniversalDividendFilter;

  GStringFilter? get id;
  GIntFilter? get blockNumber;
  GDatetimeFilter? get timestamp;
  GBigFloatFilter? get amount;
  GBigFloatFilter? get monetaryMass;
  GIntFilter? get membersCount;
  GIntFilter? get index;
  GStringFilter? get eventId;
  BuiltList<GUniversalDividendFilter>? get and;
  BuiltList<GUniversalDividendFilter>? get or;
  GUniversalDividendFilter? get not;
  static Serializer<GUniversalDividendFilter> get serializer =>
      _$gUniversalDividendFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUniversalDividendFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUniversalDividendFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUniversalDividendFilter.serializer,
        json,
      );
}

class GUniversalDividendsOrderBy extends EnumClass {
  const GUniversalDividendsOrderBy._(String name) : super(name);

  static const GUniversalDividendsOrderBy NATURAL =
      _$gUniversalDividendsOrderByNATURAL;

  static const GUniversalDividendsOrderBy ID_ASC =
      _$gUniversalDividendsOrderByID_ASC;

  static const GUniversalDividendsOrderBy ID_DESC =
      _$gUniversalDividendsOrderByID_DESC;

  static const GUniversalDividendsOrderBy BLOCK_NUMBER_ASC =
      _$gUniversalDividendsOrderByBLOCK_NUMBER_ASC;

  static const GUniversalDividendsOrderBy BLOCK_NUMBER_DESC =
      _$gUniversalDividendsOrderByBLOCK_NUMBER_DESC;

  static const GUniversalDividendsOrderBy TIMESTAMP_ASC =
      _$gUniversalDividendsOrderByTIMESTAMP_ASC;

  static const GUniversalDividendsOrderBy TIMESTAMP_DESC =
      _$gUniversalDividendsOrderByTIMESTAMP_DESC;

  static const GUniversalDividendsOrderBy AMOUNT_ASC =
      _$gUniversalDividendsOrderByAMOUNT_ASC;

  static const GUniversalDividendsOrderBy AMOUNT_DESC =
      _$gUniversalDividendsOrderByAMOUNT_DESC;

  static const GUniversalDividendsOrderBy MONETARY_MASS_ASC =
      _$gUniversalDividendsOrderByMONETARY_MASS_ASC;

  static const GUniversalDividendsOrderBy MONETARY_MASS_DESC =
      _$gUniversalDividendsOrderByMONETARY_MASS_DESC;

  static const GUniversalDividendsOrderBy MEMBERS_COUNT_ASC =
      _$gUniversalDividendsOrderByMEMBERS_COUNT_ASC;

  static const GUniversalDividendsOrderBy MEMBERS_COUNT_DESC =
      _$gUniversalDividendsOrderByMEMBERS_COUNT_DESC;

  static const GUniversalDividendsOrderBy INDEX_ASC =
      _$gUniversalDividendsOrderByINDEX_ASC;

  static const GUniversalDividendsOrderBy INDEX_DESC =
      _$gUniversalDividendsOrderByINDEX_DESC;

  static const GUniversalDividendsOrderBy EVENT_ID_ASC =
      _$gUniversalDividendsOrderByEVENT_ID_ASC;

  static const GUniversalDividendsOrderBy EVENT_ID_DESC =
      _$gUniversalDividendsOrderByEVENT_ID_DESC;

  static const GUniversalDividendsOrderBy PRIMARY_KEY_ASC =
      _$gUniversalDividendsOrderByPRIMARY_KEY_ASC;

  static const GUniversalDividendsOrderBy PRIMARY_KEY_DESC =
      _$gUniversalDividendsOrderByPRIMARY_KEY_DESC;

  static Serializer<GUniversalDividendsOrderBy> get serializer =>
      _$gUniversalDividendsOrderBySerializer;

  static BuiltSet<GUniversalDividendsOrderBy> get values =>
      _$gUniversalDividendsOrderByValues;

  static GUniversalDividendsOrderBy valueOf(String name) =>
      _$gUniversalDividendsOrderByValueOf(name);
}

abstract class GValidatorCondition
    implements Built<GValidatorCondition, GValidatorConditionBuilder> {
  GValidatorCondition._();

  factory GValidatorCondition(
          [void Function(GValidatorConditionBuilder b) updates]) =
      _$GValidatorCondition;

  String? get id;
  int? get index;
  static Serializer<GValidatorCondition> get serializer =>
      _$gValidatorConditionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorCondition.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorCondition? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorCondition.serializer,
        json,
      );
}

abstract class GValidatorFilter
    implements Built<GValidatorFilter, GValidatorFilterBuilder> {
  GValidatorFilter._();

  factory GValidatorFilter([void Function(GValidatorFilterBuilder b) updates]) =
      _$GValidatorFilter;

  GStringFilter? get id;
  GIntFilter? get index;
  BuiltList<GValidatorFilter>? get and;
  BuiltList<GValidatorFilter>? get or;
  GValidatorFilter? get not;
  static Serializer<GValidatorFilter> get serializer =>
      _$gValidatorFilterSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GValidatorFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GValidatorFilter? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GValidatorFilter.serializer,
        json,
      );
}

class GValidatorsOrderBy extends EnumClass {
  const GValidatorsOrderBy._(String name) : super(name);

  static const GValidatorsOrderBy NATURAL = _$gValidatorsOrderByNATURAL;

  static const GValidatorsOrderBy ID_ASC = _$gValidatorsOrderByID_ASC;

  static const GValidatorsOrderBy ID_DESC = _$gValidatorsOrderByID_DESC;

  static const GValidatorsOrderBy INDEX_ASC = _$gValidatorsOrderByINDEX_ASC;

  static const GValidatorsOrderBy INDEX_DESC = _$gValidatorsOrderByINDEX_DESC;

  static const GValidatorsOrderBy PRIMARY_KEY_ASC =
      _$gValidatorsOrderByPRIMARY_KEY_ASC;

  static const GValidatorsOrderBy PRIMARY_KEY_DESC =
      _$gValidatorsOrderByPRIMARY_KEY_DESC;

  static Serializer<GValidatorsOrderBy> get serializer =>
      _$gValidatorsOrderBySerializer;

  static BuiltSet<GValidatorsOrderBy> get values => _$gValidatorsOrderByValues;

  static GValidatorsOrderBy valueOf(String name) =>
      _$gValidatorsOrderByValueOf(name);
}

const Map<String, Set<String>> possibleTypesMap = {
  'Node': {
    'Account',
    'Block',
    'Call',
    'Cert',
    'CertEvent',
    'ChangeOwnerKey',
    'Event',
    'Extrinsic',
    'Identity',
    'ItemsCounter',
    'MembershipEvent',
    'Migration',
    'PopulationHistory',
    'Query',
    'Smith',
    'SmithCert',
    'SmithEvent',
    'Transfer',
    'TxComment',
    'UdHistory',
    'UdReeval',
    'UniversalDividend',
    'Validator',
  }
};
