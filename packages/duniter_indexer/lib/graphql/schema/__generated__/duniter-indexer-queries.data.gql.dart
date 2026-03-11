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

abstract class GLastBlockData
    implements Built<GLastBlockData, GLastBlockDataBuilder> {
  GLastBlockData._();

  factory GLastBlockData([void Function(GLastBlockDataBuilder b) updates]) =
      _$GLastBlockData;

  static void _initializeBuilder(GLastBlockDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLastBlockData_blocks? get blocks;
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

abstract class GLastBlockData_blocks
    implements Built<GLastBlockData_blocks, GLastBlockData_blocksBuilder> {
  GLastBlockData_blocks._();

  factory GLastBlockData_blocks(
          [void Function(GLastBlockData_blocksBuilder b) updates]) =
      _$GLastBlockData_blocks;

  static void _initializeBuilder(GLastBlockData_blocksBuilder b) =>
      b..G__typename = 'BlocksConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GLastBlockData_blocks_nodes> get nodes;
  static Serializer<GLastBlockData_blocks> get serializer =>
      _$gLastBlockDataBlocksSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastBlockData_blocks.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockData_blocks? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastBlockData_blocks.serializer,
        json,
      );
}

abstract class GLastBlockData_blocks_nodes
    implements
        Built<GLastBlockData_blocks_nodes, GLastBlockData_blocks_nodesBuilder> {
  GLastBlockData_blocks_nodes._();

  factory GLastBlockData_blocks_nodes(
          [void Function(GLastBlockData_blocks_nodesBuilder b) updates]) =
      _$GLastBlockData_blocks_nodes;

  static void _initializeBuilder(GLastBlockData_blocks_nodesBuilder b) =>
      b..G__typename = 'Block';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get height;
  static Serializer<GLastBlockData_blocks_nodes> get serializer =>
      _$gLastBlockDataBlocksNodesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastBlockData_blocks_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockData_blocks_nodes? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastBlockData_blocks_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData
    implements
        Built<GIdentitiesByNameOrPkData, GIdentitiesByNameOrPkDataBuilder> {
  GIdentitiesByNameOrPkData._();

  factory GIdentitiesByNameOrPkData(
          [void Function(GIdentitiesByNameOrPkDataBuilder b) updates]) =
      _$GIdentitiesByNameOrPkData;

  static void _initializeBuilder(GIdentitiesByNameOrPkDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GIdentitiesByNameOrPkData_identities? get identities;
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

abstract class GIdentitiesByNameOrPkData_identities
    implements
        Built<GIdentitiesByNameOrPkData_identities,
            GIdentitiesByNameOrPkData_identitiesBuilder> {
  GIdentitiesByNameOrPkData_identities._();

  factory GIdentitiesByNameOrPkData_identities(
      [void Function(GIdentitiesByNameOrPkData_identitiesBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identities;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identitiesBuilder b) =>
      b..G__typename = 'IdentitiesConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByNameOrPkData_identities_nodes> get nodes;
  static Serializer<GIdentitiesByNameOrPkData_identities> get serializer =>
      _$gIdentitiesByNameOrPkDataIdentitiesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identities.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identities_nodes
    implements
        Built<GIdentitiesByNameOrPkData_identities_nodes,
            GIdentitiesByNameOrPkData_identities_nodesBuilder>,
        GIdentityBasicFields {
  GIdentitiesByNameOrPkData_identities_nodes._();

  factory GIdentitiesByNameOrPkData_identities_nodes(
      [void Function(GIdentitiesByNameOrPkData_identities_nodesBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identities_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identities_nodesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByNameOrPkData_identities_nodes_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GIdentitiesByNameOrPkData_identities_nodes>
      get serializer => _$gIdentitiesByNameOrPkDataIdentitiesNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identities_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identities_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identities_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkData_identities_nodes_account
    implements
        Built<GIdentitiesByNameOrPkData_identities_nodes_account,
            GIdentitiesByNameOrPkData_identities_nodes_accountBuilder>,
        GIdentityBasicFields_account {
  GIdentitiesByNameOrPkData_identities_nodes_account._();

  factory GIdentitiesByNameOrPkData_identities_nodes_account(
      [void Function(
              GIdentitiesByNameOrPkData_identities_nodes_accountBuilder b)
          updates]) = _$GIdentitiesByNameOrPkData_identities_nodes_account;

  static void _initializeBuilder(
          GIdentitiesByNameOrPkData_identities_nodes_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameOrPkData_identities_nodes_account>
      get serializer =>
          _$gIdentitiesByNameOrPkDataIdentitiesNodesAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkData_identities_nodes_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkData_identities_nodes_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkData_identities_nodes_account.serializer,
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
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GIdentitiesByPkData_identities? get identities;
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

abstract class GIdentitiesByPkData_identities
    implements
        Built<GIdentitiesByPkData_identities,
            GIdentitiesByPkData_identitiesBuilder> {
  GIdentitiesByPkData_identities._();

  factory GIdentitiesByPkData_identities(
          [void Function(GIdentitiesByPkData_identitiesBuilder b) updates]) =
      _$GIdentitiesByPkData_identities;

  static void _initializeBuilder(GIdentitiesByPkData_identitiesBuilder b) =>
      b..G__typename = 'IdentitiesConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByPkData_identities_nodes> get nodes;
  static Serializer<GIdentitiesByPkData_identities> get serializer =>
      _$gIdentitiesByPkDataIdentitiesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes,
            GIdentitiesByPkData_identities_nodesBuilder>,
        GIdentityFields {
  GIdentitiesByPkData_identities_nodes._();

  factory GIdentitiesByPkData_identities_nodes(
      [void Function(GIdentitiesByPkData_identities_nodesBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByPkData_identities_nodes_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GIdentitiesByPkData_identities_nodes_certIssued get certIssued;
  @override
  GIdentitiesByPkData_identities_nodes_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GIdentitiesByPkData_identities_nodes_membershipHistory get membershipHistory;
  @override
  GIdentitiesByPkData_identities_nodes_ownerKeyChange get ownerKeyChange;
  @override
  GIdentitiesByPkData_identities_nodes_smith? get smith;
  static Serializer<GIdentitiesByPkData_identities_nodes> get serializer =>
      _$gIdentitiesByPkDataIdentitiesNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_account
    implements
        Built<GIdentitiesByPkData_identities_nodes_account,
            GIdentitiesByPkData_identities_nodes_accountBuilder>,
        GIdentityFields_account {
  GIdentitiesByPkData_identities_nodes_account._();

  factory GIdentitiesByPkData_identities_nodes_account(
      [void Function(GIdentitiesByPkData_identities_nodes_accountBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByPkData_identities_nodes_account>
      get serializer => _$gIdentitiesByPkDataIdentitiesNodesAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_account.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued
    implements
        Built<GIdentitiesByPkData_identities_nodes_certIssued,
            GIdentitiesByPkData_identities_nodes_certIssuedBuilder>,
        GIdentityFields_certIssued {
  GIdentitiesByPkData_identities_nodes_certIssued._();

  factory GIdentitiesByPkData_identities_nodes_certIssued(
      [void Function(GIdentitiesByPkData_identities_nodes_certIssuedBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certIssued;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_certIssued_nodes> get nodes;
  static Serializer<GIdentitiesByPkData_identities_nodes_certIssued>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_certIssued_nodes,
            GIdentitiesByPkData_identities_nodes_certIssued_nodesBuilder>,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GIdentitiesByPkData_identities_nodes_certIssued_nodes._();

  factory GIdentitiesByPkData_identities_nodes_certIssued_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_certIssued_nodesBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certIssued_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssued_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByPkData_identities_nodes_certIssued_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer
    implements
        Built<GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer,
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuerBuilder>,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer._();

  factory GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account,
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_accountBuilder>,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account._();

  factory GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver
    implements
        Built<GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver,
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiverBuilder>,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver._();

  factory GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account,
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_accountBuilder>,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account._();

  factory GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived
    implements
        Built<GIdentitiesByPkData_identities_nodes_certReceived,
            GIdentitiesByPkData_identities_nodes_certReceivedBuilder>,
        GIdentityFields_certReceived {
  GIdentitiesByPkData_identities_nodes_certReceived._();

  factory GIdentitiesByPkData_identities_nodes_certReceived(
      [void Function(GIdentitiesByPkData_identities_nodes_certReceivedBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certReceived;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_certReceived_nodes> get nodes;
  static Serializer<GIdentitiesByPkData_identities_nodes_certReceived>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_certReceived_nodes,
            GIdentitiesByPkData_identities_nodes_certReceived_nodesBuilder>,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GIdentitiesByPkData_identities_nodes_certReceived_nodes._();

  factory GIdentitiesByPkData_identities_nodes_certReceived_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_certReceived_nodesBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certReceived_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceived_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByPkData_identities_nodes_certReceived_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer
    implements
        Built<GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer,
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuerBuilder>,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer._();

  factory GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account,
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_accountBuilder>,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account._();

  factory GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver
    implements
        Built<GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver,
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiverBuilder>,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver._();

  factory GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account,
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_accountBuilder>,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account._();

  factory GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_membershipHistory
    implements
        Built<GIdentitiesByPkData_identities_nodes_membershipHistory,
            GIdentitiesByPkData_identities_nodes_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentitiesByPkData_identities_nodes_membershipHistory._();

  factory GIdentitiesByPkData_identities_nodes_membershipHistory(
      [void Function(
              GIdentitiesByPkData_identities_nodes_membershipHistoryBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_membershipHistory;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_membershipHistory_nodes>
      get nodes;
  static Serializer<GIdentitiesByPkData_identities_nodes_membershipHistory>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_membershipHistory_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_membershipHistory_nodes,
            GIdentitiesByPkData_identities_nodes_membershipHistory_nodesBuilder>,
        GIdentityFields_membershipHistory_nodes {
  GIdentitiesByPkData_identities_nodes_membershipHistory_nodes._();

  factory GIdentitiesByPkData_identities_nodes_membershipHistory_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_membershipHistory_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_membershipHistory_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_membershipHistory_nodesBuilder
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
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_membershipHistory_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_membershipHistory_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_membershipHistory_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_membershipHistory_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_ownerKeyChange
    implements
        Built<GIdentitiesByPkData_identities_nodes_ownerKeyChange,
            GIdentitiesByPkData_identities_nodes_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange {
  GIdentitiesByPkData_identities_nodes_ownerKeyChange._();

  factory GIdentitiesByPkData_identities_nodes_ownerKeyChange(
      [void Function(
              GIdentitiesByPkData_identities_nodes_ownerKeyChangeBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_ownerKeyChange;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes>
      get nodes;
  static Serializer<GIdentitiesByPkData_identities_nodes_ownerKeyChange>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes,
            GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodesBuilder>,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes._();

  factory GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodesBuilder b) =>
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
  static Serializer<GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_ownerKeyChange_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_smith
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith,
            GIdentitiesByPkData_identities_nodes_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentitiesByPkData_identities_nodes_smith._();

  factory GIdentitiesByPkData_identities_nodes_smith(
      [void Function(GIdentitiesByPkData_identities_nodes_smithBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_smith;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smithBuilder b) =>
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
  GIdentitiesByPkData_identities_nodes_smith_smithCertIssued
      get smithCertIssued;
  @override
  GIdentitiesByPkData_identities_nodes_smith_smithCertReceived
      get smithCertReceived;
  static Serializer<GIdentitiesByPkData_identities_nodes_smith>
      get serializer => _$gIdentitiesByPkDataIdentitiesNodesSmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_smith.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertIssued
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith_smithCertIssued,
            GIdentitiesByPkData_identities_nodes_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued {
  GIdentitiesByPkData_identities_nodes_smith_smithCertIssued._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertIssued(
      [void Function(
              GIdentitiesByPkData_identities_nodes_smith_smithCertIssuedBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes>
      get nodes;
  static Serializer<GIdentitiesByPkData_identities_nodes_smith_smithCertIssued>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes,
            GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodesBuilder>,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodesBuilder
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
          GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertIssued_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertReceived
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith_smithCertReceived,
            GIdentitiesByPkData_identities_nodes_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GIdentitiesByPkData_identities_nodes_smith_smithCertReceived._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertReceived(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes>
      get nodes;
  static Serializer<
          GIdentitiesByPkData_identities_nodes_smith_smithCertReceived>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes,
            GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodesBuilder>,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodesBuilder
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
          GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertReceived_nodes
                .serializer,
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
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GIdentitiesByNameData_identities? get identities;
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

abstract class GIdentitiesByNameData_identities
    implements
        Built<GIdentitiesByNameData_identities,
            GIdentitiesByNameData_identitiesBuilder> {
  GIdentitiesByNameData_identities._();

  factory GIdentitiesByNameData_identities(
          [void Function(GIdentitiesByNameData_identitiesBuilder b) updates]) =
      _$GIdentitiesByNameData_identities;

  static void _initializeBuilder(GIdentitiesByNameData_identitiesBuilder b) =>
      b..G__typename = 'IdentitiesConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GIdentitiesByNameData_identities_nodes> get nodes;
  static Serializer<GIdentitiesByNameData_identities> get serializer =>
      _$gIdentitiesByNameDataIdentitiesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes,
            GIdentitiesByNameData_identities_nodesBuilder>,
        GIdentityFields {
  GIdentitiesByNameData_identities_nodes._();

  factory GIdentitiesByNameData_identities_nodes(
      [void Function(GIdentitiesByNameData_identities_nodesBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodesBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GIdentitiesByNameData_identities_nodes_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GIdentitiesByNameData_identities_nodes_certIssued get certIssued;
  @override
  GIdentitiesByNameData_identities_nodes_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GIdentitiesByNameData_identities_nodes_membershipHistory
      get membershipHistory;
  @override
  GIdentitiesByNameData_identities_nodes_ownerKeyChange get ownerKeyChange;
  @override
  GIdentitiesByNameData_identities_nodes_smith? get smith;
  static Serializer<GIdentitiesByNameData_identities_nodes> get serializer =>
      _$gIdentitiesByNameDataIdentitiesNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_account
    implements
        Built<GIdentitiesByNameData_identities_nodes_account,
            GIdentitiesByNameData_identities_nodes_accountBuilder>,
        GIdentityFields_account {
  GIdentitiesByNameData_identities_nodes_account._();

  factory GIdentitiesByNameData_identities_nodes_account(
      [void Function(GIdentitiesByNameData_identities_nodes_accountBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentitiesByNameData_identities_nodes_account>
      get serializer => _$gIdentitiesByNameDataIdentitiesNodesAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_account.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued
    implements
        Built<GIdentitiesByNameData_identities_nodes_certIssued,
            GIdentitiesByNameData_identities_nodes_certIssuedBuilder>,
        GIdentityFields_certIssued {
  GIdentitiesByNameData_identities_nodes_certIssued._();

  factory GIdentitiesByNameData_identities_nodes_certIssued(
      [void Function(GIdentitiesByNameData_identities_nodes_certIssuedBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certIssued;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_certIssued_nodes> get nodes;
  static Serializer<GIdentitiesByNameData_identities_nodes_certIssued>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_certIssued_nodes,
            GIdentitiesByNameData_identities_nodes_certIssued_nodesBuilder>,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GIdentitiesByNameData_identities_nodes_certIssued_nodes._();

  factory GIdentitiesByNameData_identities_nodes_certIssued_nodes(
      [void Function(
              GIdentitiesByNameData_identities_nodes_certIssued_nodesBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certIssued_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssued_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameData_identities_nodes_certIssued_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer
    implements
        Built<GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer,
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuerBuilder>,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer._();

  factory GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account,
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_accountBuilder>,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account._();

  factory GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver
    implements
        Built<GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver,
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiverBuilder>,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver._();

  factory GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account,
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_accountBuilder>,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account._();

  factory GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certIssued_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived
    implements
        Built<GIdentitiesByNameData_identities_nodes_certReceived,
            GIdentitiesByNameData_identities_nodes_certReceivedBuilder>,
        GIdentityFields_certReceived {
  GIdentitiesByNameData_identities_nodes_certReceived._();

  factory GIdentitiesByNameData_identities_nodes_certReceived(
      [void Function(
              GIdentitiesByNameData_identities_nodes_certReceivedBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certReceived;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_certReceived_nodes>
      get nodes;
  static Serializer<GIdentitiesByNameData_identities_nodes_certReceived>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_certReceived_nodes,
            GIdentitiesByNameData_identities_nodes_certReceived_nodesBuilder>,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GIdentitiesByNameData_identities_nodes_certReceived_nodes._();

  factory GIdentitiesByNameData_identities_nodes_certReceived_nodes(
      [void Function(
              GIdentitiesByNameData_identities_nodes_certReceived_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certReceived_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceived_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentitiesByNameData_identities_nodes_certReceived_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer
    implements
        Built<GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer,
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuerBuilder>,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer._();

  factory GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account,
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_accountBuilder>,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account._();

  factory GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver,
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiverBuilder>,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver._();

  factory GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account,
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_accountBuilder>,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account._();

  factory GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certReceived_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_membershipHistory
    implements
        Built<GIdentitiesByNameData_identities_nodes_membershipHistory,
            GIdentitiesByNameData_identities_nodes_membershipHistoryBuilder>,
        GIdentityFields_membershipHistory {
  GIdentitiesByNameData_identities_nodes_membershipHistory._();

  factory GIdentitiesByNameData_identities_nodes_membershipHistory(
      [void Function(
              GIdentitiesByNameData_identities_nodes_membershipHistoryBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_membershipHistory;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_membershipHistoryBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_membershipHistory_nodes>
      get nodes;
  static Serializer<GIdentitiesByNameData_identities_nodes_membershipHistory>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_membershipHistory.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_membershipHistory_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_membershipHistory_nodes,
            GIdentitiesByNameData_identities_nodes_membershipHistory_nodesBuilder>,
        GIdentityFields_membershipHistory_nodes {
  GIdentitiesByNameData_identities_nodes_membershipHistory_nodes._();

  factory GIdentitiesByNameData_identities_nodes_membershipHistory_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_membershipHistory_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_membershipHistory_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_membershipHistory_nodesBuilder
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
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_membershipHistory_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_membershipHistory_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_membershipHistory_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_membershipHistory_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_ownerKeyChange
    implements
        Built<GIdentitiesByNameData_identities_nodes_ownerKeyChange,
            GIdentitiesByNameData_identities_nodes_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange {
  GIdentitiesByNameData_identities_nodes_ownerKeyChange._();

  factory GIdentitiesByNameData_identities_nodes_ownerKeyChange(
      [void Function(
              GIdentitiesByNameData_identities_nodes_ownerKeyChangeBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_ownerKeyChange;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes>
      get nodes;
  static Serializer<GIdentitiesByNameData_identities_nodes_ownerKeyChange>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_ownerKeyChange.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes,
            GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodesBuilder>,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes._();

  factory GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes(
      [void Function(
              GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodesBuilder
              b) =>
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
  static Serializer<GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_ownerKeyChange_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_smith
    implements
        Built<GIdentitiesByNameData_identities_nodes_smith,
            GIdentitiesByNameData_identities_nodes_smithBuilder>,
        GIdentityFields_smith,
        GSmithFields {
  GIdentitiesByNameData_identities_nodes_smith._();

  factory GIdentitiesByNameData_identities_nodes_smith(
      [void Function(GIdentitiesByNameData_identities_nodes_smithBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_smith;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smithBuilder b) =>
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
  GIdentitiesByNameData_identities_nodes_smith_smithCertIssued
      get smithCertIssued;
  @override
  GIdentitiesByNameData_identities_nodes_smith_smithCertReceived
      get smithCertReceived;
  static Serializer<GIdentitiesByNameData_identities_nodes_smith>
      get serializer => _$gIdentitiesByNameDataIdentitiesNodesSmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_smith.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertIssued
    implements
        Built<GIdentitiesByNameData_identities_nodes_smith_smithCertIssued,
            GIdentitiesByNameData_identities_nodes_smith_smithCertIssuedBuilder>,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued {
  GIdentitiesByNameData_identities_nodes_smith_smithCertIssued._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertIssued(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertIssuedBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes>
      get nodes;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_smith_smithCertIssued>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertIssued.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes,
            GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodesBuilder>,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertIssued_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertReceived
    implements
        Built<GIdentitiesByNameData_identities_nodes_smith_smithCertReceived,
            GIdentitiesByNameData_identities_nodes_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GIdentitiesByNameData_identities_nodes_smith_smithCertReceived._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertReceived(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<
          GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes>
      get nodes;
  static Serializer<
          GIdentitiesByNameData_identities_nodes_smith_smithCertReceived>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertReceived
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertReceived?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertReceived
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes,
            GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodesBuilder>,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertReceived_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData
    implements Built<GAccountByPkData, GAccountByPkDataBuilder> {
  GAccountByPkData._();

  factory GAccountByPkData([void Function(GAccountByPkDataBuilder b) updates]) =
      _$GAccountByPkData;

  static void _initializeBuilder(GAccountByPkDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountByPkData_accounts? get accounts;
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

abstract class GAccountByPkData_accounts
    implements
        Built<GAccountByPkData_accounts, GAccountByPkData_accountsBuilder> {
  GAccountByPkData_accounts._();

  factory GAccountByPkData_accounts(
          [void Function(GAccountByPkData_accountsBuilder b) updates]) =
      _$GAccountByPkData_accounts;

  static void _initializeBuilder(GAccountByPkData_accountsBuilder b) =>
      b..G__typename = 'AccountsConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountByPkData_accounts_nodes> get nodes;
  static Serializer<GAccountByPkData_accounts> get serializer =>
      _$gAccountByPkDataAccountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes
    implements
        Built<GAccountByPkData_accounts_nodes,
            GAccountByPkData_accounts_nodesBuilder>,
        GAccountFields {
  GAccountByPkData_accounts_nodes._();

  factory GAccountByPkData_accounts_nodes(
          [void Function(GAccountByPkData_accounts_nodesBuilder b) updates]) =
      _$GAccountByPkData_accounts_nodes;

  static void _initializeBuilder(GAccountByPkData_accounts_nodesBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  bool get isActive;
  @override
  GAccountByPkData_accounts_nodes_transfersIssued get transfersIssued;
  @override
  GAccountByPkData_accounts_nodes_transfersReceived get transfersReceived;
  @override
  GAccountByPkData_accounts_nodes_wasIdentityPrev get wasIdentityPrev;
  @override
  GAccountByPkData_accounts_nodes_wasIdentityNext get wasIdentityNext;
  @override
  GAccountByPkData_accounts_nodes_identity? get identity;
  static Serializer<GAccountByPkData_accounts_nodes> get serializer =>
      _$gAccountByPkDataAccountsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued,
            GAccountByPkData_accounts_nodes_transfersIssuedBuilder>,
        GAccountFields_transfersIssued {
  GAccountByPkData_accounts_nodes_transfersIssued._();

  factory GAccountByPkData_accounts_nodes_transfersIssued(
      [void Function(GAccountByPkData_accounts_nodes_transfersIssuedBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersIssued;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssuedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountByPkData_accounts_nodes_transfersIssued_pageInfo get pageInfo;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_transfersIssued_nodes> get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_transfersIssued>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued_pageInfo
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued_pageInfo,
            GAccountByPkData_accounts_nodes_transfersIssued_pageInfoBuilder>,
        GAccountFields_transfersIssued_pageInfo {
  GAccountByPkData_accounts_nodes_transfersIssued_pageInfo._();

  factory GAccountByPkData_accounts_nodes_transfersIssued_pageInfo(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersIssued_pageInfoBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersIssued_pageInfo;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssued_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountByPkData_accounts_nodes_transfersIssued_pageInfo>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_pageInfo.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued_nodes,
            GAccountByPkData_accounts_nodes_transfersIssued_nodesBuilder>,
        GAccountFields_transfersIssued_nodes,
        GTransferFields {
  GAccountByPkData_accounts_nodes_transfersIssued_nodes._();

  factory GAccountByPkData_accounts_nodes_transfersIssued_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersIssued_nodesBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersIssued_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssued_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_to? get to;
  @override
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_from? get from;
  @override
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment? get comment;
  static Serializer<GAccountByPkData_accounts_nodes_transfersIssued_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued_nodes_to
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued_nodes_to,
            GAccountByPkData_accounts_nodes_transfersIssued_nodes_toBuilder>,
        GAccountFields_transfersIssued_nodes_to,
        GTransferFields_to {
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_to._();

  factory GAccountByPkData_accounts_nodes_transfersIssued_nodes_to(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersIssued_nodes_toBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersIssued_nodes_to;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssued_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accounts_nodes_transfersIssued_nodes_to>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes_to.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued_nodes_from
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued_nodes_from,
            GAccountByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder>,
        GAccountFields_transfersIssued_nodes_from,
        GTransferFields_from {
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_from._();

  factory GAccountByPkData_accounts_nodes_transfersIssued_nodes_from(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersIssued_nodes_from;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accounts_nodes_transfersIssued_nodes_from>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes_from.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment
    implements
        Built<GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment,
            GAccountByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder>,
        GAccountFields_transfersIssued_nodes_comment,
        GTransferFields_comment {
  GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment._();

  factory GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment(
          [void Function(
                  GAccountByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersIssuedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_transfersIssued_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived,
            GAccountByPkData_accounts_nodes_transfersReceivedBuilder>,
        GAccountFields_transfersReceived {
  GAccountByPkData_accounts_nodes_transfersReceived._();

  factory GAccountByPkData_accounts_nodes_transfersReceived(
      [void Function(GAccountByPkData_accounts_nodes_transfersReceivedBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersReceived;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceivedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountByPkData_accounts_nodes_transfersReceived_pageInfo get pageInfo;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_transfersReceived_nodes> get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_transfersReceived>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived_pageInfo
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived_pageInfo,
            GAccountByPkData_accounts_nodes_transfersReceived_pageInfoBuilder>,
        GAccountFields_transfersReceived_pageInfo {
  GAccountByPkData_accounts_nodes_transfersReceived_pageInfo._();

  factory GAccountByPkData_accounts_nodes_transfersReceived_pageInfo(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersReceived_pageInfoBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersReceived_pageInfo;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceived_pageInfoBuilder
              b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountByPkData_accounts_nodes_transfersReceived_pageInfo>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_pageInfo.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived_nodes,
            GAccountByPkData_accounts_nodes_transfersReceived_nodesBuilder>,
        GAccountFields_transfersReceived_nodes,
        GTransferFields {
  GAccountByPkData_accounts_nodes_transfersReceived_nodes._();

  factory GAccountByPkData_accounts_nodes_transfersReceived_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersReceived_nodesBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersReceived_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceived_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_to? get to;
  @override
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_from? get from;
  @override
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment? get comment;
  static Serializer<GAccountByPkData_accounts_nodes_transfersReceived_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived_nodes_to
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived_nodes_to,
            GAccountByPkData_accounts_nodes_transfersReceived_nodes_toBuilder>,
        GAccountFields_transfersReceived_nodes_to,
        GTransferFields_to {
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_to._();

  factory GAccountByPkData_accounts_nodes_transfersReceived_nodes_to(
      [void Function(
              GAccountByPkData_accounts_nodes_transfersReceived_nodes_toBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_transfersReceived_nodes_to;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceived_nodes_toBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountByPkData_accounts_nodes_transfersReceived_nodes_to>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes_to.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived_nodes_from
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived_nodes_from,
            GAccountByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder>,
        GAccountFields_transfersReceived_nodes_from,
        GTransferFields_from {
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_from._();

  factory GAccountByPkData_accounts_nodes_transfersReceived_nodes_from(
          [void Function(
                  GAccountByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_transfersReceived_nodes_from;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountByPkData_accounts_nodes_transfersReceived_nodes_from>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes_from.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment
    implements
        Built<GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment,
            GAccountByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder>,
        GAccountFields_transfersReceived_nodes_comment,
        GTransferFields_comment {
  GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment._();

  factory GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment(
          [void Function(
                  GAccountByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment>
      get serializer =>
          _$gAccountByPkDataAccountsNodesTransfersReceivedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_transfersReceived_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_wasIdentityPrev
    implements
        Built<GAccountByPkData_accounts_nodes_wasIdentityPrev,
            GAccountByPkData_accounts_nodes_wasIdentityPrevBuilder>,
        GAccountFields_wasIdentityPrev {
  GAccountByPkData_accounts_nodes_wasIdentityPrev._();

  factory GAccountByPkData_accounts_nodes_wasIdentityPrev(
      [void Function(GAccountByPkData_accounts_nodes_wasIdentityPrevBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_wasIdentityPrev;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_wasIdentityPrevBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes> get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_wasIdentityPrev>
      get serializer =>
          _$gAccountByPkDataAccountsNodesWasIdentityPrevSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityPrev.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_wasIdentityPrev? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityPrev.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes,
            GAccountByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder>,
        GAccountFields_wasIdentityPrev_nodes,
        GOwnerKeyChangeFields {
  GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes._();

  factory GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder b) =>
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
  static Serializer<GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesWasIdentityPrevNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityPrev_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_wasIdentityNext
    implements
        Built<GAccountByPkData_accounts_nodes_wasIdentityNext,
            GAccountByPkData_accounts_nodes_wasIdentityNextBuilder>,
        GAccountFields_wasIdentityNext {
  GAccountByPkData_accounts_nodes_wasIdentityNext._();

  factory GAccountByPkData_accounts_nodes_wasIdentityNext(
      [void Function(GAccountByPkData_accounts_nodes_wasIdentityNextBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_wasIdentityNext;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_wasIdentityNextBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_wasIdentityNext_nodes> get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_wasIdentityNext>
      get serializer =>
          _$gAccountByPkDataAccountsNodesWasIdentityNextSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityNext.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_wasIdentityNext? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityNext.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_wasIdentityNext_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_wasIdentityNext_nodes,
            GAccountByPkData_accounts_nodes_wasIdentityNext_nodesBuilder>,
        GAccountFields_wasIdentityNext_nodes,
        GOwnerKeyChangeFields {
  GAccountByPkData_accounts_nodes_wasIdentityNext_nodes._();

  factory GAccountByPkData_accounts_nodes_wasIdentityNext_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_wasIdentityNext_nodesBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_wasIdentityNext_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_wasIdentityNext_nodesBuilder b) =>
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
  static Serializer<GAccountByPkData_accounts_nodes_wasIdentityNext_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesWasIdentityNextNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityNext_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_wasIdentityNext_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_wasIdentityNext_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity
    implements
        Built<GAccountByPkData_accounts_nodes_identity,
            GAccountByPkData_accounts_nodes_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GAccountByPkData_accounts_nodes_identity._();

  factory GAccountByPkData_accounts_nodes_identity(
      [void Function(GAccountByPkData_accounts_nodes_identityBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountByPkData_accounts_nodes_identity_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GAccountByPkData_accounts_nodes_identity_certIssued get certIssued;
  @override
  GAccountByPkData_accounts_nodes_identity_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GAccountByPkData_accounts_nodes_identity_membershipHistory
      get membershipHistory;
  @override
  GAccountByPkData_accounts_nodes_identity_ownerKeyChange get ownerKeyChange;
  @override
  GAccountByPkData_accounts_nodes_identity_smith? get smith;
  static Serializer<GAccountByPkData_accounts_nodes_identity> get serializer =>
      _$gAccountByPkDataAccountsNodesIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_account
    implements
        Built<GAccountByPkData_accounts_nodes_identity_account,
            GAccountByPkData_accounts_nodes_identity_accountBuilder>,
        GAccountFields_identity_account,
        GIdentityFields_account {
  GAccountByPkData_accounts_nodes_identity_account._();

  factory GAccountByPkData_accounts_nodes_identity_account(
      [void Function(GAccountByPkData_accounts_nodes_identity_accountBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountByPkData_accounts_nodes_identity_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_account.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued
    implements
        Built<GAccountByPkData_accounts_nodes_identity_certIssued,
            GAccountByPkData_accounts_nodes_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued {
  GAccountByPkData_accounts_nodes_identity_certIssued._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_certIssuedBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_certIssued;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_identity_certIssued_nodes>
      get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_identity_certIssued>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_identity_certIssued_nodes,
            GAccountByPkData_accounts_nodes_identity_certIssued_nodesBuilder>,
        GAccountFields_identity_certIssued_nodes,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_certIssued_nodesBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_certIssued_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssued_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountByPkData_accounts_nodes_identity_certIssued_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer
    implements
        Built<GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer,
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account,
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer_account,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver,
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account,
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver_account,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account._();

  factory GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived
    implements
        Built<GAccountByPkData_accounts_nodes_identity_certReceived,
            GAccountByPkData_accounts_nodes_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived {
  GAccountByPkData_accounts_nodes_identity_certReceived._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_certReceivedBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_certReceived;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_identity_certReceived_nodes>
      get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_identity_certReceived>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_identity_certReceived_nodes,
            GAccountByPkData_accounts_nodes_identity_certReceived_nodesBuilder>,
        GAccountFields_identity_certReceived_nodes,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived_nodes(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_certReceived_nodesBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_certReceived_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceived_nodesBuilder
              b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer?
      get issuer;
  @override
  String? get receiverId;
  @override
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountByPkData_accounts_nodes_identity_certReceived_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer,
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account,
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer_account,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver,
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account,
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver_account,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account._();

  factory GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_membershipHistory
    implements
        Built<GAccountByPkData_accounts_nodes_identity_membershipHistory,
            GAccountByPkData_accounts_nodes_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GAccountByPkData_accounts_nodes_identity_membershipHistory._();

  factory GAccountByPkData_accounts_nodes_identity_membershipHistory(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_membershipHistoryBuilder
                  b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_membershipHistory;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_membershipHistoryBuilder
              b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes>
      get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_identity_membershipHistory>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes,
            GAccountByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder>,
        GAccountFields_identity_membershipHistory_nodes,
        GIdentityFields_membershipHistory_nodes {
  GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder
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
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_membershipHistory_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_ownerKeyChange
    implements
        Built<GAccountByPkData_accounts_nodes_identity_ownerKeyChange,
            GAccountByPkData_accounts_nodes_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange {
  GAccountByPkData_accounts_nodes_identity_ownerKeyChange._();

  factory GAccountByPkData_accounts_nodes_identity_ownerKeyChange(
      [void Function(
              GAccountByPkData_accounts_nodes_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes>
      get nodes;
  static Serializer<GAccountByPkData_accounts_nodes_identity_ownerKeyChange>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes
    implements
        Built<GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes,
            GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder>,
        GAccountFields_identity_ownerKeyChange_nodes,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder
              b) =>
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
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentityOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_ownerKeyChange_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_smith
    implements
        Built<GAccountByPkData_accounts_nodes_identity_smith,
            GAccountByPkData_accounts_nodes_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountByPkData_accounts_nodes_identity_smith._();

  factory GAccountByPkData_accounts_nodes_identity_smith(
      [void Function(GAccountByPkData_accounts_nodes_identity_smithBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_identity_smith;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_smithBuilder b) =>
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
  GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued
      get smithCertIssued;
  @override
  GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived
      get smithCertReceived;
  static Serializer<GAccountByPkData_accounts_nodes_identity_smith>
      get serializer => _$gAccountByPkDataAccountsNodesIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_identity_smith.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued
    implements
        Built<GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued,
            GAccountByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued {
  GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued._();

  factory GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes>
      get nodes;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes,
            GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder>,
        GAccountFields_identity_smith_smithCertIssued_nodes,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder
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
          GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentitySmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived
    implements
        Built<GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived,
            GAccountByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived._();

  factory GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes>
      get nodes;
  static Serializer<
          GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes,
            GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder>,
        GAccountFields_identity_smith_smithCertReceived_nodes,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes._();

  factory GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder
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
          GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesIdentitySmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
                .serializer,
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
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsByPkData_accounts? get accounts;
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

abstract class GAccountsByPkData_accounts
    implements
        Built<GAccountsByPkData_accounts, GAccountsByPkData_accountsBuilder> {
  GAccountsByPkData_accounts._();

  factory GAccountsByPkData_accounts(
          [void Function(GAccountsByPkData_accountsBuilder b) updates]) =
      _$GAccountsByPkData_accounts;

  static void _initializeBuilder(GAccountsByPkData_accountsBuilder b) =>
      b..G__typename = 'AccountsConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsByPkData_accounts_nodes> get nodes;
  static Serializer<GAccountsByPkData_accounts> get serializer =>
      _$gAccountsByPkDataAccountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes,
            GAccountsByPkData_accounts_nodesBuilder>,
        GAccountFields {
  GAccountsByPkData_accounts_nodes._();

  factory GAccountsByPkData_accounts_nodes(
          [void Function(GAccountsByPkData_accounts_nodesBuilder b) updates]) =
      _$GAccountsByPkData_accounts_nodes;

  static void _initializeBuilder(GAccountsByPkData_accounts_nodesBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  bool get isActive;
  @override
  GAccountsByPkData_accounts_nodes_transfersIssued get transfersIssued;
  @override
  GAccountsByPkData_accounts_nodes_transfersReceived get transfersReceived;
  @override
  GAccountsByPkData_accounts_nodes_wasIdentityPrev get wasIdentityPrev;
  @override
  GAccountsByPkData_accounts_nodes_wasIdentityNext get wasIdentityNext;
  @override
  GAccountsByPkData_accounts_nodes_identity? get identity;
  static Serializer<GAccountsByPkData_accounts_nodes> get serializer =>
      _$gAccountsByPkDataAccountsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued,
            GAccountsByPkData_accounts_nodes_transfersIssuedBuilder>,
        GAccountFields_transfersIssued {
  GAccountsByPkData_accounts_nodes_transfersIssued._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued(
      [void Function(GAccountsByPkData_accounts_nodes_transfersIssuedBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersIssued;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssuedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo get pageInfo;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_transfersIssued_nodes> get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersIssued>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo,
            GAccountsByPkData_accounts_nodes_transfersIssued_pageInfoBuilder>,
        GAccountFields_transfersIssued_pageInfo {
  GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersIssued_pageInfoBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssued_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_pageInfo.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued_nodes,
            GAccountsByPkData_accounts_nodes_transfersIssued_nodesBuilder>,
        GAccountFields_transfersIssued_nodes,
        GTransferFields {
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued_nodes(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersIssued_nodesBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersIssued_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssued_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to? get to;
  @override
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from? get from;
  @override
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment? get comment;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersIssued_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to,
            GAccountsByPkData_accounts_nodes_transfersIssued_nodes_toBuilder>,
        GAccountFields_transfersIssued_nodes_to,
        GTransferFields_to {
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersIssued_nodes_toBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssued_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes_to.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from,
            GAccountsByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder>,
        GAccountFields_transfersIssued_nodes_from,
        GTransferFields_from {
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssued_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes_from.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment,
            GAccountsByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder>,
        GAccountFields_transfersIssued_nodes_comment,
        GTransferFields_comment {
  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment._();

  factory GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment(
          [void Function(
                  GAccountsByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersIssued_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersIssuedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_transfersIssued_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived,
            GAccountsByPkData_accounts_nodes_transfersReceivedBuilder>,
        GAccountFields_transfersReceived {
  GAccountsByPkData_accounts_nodes_transfersReceived._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersReceivedBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersReceived;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceivedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo get pageInfo;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_transfersReceived_nodes> get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersReceived>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo,
            GAccountsByPkData_accounts_nodes_transfersReceived_pageInfoBuilder>,
        GAccountFields_transfersReceived_pageInfo {
  GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersReceived_pageInfoBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceived_pageInfoBuilder
              b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_pageInfo.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived_nodes,
            GAccountsByPkData_accounts_nodes_transfersReceived_nodesBuilder>,
        GAccountFields_transfersReceived_nodes,
        GTransferFields {
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived_nodes(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersReceived_nodesBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersReceived_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceived_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to? get to;
  @override
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from? get from;
  @override
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment? get comment;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersReceived_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to,
            GAccountsByPkData_accounts_nodes_transfersReceived_nodes_toBuilder>,
        GAccountFields_transfersReceived_nodes_to,
        GTransferFields_to {
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to(
      [void Function(
              GAccountsByPkData_accounts_nodes_transfersReceived_nodes_toBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceived_nodes_toBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes_to.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from,
            GAccountsByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder>,
        GAccountFields_transfersReceived_nodes_from,
        GTransferFields_from {
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from(
          [void Function(
                  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceived_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_transfersReceived_nodes_from
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment
    implements
        Built<GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment,
            GAccountsByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder>,
        GAccountFields_transfersReceived_nodes_comment,
        GTransferFields_comment {
  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment._();

  factory GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment(
          [void Function(
                  GAccountsByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_transfersReceived_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesTransfersReceivedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_transfersReceived_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_wasIdentityPrev
    implements
        Built<GAccountsByPkData_accounts_nodes_wasIdentityPrev,
            GAccountsByPkData_accounts_nodes_wasIdentityPrevBuilder>,
        GAccountFields_wasIdentityPrev {
  GAccountsByPkData_accounts_nodes_wasIdentityPrev._();

  factory GAccountsByPkData_accounts_nodes_wasIdentityPrev(
      [void Function(GAccountsByPkData_accounts_nodes_wasIdentityPrevBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_wasIdentityPrev;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_wasIdentityPrevBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes> get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_wasIdentityPrev>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesWasIdentityPrevSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityPrev.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_wasIdentityPrev? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityPrev.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes,
            GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder>,
        GAccountFields_wasIdentityPrev_nodes,
        GOwnerKeyChangeFields {
  GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes._();

  factory GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes(
      [void Function(
              GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodesBuilder b) =>
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
  static Serializer<GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesWasIdentityPrevNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityPrev_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_wasIdentityNext
    implements
        Built<GAccountsByPkData_accounts_nodes_wasIdentityNext,
            GAccountsByPkData_accounts_nodes_wasIdentityNextBuilder>,
        GAccountFields_wasIdentityNext {
  GAccountsByPkData_accounts_nodes_wasIdentityNext._();

  factory GAccountsByPkData_accounts_nodes_wasIdentityNext(
      [void Function(GAccountsByPkData_accounts_nodes_wasIdentityNextBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_wasIdentityNext;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_wasIdentityNextBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes> get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_wasIdentityNext>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesWasIdentityNextSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityNext.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_wasIdentityNext? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityNext.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes,
            GAccountsByPkData_accounts_nodes_wasIdentityNext_nodesBuilder>,
        GAccountFields_wasIdentityNext_nodes,
        GOwnerKeyChangeFields {
  GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes._();

  factory GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes(
      [void Function(
              GAccountsByPkData_accounts_nodes_wasIdentityNext_nodesBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_wasIdentityNext_nodesBuilder b) =>
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
  static Serializer<GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesWasIdentityNextNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_wasIdentityNext_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity
    implements
        Built<GAccountsByPkData_accounts_nodes_identity,
            GAccountsByPkData_accounts_nodes_identityBuilder>,
        GAccountFields_identity,
        GIdentityFields {
  GAccountsByPkData_accounts_nodes_identity._();

  factory GAccountsByPkData_accounts_nodes_identity(
      [void Function(GAccountsByPkData_accounts_nodes_identityBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GAccountsByPkData_accounts_nodes_identity_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certIssued get certIssued;
  @override
  GAccountsByPkData_accounts_nodes_identity_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GAccountsByPkData_accounts_nodes_identity_membershipHistory
      get membershipHistory;
  @override
  GAccountsByPkData_accounts_nodes_identity_ownerKeyChange get ownerKeyChange;
  @override
  GAccountsByPkData_accounts_nodes_identity_smith? get smith;
  static Serializer<GAccountsByPkData_accounts_nodes_identity> get serializer =>
      _$gAccountsByPkDataAccountsNodesIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_account
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_account,
            GAccountsByPkData_accounts_nodes_identity_accountBuilder>,
        GAccountFields_identity_account,
        GIdentityFields_account {
  GAccountsByPkData_accounts_nodes_identity_account._();

  factory GAccountsByPkData_accounts_nodes_identity_account(
      [void Function(GAccountsByPkData_accounts_nodes_identity_accountBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_account.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_certIssued,
            GAccountsByPkData_accounts_nodes_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued {
  GAccountsByPkData_accounts_nodes_identity_certIssued._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued(
      [void Function(
              GAccountsByPkData_accounts_nodes_identity_certIssuedBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_certIssued;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_identity_certIssued_nodes>
      get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_certIssued>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_certIssued_nodes,
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodesBuilder>,
        GAccountFields_identity_certIssued_nodes,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued_nodes(
      [void Function(
              GAccountsByPkData_accounts_nodes_identity_certIssued_nodesBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_certIssued_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodesBuilder
              b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_certIssued_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer,
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account,
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer_account,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver,
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account,
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver_account,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account._();

  factory GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_certReceived,
            GAccountsByPkData_accounts_nodes_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived {
  GAccountsByPkData_accounts_nodes_identity_certReceived._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived(
      [void Function(
              GAccountsByPkData_accounts_nodes_identity_certReceivedBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_certReceived;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_identity_certReceived_nodes>
      get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_certReceived>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_certReceived_nodes,
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodesBuilder>,
        GAccountFields_identity_certReceived_nodes,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certReceived_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certReceived_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodesBuilder
              b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer?
      get issuer;
  @override
  String? get receiverId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver?
      get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer,
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account,
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer_account,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver,
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account?
      get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account,
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver_account,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account._();

  factory GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_membershipHistory
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_membershipHistory,
            GAccountsByPkData_accounts_nodes_identity_membershipHistoryBuilder>,
        GAccountFields_identity_membershipHistory,
        GIdentityFields_membershipHistory {
  GAccountsByPkData_accounts_nodes_identity_membershipHistory._();

  factory GAccountsByPkData_accounts_nodes_identity_membershipHistory(
      [void Function(
              GAccountsByPkData_accounts_nodes_identity_membershipHistoryBuilder
                  b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_membershipHistory;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_membershipHistoryBuilder
              b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes>
      get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_membershipHistory>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityMembershipHistorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_membershipHistory.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_membershipHistory? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_membershipHistory.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes,
            GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder>,
        GAccountFields_identity_membershipHistory_nodes,
        GIdentityFields_membershipHistory_nodes {
  GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodesBuilder
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
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_membershipHistory_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_ownerKeyChange
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_ownerKeyChange,
            GAccountsByPkData_accounts_nodes_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange {
  GAccountsByPkData_accounts_nodes_identity_ownerKeyChange._();

  factory GAccountsByPkData_accounts_nodes_identity_ownerKeyChange(
      [void Function(
              GAccountsByPkData_accounts_nodes_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes>
      get nodes;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_ownerKeyChange>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityOwnerKeyChangeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_ownerKeyChange.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_ownerKeyChange? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_ownerKeyChange.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes,
            GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder>,
        GAccountFields_identity_ownerKeyChange_nodes,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodesBuilder
              b) =>
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
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentityOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_ownerKeyChange_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_smith
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_smith,
            GAccountsByPkData_accounts_nodes_identity_smithBuilder>,
        GAccountFields_identity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountsByPkData_accounts_nodes_identity_smith._();

  factory GAccountsByPkData_accounts_nodes_identity_smith(
      [void Function(GAccountsByPkData_accounts_nodes_identity_smithBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_identity_smith;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_smithBuilder b) =>
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
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued
      get smithCertIssued;
  @override
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived
      get smithCertReceived;
  static Serializer<GAccountsByPkData_accounts_nodes_identity_smith>
      get serializer => _$gAccountsByPkDataAccountsNodesIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued,
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder>,
        GAccountFields_identity_smith_smithCertIssued,
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued {
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued._();

  factory GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssuedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes>
      get nodes;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentitySmithSmithCertIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes,
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder>,
        GAccountFields_identity_smith_smithCertIssued_nodes,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentitySmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertIssued_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived
    implements
        Built<GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived,
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived._();

  factory GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceivedBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes>
      get nodes;
  static Serializer<
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentitySmithSmithCertReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes,
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder>,
        GAccountFields_identity_smith_smithCertReceived_nodes,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes._();

  factory GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesIdentitySmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_identity_smith_smithCertReceived_nodes
                .serializer,
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
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountBasicByPkData_accounts? get accounts;
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

abstract class GAccountBasicByPkData_accounts
    implements
        Built<GAccountBasicByPkData_accounts,
            GAccountBasicByPkData_accountsBuilder> {
  GAccountBasicByPkData_accounts._();

  factory GAccountBasicByPkData_accounts(
          [void Function(GAccountBasicByPkData_accountsBuilder b) updates]) =
      _$GAccountBasicByPkData_accounts;

  static void _initializeBuilder(GAccountBasicByPkData_accountsBuilder b) =>
      b..G__typename = 'AccountsConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountBasicByPkData_accounts_nodes> get nodes;
  static Serializer<GAccountBasicByPkData_accounts> get serializer =>
      _$gAccountBasicByPkDataAccountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accounts_nodes
    implements
        Built<GAccountBasicByPkData_accounts_nodes,
            GAccountBasicByPkData_accounts_nodesBuilder>,
        GAccountBasicFields {
  GAccountBasicByPkData_accounts_nodes._();

  factory GAccountBasicByPkData_accounts_nodes(
      [void Function(GAccountBasicByPkData_accounts_nodesBuilder b)
          updates]) = _$GAccountBasicByPkData_accounts_nodes;

  static void _initializeBuilder(
          GAccountBasicByPkData_accounts_nodesBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  GAccountBasicByPkData_accounts_nodes_identity? get identity;
  @override
  bool get isActive;
  static Serializer<GAccountBasicByPkData_accounts_nodes> get serializer =>
      _$gAccountBasicByPkDataAccountsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts_nodes.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accounts_nodes_identity
    implements
        Built<GAccountBasicByPkData_accounts_nodes_identity,
            GAccountBasicByPkData_accounts_nodes_identityBuilder>,
        GAccountBasicFields_identity,
        GIdentityBasicFields {
  GAccountBasicByPkData_accounts_nodes_identity._();

  factory GAccountBasicByPkData_accounts_nodes_identity(
      [void Function(GAccountBasicByPkData_accounts_nodes_identityBuilder b)
          updates]) = _$GAccountBasicByPkData_accounts_nodes_identity;

  static void _initializeBuilder(
          GAccountBasicByPkData_accounts_nodes_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountBasicByPkData_accounts_nodes_identity_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountBasicByPkData_accounts_nodes_identity>
      get serializer => _$gAccountBasicByPkDataAccountsNodesIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts_nodes_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts_nodes_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts_nodes_identity.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accounts_nodes_identity_account
    implements
        Built<GAccountBasicByPkData_accounts_nodes_identity_account,
            GAccountBasicByPkData_accounts_nodes_identity_accountBuilder>,
        GAccountBasicFields_identity_account,
        GIdentityBasicFields_account {
  GAccountBasicByPkData_accounts_nodes_identity_account._();

  factory GAccountBasicByPkData_accounts_nodes_identity_account(
      [void Function(
              GAccountBasicByPkData_accounts_nodes_identity_accountBuilder b)
          updates]) = _$GAccountBasicByPkData_accounts_nodes_identity_account;

  static void _initializeBuilder(
          GAccountBasicByPkData_accounts_nodes_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountBasicByPkData_accounts_nodes_identity_account>
      get serializer =>
          _$gAccountBasicByPkDataAccountsNodesIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts_nodes_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts_nodes_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts_nodes_identity_account.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData
    implements Built<GAccountsBasicByPkData, GAccountsBasicByPkDataBuilder> {
  GAccountsBasicByPkData._();

  factory GAccountsBasicByPkData(
          [void Function(GAccountsBasicByPkDataBuilder b) updates]) =
      _$GAccountsBasicByPkData;

  static void _initializeBuilder(GAccountsBasicByPkDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountsBasicByPkData_accounts? get accounts;
  static Serializer<GAccountsBasicByPkData> get serializer =>
      _$gAccountsBasicByPkDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData_accounts
    implements
        Built<GAccountsBasicByPkData_accounts,
            GAccountsBasicByPkData_accountsBuilder> {
  GAccountsBasicByPkData_accounts._();

  factory GAccountsBasicByPkData_accounts(
          [void Function(GAccountsBasicByPkData_accountsBuilder b) updates]) =
      _$GAccountsBasicByPkData_accounts;

  static void _initializeBuilder(GAccountsBasicByPkData_accountsBuilder b) =>
      b..G__typename = 'AccountsConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountsBasicByPkData_accounts_nodes> get nodes;
  static Serializer<GAccountsBasicByPkData_accounts> get serializer =>
      _$gAccountsBasicByPkDataAccountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData_accounts_nodes
    implements
        Built<GAccountsBasicByPkData_accounts_nodes,
            GAccountsBasicByPkData_accounts_nodesBuilder>,
        GAccountBasicFields {
  GAccountsBasicByPkData_accounts_nodes._();

  factory GAccountsBasicByPkData_accounts_nodes(
      [void Function(GAccountsBasicByPkData_accounts_nodesBuilder b)
          updates]) = _$GAccountsBasicByPkData_accounts_nodes;

  static void _initializeBuilder(
          GAccountsBasicByPkData_accounts_nodesBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  GAccountsBasicByPkData_accounts_nodes_identity? get identity;
  @override
  bool get isActive;
  static Serializer<GAccountsBasicByPkData_accounts_nodes> get serializer =>
      _$gAccountsBasicByPkDataAccountsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts_nodes.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData_accounts_nodes_identity
    implements
        Built<GAccountsBasicByPkData_accounts_nodes_identity,
            GAccountsBasicByPkData_accounts_nodes_identityBuilder>,
        GAccountBasicFields_identity,
        GIdentityBasicFields {
  GAccountsBasicByPkData_accounts_nodes_identity._();

  factory GAccountsBasicByPkData_accounts_nodes_identity(
      [void Function(GAccountsBasicByPkData_accounts_nodes_identityBuilder b)
          updates]) = _$GAccountsBasicByPkData_accounts_nodes_identity;

  static void _initializeBuilder(
          GAccountsBasicByPkData_accounts_nodes_identityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountsBasicByPkData_accounts_nodes_identity_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountsBasicByPkData_accounts_nodes_identity>
      get serializer => _$gAccountsBasicByPkDataAccountsNodesIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts_nodes_identity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts_nodes_identity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts_nodes_identity.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData_accounts_nodes_identity_account
    implements
        Built<GAccountsBasicByPkData_accounts_nodes_identity_account,
            GAccountsBasicByPkData_accounts_nodes_identity_accountBuilder>,
        GAccountBasicFields_identity_account,
        GIdentityBasicFields_account {
  GAccountsBasicByPkData_accounts_nodes_identity_account._();

  factory GAccountsBasicByPkData_accounts_nodes_identity_account(
      [void Function(
              GAccountsBasicByPkData_accounts_nodes_identity_accountBuilder b)
          updates]) = _$GAccountsBasicByPkData_accounts_nodes_identity_account;

  static void _initializeBuilder(
          GAccountsBasicByPkData_accounts_nodes_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountsBasicByPkData_accounts_nodes_identity_account>
      get serializer =>
          _$gAccountsBasicByPkDataAccountsNodesIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts_nodes_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts_nodes_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts_nodes_identity_account.serializer,
        json,
      );
}

abstract class GAccountTransactionsData
    implements
        Built<GAccountTransactionsData, GAccountTransactionsDataBuilder> {
  GAccountTransactionsData._();

  factory GAccountTransactionsData(
          [void Function(GAccountTransactionsDataBuilder b) updates]) =
      _$GAccountTransactionsData;

  static void _initializeBuilder(GAccountTransactionsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GAccountTransactionsData_accounts? get accounts;
  static Serializer<GAccountTransactionsData> get serializer =>
      _$gAccountTransactionsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts
    implements
        Built<GAccountTransactionsData_accounts,
            GAccountTransactionsData_accountsBuilder> {
  GAccountTransactionsData_accounts._();

  factory GAccountTransactionsData_accounts(
          [void Function(GAccountTransactionsData_accountsBuilder b) updates]) =
      _$GAccountTransactionsData_accounts;

  static void _initializeBuilder(GAccountTransactionsData_accountsBuilder b) =>
      b..G__typename = 'AccountsConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAccountTransactionsData_accounts_nodes> get nodes;
  static Serializer<GAccountTransactionsData_accounts> get serializer =>
      _$gAccountTransactionsDataAccountsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes
    implements
        Built<GAccountTransactionsData_accounts_nodes,
            GAccountTransactionsData_accounts_nodesBuilder>,
        GAccountTxsFields {
  GAccountTransactionsData_accounts_nodes._();

  factory GAccountTransactionsData_accounts_nodes(
      [void Function(GAccountTransactionsData_accounts_nodesBuilder b)
          updates]) = _$GAccountTransactionsData_accounts_nodes;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodesBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  bool get isActive;
  @override
  GAccountTransactionsData_accounts_nodes_comments get comments;
  @override
  GAccountTransactionsData_accounts_nodes_transfersIssued get transfersIssued;
  @override
  GAccountTransactionsData_accounts_nodes_transfersReceived
      get transfersReceived;
  @override
  GAccountTransactionsData_accounts_nodes_transferWithUd get transferWithUd;
  static Serializer<GAccountTransactionsData_accounts_nodes> get serializer =>
      _$gAccountTransactionsDataAccountsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_comments
    implements
        Built<GAccountTransactionsData_accounts_nodes_comments,
            GAccountTransactionsData_accounts_nodes_commentsBuilder>,
        GAccountTxsFields_comments {
  GAccountTransactionsData_accounts_nodes_comments._();

  factory GAccountTransactionsData_accounts_nodes_comments(
      [void Function(GAccountTransactionsData_accounts_nodes_commentsBuilder b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_comments;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_commentsBuilder b) =>
      b..G__typename = 'TxCommentsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTransactionsData_accounts_nodes_comments_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTransactionsData_accounts_nodes_comments_nodes> get nodes;
  static Serializer<GAccountTransactionsData_accounts_nodes_comments>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesCommentsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_comments.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_comments? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_comments.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_comments_pageInfo
    implements
        Built<GAccountTransactionsData_accounts_nodes_comments_pageInfo,
            GAccountTransactionsData_accounts_nodes_comments_pageInfoBuilder>,
        GAccountTxsFields_comments_pageInfo {
  GAccountTransactionsData_accounts_nodes_comments_pageInfo._();

  factory GAccountTransactionsData_accounts_nodes_comments_pageInfo(
      [void Function(
              GAccountTransactionsData_accounts_nodes_comments_pageInfoBuilder
                  b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_comments_pageInfo;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_comments_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountTransactionsData_accounts_nodes_comments_pageInfo>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesCommentsPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_comments_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_comments_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_comments_pageInfo.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_comments_nodes
    implements
        Built<GAccountTransactionsData_accounts_nodes_comments_nodes,
            GAccountTransactionsData_accounts_nodes_comments_nodesBuilder>,
        GAccountTxsFields_comments_nodes,
        GCommentsIssued {
  GAccountTransactionsData_accounts_nodes_comments_nodes._();

  factory GAccountTransactionsData_accounts_nodes_comments_nodes(
      [void Function(
              GAccountTransactionsData_accounts_nodes_comments_nodesBuilder b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_comments_nodes;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_comments_nodesBuilder b) =>
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
  String get remarkBytes;
  @override
  String get type;
  static Serializer<GAccountTransactionsData_accounts_nodes_comments_nodes>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesCommentsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_comments_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_comments_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_comments_nodes.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersIssued,
            GAccountTransactionsData_accounts_nodes_transfersIssuedBuilder>,
        GAccountTxsFields_transfersIssued {
  GAccountTransactionsData_accounts_nodes_transfersIssued._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued(
      [void Function(
              GAccountTransactionsData_accounts_nodes_transfersIssuedBuilder b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_transfersIssued;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssuedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTransactionsData_accounts_nodes_transfersIssued_nodes>
      get nodes;
  static Serializer<GAccountTransactionsData_accounts_nodes_transfersIssued>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo,
            GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfoBuilder>,
        GAccountTxsFields_transfersIssued_pageInfo {
  GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfoBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfoBuilder
              b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersIssued_pageInfo
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued_nodes
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersIssued_nodes,
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodesBuilder>,
        GAccountTxsFields_transfersIssued_nodes,
        GTransferFields {
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued_nodes(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersIssued_nodesBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersIssued_nodes;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodesBuilder
              b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to? get to;
  @override
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from? get from;
  @override
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment?
      get comment;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to,
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_toBuilder>,
        GAccountTxsFields_transfersIssued_nodes_to,
        GTransferFields_to {
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_toBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_toBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_to
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from,
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_fromBuilder>,
        GAccountTxsFields_transfersIssued_nodes_from,
        GTransferFields_from {
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_fromBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_from
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment,
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_commentBuilder>,
        GAccountTxsFields_transfersIssued_nodes_comment,
        GTransferFields_comment {
  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment._();

  factory GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersIssuedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersIssued_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersReceived,
            GAccountTransactionsData_accounts_nodes_transfersReceivedBuilder>,
        GAccountTxsFields_transfersReceived {
  GAccountTransactionsData_accounts_nodes_transfersReceived._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived(
      [void Function(
              GAccountTransactionsData_accounts_nodes_transfersReceivedBuilder
                  b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_transfersReceived;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceivedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo
      get pageInfo;
  @override
  BuiltList<GAccountTransactionsData_accounts_nodes_transfersReceived_nodes>
      get nodes;
  static Serializer<GAccountTransactionsData_accounts_nodes_transfersReceived>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo,
            GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfoBuilder>,
        GAccountTxsFields_transfersReceived_pageInfo {
  GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfoBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfoBuilder
              b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersReceived_pageInfo
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived_nodes
    implements
        Built<GAccountTransactionsData_accounts_nodes_transfersReceived_nodes,
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodesBuilder>,
        GAccountTxsFields_transfersReceived_nodes,
        GTransferFields {
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived_nodes(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersReceived_nodesBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersReceived_nodes;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodesBuilder
              b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to? get to;
  @override
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from?
      get from;
  @override
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment?
      get comment;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to,
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_toBuilder>,
        GAccountTxsFields_transfersReceived_nodes_to,
        GTransferFields_to {
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_toBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_toBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_to
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from,
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_fromBuilder>,
        GAccountTxsFields_transfersReceived_nodes_from,
        GTransferFields_from {
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_fromBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_fromBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_from
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment
    implements
        Built<
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment,
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_commentBuilder>,
        GAccountTxsFields_transfersReceived_nodes_comment,
        GTransferFields_comment {
  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment._();

  factory GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_commentBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_commentBuilder
              b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransfersReceivedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transfersReceived_nodes_comment
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transferWithUd
    implements
        Built<GAccountTransactionsData_accounts_nodes_transferWithUd,
            GAccountTransactionsData_accounts_nodes_transferWithUdBuilder>,
        GAccountTxsFields_transferWithUd {
  GAccountTransactionsData_accounts_nodes_transferWithUd._();

  factory GAccountTransactionsData_accounts_nodes_transferWithUd(
      [void Function(
              GAccountTransactionsData_accounts_nodes_transferWithUdBuilder b)
          updates]) = _$GAccountTransactionsData_accounts_nodes_transferWithUd;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transferWithUdBuilder b) =>
      b..G__typename = 'TransferWithUdsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTransactionsData_accounts_nodes_transferWithUd_nodes>
      get nodes;
  static Serializer<GAccountTransactionsData_accounts_nodes_transferWithUd>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransferWithUdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transferWithUd.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transferWithUd? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_transferWithUd.serializer,
        json,
      );
}

abstract class GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo
    implements
        Built<GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo,
            GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfoBuilder>,
        GAccountTxsFields_transferWithUd_pageInfo {
  GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo._();

  factory GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfoBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfoBuilder
              b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransferWithUdPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountTransactionsData_accounts_nodes_transferWithUd_pageInfo
                .serializer,
            json,
          );
}

abstract class GAccountTransactionsData_accounts_nodes_transferWithUd_nodes
    implements
        Built<GAccountTransactionsData_accounts_nodes_transferWithUd_nodes,
            GAccountTransactionsData_accounts_nodes_transferWithUd_nodesBuilder>,
        GAccountTxsFields_transferWithUd_nodes {
  GAccountTransactionsData_accounts_nodes_transferWithUd_nodes._();

  factory GAccountTransactionsData_accounts_nodes_transferWithUd_nodes(
          [void Function(
                  GAccountTransactionsData_accounts_nodes_transferWithUd_nodesBuilder
                      b)
              updates]) =
      _$GAccountTransactionsData_accounts_nodes_transferWithUd_nodes;

  static void _initializeBuilder(
          GAccountTransactionsData_accounts_nodes_transferWithUd_nodesBuilder
              b) =>
      b..G__typename = 'TransferWithUd';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  _i2.GDatetime? get timestamp;
  @override
  _i2.GBigInt? get amount;
  static Serializer<
          GAccountTransactionsData_accounts_nodes_transferWithUd_nodes>
      get serializer =>
          _$gAccountTransactionsDataAccountsNodesTransferWithUdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsData_accounts_nodes_transferWithUd_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsData_accounts_nodes_transferWithUd_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsData_accounts_nodes_transferWithUd_nodes.serializer,
        json,
      );
}

abstract class GIndexerVersionData
    implements Built<GIndexerVersionData, GIndexerVersionDataBuilder> {
  GIndexerVersionData._();

  factory GIndexerVersionData(
          [void Function(GIndexerVersionDataBuilder b) updates]) =
      _$GIndexerVersionData;

  static void _initializeBuilder(GIndexerVersionDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GIndexerVersionData_version get version;
  GIndexerVersionData_squidStatus get squidStatus;
  static Serializer<GIndexerVersionData> get serializer =>
      _$gIndexerVersionDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIndexerVersionData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIndexerVersionData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIndexerVersionData.serializer,
        json,
      );
}

abstract class GIndexerVersionData_version
    implements
        Built<GIndexerVersionData_version, GIndexerVersionData_versionBuilder> {
  GIndexerVersionData_version._();

  factory GIndexerVersionData_version(
          [void Function(GIndexerVersionData_versionBuilder b) updates]) =
      _$GIndexerVersionData_version;

  static void _initializeBuilder(GIndexerVersionData_versionBuilder b) =>
      b..G__typename = '_IndexerInfo';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get version;
  String get type;
  static Serializer<GIndexerVersionData_version> get serializer =>
      _$gIndexerVersionDataVersionSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIndexerVersionData_version.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIndexerVersionData_version? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIndexerVersionData_version.serializer,
        json,
      );
}

abstract class GIndexerVersionData_squidStatus
    implements
        Built<GIndexerVersionData_squidStatus,
            GIndexerVersionData_squidStatusBuilder> {
  GIndexerVersionData_squidStatus._();

  factory GIndexerVersionData_squidStatus(
          [void Function(GIndexerVersionData_squidStatusBuilder b) updates]) =
      _$GIndexerVersionData_squidStatus;

  static void _initializeBuilder(GIndexerVersionData_squidStatusBuilder b) =>
      b..G__typename = '_ProcessorStatus';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get name;
  int get height;
  String get hash;
  static Serializer<GIndexerVersionData_squidStatus> get serializer =>
      _$gIndexerVersionDataSquidStatusSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIndexerVersionData_squidStatus.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIndexerVersionData_squidStatus? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIndexerVersionData_squidStatus.serializer,
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
  GCertFields_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GCertFields_issuer_account
    implements GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GCertFields_receiver implements GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GCertFields_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GCertFields_receiver_account
    implements GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
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
  GCertFieldsData_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
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

abstract class GCertFieldsData_issuer_account
    implements
        Built<GCertFieldsData_issuer_account,
            GCertFieldsData_issuer_accountBuilder>,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GCertFieldsData_issuer_account._();

  factory GCertFieldsData_issuer_account(
          [void Function(GCertFieldsData_issuer_accountBuilder b) updates]) =
      _$GCertFieldsData_issuer_account;

  static void _initializeBuilder(GCertFieldsData_issuer_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GCertFieldsData_issuer_account> get serializer =>
      _$gCertFieldsDataIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsData_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsData_issuer_account? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsData_issuer_account.serializer,
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
  GCertFieldsData_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
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

abstract class GCertFieldsData_receiver_account
    implements
        Built<GCertFieldsData_receiver_account,
            GCertFieldsData_receiver_accountBuilder>,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GCertFieldsData_receiver_account._();

  factory GCertFieldsData_receiver_account(
          [void Function(GCertFieldsData_receiver_accountBuilder b) updates]) =
      _$GCertFieldsData_receiver_account;

  static void _initializeBuilder(GCertFieldsData_receiver_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GCertFieldsData_receiver_account> get serializer =>
      _$gCertFieldsDataReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsData_receiver_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsData_receiver_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsData_receiver_account.serializer,
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
  GSmithFields_smithCertIssued get smithCertIssued;
  GSmithFields_smithCertReceived get smithCertReceived;
  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertIssued {
  String get G__typename;
  int get totalCount;
  BuiltList<GSmithFields_smithCertIssued_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertIssued_nodes implements GSmithCertFields {
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

abstract class GSmithFields_smithCertReceived {
  String get G__typename;
  int get totalCount;
  BuiltList<GSmithFields_smithCertReceived_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertReceived_nodes
    implements GSmithCertFields {
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
  GSmithFieldsData_smithCertIssued get smithCertIssued;
  @override
  GSmithFieldsData_smithCertReceived get smithCertReceived;
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
        GSmithFields_smithCertIssued {
  GSmithFieldsData_smithCertIssued._();

  factory GSmithFieldsData_smithCertIssued(
          [void Function(GSmithFieldsData_smithCertIssuedBuilder b) updates]) =
      _$GSmithFieldsData_smithCertIssued;

  static void _initializeBuilder(GSmithFieldsData_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GSmithFieldsData_smithCertIssued_nodes> get nodes;
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

abstract class GSmithFieldsData_smithCertIssued_nodes
    implements
        Built<GSmithFieldsData_smithCertIssued_nodes,
            GSmithFieldsData_smithCertIssued_nodesBuilder>,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GSmithFieldsData_smithCertIssued_nodes._();

  factory GSmithFieldsData_smithCertIssued_nodes(
      [void Function(GSmithFieldsData_smithCertIssued_nodesBuilder b)
          updates]) = _$GSmithFieldsData_smithCertIssued_nodes;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertIssued_nodesBuilder b) =>
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
  static Serializer<GSmithFieldsData_smithCertIssued_nodes> get serializer =>
      _$gSmithFieldsDataSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertIssued_nodes.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertReceived
    implements
        Built<GSmithFieldsData_smithCertReceived,
            GSmithFieldsData_smithCertReceivedBuilder>,
        GSmithFields_smithCertReceived {
  GSmithFieldsData_smithCertReceived._();

  factory GSmithFieldsData_smithCertReceived(
      [void Function(GSmithFieldsData_smithCertReceivedBuilder b)
          updates]) = _$GSmithFieldsData_smithCertReceived;

  static void _initializeBuilder(GSmithFieldsData_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GSmithFieldsData_smithCertReceived_nodes> get nodes;
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

abstract class GSmithFieldsData_smithCertReceived_nodes
    implements
        Built<GSmithFieldsData_smithCertReceived_nodes,
            GSmithFieldsData_smithCertReceived_nodesBuilder>,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GSmithFieldsData_smithCertReceived_nodes._();

  factory GSmithFieldsData_smithCertReceived_nodes(
      [void Function(GSmithFieldsData_smithCertReceived_nodesBuilder b)
          updates]) = _$GSmithFieldsData_smithCertReceived_nodes;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertReceived_nodesBuilder b) =>
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
  static Serializer<GSmithFieldsData_smithCertReceived_nodes> get serializer =>
      _$gSmithFieldsDataSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertReceived_nodes.serializer,
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
  GIdentityBasicFields_account? get account;
  String get id;
  bool get isMember;
  String get status;
  String get name;
  int get expireOn;
  int get index;
  Map<String, dynamic> toJson();
}

abstract class GIdentityBasicFields_account {
  String get G__typename;
  int get createdOn;
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
  GIdentityBasicFieldsData_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
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

abstract class GIdentityBasicFieldsData_account
    implements
        Built<GIdentityBasicFieldsData_account,
            GIdentityBasicFieldsData_accountBuilder>,
        GIdentityBasicFields_account {
  GIdentityBasicFieldsData_account._();

  factory GIdentityBasicFieldsData_account(
          [void Function(GIdentityBasicFieldsData_accountBuilder b) updates]) =
      _$GIdentityBasicFieldsData_account;

  static void _initializeBuilder(GIdentityBasicFieldsData_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityBasicFieldsData_account> get serializer =>
      _$gIdentityBasicFieldsDataAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityBasicFieldsData_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityBasicFieldsData_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityBasicFieldsData_account.serializer,
        json,
      );
}

abstract class GIdentityFields {
  String get G__typename;
  GIdentityFields_account? get account;
  String? get accountId;
  String? get accountRemovedId;
  GIdentityFields_certIssued get certIssued;
  GIdentityFields_certReceived get certReceived;
  String? get createdInId;
  int get createdOn;
  int get expireOn;
  String get id;
  int get index;
  bool get isMember;
  int get lastChangeOn;
  String get status;
  String get name;
  GIdentityFields_membershipHistory get membershipHistory;
  GIdentityFields_ownerKeyChange get ownerKeyChange;
  GIdentityFields_smith? get smith;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_account {
  String get G__typename;
  int get createdOn;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued {
  String get G__typename;
  int get totalCount;
  BuiltList<GIdentityFields_certIssued_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_nodes implements GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFields_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFields_certIssued_nodes_receiver? get receiver;
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

abstract class GIdentityFields_certIssued_nodes_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFields_certIssued_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_nodes_issuer_account
    implements GCertFields_issuer_account, GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_nodes_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFields_certIssued_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certIssued_nodes_receiver_account
    implements GCertFields_receiver_account, GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived {
  String get G__typename;
  int get totalCount;
  BuiltList<GIdentityFields_certReceived_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_nodes implements GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFields_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFields_certReceived_nodes_receiver? get receiver;
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

abstract class GIdentityFields_certReceived_nodes_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFields_certReceived_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_nodes_issuer_account
    implements GCertFields_issuer_account, GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_nodes_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFields_certReceived_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certReceived_nodes_receiver_account
    implements GCertFields_receiver_account, GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipHistory {
  String get G__typename;
  int get totalCount;
  BuiltList<GIdentityFields_membershipHistory_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipHistory_nodes {
  String get G__typename;
  int get blockNumber;
  String? get eventId;
  String get eventType;
  String get id;
  String? get identityId;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_ownerKeyChange {
  String get G__typename;
  int get totalCount;
  BuiltList<GIdentityFields_ownerKeyChange_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_ownerKeyChange_nodes
    implements GOwnerKeyChangeFields {
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
  GIdentityFields_smith_smithCertIssued get smithCertIssued;
  @override
  GIdentityFields_smith_smithCertReceived get smithCertReceived;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertIssued
    implements GSmithFields_smithCertIssued {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFields_smith_smithCertIssued_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertIssued_nodes
    implements GSmithFields_smithCertIssued_nodes, GSmithCertFields {
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
    implements GSmithFields_smithCertReceived {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFields_smith_smithCertReceived_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertReceived_nodes
    implements GSmithFields_smithCertReceived_nodes, GSmithCertFields {
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
  GIdentityFieldsData_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GIdentityFieldsData_certIssued get certIssued;
  @override
  GIdentityFieldsData_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GIdentityFieldsData_membershipHistory get membershipHistory;
  @override
  GIdentityFieldsData_ownerKeyChange get ownerKeyChange;
  @override
  GIdentityFieldsData_smith? get smith;
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

abstract class GIdentityFieldsData_account
    implements
        Built<GIdentityFieldsData_account, GIdentityFieldsData_accountBuilder>,
        GIdentityFields_account {
  GIdentityFieldsData_account._();

  factory GIdentityFieldsData_account(
          [void Function(GIdentityFieldsData_accountBuilder b) updates]) =
      _$GIdentityFieldsData_account;

  static void _initializeBuilder(GIdentityFieldsData_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_account> get serializer =>
      _$gIdentityFieldsDataAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_account? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued
    implements
        Built<GIdentityFieldsData_certIssued,
            GIdentityFieldsData_certIssuedBuilder>,
        GIdentityFields_certIssued {
  GIdentityFieldsData_certIssued._();

  factory GIdentityFieldsData_certIssued(
          [void Function(GIdentityFieldsData_certIssuedBuilder b) updates]) =
      _$GIdentityFieldsData_certIssued;

  static void _initializeBuilder(GIdentityFieldsData_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_certIssued_nodes> get nodes;
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

abstract class GIdentityFieldsData_certIssued_nodes
    implements
        Built<GIdentityFieldsData_certIssued_nodes,
            GIdentityFieldsData_certIssued_nodesBuilder>,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GIdentityFieldsData_certIssued_nodes._();

  factory GIdentityFieldsData_certIssued_nodes(
      [void Function(GIdentityFieldsData_certIssued_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFieldsData_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFieldsData_certIssued_nodes_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentityFieldsData_certIssued_nodes> get serializer =>
      _$gIdentityFieldsDataCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_nodes_issuer
    implements
        Built<GIdentityFieldsData_certIssued_nodes_issuer,
            GIdentityFieldsData_certIssued_nodes_issuerBuilder>,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certIssued_nodes_issuer._();

  factory GIdentityFieldsData_certIssued_nodes_issuer(
      [void Function(GIdentityFieldsData_certIssued_nodes_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFieldsData_certIssued_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GIdentityFieldsData_certIssued_nodes_issuer>
      get serializer => _$gIdentityFieldsDataCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_nodes_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_nodes_issuer_account
    implements
        Built<GIdentityFieldsData_certIssued_nodes_issuer_account,
            GIdentityFieldsData_certIssued_nodes_issuer_accountBuilder>,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certIssued_nodes_issuer_account._();

  factory GIdentityFieldsData_certIssued_nodes_issuer_account(
      [void Function(
              GIdentityFieldsData_certIssued_nodes_issuer_accountBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_nodes_issuer_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_certIssued_nodes_issuer_account>
      get serializer =>
          _$gIdentityFieldsDataCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_nodes_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_nodes_issuer_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_nodes_issuer_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_nodes_receiver
    implements
        Built<GIdentityFieldsData_certIssued_nodes_receiver,
            GIdentityFieldsData_certIssued_nodes_receiverBuilder>,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certIssued_nodes_receiver._();

  factory GIdentityFieldsData_certIssued_nodes_receiver(
      [void Function(GIdentityFieldsData_certIssued_nodes_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFieldsData_certIssued_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GIdentityFieldsData_certIssued_nodes_receiver>
      get serializer => _$gIdentityFieldsDataCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_nodes_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certIssued_nodes_receiver_account
    implements
        Built<GIdentityFieldsData_certIssued_nodes_receiver_account,
            GIdentityFieldsData_certIssued_nodes_receiver_accountBuilder>,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certIssued_nodes_receiver_account._();

  factory GIdentityFieldsData_certIssued_nodes_receiver_account(
      [void Function(
              GIdentityFieldsData_certIssued_nodes_receiver_accountBuilder b)
          updates]) = _$GIdentityFieldsData_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certIssued_nodes_receiver_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_certIssued_nodes_receiver_account>
      get serializer =>
          _$gIdentityFieldsDataCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certIssued_nodes_receiver_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certIssued_nodes_receiver_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certIssued_nodes_receiver_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived
    implements
        Built<GIdentityFieldsData_certReceived,
            GIdentityFieldsData_certReceivedBuilder>,
        GIdentityFields_certReceived {
  GIdentityFieldsData_certReceived._();

  factory GIdentityFieldsData_certReceived(
          [void Function(GIdentityFieldsData_certReceivedBuilder b) updates]) =
      _$GIdentityFieldsData_certReceived;

  static void _initializeBuilder(GIdentityFieldsData_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_certReceived_nodes> get nodes;
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

abstract class GIdentityFieldsData_certReceived_nodes
    implements
        Built<GIdentityFieldsData_certReceived_nodes,
            GIdentityFieldsData_certReceived_nodesBuilder>,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GIdentityFieldsData_certReceived_nodes._();

  factory GIdentityFieldsData_certReceived_nodes(
      [void Function(GIdentityFieldsData_certReceived_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GIdentityFieldsData_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GIdentityFieldsData_certReceived_nodes_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GIdentityFieldsData_certReceived_nodes> get serializer =>
      _$gIdentityFieldsDataCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_nodes_issuer
    implements
        Built<GIdentityFieldsData_certReceived_nodes_issuer,
            GIdentityFieldsData_certReceived_nodes_issuerBuilder>,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certReceived_nodes_issuer._();

  factory GIdentityFieldsData_certReceived_nodes_issuer(
      [void Function(GIdentityFieldsData_certReceived_nodes_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFieldsData_certReceived_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GIdentityFieldsData_certReceived_nodes_issuer>
      get serializer => _$gIdentityFieldsDataCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_nodes_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_nodes_issuer_account
    implements
        Built<GIdentityFieldsData_certReceived_nodes_issuer_account,
            GIdentityFieldsData_certReceived_nodes_issuer_accountBuilder>,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certReceived_nodes_issuer_account._();

  factory GIdentityFieldsData_certReceived_nodes_issuer_account(
      [void Function(
              GIdentityFieldsData_certReceived_nodes_issuer_accountBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_nodes_issuer_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_certReceived_nodes_issuer_account>
      get serializer =>
          _$gIdentityFieldsDataCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_nodes_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_nodes_issuer_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_nodes_issuer_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_nodes_receiver
    implements
        Built<GIdentityFieldsData_certReceived_nodes_receiver,
            GIdentityFieldsData_certReceived_nodes_receiverBuilder>,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certReceived_nodes_receiver._();

  factory GIdentityFieldsData_certReceived_nodes_receiver(
      [void Function(GIdentityFieldsData_certReceived_nodes_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GIdentityFieldsData_certReceived_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GIdentityFieldsData_certReceived_nodes_receiver>
      get serializer =>
          _$gIdentityFieldsDataCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_nodes_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certReceived_nodes_receiver_account
    implements
        Built<GIdentityFieldsData_certReceived_nodes_receiver_account,
            GIdentityFieldsData_certReceived_nodes_receiver_accountBuilder>,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certReceived_nodes_receiver_account._();

  factory GIdentityFieldsData_certReceived_nodes_receiver_account(
      [void Function(
              GIdentityFieldsData_certReceived_nodes_receiver_accountBuilder b)
          updates]) = _$GIdentityFieldsData_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certReceived_nodes_receiver_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GIdentityFieldsData_certReceived_nodes_receiver_account>
      get serializer =>
          _$gIdentityFieldsDataCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certReceived_nodes_receiver_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certReceived_nodes_receiver_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certReceived_nodes_receiver_account.serializer,
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
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_membershipHistory_nodes> get nodes;
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

abstract class GIdentityFieldsData_membershipHistory_nodes
    implements
        Built<GIdentityFieldsData_membershipHistory_nodes,
            GIdentityFieldsData_membershipHistory_nodesBuilder>,
        GIdentityFields_membershipHistory_nodes {
  GIdentityFieldsData_membershipHistory_nodes._();

  factory GIdentityFieldsData_membershipHistory_nodes(
      [void Function(GIdentityFieldsData_membershipHistory_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_membershipHistory_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipHistory_nodesBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GIdentityFieldsData_membershipHistory_nodes>
      get serializer => _$gIdentityFieldsDataMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipHistory_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipHistory_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipHistory_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_ownerKeyChange
    implements
        Built<GIdentityFieldsData_ownerKeyChange,
            GIdentityFieldsData_ownerKeyChangeBuilder>,
        GIdentityFields_ownerKeyChange {
  GIdentityFieldsData_ownerKeyChange._();

  factory GIdentityFieldsData_ownerKeyChange(
      [void Function(GIdentityFieldsData_ownerKeyChangeBuilder b)
          updates]) = _$GIdentityFieldsData_ownerKeyChange;

  static void _initializeBuilder(GIdentityFieldsData_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_ownerKeyChange_nodes> get nodes;
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

abstract class GIdentityFieldsData_ownerKeyChange_nodes
    implements
        Built<GIdentityFieldsData_ownerKeyChange_nodes,
            GIdentityFieldsData_ownerKeyChange_nodesBuilder>,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GIdentityFieldsData_ownerKeyChange_nodes._();

  factory GIdentityFieldsData_ownerKeyChange_nodes(
      [void Function(GIdentityFieldsData_ownerKeyChange_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_ownerKeyChange_nodesBuilder b) =>
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
  static Serializer<GIdentityFieldsData_ownerKeyChange_nodes> get serializer =>
      _$gIdentityFieldsDataOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_ownerKeyChange_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_ownerKeyChange_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_ownerKeyChange_nodes.serializer,
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
  GIdentityFieldsData_smith_smithCertIssued get smithCertIssued;
  @override
  GIdentityFieldsData_smith_smithCertReceived get smithCertReceived;
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
        GSmithFields_smithCertIssued {
  GIdentityFieldsData_smith_smithCertIssued._();

  factory GIdentityFieldsData_smith_smithCertIssued(
      [void Function(GIdentityFieldsData_smith_smithCertIssuedBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertIssued;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_smith_smithCertIssued_nodes> get nodes;
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

abstract class GIdentityFieldsData_smith_smithCertIssued_nodes
    implements
        Built<GIdentityFieldsData_smith_smithCertIssued_nodes,
            GIdentityFieldsData_smith_smithCertIssued_nodesBuilder>,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertIssued_nodes._();

  factory GIdentityFieldsData_smith_smithCertIssued_nodes(
      [void Function(GIdentityFieldsData_smith_smithCertIssued_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertIssued_nodesBuilder b) =>
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
  static Serializer<GIdentityFieldsData_smith_smithCertIssued_nodes>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertIssued_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertReceived
    implements
        Built<GIdentityFieldsData_smith_smithCertReceived,
            GIdentityFieldsData_smith_smithCertReceivedBuilder>,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GIdentityFieldsData_smith_smithCertReceived._();

  factory GIdentityFieldsData_smith_smithCertReceived(
      [void Function(GIdentityFieldsData_smith_smithCertReceivedBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertReceived;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GIdentityFieldsData_smith_smithCertReceived_nodes> get nodes;
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

abstract class GIdentityFieldsData_smith_smithCertReceived_nodes
    implements
        Built<GIdentityFieldsData_smith_smithCertReceived_nodes,
            GIdentityFieldsData_smith_smithCertReceived_nodesBuilder>,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertReceived_nodes._();

  factory GIdentityFieldsData_smith_smithCertReceived_nodes(
      [void Function(GIdentityFieldsData_smith_smithCertReceived_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertReceived_nodesBuilder b) =>
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
  static Serializer<GIdentityFieldsData_smith_smithCertReceived_nodes>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertReceived_nodes.serializer,
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
  String get remarkBytes;
  String get type;
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
  String get remarkBytes;
  @override
  String get type;
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
  _i2.GBigInt get balance;
  _i2.GBigFloat? get totalBalance;
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
  GAccountBasicFields_identity_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountBasicFields_identity_account
    implements GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
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
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
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
  GAccountBasicFieldsData_identity_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
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

abstract class GAccountBasicFieldsData_identity_account
    implements
        Built<GAccountBasicFieldsData_identity_account,
            GAccountBasicFieldsData_identity_accountBuilder>,
        GAccountBasicFields_identity_account,
        GIdentityBasicFields_account {
  GAccountBasicFieldsData_identity_account._();

  factory GAccountBasicFieldsData_identity_account(
      [void Function(GAccountBasicFieldsData_identity_accountBuilder b)
          updates]) = _$GAccountBasicFieldsData_identity_account;

  static void _initializeBuilder(
          GAccountBasicFieldsData_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountBasicFieldsData_identity_account> get serializer =>
      _$gAccountBasicFieldsDataIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsData_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsData_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsData_identity_account.serializer,
        json,
      );
}

abstract class GAccountFields {
  String get G__typename;
  int get createdOn;
  String get id;
  _i2.GBigInt get balance;
  _i2.GBigFloat? get totalBalance;
  bool get isActive;
  GAccountFields_transfersIssued get transfersIssued;
  GAccountFields_transfersReceived get transfersReceived;
  GAccountFields_wasIdentityPrev get wasIdentityPrev;
  GAccountFields_wasIdentityNext get wasIdentityNext;
  GAccountFields_identity? get identity;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued {
  String get G__typename;
  int get totalCount;
  GAccountFields_transfersIssued_pageInfo get pageInfo;
  BuiltList<GAccountFields_transfersIssued_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_nodes implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountFields_transfersIssued_nodes_to? get to;
  @override
  GAccountFields_transfersIssued_nodes_from? get from;
  @override
  GAccountFields_transfersIssued_nodes_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_nodes_to
    implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_nodes_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersIssued_nodes_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived {
  String get G__typename;
  int get totalCount;
  GAccountFields_transfersReceived_pageInfo get pageInfo;
  BuiltList<GAccountFields_transfersReceived_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_nodes
    implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountFields_transfersReceived_nodes_to? get to;
  @override
  GAccountFields_transfersReceived_nodes_from? get from;
  @override
  GAccountFields_transfersReceived_nodes_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_nodes_to
    implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_nodes_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_transfersReceived_nodes_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentityPrev {
  String get G__typename;
  int get totalCount;
  BuiltList<GAccountFields_wasIdentityPrev_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentityPrev_nodes
    implements GOwnerKeyChangeFields {
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

abstract class GAccountFields_wasIdentityNext {
  String get G__typename;
  int get totalCount;
  BuiltList<GAccountFields_wasIdentityNext_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_wasIdentityNext_nodes
    implements GOwnerKeyChangeFields {
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

abstract class GAccountFields_identity implements GIdentityFields {
  @override
  String get G__typename;
  @override
  GAccountFields_identity_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GAccountFields_identity_certIssued get certIssued;
  @override
  GAccountFields_identity_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GAccountFields_identity_membershipHistory get membershipHistory;
  @override
  GAccountFields_identity_ownerKeyChange get ownerKeyChange;
  @override
  GAccountFields_identity_smith? get smith;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_account
    implements GIdentityFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued
    implements GIdentityFields_certIssued {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_certIssued_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_nodes
    implements GIdentityFields_certIssued_nodes, GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFields_identity_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFields_identity_certIssued_nodes_receiver? get receiver;
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

abstract class GAccountFields_identity_certIssued_nodes_issuer
    implements
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFields_identity_certIssued_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_nodes_issuer_account
    implements
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_nodes_receiver
    implements
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFields_identity_certIssued_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certIssued_nodes_receiver_account
    implements
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived
    implements GIdentityFields_certReceived {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_certReceived_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_nodes
    implements GIdentityFields_certReceived_nodes, GCertFields {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFields_identity_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFields_identity_certReceived_nodes_receiver? get receiver;
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

abstract class GAccountFields_identity_certReceived_nodes_issuer
    implements
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFields_identity_certReceived_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_nodes_issuer_account
    implements
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_nodes_receiver
    implements
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFields_identity_certReceived_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_certReceived_nodes_receiver_account
    implements
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;
  @override
  int get createdOn;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_membershipHistory
    implements GIdentityFields_membershipHistory {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_membershipHistory_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_membershipHistory_nodes
    implements GIdentityFields_membershipHistory_nodes {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_ownerKeyChange
    implements GIdentityFields_ownerKeyChange {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_ownerKeyChange_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_ownerKeyChange_nodes
    implements GIdentityFields_ownerKeyChange_nodes, GOwnerKeyChangeFields {
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
  GAccountFields_identity_smith_smithCertIssued get smithCertIssued;
  @override
  GAccountFields_identity_smith_smithCertReceived get smithCertReceived;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith_smithCertIssued
    implements
        GIdentityFields_smith_smithCertIssued,
        GSmithFields_smithCertIssued {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_smith_smithCertIssued_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith_smithCertIssued_nodes
    implements
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
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
        GSmithFields_smithCertReceived {
  @override
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFields_identity_smith_smithCertReceived_nodes> get nodes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_identity_smith_smithCertReceived_nodes
    implements
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
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
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  bool get isActive;
  @override
  GAccountFieldsData_transfersIssued get transfersIssued;
  @override
  GAccountFieldsData_transfersReceived get transfersReceived;
  @override
  GAccountFieldsData_wasIdentityPrev get wasIdentityPrev;
  @override
  GAccountFieldsData_wasIdentityNext get wasIdentityNext;
  @override
  GAccountFieldsData_identity? get identity;
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

abstract class GAccountFieldsData_transfersIssued
    implements
        Built<GAccountFieldsData_transfersIssued,
            GAccountFieldsData_transfersIssuedBuilder>,
        GAccountFields_transfersIssued {
  GAccountFieldsData_transfersIssued._();

  factory GAccountFieldsData_transfersIssued(
      [void Function(GAccountFieldsData_transfersIssuedBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued;

  static void _initializeBuilder(GAccountFieldsData_transfersIssuedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountFieldsData_transfersIssued_pageInfo get pageInfo;
  @override
  BuiltList<GAccountFieldsData_transfersIssued_nodes> get nodes;
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

abstract class GAccountFieldsData_transfersIssued_pageInfo
    implements
        Built<GAccountFieldsData_transfersIssued_pageInfo,
            GAccountFieldsData_transfersIssued_pageInfoBuilder>,
        GAccountFields_transfersIssued_pageInfo {
  GAccountFieldsData_transfersIssued_pageInfo._();

  factory GAccountFieldsData_transfersIssued_pageInfo(
      [void Function(GAccountFieldsData_transfersIssued_pageInfoBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_pageInfo;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountFieldsData_transfersIssued_pageInfo>
      get serializer => _$gAccountFieldsDataTransfersIssuedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_pageInfo.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_nodes
    implements
        Built<GAccountFieldsData_transfersIssued_nodes,
            GAccountFieldsData_transfersIssued_nodesBuilder>,
        GAccountFields_transfersIssued_nodes,
        GTransferFields {
  GAccountFieldsData_transfersIssued_nodes._();

  factory GAccountFieldsData_transfersIssued_nodes(
      [void Function(GAccountFieldsData_transfersIssued_nodesBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountFieldsData_transfersIssued_nodes_to? get to;
  @override
  GAccountFieldsData_transfersIssued_nodes_from? get from;
  @override
  GAccountFieldsData_transfersIssued_nodes_comment? get comment;
  static Serializer<GAccountFieldsData_transfersIssued_nodes> get serializer =>
      _$gAccountFieldsDataTransfersIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_nodes_to
    implements
        Built<GAccountFieldsData_transfersIssued_nodes_to,
            GAccountFieldsData_transfersIssued_nodes_toBuilder>,
        GAccountFields_transfersIssued_nodes_to,
        GTransferFields_to {
  GAccountFieldsData_transfersIssued_nodes_to._();

  factory GAccountFieldsData_transfersIssued_nodes_to(
      [void Function(GAccountFieldsData_transfersIssued_nodes_toBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_nodes_to;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersIssued_nodes_to>
      get serializer => _$gAccountFieldsDataTransfersIssuedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_nodes_to.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_nodes_from
    implements
        Built<GAccountFieldsData_transfersIssued_nodes_from,
            GAccountFieldsData_transfersIssued_nodes_fromBuilder>,
        GAccountFields_transfersIssued_nodes_from,
        GTransferFields_from {
  GAccountFieldsData_transfersIssued_nodes_from._();

  factory GAccountFieldsData_transfersIssued_nodes_from(
      [void Function(GAccountFieldsData_transfersIssued_nodes_fromBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_nodes_from;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_nodes_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersIssued_nodes_from>
      get serializer => _$gAccountFieldsDataTransfersIssuedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_nodes_from.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersIssued_nodes_comment
    implements
        Built<GAccountFieldsData_transfersIssued_nodes_comment,
            GAccountFieldsData_transfersIssued_nodes_commentBuilder>,
        GAccountFields_transfersIssued_nodes_comment,
        GTransferFields_comment {
  GAccountFieldsData_transfersIssued_nodes_comment._();

  factory GAccountFieldsData_transfersIssued_nodes_comment(
      [void Function(GAccountFieldsData_transfersIssued_nodes_commentBuilder b)
          updates]) = _$GAccountFieldsData_transfersIssued_nodes_comment;

  static void _initializeBuilder(
          GAccountFieldsData_transfersIssued_nodes_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<GAccountFieldsData_transfersIssued_nodes_comment>
      get serializer =>
          _$gAccountFieldsDataTransfersIssuedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersIssued_nodes_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersIssued_nodes_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersIssued_nodes_comment.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived
    implements
        Built<GAccountFieldsData_transfersReceived,
            GAccountFieldsData_transfersReceivedBuilder>,
        GAccountFields_transfersReceived {
  GAccountFieldsData_transfersReceived._();

  factory GAccountFieldsData_transfersReceived(
      [void Function(GAccountFieldsData_transfersReceivedBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceivedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountFieldsData_transfersReceived_pageInfo get pageInfo;
  @override
  BuiltList<GAccountFieldsData_transfersReceived_nodes> get nodes;
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

abstract class GAccountFieldsData_transfersReceived_pageInfo
    implements
        Built<GAccountFieldsData_transfersReceived_pageInfo,
            GAccountFieldsData_transfersReceived_pageInfoBuilder>,
        GAccountFields_transfersReceived_pageInfo {
  GAccountFieldsData_transfersReceived_pageInfo._();

  factory GAccountFieldsData_transfersReceived_pageInfo(
      [void Function(GAccountFieldsData_transfersReceived_pageInfoBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_pageInfo;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountFieldsData_transfersReceived_pageInfo>
      get serializer => _$gAccountFieldsDataTransfersReceivedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_pageInfo.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_nodes
    implements
        Built<GAccountFieldsData_transfersReceived_nodes,
            GAccountFieldsData_transfersReceived_nodesBuilder>,
        GAccountFields_transfersReceived_nodes,
        GTransferFields {
  GAccountFieldsData_transfersReceived_nodes._();

  factory GAccountFieldsData_transfersReceived_nodes(
      [void Function(GAccountFieldsData_transfersReceived_nodesBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountFieldsData_transfersReceived_nodes_to? get to;
  @override
  GAccountFieldsData_transfersReceived_nodes_from? get from;
  @override
  GAccountFieldsData_transfersReceived_nodes_comment? get comment;
  static Serializer<GAccountFieldsData_transfersReceived_nodes>
      get serializer => _$gAccountFieldsDataTransfersReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_nodes_to
    implements
        Built<GAccountFieldsData_transfersReceived_nodes_to,
            GAccountFieldsData_transfersReceived_nodes_toBuilder>,
        GAccountFields_transfersReceived_nodes_to,
        GTransferFields_to {
  GAccountFieldsData_transfersReceived_nodes_to._();

  factory GAccountFieldsData_transfersReceived_nodes_to(
      [void Function(GAccountFieldsData_transfersReceived_nodes_toBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_nodes_to;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersReceived_nodes_to>
      get serializer => _$gAccountFieldsDataTransfersReceivedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_nodes_to.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_nodes_from
    implements
        Built<GAccountFieldsData_transfersReceived_nodes_from,
            GAccountFieldsData_transfersReceived_nodes_fromBuilder>,
        GAccountFields_transfersReceived_nodes_from,
        GTransferFields_from {
  GAccountFieldsData_transfersReceived_nodes_from._();

  factory GAccountFieldsData_transfersReceived_nodes_from(
      [void Function(GAccountFieldsData_transfersReceived_nodes_fromBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_nodes_from;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_nodes_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountFieldsData_transfersReceived_nodes_from>
      get serializer =>
          _$gAccountFieldsDataTransfersReceivedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_nodes_from.serializer,
        json,
      );
}

abstract class GAccountFieldsData_transfersReceived_nodes_comment
    implements
        Built<GAccountFieldsData_transfersReceived_nodes_comment,
            GAccountFieldsData_transfersReceived_nodes_commentBuilder>,
        GAccountFields_transfersReceived_nodes_comment,
        GTransferFields_comment {
  GAccountFieldsData_transfersReceived_nodes_comment._();

  factory GAccountFieldsData_transfersReceived_nodes_comment(
      [void Function(
              GAccountFieldsData_transfersReceived_nodes_commentBuilder b)
          updates]) = _$GAccountFieldsData_transfersReceived_nodes_comment;

  static void _initializeBuilder(
          GAccountFieldsData_transfersReceived_nodes_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<GAccountFieldsData_transfersReceived_nodes_comment>
      get serializer =>
          _$gAccountFieldsDataTransfersReceivedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_transfersReceived_nodes_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_transfersReceived_nodes_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_transfersReceived_nodes_comment.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityPrev
    implements
        Built<GAccountFieldsData_wasIdentityPrev,
            GAccountFieldsData_wasIdentityPrevBuilder>,
        GAccountFields_wasIdentityPrev {
  GAccountFieldsData_wasIdentityPrev._();

  factory GAccountFieldsData_wasIdentityPrev(
      [void Function(GAccountFieldsData_wasIdentityPrevBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityPrev;

  static void _initializeBuilder(GAccountFieldsData_wasIdentityPrevBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_wasIdentityPrev_nodes> get nodes;
  static Serializer<GAccountFieldsData_wasIdentityPrev> get serializer =>
      _$gAccountFieldsDataWasIdentityPrevSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityPrev.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityPrev? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityPrev.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityPrev_nodes
    implements
        Built<GAccountFieldsData_wasIdentityPrev_nodes,
            GAccountFieldsData_wasIdentityPrev_nodesBuilder>,
        GAccountFields_wasIdentityPrev_nodes,
        GOwnerKeyChangeFields {
  GAccountFieldsData_wasIdentityPrev_nodes._();

  factory GAccountFieldsData_wasIdentityPrev_nodes(
      [void Function(GAccountFieldsData_wasIdentityPrev_nodesBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityPrev_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_wasIdentityPrev_nodesBuilder b) =>
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
  static Serializer<GAccountFieldsData_wasIdentityPrev_nodes> get serializer =>
      _$gAccountFieldsDataWasIdentityPrevNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityPrev_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityPrev_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityPrev_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityNext
    implements
        Built<GAccountFieldsData_wasIdentityNext,
            GAccountFieldsData_wasIdentityNextBuilder>,
        GAccountFields_wasIdentityNext {
  GAccountFieldsData_wasIdentityNext._();

  factory GAccountFieldsData_wasIdentityNext(
      [void Function(GAccountFieldsData_wasIdentityNextBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityNext;

  static void _initializeBuilder(GAccountFieldsData_wasIdentityNextBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_wasIdentityNext_nodes> get nodes;
  static Serializer<GAccountFieldsData_wasIdentityNext> get serializer =>
      _$gAccountFieldsDataWasIdentityNextSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityNext.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityNext? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityNext.serializer,
        json,
      );
}

abstract class GAccountFieldsData_wasIdentityNext_nodes
    implements
        Built<GAccountFieldsData_wasIdentityNext_nodes,
            GAccountFieldsData_wasIdentityNext_nodesBuilder>,
        GAccountFields_wasIdentityNext_nodes,
        GOwnerKeyChangeFields {
  GAccountFieldsData_wasIdentityNext_nodes._();

  factory GAccountFieldsData_wasIdentityNext_nodes(
      [void Function(GAccountFieldsData_wasIdentityNext_nodesBuilder b)
          updates]) = _$GAccountFieldsData_wasIdentityNext_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_wasIdentityNext_nodesBuilder b) =>
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
  static Serializer<GAccountFieldsData_wasIdentityNext_nodes> get serializer =>
      _$gAccountFieldsDataWasIdentityNextNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_wasIdentityNext_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_wasIdentityNext_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_wasIdentityNext_nodes.serializer,
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
  GAccountFieldsData_identity_account? get account;
  @override
  String? get accountId;
  @override
  String? get accountRemovedId;
  @override
  GAccountFieldsData_identity_certIssued get certIssued;
  @override
  GAccountFieldsData_identity_certReceived get certReceived;
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
  String get status;
  @override
  String get name;
  @override
  GAccountFieldsData_identity_membershipHistory get membershipHistory;
  @override
  GAccountFieldsData_identity_ownerKeyChange get ownerKeyChange;
  @override
  GAccountFieldsData_identity_smith? get smith;
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

abstract class GAccountFieldsData_identity_account
    implements
        Built<GAccountFieldsData_identity_account,
            GAccountFieldsData_identity_accountBuilder>,
        GAccountFields_identity_account,
        GIdentityFields_account {
  GAccountFieldsData_identity_account._();

  factory GAccountFieldsData_identity_account(
      [void Function(GAccountFieldsData_identity_accountBuilder b)
          updates]) = _$GAccountFieldsData_identity_account;

  static void _initializeBuilder(
          GAccountFieldsData_identity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountFieldsData_identity_account> get serializer =>
      _$gAccountFieldsDataIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_account.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued
    implements
        Built<GAccountFieldsData_identity_certIssued,
            GAccountFieldsData_identity_certIssuedBuilder>,
        GAccountFields_identity_certIssued,
        GIdentityFields_certIssued {
  GAccountFieldsData_identity_certIssued._();

  factory GAccountFieldsData_identity_certIssued(
      [void Function(GAccountFieldsData_identity_certIssuedBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssuedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_certIssued_nodes> get nodes;
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

abstract class GAccountFieldsData_identity_certIssued_nodes
    implements
        Built<GAccountFieldsData_identity_certIssued_nodes,
            GAccountFieldsData_identity_certIssued_nodesBuilder>,
        GAccountFields_identity_certIssued_nodes,
        GIdentityFields_certIssued_nodes,
        GCertFields {
  GAccountFieldsData_identity_certIssued_nodes._();

  factory GAccountFieldsData_identity_certIssued_nodes(
      [void Function(GAccountFieldsData_identity_certIssued_nodesBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFieldsData_identity_certIssued_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFieldsData_identity_certIssued_nodes_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountFieldsData_identity_certIssued_nodes>
      get serializer => _$gAccountFieldsDataIdentityCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_nodes_issuer
    implements
        Built<GAccountFieldsData_identity_certIssued_nodes_issuer,
            GAccountFieldsData_identity_certIssued_nodes_issuerBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer,
        GIdentityFields_certIssued_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certIssued_nodes_issuer._();

  factory GAccountFieldsData_identity_certIssued_nodes_issuer(
      [void Function(
              GAccountFieldsData_identity_certIssued_nodes_issuerBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued_nodes_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFieldsData_identity_certIssued_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountFieldsData_identity_certIssued_nodes_issuer>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_nodes_issuer.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_nodes_issuer_account
    implements
        Built<GAccountFieldsData_identity_certIssued_nodes_issuer_account,
            GAccountFieldsData_identity_certIssued_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_issuer_account,
        GIdentityFields_certIssued_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_identity_certIssued_nodes_issuer_account._();

  factory GAccountFieldsData_identity_certIssued_nodes_issuer_account(
      [void Function(
              GAccountFieldsData_identity_certIssued_nodes_issuer_accountBuilder
                  b)
          updates]) = _$GAccountFieldsData_identity_certIssued_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<GAccountFieldsData_identity_certIssued_nodes_issuer_account>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_nodes_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_nodes_issuer_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_nodes_issuer_account.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_nodes_receiver
    implements
        Built<GAccountFieldsData_identity_certIssued_nodes_receiver,
            GAccountFieldsData_identity_certIssued_nodes_receiverBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver,
        GIdentityFields_certIssued_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certIssued_nodes_receiver._();

  factory GAccountFieldsData_identity_certIssued_nodes_receiver(
      [void Function(
              GAccountFieldsData_identity_certIssued_nodes_receiverBuilder b)
          updates]) = _$GAccountFieldsData_identity_certIssued_nodes_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFieldsData_identity_certIssued_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountFieldsData_identity_certIssued_nodes_receiver>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certIssued_nodes_receiver.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certIssued_nodes_receiver_account
    implements
        Built<GAccountFieldsData_identity_certIssued_nodes_receiver_account,
            GAccountFieldsData_identity_certIssued_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certIssued_nodes_receiver_account,
        GIdentityFields_certIssued_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_identity_certIssued_nodes_receiver_account._();

  factory GAccountFieldsData_identity_certIssued_nodes_receiver_account(
          [void Function(
                  GAccountFieldsData_identity_certIssued_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_certIssued_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certIssued_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountFieldsData_identity_certIssued_nodes_receiver_account>
      get serializer =>
          _$gAccountFieldsDataIdentityCertIssuedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certIssued_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certIssued_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_identity_certIssued_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_identity_certReceived
    implements
        Built<GAccountFieldsData_identity_certReceived,
            GAccountFieldsData_identity_certReceivedBuilder>,
        GAccountFields_identity_certReceived,
        GIdentityFields_certReceived {
  GAccountFieldsData_identity_certReceived._();

  factory GAccountFieldsData_identity_certReceived(
      [void Function(GAccountFieldsData_identity_certReceivedBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceivedBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_certReceived_nodes> get nodes;
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

abstract class GAccountFieldsData_identity_certReceived_nodes
    implements
        Built<GAccountFieldsData_identity_certReceived_nodes,
            GAccountFieldsData_identity_certReceived_nodesBuilder>,
        GAccountFields_identity_certReceived_nodes,
        GIdentityFields_certReceived_nodes,
        GCertFields {
  GAccountFieldsData_identity_certReceived_nodes._();

  factory GAccountFieldsData_identity_certReceived_nodes(
      [void Function(GAccountFieldsData_identity_certReceived_nodesBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get issuerId;
  @override
  GAccountFieldsData_identity_certReceived_nodes_issuer? get issuer;
  @override
  String? get receiverId;
  @override
  GAccountFieldsData_identity_certReceived_nodes_receiver? get receiver;
  @override
  int get createdOn;
  @override
  int get expireOn;
  @override
  bool get isActive;
  @override
  int get updatedOn;
  static Serializer<GAccountFieldsData_identity_certReceived_nodes>
      get serializer => _$gAccountFieldsDataIdentityCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived_nodes_issuer
    implements
        Built<GAccountFieldsData_identity_certReceived_nodes_issuer,
            GAccountFieldsData_identity_certReceived_nodes_issuerBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer,
        GIdentityFields_certReceived_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certReceived_nodes_issuer._();

  factory GAccountFieldsData_identity_certReceived_nodes_issuer(
      [void Function(
              GAccountFieldsData_identity_certReceived_nodes_issuerBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived_nodes_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFieldsData_identity_certReceived_nodes_issuer_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountFieldsData_identity_certReceived_nodes_issuer>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived_nodes_issuer.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived_nodes_issuer_account
    implements
        Built<GAccountFieldsData_identity_certReceived_nodes_issuer_account,
            GAccountFieldsData_identity_certReceived_nodes_issuer_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_issuer_account,
        GIdentityFields_certReceived_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_identity_certReceived_nodes_issuer_account._();

  factory GAccountFieldsData_identity_certReceived_nodes_issuer_account(
          [void Function(
                  GAccountFieldsData_identity_certReceived_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_certReceived_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountFieldsData_identity_certReceived_nodes_issuer_account>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_identity_certReceived_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_identity_certReceived_nodes_receiver
    implements
        Built<GAccountFieldsData_identity_certReceived_nodes_receiver,
            GAccountFieldsData_identity_certReceived_nodes_receiverBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver,
        GIdentityFields_certReceived_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_identity_certReceived_nodes_receiver._();

  factory GAccountFieldsData_identity_certReceived_nodes_receiver(
      [void Function(
              GAccountFieldsData_identity_certReceived_nodes_receiverBuilder b)
          updates]) = _$GAccountFieldsData_identity_certReceived_nodes_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get accountId;
  @override
  GAccountFieldsData_identity_certReceived_nodes_receiver_account? get account;
  @override
  String get id;
  @override
  bool get isMember;
  @override
  String get status;
  @override
  String get name;
  @override
  int get expireOn;
  @override
  int get index;
  static Serializer<GAccountFieldsData_identity_certReceived_nodes_receiver>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_certReceived_nodes_receiver.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_certReceived_nodes_receiver_account
    implements
        Built<GAccountFieldsData_identity_certReceived_nodes_receiver_account,
            GAccountFieldsData_identity_certReceived_nodes_receiver_accountBuilder>,
        GAccountFields_identity_certReceived_nodes_receiver_account,
        GIdentityFields_certReceived_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_identity_certReceived_nodes_receiver_account._();

  factory GAccountFieldsData_identity_certReceived_nodes_receiver_account(
          [void Function(
                  GAccountFieldsData_identity_certReceived_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_identity_certReceived_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountFieldsData_identity_certReceived_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  static Serializer<
          GAccountFieldsData_identity_certReceived_nodes_receiver_account>
      get serializer =>
          _$gAccountFieldsDataIdentityCertReceivedNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_certReceived_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_certReceived_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_identity_certReceived_nodes_receiver_account
                .serializer,
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
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_membershipHistory_nodes> get nodes;
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

abstract class GAccountFieldsData_identity_membershipHistory_nodes
    implements
        Built<GAccountFieldsData_identity_membershipHistory_nodes,
            GAccountFieldsData_identity_membershipHistory_nodesBuilder>,
        GAccountFields_identity_membershipHistory_nodes,
        GIdentityFields_membershipHistory_nodes {
  GAccountFieldsData_identity_membershipHistory_nodes._();

  factory GAccountFieldsData_identity_membershipHistory_nodes(
      [void Function(
              GAccountFieldsData_identity_membershipHistory_nodesBuilder b)
          updates]) = _$GAccountFieldsData_identity_membershipHistory_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_membershipHistory_nodesBuilder b) =>
      b..G__typename = 'MembershipEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  String? get eventId;
  @override
  String get eventType;
  @override
  String get id;
  @override
  String? get identityId;
  static Serializer<GAccountFieldsData_identity_membershipHistory_nodes>
      get serializer =>
          _$gAccountFieldsDataIdentityMembershipHistoryNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_membershipHistory_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_membershipHistory_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_membershipHistory_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_ownerKeyChange
    implements
        Built<GAccountFieldsData_identity_ownerKeyChange,
            GAccountFieldsData_identity_ownerKeyChangeBuilder>,
        GAccountFields_identity_ownerKeyChange,
        GIdentityFields_ownerKeyChange {
  GAccountFieldsData_identity_ownerKeyChange._();

  factory GAccountFieldsData_identity_ownerKeyChange(
      [void Function(GAccountFieldsData_identity_ownerKeyChangeBuilder b)
          updates]) = _$GAccountFieldsData_identity_ownerKeyChange;

  static void _initializeBuilder(
          GAccountFieldsData_identity_ownerKeyChangeBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_ownerKeyChange_nodes> get nodes;
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

abstract class GAccountFieldsData_identity_ownerKeyChange_nodes
    implements
        Built<GAccountFieldsData_identity_ownerKeyChange_nodes,
            GAccountFieldsData_identity_ownerKeyChange_nodesBuilder>,
        GAccountFields_identity_ownerKeyChange_nodes,
        GIdentityFields_ownerKeyChange_nodes,
        GOwnerKeyChangeFields {
  GAccountFieldsData_identity_ownerKeyChange_nodes._();

  factory GAccountFieldsData_identity_ownerKeyChange_nodes(
      [void Function(GAccountFieldsData_identity_ownerKeyChange_nodesBuilder b)
          updates]) = _$GAccountFieldsData_identity_ownerKeyChange_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_ownerKeyChange_nodesBuilder b) =>
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
  static Serializer<GAccountFieldsData_identity_ownerKeyChange_nodes>
      get serializer =>
          _$gAccountFieldsDataIdentityOwnerKeyChangeNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_ownerKeyChange_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_ownerKeyChange_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_ownerKeyChange_nodes.serializer,
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
  GAccountFieldsData_identity_smith_smithCertIssued get smithCertIssued;
  @override
  GAccountFieldsData_identity_smith_smithCertReceived get smithCertReceived;
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
        GSmithFields_smithCertIssued {
  GAccountFieldsData_identity_smith_smithCertIssued._();

  factory GAccountFieldsData_identity_smith_smithCertIssued(
      [void Function(GAccountFieldsData_identity_smith_smithCertIssuedBuilder b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertIssued;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertIssuedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_smith_smithCertIssued_nodes> get nodes;
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

abstract class GAccountFieldsData_identity_smith_smithCertIssued_nodes
    implements
        Built<GAccountFieldsData_identity_smith_smithCertIssued_nodes,
            GAccountFieldsData_identity_smith_smithCertIssued_nodesBuilder>,
        GAccountFields_identity_smith_smithCertIssued_nodes,
        GIdentityFields_smith_smithCertIssued_nodes,
        GSmithFields_smithCertIssued_nodes,
        GSmithCertFields {
  GAccountFieldsData_identity_smith_smithCertIssued_nodes._();

  factory GAccountFieldsData_identity_smith_smithCertIssued_nodes(
      [void Function(
              GAccountFieldsData_identity_smith_smithCertIssued_nodesBuilder b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertIssued_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertIssued_nodesBuilder b) =>
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
  static Serializer<GAccountFieldsData_identity_smith_smithCertIssued_nodes>
      get serializer =>
          _$gAccountFieldsDataIdentitySmithSmithCertIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_smith_smithCertIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_smith_smithCertIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_smith_smithCertIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_identity_smith_smithCertReceived
    implements
        Built<GAccountFieldsData_identity_smith_smithCertReceived,
            GAccountFieldsData_identity_smith_smithCertReceivedBuilder>,
        GAccountFields_identity_smith_smithCertReceived,
        GIdentityFields_smith_smithCertReceived,
        GSmithFields_smithCertReceived {
  GAccountFieldsData_identity_smith_smithCertReceived._();

  factory GAccountFieldsData_identity_smith_smithCertReceived(
      [void Function(
              GAccountFieldsData_identity_smith_smithCertReceivedBuilder b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertReceived;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertReceivedBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  BuiltList<GAccountFieldsData_identity_smith_smithCertReceived_nodes>
      get nodes;
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

abstract class GAccountFieldsData_identity_smith_smithCertReceived_nodes
    implements
        Built<GAccountFieldsData_identity_smith_smithCertReceived_nodes,
            GAccountFieldsData_identity_smith_smithCertReceived_nodesBuilder>,
        GAccountFields_identity_smith_smithCertReceived_nodes,
        GIdentityFields_smith_smithCertReceived_nodes,
        GSmithFields_smithCertReceived_nodes,
        GSmithCertFields {
  GAccountFieldsData_identity_smith_smithCertReceived_nodes._();

  factory GAccountFieldsData_identity_smith_smithCertReceived_nodes(
      [void Function(
              GAccountFieldsData_identity_smith_smithCertReceived_nodesBuilder
                  b)
          updates]) = _$GAccountFieldsData_identity_smith_smithCertReceived_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_identity_smith_smithCertReceived_nodesBuilder b) =>
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
  static Serializer<GAccountFieldsData_identity_smith_smithCertReceived_nodes>
      get serializer =>
          _$gAccountFieldsDataIdentitySmithSmithCertReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_identity_smith_smithCertReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_identity_smith_smithCertReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_identity_smith_smithCertReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountTxsFields {
  String get G__typename;
  int get createdOn;
  String get id;
  _i2.GBigInt get balance;
  _i2.GBigFloat? get totalBalance;
  bool get isActive;
  GAccountTxsFields_comments get comments;
  GAccountTxsFields_transfersIssued get transfersIssued;
  GAccountTxsFields_transfersReceived get transfersReceived;
  GAccountTxsFields_transferWithUd get transferWithUd;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_comments {
  String get G__typename;
  int get totalCount;
  GAccountTxsFields_comments_pageInfo get pageInfo;
  BuiltList<GAccountTxsFields_comments_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_comments_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_comments_nodes implements GCommentsIssued {
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
  String get remarkBytes;
  @override
  String get type;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued {
  String get G__typename;
  int get totalCount;
  GAccountTxsFields_transfersIssued_pageInfo get pageInfo;
  BuiltList<GAccountTxsFields_transfersIssued_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued_nodes
    implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTxsFields_transfersIssued_nodes_to? get to;
  @override
  GAccountTxsFields_transfersIssued_nodes_from? get from;
  @override
  GAccountTxsFields_transfersIssued_nodes_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued_nodes_to
    implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued_nodes_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersIssued_nodes_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived {
  String get G__typename;
  int get totalCount;
  GAccountTxsFields_transfersReceived_pageInfo get pageInfo;
  BuiltList<GAccountTxsFields_transfersReceived_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived_nodes
    implements GTransferFields {
  @override
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTxsFields_transfersReceived_nodes_to? get to;
  @override
  GAccountTxsFields_transfersReceived_nodes_from? get from;
  @override
  GAccountTxsFields_transfersReceived_nodes_comment? get comment;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived_nodes_to
    implements GTransferFields_to {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived_nodes_from
    implements GTransferFields_from {
  @override
  String get G__typename;
  @override
  String get id;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transfersReceived_nodes_comment
    implements GTransferFields_comment {
  @override
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transferWithUd {
  String get G__typename;
  int get totalCount;
  GAccountTxsFields_transferWithUd_pageInfo get pageInfo;
  BuiltList<GAccountTxsFields_transferWithUd_nodes> get nodes;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transferWithUd_pageInfo {
  String get G__typename;
  bool get hasNextPage;
  _i2.GCursor? get endCursor;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFields_transferWithUd_nodes {
  String get G__typename;
  _i2.GDatetime? get timestamp;
  _i2.GBigInt? get amount;
  Map<String, dynamic> toJson();
}

abstract class GAccountTxsFieldsData
    implements
        Built<GAccountTxsFieldsData, GAccountTxsFieldsDataBuilder>,
        GAccountTxsFields {
  GAccountTxsFieldsData._();

  factory GAccountTxsFieldsData(
          [void Function(GAccountTxsFieldsDataBuilder b) updates]) =
      _$GAccountTxsFieldsData;

  static void _initializeBuilder(GAccountTxsFieldsDataBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get createdOn;
  @override
  String get id;
  @override
  _i2.GBigInt get balance;
  @override
  _i2.GBigFloat? get totalBalance;
  @override
  bool get isActive;
  @override
  GAccountTxsFieldsData_comments get comments;
  @override
  GAccountTxsFieldsData_transfersIssued get transfersIssued;
  @override
  GAccountTxsFieldsData_transfersReceived get transfersReceived;
  @override
  GAccountTxsFieldsData_transferWithUd get transferWithUd;
  static Serializer<GAccountTxsFieldsData> get serializer =>
      _$gAccountTxsFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_comments
    implements
        Built<GAccountTxsFieldsData_comments,
            GAccountTxsFieldsData_commentsBuilder>,
        GAccountTxsFields_comments {
  GAccountTxsFieldsData_comments._();

  factory GAccountTxsFieldsData_comments(
          [void Function(GAccountTxsFieldsData_commentsBuilder b) updates]) =
      _$GAccountTxsFieldsData_comments;

  static void _initializeBuilder(GAccountTxsFieldsData_commentsBuilder b) =>
      b..G__typename = 'TxCommentsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTxsFieldsData_comments_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTxsFieldsData_comments_nodes> get nodes;
  static Serializer<GAccountTxsFieldsData_comments> get serializer =>
      _$gAccountTxsFieldsDataCommentsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_comments.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_comments? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_comments.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_comments_pageInfo
    implements
        Built<GAccountTxsFieldsData_comments_pageInfo,
            GAccountTxsFieldsData_comments_pageInfoBuilder>,
        GAccountTxsFields_comments_pageInfo {
  GAccountTxsFieldsData_comments_pageInfo._();

  factory GAccountTxsFieldsData_comments_pageInfo(
      [void Function(GAccountTxsFieldsData_comments_pageInfoBuilder b)
          updates]) = _$GAccountTxsFieldsData_comments_pageInfo;

  static void _initializeBuilder(
          GAccountTxsFieldsData_comments_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountTxsFieldsData_comments_pageInfo> get serializer =>
      _$gAccountTxsFieldsDataCommentsPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_comments_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_comments_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_comments_pageInfo.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_comments_nodes
    implements
        Built<GAccountTxsFieldsData_comments_nodes,
            GAccountTxsFieldsData_comments_nodesBuilder>,
        GAccountTxsFields_comments_nodes,
        GCommentsIssued {
  GAccountTxsFieldsData_comments_nodes._();

  factory GAccountTxsFieldsData_comments_nodes(
      [void Function(GAccountTxsFieldsData_comments_nodesBuilder b)
          updates]) = _$GAccountTxsFieldsData_comments_nodes;

  static void _initializeBuilder(
          GAccountTxsFieldsData_comments_nodesBuilder b) =>
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
  String get remarkBytes;
  @override
  String get type;
  static Serializer<GAccountTxsFieldsData_comments_nodes> get serializer =>
      _$gAccountTxsFieldsDataCommentsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_comments_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_comments_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_comments_nodes.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued
    implements
        Built<GAccountTxsFieldsData_transfersIssued,
            GAccountTxsFieldsData_transfersIssuedBuilder>,
        GAccountTxsFields_transfersIssued {
  GAccountTxsFieldsData_transfersIssued._();

  factory GAccountTxsFieldsData_transfersIssued(
      [void Function(GAccountTxsFieldsData_transfersIssuedBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssuedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTxsFieldsData_transfersIssued_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTxsFieldsData_transfersIssued_nodes> get nodes;
  static Serializer<GAccountTxsFieldsData_transfersIssued> get serializer =>
      _$gAccountTxsFieldsDataTransfersIssuedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued_pageInfo
    implements
        Built<GAccountTxsFieldsData_transfersIssued_pageInfo,
            GAccountTxsFieldsData_transfersIssued_pageInfoBuilder>,
        GAccountTxsFields_transfersIssued_pageInfo {
  GAccountTxsFieldsData_transfersIssued_pageInfo._();

  factory GAccountTxsFieldsData_transfersIssued_pageInfo(
      [void Function(GAccountTxsFieldsData_transfersIssued_pageInfoBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued_pageInfo;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssued_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountTxsFieldsData_transfersIssued_pageInfo>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersIssuedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued_pageInfo.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued_nodes
    implements
        Built<GAccountTxsFieldsData_transfersIssued_nodes,
            GAccountTxsFieldsData_transfersIssued_nodesBuilder>,
        GAccountTxsFields_transfersIssued_nodes,
        GTransferFields {
  GAccountTxsFieldsData_transfersIssued_nodes._();

  factory GAccountTxsFieldsData_transfersIssued_nodes(
      [void Function(GAccountTxsFieldsData_transfersIssued_nodesBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued_nodes;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssued_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTxsFieldsData_transfersIssued_nodes_to? get to;
  @override
  GAccountTxsFieldsData_transfersIssued_nodes_from? get from;
  @override
  GAccountTxsFieldsData_transfersIssued_nodes_comment? get comment;
  static Serializer<GAccountTxsFieldsData_transfersIssued_nodes>
      get serializer => _$gAccountTxsFieldsDataTransfersIssuedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued_nodes_to
    implements
        Built<GAccountTxsFieldsData_transfersIssued_nodes_to,
            GAccountTxsFieldsData_transfersIssued_nodes_toBuilder>,
        GAccountTxsFields_transfersIssued_nodes_to,
        GTransferFields_to {
  GAccountTxsFieldsData_transfersIssued_nodes_to._();

  factory GAccountTxsFieldsData_transfersIssued_nodes_to(
      [void Function(GAccountTxsFieldsData_transfersIssued_nodes_toBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued_nodes_to;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssued_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountTxsFieldsData_transfersIssued_nodes_to>
      get serializer => _$gAccountTxsFieldsDataTransfersIssuedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_to.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued_nodes_from
    implements
        Built<GAccountTxsFieldsData_transfersIssued_nodes_from,
            GAccountTxsFieldsData_transfersIssued_nodes_fromBuilder>,
        GAccountTxsFields_transfersIssued_nodes_from,
        GTransferFields_from {
  GAccountTxsFieldsData_transfersIssued_nodes_from._();

  factory GAccountTxsFieldsData_transfersIssued_nodes_from(
      [void Function(GAccountTxsFieldsData_transfersIssued_nodes_fromBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued_nodes_from;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssued_nodes_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountTxsFieldsData_transfersIssued_nodes_from>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersIssuedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_from.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersIssued_nodes_comment
    implements
        Built<GAccountTxsFieldsData_transfersIssued_nodes_comment,
            GAccountTxsFieldsData_transfersIssued_nodes_commentBuilder>,
        GAccountTxsFields_transfersIssued_nodes_comment,
        GTransferFields_comment {
  GAccountTxsFieldsData_transfersIssued_nodes_comment._();

  factory GAccountTxsFieldsData_transfersIssued_nodes_comment(
      [void Function(
              GAccountTxsFieldsData_transfersIssued_nodes_commentBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersIssued_nodes_comment;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersIssued_nodes_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<GAccountTxsFieldsData_transfersIssued_nodes_comment>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersIssuedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersIssued_nodes_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersIssued_nodes_comment.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived
    implements
        Built<GAccountTxsFieldsData_transfersReceived,
            GAccountTxsFieldsData_transfersReceivedBuilder>,
        GAccountTxsFields_transfersReceived {
  GAccountTxsFieldsData_transfersReceived._();

  factory GAccountTxsFieldsData_transfersReceived(
      [void Function(GAccountTxsFieldsData_transfersReceivedBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceivedBuilder b) =>
      b..G__typename = 'TransfersConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTxsFieldsData_transfersReceived_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTxsFieldsData_transfersReceived_nodes> get nodes;
  static Serializer<GAccountTxsFieldsData_transfersReceived> get serializer =>
      _$gAccountTxsFieldsDataTransfersReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived_pageInfo
    implements
        Built<GAccountTxsFieldsData_transfersReceived_pageInfo,
            GAccountTxsFieldsData_transfersReceived_pageInfoBuilder>,
        GAccountTxsFields_transfersReceived_pageInfo {
  GAccountTxsFieldsData_transfersReceived_pageInfo._();

  factory GAccountTxsFieldsData_transfersReceived_pageInfo(
      [void Function(GAccountTxsFieldsData_transfersReceived_pageInfoBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived_pageInfo;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceived_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountTxsFieldsData_transfersReceived_pageInfo>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersReceivedPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived_pageInfo.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived_nodes
    implements
        Built<GAccountTxsFieldsData_transfersReceived_nodes,
            GAccountTxsFieldsData_transfersReceived_nodesBuilder>,
        GAccountTxsFields_transfersReceived_nodes,
        GTransferFields {
  GAccountTxsFieldsData_transfersReceived_nodes._();

  factory GAccountTxsFieldsData_transfersReceived_nodes(
      [void Function(GAccountTxsFieldsData_transfersReceived_nodesBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived_nodes;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceived_nodesBuilder b) =>
      b..G__typename = 'Transfer';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get blockNumber;
  @override
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
  @override
  GAccountTxsFieldsData_transfersReceived_nodes_to? get to;
  @override
  GAccountTxsFieldsData_transfersReceived_nodes_from? get from;
  @override
  GAccountTxsFieldsData_transfersReceived_nodes_comment? get comment;
  static Serializer<GAccountTxsFieldsData_transfersReceived_nodes>
      get serializer => _$gAccountTxsFieldsDataTransfersReceivedNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived_nodes_to
    implements
        Built<GAccountTxsFieldsData_transfersReceived_nodes_to,
            GAccountTxsFieldsData_transfersReceived_nodes_toBuilder>,
        GAccountTxsFields_transfersReceived_nodes_to,
        GTransferFields_to {
  GAccountTxsFieldsData_transfersReceived_nodes_to._();

  factory GAccountTxsFieldsData_transfersReceived_nodes_to(
      [void Function(GAccountTxsFieldsData_transfersReceived_nodes_toBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived_nodes_to;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceived_nodes_toBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountTxsFieldsData_transfersReceived_nodes_to>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersReceivedNodesToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_to.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived_nodes_to? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_to.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived_nodes_from
    implements
        Built<GAccountTxsFieldsData_transfersReceived_nodes_from,
            GAccountTxsFieldsData_transfersReceived_nodes_fromBuilder>,
        GAccountTxsFields_transfersReceived_nodes_from,
        GTransferFields_from {
  GAccountTxsFieldsData_transfersReceived_nodes_from._();

  factory GAccountTxsFieldsData_transfersReceived_nodes_from(
      [void Function(
              GAccountTxsFieldsData_transfersReceived_nodes_fromBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived_nodes_from;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceived_nodes_fromBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  static Serializer<GAccountTxsFieldsData_transfersReceived_nodes_from>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersReceivedNodesFromSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_from.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived_nodes_from? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_from.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transfersReceived_nodes_comment
    implements
        Built<GAccountTxsFieldsData_transfersReceived_nodes_comment,
            GAccountTxsFieldsData_transfersReceived_nodes_commentBuilder>,
        GAccountTxsFields_transfersReceived_nodes_comment,
        GTransferFields_comment {
  GAccountTxsFieldsData_transfersReceived_nodes_comment._();

  factory GAccountTxsFieldsData_transfersReceived_nodes_comment(
      [void Function(
              GAccountTxsFieldsData_transfersReceived_nodes_commentBuilder b)
          updates]) = _$GAccountTxsFieldsData_transfersReceived_nodes_comment;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transfersReceived_nodes_commentBuilder b) =>
      b..G__typename = 'TxComment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get remark;
  @override
  String get remarkBytes;
  static Serializer<GAccountTxsFieldsData_transfersReceived_nodes_comment>
      get serializer =>
          _$gAccountTxsFieldsDataTransfersReceivedNodesCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_comment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transfersReceived_nodes_comment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transfersReceived_nodes_comment.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transferWithUd
    implements
        Built<GAccountTxsFieldsData_transferWithUd,
            GAccountTxsFieldsData_transferWithUdBuilder>,
        GAccountTxsFields_transferWithUd {
  GAccountTxsFieldsData_transferWithUd._();

  factory GAccountTxsFieldsData_transferWithUd(
      [void Function(GAccountTxsFieldsData_transferWithUdBuilder b)
          updates]) = _$GAccountTxsFieldsData_transferWithUd;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transferWithUdBuilder b) =>
      b..G__typename = 'TransferWithUdsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  int get totalCount;
  @override
  GAccountTxsFieldsData_transferWithUd_pageInfo get pageInfo;
  @override
  BuiltList<GAccountTxsFieldsData_transferWithUd_nodes> get nodes;
  static Serializer<GAccountTxsFieldsData_transferWithUd> get serializer =>
      _$gAccountTxsFieldsDataTransferWithUdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transferWithUd.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transferWithUd? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transferWithUd.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transferWithUd_pageInfo
    implements
        Built<GAccountTxsFieldsData_transferWithUd_pageInfo,
            GAccountTxsFieldsData_transferWithUd_pageInfoBuilder>,
        GAccountTxsFields_transferWithUd_pageInfo {
  GAccountTxsFieldsData_transferWithUd_pageInfo._();

  factory GAccountTxsFieldsData_transferWithUd_pageInfo(
      [void Function(GAccountTxsFieldsData_transferWithUd_pageInfoBuilder b)
          updates]) = _$GAccountTxsFieldsData_transferWithUd_pageInfo;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transferWithUd_pageInfoBuilder b) =>
      b..G__typename = 'PageInfo';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  bool get hasNextPage;
  @override
  _i2.GCursor? get endCursor;
  static Serializer<GAccountTxsFieldsData_transferWithUd_pageInfo>
      get serializer => _$gAccountTxsFieldsDataTransferWithUdPageInfoSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transferWithUd_pageInfo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transferWithUd_pageInfo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transferWithUd_pageInfo.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsData_transferWithUd_nodes
    implements
        Built<GAccountTxsFieldsData_transferWithUd_nodes,
            GAccountTxsFieldsData_transferWithUd_nodesBuilder>,
        GAccountTxsFields_transferWithUd_nodes {
  GAccountTxsFieldsData_transferWithUd_nodes._();

  factory GAccountTxsFieldsData_transferWithUd_nodes(
      [void Function(GAccountTxsFieldsData_transferWithUd_nodesBuilder b)
          updates]) = _$GAccountTxsFieldsData_transferWithUd_nodes;

  static void _initializeBuilder(
          GAccountTxsFieldsData_transferWithUd_nodesBuilder b) =>
      b..G__typename = 'TransferWithUd';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  _i2.GDatetime? get timestamp;
  @override
  _i2.GBigInt? get amount;
  static Serializer<GAccountTxsFieldsData_transferWithUd_nodes>
      get serializer => _$gAccountTxsFieldsDataTransferWithUdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsData_transferWithUd_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsData_transferWithUd_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsData_transferWithUd_nodes.serializer,
        json,
      );
}

abstract class GTransferFields {
  String get G__typename;
  int get blockNumber;
  _i2.GDatetime get timestamp;
  _i2.GBigInt get amount;
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
  String get remarkBytes;
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
  _i2.GDatetime get timestamp;
  @override
  _i2.GBigInt get amount;
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
  @override
  String get remarkBytes;
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
