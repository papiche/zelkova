// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ginkgo/graphql/__generated__/serializers.gql.dart' as _i1;

part 'duniter-custom-queries.var.gql.g.dart';

abstract class GAccountsByPkVars
    implements Built<GAccountsByPkVars, GAccountsByPkVarsBuilder> {
  GAccountsByPkVars._();

  factory GAccountsByPkVars([Function(GAccountsByPkVarsBuilder b) updates]) =
      _$GAccountsByPkVars;

  String get address;
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

abstract class GSearchIdentityVars
    implements Built<GSearchIdentityVars, GSearchIdentityVarsBuilder> {
  GSearchIdentityVars._();

  factory GSearchIdentityVars(
      [Function(GSearchIdentityVarsBuilder b) updates]) = _$GSearchIdentityVars;

  String get name;
  static Serializer<GSearchIdentityVars> get serializer =>
      _$gSearchIdentityVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchIdentityVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchIdentityVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchIdentityVars.serializer,
        json,
      );
}

abstract class GLastIndexedBlockNumberVars
    implements
        Built<GLastIndexedBlockNumberVars, GLastIndexedBlockNumberVarsBuilder> {
  GLastIndexedBlockNumberVars._();

  factory GLastIndexedBlockNumberVars(
          [Function(GLastIndexedBlockNumberVarsBuilder b) updates]) =
      _$GLastIndexedBlockNumberVars;

  static Serializer<GLastIndexedBlockNumberVars> get serializer =>
      _$gLastIndexedBlockNumberVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLastIndexedBlockNumberVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastIndexedBlockNumberVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLastIndexedBlockNumberVars.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkVars
    implements Built<GAccountsByNameOrPkVars, GAccountsByNameOrPkVarsBuilder> {
  GAccountsByNameOrPkVars._();

  factory GAccountsByNameOrPkVars(
          [Function(GAccountsByNameOrPkVarsBuilder b) updates]) =
      _$GAccountsByNameOrPkVars;

  String get pattern;
  static Serializer<GAccountsByNameOrPkVars> get serializer =>
      _$gAccountsByNameOrPkVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAccountsByNameOrPkVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAccountsByNameOrPkVars.serializer,
        json,
      );
}
