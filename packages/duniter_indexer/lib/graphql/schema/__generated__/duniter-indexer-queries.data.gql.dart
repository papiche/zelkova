// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer.schema.schema.gql.dart'
    as _i2;
import 'package:duniter_indexer/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-indexer-queries.data.gql.g.dart';

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

abstract class GAccountsByNameData
    implements Built<GAccountsByNameData, GAccountsByNameDataBuilder> {
  GAccountsByNameData._();

  factory GAccountsByNameData(
          [void Function(GAccountsByNameDataBuilder b) updates]) =
      _$GAccountsByNameData;

  static void _initializeBuilder(GAccountsByNameDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsByNameData_identity> get identity;
  static Serializer<GAccountsByNameData> get serializer =>
      _$gAccountsByNameDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameData.serializer,
        json,
      );
}

abstract class GAccountsByNameData_identity
    implements
        Built<GAccountsByNameData_identity,
            GAccountsByNameData_identityBuilder> {
  GAccountsByNameData_identity._();

  factory GAccountsByNameData_identity(
          [void Function(GAccountsByNameData_identityBuilder b) updates]) =
      _$GAccountsByNameData_identity;

  static void _initializeBuilder(GAccountsByNameData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isMember;
  String get name;
  String? get accountId;
  _i2.GIdentityStatusEnum? get status;
  int get createdOn;
  GAccountsByNameData_identity_account? get account;
  int get index;
  static Serializer<GAccountsByNameData_identity> get serializer =>
      _$gAccountsByNameDataIdentitySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameData_identity? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameData_identity.serializer,
        json,
      );
}

abstract class GAccountsByNameData_identity_account
    implements
        Built<GAccountsByNameData_identity_account,
            GAccountsByNameData_identity_accountBuilder> {
  GAccountsByNameData_identity_account._();

  factory GAccountsByNameData_identity_account(
      [void Function(GAccountsByNameData_identity_accountBuilder b)
          updates]) = _$GAccountsByNameData_identity_account;

  static void _initializeBuilder(
          GAccountsByNameData_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isActive;
  static Serializer<GAccountsByNameData_identity_account> get serializer =>
      _$gAccountsByNameDataIdentityAccountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameData_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameData_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameData_identity_account.serializer,
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

abstract class GGetHistoryAndBalanceData
    implements
        Built<GGetHistoryAndBalanceData, GGetHistoryAndBalanceDataBuilder> {
  GGetHistoryAndBalanceData._();

  factory GGetHistoryAndBalanceData(
          [void Function(GGetHistoryAndBalanceDataBuilder b) updates]) =
      _$GGetHistoryAndBalanceData;

  static void _initializeBuilder(GGetHistoryAndBalanceDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetHistoryAndBalanceData_account> get account;
  static Serializer<GGetHistoryAndBalanceData> get serializer =>
      _$gGetHistoryAndBalanceDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account
    implements
        Built<GGetHistoryAndBalanceData_account,
            GGetHistoryAndBalanceData_accountBuilder> {
  GGetHistoryAndBalanceData_account._();

  factory GGetHistoryAndBalanceData_account(
          [void Function(GGetHistoryAndBalanceData_accountBuilder b) updates]) =
      _$GGetHistoryAndBalanceData_account;

  static void _initializeBuilder(GGetHistoryAndBalanceData_accountBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  BuiltList<GGetHistoryAndBalanceData_account_transfersIssued>
      get transfersIssued;
  BuiltList<GGetHistoryAndBalanceData_account_transfersReceived>
      get transfersReceived;
  static Serializer<GGetHistoryAndBalanceData_account> get serializer =>
      _$gGetHistoryAndBalanceDataAccountSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssued
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssued,
            GGetHistoryAndBalanceData_account_transfersIssuedBuilder> {
  GGetHistoryAndBalanceData_account_transfersIssued._();

  factory GGetHistoryAndBalanceData_account_transfersIssued(
      [void Function(GGetHistoryAndBalanceData_account_transfersIssuedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssuedBuilder b) =>
      b..G__typename = 'Transfer';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get blockNumber;
  _i2.Gtimestamptz get timestamp;
  int get amount;
  GGetHistoryAndBalanceData_account_transfersIssued_to? get to;
  GGetHistoryAndBalanceData_account_transfersIssued_from? get from;
  GGetHistoryAndBalanceData_account_transfersIssued_comment? get comment;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssued_to
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssued_to,
            GGetHistoryAndBalanceData_account_transfersIssued_toBuilder> {
  GGetHistoryAndBalanceData_account_transfersIssued_to._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_to(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_toBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_to;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_toBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_to>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedToSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssued_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_to.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssued_from
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssued_from,
            GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder> {
  GGetHistoryAndBalanceData_account_transfersIssued_from._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_from(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_from;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_from>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedFromSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssued_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_from.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssued_comment
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssued_comment,
            GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder> {
  GGetHistoryAndBalanceData_account_transfersIssued_comment._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_comment(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_comment;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get remark;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_comment>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedCommentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssued_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersIssued_comment.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceived
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived,
            GGetHistoryAndBalanceData_account_transfersReceivedBuilder> {
  GGetHistoryAndBalanceData_account_transfersReceived._();

  factory GGetHistoryAndBalanceData_account_transfersReceived(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceivedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceivedBuilder b) =>
      b..G__typename = 'Transfer';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get blockNumber;
  _i2.Gtimestamptz get timestamp;
  int get amount;
  GGetHistoryAndBalanceData_account_transfersReceived_from? get from;
  GGetHistoryAndBalanceData_account_transfersReceived_to? get to;
  GGetHistoryAndBalanceData_account_transfersReceived_comment? get comment;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceived_from
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_from,
            GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder> {
  GGetHistoryAndBalanceData_account_transfersReceived_from._();

  factory GGetHistoryAndBalanceData_account_transfersReceived_from(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived_from;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_from>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedFromSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceived_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_from.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceived_to
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_to,
            GGetHistoryAndBalanceData_account_transfersReceived_toBuilder> {
  GGetHistoryAndBalanceData_account_transfersReceived_to._();

  factory GGetHistoryAndBalanceData_account_transfersReceived_to(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_toBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived_to;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceived_toBuilder b) =>
      b..G__typename = 'Account';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_to>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedToSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceived_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_to.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceived_comment
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_comment,
            GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder> {
  GGetHistoryAndBalanceData_account_transfersReceived_comment._();

  factory GGetHistoryAndBalanceData_account_transfersReceived_comment(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived_comment;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get remark;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_comment>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedCommentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceived_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersReceived_comment.serializer,
        json,
      );
}
