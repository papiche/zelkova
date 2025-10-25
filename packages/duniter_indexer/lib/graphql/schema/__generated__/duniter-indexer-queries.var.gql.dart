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

part 'duniter-indexer-queries.var.gql.g.dart';

abstract class GLastBlockVars
    implements Built<GLastBlockVars, GLastBlockVarsBuilder> {
  GLastBlockVars._();

  factory GLastBlockVars([void Function(GLastBlockVarsBuilder b) updates]) =
      _$GLastBlockVars;

  static Serializer<GLastBlockVars> get serializer =>
      _$gLastBlockVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastBlockVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastBlockVars.serializer,
        json,
      );
}

abstract class GIdentitiesByNameOrPkVars
    implements
        Built<GIdentitiesByNameOrPkVars, GIdentitiesByNameOrPkVarsBuilder> {
  GIdentitiesByNameOrPkVars._();

  factory GIdentitiesByNameOrPkVars(
          [void Function(GIdentitiesByNameOrPkVarsBuilder b) updates]) =
      _$GIdentitiesByNameOrPkVars;

  String? get pattern;
  static Serializer<GIdentitiesByNameOrPkVars> get serializer =>
      _$gIdentitiesByNameOrPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameOrPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameOrPkVars.serializer,
        json,
      );
}

abstract class GIdentitiesByPkVars
    implements Built<GIdentitiesByPkVars, GIdentitiesByPkVarsBuilder> {
  GIdentitiesByPkVars._();

  factory GIdentitiesByPkVars(
          [void Function(GIdentitiesByPkVarsBuilder b) updates]) =
      _$GIdentitiesByPkVars;

  BuiltList<String> get pubKeys;
  static Serializer<GIdentitiesByPkVars> get serializer =>
      _$gIdentitiesByPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByPkVars.serializer,
        json,
      );
}

abstract class GIdentitiesByNameVars
    implements Built<GIdentitiesByNameVars, GIdentitiesByNameVarsBuilder> {
  GIdentitiesByNameVars._();

  factory GIdentitiesByNameVars(
          [void Function(GIdentitiesByNameVarsBuilder b) updates]) =
      _$GIdentitiesByNameVars;

  String? get pattern;
  static Serializer<GIdentitiesByNameVars> get serializer =>
      _$gIdentitiesByNameVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentitiesByNameVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentitiesByNameVars.serializer,
        json,
      );
}

abstract class GAccountByPkVars
    implements Built<GAccountByPkVars, GAccountByPkVarsBuilder> {
  GAccountByPkVars._();

  factory GAccountByPkVars([void Function(GAccountByPkVarsBuilder b) updates]) =
      _$GAccountByPkVars;

  String get id;
  int? get limit;
  _i2.GCursor? get cursor;
  static Serializer<GAccountByPkVars> get serializer =>
      _$gAccountByPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountByPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountByPkVars.serializer,
        json,
      );
}

abstract class GAccountsByPkVars
    implements Built<GAccountsByPkVars, GAccountsByPkVarsBuilder> {
  GAccountsByPkVars._();

  factory GAccountsByPkVars(
          [void Function(GAccountsByPkVarsBuilder b) updates]) =
      _$GAccountsByPkVars;

  BuiltList<String> get accountIds;
  int? get limit;
  _i2.GCursor? get cursor;
  static Serializer<GAccountsByPkVars> get serializer =>
      _$gAccountsByPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByPkVars.serializer,
        json,
      );
}

abstract class GAccountBasicByPkVars
    implements Built<GAccountBasicByPkVars, GAccountBasicByPkVarsBuilder> {
  GAccountBasicByPkVars._();

  factory GAccountBasicByPkVars(
          [void Function(GAccountBasicByPkVarsBuilder b) updates]) =
      _$GAccountBasicByPkVars;

  String get id;
  static Serializer<GAccountBasicByPkVars> get serializer =>
      _$gAccountBasicByPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicByPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicByPkVars.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkVars
    implements Built<GAccountsBasicByPkVars, GAccountsBasicByPkVarsBuilder> {
  GAccountsBasicByPkVars._();

  factory GAccountsBasicByPkVars(
          [void Function(GAccountsBasicByPkVarsBuilder b) updates]) =
      _$GAccountsBasicByPkVars;

  BuiltList<String> get accountIds;
  static Serializer<GAccountsBasicByPkVars> get serializer =>
      _$gAccountsBasicByPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsBasicByPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsBasicByPkVars.serializer,
        json,
      );
}

abstract class GAccountTransactionsVars
    implements
        Built<GAccountTransactionsVars, GAccountTransactionsVarsBuilder> {
  GAccountTransactionsVars._();

  factory GAccountTransactionsVars(
          [void Function(GAccountTransactionsVarsBuilder b) updates]) =
      _$GAccountTransactionsVars;

  String get accountId;
  int? get limit;
  _i2.GCursor? get cursor;
  static Serializer<GAccountTransactionsVars> get serializer =>
      _$gAccountTransactionsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTransactionsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTransactionsVars.serializer,
        json,
      );
}

abstract class GCertFieldsVars
    implements Built<GCertFieldsVars, GCertFieldsVarsBuilder> {
  GCertFieldsVars._();

  factory GCertFieldsVars([void Function(GCertFieldsVarsBuilder b) updates]) =
      _$GCertFieldsVars;

  static Serializer<GCertFieldsVars> get serializer =>
      _$gCertFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCertFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCertFieldsVars.serializer,
        json,
      );
}

abstract class GSmithCertFieldsVars
    implements Built<GSmithCertFieldsVars, GSmithCertFieldsVarsBuilder> {
  GSmithCertFieldsVars._();

  factory GSmithCertFieldsVars(
          [void Function(GSmithCertFieldsVarsBuilder b) updates]) =
      _$GSmithCertFieldsVars;

  static Serializer<GSmithCertFieldsVars> get serializer =>
      _$gSmithCertFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithCertFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithCertFieldsVars.serializer,
        json,
      );
}

abstract class GSmithFieldsVars
    implements Built<GSmithFieldsVars, GSmithFieldsVarsBuilder> {
  GSmithFieldsVars._();

  factory GSmithFieldsVars([void Function(GSmithFieldsVarsBuilder b) updates]) =
      _$GSmithFieldsVars;

  static Serializer<GSmithFieldsVars> get serializer =>
      _$gSmithFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSmithFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSmithFieldsVars.serializer,
        json,
      );
}

abstract class GOwnerKeyChangeFieldsVars
    implements
        Built<GOwnerKeyChangeFieldsVars, GOwnerKeyChangeFieldsVarsBuilder> {
  GOwnerKeyChangeFieldsVars._();

  factory GOwnerKeyChangeFieldsVars(
          [void Function(GOwnerKeyChangeFieldsVarsBuilder b) updates]) =
      _$GOwnerKeyChangeFieldsVars;

  static Serializer<GOwnerKeyChangeFieldsVars> get serializer =>
      _$gOwnerKeyChangeFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOwnerKeyChangeFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOwnerKeyChangeFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOwnerKeyChangeFieldsVars.serializer,
        json,
      );
}

abstract class GIdentityBasicFieldsVars
    implements
        Built<GIdentityBasicFieldsVars, GIdentityBasicFieldsVarsBuilder> {
  GIdentityBasicFieldsVars._();

  factory GIdentityBasicFieldsVars(
          [void Function(GIdentityBasicFieldsVarsBuilder b) updates]) =
      _$GIdentityBasicFieldsVars;

  static Serializer<GIdentityBasicFieldsVars> get serializer =>
      _$gIdentityBasicFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityBasicFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityBasicFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityBasicFieldsVars.serializer,
        json,
      );
}

abstract class GIdentityFieldsVars
    implements Built<GIdentityFieldsVars, GIdentityFieldsVarsBuilder> {
  GIdentityFieldsVars._();

  factory GIdentityFieldsVars(
          [void Function(GIdentityFieldsVarsBuilder b) updates]) =
      _$GIdentityFieldsVars;

  static Serializer<GIdentityFieldsVars> get serializer =>
      _$gIdentityFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GIdentityFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GIdentityFieldsVars.serializer,
        json,
      );
}

abstract class GCommentsIssuedVars
    implements Built<GCommentsIssuedVars, GCommentsIssuedVarsBuilder> {
  GCommentsIssuedVars._();

  factory GCommentsIssuedVars(
          [void Function(GCommentsIssuedVarsBuilder b) updates]) =
      _$GCommentsIssuedVars;

  static Serializer<GCommentsIssuedVars> get serializer =>
      _$gCommentsIssuedVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentsIssuedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentsIssuedVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentsIssuedVars.serializer,
        json,
      );
}

abstract class GAccountBasicFieldsVars
    implements Built<GAccountBasicFieldsVars, GAccountBasicFieldsVarsBuilder> {
  GAccountBasicFieldsVars._();

  factory GAccountBasicFieldsVars(
          [void Function(GAccountBasicFieldsVarsBuilder b) updates]) =
      _$GAccountBasicFieldsVars;

  static Serializer<GAccountBasicFieldsVars> get serializer =>
      _$gAccountBasicFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountBasicFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountBasicFieldsVars.serializer,
        json,
      );
}

abstract class GAccountFieldsVars
    implements Built<GAccountFieldsVars, GAccountFieldsVarsBuilder> {
  GAccountFieldsVars._();

  factory GAccountFieldsVars(
          [void Function(GAccountFieldsVarsBuilder b) updates]) =
      _$GAccountFieldsVars;

  int? get first;
  _i2.GCursor? get after;
  static Serializer<GAccountFieldsVars> get serializer =>
      _$gAccountFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountFieldsVars.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsVars
    implements Built<GAccountTxsFieldsVars, GAccountTxsFieldsVarsBuilder> {
  GAccountTxsFieldsVars._();

  factory GAccountTxsFieldsVars(
          [void Function(GAccountTxsFieldsVarsBuilder b) updates]) =
      _$GAccountTxsFieldsVars;

  int? get first;
  _i2.GCursor? get after;
  static Serializer<GAccountTxsFieldsVars> get serializer =>
      _$gAccountTxsFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountTxsFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountTxsFieldsVars.serializer,
        json,
      );
}

abstract class GTransferFieldsVars
    implements Built<GTransferFieldsVars, GTransferFieldsVarsBuilder> {
  GTransferFieldsVars._();

  factory GTransferFieldsVars(
          [void Function(GTransferFieldsVarsBuilder b) updates]) =
      _$GTransferFieldsVars;

  static Serializer<GTransferFieldsVars> get serializer =>
      _$gTransferFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTransferFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTransferFieldsVars.serializer,
        json,
      );
}
