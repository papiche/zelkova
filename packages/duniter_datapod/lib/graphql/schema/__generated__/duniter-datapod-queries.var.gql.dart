// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-datapod-queries.var.gql.g.dart';

abstract class GGetProfileByAddressVars
    implements
        Built<GGetProfileByAddressVars, GGetProfileByAddressVarsBuilder> {
  GGetProfileByAddressVars._();

  factory GGetProfileByAddressVars(
          [void Function(GGetProfileByAddressVarsBuilder b) updates]) =
      _$GGetProfileByAddressVars;

  String get pubkey;
  static Serializer<GGetProfileByAddressVars> get serializer =>
      _$gGetProfileByAddressVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileByAddressVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileByAddressVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileByAddressVars.serializer,
        json,
      );
}

abstract class GGetProfilesByAddressVars
    implements
        Built<GGetProfilesByAddressVars, GGetProfilesByAddressVarsBuilder> {
  GGetProfilesByAddressVars._();

  factory GGetProfilesByAddressVars(
          [void Function(GGetProfilesByAddressVarsBuilder b) updates]) =
      _$GGetProfilesByAddressVars;

  BuiltList<String> get pubkeys;
  static Serializer<GGetProfilesByAddressVars> get serializer =>
      _$gGetProfilesByAddressVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfilesByAddressVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfilesByAddressVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfilesByAddressVars.serializer,
        json,
      );
}

abstract class GGetProfileCountVars
    implements Built<GGetProfileCountVars, GGetProfileCountVarsBuilder> {
  GGetProfileCountVars._();

  factory GGetProfileCountVars(
          [void Function(GGetProfileCountVarsBuilder b) updates]) =
      _$GGetProfileCountVars;

  static Serializer<GGetProfileCountVars> get serializer =>
      _$gGetProfileCountVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetProfileCountVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileCountVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetProfileCountVars.serializer,
        json,
      );
}

abstract class GSearchProfileByTermVars
    implements
        Built<GSearchProfileByTermVars, GSearchProfileByTermVarsBuilder> {
  GSearchProfileByTermVars._();

  factory GSearchProfileByTermVars(
          [void Function(GSearchProfileByTermVarsBuilder b) updates]) =
      _$GSearchProfileByTermVars;

  String get pattern;
  static Serializer<GSearchProfileByTermVars> get serializer =>
      _$gSearchProfileByTermVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfileByTermVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfileByTermVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfileByTermVars.serializer,
        json,
      );
}

abstract class GSearchProfilesVars
    implements Built<GSearchProfilesVars, GSearchProfilesVarsBuilder> {
  GSearchProfilesVars._();

  factory GSearchProfilesVars(
          [void Function(GSearchProfilesVarsBuilder b) updates]) =
      _$GSearchProfilesVars;

  String get searchTermLower;
  String get searchTerm;
  String get searchTermCapitalized;
  static Serializer<GSearchProfilesVars> get serializer =>
      _$gSearchProfilesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchProfilesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfilesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchProfilesVars.serializer,
        json,
      );
}
