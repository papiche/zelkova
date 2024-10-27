// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ginkgo/data/models/duniter-indexer/__generated__/duniter-indexer.schema.gql.dart'
    as _i2;
import 'package:ginkgo/data/models/duniter-indexer/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-queries.data.gql.g.dart';

abstract class GAccountsByNameOrPkData
    implements Built<GAccountsByNameOrPkData, GAccountsByNameOrPkDataBuilder> {
  GAccountsByNameOrPkData._();

  factory GAccountsByNameOrPkData(
          [void Function(GAccountsByNameOrPkDataBuilder b) updates]) =
      _$GAccountsByNameOrPkData;

  static void _initializeBuilder(GAccountsByNameOrPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsByNameOrPkData_identity> get identity;
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

abstract class GAccountsByNameOrPkData_identity
    implements
        Built<GAccountsByNameOrPkData_identity,
            GAccountsByNameOrPkData_identityBuilder> {
  GAccountsByNameOrPkData_identity._();

  factory GAccountsByNameOrPkData_identity(
          [void Function(GAccountsByNameOrPkData_identityBuilder b) updates]) =
      _$GAccountsByNameOrPkData_identity;

  static void _initializeBuilder(GAccountsByNameOrPkData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isMember;
  String get name;
  String? get accountId;
  _i2.GIdentityStatusEnum? get status;
  int get createdOn;
  GAccountsByNameOrPkData_identity_account? get account;
  int get index;
  static Serializer<GAccountsByNameOrPkData_identity> get serializer =>
      _$gAccountsByNameOrPkDataIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_identity.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkData_identity_account
    implements
        Built<GAccountsByNameOrPkData_identity_account,
            GAccountsByNameOrPkData_identity_accountBuilder> {
  GAccountsByNameOrPkData_identity_account._();

  factory GAccountsByNameOrPkData_identity_account(
      [void Function(GAccountsByNameOrPkData_identity_accountBuilder b)
          updates]) = _$GAccountsByNameOrPkData_identity_account;

  static void _initializeBuilder(
          GAccountsByNameOrPkData_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isActive;
  static Serializer<GAccountsByNameOrPkData_identity_account> get serializer =>
      _$gAccountsByNameOrPkDataIdentityAccountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkData_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkData_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkData_identity_account.serializer,
        json,
      );
}

abstract class GAccountByPkData
    implements Built<GAccountByPkData, GAccountByPkDataBuilder> {
  GAccountByPkData._();

  factory GAccountByPkData([void Function(GAccountByPkDataBuilder b) updates]) =
      _$GAccountByPkData;

  static void _initializeBuilder(GAccountByPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountByPkData_accountByPk? get accountByPk;
  static Serializer<GAccountByPkData> get serializer =>
      _$gAccountByPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk
    implements
        Built<GAccountByPkData_accountByPk,
            GAccountByPkData_accountByPkBuilder> {
  GAccountByPkData_accountByPk._();

  factory GAccountByPkData_accountByPk(
          [void Function(GAccountByPkData_accountByPkBuilder b) updates]) =
      _$GAccountByPkData_accountByPk;

  static void _initializeBuilder(GAccountByPkData_accountByPkBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isActive;
  static Serializer<GAccountByPkData_accountByPk> get serializer =>
      _$gAccountByPkDataAccountByPkSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk.serializer,
        json,
      );
}

abstract class GLastBlockData
    implements Built<GLastBlockData, GLastBlockDataBuilder> {
  GLastBlockData._();

  factory GLastBlockData([void Function(GLastBlockDataBuilder b) updates]) =
      _$GLastBlockData;

  static void _initializeBuilder(GLastBlockDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GLastBlockData_block> get block;
  static Serializer<GLastBlockData> get serializer =>
      _$gLastBlockDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastBlockData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastBlockData.serializer,
        json,
      );
}

abstract class GLastBlockData_block
    implements Built<GLastBlockData_block, GLastBlockData_blockBuilder> {
  GLastBlockData_block._();

  factory GLastBlockData_block(
          [void Function(GLastBlockData_blockBuilder b) updates]) =
      _$GLastBlockData_block;

  static void _initializeBuilder(GLastBlockData_blockBuilder b) =>
      b..G__typename = 'Block';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get height;
  static Serializer<GLastBlockData_block> get serializer =>
      _$gLastBlockDataBlockSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastBlockData_block.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockData_block? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastBlockData_block.serializer,
        json,
      );
}
