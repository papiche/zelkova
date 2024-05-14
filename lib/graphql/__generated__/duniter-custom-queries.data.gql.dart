// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ginkgo/graphql/__generated__/duniter-indexer.schema.gql.dart'
    as _i2;
import 'package:ginkgo/graphql/__generated__/serializers.gql.dart' as _i1;

part 'duniter-custom-queries.data.gql.g.dart';

abstract class GAccountsByPkData
    implements Built<GAccountsByPkData, GAccountsByPkDataBuilder> {
  GAccountsByPkData._();

  factory GAccountsByPkData([Function(GAccountsByPkDataBuilder b) updates]) =
      _$GAccountsByPkData;

  static void _initializeBuilder(GAccountsByPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByPkData_account_by_pk? get account_by_pk;
  static Serializer<GAccountsByPkData> get serializer =>
      _$gAccountsByPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_by_pk
    implements
        Built<GAccountsByPkData_account_by_pk,
            GAccountsByPkData_account_by_pkBuilder> {
  GAccountsByPkData_account_by_pk._();

  factory GAccountsByPkData_account_by_pk(
          [Function(GAccountsByPkData_account_by_pkBuilder b) updates]) =
      _$GAccountsByPkData_account_by_pk;

  static void _initializeBuilder(GAccountsByPkData_account_by_pkBuilder b) =>
      b..G__typename = 'account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByPkData_account_by_pk_identity? get identity;
  String get pubkey;
  static Serializer<GAccountsByPkData_account_by_pk> get serializer =>
      _$gAccountsByPkDataAccountByPkSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_by_pk.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_by_pk? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_by_pk.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_by_pk_identity
    implements
        Built<GAccountsByPkData_account_by_pk_identity,
            GAccountsByPkData_account_by_pk_identityBuilder> {
  GAccountsByPkData_account_by_pk_identity._();

  factory GAccountsByPkData_account_by_pk_identity(
      [Function(GAccountsByPkData_account_by_pk_identityBuilder b)
          updates]) = _$GAccountsByPkData_account_by_pk_identity;

  static void _initializeBuilder(
          GAccountsByPkData_account_by_pk_identityBuilder b) =>
      b..G__typename = 'identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get name;
  static Serializer<GAccountsByPkData_account_by_pk_identity> get serializer =>
      _$gAccountsByPkDataAccountByPkIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_by_pk_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_by_pk_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_by_pk_identity.serializer,
        json,
      );
}

abstract class GSearchIdentityData
    implements Built<GSearchIdentityData, GSearchIdentityDataBuilder> {
  GSearchIdentityData._();

  factory GSearchIdentityData(
      [Function(GSearchIdentityDataBuilder b) updates]) = _$GSearchIdentityData;

  static void _initializeBuilder(GSearchIdentityDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchIdentityData_search_identity> get search_identity;
  static Serializer<GSearchIdentityData> get serializer =>
      _$gSearchIdentityDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchIdentityData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchIdentityData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchIdentityData.serializer,
        json,
      );
}

abstract class GSearchIdentityData_search_identity
    implements
        Built<GSearchIdentityData_search_identity,
            GSearchIdentityData_search_identityBuilder> {
  GSearchIdentityData_search_identity._();

  factory GSearchIdentityData_search_identity(
          [Function(GSearchIdentityData_search_identityBuilder b) updates]) =
      _$GSearchIdentityData_search_identity;

  static void _initializeBuilder(
          GSearchIdentityData_search_identityBuilder b) =>
      b..G__typename = 'identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get pubkey;
  String? get name;
  static Serializer<GSearchIdentityData_search_identity> get serializer =>
      _$gSearchIdentityDataSearchIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchIdentityData_search_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchIdentityData_search_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchIdentityData_search_identity.serializer,
        json,
      );
}

abstract class GLastIndexedBlockNumberData
    implements
        Built<GLastIndexedBlockNumberData, GLastIndexedBlockNumberDataBuilder> {
  GLastIndexedBlockNumberData._();

  factory GLastIndexedBlockNumberData(
          [Function(GLastIndexedBlockNumberDataBuilder b) updates]) =
      _$GLastIndexedBlockNumberData;

  static void _initializeBuilder(GLastIndexedBlockNumberDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLastIndexedBlockNumberData_parameters_by_pk? get parameters_by_pk;
  static Serializer<GLastIndexedBlockNumberData> get serializer =>
      _$gLastIndexedBlockNumberDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastIndexedBlockNumberData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastIndexedBlockNumberData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastIndexedBlockNumberData.serializer,
        json,
      );
}

abstract class GLastIndexedBlockNumberData_parameters_by_pk
    implements
        Built<GLastIndexedBlockNumberData_parameters_by_pk,
            GLastIndexedBlockNumberData_parameters_by_pkBuilder> {
  GLastIndexedBlockNumberData_parameters_by_pk._();

  factory GLastIndexedBlockNumberData_parameters_by_pk(
      [Function(GLastIndexedBlockNumberData_parameters_by_pkBuilder b)
          updates]) = _$GLastIndexedBlockNumberData_parameters_by_pk;

  static void _initializeBuilder(
          GLastIndexedBlockNumberData_parameters_by_pkBuilder b) =>
      b..G__typename = 'parameters';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i2.Gjsonb? get value;
  static Serializer<GLastIndexedBlockNumberData_parameters_by_pk>
      get serializer => _$gLastIndexedBlockNumberDataParametersByPkSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastIndexedBlockNumberData_parameters_by_pk.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastIndexedBlockNumberData_parameters_by_pk? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastIndexedBlockNumberData_parameters_by_pk.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData
    implements Built<GAccountsByNameOrPkData, GAccountsByNameOrPkDataBuilder> {
  GAccountsByNameOrPkData._();

  factory GAccountsByNameOrPkData(
          [Function(GAccountsByNameOrPkDataBuilder b) updates]) =
      _$GAccountsByNameOrPkData;

  static void _initializeBuilder(GAccountsByNameOrPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsByNameOrPkData_account> get account;
  static Serializer<GAccountsByNameOrPkData> get serializer =>
      _$gAccountsByNameOrPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData_account
    implements
        Built<GAccountsByNameOrPkData_account,
            GAccountsByNameOrPkData_accountBuilder> {
  GAccountsByNameOrPkData_account._();

  factory GAccountsByNameOrPkData_account(
          [Function(GAccountsByNameOrPkData_accountBuilder b) updates]) =
      _$GAccountsByNameOrPkData_account;

  static void _initializeBuilder(GAccountsByNameOrPkData_accountBuilder b) =>
      b..G__typename = 'account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByNameOrPkData_account_identity? get identity;
  static Serializer<GAccountsByNameOrPkData_account> get serializer =>
      _$gAccountsByNameOrPkDataAccountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_account? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_account.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData_account_identity
    implements
        Built<GAccountsByNameOrPkData_account_identity,
            GAccountsByNameOrPkData_account_identityBuilder> {
  GAccountsByNameOrPkData_account_identity._();

  factory GAccountsByNameOrPkData_account_identity(
      [Function(GAccountsByNameOrPkData_account_identityBuilder b)
          updates]) = _$GAccountsByNameOrPkData_account_identity;

  static void _initializeBuilder(
          GAccountsByNameOrPkData_account_identityBuilder b) =>
      b..G__typename = 'identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByNameOrPkData_account_identity_account? get account;
  static Serializer<GAccountsByNameOrPkData_account_identity> get serializer =>
      _$gAccountsByNameOrPkDataAccountIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_account_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_account_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_account_identity.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData_account_identity_account
    implements
        Built<GAccountsByNameOrPkData_account_identity_account,
            GAccountsByNameOrPkData_account_identity_accountBuilder> {
  GAccountsByNameOrPkData_account_identity_account._();

  factory GAccountsByNameOrPkData_account_identity_account(
      [Function(GAccountsByNameOrPkData_account_identity_accountBuilder b)
          updates]) = _$GAccountsByNameOrPkData_account_identity_account;

  static void _initializeBuilder(
          GAccountsByNameOrPkData_account_identity_accountBuilder b) =>
      b..G__typename = 'account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByNameOrPkData_account_identity_account_identity? get identity;
  static Serializer<GAccountsByNameOrPkData_account_identity_account>
      get serializer =>
          _$gAccountsByNameOrPkDataAccountIdentityAccountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_account_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_account_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_account_identity_account.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData_account_identity_account_identity
    implements
        Built<GAccountsByNameOrPkData_account_identity_account_identity,
            GAccountsByNameOrPkData_account_identity_account_identityBuilder> {
  GAccountsByNameOrPkData_account_identity_account_identity._();

  factory GAccountsByNameOrPkData_account_identity_account_identity(
      [Function(
              GAccountsByNameOrPkData_account_identity_account_identityBuilder
                  b)
          updates]) = _$GAccountsByNameOrPkData_account_identity_account_identity;

  static void _initializeBuilder(
          GAccountsByNameOrPkData_account_identity_account_identityBuilder b) =>
      b..G__typename = 'identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get name;
  String get pubkey;
  static Serializer<GAccountsByNameOrPkData_account_identity_account_identity>
      get serializer =>
          _$gAccountsByNameOrPkDataAccountIdentityAccountIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_account_identity_account_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_account_identity_account_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_account_identity_account_identity.serializer,
        json,
      );
}
