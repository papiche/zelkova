// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.ast.gql.dart'
    as _i5;
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart'
    as _i2;
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart'
    as _i3;
import 'package:duniter_indexer/graphql/schema/__generated__/serializers.gql.dart'
    as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'duniter-indexer-queries.req.gql.g.dart';

abstract class GAccountsByNameOrPkReq
    implements
        Built<GAccountsByNameOrPkReq, GAccountsByNameOrPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsByNameOrPkData,
            _i3.GAccountsByNameOrPkVars> {
  GAccountsByNameOrPkReq._();

  factory GAccountsByNameOrPkReq(
          [void Function(GAccountsByNameOrPkReqBuilder b) updates]) =
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
        context: context ?? const _i4.Context(),
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
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAccountsByNameOrPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsByNameOrPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountsByNameOrPkData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountsByNameOrPkData, _i3.GAccountsByNameOrPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

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

abstract class GAccountsByNameReq
    implements
        Built<GAccountsByNameReq, GAccountsByNameReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsByNameData, _i3.GAccountsByNameVars> {
  GAccountsByNameReq._();

  factory GAccountsByNameReq(
          [void Function(GAccountsByNameReqBuilder b) updates]) =
      _$GAccountsByNameReq;

  static void _initializeBuilder(GAccountsByNameReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountsByName',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountsByNameVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAccountsByNameData? Function(
    _i2.GAccountsByNameData?,
    _i2.GAccountsByNameData?,
  )? get updateResult;
  @override
  _i2.GAccountsByNameData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAccountsByNameData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsByNameData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountsByNameData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountsByNameData, _i3.GAccountsByNameVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAccountsByNameReq> get serializer =>
      _$gAccountsByNameReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountsByNameReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsByNameReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountsByNameReq.serializer,
        json,
      );
}

abstract class GAccountByPkReq
    implements
        Built<GAccountByPkReq, GAccountByPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountByPkData, _i3.GAccountByPkVars> {
  GAccountByPkReq._();

  factory GAccountByPkReq([void Function(GAccountByPkReqBuilder b) updates]) =
      _$GAccountByPkReq;

  static void _initializeBuilder(GAccountByPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountByPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountByPkVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAccountByPkData? Function(
    _i2.GAccountByPkData?,
    _i2.GAccountByPkData?,
  )? get updateResult;
  @override
  _i2.GAccountByPkData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAccountByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountByPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountByPkData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountByPkData, _i3.GAccountByPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAccountByPkReq> get serializer =>
      _$gAccountByPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountByPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountByPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountByPkReq.serializer,
        json,
      );
}

abstract class GLastBlockReq
    implements
        Built<GLastBlockReq, GLastBlockReqBuilder>,
        _i1.OperationRequest<_i2.GLastBlockData, _i3.GLastBlockVars> {
  GLastBlockReq._();

  factory GLastBlockReq([void Function(GLastBlockReqBuilder b) updates]) =
      _$GLastBlockReq;

  static void _initializeBuilder(GLastBlockReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'LastBlock',
    )
    ..executeOnListen = true;

  @override
  _i3.GLastBlockVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GLastBlockData? Function(
    _i2.GLastBlockData?,
    _i2.GLastBlockData?,
  )? get updateResult;
  @override
  _i2.GLastBlockData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GLastBlockData? parseData(Map<String, dynamic> json) =>
      _i2.GLastBlockData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GLastBlockData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GLastBlockData, _i3.GLastBlockVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GLastBlockReq> get serializer => _$gLastBlockReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GLastBlockReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLastBlockReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GLastBlockReq.serializer,
        json,
      );
}
