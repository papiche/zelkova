// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:ginkgo/graphql/__generated__/duniter-custom-queries.ast.gql.dart'
    as _i5;
import 'package:ginkgo/graphql/__generated__/duniter-custom-queries.data.gql.dart'
    as _i2;
import 'package:ginkgo/graphql/__generated__/duniter-custom-queries.var.gql.dart'
    as _i3;
import 'package:ginkgo/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'duniter-custom-queries.req.gql.g.dart';

abstract class GAccountsByPkReq
    implements
        Built<GAccountsByPkReq, GAccountsByPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsByPkData, _i3.GAccountsByPkVars> {
  GAccountsByPkReq._();

  factory GAccountsByPkReq([Function(GAccountsByPkReqBuilder b) updates]) =
      _$GAccountsByPkReq;

  static void _initializeBuilder(GAccountsByPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountsByPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountsByPkVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAccountsByPkData? Function(
    _i2.GAccountsByPkData?,
    _i2.GAccountsByPkData?,
  )? get updateResult;
  @override
  _i2.GAccountsByPkData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GAccountsByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsByPkData.fromJson(json);

  static Serializer<GAccountsByPkReq> get serializer =>
      _$gAccountsByPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountsByPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountsByPkReq.serializer,
        json,
      );
}

abstract class GSearchIdentityReq
    implements
        Built<GSearchIdentityReq, GSearchIdentityReqBuilder>,
        _i1.OperationRequest<_i2.GSearchIdentityData, _i3.GSearchIdentityVars> {
  GSearchIdentityReq._();

  factory GSearchIdentityReq([Function(GSearchIdentityReqBuilder b) updates]) =
      _$GSearchIdentityReq;

  static void _initializeBuilder(GSearchIdentityReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchIdentity',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchIdentityVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GSearchIdentityData? Function(
    _i2.GSearchIdentityData?,
    _i2.GSearchIdentityData?,
  )? get updateResult;
  @override
  _i2.GSearchIdentityData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GSearchIdentityData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchIdentityData.fromJson(json);

  static Serializer<GSearchIdentityReq> get serializer =>
      _$gSearchIdentityReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchIdentityReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchIdentityReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchIdentityReq.serializer,
        json,
      );
}

abstract class GLastIndexedBlockNumberReq
    implements
        Built<GLastIndexedBlockNumberReq, GLastIndexedBlockNumberReqBuilder>,
        _i1.OperationRequest<_i2.GLastIndexedBlockNumberData,
            _i3.GLastIndexedBlockNumberVars> {
  GLastIndexedBlockNumberReq._();

  factory GLastIndexedBlockNumberReq(
          [Function(GLastIndexedBlockNumberReqBuilder b) updates]) =
      _$GLastIndexedBlockNumberReq;

  static void _initializeBuilder(GLastIndexedBlockNumberReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'LastIndexedBlockNumber',
    )
    ..executeOnListen = true;

  @override
  _i3.GLastIndexedBlockNumberVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GLastIndexedBlockNumberData? Function(
    _i2.GLastIndexedBlockNumberData?,
    _i2.GLastIndexedBlockNumberData?,
  )? get updateResult;
  @override
  _i2.GLastIndexedBlockNumberData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GLastIndexedBlockNumberData? parseData(Map<String, dynamic> json) =>
      _i2.GLastIndexedBlockNumberData.fromJson(json);

  static Serializer<GLastIndexedBlockNumberReq> get serializer =>
      _$gLastIndexedBlockNumberReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GLastIndexedBlockNumberReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastIndexedBlockNumberReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GLastIndexedBlockNumberReq.serializer,
        json,
      );
}

abstract class GAccountsByNameOrPkReq
    implements
        Built<GAccountsByNameOrPkReq, GAccountsByNameOrPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsByNameOrPkData,
            _i3.GAccountsByNameOrPkVars> {
  GAccountsByNameOrPkReq._();

  factory GAccountsByNameOrPkReq(
          [Function(GAccountsByNameOrPkReqBuilder b) updates]) =
      _$GAccountsByNameOrPkReq;

  static void _initializeBuilder(GAccountsByNameOrPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountsByNameOrPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountsByNameOrPkVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAccountsByNameOrPkData? Function(
    _i2.GAccountsByNameOrPkData?,
    _i2.GAccountsByNameOrPkData?,
  )? get updateResult;
  @override
  _i2.GAccountsByNameOrPkData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GAccountsByNameOrPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsByNameOrPkData.fromJson(json);

  static Serializer<GAccountsByNameOrPkReq> get serializer =>
      _$gAccountsByNameOrPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountsByNameOrPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameOrPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountsByNameOrPkReq.serializer,
        json,
      );
}
