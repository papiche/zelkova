// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ginkgo/data/models/duniter-indexer/__generated__/serializers.gql.dart'
    as _i1;

part 'duniter-queries.var.gql.g.dart';

abstract class GAccountsByNameOrPkVars
    implements Built<GAccountsByNameOrPkVars, GAccountsByNameOrPkVarsBuilder> {
  GAccountsByNameOrPkVars._();

  factory GAccountsByNameOrPkVars(
          [void Function(GAccountsByNameOrPkVarsBuilder b) updates]) =
      _$GAccountsByNameOrPkVars;

  String? get pattern;
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

abstract class GAccountByPkVars
    implements Built<GAccountByPkVars, GAccountByPkVarsBuilder> {
  GAccountByPkVars._();

  factory GAccountByPkVars([void Function(GAccountByPkVarsBuilder b) updates]) =
      _$GAccountByPkVars;

  String get id;
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
