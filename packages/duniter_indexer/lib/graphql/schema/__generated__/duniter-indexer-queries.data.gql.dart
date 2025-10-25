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
  GIdentitiesByPkData_identities_nodes_certsByIssuerId get certsByIssuerId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByReceiverId get certsByReceiverId;

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
  GIdentitiesByPkData_identities_nodes_membershipEvents get membershipEvents;

  @override
  GIdentitiesByPkData_identities_nodes_changeOwnerKeys get changeOwnerKeys;

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

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId
    implements
        Built<GIdentitiesByPkData_identities_nodes_certsByIssuerId,
            GIdentitiesByPkData_identities_nodes_certsByIssuerIdBuilder>,
        GIdentityFields_certsByIssuerId {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId(
      [void Function(
              GIdentitiesByPkData_identities_nodes_certsByIssuerIdBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certsByIssuerId;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes>
      get nodes;

  static Serializer<GIdentitiesByPkData_identities_nodes_certsByIssuerId>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes,
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodesBuilder>,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodesBuilder
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
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver?
      get receiver;

  @override
  int get createdOn;

  @override
  int get expireOn;

  @override
  bool get isActive;

  @override
  int get updatedOn;

  static Serializer<GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer
    implements
        Built<GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer,
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuerBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account?
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
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account,
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver,
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiverBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account?
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
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account,
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account._();

  factory GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId
    implements
        Built<GIdentitiesByPkData_identities_nodes_certsByReceiverId,
            GIdentitiesByPkData_identities_nodes_certsByReceiverIdBuilder>,
        GIdentityFields_certsByReceiverId {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId(
      [void Function(
              GIdentitiesByPkData_identities_nodes_certsByReceiverIdBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_certsByReceiverId;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes>
      get nodes;

  static Serializer<GIdentitiesByPkData_identities_nodes_certsByReceiverId>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes,
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodesBuilder>,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodesBuilder
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
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver?
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
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer,
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuerBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account?
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
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account,
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver,
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiverBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account?
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
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account,
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account._();

  factory GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_membershipEvents
    implements
        Built<GIdentitiesByPkData_identities_nodes_membershipEvents,
            GIdentitiesByPkData_identities_nodes_membershipEventsBuilder>,
        GIdentityFields_membershipEvents {
  GIdentitiesByPkData_identities_nodes_membershipEvents._();

  factory GIdentitiesByPkData_identities_nodes_membershipEvents(
      [void Function(
              GIdentitiesByPkData_identities_nodes_membershipEventsBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_membershipEvents;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_membershipEventsBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_membershipEvents_nodes>
      get nodes;

  static Serializer<GIdentitiesByPkData_identities_nodes_membershipEvents>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_membershipEvents.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_membershipEvents? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_membershipEvents.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_membershipEvents_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_membershipEvents_nodes,
            GIdentitiesByPkData_identities_nodes_membershipEvents_nodesBuilder>,
        GIdentityFields_membershipEvents_nodes {
  GIdentitiesByPkData_identities_nodes_membershipEvents_nodes._();

  factory GIdentitiesByPkData_identities_nodes_membershipEvents_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_membershipEvents_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_membershipEvents_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_membershipEvents_nodesBuilder
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

  static Serializer<GIdentitiesByPkData_identities_nodes_membershipEvents_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_membershipEvents_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_membershipEvents_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_membershipEvents_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_changeOwnerKeys
    implements
        Built<GIdentitiesByPkData_identities_nodes_changeOwnerKeys,
            GIdentitiesByPkData_identities_nodes_changeOwnerKeysBuilder>,
        GIdentityFields_changeOwnerKeys {
  GIdentitiesByPkData_identities_nodes_changeOwnerKeys._();

  factory GIdentitiesByPkData_identities_nodes_changeOwnerKeys(
      [void Function(
              GIdentitiesByPkData_identities_nodes_changeOwnerKeysBuilder b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_changeOwnerKeys;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_changeOwnerKeysBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes>
      get nodes;

  static Serializer<GIdentitiesByPkData_identities_nodes_changeOwnerKeys>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_changeOwnerKeys.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_changeOwnerKeys? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_changeOwnerKeys.serializer,
        json,
      );
}

abstract class GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes
    implements
        Built<GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes,
            GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodesBuilder>,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes._();

  factory GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes(
      [void Function(
              GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodesBuilder
                  b)
          updates]) = _$GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodesBuilder
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

  static Serializer<GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkData_identities_nodes_changeOwnerKeys_nodes.serializer,
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
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

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

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId,
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerIdBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerIdBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes,
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder
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
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId
    implements
        Built<GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId,
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverIdBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverIdBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId
                .serializer,
            json,
          );
}

abstract class GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes
    implements
        Built<
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes,
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes._();

  factory GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes(
          [void Function(
                  GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder
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
          GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gIdentitiesByPkDataIdentitiesNodesSmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByPkData_identities_nodes_smith_smithCertsByReceiverId_nodes
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
  GIdentitiesByNameData_identities_nodes_certsByIssuerId get certsByIssuerId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByReceiverId
      get certsByReceiverId;

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
  GIdentitiesByNameData_identities_nodes_membershipEvents get membershipEvents;

  @override
  GIdentitiesByNameData_identities_nodes_changeOwnerKeys get changeOwnerKeys;

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

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId
    implements
        Built<GIdentitiesByNameData_identities_nodes_certsByIssuerId,
            GIdentitiesByNameData_identities_nodes_certsByIssuerIdBuilder>,
        GIdentityFields_certsByIssuerId {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId(
      [void Function(
              GIdentitiesByNameData_identities_nodes_certsByIssuerIdBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certsByIssuerId;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes>
      get nodes;

  static Serializer<GIdentitiesByNameData_identities_nodes_certsByIssuerId>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes,
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodesBuilder>,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodesBuilder
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
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver?
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
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer,
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuerBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account?
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
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account,
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver,
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiverBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account?
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
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account,
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account._();

  factory GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByIssuerId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId
    implements
        Built<GIdentitiesByNameData_identities_nodes_certsByReceiverId,
            GIdentitiesByNameData_identities_nodes_certsByReceiverIdBuilder>,
        GIdentityFields_certsByReceiverId {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId(
      [void Function(
              GIdentitiesByNameData_identities_nodes_certsByReceiverIdBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_certsByReceiverId;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes>
      get nodes;

  static Serializer<GIdentitiesByNameData_identities_nodes_certsByReceiverId>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes,
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodesBuilder>,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodesBuilder
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
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver?
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
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer,
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuerBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account?
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
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account,
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver,
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiverBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account?
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
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account,
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account._();

  factory GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_certsByReceiverId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_membershipEvents
    implements
        Built<GIdentitiesByNameData_identities_nodes_membershipEvents,
            GIdentitiesByNameData_identities_nodes_membershipEventsBuilder>,
        GIdentityFields_membershipEvents {
  GIdentitiesByNameData_identities_nodes_membershipEvents._();

  factory GIdentitiesByNameData_identities_nodes_membershipEvents(
      [void Function(
              GIdentitiesByNameData_identities_nodes_membershipEventsBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_membershipEvents;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_membershipEventsBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_membershipEvents_nodes>
      get nodes;

  static Serializer<GIdentitiesByNameData_identities_nodes_membershipEvents>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_membershipEvents.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_membershipEvents? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_membershipEvents.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_membershipEvents_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_membershipEvents_nodes,
            GIdentitiesByNameData_identities_nodes_membershipEvents_nodesBuilder>,
        GIdentityFields_membershipEvents_nodes {
  GIdentitiesByNameData_identities_nodes_membershipEvents_nodes._();

  factory GIdentitiesByNameData_identities_nodes_membershipEvents_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_membershipEvents_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_membershipEvents_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_membershipEvents_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_membershipEvents_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_membershipEvents_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_membershipEvents_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_membershipEvents_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_changeOwnerKeys
    implements
        Built<GIdentitiesByNameData_identities_nodes_changeOwnerKeys,
            GIdentitiesByNameData_identities_nodes_changeOwnerKeysBuilder>,
        GIdentityFields_changeOwnerKeys {
  GIdentitiesByNameData_identities_nodes_changeOwnerKeys._();

  factory GIdentitiesByNameData_identities_nodes_changeOwnerKeys(
      [void Function(
              GIdentitiesByNameData_identities_nodes_changeOwnerKeysBuilder b)
          updates]) = _$GIdentitiesByNameData_identities_nodes_changeOwnerKeys;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_changeOwnerKeysBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes>
      get nodes;

  static Serializer<GIdentitiesByNameData_identities_nodes_changeOwnerKeys>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_changeOwnerKeys.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_changeOwnerKeys? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_changeOwnerKeys.serializer,
        json,
      );
}

abstract class GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes
    implements
        Built<GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes,
            GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodesBuilder>,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes._();

  factory GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameData_identities_nodes_changeOwnerKeys_nodes.serializer,
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
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

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

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId
    implements
        Built<GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId,
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerIdBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerIdBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes,
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId,
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverIdBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverIdBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId
                .serializer,
            json,
          );
}

abstract class GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes
    implements
        Built<
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes,
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes._();

  factory GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes(
          [void Function(
                  GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodesBuilder
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
          GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gIdentitiesByNameDataIdentitiesNodesSmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GIdentitiesByNameData_identities_nodes_smith_smithCertsByReceiverId_nodes
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
  _i2.GBigFloat get balance;

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
  GAccountByPkData_accounts_nodes_linkedIdentity? get linkedIdentity;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

abstract class GAccountByPkData_accounts_nodes_linkedIdentity
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity,
            GAccountByPkData_accounts_nodes_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityFields {
  GAccountByPkData_accounts_nodes_linkedIdentity._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity(
      [void Function(GAccountByPkData_accounts_nodes_linkedIdentityBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_linkedIdentity;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_account? get account;

  @override
  String? get accountId;

  @override
  String? get accountRemovedId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
      get certsByIssuerId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
      get certsByReceiverId;

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
  GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents
      get membershipEvents;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
      get changeOwnerKeys;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_smith? get smith;

  static Serializer<GAccountByPkData_accounts_nodes_linkedIdentity>
      get serializer => _$gAccountByPkDataAccountsNodesLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_account
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_account,
            GAccountByPkData_accounts_nodes_linkedIdentity_accountBuilder>,
        GAccountFields_linkedIdentity_account,
        GIdentityFields_account {
  GAccountByPkData_accounts_nodes_linkedIdentity_account._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_account(
      [void Function(
              GAccountByPkData_accounts_nodes_linkedIdentity_accountBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GAccountByPkData_accounts_nodes_linkedIdentity_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_account.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId,
        GIdentityFields_certsByIssuerId {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder
              b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder
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
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer_account,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver_account,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId,
        GIdentityFields_certsByReceiverId {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder
              b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder
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
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer_account,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account?
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
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account,
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver_account,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents,
            GAccountByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder>,
        GAccountFields_linkedIdentity_membershipEvents,
        GIdentityFields_membershipEvents {
  GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder
              b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder>,
        GAccountFields_linkedIdentity_membershipEvents_nodes,
        GIdentityFields_membershipEvents_nodes {
  GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder
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
          GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys,
            GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys,
        GIdentityFields_changeOwnerKeys {
  GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys_nodes,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder
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
          GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentityChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_smith
    implements
        Built<GAccountByPkData_accounts_nodes_linkedIdentity_smith,
            GAccountByPkData_accounts_nodes_linkedIdentity_smithBuilder>,
        GAccountFields_linkedIdentity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_smith._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_smith(
      [void Function(
              GAccountByPkData_accounts_nodes_linkedIdentity_smithBuilder b)
          updates]) = _$GAccountByPkData_accounts_nodes_linkedIdentity_smith;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_smithBuilder b) =>
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
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

  static Serializer<GAccountByPkData_accounts_nodes_linkedIdentity_smith>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith.serializer,
        json,
      );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId,
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId_nodes,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
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
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId,
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
                .serializer,
            json,
          );
}

abstract class GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
    implements
        Built<
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes,
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId_nodes,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes._();

  factory GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes(
          [void Function(
                  GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
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
          GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gAccountByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
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
  _i2.GBigFloat get balance;

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
  GAccountsByPkData_accounts_nodes_linkedIdentity? get linkedIdentity;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity,
            GAccountsByPkData_accounts_nodes_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity(
      [void Function(GAccountsByPkData_accounts_nodes_linkedIdentityBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_linkedIdentity;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_account? get account;

  @override
  String? get accountId;

  @override
  String? get accountRemovedId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
      get certsByIssuerId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
      get certsByReceiverId;

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
  GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents
      get membershipEvents;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
      get changeOwnerKeys;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith? get smith;

  static Serializer<GAccountsByPkData_accounts_nodes_linkedIdentity>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_account
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_account,
            GAccountsByPkData_accounts_nodes_linkedIdentity_accountBuilder>,
        GAccountFields_linkedIdentity_account,
        GIdentityFields_account {
  GAccountsByPkData_accounts_nodes_linkedIdentity_account._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_account(
      [void Function(
              GAccountsByPkData_accounts_nodes_linkedIdentity_accountBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GAccountsByPkData_accounts_nodes_linkedIdentity_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_account.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId,
        GIdentityFields_certsByIssuerId {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerIdBuilder
              b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodesBuilder
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
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer_account,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver_account,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId,
        GIdentityFields_certsByReceiverId {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverIdBuilder
              b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodesBuilder
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
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer?
      get issuer;

  @override
  String? get receiverId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer_account,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account?
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account,
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver_account,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents,
            GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder>,
        GAccountFields_linkedIdentity_membershipEvents,
        GIdentityFields_membershipEvents {
  GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEventsBuilder
              b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder>,
        GAccountFields_linkedIdentity_membershipEvents_nodes,
        GIdentityFields_membershipEvents_nodes {
  GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_membershipEvents_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys,
            GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys,
        GIdentityFields_changeOwnerKeys {
  GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeysBuilder
              b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys_nodes,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentityChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_changeOwnerKeys_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_smith
    implements
        Built<GAccountsByPkData_accounts_nodes_linkedIdentity_smith,
            GAccountsByPkData_accounts_nodes_linkedIdentity_smithBuilder>,
        GAccountFields_linkedIdentity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_smith(
      [void Function(
              GAccountsByPkData_accounts_nodes_linkedIdentity_smithBuilder b)
          updates]) = _$GAccountsByPkData_accounts_nodes_linkedIdentity_smith;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_smithBuilder b) =>
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
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

  static Serializer<GAccountsByPkData_accounts_nodes_linkedIdentity_smith>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith.serializer,
        json,
      );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId,
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId_nodes,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId,
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId
                .serializer,
            json,
          );
}

abstract class GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
    implements
        Built<
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes,
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId_nodes,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes._();

  factory GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes(
          [void Function(
                  GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
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
          GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gAccountsByPkDataAccountsNodesLinkedIdentitySmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountsByPkData_accounts_nodes_linkedIdentity_smith_smithCertsByReceiverId_nodes
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
  _i2.GBigFloat get balance;

  @override
  _i2.GBigFloat? get totalBalance;

  @override
  GAccountBasicByPkData_accounts_nodes_linkedIdentity? get linkedIdentity;

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

abstract class GAccountBasicByPkData_accounts_nodes_linkedIdentity
    implements
        Built<GAccountBasicByPkData_accounts_nodes_linkedIdentity,
            GAccountBasicByPkData_accounts_nodes_linkedIdentityBuilder>,
        GAccountBasicFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountBasicByPkData_accounts_nodes_linkedIdentity._();

  factory GAccountBasicByPkData_accounts_nodes_linkedIdentity(
      [void Function(
              GAccountBasicByPkData_accounts_nodes_linkedIdentityBuilder b)
          updates]) = _$GAccountBasicByPkData_accounts_nodes_linkedIdentity;

  static void _initializeBuilder(
          GAccountBasicByPkData_accounts_nodes_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountBasicByPkData_accounts_nodes_linkedIdentity_account? get account;

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

  static Serializer<GAccountBasicByPkData_accounts_nodes_linkedIdentity>
      get serializer =>
          _$gAccountBasicByPkDataAccountsNodesLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts_nodes_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts_nodes_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts_nodes_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountBasicByPkData_accounts_nodes_linkedIdentity_account
    implements
        Built<GAccountBasicByPkData_accounts_nodes_linkedIdentity_account,
            GAccountBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder>,
        GAccountBasicFields_linkedIdentity_account,
        GIdentityBasicFields_account {
  GAccountBasicByPkData_accounts_nodes_linkedIdentity_account._();

  factory GAccountBasicByPkData_accounts_nodes_linkedIdentity_account(
      [void Function(
              GAccountBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder
                  b)
          updates]) = _$GAccountBasicByPkData_accounts_nodes_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GAccountBasicByPkData_accounts_nodes_linkedIdentity_account>
      get serializer =>
          _$gAccountBasicByPkDataAccountsNodesLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkData_accounts_nodes_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkData_accounts_nodes_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkData_accounts_nodes_linkedIdentity_account.serializer,
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
  _i2.GBigFloat get balance;

  @override
  _i2.GBigFloat? get totalBalance;

  @override
  GAccountsBasicByPkData_accounts_nodes_linkedIdentity? get linkedIdentity;

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

abstract class GAccountsBasicByPkData_accounts_nodes_linkedIdentity
    implements
        Built<GAccountsBasicByPkData_accounts_nodes_linkedIdentity,
            GAccountsBasicByPkData_accounts_nodes_linkedIdentityBuilder>,
        GAccountBasicFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountsBasicByPkData_accounts_nodes_linkedIdentity._();

  factory GAccountsBasicByPkData_accounts_nodes_linkedIdentity(
      [void Function(
              GAccountsBasicByPkData_accounts_nodes_linkedIdentityBuilder b)
          updates]) = _$GAccountsBasicByPkData_accounts_nodes_linkedIdentity;

  static void _initializeBuilder(
          GAccountsBasicByPkData_accounts_nodes_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account? get account;

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

  static Serializer<GAccountsBasicByPkData_accounts_nodes_linkedIdentity>
      get serializer =>
          _$gAccountsBasicByPkDataAccountsNodesLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts_nodes_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts_nodes_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts_nodes_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account
    implements
        Built<GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account,
            GAccountsBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder>,
        GAccountBasicFields_linkedIdentity_account,
        GIdentityBasicFields_account {
  GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account._();

  factory GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account(
          [void Function(
                  GAccountsBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder
                      b)
              updates]) =
      _$GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountsBasicByPkData_accounts_nodes_linkedIdentity_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account>
      get serializer =>
          _$gAccountsBasicByPkDataAccountsNodesLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkData_accounts_nodes_linkedIdentity_account.serializer,
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
  _i2.GBigFloat get balance;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

  GSmithFields_smithCertsByIssuerId get smithCertsByIssuerId;

  GSmithFields_smithCertsByReceiverId get smithCertsByReceiverId;

  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertsByIssuerId {
  String get G__typename;

  int get totalCount;

  BuiltList<GSmithFields_smithCertsByIssuerId_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertsByIssuerId_nodes
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

abstract class GSmithFields_smithCertsByReceiverId {
  String get G__typename;

  int get totalCount;

  BuiltList<GSmithFields_smithCertsByReceiverId_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GSmithFields_smithCertsByReceiverId_nodes
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
  GSmithFieldsData_smithCertsByIssuerId get smithCertsByIssuerId;

  @override
  GSmithFieldsData_smithCertsByReceiverId get smithCertsByReceiverId;

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

abstract class GSmithFieldsData_smithCertsByIssuerId
    implements
        Built<GSmithFieldsData_smithCertsByIssuerId,
            GSmithFieldsData_smithCertsByIssuerIdBuilder>,
        GSmithFields_smithCertsByIssuerId {
  GSmithFieldsData_smithCertsByIssuerId._();

  factory GSmithFieldsData_smithCertsByIssuerId(
      [void Function(GSmithFieldsData_smithCertsByIssuerIdBuilder b)
          updates]) = _$GSmithFieldsData_smithCertsByIssuerId;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertsByIssuerIdBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GSmithFieldsData_smithCertsByIssuerId_nodes> get nodes;

  static Serializer<GSmithFieldsData_smithCertsByIssuerId> get serializer =>
      _$gSmithFieldsDataSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertsByIssuerId.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertsByIssuerId_nodes
    implements
        Built<GSmithFieldsData_smithCertsByIssuerId_nodes,
            GSmithFieldsData_smithCertsByIssuerId_nodesBuilder>,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GSmithFieldsData_smithCertsByIssuerId_nodes._();

  factory GSmithFieldsData_smithCertsByIssuerId_nodes(
      [void Function(GSmithFieldsData_smithCertsByIssuerId_nodesBuilder b)
          updates]) = _$GSmithFieldsData_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertsByIssuerId_nodesBuilder b) =>
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

  static Serializer<GSmithFieldsData_smithCertsByIssuerId_nodes>
      get serializer => _$gSmithFieldsDataSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertsByReceiverId
    implements
        Built<GSmithFieldsData_smithCertsByReceiverId,
            GSmithFieldsData_smithCertsByReceiverIdBuilder>,
        GSmithFields_smithCertsByReceiverId {
  GSmithFieldsData_smithCertsByReceiverId._();

  factory GSmithFieldsData_smithCertsByReceiverId(
      [void Function(GSmithFieldsData_smithCertsByReceiverIdBuilder b)
          updates]) = _$GSmithFieldsData_smithCertsByReceiverId;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertsByReceiverIdBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GSmithFieldsData_smithCertsByReceiverId_nodes> get nodes;

  static Serializer<GSmithFieldsData_smithCertsByReceiverId> get serializer =>
      _$gSmithFieldsDataSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertsByReceiverId.serializer,
        json,
      );
}

abstract class GSmithFieldsData_smithCertsByReceiverId_nodes
    implements
        Built<GSmithFieldsData_smithCertsByReceiverId_nodes,
            GSmithFieldsData_smithCertsByReceiverId_nodesBuilder>,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GSmithFieldsData_smithCertsByReceiverId_nodes._();

  factory GSmithFieldsData_smithCertsByReceiverId_nodes(
      [void Function(GSmithFieldsData_smithCertsByReceiverId_nodesBuilder b)
          updates]) = _$GSmithFieldsData_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GSmithFieldsData_smithCertsByReceiverId_nodesBuilder b) =>
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

  static Serializer<GSmithFieldsData_smithCertsByReceiverId_nodes>
      get serializer => _$gSmithFieldsDataSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsData_smithCertsByReceiverId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsData_smithCertsByReceiverId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsData_smithCertsByReceiverId_nodes.serializer,
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

  GIdentityFields_certsByIssuerId get certsByIssuerId;

  GIdentityFields_certsByReceiverId get certsByReceiverId;

  String? get createdInId;

  int get createdOn;

  int get expireOn;

  String get id;

  int get index;

  bool get isMember;

  int get lastChangeOn;

  String get status;

  String get name;

  GIdentityFields_membershipEvents get membershipEvents;

  GIdentityFields_changeOwnerKeys get changeOwnerKeys;

  GIdentityFields_smith? get smith;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_account {
  String get G__typename;

  int get createdOn;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByIssuerId {
  String get G__typename;

  int get totalCount;

  BuiltList<GIdentityFields_certsByIssuerId_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByIssuerId_nodes implements GCertFields {
  @override
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GIdentityFields_certsByIssuerId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GIdentityFields_certsByIssuerId_nodes_receiver? get receiver;

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

abstract class GIdentityFields_certsByIssuerId_nodes_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFields_certsByIssuerId_nodes_issuer_account? get account;

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

abstract class GIdentityFields_certsByIssuerId_nodes_issuer_account
    implements GCertFields_issuer_account, GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByIssuerId_nodes_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFields_certsByIssuerId_nodes_receiver_account? get account;

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

abstract class GIdentityFields_certsByIssuerId_nodes_receiver_account
    implements GCertFields_receiver_account, GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByReceiverId {
  String get G__typename;

  int get totalCount;

  BuiltList<GIdentityFields_certsByReceiverId_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByReceiverId_nodes implements GCertFields {
  @override
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GIdentityFields_certsByReceiverId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GIdentityFields_certsByReceiverId_nodes_receiver? get receiver;

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

abstract class GIdentityFields_certsByReceiverId_nodes_issuer
    implements GCertFields_issuer, GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFields_certsByReceiverId_nodes_issuer_account? get account;

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

abstract class GIdentityFields_certsByReceiverId_nodes_issuer_account
    implements GCertFields_issuer_account, GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_certsByReceiverId_nodes_receiver
    implements GCertFields_receiver, GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFields_certsByReceiverId_nodes_receiver_account? get account;

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

abstract class GIdentityFields_certsByReceiverId_nodes_receiver_account
    implements GCertFields_receiver_account, GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipEvents {
  String get G__typename;

  int get totalCount;

  BuiltList<GIdentityFields_membershipEvents_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_membershipEvents_nodes {
  String get G__typename;

  int get blockNumber;

  String? get eventId;

  String get eventType;

  String get id;

  String? get identityId;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_changeOwnerKeys {
  String get G__typename;

  int get totalCount;

  BuiltList<GIdentityFields_changeOwnerKeys_nodes> get nodes;

  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_changeOwnerKeys_nodes
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
  GIdentityFields_smith_smithCertsByIssuerId get smithCertsByIssuerId;

  @override
  GIdentityFields_smith_smithCertsByReceiverId get smithCertsByReceiverId;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertsByIssuerId
    implements GSmithFields_smithCertsByIssuerId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFields_smith_smithCertsByIssuerId_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertsByIssuerId_nodes
    implements GSmithFields_smithCertsByIssuerId_nodes, GSmithCertFields {
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

abstract class GIdentityFields_smith_smithCertsByReceiverId
    implements GSmithFields_smithCertsByReceiverId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFields_smith_smithCertsByReceiverId_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GIdentityFields_smith_smithCertsByReceiverId_nodes
    implements GSmithFields_smithCertsByReceiverId_nodes, GSmithCertFields {
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
  GIdentityFieldsData_certsByIssuerId get certsByIssuerId;

  @override
  GIdentityFieldsData_certsByReceiverId get certsByReceiverId;

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
  GIdentityFieldsData_membershipEvents get membershipEvents;

  @override
  GIdentityFieldsData_changeOwnerKeys get changeOwnerKeys;

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

abstract class GIdentityFieldsData_certsByIssuerId
    implements
        Built<GIdentityFieldsData_certsByIssuerId,
            GIdentityFieldsData_certsByIssuerIdBuilder>,
        GIdentityFields_certsByIssuerId {
  GIdentityFieldsData_certsByIssuerId._();

  factory GIdentityFieldsData_certsByIssuerId(
      [void Function(GIdentityFieldsData_certsByIssuerIdBuilder b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_certsByIssuerId_nodes> get nodes;

  static Serializer<GIdentityFieldsData_certsByIssuerId> get serializer =>
      _$gIdentityFieldsDataCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByIssuerId_nodes
    implements
        Built<GIdentityFieldsData_certsByIssuerId_nodes,
            GIdentityFieldsData_certsByIssuerId_nodesBuilder>,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GIdentityFieldsData_certsByIssuerId_nodes._();

  factory GIdentityFieldsData_certsByIssuerId_nodes(
      [void Function(GIdentityFieldsData_certsByIssuerId_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerId_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GIdentityFieldsData_certsByIssuerId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GIdentityFieldsData_certsByIssuerId_nodes_receiver? get receiver;

  @override
  int get createdOn;

  @override
  int get expireOn;

  @override
  bool get isActive;

  @override
  int get updatedOn;

  static Serializer<GIdentityFieldsData_certsByIssuerId_nodes> get serializer =>
      _$gIdentityFieldsDataCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByIssuerId_nodes_issuer
    implements
        Built<GIdentityFieldsData_certsByIssuerId_nodes_issuer,
            GIdentityFieldsData_certsByIssuerId_nodes_issuerBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certsByIssuerId_nodes_issuer._();

  factory GIdentityFieldsData_certsByIssuerId_nodes_issuer(
      [void Function(GIdentityFieldsData_certsByIssuerId_nodes_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerId_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFieldsData_certsByIssuerId_nodes_issuer_account? get account;

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

  static Serializer<GIdentityFieldsData_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gIdentityFieldsDataCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByIssuerId_nodes_issuer_account
    implements
        Built<GIdentityFieldsData_certsByIssuerId_nodes_issuer_account,
            GIdentityFieldsData_certsByIssuerId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certsByIssuerId_nodes_issuer_account._();

  factory GIdentityFieldsData_certsByIssuerId_nodes_issuer_account(
      [void Function(
              GIdentityFieldsData_certsByIssuerId_nodes_issuer_accountBuilder b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerId_nodes_issuer_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GIdentityFieldsData_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gIdentityFieldsDataCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId_nodes_issuer_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_issuer_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByIssuerId_nodes_receiver
    implements
        Built<GIdentityFieldsData_certsByIssuerId_nodes_receiver,
            GIdentityFieldsData_certsByIssuerId_nodes_receiverBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certsByIssuerId_nodes_receiver._();

  factory GIdentityFieldsData_certsByIssuerId_nodes_receiver(
      [void Function(
              GIdentityFieldsData_certsByIssuerId_nodes_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerId_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFieldsData_certsByIssuerId_nodes_receiver_account? get account;

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

  static Serializer<GIdentityFieldsData_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gIdentityFieldsDataCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByIssuerId_nodes_receiver_account
    implements
        Built<GIdentityFieldsData_certsByIssuerId_nodes_receiver_account,
            GIdentityFieldsData_certsByIssuerId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certsByIssuerId_nodes_receiver_account._();

  factory GIdentityFieldsData_certsByIssuerId_nodes_receiver_account(
      [void Function(
              GIdentityFieldsData_certsByIssuerId_nodes_receiver_accountBuilder
                  b)
          updates]) = _$GIdentityFieldsData_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GIdentityFieldsData_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gIdentityFieldsDataCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_receiver_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByIssuerId_nodes_receiver_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByIssuerId_nodes_receiver_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId
    implements
        Built<GIdentityFieldsData_certsByReceiverId,
            GIdentityFieldsData_certsByReceiverIdBuilder>,
        GIdentityFields_certsByReceiverId {
  GIdentityFieldsData_certsByReceiverId._();

  factory GIdentityFieldsData_certsByReceiverId(
      [void Function(GIdentityFieldsData_certsByReceiverIdBuilder b)
          updates]) = _$GIdentityFieldsData_certsByReceiverId;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_certsByReceiverId_nodes> get nodes;

  static Serializer<GIdentityFieldsData_certsByReceiverId> get serializer =>
      _$gIdentityFieldsDataCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId_nodes
    implements
        Built<GIdentityFieldsData_certsByReceiverId_nodes,
            GIdentityFieldsData_certsByReceiverId_nodesBuilder>,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GIdentityFieldsData_certsByReceiverId_nodes._();

  factory GIdentityFieldsData_certsByReceiverId_nodes(
      [void Function(GIdentityFieldsData_certsByReceiverId_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverId_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GIdentityFieldsData_certsByReceiverId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GIdentityFieldsData_certsByReceiverId_nodes_receiver? get receiver;

  @override
  int get createdOn;

  @override
  int get expireOn;

  @override
  bool get isActive;

  @override
  int get updatedOn;

  static Serializer<GIdentityFieldsData_certsByReceiverId_nodes>
      get serializer => _$gIdentityFieldsDataCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId_nodes_issuer
    implements
        Built<GIdentityFieldsData_certsByReceiverId_nodes_issuer,
            GIdentityFieldsData_certsByReceiverId_nodes_issuerBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GIdentityFieldsData_certsByReceiverId_nodes_issuer._();

  factory GIdentityFieldsData_certsByReceiverId_nodes_issuer(
      [void Function(
              GIdentityFieldsData_certsByReceiverId_nodes_issuerBuilder b)
          updates]) = _$GIdentityFieldsData_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverId_nodes_issuerBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFieldsData_certsByReceiverId_nodes_issuer_account? get account;

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

  static Serializer<GIdentityFieldsData_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gIdentityFieldsDataCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_issuer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId_nodes_issuer? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_issuer.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId_nodes_issuer_account
    implements
        Built<GIdentityFieldsData_certsByReceiverId_nodes_issuer_account,
            GIdentityFieldsData_certsByReceiverId_nodes_issuer_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certsByReceiverId_nodes_issuer_account._();

  factory GIdentityFieldsData_certsByReceiverId_nodes_issuer_account(
      [void Function(
              GIdentityFieldsData_certsByReceiverId_nodes_issuer_accountBuilder
                  b)
          updates]) = _$GIdentityFieldsData_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GIdentityFieldsData_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gIdentityFieldsDataCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_issuer_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId_nodes_issuer_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_issuer_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId_nodes_receiver
    implements
        Built<GIdentityFieldsData_certsByReceiverId_nodes_receiver,
            GIdentityFieldsData_certsByReceiverId_nodes_receiverBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GIdentityFieldsData_certsByReceiverId_nodes_receiver._();

  factory GIdentityFieldsData_certsByReceiverId_nodes_receiver(
      [void Function(
              GIdentityFieldsData_certsByReceiverId_nodes_receiverBuilder b)
          updates]) = _$GIdentityFieldsData_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverId_nodes_receiverBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GIdentityFieldsData_certsByReceiverId_nodes_receiver_account? get account;

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

  static Serializer<GIdentityFieldsData_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gIdentityFieldsDataCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_receiver.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId_nodes_receiver? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_receiver.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_certsByReceiverId_nodes_receiver_account
    implements
        Built<GIdentityFieldsData_certsByReceiverId_nodes_receiver_account,
            GIdentityFieldsData_certsByReceiverId_nodes_receiver_accountBuilder>,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GIdentityFieldsData_certsByReceiverId_nodes_receiver_account._();

  factory GIdentityFieldsData_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GIdentityFieldsData_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GIdentityFieldsData_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GIdentityFieldsData_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GIdentityFieldsData_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gIdentityFieldsDataCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_receiver_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_certsByReceiverId_nodes_receiver_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_certsByReceiverId_nodes_receiver_account.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_membershipEvents
    implements
        Built<GIdentityFieldsData_membershipEvents,
            GIdentityFieldsData_membershipEventsBuilder>,
        GIdentityFields_membershipEvents {
  GIdentityFieldsData_membershipEvents._();

  factory GIdentityFieldsData_membershipEvents(
      [void Function(GIdentityFieldsData_membershipEventsBuilder b)
          updates]) = _$GIdentityFieldsData_membershipEvents;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipEventsBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_membershipEvents_nodes> get nodes;

  static Serializer<GIdentityFieldsData_membershipEvents> get serializer =>
      _$gIdentityFieldsDataMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipEvents.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipEvents? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipEvents.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_membershipEvents_nodes
    implements
        Built<GIdentityFieldsData_membershipEvents_nodes,
            GIdentityFieldsData_membershipEvents_nodesBuilder>,
        GIdentityFields_membershipEvents_nodes {
  GIdentityFieldsData_membershipEvents_nodes._();

  factory GIdentityFieldsData_membershipEvents_nodes(
      [void Function(GIdentityFieldsData_membershipEvents_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_membershipEvents_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_membershipEvents_nodesBuilder b) =>
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

  static Serializer<GIdentityFieldsData_membershipEvents_nodes>
      get serializer => _$gIdentityFieldsDataMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_membershipEvents_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_membershipEvents_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_membershipEvents_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_changeOwnerKeys
    implements
        Built<GIdentityFieldsData_changeOwnerKeys,
            GIdentityFieldsData_changeOwnerKeysBuilder>,
        GIdentityFields_changeOwnerKeys {
  GIdentityFieldsData_changeOwnerKeys._();

  factory GIdentityFieldsData_changeOwnerKeys(
      [void Function(GIdentityFieldsData_changeOwnerKeysBuilder b)
          updates]) = _$GIdentityFieldsData_changeOwnerKeys;

  static void _initializeBuilder(
          GIdentityFieldsData_changeOwnerKeysBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_changeOwnerKeys_nodes> get nodes;

  static Serializer<GIdentityFieldsData_changeOwnerKeys> get serializer =>
      _$gIdentityFieldsDataChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_changeOwnerKeys.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_changeOwnerKeys? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_changeOwnerKeys.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_changeOwnerKeys_nodes
    implements
        Built<GIdentityFieldsData_changeOwnerKeys_nodes,
            GIdentityFieldsData_changeOwnerKeys_nodesBuilder>,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GIdentityFieldsData_changeOwnerKeys_nodes._();

  factory GIdentityFieldsData_changeOwnerKeys_nodes(
      [void Function(GIdentityFieldsData_changeOwnerKeys_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_changeOwnerKeys_nodesBuilder b) =>
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

  static Serializer<GIdentityFieldsData_changeOwnerKeys_nodes> get serializer =>
      _$gIdentityFieldsDataChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_changeOwnerKeys_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_changeOwnerKeys_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_changeOwnerKeys_nodes.serializer,
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
  GIdentityFieldsData_smith_smithCertsByIssuerId get smithCertsByIssuerId;

  @override
  GIdentityFieldsData_smith_smithCertsByReceiverId get smithCertsByReceiverId;

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

abstract class GIdentityFieldsData_smith_smithCertsByIssuerId
    implements
        Built<GIdentityFieldsData_smith_smithCertsByIssuerId,
            GIdentityFieldsData_smith_smithCertsByIssuerIdBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GIdentityFieldsData_smith_smithCertsByIssuerId._();

  factory GIdentityFieldsData_smith_smithCertsByIssuerId(
      [void Function(GIdentityFieldsData_smith_smithCertsByIssuerIdBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertsByIssuerIdBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_smith_smithCertsByIssuerId_nodes> get nodes;

  static Serializer<GIdentityFieldsData_smith_smithCertsByIssuerId>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertsByIssuerId.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertsByIssuerId_nodes
    implements
        Built<GIdentityFieldsData_smith_smithCertsByIssuerId_nodes,
            GIdentityFieldsData_smith_smithCertsByIssuerId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertsByIssuerId_nodes._();

  factory GIdentityFieldsData_smith_smithCertsByIssuerId_nodes(
      [void Function(
              GIdentityFieldsData_smith_smithCertsByIssuerId_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertsByIssuerId_nodesBuilder b) =>
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

  static Serializer<GIdentityFieldsData_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertsByReceiverId
    implements
        Built<GIdentityFieldsData_smith_smithCertsByReceiverId,
            GIdentityFieldsData_smith_smithCertsByReceiverIdBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GIdentityFieldsData_smith_smithCertsByReceiverId._();

  factory GIdentityFieldsData_smith_smithCertsByReceiverId(
      [void Function(GIdentityFieldsData_smith_smithCertsByReceiverIdBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertsByReceiverIdBuilder b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GIdentityFieldsData_smith_smithCertsByReceiverId_nodes> get nodes;

  static Serializer<GIdentityFieldsData_smith_smithCertsByReceiverId>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertsByReceiverId.serializer,
        json,
      );
}

abstract class GIdentityFieldsData_smith_smithCertsByReceiverId_nodes
    implements
        Built<GIdentityFieldsData_smith_smithCertsByReceiverId_nodes,
            GIdentityFieldsData_smith_smithCertsByReceiverId_nodesBuilder>,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GIdentityFieldsData_smith_smithCertsByReceiverId_nodes._();

  factory GIdentityFieldsData_smith_smithCertsByReceiverId_nodes(
      [void Function(
              GIdentityFieldsData_smith_smithCertsByReceiverId_nodesBuilder b)
          updates]) = _$GIdentityFieldsData_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GIdentityFieldsData_smith_smithCertsByReceiverId_nodesBuilder b) =>
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

  static Serializer<GIdentityFieldsData_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gIdentityFieldsDataSmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsData_smith_smithCertsByReceiverId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsData_smith_smithCertsByReceiverId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsData_smith_smithCertsByReceiverId_nodes.serializer,
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

  _i2.GBigFloat get balance;

  _i2.GBigFloat? get totalBalance;

  GAccountBasicFields_linkedIdentity? get linkedIdentity;

  bool get isActive;

  Map<String, dynamic> toJson();
}

abstract class GAccountBasicFields_linkedIdentity
    implements GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountBasicFields_linkedIdentity_account? get account;

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

abstract class GAccountBasicFields_linkedIdentity_account
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
  _i2.GBigFloat get balance;

  @override
  _i2.GBigFloat? get totalBalance;

  @override
  GAccountBasicFieldsData_linkedIdentity? get linkedIdentity;

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

abstract class GAccountBasicFieldsData_linkedIdentity
    implements
        Built<GAccountBasicFieldsData_linkedIdentity,
            GAccountBasicFieldsData_linkedIdentityBuilder>,
        GAccountBasicFields_linkedIdentity,
        GIdentityBasicFields {
  GAccountBasicFieldsData_linkedIdentity._();

  factory GAccountBasicFieldsData_linkedIdentity(
      [void Function(GAccountBasicFieldsData_linkedIdentityBuilder b)
          updates]) = _$GAccountBasicFieldsData_linkedIdentity;

  static void _initializeBuilder(
          GAccountBasicFieldsData_linkedIdentityBuilder b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountBasicFieldsData_linkedIdentity_account? get account;

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

  static Serializer<GAccountBasicFieldsData_linkedIdentity> get serializer =>
      _$gAccountBasicFieldsDataLinkedIdentitySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsData_linkedIdentity.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsData_linkedIdentity? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsData_linkedIdentity.serializer,
        json,
      );
}

abstract class GAccountBasicFieldsData_linkedIdentity_account
    implements
        Built<GAccountBasicFieldsData_linkedIdentity_account,
            GAccountBasicFieldsData_linkedIdentity_accountBuilder>,
        GAccountBasicFields_linkedIdentity_account,
        GIdentityBasicFields_account {
  GAccountBasicFieldsData_linkedIdentity_account._();

  factory GAccountBasicFieldsData_linkedIdentity_account(
      [void Function(GAccountBasicFieldsData_linkedIdentity_accountBuilder b)
          updates]) = _$GAccountBasicFieldsData_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountBasicFieldsData_linkedIdentity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GAccountBasicFieldsData_linkedIdentity_account>
      get serializer =>
          _$gAccountBasicFieldsDataLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsData_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsData_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsData_linkedIdentity_account.serializer,
        json,
      );
}

abstract class GAccountFields {
  String get G__typename;

  int get createdOn;

  String get id;

  _i2.GBigFloat get balance;

  _i2.GBigFloat? get totalBalance;

  bool get isActive;

  GAccountFields_transfersIssued get transfersIssued;

  GAccountFields_transfersReceived get transfersReceived;

  GAccountFields_wasIdentityPrev get wasIdentityPrev;

  GAccountFields_wasIdentityNext get wasIdentityNext;

  GAccountFields_linkedIdentity? get linkedIdentity;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

abstract class GAccountFields_linkedIdentity implements GIdentityFields {
  @override
  String get G__typename;

  @override
  GAccountFields_linkedIdentity_account? get account;

  @override
  String? get accountId;

  @override
  String? get accountRemovedId;

  @override
  GAccountFields_linkedIdentity_certsByIssuerId get certsByIssuerId;

  @override
  GAccountFields_linkedIdentity_certsByReceiverId get certsByReceiverId;

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
  GAccountFields_linkedIdentity_membershipEvents get membershipEvents;

  @override
  GAccountFields_linkedIdentity_changeOwnerKeys get changeOwnerKeys;

  @override
  GAccountFields_linkedIdentity_smith? get smith;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_account
    implements GIdentityFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByIssuerId
    implements GIdentityFields_certsByIssuerId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_certsByIssuerId_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByIssuerId_nodes
    implements GIdentityFields_certsByIssuerId_nodes, GCertFields {
  @override
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver? get receiver;

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

abstract class GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer
    implements
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer_account?
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

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer_account
    implements
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver
    implements
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver_account?
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

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver_account
    implements
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByReceiverId
    implements GIdentityFields_certsByReceiverId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_certsByReceiverId_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByReceiverId_nodes
    implements GIdentityFields_certsByReceiverId_nodes, GCertFields {
  @override
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver? get receiver;

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

abstract class GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer
    implements
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer_account?
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

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer_account
    implements
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver
    implements
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  @override
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver_account?
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

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver_account
    implements
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  @override
  String get G__typename;

  @override
  int get createdOn;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_membershipEvents
    implements GIdentityFields_membershipEvents {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_membershipEvents_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_membershipEvents_nodes
    implements GIdentityFields_membershipEvents_nodes {
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

abstract class GAccountFields_linkedIdentity_changeOwnerKeys
    implements GIdentityFields_changeOwnerKeys {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_changeOwnerKeys_nodes> get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_changeOwnerKeys_nodes
    implements GIdentityFields_changeOwnerKeys_nodes, GOwnerKeyChangeFields {
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

abstract class GAccountFields_linkedIdentity_smith
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
  GAccountFields_linkedIdentity_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GAccountFields_linkedIdentity_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_smith_smithCertsByIssuerId
    implements
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_smith_smithCertsByIssuerId_nodes
    implements
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
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

abstract class GAccountFields_linkedIdentity_smith_smithCertsByReceiverId
    implements
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  @override
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFields_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get nodes;

  @override
  Map<String, dynamic> toJson();
}

abstract class GAccountFields_linkedIdentity_smith_smithCertsByReceiverId_nodes
    implements
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
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
  _i2.GBigFloat get balance;

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
  GAccountFieldsData_linkedIdentity? get linkedIdentity;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

abstract class GAccountFieldsData_linkedIdentity
    implements
        Built<GAccountFieldsData_linkedIdentity,
            GAccountFieldsData_linkedIdentityBuilder>,
        GAccountFields_linkedIdentity,
        GIdentityFields {
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
  GAccountFieldsData_linkedIdentity_account? get account;

  @override
  String? get accountId;

  @override
  String? get accountRemovedId;

  @override
  GAccountFieldsData_linkedIdentity_certsByIssuerId get certsByIssuerId;

  @override
  GAccountFieldsData_linkedIdentity_certsByReceiverId get certsByReceiverId;

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
  GAccountFieldsData_linkedIdentity_membershipEvents get membershipEvents;

  @override
  GAccountFieldsData_linkedIdentity_changeOwnerKeys get changeOwnerKeys;

  @override
  GAccountFieldsData_linkedIdentity_smith? get smith;

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

abstract class GAccountFieldsData_linkedIdentity_account
    implements
        Built<GAccountFieldsData_linkedIdentity_account,
            GAccountFieldsData_linkedIdentity_accountBuilder>,
        GAccountFields_linkedIdentity_account,
        GIdentityFields_account {
  GAccountFieldsData_linkedIdentity_account._();

  factory GAccountFieldsData_linkedIdentity_account(
      [void Function(GAccountFieldsData_linkedIdentity_accountBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_account;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_accountBuilder b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<GAccountFieldsData_linkedIdentity_account> get serializer =>
      _$gAccountFieldsDataLinkedIdentityAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_account.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_account? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_account.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByIssuerId,
            GAccountFieldsData_linkedIdentity_certsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId,
        GIdentityFields_certsByIssuerId {
  GAccountFieldsData_linkedIdentity_certsByIssuerId._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId(
      [void Function(GAccountFieldsData_linkedIdentity_certsByIssuerIdBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_certsByIssuerId;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes> get nodes;

  static Serializer<GAccountFieldsData_linkedIdentity_certsByIssuerId>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes,
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes,
        GIdentityFields_certsByIssuerId_nodes,
        GCertFields {
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes(
      [void Function(
              GAccountFieldsData_linkedIdentity_certsByIssuerId_nodesBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver?
      get receiver;

  @override
  int get createdOn;

  @override
  int get expireOn;

  @override
  bool get isActive;

  @override
  int get updatedOn;

  static Serializer<GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer,
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer,
        GIdentityFields_certsByIssuerId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account?
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
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account
    implements
        Built<
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account,
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_issuer_account,
        GIdentityFields_certsByIssuerId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver,
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver,
        GIdentityFields_certsByIssuerId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account?
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
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account
    implements
        Built<
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account,
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByIssuerId_nodes_receiver_account,
        GIdentityFields_certsByIssuerId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account._();

  factory GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByIssuerIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByIssuerId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByReceiverId,
            GAccountFieldsData_linkedIdentity_certsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId,
        GIdentityFields_certsByReceiverId {
  GAccountFieldsData_linkedIdentity_certsByReceiverId._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId(
      [void Function(
              GAccountFieldsData_linkedIdentity_certsByReceiverIdBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_certsByReceiverId;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverIdBuilder b) =>
      b..G__typename = 'CertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes>
      get nodes;

  static Serializer<GAccountFieldsData_linkedIdentity_certsByReceiverId>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes,
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes,
        GIdentityFields_certsByReceiverId_nodes,
        GCertFields {
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes(
      [void Function(
              GAccountFieldsData_linkedIdentity_certsByReceiverId_nodesBuilder
                  b)
          updates]) = _$GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodesBuilder b) =>
      b..G__typename = 'Cert';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String get id;

  @override
  String? get issuerId;

  @override
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer? get issuer;

  @override
  String? get receiverId;

  @override
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver?
      get receiver;

  @override
  int get createdOn;

  @override
  int get expireOn;

  @override
  bool get isActive;

  @override
  int get updatedOn;

  static Serializer<GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer
    implements
        Built<GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer,
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuerBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer,
        GIdentityFields_certsByReceiverId_nodes_issuer,
        GCertFields_issuer,
        GIdentityBasicFields {
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuerBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account?
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
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdNodesIssuerSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account
    implements
        Built<
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account,
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_issuer_account,
        GIdentityFields_certsByReceiverId_nodes_issuer_account,
        GCertFields_issuer_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdNodesIssuerAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_issuer_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver
    implements
        Built<
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver,
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiverBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver,
        GIdentityFields_certsByReceiverId_nodes_receiver,
        GCertFields_receiver,
        GIdentityBasicFields {
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiverBuilder
              b) =>
      b..G__typename = 'Identity';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  String? get accountId;

  @override
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account?
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
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdNodesReceiverSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account
    implements
        Built<
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account,
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder>,
        GAccountFields_linkedIdentity_certsByReceiverId_nodes_receiver_account,
        GIdentityFields_certsByReceiverId_nodes_receiver_account,
        GCertFields_receiver_account,
        GIdentityBasicFields_account {
  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account._();

  factory GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account(
          [void Function(
                  GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_accountBuilder
              b) =>
      b..G__typename = 'Account';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get createdOn;

  static Serializer<
          GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityCertsByReceiverIdNodesReceiverAccountSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_certsByReceiverId_nodes_receiver_account
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_membershipEvents
    implements
        Built<GAccountFieldsData_linkedIdentity_membershipEvents,
            GAccountFieldsData_linkedIdentity_membershipEventsBuilder>,
        GAccountFields_linkedIdentity_membershipEvents,
        GIdentityFields_membershipEvents {
  GAccountFieldsData_linkedIdentity_membershipEvents._();

  factory GAccountFieldsData_linkedIdentity_membershipEvents(
      [void Function(
              GAccountFieldsData_linkedIdentity_membershipEventsBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_membershipEvents;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_membershipEventsBuilder b) =>
      b..G__typename = 'MembershipEventsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFieldsData_linkedIdentity_membershipEvents_nodes> get nodes;

  static Serializer<GAccountFieldsData_linkedIdentity_membershipEvents>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityMembershipEventsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_membershipEvents.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_membershipEvents? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_membershipEvents.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_membershipEvents_nodes
    implements
        Built<GAccountFieldsData_linkedIdentity_membershipEvents_nodes,
            GAccountFieldsData_linkedIdentity_membershipEvents_nodesBuilder>,
        GAccountFields_linkedIdentity_membershipEvents_nodes,
        GIdentityFields_membershipEvents_nodes {
  GAccountFieldsData_linkedIdentity_membershipEvents_nodes._();

  factory GAccountFieldsData_linkedIdentity_membershipEvents_nodes(
      [void Function(
              GAccountFieldsData_linkedIdentity_membershipEvents_nodesBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_membershipEvents_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_membershipEvents_nodesBuilder b) =>
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

  static Serializer<GAccountFieldsData_linkedIdentity_membershipEvents_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityMembershipEventsNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_membershipEvents_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_membershipEvents_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_membershipEvents_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_changeOwnerKeys
    implements
        Built<GAccountFieldsData_linkedIdentity_changeOwnerKeys,
            GAccountFieldsData_linkedIdentity_changeOwnerKeysBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys,
        GIdentityFields_changeOwnerKeys {
  GAccountFieldsData_linkedIdentity_changeOwnerKeys._();

  factory GAccountFieldsData_linkedIdentity_changeOwnerKeys(
      [void Function(GAccountFieldsData_linkedIdentity_changeOwnerKeysBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_changeOwnerKeys;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_changeOwnerKeysBuilder b) =>
      b..G__typename = 'ChangeOwnerKeysConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes> get nodes;

  static Serializer<GAccountFieldsData_linkedIdentity_changeOwnerKeys>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityChangeOwnerKeysSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_changeOwnerKeys.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_changeOwnerKeys? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_changeOwnerKeys.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes
    implements
        Built<GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes,
            GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodesBuilder>,
        GAccountFields_linkedIdentity_changeOwnerKeys_nodes,
        GIdentityFields_changeOwnerKeys_nodes,
        GOwnerKeyChangeFields {
  GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes._();

  factory GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes(
      [void Function(
              GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodesBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodesBuilder b) =>
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

  static Serializer<GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentityChangeOwnerKeysNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_changeOwnerKeys_nodes.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_smith
    implements
        Built<GAccountFieldsData_linkedIdentity_smith,
            GAccountFieldsData_linkedIdentity_smithBuilder>,
        GAccountFields_linkedIdentity_smith,
        GIdentityFields_smith,
        GSmithFields {
  GAccountFieldsData_linkedIdentity_smith._();

  factory GAccountFieldsData_linkedIdentity_smith(
      [void Function(GAccountFieldsData_linkedIdentity_smithBuilder b)
          updates]) = _$GAccountFieldsData_linkedIdentity_smith;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_smithBuilder b) =>
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
  GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId
      get smithCertsByIssuerId;

  @override
  GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId
      get smithCertsByReceiverId;

  static Serializer<GAccountFieldsData_linkedIdentity_smith> get serializer =>
      _$gAccountFieldsDataLinkedIdentitySmithSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_smith.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_smith? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_smith.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId
    implements
        Built<GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId,
            GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId,
        GIdentityFields_smith_smithCertsByIssuerId,
        GSmithFields_smithCertsByIssuerId {
  GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId._();

  factory GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId(
          [void Function(
                  GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerIdBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get nodes;

  static Serializer<
          GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentitySmithSmithCertsByIssuerIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId.serializer,
        json,
      );
}

abstract class GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes
    implements
        Built<
            GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes,
            GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByIssuerId_nodes,
        GIdentityFields_smith_smithCertsByIssuerId_nodes,
        GSmithFields_smithCertsByIssuerId_nodes,
        GSmithCertFields {
  GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes._();

  factory GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes(
          [void Function(
                  GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodesBuilder
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
          GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentitySmithSmithCertsByIssuerIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_smith_smithCertsByIssuerId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId
    implements
        Built<GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId,
            GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverIdBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId,
        GIdentityFields_smith_smithCertsByReceiverId,
        GSmithFields_smithCertsByReceiverId {
  GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId._();

  factory GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId(
          [void Function(
                  GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverIdBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverIdBuilder
              b) =>
      b..G__typename = 'SmithCertsConnection';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;

  @override
  int get totalCount;

  @override
  BuiltList<
          GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get nodes;

  static Serializer<
          GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentitySmithSmithCertsByReceiverIdSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId
                .serializer,
            json,
          );
}

abstract class GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes
    implements
        Built<
            GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes,
            GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder>,
        GAccountFields_linkedIdentity_smith_smithCertsByReceiverId_nodes,
        GIdentityFields_smith_smithCertsByReceiverId_nodes,
        GSmithFields_smithCertsByReceiverId_nodes,
        GSmithCertFields {
  GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes._();

  factory GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes(
          [void Function(
                  GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
                      b)
              updates]) =
      _$GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes;

  static void _initializeBuilder(
          GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodesBuilder
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
          GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes>
      get serializer =>
          _$gAccountFieldsDataLinkedIdentitySmithSmithCertsByReceiverIdNodesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GAccountFieldsData_linkedIdentity_smith_smithCertsByReceiverId_nodes
                .serializer,
            json,
          );
}

abstract class GAccountTxsFields {
  String get G__typename;

  int get createdOn;

  String get id;

  _i2.GBigFloat get balance;

  _i2.GBigFloat? get totalBalance;

  bool get isActive;

  GAccountTxsFields_comments get comments;

  GAccountTxsFields_transfersIssued get transfersIssued;

  GAccountTxsFields_transfersReceived get transfersReceived;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get balance;

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
  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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

abstract class GTransferFields {
  String get G__typename;

  int get blockNumber;

  _i2.GDatetime get timestamp;

  _i2.GBigFloat get amount;

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
  _i2.GBigFloat get amount;

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
