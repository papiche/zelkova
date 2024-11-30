// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod.schema.schema.gql.dart'
    as _i2;
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-datapod-mutations.var.gql.g.dart';

abstract class GDeleteProfileVars
    implements Built<GDeleteProfileVars, GDeleteProfileVarsBuilder> {
  GDeleteProfileVars._();

  factory GDeleteProfileVars(
          [void Function(GDeleteProfileVarsBuilder b) updates]) =
      _$GDeleteProfileVars;

  String get address;
  String get hash;
  String get signature;
  static Serializer<GDeleteProfileVars> get serializer =>
      _$gDeleteProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteProfileVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteProfileVars.serializer,
        json,
      );
}

abstract class GMigrateProfileVars
    implements Built<GMigrateProfileVars, GMigrateProfileVarsBuilder> {
  GMigrateProfileVars._();

  factory GMigrateProfileVars(
          [void Function(GMigrateProfileVarsBuilder b) updates]) =
      _$GMigrateProfileVars;

  String get addressNew;
  String get addressOld;
  String get hash;
  String get signature;
  static Serializer<GMigrateProfileVars> get serializer =>
      _$gMigrateProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMigrateProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMigrateProfileVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMigrateProfileVars.serializer,
        json,
      );
}

abstract class GUpdateProfileVars
    implements Built<GUpdateProfileVars, GUpdateProfileVarsBuilder> {
  GUpdateProfileVars._();

  factory GUpdateProfileVars(
          [void Function(GUpdateProfileVarsBuilder b) updates]) =
      _$GUpdateProfileVars;

  String get address;
  String? get avatarBase64;
  String? get city;
  String? get description;
  _i2.GGeolocInput? get geoloc;
  String get hash;
  String get signature;
  BuiltList<_i2.GSocialInput>? get socials;
  String? get title;
  static Serializer<GUpdateProfileVars> get serializer =>
      _$gUpdateProfileVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileVars.serializer,
        json,
      );
}
