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

abstract class GIdentitiesByNameOrPkData
    implements
        Built<GIdentitiesByNameOrPkData, GIdentitiesByNameOrPkDataBuilder> {
  GIdentitiesByNameOrPkData._();

  factory GIdentitiesByNameOrPkData(
          [void Function(GIdentitiesByNameOrPkDataBuilder b) updates]) =
      _$GIdentitiesByNameOrPkData;

  static void _initializeBuilder(GIdentitiesByNameOrPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByNameOrPkData_identity> get identity;
  static Serializer<GIdentitiesByNameOrPkData> get serializer =>
      _$gIdentitiesByNameOrPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity
    implements
        Built<GIdentitiesByNameOrPkData_identity,
            GIdentitiesByNameOrPkData_identityBuilder>,
        GIdentityFields {
  GIdentitiesByNameOrPkData_identity._();

  factory GIdentitiesByNameOrPkData_identity(
      [void Function(GIdentitiesByNameOrPkData_identityBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity;

  static void _initializeBuilder(GIdentitiesByNameOrPkData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_certIssued> get certIssued;
  @override
  GIdentitiesByNameOrPkData_identity_certIssuedAggregate
      get certIssuedAggregate;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_certReceived> get certReceived;
  @override
  GIdentitiesByNameOrPkData_identity_certReceivedAggregate
      get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_linkedAccount> get linkedAccount;
  @override
  GIdentitiesByNameOrPkData_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_membershipHistory>
      get membershipHistory;
  @override
  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_ownerKeyChange>
      get ownerKeyChange;
  @override
  GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GIdentitiesByNameOrPkData_identity_smith? get smith;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_udHistory>? get udHistory;
  static Serializer<GIdentitiesByNameOrPkData_identity> get serializer =>
      _$gIdentitiesByNameOrPkDataIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certIssued
    implements
        Built<GIdentitiesByNameOrPkData_identity_certIssued,
            GIdentitiesByNameOrPkData_identity_certIssuedBuilder>,
        GIdentityFields_certIssued,
        GCertFields {
  GIdentitiesByNameOrPkData_identity_certIssued._();

  factory GIdentitiesByNameOrPkData_identity_certIssued(
      [void Function(GIdentitiesByNameOrPkData_identity_certIssuedBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certIssued;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameOrPkData_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameOrPkData_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameOrPkData_identity_certIssued>
      get serializer => _$gIdentitiesByNameOrPkDataIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certIssued_issuer
    implements
        Built<GIdentitiesByNameOrPkData_identity_certIssued_issuer,
            GIdentitiesByNameOrPkData_identity_certIssued_issuerBuilder>,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameOrPkData_identity_certIssued_issuer._();

  factory GIdentitiesByNameOrPkData_identity_certIssued_issuer(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certIssued_issuerBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certIssued_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameOrPkData_identity_certIssued_issuer>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certIssued_receiver
    implements
        Built<GIdentitiesByNameOrPkData_identity_certIssued_receiver,
            GIdentitiesByNameOrPkData_identity_certIssued_receiverBuilder>,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameOrPkData_identity_certIssued_receiver._();

  factory GIdentitiesByNameOrPkData_identity_certIssued_receiver(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certIssued_receiverBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certIssued_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameOrPkData_identity_certIssued_receiver>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certIssuedAggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_certIssuedAggregate,
            GIdentitiesByNameOrPkData_identity_certIssuedAggregateBuilder>,
        GIdentityFields_certIssuedAggregate {
  GIdentitiesByNameOrPkData_identity_certIssuedAggregate._();

  factory GIdentitiesByNameOrPkData_identity_certIssuedAggregate(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certIssuedAggregateBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameOrPkData_identity_certIssuedAggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate,
            GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregateBuilder>,
        GIdentityFields_certIssuedAggregate_aggregate {
  GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate._();

  factory GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_certIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_certReceived
    implements
        Built<GIdentitiesByNameOrPkData_identity_certReceived,
            GIdentitiesByNameOrPkData_identity_certReceivedBuilder>,
        GIdentityFields_certReceived,
        GCertFields {
  GIdentitiesByNameOrPkData_identity_certReceived._();

  factory GIdentitiesByNameOrPkData_identity_certReceived(
      [void Function(GIdentitiesByNameOrPkData_identity_certReceivedBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certReceived;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameOrPkData_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameOrPkData_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameOrPkData_identity_certReceived>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certReceived_issuer
    implements
        Built<GIdentitiesByNameOrPkData_identity_certReceived_issuer,
            GIdentitiesByNameOrPkData_identity_certReceived_issuerBuilder>,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameOrPkData_identity_certReceived_issuer._();

  factory GIdentitiesByNameOrPkData_identity_certReceived_issuer(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certReceived_issuerBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certReceived_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameOrPkData_identity_certReceived_issuer>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certReceived_receiver
    implements
        Built<GIdentitiesByNameOrPkData_identity_certReceived_receiver,
            GIdentitiesByNameOrPkData_identity_certReceived_receiverBuilder>,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameOrPkData_identity_certReceived_receiver._();

  factory GIdentitiesByNameOrPkData_identity_certReceived_receiver(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certReceived_receiverBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certReceived_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameOrPkData_identity_certReceived_receiver>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certReceivedAggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_certReceivedAggregate,
            GIdentitiesByNameOrPkData_identity_certReceivedAggregateBuilder>,
        GIdentityFields_certReceivedAggregate {
  GIdentitiesByNameOrPkData_identity_certReceivedAggregate._();

  factory GIdentitiesByNameOrPkData_identity_certReceivedAggregate(
      [void Function(
              GIdentitiesByNameOrPkData_identity_certReceivedAggregateBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameOrPkData_identity_certReceivedAggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate
    implements
        Built<
            GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate,
            GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregateBuilder>,
        GIdentityFields_certReceivedAggregate_aggregate {
  GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate._();

  factory GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_certReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_linkedAccount
    implements
        Built<GIdentitiesByNameOrPkData_identity_linkedAccount,
            GIdentitiesByNameOrPkData_identity_linkedAccountBuilder>,
        GIdentityFields_linkedAccount {
  GIdentitiesByNameOrPkData_identity_linkedAccount._();

  factory GIdentitiesByNameOrPkData_identity_linkedAccount(
      [void Function(GIdentitiesByNameOrPkData_identity_linkedAccountBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_linkedAccount;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GIdentitiesByNameOrPkData_identity_linkedAccount>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_linkedAccountAggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_linkedAccountAggregate,
            GIdentitiesByNameOrPkData_identity_linkedAccountAggregateBuilder>,
        GIdentityFields_linkedAccountAggregate {
  GIdentitiesByNameOrPkData_identity_linkedAccountAggregate._();

  factory GIdentitiesByNameOrPkData_identity_linkedAccountAggregate(
      [void Function(
              GIdentitiesByNameOrPkData_identity_linkedAccountAggregateBuilder
                  b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameOrPkData_identity_linkedAccountAggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate
    implements
        Built<
            GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate,
            GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregateBuilder>,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate._();

  factory GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_membershipHistory
    implements
        Built<GIdentitiesByNameOrPkData_identity_membershipHistory,
            GIdentitiesByNameOrPkData_identity_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentitiesByNameOrPkData_identity_membershipHistory._();

  factory GIdentitiesByNameOrPkData_identity_membershipHistory(
      [void Function(
              GIdentitiesByNameOrPkData_identity_membershipHistoryBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_membershipHistory;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GIdentitiesByNameOrPkData_identity_membershipHistory>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate,
            GIdentitiesByNameOrPkData_identity_membershipHistoryAggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate {
  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate._();

  factory GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_membershipHistoryAggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate
    implements
        Built<
            GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate,
            GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate._();

  factory GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_ownerKeyChange
    implements
        Built<GIdentitiesByNameOrPkData_identity_ownerKeyChange,
            GIdentitiesByNameOrPkData_identity_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GIdentitiesByNameOrPkData_identity_ownerKeyChange._();

  factory GIdentitiesByNameOrPkData_identity_ownerKeyChange(
      [void Function(GIdentitiesByNameOrPkData_identity_ownerKeyChangeBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_ownerKeyChange;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GIdentitiesByNameOrPkData_identity_ownerKeyChange>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate
    implements
        Built<GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate,
            GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate {
  GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate._();

  factory GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate(
      [void Function(
              GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregateBuilder
                  b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<
            GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate,
            GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate._();

  factory GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameOrPkData_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameOrPkData_identity_smith
    implements
        Built<GIdentitiesByNameOrPkData_identity_smith,
            GIdentitiesByNameOrPkData_identity_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentitiesByNameOrPkData_identity_smith._();

  factory GIdentitiesByNameOrPkData_identity_smith(
      [void Function(GIdentitiesByNameOrPkData_identity_smithBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_smith;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GIdentitiesByNameOrPkData_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GIdentitiesByNameOrPkData_identity_smith> get serializer =>
      _$gIdentitiesByNameOrPkDataIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_smith.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_smith_smithCertIssued
    implements
        Built<GIdentitiesByNameOrPkData_identity_smith_smithCertIssued,
            GIdentitiesByNameOrPkData_identity_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GIdentitiesByNameOrPkData_identity_smith_smithCertIssued._();

  factory GIdentitiesByNameOrPkData_identity_smith_smithCertIssued(
      [void Function(
              GIdentitiesByNameOrPkData_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameOrPkData_identity_smith_smithCertIssued>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_smith_smithCertReceived
    implements
        Built<GIdentitiesByNameOrPkData_identity_smith_smithCertReceived,
            GIdentitiesByNameOrPkData_identity_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GIdentitiesByNameOrPkData_identity_smith_smithCertReceived._();

  factory GIdentitiesByNameOrPkData_identity_smith_smithCertReceived(
      [void Function(
              GIdentitiesByNameOrPkData_identity_smith_smithCertReceivedBuilder
                  b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameOrPkData_identity_smith_smithCertReceived>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identity_udHistory
    implements
        Built<GIdentitiesByNameOrPkData_identity_udHistory,
            GIdentitiesByNameOrPkData_identity_udHistoryBuilder>,
        GIdentityFields_udHistory {
  GIdentitiesByNameOrPkData_identity_udHistory._();

  factory GIdentitiesByNameOrPkData_identity_udHistory(
      [void Function(GIdentitiesByNameOrPkData_identity_udHistoryBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identity_udHistory;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GIdentitiesByNameOrPkData_identity_udHistory>
      get serializer => _$gIdentitiesByNameOrPkDataIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identity_udHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData
    implements Built<GIdentitiesByPkData, GIdentitiesByPkDataBuilder> {
  GIdentitiesByPkData._();

  factory GIdentitiesByPkData(
          [void Function(GIdentitiesByPkDataBuilder b) updates]) =
      _$GIdentitiesByPkData;

  static void _initializeBuilder(GIdentitiesByPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByPkData_identity> get identity;
  static Serializer<GIdentitiesByPkData> get serializer =>
      _$gIdentitiesByPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity
    implements
        Built<GIdentitiesByPkData_identity,
            GIdentitiesByPkData_identityBuilder>,
        GIdentityFields {
  GIdentitiesByPkData_identity._();

  factory GIdentitiesByPkData_identity(
          [void Function(GIdentitiesByPkData_identityBuilder b) updates]) =
      _$GIdentitiesByPkData_identity;

  static void _initializeBuilder(GIdentitiesByPkData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GIdentitiesByPkData_identity_certIssued> get certIssued;
  @override
  GIdentitiesByPkData_identity_certIssuedAggregate get certIssuedAggregate;
  @override
  BuiltList<GIdentitiesByPkData_identity_certReceived> get certReceived;
  @override
  GIdentitiesByPkData_identity_certReceivedAggregate get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GIdentitiesByPkData_identity_linkedAccount> get linkedAccount;
  @override
  GIdentitiesByPkData_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GIdentitiesByPkData_identity_membershipHistory>
      get membershipHistory;
  @override
  GIdentitiesByPkData_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GIdentitiesByPkData_identity_ownerKeyChange> get ownerKeyChange;
  @override
  GIdentitiesByPkData_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GIdentitiesByPkData_identity_smith? get smith;
  @override
  BuiltList<GIdentitiesByPkData_identity_udHistory>? get udHistory;
  static Serializer<GIdentitiesByPkData_identity> get serializer =>
      _$gIdentitiesByPkDataIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certIssued
    implements
        Built<GIdentitiesByPkData_identity_certIssued,
            GIdentitiesByPkData_identity_certIssuedBuilder>,
        GIdentityFields_certIssued,
        GCertFields {
  GIdentitiesByPkData_identity_certIssued._();

  factory GIdentitiesByPkData_identity_certIssued(
      [void Function(GIdentitiesByPkData_identity_certIssuedBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certIssued;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByPkData_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByPkData_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByPkData_identity_certIssued> get serializer =>
      _$gIdentitiesByPkDataIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certIssued_issuer
    implements
        Built<GIdentitiesByPkData_identity_certIssued_issuer,
            GIdentitiesByPkData_identity_certIssued_issuerBuilder>,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identity_certIssued_issuer._();

  factory GIdentitiesByPkData_identity_certIssued_issuer(
      [void Function(GIdentitiesByPkData_identity_certIssued_issuerBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certIssued_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByPkData_identity_certIssued_issuer>
      get serializer => _$gIdentitiesByPkDataIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certIssued_receiver
    implements
        Built<GIdentitiesByPkData_identity_certIssued_receiver,
            GIdentitiesByPkData_identity_certIssued_receiverBuilder>,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identity_certIssued_receiver._();

  factory GIdentitiesByPkData_identity_certIssued_receiver(
      [void Function(GIdentitiesByPkData_identity_certIssued_receiverBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certIssued_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByPkData_identity_certIssued_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certIssuedAggregate
    implements
        Built<GIdentitiesByPkData_identity_certIssuedAggregate,
            GIdentitiesByPkData_identity_certIssuedAggregateBuilder>,
        GIdentityFields_certIssuedAggregate {
  GIdentitiesByPkData_identity_certIssuedAggregate._();

  factory GIdentitiesByPkData_identity_certIssuedAggregate(
      [void Function(GIdentitiesByPkData_identity_certIssuedAggregateBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identity_certIssuedAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByPkData_identity_certIssuedAggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certIssuedAggregate_aggregate
    implements
        Built<GIdentitiesByPkData_identity_certIssuedAggregate_aggregate,
            GIdentitiesByPkData_identity_certIssuedAggregate_aggregateBuilder>,
        GIdentityFields_certIssuedAggregate_aggregate {
  GIdentitiesByPkData_identity_certIssuedAggregate_aggregate._();

  factory GIdentitiesByPkData_identity_certIssuedAggregate_aggregate(
      [void Function(
              GIdentitiesByPkData_identity_certIssuedAggregate_aggregateBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentitiesByPkData_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certReceived
    implements
        Built<GIdentitiesByPkData_identity_certReceived,
            GIdentitiesByPkData_identity_certReceivedBuilder>,
        GIdentityFields_certReceived,
        GCertFields {
  GIdentitiesByPkData_identity_certReceived._();

  factory GIdentitiesByPkData_identity_certReceived(
      [void Function(GIdentitiesByPkData_identity_certReceivedBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certReceived;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByPkData_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByPkData_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByPkData_identity_certReceived> get serializer =>
      _$gIdentitiesByPkDataIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certReceived_issuer
    implements
        Built<GIdentitiesByPkData_identity_certReceived_issuer,
            GIdentitiesByPkData_identity_certReceived_issuerBuilder>,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identity_certReceived_issuer._();

  factory GIdentitiesByPkData_identity_certReceived_issuer(
      [void Function(GIdentitiesByPkData_identity_certReceived_issuerBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certReceived_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByPkData_identity_certReceived_issuer>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certReceived_receiver
    implements
        Built<GIdentitiesByPkData_identity_certReceived_receiver,
            GIdentitiesByPkData_identity_certReceived_receiverBuilder>,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identity_certReceived_receiver._();

  factory GIdentitiesByPkData_identity_certReceived_receiver(
      [void Function(
              GIdentitiesByPkData_identity_certReceived_receiverBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certReceived_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByPkData_identity_certReceived_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certReceivedAggregate
    implements
        Built<GIdentitiesByPkData_identity_certReceivedAggregate,
            GIdentitiesByPkData_identity_certReceivedAggregateBuilder>,
        GIdentityFields_certReceivedAggregate {
  GIdentitiesByPkData_identity_certReceivedAggregate._();

  factory GIdentitiesByPkData_identity_certReceivedAggregate(
      [void Function(
              GIdentitiesByPkData_identity_certReceivedAggregateBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identity_certReceivedAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByPkData_identity_certReceivedAggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_certReceivedAggregate_aggregate
    implements
        Built<GIdentitiesByPkData_identity_certReceivedAggregate_aggregate,
            GIdentitiesByPkData_identity_certReceivedAggregate_aggregateBuilder>,
        GIdentityFields_certReceivedAggregate_aggregate {
  GIdentitiesByPkData_identity_certReceivedAggregate_aggregate._();

  factory GIdentitiesByPkData_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GIdentitiesByPkData_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByPkData_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_certReceivedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_certReceivedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_certReceivedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_linkedAccount
    implements
        Built<GIdentitiesByPkData_identity_linkedAccount,
            GIdentitiesByPkData_identity_linkedAccountBuilder>,
        GIdentityFields_linkedAccount {
  GIdentitiesByPkData_identity_linkedAccount._();

  factory GIdentitiesByPkData_identity_linkedAccount(
      [void Function(GIdentitiesByPkData_identity_linkedAccountBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_linkedAccount;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GIdentitiesByPkData_identity_linkedAccount>
      get serializer => _$gIdentitiesByPkDataIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_linkedAccountAggregate
    implements
        Built<GIdentitiesByPkData_identity_linkedAccountAggregate,
            GIdentitiesByPkData_identity_linkedAccountAggregateBuilder>,
        GIdentityFields_linkedAccountAggregate {
  GIdentitiesByPkData_identity_linkedAccountAggregate._();

  factory GIdentitiesByPkData_identity_linkedAccountAggregate(
      [void Function(
              GIdentitiesByPkData_identity_linkedAccountAggregateBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByPkData_identity_linkedAccountAggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate
    implements
        Built<GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate,
            GIdentitiesByPkData_identity_linkedAccountAggregate_aggregateBuilder>,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate._();

  factory GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GIdentitiesByPkData_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identity_membershipHistory
    implements
        Built<GIdentitiesByPkData_identity_membershipHistory,
            GIdentitiesByPkData_identity_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentitiesByPkData_identity_membershipHistory._();

  factory GIdentitiesByPkData_identity_membershipHistory(
      [void Function(GIdentitiesByPkData_identity_membershipHistoryBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_membershipHistory;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GIdentitiesByPkData_identity_membershipHistory>
      get serializer =>
          _$gIdentitiesByPkDataIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_membershipHistoryAggregate
    implements
        Built<GIdentitiesByPkData_identity_membershipHistoryAggregate,
            GIdentitiesByPkData_identity_membershipHistoryAggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate {
  GIdentitiesByPkData_identity_membershipHistoryAggregate._();

  factory GIdentitiesByPkData_identity_membershipHistoryAggregate(
      [void Function(
              GIdentitiesByPkData_identity_membershipHistoryAggregateBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_membershipHistoryAggregateBuilder b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByPkData_identity_membershipHistoryAggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_membershipHistoryAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_membershipHistoryAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_membershipHistoryAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate
    implements
        Built<GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate,
            GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate._();

  factory GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identity_ownerKeyChange
    implements
        Built<GIdentitiesByPkData_identity_ownerKeyChange,
            GIdentitiesByPkData_identity_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GIdentitiesByPkData_identity_ownerKeyChange._();

  factory GIdentitiesByPkData_identity_ownerKeyChange(
      [void Function(GIdentitiesByPkData_identity_ownerKeyChangeBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_ownerKeyChange;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GIdentitiesByPkData_identity_ownerKeyChange>
      get serializer => _$gIdentitiesByPkDataIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_ownerKeyChangeAggregate
    implements
        Built<GIdentitiesByPkData_identity_ownerKeyChangeAggregate,
            GIdentitiesByPkData_identity_ownerKeyChangeAggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate {
  GIdentitiesByPkData_identity_ownerKeyChangeAggregate._();

  factory GIdentitiesByPkData_identity_ownerKeyChangeAggregate(
      [void Function(
              GIdentitiesByPkData_identity_ownerKeyChangeAggregateBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_ownerKeyChangeAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByPkData_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate,
            GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate._();

  factory GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByPkDataIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identity_smith
    implements
        Built<GIdentitiesByPkData_identity_smith,
            GIdentitiesByPkData_identity_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentitiesByPkData_identity_smith._();

  factory GIdentitiesByPkData_identity_smith(
      [void Function(GIdentitiesByPkData_identity_smithBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_smith;

  static void _initializeBuilder(GIdentitiesByPkData_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GIdentitiesByPkData_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GIdentitiesByPkData_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GIdentitiesByPkData_identity_smith> get serializer =>
      _$gIdentitiesByPkDataIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_smith.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_smith_smithCertIssued
    implements
        Built<GIdentitiesByPkData_identity_smith_smithCertIssued,
            GIdentitiesByPkData_identity_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GIdentitiesByPkData_identity_smith_smithCertIssued._();

  factory GIdentitiesByPkData_identity_smith_smithCertIssued(
      [void Function(
              GIdentitiesByPkData_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByPkData_identity_smith_smithCertIssued>
      get serializer =>
          _$gIdentitiesByPkDataIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_smith_smithCertReceived
    implements
        Built<GIdentitiesByPkData_identity_smith_smithCertReceived,
            GIdentitiesByPkData_identity_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GIdentitiesByPkData_identity_smith_smithCertReceived._();

  factory GIdentitiesByPkData_identity_smith_smithCertReceived(
      [void Function(
              GIdentitiesByPkData_identity_smith_smithCertReceivedBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByPkData_identity_smith_smithCertReceived>
      get serializer =>
          _$gIdentitiesByPkDataIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identity_udHistory
    implements
        Built<GIdentitiesByPkData_identity_udHistory,
            GIdentitiesByPkData_identity_udHistoryBuilder>,
        GIdentityFields_udHistory {
  GIdentitiesByPkData_identity_udHistory._();

  factory GIdentitiesByPkData_identity_udHistory(
      [void Function(GIdentitiesByPkData_identity_udHistoryBuilder b)
          updates]) = _$GIdentitiesByPkData_identity_udHistory;

  static void _initializeBuilder(
          GIdentitiesByPkData_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GIdentitiesByPkData_identity_udHistory> get serializer =>
      _$gIdentitiesByPkDataIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identity_udHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData
    implements Built<GIdentitiesByNameData, GIdentitiesByNameDataBuilder> {
  GIdentitiesByNameData._();

  factory GIdentitiesByNameData(
          [void Function(GIdentitiesByNameDataBuilder b) updates]) =
      _$GIdentitiesByNameData;

  static void _initializeBuilder(GIdentitiesByNameDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByNameData_identity> get identity;
  static Serializer<GIdentitiesByNameData> get serializer =>
      _$gIdentitiesByNameDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity
    implements
        Built<GIdentitiesByNameData_identity,
            GIdentitiesByNameData_identityBuilder>,
        GIdentityFields {
  GIdentitiesByNameData_identity._();

  factory GIdentitiesByNameData_identity(
          [void Function(GIdentitiesByNameData_identityBuilder b) updates]) =
      _$GIdentitiesByNameData_identity;

  static void _initializeBuilder(GIdentitiesByNameData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GIdentitiesByNameData_identity_certIssued> get certIssued;
  @override
  GIdentitiesByNameData_identity_certIssuedAggregate get certIssuedAggregate;
  @override
  BuiltList<GIdentitiesByNameData_identity_certReceived> get certReceived;
  @override
  GIdentitiesByNameData_identity_certReceivedAggregate
      get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GIdentitiesByNameData_identity_linkedAccount> get linkedAccount;
  @override
  GIdentitiesByNameData_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GIdentitiesByNameData_identity_membershipHistory>
      get membershipHistory;
  @override
  GIdentitiesByNameData_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GIdentitiesByNameData_identity_ownerKeyChange> get ownerKeyChange;
  @override
  GIdentitiesByNameData_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GIdentitiesByNameData_identity_smith? get smith;
  @override
  BuiltList<GIdentitiesByNameData_identity_udHistory>? get udHistory;
  static Serializer<GIdentitiesByNameData_identity> get serializer =>
      _$gIdentitiesByNameDataIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certIssued
    implements
        Built<GIdentitiesByNameData_identity_certIssued,
            GIdentitiesByNameData_identity_certIssuedBuilder>,
        GIdentityFields_certIssued,
        GCertFields {
  GIdentitiesByNameData_identity_certIssued._();

  factory GIdentitiesByNameData_identity_certIssued(
      [void Function(GIdentitiesByNameData_identity_certIssuedBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certIssued;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameData_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameData_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameData_identity_certIssued> get serializer =>
      _$gIdentitiesByNameDataIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certIssued_issuer
    implements
        Built<GIdentitiesByNameData_identity_certIssued_issuer,
            GIdentitiesByNameData_identity_certIssued_issuerBuilder>,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identity_certIssued_issuer._();

  factory GIdentitiesByNameData_identity_certIssued_issuer(
      [void Function(GIdentitiesByNameData_identity_certIssued_issuerBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certIssued_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameData_identity_certIssued_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certIssued_receiver
    implements
        Built<GIdentitiesByNameData_identity_certIssued_receiver,
            GIdentitiesByNameData_identity_certIssued_receiverBuilder>,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identity_certIssued_receiver._();

  factory GIdentitiesByNameData_identity_certIssued_receiver(
      [void Function(
              GIdentitiesByNameData_identity_certIssued_receiverBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certIssued_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameData_identity_certIssued_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certIssuedAggregate
    implements
        Built<GIdentitiesByNameData_identity_certIssuedAggregate,
            GIdentitiesByNameData_identity_certIssuedAggregateBuilder>,
        GIdentityFields_certIssuedAggregate {
  GIdentitiesByNameData_identity_certIssuedAggregate._();

  factory GIdentitiesByNameData_identity_certIssuedAggregate(
      [void Function(
              GIdentitiesByNameData_identity_certIssuedAggregateBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identity_certIssuedAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByNameData_identity_certIssuedAggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certIssuedAggregate_aggregate
    implements
        Built<GIdentitiesByNameData_identity_certIssuedAggregate_aggregate,
            GIdentitiesByNameData_identity_certIssuedAggregate_aggregateBuilder>,
        GIdentityFields_certIssuedAggregate_aggregate {
  GIdentitiesByNameData_identity_certIssuedAggregate_aggregate._();

  factory GIdentitiesByNameData_identity_certIssuedAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameData_identity_certIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameData_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certReceived
    implements
        Built<GIdentitiesByNameData_identity_certReceived,
            GIdentitiesByNameData_identity_certReceivedBuilder>,
        GIdentityFields_certReceived,
        GCertFields {
  GIdentitiesByNameData_identity_certReceived._();

  factory GIdentitiesByNameData_identity_certReceived(
      [void Function(GIdentitiesByNameData_identity_certReceivedBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certReceived;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameData_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameData_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameData_identity_certReceived>
      get serializer => _$gIdentitiesByNameDataIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certReceived_issuer
    implements
        Built<GIdentitiesByNameData_identity_certReceived_issuer,
            GIdentitiesByNameData_identity_certReceived_issuerBuilder>,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identity_certReceived_issuer._();

  factory GIdentitiesByNameData_identity_certReceived_issuer(
      [void Function(
              GIdentitiesByNameData_identity_certReceived_issuerBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certReceived_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameData_identity_certReceived_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certReceived_receiver
    implements
        Built<GIdentitiesByNameData_identity_certReceived_receiver,
            GIdentitiesByNameData_identity_certReceived_receiverBuilder>,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identity_certReceived_receiver._();

  factory GIdentitiesByNameData_identity_certReceived_receiver(
      [void Function(
              GIdentitiesByNameData_identity_certReceived_receiverBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certReceived_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentitiesByNameData_identity_certReceived_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certReceivedAggregate
    implements
        Built<GIdentitiesByNameData_identity_certReceivedAggregate,
            GIdentitiesByNameData_identity_certReceivedAggregateBuilder>,
        GIdentityFields_certReceivedAggregate {
  GIdentitiesByNameData_identity_certReceivedAggregate._();

  factory GIdentitiesByNameData_identity_certReceivedAggregate(
      [void Function(
              GIdentitiesByNameData_identity_certReceivedAggregateBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identity_certReceivedAggregate_aggregate? get aggregate;
  static Serializer<GIdentitiesByNameData_identity_certReceivedAggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_certReceivedAggregate_aggregate
    implements
        Built<GIdentitiesByNameData_identity_certReceivedAggregate_aggregate,
            GIdentitiesByNameData_identity_certReceivedAggregate_aggregateBuilder>,
        GIdentityFields_certReceivedAggregate_aggregate {
  GIdentitiesByNameData_identity_certReceivedAggregate_aggregate._();

  factory GIdentitiesByNameData_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameData_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameData_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_certReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_certReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identity_certReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identity_linkedAccount
    implements
        Built<GIdentitiesByNameData_identity_linkedAccount,
            GIdentitiesByNameData_identity_linkedAccountBuilder>,
        GIdentityFields_linkedAccount {
  GIdentitiesByNameData_identity_linkedAccount._();

  factory GIdentitiesByNameData_identity_linkedAccount(
      [void Function(GIdentitiesByNameData_identity_linkedAccountBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_linkedAccount;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GIdentitiesByNameData_identity_linkedAccount>
      get serializer => _$gIdentitiesByNameDataIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_linkedAccountAggregate
    implements
        Built<GIdentitiesByNameData_identity_linkedAccountAggregate,
            GIdentitiesByNameData_identity_linkedAccountAggregateBuilder>,
        GIdentityFields_linkedAccountAggregate {
  GIdentitiesByNameData_identity_linkedAccountAggregate._();

  factory GIdentitiesByNameData_identity_linkedAccountAggregate(
      [void Function(
              GIdentitiesByNameData_identity_linkedAccountAggregateBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameData_identity_linkedAccountAggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate
    implements
        Built<GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate,
            GIdentitiesByNameData_identity_linkedAccountAggregate_aggregateBuilder>,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate._();

  factory GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameData_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identity_membershipHistory
    implements
        Built<GIdentitiesByNameData_identity_membershipHistory,
            GIdentitiesByNameData_identity_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentitiesByNameData_identity_membershipHistory._();

  factory GIdentitiesByNameData_identity_membershipHistory(
      [void Function(GIdentitiesByNameData_identity_membershipHistoryBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_membershipHistory;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GIdentitiesByNameData_identity_membershipHistory>
      get serializer =>
          _$gIdentitiesByNameDataIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_membershipHistoryAggregate
    implements
        Built<GIdentitiesByNameData_identity_membershipHistoryAggregate,
            GIdentitiesByNameData_identity_membershipHistoryAggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate {
  GIdentitiesByNameData_identity_membershipHistoryAggregate._();

  factory GIdentitiesByNameData_identity_membershipHistoryAggregate(
      [void Function(
              GIdentitiesByNameData_identity_membershipHistoryAggregateBuilder
                  b)
          updates]) = _$GIdentitiesByNameData_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_membershipHistoryAggregateBuilder b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameData_identity_membershipHistoryAggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_membershipHistoryAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_membershipHistoryAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_membershipHistoryAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate
    implements
        Built<
            GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate,
            GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate._();

  factory GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identity_ownerKeyChange
    implements
        Built<GIdentitiesByNameData_identity_ownerKeyChange,
            GIdentitiesByNameData_identity_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GIdentitiesByNameData_identity_ownerKeyChange._();

  factory GIdentitiesByNameData_identity_ownerKeyChange(
      [void Function(GIdentitiesByNameData_identity_ownerKeyChangeBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_ownerKeyChange;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GIdentitiesByNameData_identity_ownerKeyChange>
      get serializer => _$gIdentitiesByNameDataIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_ownerKeyChangeAggregate
    implements
        Built<GIdentitiesByNameData_identity_ownerKeyChangeAggregate,
            GIdentitiesByNameData_identity_ownerKeyChangeAggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate {
  GIdentitiesByNameData_identity_ownerKeyChangeAggregate._();

  factory GIdentitiesByNameData_identity_ownerKeyChangeAggregate(
      [void Function(
              GIdentitiesByNameData_identity_ownerKeyChangeAggregateBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_ownerKeyChangeAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate?
      get aggregate;
  static Serializer<GIdentitiesByNameData_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate,
            GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate._();

  factory GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gIdentitiesByNameDataIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identity_smith
    implements
        Built<GIdentitiesByNameData_identity_smith,
            GIdentitiesByNameData_identity_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentitiesByNameData_identity_smith._();

  factory GIdentitiesByNameData_identity_smith(
      [void Function(GIdentitiesByNameData_identity_smithBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_smith;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GIdentitiesByNameData_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GIdentitiesByNameData_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GIdentitiesByNameData_identity_smith> get serializer =>
      _$gIdentitiesByNameDataIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_smith.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_smith_smithCertIssued
    implements
        Built<GIdentitiesByNameData_identity_smith_smithCertIssued,
            GIdentitiesByNameData_identity_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GIdentitiesByNameData_identity_smith_smithCertIssued._();

  factory GIdentitiesByNameData_identity_smith_smithCertIssued(
      [void Function(
              GIdentitiesByNameData_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameData_identity_smith_smithCertIssued>
      get serializer =>
          _$gIdentitiesByNameDataIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_smith_smithCertReceived
    implements
        Built<GIdentitiesByNameData_identity_smith_smithCertReceived,
            GIdentitiesByNameData_identity_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GIdentitiesByNameData_identity_smith_smithCertReceived._();

  factory GIdentitiesByNameData_identity_smith_smithCertReceived(
      [void Function(
              GIdentitiesByNameData_identity_smith_smithCertReceivedBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameData_identity_smith_smithCertReceived>
      get serializer =>
          _$gIdentitiesByNameDataIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identity_udHistory
    implements
        Built<GIdentitiesByNameData_identity_udHistory,
            GIdentitiesByNameData_identity_udHistoryBuilder>,
        GIdentityFields_udHistory {
  GIdentitiesByNameData_identity_udHistory._();

  factory GIdentitiesByNameData_identity_udHistory(
      [void Function(GIdentitiesByNameData_identity_udHistoryBuilder b)
          updates]) = _$GIdentitiesByNameData_identity_udHistory;

  static void _initializeBuilder(
          GIdentitiesByNameData_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GIdentitiesByNameData_identity_udHistory> get serializer =>
      _$gIdentitiesByNameDataIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identity_udHistory.serializer,
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
            GAccountByPkData_accountByPkBuilder>,
        GAccountFields {
  GAccountByPkData_accountByPk._();

  factory GAccountByPkData_accountByPk(
          [void Function(GAccountByPkData_accountByPkBuilder b) updates]) =
      _$GAccountByPkData_accountByPk;

  static void _initializeBuilder(GAccountByPkData_accountByPkBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  BuiltList<GAccountByPkData_accountByPk_commentsIssued> get commentsIssued;
  @override
  GAccountByPkData_accountByPk_commentsIssuedAggregate
      get commentsIssuedAggregate;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GAccountByPkData_accountByPk_identity? get identity;
  @override
  bool get isActive;
  @override
  GAccountByPkData_accountByPk_linkedIdentity? get linkedIdentity;
  @override
  BuiltList<GAccountByPkData_accountByPk_removedIdentities>
      get removedIdentities;
  @override
  GAccountByPkData_accountByPk_removedIdentitiesAggregate
      get removedIdentitiesAggregate;
  @override
  BuiltList<GAccountByPkData_accountByPk_transfersIssued> get transfersIssued;
  @override
  GAccountByPkData_accountByPk_transfersIssuedAggregate
      get transfersIssuedAggregate;
  @override
  BuiltList<GAccountByPkData_accountByPk_transfersReceived>
      get transfersReceived;
  @override
  GAccountByPkData_accountByPk_transfersReceivedAggregate
      get transfersReceivedAggregate;
  @override
  BuiltList<GAccountByPkData_accountByPk_wasIdentity> get wasIdentity;
  @override
  GAccountByPkData_accountByPk_wasIdentityAggregate get wasIdentityAggregate;
  static Serializer<GAccountByPkData_accountByPk> get serializer =>
      _$gAccountByPkDataAccountByPkSerializer;

  @override
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

abstract class GAccountByPkData_accountByPk_commentsIssued
    implements
        Built<GAccountByPkData_accountByPk_commentsIssued,
            GAccountByPkData_accountByPk_commentsIssuedBuilder>,
        GAccountFields_commentsIssued,
        GCommentsIssued {
  GAccountByPkData_accountByPk_commentsIssued._();

  factory GAccountByPkData_accountByPk_commentsIssued(
      [void Function(GAccountByPkData_accountByPk_commentsIssuedBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_commentsIssued;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_commentsIssuedBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  static Serializer<GAccountByPkData_accountByPk_commentsIssued>
      get serializer => _$gAccountByPkDataAccountByPkCommentsIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_commentsIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_commentsIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_commentsIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_commentsIssuedAggregate
    implements
        Built<GAccountByPkData_accountByPk_commentsIssuedAggregate,
            GAccountByPkData_accountByPk_commentsIssuedAggregateBuilder>,
        GAccountFields_commentsIssuedAggregate {
  GAccountByPkData_accountByPk_commentsIssuedAggregate._();

  factory GAccountByPkData_accountByPk_commentsIssuedAggregate(
      [void Function(
              GAccountByPkData_accountByPk_commentsIssuedAggregateBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_commentsIssuedAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_commentsIssuedAggregateBuilder b) =>
      b..G__typename = 'TxCommentAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountByPkData_accountByPk_commentsIssuedAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkCommentsIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_commentsIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_commentsIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_commentsIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate
    implements
        Built<GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate,
            GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregateBuilder>,
        GAccountFields_commentsIssuedAggregate_aggregate {
  GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TxCommentAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkCommentsIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_commentsIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity
    implements
        Built<GAccountByPkData_accountByPk_identity,
            GAccountByPkData_accountByPk_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GAccountByPkData_accountByPk_identity._();

  factory GAccountByPkData_accountByPk_identity(
      [void Function(GAccountByPkData_accountByPk_identityBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_certIssued> get certIssued;
  @override
  GAccountByPkData_accountByPk_identity_certIssuedAggregate
      get certIssuedAggregate;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_certReceived>
      get certReceived;
  @override
  GAccountByPkData_accountByPk_identity_certReceivedAggregate
      get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_linkedAccount>
      get linkedAccount;
  @override
  GAccountByPkData_accountByPk_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_membershipHistory>
      get membershipHistory;
  @override
  GAccountByPkData_accountByPk_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_ownerKeyChange>
      get ownerKeyChange;
  @override
  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GAccountByPkData_accountByPk_identity_smith? get smith;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_udHistory>? get udHistory;
  static Serializer<GAccountByPkData_accountByPk_identity> get serializer =>
      _$gAccountByPkDataAccountByPkIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certIssued
    implements
        Built<GAccountByPkData_accountByPk_identity_certIssued,
            GAccountByPkData_accountByPk_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued,
        GCertFields {
  GAccountByPkData_accountByPk_identity_certIssued._();

  factory GAccountByPkData_accountByPk_identity_certIssued(
      [void Function(GAccountByPkData_accountByPk_identity_certIssuedBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certIssued;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountByPkData_accountByPk_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountByPkData_accountByPk_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountByPkData_accountByPk_identity_certIssued>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certIssued_issuer
    implements
        Built<GAccountByPkData_accountByPk_identity_certIssued_issuer,
            GAccountByPkData_accountByPk_identity_certIssued_issuerBuilder>,
        GAccountFields_identity_certIssued_issuer,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_identity_certIssued_issuer._();

  factory GAccountByPkData_accountByPk_identity_certIssued_issuer(
      [void Function(
              GAccountByPkData_accountByPk_identity_certIssued_issuerBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certIssued_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_identity_certIssued_issuer>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certIssued_receiver
    implements
        Built<GAccountByPkData_accountByPk_identity_certIssued_receiver,
            GAccountByPkData_accountByPk_identity_certIssued_receiverBuilder>,
        GAccountFields_identity_certIssued_receiver,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_identity_certIssued_receiver._();

  factory GAccountByPkData_accountByPk_identity_certIssued_receiver(
      [void Function(
              GAccountByPkData_accountByPk_identity_certIssued_receiverBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certIssued_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_identity_certIssued_receiver>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certIssuedAggregate
    implements
        Built<GAccountByPkData_accountByPk_identity_certIssuedAggregate,
            GAccountByPkData_accountByPk_identity_certIssuedAggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate,
        GIdentityFields_certIssuedAggregate {
  GAccountByPkData_accountByPk_identity_certIssuedAggregate._();

  factory GAccountByPkData_accountByPk_identity_certIssuedAggregate(
      [void Function(
              GAccountByPkData_accountByPk_identity_certIssuedAggregateBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountByPkData_accountByPk_identity_certIssuedAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate
    implements
        Built<
            GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate,
            GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate_aggregate,
        GIdentityFields_certIssuedAggregate_aggregate {
  GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_certIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_certReceived
    implements
        Built<GAccountByPkData_accountByPk_identity_certReceived,
            GAccountByPkData_accountByPk_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived,
        GCertFields {
  GAccountByPkData_accountByPk_identity_certReceived._();

  factory GAccountByPkData_accountByPk_identity_certReceived(
      [void Function(
              GAccountByPkData_accountByPk_identity_certReceivedBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certReceived;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountByPkData_accountByPk_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountByPkData_accountByPk_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountByPkData_accountByPk_identity_certReceived>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certReceived.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certReceived_issuer
    implements
        Built<GAccountByPkData_accountByPk_identity_certReceived_issuer,
            GAccountByPkData_accountByPk_identity_certReceived_issuerBuilder>,
        GAccountFields_identity_certReceived_issuer,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_identity_certReceived_issuer._();

  factory GAccountByPkData_accountByPk_identity_certReceived_issuer(
      [void Function(
              GAccountByPkData_accountByPk_identity_certReceived_issuerBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certReceived_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_identity_certReceived_issuer>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certReceived_receiver
    implements
        Built<GAccountByPkData_accountByPk_identity_certReceived_receiver,
            GAccountByPkData_accountByPk_identity_certReceived_receiverBuilder>,
        GAccountFields_identity_certReceived_receiver,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_identity_certReceived_receiver._();

  factory GAccountByPkData_accountByPk_identity_certReceived_receiver(
      [void Function(
              GAccountByPkData_accountByPk_identity_certReceived_receiverBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certReceived_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certReceived_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_identity_certReceived_receiver>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certReceivedAggregate
    implements
        Built<GAccountByPkData_accountByPk_identity_certReceivedAggregate,
            GAccountByPkData_accountByPk_identity_certReceivedAggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate,
        GIdentityFields_certReceivedAggregate {
  GAccountByPkData_accountByPk_identity_certReceivedAggregate._();

  factory GAccountByPkData_accountByPk_identity_certReceivedAggregate(
      [void Function(
              GAccountByPkData_accountByPk_identity_certReceivedAggregateBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certReceivedAggregateBuilder
              b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountByPkData_accountByPk_identity_certReceivedAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate
    implements
        Built<
            GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate,
            GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate_aggregate,
        GIdentityFields_certReceivedAggregate_aggregate {
  GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_certReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_linkedAccount
    implements
        Built<GAccountByPkData_accountByPk_identity_linkedAccount,
            GAccountByPkData_accountByPk_identity_linkedAccountBuilder>,
        GAccountFields_identity_linkedAccount,
        GIdentityFields_linkedAccount {
  GAccountByPkData_accountByPk_identity_linkedAccount._();

  factory GAccountByPkData_accountByPk_identity_linkedAccount(
      [void Function(
              GAccountByPkData_accountByPk_identity_linkedAccountBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_linkedAccount;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accountByPk_identity_linkedAccount>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_linkedAccountAggregate
    implements
        Built<GAccountByPkData_accountByPk_identity_linkedAccountAggregate,
            GAccountByPkData_accountByPk_identity_linkedAccountAggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate,
        GIdentityFields_linkedAccountAggregate {
  GAccountByPkData_accountByPk_identity_linkedAccountAggregate._();

  factory GAccountByPkData_accountByPk_identity_linkedAccountAggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_linkedAccountAggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_linkedAccountAggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate?
      get aggregate;
  static Serializer<
          GAccountByPkData_accountByPk_identity_linkedAccountAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate
    implements
        Built<
            GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate,
            GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate_aggregate,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_membershipHistory
    implements
        Built<GAccountByPkData_accountByPk_identity_membershipHistory,
            GAccountByPkData_accountByPk_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GAccountByPkData_accountByPk_identity_membershipHistory._();

  factory GAccountByPkData_accountByPk_identity_membershipHistory(
      [void Function(
              GAccountByPkData_accountByPk_identity_membershipHistoryBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_membershipHistory;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GAccountByPkData_accountByPk_identity_membershipHistory>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_membershipHistoryAggregate
    implements
        Built<GAccountByPkData_accountByPk_identity_membershipHistoryAggregate,
            GAccountByPkData_accountByPk_identity_membershipHistoryAggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate,
        GIdentityFields_membershipHistoryAggregate {
  GAccountByPkData_accountByPk_identity_membershipHistoryAggregate._();

  factory GAccountByPkData_accountByPk_identity_membershipHistoryAggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_membershipHistoryAggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_membershipHistoryAggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<
          GAccountByPkData_accountByPk_identity_membershipHistoryAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_membershipHistoryAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_membershipHistoryAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_membershipHistoryAggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate
    implements
        Built<
            GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate,
            GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate_aggregate,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_ownerKeyChange
    implements
        Built<GAccountByPkData_accountByPk_identity_ownerKeyChange,
            GAccountByPkData_accountByPk_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GAccountByPkData_accountByPk_identity_ownerKeyChange._();

  factory GAccountByPkData_accountByPk_identity_ownerKeyChange(
      [void Function(
              GAccountByPkData_accountByPk_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountByPkData_accountByPk_identity_ownerKeyChange>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate
    implements
        Built<GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate,
            GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate,
        GIdentityFields_ownerKeyChangeAggregate {
  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate._();

  factory GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate?
      get aggregate;
  static Serializer<
          GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<
            GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate,
            GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate_aggregate,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_smith
    implements
        Built<GAccountByPkData_accountByPk_identity_smith,
            GAccountByPkData_accountByPk_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountByPkData_accountByPk_identity_smith._();

  factory GAccountByPkData_accountByPk_identity_smith(
      [void Function(GAccountByPkData_accountByPk_identity_smithBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_smith;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GAccountByPkData_accountByPk_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GAccountByPkData_accountByPk_identity_smith>
      get serializer => _$gAccountByPkDataAccountByPkIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_smith.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_smith_smithCertIssued
    implements
        Built<GAccountByPkData_accountByPk_identity_smith_smithCertIssued,
            GAccountByPkData_accountByPk_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GAccountByPkData_accountByPk_identity_smith_smithCertIssued._();

  factory GAccountByPkData_accountByPk_identity_smith_smithCertIssued(
      [void Function(
              GAccountByPkData_accountByPk_identity_smith_smithCertIssuedBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GAccountByPkData_accountByPk_identity_smith_smithCertIssued>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_identity_smith_smithCertReceived
    implements
        Built<GAccountByPkData_accountByPk_identity_smith_smithCertReceived,
            GAccountByPkData_accountByPk_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GAccountByPkData_accountByPk_identity_smith_smithCertReceived._();

  factory GAccountByPkData_accountByPk_identity_smith_smithCertReceived(
          [void Function(
                  GAccountByPkData_accountByPk_identity_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<
          GAccountByPkData_accountByPk_identity_smith_smithCertReceived>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_smith_smithCertReceived
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_smith_smithCertReceived?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_identity_smith_smithCertReceived
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_identity_udHistory
    implements
        Built<GAccountByPkData_accountByPk_identity_udHistory,
            GAccountByPkData_accountByPk_identity_udHistoryBuilder>,
        GAccountFields_identity_udHistory,
        GIdentityFields_udHistory {
  GAccountByPkData_accountByPk_identity_udHistory._();

  factory GAccountByPkData_accountByPk_identity_udHistory(
      [void Function(GAccountByPkData_accountByPk_identity_udHistoryBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_identity_udHistory;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GAccountByPkData_accountByPk_identity_udHistory>
      get serializer =>
          _$gAccountByPkDataAccountByPkIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_identity_udHistory.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_linkedIdentity
    implements
        Built<GAccountByPkData_accountByPk_linkedIdentity,
            GAccountByPkData_accountByPk_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_linkedIdentity._();

  factory GAccountByPkData_accountByPk_linkedIdentity(
      [void Function(GAccountByPkData_accountByPk_linkedIdentityBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_linkedIdentity;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_linkedIdentity>
      get serializer => _$gAccountByPkDataAccountByPkLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_removedIdentities
    implements
        Built<GAccountByPkData_accountByPk_removedIdentities,
            GAccountByPkData_accountByPk_removedIdentitiesBuilder>,
        GAccountFields_removedIdentities,
        GIdentityBasicFields {
  GAccountByPkData_accountByPk_removedIdentities._();

  factory GAccountByPkData_accountByPk_removedIdentities(
      [void Function(GAccountByPkData_accountByPk_removedIdentitiesBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_removedIdentities;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_removedIdentitiesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountByPkData_accountByPk_removedIdentities>
      get serializer =>
          _$gAccountByPkDataAccountByPkRemovedIdentitiesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_removedIdentities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_removedIdentities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_removedIdentities.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_removedIdentitiesAggregate
    implements
        Built<GAccountByPkData_accountByPk_removedIdentitiesAggregate,
            GAccountByPkData_accountByPk_removedIdentitiesAggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate {
  GAccountByPkData_accountByPk_removedIdentitiesAggregate._();

  factory GAccountByPkData_accountByPk_removedIdentitiesAggregate(
      [void Function(
              GAccountByPkData_accountByPk_removedIdentitiesAggregateBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_removedIdentitiesAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_removedIdentitiesAggregateBuilder b) =>
      b..G__typename = 'IdentityAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountByPkData_accountByPk_removedIdentitiesAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkRemovedIdentitiesAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_removedIdentitiesAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_removedIdentitiesAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_removedIdentitiesAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate
    implements
        Built<GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate,
            GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate_aggregate {
  GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'IdentityAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkRemovedIdentitiesAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_removedIdentitiesAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_transfersIssued
    implements
        Built<GAccountByPkData_accountByPk_transfersIssued,
            GAccountByPkData_accountByPk_transfersIssuedBuilder>,
        GAccountFields_transfersIssued,
        GTransferFields {
  GAccountByPkData_accountByPk_transfersIssued._();

  factory GAccountByPkData_accountByPk_transfersIssued(
      [void Function(GAccountByPkData_accountByPk_transfersIssuedBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersIssued;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssuedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountByPkData_accountByPk_transfersIssued_to? get to;
  @override
  GAccountByPkData_accountByPk_transfersIssued_from? get from;
  @override
  GAccountByPkData_accountByPk_transfersIssued_comment? get comment;
  static Serializer<GAccountByPkData_accountByPk_transfersIssued>
      get serializer => _$gAccountByPkDataAccountByPkTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersIssued_to
    implements
        Built<GAccountByPkData_accountByPk_transfersIssued_to,
            GAccountByPkData_accountByPk_transfersIssued_toBuilder>,
        GAccountFields_transfersIssued_to,
        GTransferFields_to {
  GAccountByPkData_accountByPk_transfersIssued_to._();

  factory GAccountByPkData_accountByPk_transfersIssued_to(
      [void Function(GAccountByPkData_accountByPk_transfersIssued_toBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersIssued_to;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssued_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accountByPk_transfersIssued_to>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssued_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssued_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersIssued_to.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersIssued_from
    implements
        Built<GAccountByPkData_accountByPk_transfersIssued_from,
            GAccountByPkData_accountByPk_transfersIssued_fromBuilder>,
        GAccountFields_transfersIssued_from,
        GTransferFields_from {
  GAccountByPkData_accountByPk_transfersIssued_from._();

  factory GAccountByPkData_accountByPk_transfersIssued_from(
      [void Function(GAccountByPkData_accountByPk_transfersIssued_fromBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersIssued_from;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssued_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accountByPk_transfersIssued_from>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssued_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssued_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersIssued_from.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersIssued_comment
    implements
        Built<GAccountByPkData_accountByPk_transfersIssued_comment,
            GAccountByPkData_accountByPk_transfersIssued_commentBuilder>,
        GAccountFields_transfersIssued_comment,
        GTransferFields_comment {
  GAccountByPkData_accountByPk_transfersIssued_comment._();

  factory GAccountByPkData_accountByPk_transfersIssued_comment(
      [void Function(
              GAccountByPkData_accountByPk_transfersIssued_commentBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersIssued_comment;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssued_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountByPkData_accountByPk_transfersIssued_comment>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssued_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssued_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersIssued_comment.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersIssuedAggregate
    implements
        Built<GAccountByPkData_accountByPk_transfersIssuedAggregate,
            GAccountByPkData_accountByPk_transfersIssuedAggregateBuilder>,
        GAccountFields_transfersIssuedAggregate {
  GAccountByPkData_accountByPk_transfersIssuedAggregate._();

  factory GAccountByPkData_accountByPk_transfersIssuedAggregate(
      [void Function(
              GAccountByPkData_accountByPk_transfersIssuedAggregateBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersIssuedAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssuedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountByPkData_accountByPk_transfersIssuedAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate
    implements
        Built<GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate,
            GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregateBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate {
  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum? get sum;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum
    implements
        Built<
            GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum,
            GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate_sum {
  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum._();

  factory GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum(
          [void Function(
                  GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersIssuedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_transfersIssuedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_transfersReceived
    implements
        Built<GAccountByPkData_accountByPk_transfersReceived,
            GAccountByPkData_accountByPk_transfersReceivedBuilder>,
        GAccountFields_transfersReceived,
        GTransferFields {
  GAccountByPkData_accountByPk_transfersReceived._();

  factory GAccountByPkData_accountByPk_transfersReceived(
      [void Function(GAccountByPkData_accountByPk_transfersReceivedBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersReceived;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceivedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountByPkData_accountByPk_transfersReceived_to? get to;
  @override
  GAccountByPkData_accountByPk_transfersReceived_from? get from;
  @override
  GAccountByPkData_accountByPk_transfersReceived_comment? get comment;
  static Serializer<GAccountByPkData_accountByPk_transfersReceived>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersReceived_to
    implements
        Built<GAccountByPkData_accountByPk_transfersReceived_to,
            GAccountByPkData_accountByPk_transfersReceived_toBuilder>,
        GAccountFields_transfersReceived_to,
        GTransferFields_to {
  GAccountByPkData_accountByPk_transfersReceived_to._();

  factory GAccountByPkData_accountByPk_transfersReceived_to(
      [void Function(GAccountByPkData_accountByPk_transfersReceived_toBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersReceived_to;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceived_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accountByPk_transfersReceived_to>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceived_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceived_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersReceived_to.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersReceived_from
    implements
        Built<GAccountByPkData_accountByPk_transfersReceived_from,
            GAccountByPkData_accountByPk_transfersReceived_fromBuilder>,
        GAccountFields_transfersReceived_from,
        GTransferFields_from {
  GAccountByPkData_accountByPk_transfersReceived_from._();

  factory GAccountByPkData_accountByPk_transfersReceived_from(
      [void Function(
              GAccountByPkData_accountByPk_transfersReceived_fromBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersReceived_from;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceived_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accountByPk_transfersReceived_from>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceived_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceived_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersReceived_from.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersReceived_comment
    implements
        Built<GAccountByPkData_accountByPk_transfersReceived_comment,
            GAccountByPkData_accountByPk_transfersReceived_commentBuilder>,
        GAccountFields_transfersReceived_comment,
        GTransferFields_comment {
  GAccountByPkData_accountByPk_transfersReceived_comment._();

  factory GAccountByPkData_accountByPk_transfersReceived_comment(
      [void Function(
              GAccountByPkData_accountByPk_transfersReceived_commentBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersReceived_comment;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceived_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountByPkData_accountByPk_transfersReceived_comment>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceived_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceived_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersReceived_comment.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersReceivedAggregate
    implements
        Built<GAccountByPkData_accountByPk_transfersReceivedAggregate,
            GAccountByPkData_accountByPk_transfersReceivedAggregateBuilder>,
        GAccountFields_transfersReceivedAggregate {
  GAccountByPkData_accountByPk_transfersReceivedAggregate._();

  factory GAccountByPkData_accountByPk_transfersReceivedAggregate(
      [void Function(
              GAccountByPkData_accountByPk_transfersReceivedAggregateBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_transfersReceivedAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceivedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountByPkData_accountByPk_transfersReceivedAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_transfersReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate
    implements
        Built<GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate,
            GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregateBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate {
  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate(
          [void Function(
                  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum?
      get sum;
  @override
  int get count;
  static Serializer<
          GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum
    implements
        Built<
            GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum,
            GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate_sum {
  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum._();

  factory GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum(
          [void Function(
                  GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountByPkDataAccountByPkTransfersReceivedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accountByPk_transfersReceivedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accountByPk_wasIdentity
    implements
        Built<GAccountByPkData_accountByPk_wasIdentity,
            GAccountByPkData_accountByPk_wasIdentityBuilder>,
        GAccountFields_wasIdentity,
        GOwnerKeyChangeFields {
  GAccountByPkData_accountByPk_wasIdentity._();

  factory GAccountByPkData_accountByPk_wasIdentity(
      [void Function(GAccountByPkData_accountByPk_wasIdentityBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_wasIdentity;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_wasIdentityBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountByPkData_accountByPk_wasIdentity> get serializer =>
      _$gAccountByPkDataAccountByPkWasIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_wasIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_wasIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_wasIdentity.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_wasIdentityAggregate
    implements
        Built<GAccountByPkData_accountByPk_wasIdentityAggregate,
            GAccountByPkData_accountByPk_wasIdentityAggregateBuilder>,
        GAccountFields_wasIdentityAggregate {
  GAccountByPkData_accountByPk_wasIdentityAggregate._();

  factory GAccountByPkData_accountByPk_wasIdentityAggregate(
      [void Function(GAccountByPkData_accountByPk_wasIdentityAggregateBuilder b)
          updates]) = _$GAccountByPkData_accountByPk_wasIdentityAggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_wasIdentityAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate? get aggregate;
  static Serializer<GAccountByPkData_accountByPk_wasIdentityAggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkWasIdentityAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_wasIdentityAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_wasIdentityAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_wasIdentityAggregate.serializer,
        json,
      );
}

abstract class GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate
    implements
        Built<GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate,
            GAccountByPkData_accountByPk_wasIdentityAggregate_aggregateBuilder>,
        GAccountFields_wasIdentityAggregate_aggregate {
  GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate._();

  factory GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate(
      [void Function(
              GAccountByPkData_accountByPk_wasIdentityAggregate_aggregateBuilder
                  b)
          updates]) = _$GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate;

  static void _initializeBuilder(
          GAccountByPkData_accountByPk_wasIdentityAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate>
      get serializer =>
          _$gAccountByPkDataAccountByPkWasIdentityAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accountByPk_wasIdentityAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData
    implements Built<GAccountBasicByPkData, GAccountBasicByPkDataBuilder> {
  GAccountBasicByPkData._();

  factory GAccountBasicByPkData(
          [void Function(GAccountBasicByPkDataBuilder b) updates]) =
      _$GAccountBasicByPkData;

  static void _initializeBuilder(GAccountBasicByPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountBasicByPkData_accountByPk? get accountByPk;
  static Serializer<GAccountBasicByPkData> get serializer =>
      _$gAccountBasicByPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accountByPk
    implements
        Built<GAccountBasicByPkData_accountByPk,
            GAccountBasicByPkData_accountByPkBuilder>,
        GAccountBasicFields {
  GAccountBasicByPkData_accountByPk._();

  factory GAccountBasicByPkData_accountByPk(
          [void Function(GAccountBasicByPkData_accountByPkBuilder b) updates]) =
      _$GAccountBasicByPkData_accountByPk;

  static void _initializeBuilder(GAccountBasicByPkData_accountByPkBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GAccountBasicByPkData_accountByPk_identity? get identity;
  @override
  bool get isActive;
  static Serializer<GAccountBasicByPkData_accountByPk> get serializer =>
      _$gAccountBasicByPkDataAccountByPkSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accountByPk.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accountByPk? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accountByPk.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accountByPk_identity
    implements
        Built<GAccountBasicByPkData_accountByPk_identity,
            GAccountBasicByPkData_accountByPk_identityBuilder>,
        GAccountBasicFields_identity,
        GIdentityBasicFields {
  GAccountBasicByPkData_accountByPk_identity._();

  factory GAccountBasicByPkData_accountByPk_identity(
      [void Function(GAccountBasicByPkData_accountByPk_identityBuilder b)
          updates]) = _$GAccountBasicByPkData_accountByPk_identity;

  static void _initializeBuilder(
          GAccountBasicByPkData_accountByPk_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountBasicByPkData_accountByPk_identity>
      get serializer => _$gAccountBasicByPkDataAccountByPkIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accountByPk_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accountByPk_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accountByPk_identity.serializer,
        json,
      );
}

abstract class GAccountsByPkData
    implements Built<GAccountsByPkData, GAccountsByPkDataBuilder> {
  GAccountsByPkData._();

  factory GAccountsByPkData(
          [void Function(GAccountsByPkDataBuilder b) updates]) =
      _$GAccountsByPkData;

  static void _initializeBuilder(GAccountsByPkDataBuilder b) =>
      b..G__typename = 'query_root';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsByPkData_account> get account;
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

abstract class GAccountsByPkData_account
    implements
        Built<GAccountsByPkData_account, GAccountsByPkData_accountBuilder>,
        GAccountFields {
  GAccountsByPkData_account._();

  factory GAccountsByPkData_account(
          [void Function(GAccountsByPkData_accountBuilder b) updates]) =
      _$GAccountsByPkData_account;

  static void _initializeBuilder(GAccountsByPkData_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  BuiltList<GAccountsByPkData_account_commentsIssued> get commentsIssued;
  @override
  GAccountsByPkData_account_commentsIssuedAggregate get commentsIssuedAggregate;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GAccountsByPkData_account_identity? get identity;
  @override
  bool get isActive;
  @override
  GAccountsByPkData_account_linkedIdentity? get linkedIdentity;
  @override
  BuiltList<GAccountsByPkData_account_removedIdentities> get removedIdentities;
  @override
  GAccountsByPkData_account_removedIdentitiesAggregate
      get removedIdentitiesAggregate;
  @override
  BuiltList<GAccountsByPkData_account_transfersIssued> get transfersIssued;
  @override
  GAccountsByPkData_account_transfersIssuedAggregate
      get transfersIssuedAggregate;
  @override
  BuiltList<GAccountsByPkData_account_transfersReceived> get transfersReceived;
  @override
  GAccountsByPkData_account_transfersReceivedAggregate
      get transfersReceivedAggregate;
  @override
  BuiltList<GAccountsByPkData_account_wasIdentity> get wasIdentity;
  @override
  GAccountsByPkData_account_wasIdentityAggregate get wasIdentityAggregate;
  static Serializer<GAccountsByPkData_account> get serializer =>
      _$gAccountsByPkDataAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_commentsIssued
    implements
        Built<GAccountsByPkData_account_commentsIssued,
            GAccountsByPkData_account_commentsIssuedBuilder>,
        GAccountFields_commentsIssued,
        GCommentsIssued {
  GAccountsByPkData_account_commentsIssued._();

  factory GAccountsByPkData_account_commentsIssued(
      [void Function(GAccountsByPkData_account_commentsIssuedBuilder b)
          updates]) = _$GAccountsByPkData_account_commentsIssued;

  static void _initializeBuilder(
          GAccountsByPkData_account_commentsIssuedBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  static Serializer<GAccountsByPkData_account_commentsIssued> get serializer =>
      _$gAccountsByPkDataAccountCommentsIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_commentsIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_commentsIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_commentsIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_commentsIssuedAggregate
    implements
        Built<GAccountsByPkData_account_commentsIssuedAggregate,
            GAccountsByPkData_account_commentsIssuedAggregateBuilder>,
        GAccountFields_commentsIssuedAggregate {
  GAccountsByPkData_account_commentsIssuedAggregate._();

  factory GAccountsByPkData_account_commentsIssuedAggregate(
      [void Function(GAccountsByPkData_account_commentsIssuedAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_commentsIssuedAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_commentsIssuedAggregateBuilder b) =>
      b..G__typename = 'TxCommentAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_commentsIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountsByPkData_account_commentsIssuedAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountCommentsIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_commentsIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_commentsIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_commentsIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_commentsIssuedAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_commentsIssuedAggregate_aggregate,
            GAccountsByPkData_account_commentsIssuedAggregate_aggregateBuilder>,
        GAccountFields_commentsIssuedAggregate_aggregate {
  GAccountsByPkData_account_commentsIssuedAggregate_aggregate._();

  factory GAccountsByPkData_account_commentsIssuedAggregate_aggregate(
      [void Function(
              GAccountsByPkData_account_commentsIssuedAggregate_aggregateBuilder
                  b)
          updates]) = _$GAccountsByPkData_account_commentsIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_commentsIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TxCommentAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountsByPkData_account_commentsIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountCommentsIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_commentsIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_commentsIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_commentsIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity
    implements
        Built<GAccountsByPkData_account_identity,
            GAccountsByPkData_account_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GAccountsByPkData_account_identity._();

  factory GAccountsByPkData_account_identity(
      [void Function(GAccountsByPkData_account_identityBuilder b)
          updates]) = _$GAccountsByPkData_account_identity;

  static void _initializeBuilder(GAccountsByPkData_account_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GAccountsByPkData_account_identity_certIssued> get certIssued;
  @override
  GAccountsByPkData_account_identity_certIssuedAggregate
      get certIssuedAggregate;
  @override
  BuiltList<GAccountsByPkData_account_identity_certReceived> get certReceived;
  @override
  GAccountsByPkData_account_identity_certReceivedAggregate
      get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GAccountsByPkData_account_identity_linkedAccount> get linkedAccount;
  @override
  GAccountsByPkData_account_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GAccountsByPkData_account_identity_membershipHistory>
      get membershipHistory;
  @override
  GAccountsByPkData_account_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GAccountsByPkData_account_identity_ownerKeyChange>
      get ownerKeyChange;
  @override
  GAccountsByPkData_account_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GAccountsByPkData_account_identity_smith? get smith;
  @override
  BuiltList<GAccountsByPkData_account_identity_udHistory>? get udHistory;
  static Serializer<GAccountsByPkData_account_identity> get serializer =>
      _$gAccountsByPkDataAccountIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certIssued
    implements
        Built<GAccountsByPkData_account_identity_certIssued,
            GAccountsByPkData_account_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued,
        GCertFields {
  GAccountsByPkData_account_identity_certIssued._();

  factory GAccountsByPkData_account_identity_certIssued(
      [void Function(GAccountsByPkData_account_identity_certIssuedBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certIssued;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountsByPkData_account_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountsByPkData_account_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountsByPkData_account_identity_certIssued>
      get serializer => _$gAccountsByPkDataAccountIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certIssued_issuer
    implements
        Built<GAccountsByPkData_account_identity_certIssued_issuer,
            GAccountsByPkData_account_identity_certIssued_issuerBuilder>,
        GAccountFields_identity_certIssued_issuer,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_account_identity_certIssued_issuer._();

  factory GAccountsByPkData_account_identity_certIssued_issuer(
      [void Function(
              GAccountsByPkData_account_identity_certIssued_issuerBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certIssued_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_identity_certIssued_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certIssued_receiver
    implements
        Built<GAccountsByPkData_account_identity_certIssued_receiver,
            GAccountsByPkData_account_identity_certIssued_receiverBuilder>,
        GAccountFields_identity_certIssued_receiver,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_account_identity_certIssued_receiver._();

  factory GAccountsByPkData_account_identity_certIssued_receiver(
      [void Function(
              GAccountsByPkData_account_identity_certIssued_receiverBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certIssued_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_identity_certIssued_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certIssuedAggregate
    implements
        Built<GAccountsByPkData_account_identity_certIssuedAggregate,
            GAccountsByPkData_account_identity_certIssuedAggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate,
        GIdentityFields_certIssuedAggregate {
  GAccountsByPkData_account_identity_certIssuedAggregate._();

  factory GAccountsByPkData_account_identity_certIssuedAggregate(
      [void Function(
              GAccountsByPkData_account_identity_certIssuedAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_identity_certIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountsByPkData_account_identity_certIssuedAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certIssuedAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_identity_certIssuedAggregate_aggregate,
            GAccountsByPkData_account_identity_certIssuedAggregate_aggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate_aggregate,
        GIdentityFields_certIssuedAggregate_aggregate {
  GAccountsByPkData_account_identity_certIssuedAggregate_aggregate._();

  factory GAccountsByPkData_account_identity_certIssuedAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_identity_certIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_certIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_certReceived
    implements
        Built<GAccountsByPkData_account_identity_certReceived,
            GAccountsByPkData_account_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived,
        GCertFields {
  GAccountsByPkData_account_identity_certReceived._();

  factory GAccountsByPkData_account_identity_certReceived(
      [void Function(GAccountsByPkData_account_identity_certReceivedBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certReceived;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountsByPkData_account_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountsByPkData_account_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountsByPkData_account_identity_certReceived>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certReceived.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certReceived_issuer
    implements
        Built<GAccountsByPkData_account_identity_certReceived_issuer,
            GAccountsByPkData_account_identity_certReceived_issuerBuilder>,
        GAccountFields_identity_certReceived_issuer,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_account_identity_certReceived_issuer._();

  factory GAccountsByPkData_account_identity_certReceived_issuer(
      [void Function(
              GAccountsByPkData_account_identity_certReceived_issuerBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certReceived_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_identity_certReceived_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certReceived_receiver
    implements
        Built<GAccountsByPkData_account_identity_certReceived_receiver,
            GAccountsByPkData_account_identity_certReceived_receiverBuilder>,
        GAccountFields_identity_certReceived_receiver,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_account_identity_certReceived_receiver._();

  factory GAccountsByPkData_account_identity_certReceived_receiver(
      [void Function(
              GAccountsByPkData_account_identity_certReceived_receiverBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certReceived_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_identity_certReceived_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certReceivedAggregate
    implements
        Built<GAccountsByPkData_account_identity_certReceivedAggregate,
            GAccountsByPkData_account_identity_certReceivedAggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate,
        GIdentityFields_certReceivedAggregate {
  GAccountsByPkData_account_identity_certReceivedAggregate._();

  factory GAccountsByPkData_account_identity_certReceivedAggregate(
      [void Function(
              GAccountsByPkData_account_identity_certReceivedAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_identity_certReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountsByPkData_account_identity_certReceivedAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_certReceivedAggregate_aggregate
    implements
        Built<
            GAccountsByPkData_account_identity_certReceivedAggregate_aggregate,
            GAccountsByPkData_account_identity_certReceivedAggregate_aggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate_aggregate,
        GIdentityFields_certReceivedAggregate_aggregate {
  GAccountsByPkData_account_identity_certReceivedAggregate_aggregate._();

  factory GAccountsByPkData_account_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_certReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_certReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_certReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_linkedAccount
    implements
        Built<GAccountsByPkData_account_identity_linkedAccount,
            GAccountsByPkData_account_identity_linkedAccountBuilder>,
        GAccountFields_identity_linkedAccount,
        GIdentityFields_linkedAccount {
  GAccountsByPkData_account_identity_linkedAccount._();

  factory GAccountsByPkData_account_identity_linkedAccount(
      [void Function(GAccountsByPkData_account_identity_linkedAccountBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_linkedAccount;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_account_identity_linkedAccount>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_linkedAccountAggregate
    implements
        Built<GAccountsByPkData_account_identity_linkedAccountAggregate,
            GAccountsByPkData_account_identity_linkedAccountAggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate,
        GIdentityFields_linkedAccountAggregate {
  GAccountsByPkData_account_identity_linkedAccountAggregate._();

  factory GAccountsByPkData_account_identity_linkedAccountAggregate(
      [void Function(
              GAccountsByPkData_account_identity_linkedAccountAggregateBuilder
                  b)
          updates]) = _$GAccountsByPkData_account_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountsByPkData_account_identity_linkedAccountAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate
    implements
        Built<
            GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate,
            GAccountsByPkData_account_identity_linkedAccountAggregate_aggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate_aggregate,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate._();

  factory GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_membershipHistory
    implements
        Built<GAccountsByPkData_account_identity_membershipHistory,
            GAccountsByPkData_account_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GAccountsByPkData_account_identity_membershipHistory._();

  factory GAccountsByPkData_account_identity_membershipHistory(
      [void Function(
              GAccountsByPkData_account_identity_membershipHistoryBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_membershipHistory;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GAccountsByPkData_account_identity_membershipHistory>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_membershipHistoryAggregate
    implements
        Built<GAccountsByPkData_account_identity_membershipHistoryAggregate,
            GAccountsByPkData_account_identity_membershipHistoryAggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate,
        GIdentityFields_membershipHistoryAggregate {
  GAccountsByPkData_account_identity_membershipHistoryAggregate._();

  factory GAccountsByPkData_account_identity_membershipHistoryAggregate(
          [void Function(
                  GAccountsByPkData_account_identity_membershipHistoryAggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_membershipHistoryAggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<
          GAccountsByPkData_account_identity_membershipHistoryAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_membershipHistoryAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_membershipHistoryAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_membershipHistoryAggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate
    implements
        Built<
            GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate,
            GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate_aggregate,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate._();

  factory GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_ownerKeyChange
    implements
        Built<GAccountsByPkData_account_identity_ownerKeyChange,
            GAccountsByPkData_account_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GAccountsByPkData_account_identity_ownerKeyChange._();

  factory GAccountsByPkData_account_identity_ownerKeyChange(
      [void Function(GAccountsByPkData_account_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountsByPkData_account_identity_ownerKeyChange>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_ownerKeyChangeAggregate
    implements
        Built<GAccountsByPkData_account_identity_ownerKeyChangeAggregate,
            GAccountsByPkData_account_identity_ownerKeyChangeAggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate,
        GIdentityFields_ownerKeyChangeAggregate {
  GAccountsByPkData_account_identity_ownerKeyChangeAggregate._();

  factory GAccountsByPkData_account_identity_ownerKeyChangeAggregate(
      [void Function(
              GAccountsByPkData_account_identity_ownerKeyChangeAggregateBuilder
                  b)
          updates]) = _$GAccountsByPkData_account_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_ownerKeyChangeAggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountsByPkData_account_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<
            GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate,
            GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate_aggregate,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate._();

  factory GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_identity_smith
    implements
        Built<GAccountsByPkData_account_identity_smith,
            GAccountsByPkData_account_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountsByPkData_account_identity_smith._();

  factory GAccountsByPkData_account_identity_smith(
      [void Function(GAccountsByPkData_account_identity_smithBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_smith;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GAccountsByPkData_account_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GAccountsByPkData_account_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GAccountsByPkData_account_identity_smith> get serializer =>
      _$gAccountsByPkDataAccountIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_smith.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_smith_smithCertIssued
    implements
        Built<GAccountsByPkData_account_identity_smith_smithCertIssued,
            GAccountsByPkData_account_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GAccountsByPkData_account_identity_smith_smithCertIssued._();

  factory GAccountsByPkData_account_identity_smith_smithCertIssued(
      [void Function(
              GAccountsByPkData_account_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GAccountsByPkData_account_identity_smith_smithCertIssued>
      get serializer =>
          _$gAccountsByPkDataAccountIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_smith_smithCertReceived
    implements
        Built<GAccountsByPkData_account_identity_smith_smithCertReceived,
            GAccountsByPkData_account_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GAccountsByPkData_account_identity_smith_smithCertReceived._();

  factory GAccountsByPkData_account_identity_smith_smithCertReceived(
      [void Function(
              GAccountsByPkData_account_identity_smith_smithCertReceivedBuilder
                  b)
          updates]) = _$GAccountsByPkData_account_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GAccountsByPkData_account_identity_smith_smithCertReceived>
      get serializer =>
          _$gAccountsByPkDataAccountIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_identity_udHistory
    implements
        Built<GAccountsByPkData_account_identity_udHistory,
            GAccountsByPkData_account_identity_udHistoryBuilder>,
        GAccountFields_identity_udHistory,
        GIdentityFields_udHistory {
  GAccountsByPkData_account_identity_udHistory._();

  factory GAccountsByPkData_account_identity_udHistory(
      [void Function(GAccountsByPkData_account_identity_udHistoryBuilder b)
          updates]) = _$GAccountsByPkData_account_identity_udHistory;

  static void _initializeBuilder(
          GAccountsByPkData_account_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GAccountsByPkData_account_identity_udHistory>
      get serializer => _$gAccountsByPkDataAccountIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_identity_udHistory.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_linkedIdentity
    implements
        Built<GAccountsByPkData_account_linkedIdentity,
            GAccountsByPkData_account_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountsByPkData_account_linkedIdentity._();

  factory GAccountsByPkData_account_linkedIdentity(
      [void Function(GAccountsByPkData_account_linkedIdentityBuilder b)
          updates]) = _$GAccountsByPkData_account_linkedIdentity;

  static void _initializeBuilder(
          GAccountsByPkData_account_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_linkedIdentity> get serializer =>
      _$gAccountsByPkDataAccountLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_removedIdentities
    implements
        Built<GAccountsByPkData_account_removedIdentities,
            GAccountsByPkData_account_removedIdentitiesBuilder>,
        GAccountFields_removedIdentities,
        GIdentityBasicFields {
  GAccountsByPkData_account_removedIdentities._();

  factory GAccountsByPkData_account_removedIdentities(
      [void Function(GAccountsByPkData_account_removedIdentitiesBuilder b)
          updates]) = _$GAccountsByPkData_account_removedIdentities;

  static void _initializeBuilder(
          GAccountsByPkData_account_removedIdentitiesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountsByPkData_account_removedIdentities>
      get serializer => _$gAccountsByPkDataAccountRemovedIdentitiesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_removedIdentities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_removedIdentities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_removedIdentities.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_removedIdentitiesAggregate
    implements
        Built<GAccountsByPkData_account_removedIdentitiesAggregate,
            GAccountsByPkData_account_removedIdentitiesAggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate {
  GAccountsByPkData_account_removedIdentitiesAggregate._();

  factory GAccountsByPkData_account_removedIdentitiesAggregate(
      [void Function(
              GAccountsByPkData_account_removedIdentitiesAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_removedIdentitiesAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_removedIdentitiesAggregateBuilder b) =>
      b..G__typename = 'IdentityAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_removedIdentitiesAggregate_aggregate? get aggregate;
  static Serializer<GAccountsByPkData_account_removedIdentitiesAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountRemovedIdentitiesAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_removedIdentitiesAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_removedIdentitiesAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_removedIdentitiesAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_removedIdentitiesAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_removedIdentitiesAggregate_aggregate,
            GAccountsByPkData_account_removedIdentitiesAggregate_aggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate_aggregate {
  GAccountsByPkData_account_removedIdentitiesAggregate_aggregate._();

  factory GAccountsByPkData_account_removedIdentitiesAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_removedIdentitiesAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_removedIdentitiesAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_removedIdentitiesAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'IdentityAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_removedIdentitiesAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountRemovedIdentitiesAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_removedIdentitiesAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_removedIdentitiesAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_removedIdentitiesAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_transfersIssued
    implements
        Built<GAccountsByPkData_account_transfersIssued,
            GAccountsByPkData_account_transfersIssuedBuilder>,
        GAccountFields_transfersIssued,
        GTransferFields {
  GAccountsByPkData_account_transfersIssued._();

  factory GAccountsByPkData_account_transfersIssued(
      [void Function(GAccountsByPkData_account_transfersIssuedBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersIssued;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssuedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountsByPkData_account_transfersIssued_to? get to;
  @override
  GAccountsByPkData_account_transfersIssued_from? get from;
  @override
  GAccountsByPkData_account_transfersIssued_comment? get comment;
  static Serializer<GAccountsByPkData_account_transfersIssued> get serializer =>
      _$gAccountsByPkDataAccountTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssued_to
    implements
        Built<GAccountsByPkData_account_transfersIssued_to,
            GAccountsByPkData_account_transfersIssued_toBuilder>,
        GAccountFields_transfersIssued_to,
        GTransferFields_to {
  GAccountsByPkData_account_transfersIssued_to._();

  factory GAccountsByPkData_account_transfersIssued_to(
      [void Function(GAccountsByPkData_account_transfersIssued_toBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersIssued_to;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssued_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_account_transfersIssued_to>
      get serializer => _$gAccountsByPkDataAccountTransfersIssuedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssued_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssued_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssued_to.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssued_from
    implements
        Built<GAccountsByPkData_account_transfersIssued_from,
            GAccountsByPkData_account_transfersIssued_fromBuilder>,
        GAccountFields_transfersIssued_from,
        GTransferFields_from {
  GAccountsByPkData_account_transfersIssued_from._();

  factory GAccountsByPkData_account_transfersIssued_from(
      [void Function(GAccountsByPkData_account_transfersIssued_fromBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersIssued_from;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssued_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_account_transfersIssued_from>
      get serializer => _$gAccountsByPkDataAccountTransfersIssuedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssued_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssued_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssued_from.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssued_comment
    implements
        Built<GAccountsByPkData_account_transfersIssued_comment,
            GAccountsByPkData_account_transfersIssued_commentBuilder>,
        GAccountFields_transfersIssued_comment,
        GTransferFields_comment {
  GAccountsByPkData_account_transfersIssued_comment._();

  factory GAccountsByPkData_account_transfersIssued_comment(
      [void Function(GAccountsByPkData_account_transfersIssued_commentBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersIssued_comment;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssued_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountsByPkData_account_transfersIssued_comment>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersIssuedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssued_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssued_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssued_comment.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssuedAggregate
    implements
        Built<GAccountsByPkData_account_transfersIssuedAggregate,
            GAccountsByPkData_account_transfersIssuedAggregateBuilder>,
        GAccountFields_transfersIssuedAggregate {
  GAccountsByPkData_account_transfersIssuedAggregate._();

  factory GAccountsByPkData_account_transfersIssuedAggregate(
      [void Function(
              GAccountsByPkData_account_transfersIssuedAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersIssuedAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssuedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_transfersIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountsByPkData_account_transfersIssuedAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssuedAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_transfersIssuedAggregate_aggregate,
            GAccountsByPkData_account_transfersIssuedAggregate_aggregateBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate {
  GAccountsByPkData_account_transfersIssuedAggregate_aggregate._();

  factory GAccountsByPkData_account_transfersIssuedAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_transfersIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_transfersIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum? get sum;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_transfersIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum
    implements
        Built<GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum,
            GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate_sum {
  GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum._();

  factory GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum(
          [void Function(
                  GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersIssuedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_transfersIssuedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_transfersReceived
    implements
        Built<GAccountsByPkData_account_transfersReceived,
            GAccountsByPkData_account_transfersReceivedBuilder>,
        GAccountFields_transfersReceived,
        GTransferFields {
  GAccountsByPkData_account_transfersReceived._();

  factory GAccountsByPkData_account_transfersReceived(
      [void Function(GAccountsByPkData_account_transfersReceivedBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersReceived;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceivedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountsByPkData_account_transfersReceived_to? get to;
  @override
  GAccountsByPkData_account_transfersReceived_from? get from;
  @override
  GAccountsByPkData_account_transfersReceived_comment? get comment;
  static Serializer<GAccountsByPkData_account_transfersReceived>
      get serializer => _$gAccountsByPkDataAccountTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersReceived_to
    implements
        Built<GAccountsByPkData_account_transfersReceived_to,
            GAccountsByPkData_account_transfersReceived_toBuilder>,
        GAccountFields_transfersReceived_to,
        GTransferFields_to {
  GAccountsByPkData_account_transfersReceived_to._();

  factory GAccountsByPkData_account_transfersReceived_to(
      [void Function(GAccountsByPkData_account_transfersReceived_toBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersReceived_to;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceived_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_account_transfersReceived_to>
      get serializer => _$gAccountsByPkDataAccountTransfersReceivedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceived_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceived_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersReceived_to.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersReceived_from
    implements
        Built<GAccountsByPkData_account_transfersReceived_from,
            GAccountsByPkData_account_transfersReceived_fromBuilder>,
        GAccountFields_transfersReceived_from,
        GTransferFields_from {
  GAccountsByPkData_account_transfersReceived_from._();

  factory GAccountsByPkData_account_transfersReceived_from(
      [void Function(GAccountsByPkData_account_transfersReceived_fromBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersReceived_from;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceived_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_account_transfersReceived_from>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersReceivedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceived_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceived_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersReceived_from.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersReceived_comment
    implements
        Built<GAccountsByPkData_account_transfersReceived_comment,
            GAccountsByPkData_account_transfersReceived_commentBuilder>,
        GAccountFields_transfersReceived_comment,
        GTransferFields_comment {
  GAccountsByPkData_account_transfersReceived_comment._();

  factory GAccountsByPkData_account_transfersReceived_comment(
      [void Function(
              GAccountsByPkData_account_transfersReceived_commentBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersReceived_comment;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceived_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountsByPkData_account_transfersReceived_comment>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersReceivedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceived_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceived_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersReceived_comment.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersReceivedAggregate
    implements
        Built<GAccountsByPkData_account_transfersReceivedAggregate,
            GAccountsByPkData_account_transfersReceivedAggregateBuilder>,
        GAccountFields_transfersReceivedAggregate {
  GAccountsByPkData_account_transfersReceivedAggregate._();

  factory GAccountsByPkData_account_transfersReceivedAggregate(
      [void Function(
              GAccountsByPkData_account_transfersReceivedAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_transfersReceivedAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceivedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_transfersReceivedAggregate_aggregate? get aggregate;
  static Serializer<GAccountsByPkData_account_transfersReceivedAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_transfersReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_transfersReceivedAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_transfersReceivedAggregate_aggregate,
            GAccountsByPkData_account_transfersReceivedAggregate_aggregateBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate {
  GAccountsByPkData_account_transfersReceivedAggregate_aggregate._();

  factory GAccountsByPkData_account_transfersReceivedAggregate_aggregate(
          [void Function(
                  GAccountsByPkData_account_transfersReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_transfersReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum? get sum;
  @override
  int get count;
  static Serializer<
          GAccountsByPkData_account_transfersReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_transfersReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum
    implements
        Built<
            GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum,
            GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate_sum {
  GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum._();

  factory GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum(
          [void Function(
                  GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountsByPkDataAccountTransfersReceivedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_account_transfersReceivedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_account_wasIdentity
    implements
        Built<GAccountsByPkData_account_wasIdentity,
            GAccountsByPkData_account_wasIdentityBuilder>,
        GAccountFields_wasIdentity,
        GOwnerKeyChangeFields {
  GAccountsByPkData_account_wasIdentity._();

  factory GAccountsByPkData_account_wasIdentity(
      [void Function(GAccountsByPkData_account_wasIdentityBuilder b)
          updates]) = _$GAccountsByPkData_account_wasIdentity;

  static void _initializeBuilder(
          GAccountsByPkData_account_wasIdentityBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountsByPkData_account_wasIdentity> get serializer =>
      _$gAccountsByPkDataAccountWasIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_wasIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_wasIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_wasIdentity.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_wasIdentityAggregate
    implements
        Built<GAccountsByPkData_account_wasIdentityAggregate,
            GAccountsByPkData_account_wasIdentityAggregateBuilder>,
        GAccountFields_wasIdentityAggregate {
  GAccountsByPkData_account_wasIdentityAggregate._();

  factory GAccountsByPkData_account_wasIdentityAggregate(
      [void Function(GAccountsByPkData_account_wasIdentityAggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_wasIdentityAggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_wasIdentityAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_account_wasIdentityAggregate_aggregate? get aggregate;
  static Serializer<GAccountsByPkData_account_wasIdentityAggregate>
      get serializer =>
          _$gAccountsByPkDataAccountWasIdentityAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_wasIdentityAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_wasIdentityAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_wasIdentityAggregate.serializer,
        json,
      );
}

abstract class GAccountsByPkData_account_wasIdentityAggregate_aggregate
    implements
        Built<GAccountsByPkData_account_wasIdentityAggregate_aggregate,
            GAccountsByPkData_account_wasIdentityAggregate_aggregateBuilder>,
        GAccountFields_wasIdentityAggregate_aggregate {
  GAccountsByPkData_account_wasIdentityAggregate_aggregate._();

  factory GAccountsByPkData_account_wasIdentityAggregate_aggregate(
      [void Function(
              GAccountsByPkData_account_wasIdentityAggregate_aggregateBuilder b)
          updates]) = _$GAccountsByPkData_account_wasIdentityAggregate_aggregate;

  static void _initializeBuilder(
          GAccountsByPkData_account_wasIdentityAggregate_aggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountsByPkData_account_wasIdentityAggregate_aggregate>
      get serializer =>
          _$gAccountsByPkDataAccountWasIdentityAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_account_wasIdentityAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_account_wasIdentityAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_account_wasIdentityAggregate_aggregate.serializer,
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
            GGetHistoryAndBalanceData_accountBuilder>,
        GAccountFields {
  GGetHistoryAndBalanceData_account._();

  factory GGetHistoryAndBalanceData_account(
          [void Function(GGetHistoryAndBalanceData_accountBuilder b) updates]) =
      _$GGetHistoryAndBalanceData_account;

  static void _initializeBuilder(GGetHistoryAndBalanceData_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_commentsIssued>
      get commentsIssued;
  @override
  GGetHistoryAndBalanceData_account_commentsIssuedAggregate
      get commentsIssuedAggregate;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GGetHistoryAndBalanceData_account_identity? get identity;
  @override
  bool get isActive;
  @override
  GGetHistoryAndBalanceData_account_linkedIdentity? get linkedIdentity;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_removedIdentities>
      get removedIdentities;
  @override
  GGetHistoryAndBalanceData_account_removedIdentitiesAggregate
      get removedIdentitiesAggregate;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_transfersIssued>
      get transfersIssued;
  @override
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate
      get transfersIssuedAggregate;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_transfersReceived>
      get transfersReceived;
  @override
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate
      get transfersReceivedAggregate;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_wasIdentity> get wasIdentity;
  @override
  GGetHistoryAndBalanceData_account_wasIdentityAggregate
      get wasIdentityAggregate;
  static Serializer<GGetHistoryAndBalanceData_account> get serializer =>
      _$gGetHistoryAndBalanceDataAccountSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_commentsIssued
    implements
        Built<GGetHistoryAndBalanceData_account_commentsIssued,
            GGetHistoryAndBalanceData_account_commentsIssuedBuilder>,
        GAccountFields_commentsIssued,
        GCommentsIssued {
  GGetHistoryAndBalanceData_account_commentsIssued._();

  factory GGetHistoryAndBalanceData_account_commentsIssued(
      [void Function(GGetHistoryAndBalanceData_account_commentsIssuedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_commentsIssued;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_commentsIssuedBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  static Serializer<GGetHistoryAndBalanceData_account_commentsIssued>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountCommentsIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_commentsIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_commentsIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_commentsIssued.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_commentsIssuedAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_commentsIssuedAggregate,
            GGetHistoryAndBalanceData_account_commentsIssuedAggregateBuilder>,
        GAccountFields_commentsIssuedAggregate {
  GGetHistoryAndBalanceData_account_commentsIssuedAggregate._();

  factory GGetHistoryAndBalanceData_account_commentsIssuedAggregate(
      [void Function(
              GGetHistoryAndBalanceData_account_commentsIssuedAggregateBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_commentsIssuedAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_commentsIssuedAggregateBuilder b) =>
      b..G__typename = 'TxCommentAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GGetHistoryAndBalanceData_account_commentsIssuedAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountCommentsIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_commentsIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_commentsIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_commentsIssuedAggregate.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate,
            GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregateBuilder>,
        GAccountFields_commentsIssuedAggregate_aggregate {
  GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TxCommentAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountCommentsIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_commentsIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity
    implements
        Built<GGetHistoryAndBalanceData_account_identity,
            GGetHistoryAndBalanceData_account_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GGetHistoryAndBalanceData_account_identity._();

  factory GGetHistoryAndBalanceData_account_identity(
      [void Function(GGetHistoryAndBalanceData_account_identityBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_certIssued>
      get certIssued;
  @override
  GGetHistoryAndBalanceData_account_identity_certIssuedAggregate
      get certIssuedAggregate;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_certReceived>
      get certReceived;
  @override
  GGetHistoryAndBalanceData_account_identity_certReceivedAggregate
      get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_linkedAccount>
      get linkedAccount;
  @override
  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate
      get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_membershipHistory>
      get membershipHistory;
  @override
  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_ownerKeyChange>
      get ownerKeyChange;
  @override
  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GGetHistoryAndBalanceData_account_identity_smith? get smith;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_udHistory>?
      get udHistory;
  static Serializer<GGetHistoryAndBalanceData_account_identity>
      get serializer => _$gGetHistoryAndBalanceDataAccountIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_certIssued
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certIssued,
            GGetHistoryAndBalanceData_account_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued,
        GCertFields {
  GGetHistoryAndBalanceData_account_identity_certIssued._();

  factory GGetHistoryAndBalanceData_account_identity_certIssued(
      [void Function(
              GGetHistoryAndBalanceData_account_identity_certIssuedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_certIssued;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GGetHistoryAndBalanceData_account_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GGetHistoryAndBalanceData_account_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GGetHistoryAndBalanceData_account_identity_certIssued>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssued.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_certIssued_issuer
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certIssued_issuer,
            GGetHistoryAndBalanceData_account_identity_certIssued_issuerBuilder>,
        GAccountFields_identity_certIssued_issuer,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_identity_certIssued_issuer._();

  factory GGetHistoryAndBalanceData_account_identity_certIssued_issuer(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certIssued_issuerBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certIssued_issuer;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certIssued_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certIssued_issuer>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_certIssued_receiver
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certIssued_receiver,
            GGetHistoryAndBalanceData_account_identity_certIssued_receiverBuilder>,
        GAccountFields_identity_certIssued_receiver,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_identity_certIssued_receiver._();

  factory GGetHistoryAndBalanceData_account_identity_certIssued_receiver(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certIssued_receiverBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certIssued_receiver;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certIssued_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certIssued_receiver>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssued_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certIssued_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certIssued_receiver
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certIssuedAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certIssuedAggregate,
            GGetHistoryAndBalanceData_account_identity_certIssuedAggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate,
        GIdentityFields_certIssuedAggregate {
  GGetHistoryAndBalanceData_account_identity_certIssuedAggregate._();

  factory GGetHistoryAndBalanceData_account_identity_certIssuedAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certIssuedAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certIssuedAggregateBuilder
              b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certIssuedAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssuedAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certIssuedAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certIssuedAggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate,
            GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate_aggregate,
        GIdentityFields_certIssuedAggregate_aggregate {
  GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certReceived
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certReceived,
            GGetHistoryAndBalanceData_account_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived,
        GCertFields {
  GGetHistoryAndBalanceData_account_identity_certReceived._();

  factory GGetHistoryAndBalanceData_account_identity_certReceived(
      [void Function(
              GGetHistoryAndBalanceData_account_identity_certReceivedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_certReceived;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GGetHistoryAndBalanceData_account_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GGetHistoryAndBalanceData_account_identity_certReceived_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GGetHistoryAndBalanceData_account_identity_certReceived>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceived.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_certReceived_issuer
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certReceived_issuer,
            GGetHistoryAndBalanceData_account_identity_certReceived_issuerBuilder>,
        GAccountFields_identity_certReceived_issuer,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_identity_certReceived_issuer._();

  factory GGetHistoryAndBalanceData_account_identity_certReceived_issuer(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certReceived_issuerBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certReceived_issuer;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certReceived_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certReceived_issuer>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceived_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certReceived_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certReceived_issuer
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certReceived_receiver
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certReceived_receiver,
            GGetHistoryAndBalanceData_account_identity_certReceived_receiverBuilder>,
        GAccountFields_identity_certReceived_receiver,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_identity_certReceived_receiver._();

  factory GGetHistoryAndBalanceData_account_identity_certReceived_receiver(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certReceived_receiverBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certReceived_receiver;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certReceived_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certReceived_receiver>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceived_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certReceived_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certReceived_receiver
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certReceivedAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_identity_certReceivedAggregate,
            GGetHistoryAndBalanceData_account_identity_certReceivedAggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate,
        GIdentityFields_certReceivedAggregate {
  GGetHistoryAndBalanceData_account_identity_certReceivedAggregate._();

  factory GGetHistoryAndBalanceData_account_identity_certReceivedAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certReceivedAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certReceivedAggregateBuilder
              b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certReceivedAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceivedAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certReceivedAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certReceivedAggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate,
            GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate_aggregate,
        GIdentityFields_certReceivedAggregate_aggregate {
  GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_certReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_linkedAccount
    implements
        Built<GGetHistoryAndBalanceData_account_identity_linkedAccount,
            GGetHistoryAndBalanceData_account_identity_linkedAccountBuilder>,
        GAccountFields_identity_linkedAccount,
        GIdentityFields_linkedAccount {
  GGetHistoryAndBalanceData_account_identity_linkedAccount._();

  factory GGetHistoryAndBalanceData_account_identity_linkedAccount(
      [void Function(
              GGetHistoryAndBalanceData_account_identity_linkedAccountBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_linkedAccount;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_identity_linkedAccount>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate,
            GGetHistoryAndBalanceData_account_identity_linkedAccountAggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate,
        GIdentityFields_linkedAccountAggregate {
  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate._();

  factory GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_linkedAccountAggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate,
            GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate_aggregate,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_linkedAccountAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_membershipHistory
    implements
        Built<GGetHistoryAndBalanceData_account_identity_membershipHistory,
            GGetHistoryAndBalanceData_account_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GGetHistoryAndBalanceData_account_identity_membershipHistory._();

  factory GGetHistoryAndBalanceData_account_identity_membershipHistory(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_membershipHistoryBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_membershipHistory;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_membershipHistoryBuilder
              b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_membershipHistory>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate,
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate,
        GIdentityFields_membershipHistoryAggregate {
  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate._();

  factory GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate,
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate_aggregate,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_ownerKeyChange
    implements
        Built<GGetHistoryAndBalanceData_account_identity_ownerKeyChange,
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GGetHistoryAndBalanceData_account_identity_ownerKeyChange._();

  factory GGetHistoryAndBalanceData_account_identity_ownerKeyChange(
      [void Function(
              GGetHistoryAndBalanceData_account_identity_ownerKeyChangeBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_ownerKeyChange;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GGetHistoryAndBalanceData_account_identity_ownerKeyChange>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate,
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate,
        GIdentityFields_ownerKeyChangeAggregate {
  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate._();

  factory GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate,
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate_aggregate,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_smith
    implements
        Built<GGetHistoryAndBalanceData_account_identity_smith,
            GGetHistoryAndBalanceData_account_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GGetHistoryAndBalanceData_account_identity_smith._();

  factory GGetHistoryAndBalanceData_account_identity_smith(
      [void Function(GGetHistoryAndBalanceData_account_identity_smithBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_smith;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GGetHistoryAndBalanceData_account_identity_smith>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_smith.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued
    implements
        Built<GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued,
            GGetHistoryAndBalanceData_account_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued._();

  factory GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_smith_smithCertIssuedBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_smith_smithCertIssued
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived
    implements
        Built<
            GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived,
            GGetHistoryAndBalanceData_account_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived._();

  factory GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived(
          [void Function(
                  GGetHistoryAndBalanceData_account_identity_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<
          GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_identity_smith_smithCertReceived
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_identity_udHistory
    implements
        Built<GGetHistoryAndBalanceData_account_identity_udHistory,
            GGetHistoryAndBalanceData_account_identity_udHistoryBuilder>,
        GAccountFields_identity_udHistory,
        GIdentityFields_udHistory {
  GGetHistoryAndBalanceData_account_identity_udHistory._();

  factory GGetHistoryAndBalanceData_account_identity_udHistory(
      [void Function(
              GGetHistoryAndBalanceData_account_identity_udHistoryBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_identity_udHistory;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GGetHistoryAndBalanceData_account_identity_udHistory>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_identity_udHistory.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_linkedIdentity
    implements
        Built<GGetHistoryAndBalanceData_account_linkedIdentity,
            GGetHistoryAndBalanceData_account_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_linkedIdentity._();

  factory GGetHistoryAndBalanceData_account_linkedIdentity(
      [void Function(GGetHistoryAndBalanceData_account_linkedIdentityBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_linkedIdentity;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GGetHistoryAndBalanceData_account_linkedIdentity>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_linkedIdentity.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_removedIdentities
    implements
        Built<GGetHistoryAndBalanceData_account_removedIdentities,
            GGetHistoryAndBalanceData_account_removedIdentitiesBuilder>,
        GAccountFields_removedIdentities,
        GIdentityBasicFields {
  GGetHistoryAndBalanceData_account_removedIdentities._();

  factory GGetHistoryAndBalanceData_account_removedIdentities(
      [void Function(
              GGetHistoryAndBalanceData_account_removedIdentitiesBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_removedIdentities;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_removedIdentitiesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GGetHistoryAndBalanceData_account_removedIdentities>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountRemovedIdentitiesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_removedIdentities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_removedIdentities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_removedIdentities.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_removedIdentitiesAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_removedIdentitiesAggregate,
            GGetHistoryAndBalanceData_account_removedIdentitiesAggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate {
  GGetHistoryAndBalanceData_account_removedIdentitiesAggregate._();

  factory GGetHistoryAndBalanceData_account_removedIdentitiesAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_removedIdentitiesAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_removedIdentitiesAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_removedIdentitiesAggregateBuilder
              b) =>
      b..G__typename = 'IdentityAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_removedIdentitiesAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountRemovedIdentitiesAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_removedIdentitiesAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_removedIdentitiesAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_removedIdentitiesAggregate.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate,
            GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate_aggregate {
  GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'IdentityAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountRemovedIdentitiesAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_removedIdentitiesAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssued
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssued,
            GGetHistoryAndBalanceData_account_transfersIssuedBuilder>,
        GAccountFields_transfersIssued,
        GTransferFields {
  GGetHistoryAndBalanceData_account_transfersIssued._();

  factory GGetHistoryAndBalanceData_account_transfersIssued(
      [void Function(GGetHistoryAndBalanceData_account_transfersIssuedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssuedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GGetHistoryAndBalanceData_account_transfersIssued_to? get to;
  @override
  GGetHistoryAndBalanceData_account_transfersIssued_from? get from;
  @override
  GGetHistoryAndBalanceData_account_transfersIssued_comment? get comment;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedSerializer;

  @override
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
            GGetHistoryAndBalanceData_account_transfersIssued_toBuilder>,
        GAccountFields_transfersIssued_to,
        GTransferFields_to {
  GGetHistoryAndBalanceData_account_transfersIssued_to._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_to(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_toBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_to;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_to>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedToSerializer;

  @override
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
            GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder>,
        GAccountFields_transfersIssued_from,
        GTransferFields_from {
  GGetHistoryAndBalanceData_account_transfersIssued_from._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_from(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_from;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_from>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedFromSerializer;

  @override
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
            GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder>,
        GAccountFields_transfersIssued_comment,
        GTransferFields_comment {
  GGetHistoryAndBalanceData_account_transfersIssued_comment._();

  factory GGetHistoryAndBalanceData_account_transfersIssued_comment(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssued_comment;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssued_comment>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedCommentSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_transfersIssuedAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_transfersIssuedAggregate,
            GGetHistoryAndBalanceData_account_transfersIssuedAggregateBuilder>,
        GAccountFields_transfersIssuedAggregate {
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate._();

  factory GGetHistoryAndBalanceData_account_transfersIssuedAggregate(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersIssuedAggregateBuilder
                  b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersIssuedAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssuedAggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate?
      get aggregate;
  static Serializer<GGetHistoryAndBalanceData_account_transfersIssuedAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersIssuedAggregate.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate,
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregateBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate {
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum?
      get sum;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum
    implements
        Built<
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum,
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate_sum {
  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum._();

  factory GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersIssuedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_transfersIssuedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceived
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived,
            GGetHistoryAndBalanceData_account_transfersReceivedBuilder>,
        GAccountFields_transfersReceived,
        GTransferFields {
  GGetHistoryAndBalanceData_account_transfersReceived._();

  factory GGetHistoryAndBalanceData_account_transfersReceived(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceivedBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceivedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GGetHistoryAndBalanceData_account_transfersReceived_to? get to;
  @override
  GGetHistoryAndBalanceData_account_transfersReceived_from? get from;
  @override
  GGetHistoryAndBalanceData_account_transfersReceived_comment? get comment;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_transfersReceived_to
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_to,
            GGetHistoryAndBalanceData_account_transfersReceived_toBuilder>,
        GAccountFields_transfersReceived_to,
        GTransferFields_to {
  GGetHistoryAndBalanceData_account_transfersReceived_to._();

  factory GGetHistoryAndBalanceData_account_transfersReceived_to(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_toBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived_to;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceived_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_to>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedToSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_transfersReceived_from
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_from,
            GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder>,
        GAccountFields_transfersReceived_from,
        GTransferFields_from {
  GGetHistoryAndBalanceData_account_transfersReceived_from._();

  factory GGetHistoryAndBalanceData_account_transfersReceived_from(
      [void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_transfersReceived_from;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_from>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedFromSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_transfersReceived_comment
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceived_comment,
            GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder>,
        GAccountFields_transfersReceived_comment,
        GTransferFields_comment {
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

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GGetHistoryAndBalanceData_account_transfersReceived_comment>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedCommentSerializer;

  @override
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

abstract class GGetHistoryAndBalanceData_account_transfersReceivedAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_transfersReceivedAggregate,
            GGetHistoryAndBalanceData_account_transfersReceivedAggregateBuilder>,
        GAccountFields_transfersReceivedAggregate {
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate._();

  factory GGetHistoryAndBalanceData_account_transfersReceivedAggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceivedAggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_transfersReceivedAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceivedAggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate?
      get aggregate;
  static Serializer<
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_transfersReceivedAggregate.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate
    implements
        Built<
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate,
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregateBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate {
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum?
      get sum;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum
    implements
        Built<
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum,
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate_sum {
  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum._();

  factory GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sumBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<
          GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountTransfersReceivedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_transfersReceivedAggregate_aggregate_sum
                .serializer,
            json,
          );
}

abstract class GGetHistoryAndBalanceData_account_wasIdentity
    implements
        Built<GGetHistoryAndBalanceData_account_wasIdentity,
            GGetHistoryAndBalanceData_account_wasIdentityBuilder>,
        GAccountFields_wasIdentity,
        GOwnerKeyChangeFields {
  GGetHistoryAndBalanceData_account_wasIdentity._();

  factory GGetHistoryAndBalanceData_account_wasIdentity(
      [void Function(GGetHistoryAndBalanceData_account_wasIdentityBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_wasIdentity;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_wasIdentityBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GGetHistoryAndBalanceData_account_wasIdentity>
      get serializer => _$gGetHistoryAndBalanceDataAccountWasIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_wasIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_wasIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_wasIdentity.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_wasIdentityAggregate
    implements
        Built<GGetHistoryAndBalanceData_account_wasIdentityAggregate,
            GGetHistoryAndBalanceData_account_wasIdentityAggregateBuilder>,
        GAccountFields_wasIdentityAggregate {
  GGetHistoryAndBalanceData_account_wasIdentityAggregate._();

  factory GGetHistoryAndBalanceData_account_wasIdentityAggregate(
      [void Function(
              GGetHistoryAndBalanceData_account_wasIdentityAggregateBuilder b)
          updates]) = _$GGetHistoryAndBalanceData_account_wasIdentityAggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_wasIdentityAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate?
      get aggregate;
  static Serializer<GGetHistoryAndBalanceData_account_wasIdentityAggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountWasIdentityAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_wasIdentityAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_wasIdentityAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetHistoryAndBalanceData_account_wasIdentityAggregate.serializer,
        json,
      );
}

abstract class GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate
    implements
        Built<GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate,
            GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregateBuilder>,
        GAccountFields_wasIdentityAggregate_aggregate {
  GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate._();

  factory GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate(
          [void Function(
                  GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate;

  static void _initializeBuilder(
          GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate>
      get serializer =>
          _$gGetHistoryAndBalanceDataAccountWasIdentityAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GGetHistoryAndBalanceData_account_wasIdentityAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GCertFields {
  String get G__typename;
  String get id;
  String? get issuerId;
  GCertFields_issuer? get issuer;
  String? get receiverId;
  GCertFields_receiver? get receiver;
  int get createdOn;
  int get expireOn;
  bool get isActive;
  int get updatedOn;
  Map<String, dynamic> toJson();
}

abstract class GCertFields_issuer implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GCertFields_receiver implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GCertFieldsData
    implements Built<GCertFieldsData, GCertFieldsDataBuilder>, GCertFields {
  GCertFieldsData._();

  factory GCertFieldsData([void Function(GCertFieldsDataBuilder b) updates]) =
      _$GCertFieldsData;

  static void _initializeBuilder(GCertFieldsDataBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GCertFieldsData_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GCertFieldsData_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GCertFieldsData> get serializer =>
      _$gCertFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsData.serializer,
        json,
      );
}

abstract class GCertFieldsData_issuer
    implements
        Built<GCertFieldsData_issuer, GCertFieldsData_issuerBuilder>,
        GCertFields_issuer,
        GIdentityBasicFields {
  GCertFieldsData_issuer._();

  factory GCertFieldsData_issuer(
          [void Function(GCertFieldsData_issuerBuilder b) updates]) =
      _$GCertFieldsData_issuer;

  static void _initializeBuilder(GCertFieldsData_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GCertFieldsData_issuer> get serializer =>
      _$gCertFieldsDataIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsData_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsData_issuer? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsData_issuer.serializer,
        json,
      );
}

abstract class GCertFieldsData_receiver
    implements
        Built<GCertFieldsData_receiver, GCertFieldsData_receiverBuilder>,
        GCertFields_receiver,
        GIdentityBasicFields {
  GCertFieldsData_receiver._();

  factory GCertFieldsData_receiver(
          [void Function(GCertFieldsData_receiverBuilder b) updates]) =
      _$GCertFieldsData_receiver;

  static void _initializeBuilder(GCertFieldsData_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GCertFieldsData_receiver> get serializer =>
      _$gCertFieldsDataReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsData_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsData_receiver? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsData_receiver.serializer,
        json,
      );
}

abstract class GSmithCertFields {
  String get G__typename;
  String get id;
  String? get issuerId;
  String? get receiverId;
  int get createdOn;
  Map<String, dynamic> toJson();
}

abstract class GSmithCertFieldsData
    implements
        Built<GSmithCertFieldsData, GSmithCertFieldsDataBuilder>,
        GSmithCertFields {
  GSmithCertFieldsData._();

  factory GSmithCertFieldsData(
          [void Function(GSmithCertFieldsDataBuilder b) updates]) =
      _$GSmithCertFieldsData;

  static void _initializeBuilder(GSmithCertFieldsDataBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GSmithCertFieldsData> get serializer =>
      _$gSmithCertFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertFieldsData.serializer,
        json,
      );
}

abstract class GSmithFields {
  String get G__typename;
  String get id;
  int get forged;
  int get index;
  int? get lastChanged;
  int? get lastForged;
  BuiltList<GSmithFields_smithCertIssued> get smithCertIssued;
  BuiltList<GSmithFields_smithCertReceived> get smithCertReceived;
  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertIssued implements GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertReceived implements GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GSmithFieldsData
    implements Built<GSmithFieldsData, GSmithFieldsDataBuilder>, GSmithFields {
  GSmithFieldsData._();

  factory GSmithFieldsData([void Function(GSmithFieldsDataBuilder b) updates]) =
      _$GSmithFieldsData;

  static void _initializeBuilder(GSmithFieldsDataBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GSmithFieldsData_smithCertIssued> get smithCertIssued;
  @override
  BuiltList<GSmithFieldsData_smithCertReceived> get smithCertReceived;
  static Serializer<GSmithFieldsData> get serializer =>
      _$gSmithFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertIssued
    implements
        Built<GSmithFieldsData_smithCertIssued,
            GSmithFieldsData_smithCertIssuedBuilder>,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GSmithFieldsData_smithCertIssued._();

  factory GSmithFieldsData_smithCertIssued(
          [void Function(GSmithFieldsData_smithCertIssuedBuilder b) updates]) =
      _$GSmithFieldsData_smithCertIssued;

  static void _initializeBuilder(GSmithFieldsData_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GSmithFieldsData_smithCertIssued> get serializer =>
      _$gSmithFieldsDataSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertIssued.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertReceived
    implements
        Built<GSmithFieldsData_smithCertReceived,
            GSmithFieldsData_smithCertReceivedBuilder>,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GSmithFieldsData_smithCertReceived._();

  factory GSmithFieldsData_smithCertReceived(
      [void Function(GSmithFieldsData_smithCertReceivedBuilder b)
          updates]) = _$GSmithFieldsData_smithCertReceived;

  static void _initializeBuilder(GSmithFieldsData_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GSmithFieldsData_smithCertReceived> get serializer =>
      _$gSmithFieldsDataSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertReceived.serializer,
        json,
      );
}

abstract class GOwnerKeyChangeFields {
  String get G__typename;
  String get id;
  int get blockNumber;
  String? get identityId;
  String? get nextId;
  String? get previousId;
  Map<String, dynamic> toJson();
}

abstract class GOwnerKeyChangeFieldsData
    implements
        Built<GOwnerKeyChangeFieldsData, GOwnerKeyChangeFieldsDataBuilder>,
        GOwnerKeyChangeFields {
  GOwnerKeyChangeFieldsData._();

  factory GOwnerKeyChangeFieldsData(
          [void Function(GOwnerKeyChangeFieldsDataBuilder b) updates]) =
      _$GOwnerKeyChangeFieldsData;

  static void _initializeBuilder(GOwnerKeyChangeFieldsDataBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GOwnerKeyChangeFieldsData> get serializer =>
      _$gOwnerKeyChangeFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOwnerKeyChangeFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOwnerKeyChangeFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOwnerKeyChangeFieldsData.serializer,
        json,
      );
}

abstract class GIdentityBasicFields {
  String get G__typename;
  String? get accountId;
  String get id;
  bool get isMember;
  _i2.GIdentityStatusEnum? get status;
  String get name;
  Map<String, dynamic> toJson();
}

abstract class GIdentityBasicFieldsData
    implements
        Built<GIdentityBasicFieldsData, GIdentityBasicFieldsDataBuilder>,
        GIdentityBasicFields {
  GIdentityBasicFieldsData._();

  factory GIdentityBasicFieldsData(
          [void Function(GIdentityBasicFieldsDataBuilder b) updates]) =
      _$GIdentityBasicFieldsData;

  static void _initializeBuilder(GIdentityBasicFieldsDataBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentityBasicFieldsData> get serializer =>
      _$gIdentityBasicFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityBasicFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityBasicFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityBasicFieldsData.serializer,
        json,
      );
}

abstract class GIdentityFields {
  String get G__typename;
  String? get accountId;
  String? get accountRemovedId;
  BuiltList<GIdentityFields_certIssued> get certIssued;
  GIdentityFields_certIssuedAggregate get certIssuedAggregate;
  BuiltList<GIdentityFields_certReceived> get certReceived;
  GIdentityFields_certReceivedAggregate get certReceivedAggregate;
  String? get createdInId;
  int get createdOn;
  int get expireOn;
  String get id;
  int get index;
  bool get isMember;
  int get lastChangeOn;
  BuiltList<GIdentityFields_linkedAccount> get linkedAccount;
  GIdentityFields_linkedAccountAggregate get linkedAccountAggregate;
  _i2.GIdentityStatusEnum? get status;
  BuiltList<GIdentityFields_membershipHistory> get membershipHistory;
  GIdentityFields_membershipHistoryAggregate get membershipHistoryAggregate;
  String get name;
  BuiltList<GIdentityFields_ownerKeyChange> get ownerKeyChange;
  GIdentityFields_ownerKeyChangeAggregate get ownerKeyChangeAggregate;
  GIdentityFields_smith? get smith;
  BuiltList<GIdentityFields_udHistory>? get udHistory;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued implements GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFields_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFields_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssuedAggregate {
  String get G__typename;
  GIdentityFields_certIssuedAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssuedAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived implements GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFields_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFields_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceivedAggregate {
  String get G__typename;
  GIdentityFields_certReceivedAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceivedAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_linkedAccount {
  String get G__typename;
  String get id;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_linkedAccountAggregate {
  String get G__typename;
  GIdentityFields_linkedAccountAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_linkedAccountAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipHistory {
  String get G__typename;
  int get blockNumber;
  String? get eventId;
  _i2.GEventTypeEnum? get eventType;
  String get id;
  String? get identityId;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipHistoryAggregate {
  String get G__typename;
  GIdentityFields_membershipHistoryAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipHistoryAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_ownerKeyChange implements GOwnerKeyChangeFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_ownerKeyChangeAggregate {
  String get G__typename;
  GIdentityFields_ownerKeyChangeAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_ownerKeyChangeAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith implements GSmithFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GIdentityFields_smith_smithCertIssued> get smithCertIssued;
  @override
  BuiltList<GIdentityFields_smith_smithCertReceived> get smithCertReceived;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertIssued
    implements GSmithFields_smithCertIssued, GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertReceived
    implements GSmithFields_smithCertReceived, GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_udHistory {
  String get G__typename;
  String get id;
  int get amount;
  _i2.Gtimestamptz get timestamp;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFieldsData
    implements
        Built<GIdentityFieldsData, GIdentityFieldsDataBuilder>,
        GIdentityFields {
  GIdentityFieldsData._();

  factory GIdentityFieldsData(
          [void Function(GIdentityFieldsDataBuilder b) updates]) =
      _$GIdentityFieldsData;

  static void _initializeBuilder(GIdentityFieldsDataBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GIdentityFieldsData_certIssued> get certIssued;
  @override
  GIdentityFieldsData_certIssuedAggregate get certIssuedAggregate;
  @override
  BuiltList<GIdentityFieldsData_certReceived> get certReceived;
  @override
  GIdentityFieldsData_certReceivedAggregate get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GIdentityFieldsData_linkedAccount> get linkedAccount;
  @override
  GIdentityFieldsData_linkedAccountAggregate get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GIdentityFieldsData_membershipHistory> get membershipHistory;
  @override
  GIdentityFieldsData_membershipHistoryAggregate get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GIdentityFieldsData_ownerKeyChange> get ownerKeyChange;
  @override
  GIdentityFieldsData_ownerKeyChangeAggregate get ownerKeyChangeAggregate;
  @override
  GIdentityFieldsData_smith? get smith;
  @override
  BuiltList<GIdentityFieldsData_udHistory>? get udHistory;
  static Serializer<GIdentityFieldsData> get serializer =>
      _$gIdentityFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued
    implements
        Built<GIdentityFieldsData_certIssued,
            GIdentityFieldsData_certIssuedBuilder>,
        GIdentityFields_certIssued,
        GCertFields {
  GIdentityFieldsData_certIssued._();

  factory GIdentityFieldsData_certIssued(
          [void Function(GIdentityFieldsData_certIssuedBuilder b) updates]) =
      _$GIdentityFieldsData_certIssued;

  static void _initializeBuilder(GIdentityFieldsData_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFieldsData_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFieldsData_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentityFieldsData_certIssued> get serializer =>
      _$gIdentityFieldsDataCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_issuer
    implements
        Built<GIdentityFieldsData_certIssued_issuer,
            GIdentityFieldsData_certIssued_issuerBuilder>,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certIssued_issuer._();

  factory GIdentityFieldsData_certIssued_issuer(
      [void Function(GIdentityFieldsData_certIssued_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentityFieldsData_certIssued_issuer> get serializer =>
      _$gIdentityFieldsDataCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_receiver
    implements
        Built<GIdentityFieldsData_certIssued_receiver,
            GIdentityFieldsData_certIssued_receiverBuilder>,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certIssued_receiver._();

  factory GIdentityFieldsData_certIssued_receiver(
      [void Function(GIdentityFieldsData_certIssued_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentityFieldsData_certIssued_receiver> get serializer =>
      _$gIdentityFieldsDataCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssuedAggregate
    implements
        Built<GIdentityFieldsData_certIssuedAggregate,
            GIdentityFieldsData_certIssuedAggregateBuilder>,
        GIdentityFields_certIssuedAggregate {
  GIdentityFieldsData_certIssuedAggregate._();

  factory GIdentityFieldsData_certIssuedAggregate(
      [void Function(GIdentityFieldsData_certIssuedAggregateBuilder b)
          updates]) = _$GIdentityFieldsData_certIssuedAggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentityFieldsData_certIssuedAggregate_aggregate? get aggregate;
  static Serializer<GIdentityFieldsData_certIssuedAggregate> get serializer =>
      _$gIdentityFieldsDataCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssuedAggregate_aggregate
    implements
        Built<GIdentityFieldsData_certIssuedAggregate_aggregate,
            GIdentityFieldsData_certIssuedAggregate_aggregateBuilder>,
        GIdentityFields_certIssuedAggregate_aggregate {
  GIdentityFieldsData_certIssuedAggregate_aggregate._();

  factory GIdentityFieldsData_certIssuedAggregate_aggregate(
      [void Function(GIdentityFieldsData_certIssuedAggregate_aggregateBuilder b)
          updates]) = _$GIdentityFieldsData_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssuedAggregate_aggregateBuilder b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentityFieldsData_certIssuedAggregate_aggregate>
      get serializer =>
          _$gIdentityFieldsDataCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived
    implements
        Built<GIdentityFieldsData_certReceived,
            GIdentityFieldsData_certReceivedBuilder>,
        GIdentityFields_certReceived,
        GCertFields {
  GIdentityFieldsData_certReceived._();

  factory GIdentityFieldsData_certReceived(
          [void Function(GIdentityFieldsData_certReceivedBuilder b) updates]) =
      _$GIdentityFieldsData_certReceived;

  static void _initializeBuilder(GIdentityFieldsData_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFieldsData_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFieldsData_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentityFieldsData_certReceived> get serializer =>
      _$gIdentityFieldsDataCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_issuer
    implements
        Built<GIdentityFieldsData_certReceived_issuer,
            GIdentityFieldsData_certReceived_issuerBuilder>,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certReceived_issuer._();

  factory GIdentityFieldsData_certReceived_issuer(
      [void Function(GIdentityFieldsData_certReceived_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentityFieldsData_certReceived_issuer> get serializer =>
      _$gIdentityFieldsDataCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_receiver
    implements
        Built<GIdentityFieldsData_certReceived_receiver,
            GIdentityFieldsData_certReceived_receiverBuilder>,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certReceived_receiver._();

  factory GIdentityFieldsData_certReceived_receiver(
      [void Function(GIdentityFieldsData_certReceived_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GIdentityFieldsData_certReceived_receiver> get serializer =>
      _$gIdentityFieldsDataCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceivedAggregate
    implements
        Built<GIdentityFieldsData_certReceivedAggregate,
            GIdentityFieldsData_certReceivedAggregateBuilder>,
        GIdentityFields_certReceivedAggregate {
  GIdentityFieldsData_certReceivedAggregate._();

  factory GIdentityFieldsData_certReceivedAggregate(
      [void Function(GIdentityFieldsData_certReceivedAggregateBuilder b)
          updates]) = _$GIdentityFieldsData_certReceivedAggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentityFieldsData_certReceivedAggregate_aggregate? get aggregate;
  static Serializer<GIdentityFieldsData_certReceivedAggregate> get serializer =>
      _$gIdentityFieldsDataCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceivedAggregate_aggregate
    implements
        Built<GIdentityFieldsData_certReceivedAggregate_aggregate,
            GIdentityFieldsData_certReceivedAggregate_aggregateBuilder>,
        GIdentityFields_certReceivedAggregate_aggregate {
  GIdentityFieldsData_certReceivedAggregate_aggregate._();

  factory GIdentityFieldsData_certReceivedAggregate_aggregate(
      [void Function(
              GIdentityFieldsData_certReceivedAggregate_aggregateBuilder b)
          updates]) = _$GIdentityFieldsData_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceivedAggregate_aggregateBuilder b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentityFieldsData_certReceivedAggregate_aggregate>
      get serializer =>
          _$gIdentityFieldsDataCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceivedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceivedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceivedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_linkedAccount
    implements
        Built<GIdentityFieldsData_linkedAccount,
            GIdentityFieldsData_linkedAccountBuilder>,
        GIdentityFields_linkedAccount {
  GIdentityFieldsData_linkedAccount._();

  factory GIdentityFieldsData_linkedAccount(
          [void Function(GIdentityFieldsData_linkedAccountBuilder b) updates]) =
      _$GIdentityFieldsData_linkedAccount;

  static void _initializeBuilder(GIdentityFieldsData_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GIdentityFieldsData_linkedAccount> get serializer =>
      _$gIdentityFieldsDataLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_linkedAccount.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_linkedAccountAggregate
    implements
        Built<GIdentityFieldsData_linkedAccountAggregate,
            GIdentityFieldsData_linkedAccountAggregateBuilder>,
        GIdentityFields_linkedAccountAggregate {
  GIdentityFieldsData_linkedAccountAggregate._();

  factory GIdentityFieldsData_linkedAccountAggregate(
      [void Function(GIdentityFieldsData_linkedAccountAggregateBuilder b)
          updates]) = _$GIdentityFieldsData_linkedAccountAggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentityFieldsData_linkedAccountAggregate_aggregate? get aggregate;
  static Serializer<GIdentityFieldsData_linkedAccountAggregate>
      get serializer => _$gIdentityFieldsDataLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_linkedAccountAggregate_aggregate
    implements
        Built<GIdentityFieldsData_linkedAccountAggregate_aggregate,
            GIdentityFieldsData_linkedAccountAggregate_aggregateBuilder>,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GIdentityFieldsData_linkedAccountAggregate_aggregate._();

  factory GIdentityFieldsData_linkedAccountAggregate_aggregate(
      [void Function(
              GIdentityFieldsData_linkedAccountAggregate_aggregateBuilder b)
          updates]) = _$GIdentityFieldsData_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_linkedAccountAggregate_aggregateBuilder b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentityFieldsData_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gIdentityFieldsDataLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_linkedAccountAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_linkedAccountAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_linkedAccountAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_membershipHistory
    implements
        Built<GIdentityFieldsData_membershipHistory,
            GIdentityFieldsData_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentityFieldsData_membershipHistory._();

  factory GIdentityFieldsData_membershipHistory(
      [void Function(GIdentityFieldsData_membershipHistoryBuilder b)
          updates]) = _$GIdentityFieldsData_membershipHistory;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GIdentityFieldsData_membershipHistory> get serializer =>
      _$gIdentityFieldsDataMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_membershipHistoryAggregate
    implements
        Built<GIdentityFieldsData_membershipHistoryAggregate,
            GIdentityFieldsData_membershipHistoryAggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate {
  GIdentityFieldsData_membershipHistoryAggregate._();

  factory GIdentityFieldsData_membershipHistoryAggregate(
      [void Function(GIdentityFieldsData_membershipHistoryAggregateBuilder b)
          updates]) = _$GIdentityFieldsData_membershipHistoryAggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipHistoryAggregateBuilder b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentityFieldsData_membershipHistoryAggregate_aggregate? get aggregate;
  static Serializer<GIdentityFieldsData_membershipHistoryAggregate>
      get serializer =>
          _$gIdentityFieldsDataMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipHistoryAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipHistoryAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipHistoryAggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_membershipHistoryAggregate_aggregate
    implements
        Built<GIdentityFieldsData_membershipHistoryAggregate_aggregate,
            GIdentityFieldsData_membershipHistoryAggregate_aggregateBuilder>,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GIdentityFieldsData_membershipHistoryAggregate_aggregate._();

  factory GIdentityFieldsData_membershipHistoryAggregate_aggregate(
      [void Function(
              GIdentityFieldsData_membershipHistoryAggregate_aggregateBuilder b)
          updates]) = _$GIdentityFieldsData_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipHistoryAggregate_aggregateBuilder b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentityFieldsData_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gIdentityFieldsDataMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipHistoryAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipHistoryAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipHistoryAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_ownerKeyChange
    implements
        Built<GIdentityFieldsData_ownerKeyChange,
            GIdentityFieldsData_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GIdentityFieldsData_ownerKeyChange._();

  factory GIdentityFieldsData_ownerKeyChange(
      [void Function(GIdentityFieldsData_ownerKeyChangeBuilder b)
          updates]) = _$GIdentityFieldsData_ownerKeyChange;

  static void _initializeBuilder(GIdentityFieldsData_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GIdentityFieldsData_ownerKeyChange> get serializer =>
      _$gIdentityFieldsDataOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_ownerKeyChangeAggregate
    implements
        Built<GIdentityFieldsData_ownerKeyChangeAggregate,
            GIdentityFieldsData_ownerKeyChangeAggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate {
  GIdentityFieldsData_ownerKeyChangeAggregate._();

  factory GIdentityFieldsData_ownerKeyChangeAggregate(
      [void Function(GIdentityFieldsData_ownerKeyChangeAggregateBuilder b)
          updates]) = _$GIdentityFieldsData_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_ownerKeyChangeAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentityFieldsData_ownerKeyChangeAggregate_aggregate? get aggregate;
  static Serializer<GIdentityFieldsData_ownerKeyChangeAggregate>
      get serializer => _$gIdentityFieldsDataOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_ownerKeyChangeAggregate_aggregate
    implements
        Built<GIdentityFieldsData_ownerKeyChangeAggregate_aggregate,
            GIdentityFieldsData_ownerKeyChangeAggregate_aggregateBuilder>,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GIdentityFieldsData_ownerKeyChangeAggregate_aggregate._();

  factory GIdentityFieldsData_ownerKeyChangeAggregate_aggregate(
      [void Function(
              GIdentityFieldsData_ownerKeyChangeAggregate_aggregateBuilder b)
          updates]) = _$GIdentityFieldsData_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GIdentityFieldsData_ownerKeyChangeAggregate_aggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GIdentityFieldsData_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gIdentityFieldsDataOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_ownerKeyChangeAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_ownerKeyChangeAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_ownerKeyChangeAggregate_aggregate.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith
    implements
        Built<GIdentityFieldsData_smith, GIdentityFieldsData_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentityFieldsData_smith._();

  factory GIdentityFieldsData_smith(
          [void Function(GIdentityFieldsData_smithBuilder b) updates]) =
      _$GIdentityFieldsData_smith;

  static void _initializeBuilder(GIdentityFieldsData_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GIdentityFieldsData_smith_smithCertIssued> get smithCertIssued;
  @override
  BuiltList<GIdentityFieldsData_smith_smithCertReceived> get smithCertReceived;
  static Serializer<GIdentityFieldsData_smith> get serializer =>
      _$gIdentityFieldsDataSmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertIssued
    implements
        Built<GIdentityFieldsData_smith_smithCertIssued,
            GIdentityFieldsData_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertIssued._();

  factory GIdentityFieldsData_smith_smithCertIssued(
      [void Function(GIdentityFieldsData_smith_smithCertIssuedBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_smith_smithCertIssued> get serializer =>
      _$gIdentityFieldsDataSmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertReceived
    implements
        Built<GIdentityFieldsData_smith_smithCertReceived,
            GIdentityFieldsData_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertReceived._();

  factory GIdentityFieldsData_smith_smithCertReceived(
      [void Function(GIdentityFieldsData_smith_smithCertReceivedBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_smith_smithCertReceived>
      get serializer => _$gIdentityFieldsDataSmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_udHistory
    implements
        Built<GIdentityFieldsData_udHistory,
            GIdentityFieldsData_udHistoryBuilder>,
        GIdentityFields_udHistory {
  GIdentityFieldsData_udHistory._();

  factory GIdentityFieldsData_udHistory(
          [void Function(GIdentityFieldsData_udHistoryBuilder b) updates]) =
      _$GIdentityFieldsData_udHistory;

  static void _initializeBuilder(GIdentityFieldsData_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GIdentityFieldsData_udHistory> get serializer =>
      _$gIdentityFieldsDataUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_udHistory? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_udHistory.serializer,
        json,
      );
}

abstract class GCommentsIssued {
  String get G__typename;
  String? get authorId;
  int get blockNumber;
  String? get eventId;
  String get hash;
  String get id;
  String get remark;
  _i2.GCommentTypeEnum? get type;
  Map<String, dynamic> toJson();
}

abstract class GCommentsIssuedData
    implements
        Built<GCommentsIssuedData, GCommentsIssuedDataBuilder>,
        GCommentsIssued {
  GCommentsIssuedData._();

  factory GCommentsIssuedData(
          [void Function(GCommentsIssuedDataBuilder b) updates]) =
      _$GCommentsIssuedData;

  static void _initializeBuilder(GCommentsIssuedDataBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  static Serializer<GCommentsIssuedData> get serializer =>
      _$gCommentsIssuedDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentsIssuedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentsIssuedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentsIssuedData.serializer,
        json,
      );
}

abstract class GAccountBasicFields {
  String get G__typename;
  int get createdOn;
  String get id;
  GAccountBasicFields_identity? get identity;
  bool get isActive;
  Map<String, dynamic> toJson();
}

abstract class GAccountBasicFields_identity implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountBasicFieldsData
    implements
        Built<GAccountBasicFieldsData, GAccountBasicFieldsDataBuilder>,
        GAccountBasicFields {
  GAccountBasicFieldsData._();

  factory GAccountBasicFieldsData(
          [void Function(GAccountBasicFieldsDataBuilder b) updates]) =
      _$GAccountBasicFieldsData;

  static void _initializeBuilder(GAccountBasicFieldsDataBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GAccountBasicFieldsData_identity? get identity;
  @override
  bool get isActive;
  static Serializer<GAccountBasicFieldsData> get serializer =>
      _$gAccountBasicFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsData.serializer,
        json,
      );
}

abstract class GAccountBasicFieldsData_identity
    implements
        Built<GAccountBasicFieldsData_identity,
            GAccountBasicFieldsData_identityBuilder>,
        GAccountBasicFields_identity,
        GIdentityBasicFields {
  GAccountBasicFieldsData_identity._();

  factory GAccountBasicFieldsData_identity(
          [void Function(GAccountBasicFieldsData_identityBuilder b) updates]) =
      _$GAccountBasicFieldsData_identity;

  static void _initializeBuilder(GAccountBasicFieldsData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountBasicFieldsData_identity> get serializer =>
      _$gAccountBasicFieldsDataIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsData_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsData_identity.serializer,
        json,
      );
}

abstract class GAccountFields {
  String get G__typename;
  BuiltList<GAccountFields_commentsIssued> get commentsIssued;
  GAccountFields_commentsIssuedAggregate get commentsIssuedAggregate;
  int get createdOn;
  String get id;
  GAccountFields_identity? get identity;
  bool get isActive;
  GAccountFields_linkedIdentity? get linkedIdentity;
  BuiltList<GAccountFields_removedIdentities> get removedIdentities;
  GAccountFields_removedIdentitiesAggregate get removedIdentitiesAggregate;
  BuiltList<GAccountFields_transfersIssued> get transfersIssued;
  GAccountFields_transfersIssuedAggregate get transfersIssuedAggregate;
  BuiltList<GAccountFields_transfersReceived> get transfersReceived;
  GAccountFields_transfersReceivedAggregate get transfersReceivedAggregate;
  BuiltList<GAccountFields_wasIdentity> get wasIdentity;
  GAccountFields_wasIdentityAggregate get wasIdentityAggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_commentsIssued implements GCommentsIssued {
  @override
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_commentsIssuedAggregate {
  String get G__typename;
  GAccountFields_commentsIssuedAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_commentsIssuedAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity implements GIdentityFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GAccountFields_identity_certIssued> get certIssued;
  @override
  GAccountFields_identity_certIssuedAggregate get certIssuedAggregate;
  @override
  BuiltList<GAccountFields_identity_certReceived> get certReceived;
  @override
  GAccountFields_identity_certReceivedAggregate get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GAccountFields_identity_linkedAccount> get linkedAccount;
  @override
  GAccountFields_identity_linkedAccountAggregate get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GAccountFields_identity_membershipHistory> get membershipHistory;
  @override
  GAccountFields_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GAccountFields_identity_ownerKeyChange> get ownerKeyChange;
  @override
  GAccountFields_identity_ownerKeyChangeAggregate get ownerKeyChangeAggregate;
  @override
  GAccountFields_identity_smith? get smith;
  @override
  BuiltList<GAccountFields_identity_udHistory>? get udHistory;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued
    implements GIdentityFields_certIssued, GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFields_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFields_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_issuer
    implements
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_receiver
    implements
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssuedAggregate
    implements GIdentityFields_certIssuedAggregate {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_certIssuedAggregate_aggregate? get aggregate;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssuedAggregate_aggregate
    implements GIdentityFields_certIssuedAggregate_aggregate {
  @override
  String get G__typename;
  @override
  int get count;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived
    implements GIdentityFields_certReceived, GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFields_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFields_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_issuer
    implements
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_receiver
    implements
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceivedAggregate
    implements GIdentityFields_certReceivedAggregate {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_certReceivedAggregate_aggregate? get aggregate;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceivedAggregate_aggregate
    implements GIdentityFields_certReceivedAggregate_aggregate {
  @override
  String get G__typename;
  @override
  int get count;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_linkedAccount
    implements GIdentityFields_linkedAccount {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_linkedAccountAggregate
    implements GIdentityFields_linkedAccountAggregate {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_linkedAccountAggregate_aggregate? get aggregate;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_linkedAccountAggregate_aggregate
    implements GIdentityFields_linkedAccountAggregate_aggregate {
  @override
  String get G__typename;
  @override
  int get count;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_membershipHistory
    implements GIdentityFields_membershipHistory {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_membershipHistoryAggregate
    implements GIdentityFields_membershipHistoryAggregate {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_membershipHistoryAggregate_aggregate? get aggregate;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_membershipHistoryAggregate_aggregate
    implements GIdentityFields_membershipHistoryAggregate_aggregate {
  @override
  String get G__typename;
  @override
  int get count;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_ownerKeyChange
    implements GIdentityFields_ownerKeyChange, GOwnerKeyChangeFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_ownerKeyChangeAggregate
    implements GIdentityFields_ownerKeyChangeAggregate {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_ownerKeyChangeAggregate_aggregate? get aggregate;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_ownerKeyChangeAggregate_aggregate
    implements GIdentityFields_ownerKeyChangeAggregate_aggregate {
  @override
  String get G__typename;
  @override
  int get count;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith
    implements GIdentityFields_smith, GSmithFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GAccountFields_identity_smith_smithCertIssued> get smithCertIssued;
  @override
  BuiltList<GAccountFields_identity_smith_smithCertReceived>
      get smithCertReceived;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith_smithCertIssued
    implements
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith_smithCertReceived
    implements
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_udHistory
    implements GIdentityFields_udHistory {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_removedIdentities
    implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_removedIdentitiesAggregate {
  String get G__typename;
  GAccountFields_removedIdentitiesAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_removedIdentitiesAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountFields_transfersIssued_to? get to;
  @override
  GAccountFields_transfersIssued_from? get from;
  @override
  GAccountFields_transfersIssued_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_to implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssuedAggregate {
  String get G__typename;
  GAccountFields_transfersIssuedAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssuedAggregate_aggregate {
  String get G__typename;
  GAccountFields_transfersIssuedAggregate_aggregate_sum? get sum;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssuedAggregate_aggregate_sum {
  String get G__typename;
  int? get amount;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountFields_transfersReceived_to? get to;
  @override
  GAccountFields_transfersReceived_from? get from;
  @override
  GAccountFields_transfersReceived_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_to
    implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceivedAggregate {
  String get G__typename;
  GAccountFields_transfersReceivedAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceivedAggregate_aggregate {
  String get G__typename;
  GAccountFields_transfersReceivedAggregate_aggregate_sum? get sum;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceivedAggregate_aggregate_sum {
  String get G__typename;
  int? get amount;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentity implements GOwnerKeyChangeFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentityAggregate {
  String get G__typename;
  GAccountFields_wasIdentityAggregate_aggregate? get aggregate;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentityAggregate_aggregate {
  String get G__typename;
  int get count;
  Map<String, dynamic> toJson();
}

abstract class GAccountFieldsData
    implements
        Built<GAccountFieldsData, GAccountFieldsDataBuilder>,
        GAccountFields {
  GAccountFieldsData._();

  factory GAccountFieldsData(
          [void Function(GAccountFieldsDataBuilder b) updates]) =
      _$GAccountFieldsData;

  static void _initializeBuilder(GAccountFieldsDataBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  BuiltList<GAccountFieldsData_commentsIssued> get commentsIssued;
  @override
  GAccountFieldsData_commentsIssuedAggregate get commentsIssuedAggregate;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  GAccountFieldsData_identity? get identity;
  @override
  bool get isActive;
  @override
  GAccountFieldsData_linkedIdentity? get linkedIdentity;
  @override
  BuiltList<GAccountFieldsData_removedIdentities> get removedIdentities;
  @override
  GAccountFieldsData_removedIdentitiesAggregate get removedIdentitiesAggregate;
  @override
  BuiltList<GAccountFieldsData_transfersIssued> get transfersIssued;
  @override
  GAccountFieldsData_transfersIssuedAggregate get transfersIssuedAggregate;
  @override
  BuiltList<GAccountFieldsData_transfersReceived> get transfersReceived;
  @override
  GAccountFieldsData_transfersReceivedAggregate get transfersReceivedAggregate;
  @override
  BuiltList<GAccountFieldsData_wasIdentity> get wasIdentity;
  @override
  GAccountFieldsData_wasIdentityAggregate get wasIdentityAggregate;
  static Serializer<GAccountFieldsData> get serializer =>
      _$gAccountFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData.serializer,
        json,
      );
}

abstract class GAccountFieldsData_commentsIssued
    implements
        Built<GAccountFieldsData_commentsIssued,
            GAccountFieldsData_commentsIssuedBuilder>,
        GAccountFields_commentsIssued,
        GCommentsIssued {
  GAccountFieldsData_commentsIssued._();

  factory GAccountFieldsData_commentsIssued(
          [void Function(GAccountFieldsData_commentsIssuedBuilder b) updates]) =
      _$GAccountFieldsData_commentsIssued;

  static void _initializeBuilder(GAccountFieldsData_commentsIssuedBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get authorId;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get hash;
  @override
  String get id;
  @override
  String get remark;
  @override
  _i2.GCommentTypeEnum? get type;
  static Serializer<GAccountFieldsData_commentsIssued> get serializer =>
      _$gAccountFieldsDataCommentsIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_commentsIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_commentsIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_commentsIssued.serializer,
        json,
      );
}

abstract class GAccountFieldsData_commentsIssuedAggregate
    implements
        Built<GAccountFieldsData_commentsIssuedAggregate,
            GAccountFieldsData_commentsIssuedAggregateBuilder>,
        GAccountFields_commentsIssuedAggregate {
  GAccountFieldsData_commentsIssuedAggregate._();

  factory GAccountFieldsData_commentsIssuedAggregate(
      [void Function(GAccountFieldsData_commentsIssuedAggregateBuilder b)
          updates]) = _$GAccountFieldsData_commentsIssuedAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_commentsIssuedAggregateBuilder b) =>
      b..G__typename = 'TxCommentAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_commentsIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_commentsIssuedAggregate>
      get serializer => _$gAccountFieldsDataCommentsIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_commentsIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_commentsIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_commentsIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_commentsIssuedAggregate_aggregate
    implements
        Built<GAccountFieldsData_commentsIssuedAggregate_aggregate,
            GAccountFieldsData_commentsIssuedAggregate_aggregateBuilder>,
        GAccountFields_commentsIssuedAggregate_aggregate {
  GAccountFieldsData_commentsIssuedAggregate_aggregate._();

  factory GAccountFieldsData_commentsIssuedAggregate_aggregate(
      [void Function(
              GAccountFieldsData_commentsIssuedAggregate_aggregateBuilder b)
          updates]) = _$GAccountFieldsData_commentsIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_commentsIssuedAggregate_aggregateBuilder b) =>
      b..G__typename = 'TxCommentAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountFieldsData_commentsIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataCommentsIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_commentsIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_commentsIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_commentsIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity
    implements
        Built<GAccountFieldsData_identity, GAccountFieldsData_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GAccountFieldsData_identity._();

  factory GAccountFieldsData_identity(
          [void Function(GAccountFieldsData_identityBuilder b) updates]) =
      _$GAccountFieldsData_identity;

  static void _initializeBuilder(GAccountFieldsData_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  BuiltList<GAccountFieldsData_identity_certIssued> get certIssued;
  @override
  GAccountFieldsData_identity_certIssuedAggregate get certIssuedAggregate;
  @override
  BuiltList<GAccountFieldsData_identity_certReceived> get certReceived;
  @override
  GAccountFieldsData_identity_certReceivedAggregate get certReceivedAggregate;
  @override
  String? get createdInId;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  String get id;
  @override
  int get index;
  @override
  bool get isMember;
  @override
  int get lastChangeOn;
  @override
  BuiltList<GAccountFieldsData_identity_linkedAccount> get linkedAccount;
  @override
  GAccountFieldsData_identity_linkedAccountAggregate get linkedAccountAggregate;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  BuiltList<GAccountFieldsData_identity_membershipHistory>
      get membershipHistory;
  @override
  GAccountFieldsData_identity_membershipHistoryAggregate
      get membershipHistoryAggregate;
  @override
  String get name;
  @override
  BuiltList<GAccountFieldsData_identity_ownerKeyChange> get ownerKeyChange;
  @override
  GAccountFieldsData_identity_ownerKeyChangeAggregate
      get ownerKeyChangeAggregate;
  @override
  GAccountFieldsData_identity_smith? get smith;
  @override
  BuiltList<GAccountFieldsData_identity_udHistory>? get udHistory;
  static Serializer<GAccountFieldsData_identity> get serializer =>
      _$gAccountFieldsDataIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued
    implements
        Built<GAccountFieldsData_identity_certIssued,
            GAccountFieldsData_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued,
        GCertFields {
  GAccountFieldsData_identity_certIssued._();

  factory GAccountFieldsData_identity_certIssued(
      [void Function(GAccountFieldsData_identity_certIssuedBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssuedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFieldsData_identity_certIssued_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFieldsData_identity_certIssued_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountFieldsData_identity_certIssued> get serializer =>
      _$gAccountFieldsDataIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_issuer
    implements
        Built<GAccountFieldsData_identity_certIssued_issuer,
            GAccountFieldsData_identity_certIssued_issuerBuilder>,
        GAccountFields_identity_certIssued_issuer,
        GIdentityFields_certIssued_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certIssued_issuer._();

  factory GAccountFieldsData_identity_certIssued_issuer(
      [void Function(GAccountFieldsData_identity_certIssued_issuerBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_identity_certIssued_issuer>
      get serializer => _$gAccountFieldsDataIdentityCertIssuedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_issuer.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_receiver
    implements
        Built<GAccountFieldsData_identity_certIssued_receiver,
            GAccountFieldsData_identity_certIssued_receiverBuilder>,
        GAccountFields_identity_certIssued_receiver,
        GIdentityFields_certIssued_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certIssued_receiver._();

  factory GAccountFieldsData_identity_certIssued_receiver(
      [void Function(GAccountFieldsData_identity_certIssued_receiverBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_identity_certIssued_receiver>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_receiver.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssuedAggregate
    implements
        Built<GAccountFieldsData_identity_certIssuedAggregate,
            GAccountFieldsData_identity_certIssuedAggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate,
        GIdentityFields_certIssuedAggregate {
  GAccountFieldsData_identity_certIssuedAggregate._();

  factory GAccountFieldsData_identity_certIssuedAggregate(
      [void Function(GAccountFieldsData_identity_certIssuedAggregateBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssuedAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssuedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_identity_certIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_identity_certIssuedAggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssuedAggregate_aggregate
    implements
        Built<GAccountFieldsData_identity_certIssuedAggregate_aggregate,
            GAccountFieldsData_identity_certIssuedAggregate_aggregateBuilder>,
        GAccountFields_identity_certIssuedAggregate_aggregate,
        GIdentityFields_certIssuedAggregate_aggregate {
  GAccountFieldsData_identity_certIssuedAggregate_aggregate._();

  factory GAccountFieldsData_identity_certIssuedAggregate_aggregate(
      [void Function(
              GAccountFieldsData_identity_certIssuedAggregate_aggregateBuilder
                  b)
          updates]) = _$GAccountFieldsData_identity_certIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssuedAggregate_aggregateBuilder b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountFieldsData_identity_certIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived
    implements
        Built<GAccountFieldsData_identity_certReceived,
            GAccountFieldsData_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived,
        GCertFields {
  GAccountFieldsData_identity_certReceived._();

  factory GAccountFieldsData_identity_certReceived(
      [void Function(GAccountFieldsData_identity_certReceivedBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceivedBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFieldsData_identity_certReceived_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFieldsData_identity_certReceived_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountFieldsData_identity_certReceived> get serializer =>
      _$gAccountFieldsDataIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived_issuer
    implements
        Built<GAccountFieldsData_identity_certReceived_issuer,
            GAccountFieldsData_identity_certReceived_issuerBuilder>,
        GAccountFields_identity_certReceived_issuer,
        GIdentityFields_certReceived_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certReceived_issuer._();

  factory GAccountFieldsData_identity_certReceived_issuer(
      [void Function(GAccountFieldsData_identity_certReceived_issuerBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_identity_certReceived_issuer>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived_issuer.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived_receiver
    implements
        Built<GAccountFieldsData_identity_certReceived_receiver,
            GAccountFieldsData_identity_certReceived_receiverBuilder>,
        GAccountFields_identity_certReceived_receiver,
        GIdentityFields_certReceived_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certReceived_receiver._();

  factory GAccountFieldsData_identity_certReceived_receiver(
      [void Function(GAccountFieldsData_identity_certReceived_receiverBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_identity_certReceived_receiver>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived_receiver.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceivedAggregate
    implements
        Built<GAccountFieldsData_identity_certReceivedAggregate,
            GAccountFieldsData_identity_certReceivedAggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate,
        GIdentityFields_certReceivedAggregate {
  GAccountFieldsData_identity_certReceivedAggregate._();

  factory GAccountFieldsData_identity_certReceivedAggregate(
      [void Function(GAccountFieldsData_identity_certReceivedAggregateBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceivedAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceivedAggregateBuilder b) =>
      b..G__typename = 'CertAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_identity_certReceivedAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_identity_certReceivedAggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceivedAggregate_aggregate
    implements
        Built<GAccountFieldsData_identity_certReceivedAggregate_aggregate,
            GAccountFieldsData_identity_certReceivedAggregate_aggregateBuilder>,
        GAccountFields_identity_certReceivedAggregate_aggregate,
        GIdentityFields_certReceivedAggregate_aggregate {
  GAccountFieldsData_identity_certReceivedAggregate_aggregate._();

  factory GAccountFieldsData_identity_certReceivedAggregate_aggregate(
      [void Function(
              GAccountFieldsData_identity_certReceivedAggregate_aggregateBuilder
                  b)
          updates]) = _$GAccountFieldsData_identity_certReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceivedAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'CertAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountFieldsData_identity_certReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceivedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceivedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceivedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_linkedAccount
    implements
        Built<GAccountFieldsData_identity_linkedAccount,
            GAccountFieldsData_identity_linkedAccountBuilder>,
        GAccountFields_identity_linkedAccount,
        GIdentityFields_linkedAccount {
  GAccountFieldsData_identity_linkedAccount._();

  factory GAccountFieldsData_identity_linkedAccount(
      [void Function(GAccountFieldsData_identity_linkedAccountBuilder b)
          updates]) = _$GAccountFieldsData_identity_linkedAccount;

  static void _initializeBuilder(
          GAccountFieldsData_identity_linkedAccountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_identity_linkedAccount> get serializer =>
      _$gAccountFieldsDataIdentityLinkedAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_linkedAccount.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_linkedAccount? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_linkedAccount.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_linkedAccountAggregate
    implements
        Built<GAccountFieldsData_identity_linkedAccountAggregate,
            GAccountFieldsData_identity_linkedAccountAggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate,
        GIdentityFields_linkedAccountAggregate {
  GAccountFieldsData_identity_linkedAccountAggregate._();

  factory GAccountFieldsData_identity_linkedAccountAggregate(
      [void Function(
              GAccountFieldsData_identity_linkedAccountAggregateBuilder b)
          updates]) = _$GAccountFieldsData_identity_linkedAccountAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_linkedAccountAggregateBuilder b) =>
      b..G__typename = 'AccountAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_identity_linkedAccountAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_identity_linkedAccountAggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityLinkedAccountAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_linkedAccountAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_linkedAccountAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_linkedAccountAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_linkedAccountAggregate_aggregate
    implements
        Built<GAccountFieldsData_identity_linkedAccountAggregate_aggregate,
            GAccountFieldsData_identity_linkedAccountAggregate_aggregateBuilder>,
        GAccountFields_identity_linkedAccountAggregate_aggregate,
        GIdentityFields_linkedAccountAggregate_aggregate {
  GAccountFieldsData_identity_linkedAccountAggregate_aggregate._();

  factory GAccountFieldsData_identity_linkedAccountAggregate_aggregate(
          [void Function(
                  GAccountFieldsData_identity_linkedAccountAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_linkedAccountAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_linkedAccountAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'AccountAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountFieldsData_identity_linkedAccountAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityLinkedAccountAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_linkedAccountAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_linkedAccountAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_linkedAccountAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_membershipHistory
    implements
        Built<GAccountFieldsData_identity_membershipHistory,
            GAccountFieldsData_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GAccountFieldsData_identity_membershipHistory._();

  factory GAccountFieldsData_identity_membershipHistory(
      [void Function(GAccountFieldsData_identity_membershipHistoryBuilder b)
          updates]) = _$GAccountFieldsData_identity_membershipHistory;

  static void _initializeBuilder(
          GAccountFieldsData_identity_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  _i2.GEventTypeEnum? get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GAccountFieldsData_identity_membershipHistory>
      get serializer => _$gAccountFieldsDataIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_membershipHistoryAggregate
    implements
        Built<GAccountFieldsData_identity_membershipHistoryAggregate,
            GAccountFieldsData_identity_membershipHistoryAggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate,
        GIdentityFields_membershipHistoryAggregate {
  GAccountFieldsData_identity_membershipHistoryAggregate._();

  factory GAccountFieldsData_identity_membershipHistoryAggregate(
      [void Function(
              GAccountFieldsData_identity_membershipHistoryAggregateBuilder b)
          updates]) = _$GAccountFieldsData_identity_membershipHistoryAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_membershipHistoryAggregateBuilder b) =>
      b..G__typename = 'MembershipEventAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_identity_membershipHistoryAggregate_aggregate?
      get aggregate;
  static Serializer<GAccountFieldsData_identity_membershipHistoryAggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityMembershipHistoryAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_membershipHistoryAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_membershipHistoryAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_membershipHistoryAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_membershipHistoryAggregate_aggregate
    implements
        Built<GAccountFieldsData_identity_membershipHistoryAggregate_aggregate,
            GAccountFieldsData_identity_membershipHistoryAggregate_aggregateBuilder>,
        GAccountFields_identity_membershipHistoryAggregate_aggregate,
        GIdentityFields_membershipHistoryAggregate_aggregate {
  GAccountFieldsData_identity_membershipHistoryAggregate_aggregate._();

  factory GAccountFieldsData_identity_membershipHistoryAggregate_aggregate(
          [void Function(
                  GAccountFieldsData_identity_membershipHistoryAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_membershipHistoryAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_membershipHistoryAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'MembershipEventAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountFieldsData_identity_membershipHistoryAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityMembershipHistoryAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_membershipHistoryAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_membershipHistoryAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_identity_membershipHistoryAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_identity_ownerKeyChange
    implements
        Built<GAccountFieldsData_identity_ownerKeyChange,
            GAccountFieldsData_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange,
        GOwnerKeyChangeFields {
  GAccountFieldsData_identity_ownerKeyChange._();

  factory GAccountFieldsData_identity_ownerKeyChange(
      [void Function(GAccountFieldsData_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountFieldsData_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountFieldsData_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountFieldsData_identity_ownerKeyChange>
      get serializer => _$gAccountFieldsDataIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_ownerKeyChangeAggregate
    implements
        Built<GAccountFieldsData_identity_ownerKeyChangeAggregate,
            GAccountFieldsData_identity_ownerKeyChangeAggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate,
        GIdentityFields_ownerKeyChangeAggregate {
  GAccountFieldsData_identity_ownerKeyChangeAggregate._();

  factory GAccountFieldsData_identity_ownerKeyChangeAggregate(
      [void Function(
              GAccountFieldsData_identity_ownerKeyChangeAggregateBuilder b)
          updates]) = _$GAccountFieldsData_identity_ownerKeyChangeAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_ownerKeyChangeAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_identity_ownerKeyChangeAggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityOwnerKeyChangeAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_ownerKeyChangeAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_ownerKeyChangeAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_ownerKeyChangeAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate
    implements
        Built<GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate,
            GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregateBuilder>,
        GAccountFields_identity_ownerKeyChangeAggregate_aggregate,
        GIdentityFields_ownerKeyChangeAggregate_aggregate {
  GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate._();

  factory GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate(
          [void Function(
                  GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregateBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregateBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<
          GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataIdentityOwnerKeyChangeAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_identity_ownerKeyChangeAggregate_aggregate
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_identity_smith
    implements
        Built<GAccountFieldsData_identity_smith,
            GAccountFieldsData_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountFieldsData_identity_smith._();

  factory GAccountFieldsData_identity_smith(
          [void Function(GAccountFieldsData_identity_smithBuilder b) updates]) =
      _$GAccountFieldsData_identity_smith;

  static void _initializeBuilder(GAccountFieldsData_identity_smithBuilder b) =>
      b..G__typename = 'Smith';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get forged;
  @override
  int get index;
  @override
  int? get lastChanged;
  @override
  int? get lastForged;
  @override
  BuiltList<GAccountFieldsData_identity_smith_smithCertIssued>
      get smithCertIssued;
  @override
  BuiltList<GAccountFieldsData_identity_smith_smithCertReceived>
      get smithCertReceived;
  static Serializer<GAccountFieldsData_identity_smith> get serializer =>
      _$gAccountFieldsDataIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_smith.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_smith_smithCertIssued
    implements
        Built<GAccountFieldsData_identity_smith_smithCertIssued,
            GAccountFieldsData_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued,
        GSmithCertFields {
  GAccountFieldsData_identity_smith_smithCertIssued._();

  factory GAccountFieldsData_identity_smith_smithCertIssued(
      [void Function(GAccountFieldsData_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GAccountFieldsData_identity_smith_smithCertIssued>
      get serializer =>
          _$gAccountFieldsDataIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_smith_smithCertReceived
    implements
        Built<GAccountFieldsData_identity_smith_smithCertReceived,
            GAccountFieldsData_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived,
        GSmithCertFields {
  GAccountFieldsData_identity_smith_smithCertReceived._();

  factory GAccountFieldsData_identity_smith_smithCertReceived(
      [void Function(
              GAccountFieldsData_identity_smith_smithCertReceivedBuilder b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  String? get receiverId;
  @override
  int get createdOn;
  static Serializer<GAccountFieldsData_identity_smith_smithCertReceived>
      get serializer =>
          _$gAccountFieldsDataIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_udHistory
    implements
        Built<GAccountFieldsData_identity_udHistory,
            GAccountFieldsData_identity_udHistoryBuilder>,
        GAccountFields_identity_udHistory,
        GIdentityFields_udHistory {
  GAccountFieldsData_identity_udHistory._();

  factory GAccountFieldsData_identity_udHistory(
      [void Function(GAccountFieldsData_identity_udHistoryBuilder b)
          updates]) = _$GAccountFieldsData_identity_udHistory;

  static void _initializeBuilder(
          GAccountFieldsData_identity_udHistoryBuilder b) =>
      b..G__typename = 'UdHistory';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get amount;
  @override
  _i2.Gtimestamptz get timestamp;
  static Serializer<GAccountFieldsData_identity_udHistory> get serializer =>
      _$gAccountFieldsDataIdentityUdHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_udHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_udHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_udHistory.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity
    implements
        Built<GAccountFieldsData_linkedIdentity,
            GAccountFieldsData_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountFieldsData_linkedIdentity._();

  factory GAccountFieldsData_linkedIdentity(
          [void Function(GAccountFieldsData_linkedIdentityBuilder b) updates]) =
      _$GAccountFieldsData_linkedIdentity;

  static void _initializeBuilder(GAccountFieldsData_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_linkedIdentity> get serializer =>
      _$gAccountFieldsDataLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountFieldsData_removedIdentities
    implements
        Built<GAccountFieldsData_removedIdentities,
            GAccountFieldsData_removedIdentitiesBuilder>,
        GAccountFields_removedIdentities,
        GIdentityBasicFields {
  GAccountFieldsData_removedIdentities._();

  factory GAccountFieldsData_removedIdentities(
      [void Function(GAccountFieldsData_removedIdentitiesBuilder b)
          updates]) = _$GAccountFieldsData_removedIdentities;

  static void _initializeBuilder(
          GAccountFieldsData_removedIdentitiesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  _i2.GIdentityStatusEnum? get status;
  @override
  String get name;
  static Serializer<GAccountFieldsData_removedIdentities> get serializer =>
      _$gAccountFieldsDataRemovedIdentitiesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_removedIdentities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_removedIdentities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_removedIdentities.serializer,
        json,
      );
}

abstract class GAccountFieldsData_removedIdentitiesAggregate
    implements
        Built<GAccountFieldsData_removedIdentitiesAggregate,
            GAccountFieldsData_removedIdentitiesAggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate {
  GAccountFieldsData_removedIdentitiesAggregate._();

  factory GAccountFieldsData_removedIdentitiesAggregate(
      [void Function(GAccountFieldsData_removedIdentitiesAggregateBuilder b)
          updates]) = _$GAccountFieldsData_removedIdentitiesAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_removedIdentitiesAggregateBuilder b) =>
      b..G__typename = 'IdentityAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_removedIdentitiesAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_removedIdentitiesAggregate>
      get serializer =>
          _$gAccountFieldsDataRemovedIdentitiesAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_removedIdentitiesAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_removedIdentitiesAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_removedIdentitiesAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_removedIdentitiesAggregate_aggregate
    implements
        Built<GAccountFieldsData_removedIdentitiesAggregate_aggregate,
            GAccountFieldsData_removedIdentitiesAggregate_aggregateBuilder>,
        GAccountFields_removedIdentitiesAggregate_aggregate {
  GAccountFieldsData_removedIdentitiesAggregate_aggregate._();

  factory GAccountFieldsData_removedIdentitiesAggregate_aggregate(
      [void Function(
              GAccountFieldsData_removedIdentitiesAggregate_aggregateBuilder b)
          updates]) = _$GAccountFieldsData_removedIdentitiesAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_removedIdentitiesAggregate_aggregateBuilder b) =>
      b..G__typename = 'IdentityAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountFieldsData_removedIdentitiesAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataRemovedIdentitiesAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_removedIdentitiesAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_removedIdentitiesAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_removedIdentitiesAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued
    implements
        Built<GAccountFieldsData_transfersIssued,
            GAccountFieldsData_transfersIssuedBuilder>,
        GAccountFields_transfersIssued,
        GTransferFields {
  GAccountFieldsData_transfersIssued._();

  factory GAccountFieldsData_transfersIssued(
      [void Function(GAccountFieldsData_transfersIssuedBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued;

  static void _initializeBuilder(GAccountFieldsData_transfersIssuedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountFieldsData_transfersIssued_to? get to;
  @override
  GAccountFieldsData_transfersIssued_from? get from;
  @override
  GAccountFieldsData_transfersIssued_comment? get comment;
  static Serializer<GAccountFieldsData_transfersIssued> get serializer =>
      _$gAccountFieldsDataTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_to
    implements
        Built<GAccountFieldsData_transfersIssued_to,
            GAccountFieldsData_transfersIssued_toBuilder>,
        GAccountFields_transfersIssued_to,
        GTransferFields_to {
  GAccountFieldsData_transfersIssued_to._();

  factory GAccountFieldsData_transfersIssued_to(
      [void Function(GAccountFieldsData_transfersIssued_toBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_to;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersIssued_to> get serializer =>
      _$gAccountFieldsDataTransfersIssuedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_to.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_from
    implements
        Built<GAccountFieldsData_transfersIssued_from,
            GAccountFieldsData_transfersIssued_fromBuilder>,
        GAccountFields_transfersIssued_from,
        GTransferFields_from {
  GAccountFieldsData_transfersIssued_from._();

  factory GAccountFieldsData_transfersIssued_from(
      [void Function(GAccountFieldsData_transfersIssued_fromBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_from;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersIssued_from> get serializer =>
      _$gAccountFieldsDataTransfersIssuedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_from.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_comment
    implements
        Built<GAccountFieldsData_transfersIssued_comment,
            GAccountFieldsData_transfersIssued_commentBuilder>,
        GAccountFields_transfersIssued_comment,
        GTransferFields_comment {
  GAccountFieldsData_transfersIssued_comment._();

  factory GAccountFieldsData_transfersIssued_comment(
      [void Function(GAccountFieldsData_transfersIssued_commentBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_comment;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountFieldsData_transfersIssued_comment>
      get serializer => _$gAccountFieldsDataTransfersIssuedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_comment.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssuedAggregate
    implements
        Built<GAccountFieldsData_transfersIssuedAggregate,
            GAccountFieldsData_transfersIssuedAggregateBuilder>,
        GAccountFields_transfersIssuedAggregate {
  GAccountFieldsData_transfersIssuedAggregate._();

  factory GAccountFieldsData_transfersIssuedAggregate(
      [void Function(GAccountFieldsData_transfersIssuedAggregateBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssuedAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssuedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_transfersIssuedAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_transfersIssuedAggregate>
      get serializer => _$gAccountFieldsDataTransfersIssuedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssuedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssuedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssuedAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssuedAggregate_aggregate
    implements
        Built<GAccountFieldsData_transfersIssuedAggregate_aggregate,
            GAccountFieldsData_transfersIssuedAggregate_aggregateBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate {
  GAccountFieldsData_transfersIssuedAggregate_aggregate._();

  factory GAccountFieldsData_transfersIssuedAggregate_aggregate(
      [void Function(
              GAccountFieldsData_transfersIssuedAggregate_aggregateBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssuedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssuedAggregate_aggregateBuilder b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_transfersIssuedAggregate_aggregate_sum? get sum;
  @override
  int get count;
  static Serializer<GAccountFieldsData_transfersIssuedAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataTransfersIssuedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssuedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssuedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssuedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssuedAggregate_aggregate_sum
    implements
        Built<GAccountFieldsData_transfersIssuedAggregate_aggregate_sum,
            GAccountFieldsData_transfersIssuedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersIssuedAggregate_aggregate_sum {
  GAccountFieldsData_transfersIssuedAggregate_aggregate_sum._();

  factory GAccountFieldsData_transfersIssuedAggregate_aggregate_sum(
      [void Function(
              GAccountFieldsData_transfersIssuedAggregate_aggregate_sumBuilder
                  b)
          updates]) = _$GAccountFieldsData_transfersIssuedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssuedAggregate_aggregate_sumBuilder b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<GAccountFieldsData_transfersIssuedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountFieldsDataTransfersIssuedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssuedAggregate_aggregate_sum.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssuedAggregate_aggregate_sum? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssuedAggregate_aggregate_sum.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived
    implements
        Built<GAccountFieldsData_transfersReceived,
            GAccountFieldsData_transfersReceivedBuilder>,
        GAccountFields_transfersReceived,
        GTransferFields {
  GAccountFieldsData_transfersReceived._();

  factory GAccountFieldsData_transfersReceived(
      [void Function(GAccountFieldsData_transfersReceivedBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceivedBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GAccountFieldsData_transfersReceived_to? get to;
  @override
  GAccountFieldsData_transfersReceived_from? get from;
  @override
  GAccountFieldsData_transfersReceived_comment? get comment;
  static Serializer<GAccountFieldsData_transfersReceived> get serializer =>
      _$gAccountFieldsDataTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_to
    implements
        Built<GAccountFieldsData_transfersReceived_to,
            GAccountFieldsData_transfersReceived_toBuilder>,
        GAccountFields_transfersReceived_to,
        GTransferFields_to {
  GAccountFieldsData_transfersReceived_to._();

  factory GAccountFieldsData_transfersReceived_to(
      [void Function(GAccountFieldsData_transfersReceived_toBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_to;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersReceived_to> get serializer =>
      _$gAccountFieldsDataTransfersReceivedToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_to.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_from
    implements
        Built<GAccountFieldsData_transfersReceived_from,
            GAccountFieldsData_transfersReceived_fromBuilder>,
        GAccountFields_transfersReceived_from,
        GTransferFields_from {
  GAccountFieldsData_transfersReceived_from._();

  factory GAccountFieldsData_transfersReceived_from(
      [void Function(GAccountFieldsData_transfersReceived_fromBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_from;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersReceived_from> get serializer =>
      _$gAccountFieldsDataTransfersReceivedFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_from.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_comment
    implements
        Built<GAccountFieldsData_transfersReceived_comment,
            GAccountFieldsData_transfersReceived_commentBuilder>,
        GAccountFields_transfersReceived_comment,
        GTransferFields_comment {
  GAccountFieldsData_transfersReceived_comment._();

  factory GAccountFieldsData_transfersReceived_comment(
      [void Function(GAccountFieldsData_transfersReceived_commentBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_comment;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GAccountFieldsData_transfersReceived_comment>
      get serializer => _$gAccountFieldsDataTransfersReceivedCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_comment.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceivedAggregate
    implements
        Built<GAccountFieldsData_transfersReceivedAggregate,
            GAccountFieldsData_transfersReceivedAggregateBuilder>,
        GAccountFields_transfersReceivedAggregate {
  GAccountFieldsData_transfersReceivedAggregate._();

  factory GAccountFieldsData_transfersReceivedAggregate(
      [void Function(GAccountFieldsData_transfersReceivedAggregateBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceivedAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceivedAggregateBuilder b) =>
      b..G__typename = 'TransferAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_transfersReceivedAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_transfersReceivedAggregate>
      get serializer =>
          _$gAccountFieldsDataTransfersReceivedAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceivedAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceivedAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceivedAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceivedAggregate_aggregate
    implements
        Built<GAccountFieldsData_transfersReceivedAggregate_aggregate,
            GAccountFieldsData_transfersReceivedAggregate_aggregateBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate {
  GAccountFieldsData_transfersReceivedAggregate_aggregate._();

  factory GAccountFieldsData_transfersReceivedAggregate_aggregate(
      [void Function(
              GAccountFieldsData_transfersReceivedAggregate_aggregateBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceivedAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceivedAggregate_aggregateBuilder b) =>
      b..G__typename = 'TransferAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_transfersReceivedAggregate_aggregate_sum? get sum;
  @override
  int get count;
  static Serializer<GAccountFieldsData_transfersReceivedAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataTransfersReceivedAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceivedAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceivedAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceivedAggregate_aggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceivedAggregate_aggregate_sum
    implements
        Built<GAccountFieldsData_transfersReceivedAggregate_aggregate_sum,
            GAccountFieldsData_transfersReceivedAggregate_aggregate_sumBuilder>,
        GAccountFields_transfersReceivedAggregate_aggregate_sum {
  GAccountFieldsData_transfersReceivedAggregate_aggregate_sum._();

  factory GAccountFieldsData_transfersReceivedAggregate_aggregate_sum(
      [void Function(
              GAccountFieldsData_transfersReceivedAggregate_aggregate_sumBuilder
                  b)
          updates]) = _$GAccountFieldsData_transfersReceivedAggregate_aggregate_sum;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceivedAggregate_aggregate_sumBuilder
              b) =>
      b..G__typename = 'TransferSumFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int? get amount;
  static Serializer<GAccountFieldsData_transfersReceivedAggregate_aggregate_sum>
      get serializer =>
          _$gAccountFieldsDataTransfersReceivedAggregateAggregateSumSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceivedAggregate_aggregate_sum.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceivedAggregate_aggregate_sum? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceivedAggregate_aggregate_sum.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentity
    implements
        Built<GAccountFieldsData_wasIdentity,
            GAccountFieldsData_wasIdentityBuilder>,
        GAccountFields_wasIdentity,
        GOwnerKeyChangeFields {
  GAccountFieldsData_wasIdentity._();

  factory GAccountFieldsData_wasIdentity(
          [void Function(GAccountFieldsData_wasIdentityBuilder b) updates]) =
      _$GAccountFieldsData_wasIdentity;

  static void _initializeBuilder(GAccountFieldsData_wasIdentityBuilder b) =>
      b..G__typename = 'ChangeOwnerKey';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  int get blockNumber;
  @override
  String? get identityId;
  @override
  String? get nextId;
  @override
  String? get previousId;
  static Serializer<GAccountFieldsData_wasIdentity> get serializer =>
      _$gAccountFieldsDataWasIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentity? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentity.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityAggregate
    implements
        Built<GAccountFieldsData_wasIdentityAggregate,
            GAccountFieldsData_wasIdentityAggregateBuilder>,
        GAccountFields_wasIdentityAggregate {
  GAccountFieldsData_wasIdentityAggregate._();

  factory GAccountFieldsData_wasIdentityAggregate(
      [void Function(GAccountFieldsData_wasIdentityAggregateBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityAggregate;

  static void _initializeBuilder(
          GAccountFieldsData_wasIdentityAggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregate';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountFieldsData_wasIdentityAggregate_aggregate? get aggregate;
  static Serializer<GAccountFieldsData_wasIdentityAggregate> get serializer =>
      _$gAccountFieldsDataWasIdentityAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityAggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityAggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityAggregate.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityAggregate_aggregate
    implements
        Built<GAccountFieldsData_wasIdentityAggregate_aggregate,
            GAccountFieldsData_wasIdentityAggregate_aggregateBuilder>,
        GAccountFields_wasIdentityAggregate_aggregate {
  GAccountFieldsData_wasIdentityAggregate_aggregate._();

  factory GAccountFieldsData_wasIdentityAggregate_aggregate(
      [void Function(GAccountFieldsData_wasIdentityAggregate_aggregateBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityAggregate_aggregate;

  static void _initializeBuilder(
          GAccountFieldsData_wasIdentityAggregate_aggregateBuilder b) =>
      b..G__typename = 'ChangeOwnerKeyAggregateFields';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get count;
  static Serializer<GAccountFieldsData_wasIdentityAggregate_aggregate>
      get serializer =>
          _$gAccountFieldsDataWasIdentityAggregateAggregateSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityAggregate_aggregate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityAggregate_aggregate? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityAggregate_aggregate.serializer,
        json,
      );
}

abstract class GTransferFields {
  String get G__typename;
  int get blockNumber;
  _i2.Gtimestamptz get timestamp;
  int get amount;
  GTransferFields_to? get to;
  GTransferFields_from? get from;
  GTransferFields_comment? get comment;
  Map<String, dynamic> toJson();
}

abstract class GTransferFields_to {
  String get G__typename;
  String get id;
  Map<String, dynamic> toJson();
}

abstract class GTransferFields_from {
  String get G__typename;
  String get id;
  Map<String, dynamic> toJson();
}

abstract class GTransferFields_comment {
  String get G__typename;
  String get remark;
  Map<String, dynamic> toJson();
}

abstract class GTransferFieldsData
    implements
        Built<GTransferFieldsData, GTransferFieldsDataBuilder>,
        GTransferFields {
  GTransferFieldsData._();

  factory GTransferFieldsData(
          [void Function(GTransferFieldsDataBuilder b) updates]) =
      _$GTransferFieldsData;

  static void _initializeBuilder(GTransferFieldsDataBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.Gtimestamptz get timestamp;
  @override
  int get amount;
  @override
  GTransferFieldsData_to? get to;
  @override
  GTransferFieldsData_from? get from;
  @override
  GTransferFieldsData_comment? get comment;
  static Serializer<GTransferFieldsData> get serializer =>
      _$gTransferFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFieldsData.serializer,
        json,
      );
}

abstract class GTransferFieldsData_to
    implements
        Built<GTransferFieldsData_to, GTransferFieldsData_toBuilder>,
        GTransferFields_to {
  GTransferFieldsData_to._();

  factory GTransferFieldsData_to(
          [void Function(GTransferFieldsData_toBuilder b) updates]) =
      _$GTransferFieldsData_to;

  static void _initializeBuilder(GTransferFieldsData_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GTransferFieldsData_to> get serializer =>
      _$gTransferFieldsDataToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFieldsData_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsData_to? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFieldsData_to.serializer,
        json,
      );
}

abstract class GTransferFieldsData_from
    implements
        Built<GTransferFieldsData_from, GTransferFieldsData_fromBuilder>,
        GTransferFields_from {
  GTransferFieldsData_from._();

  factory GTransferFieldsData_from(
          [void Function(GTransferFieldsData_fromBuilder b) updates]) =
      _$GTransferFieldsData_from;

  static void _initializeBuilder(GTransferFieldsData_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GTransferFieldsData_from> get serializer =>
      _$gTransferFieldsDataFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFieldsData_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsData_from? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFieldsData_from.serializer,
        json,
      );
}

abstract class GTransferFieldsData_comment
    implements
        Built<GTransferFieldsData_comment, GTransferFieldsData_commentBuilder>,
        GTransferFields_comment {
  GTransferFieldsData_comment._();

  factory GTransferFieldsData_comment(
          [void Function(GTransferFieldsData_commentBuilder b) updates]) =
      _$GTransferFieldsData_comment;

  static void _initializeBuilder(GTransferFieldsData_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  static Serializer<GTransferFieldsData_comment> get serializer =>
      _$gTransferFieldsDataCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFieldsData_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsData_comment? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFieldsData_comment.serializer,
        json,
      );
}
