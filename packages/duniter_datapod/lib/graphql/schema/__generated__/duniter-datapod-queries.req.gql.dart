// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.ast.gql.dart'
    as _i5;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.data.gql.dart'
    as _i2;
import 'package:duniter_datapod/graphql/schema/__generated__/duniter-datapod-queries.var.gql.dart'
    as _i3;
import 'package:duniter_datapod/graphql/schema/__generated__/serializers.gql.dart'
    as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'duniter-datapod-queries.req.gql.g.dart';

abstract class GGetProfileByAddressReq
    implements
        Built<GGetProfileByAddressReq, GGetProfileByAddressReqBuilder>,
        _i1.OperationRequest<_i2.GGetProfileByAddressData,
            _i3.GGetProfileByAddressVars> {
  GGetProfileByAddressReq._();

  factory GGetProfileByAddressReq(
          [void Function(GGetProfileByAddressReqBuilder b) updates]) =
      _$GGetProfileByAddressReq;

  static void _initializeBuilder(GGetProfileByAddressReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetProfileByAddress',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetProfileByAddressVars get vars;
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
  _i2.GGetProfileByAddressData? Function(
    _i2.GGetProfileByAddressData?,
    _i2.GGetProfileByAddressData?,
  )? get updateResult;
  @override
  _i2.GGetProfileByAddressData? get optimisticResponse;
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
  _i2.GGetProfileByAddressData? parseData(Map<String, dynamic> json) =>
      _i2.GGetProfileByAddressData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetProfileByAddressData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetProfileByAddressData,
      _i3.GGetProfileByAddressVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetProfileByAddressReq> get serializer =>
      _$gGetProfileByAddressReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetProfileByAddressReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileByAddressReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetProfileByAddressReq.serializer,
        json,
      );
}

abstract class GGetProfilesByAddressReq
    implements
        Built<GGetProfilesByAddressReq, GGetProfilesByAddressReqBuilder>,
        _i1.OperationRequest<_i2.GGetProfilesByAddressData,
            _i3.GGetProfilesByAddressVars> {
  GGetProfilesByAddressReq._();

  factory GGetProfilesByAddressReq(
          [void Function(GGetProfilesByAddressReqBuilder b) updates]) =
      _$GGetProfilesByAddressReq;

  static void _initializeBuilder(GGetProfilesByAddressReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetProfilesByAddress',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetProfilesByAddressVars get vars;
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
  _i2.GGetProfilesByAddressData? Function(
    _i2.GGetProfilesByAddressData?,
    _i2.GGetProfilesByAddressData?,
  )? get updateResult;
  @override
  _i2.GGetProfilesByAddressData? get optimisticResponse;
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
  _i2.GGetProfilesByAddressData? parseData(Map<String, dynamic> json) =>
      _i2.GGetProfilesByAddressData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetProfilesByAddressData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetProfilesByAddressData,
      _i3.GGetProfilesByAddressVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetProfilesByAddressReq> get serializer =>
      _$gGetProfilesByAddressReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetProfilesByAddressReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfilesByAddressReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetProfilesByAddressReq.serializer,
        json,
      );
}

abstract class GGetProfileCountReq
    implements
        Built<GGetProfileCountReq, GGetProfileCountReqBuilder>,
        _i1
        .OperationRequest<_i2.GGetProfileCountData, _i3.GGetProfileCountVars> {
  GGetProfileCountReq._();

  factory GGetProfileCountReq(
          [void Function(GGetProfileCountReqBuilder b) updates]) =
      _$GGetProfileCountReq;

  static void _initializeBuilder(GGetProfileCountReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetProfileCount',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetProfileCountVars get vars;
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
  _i2.GGetProfileCountData? Function(
    _i2.GGetProfileCountData?,
    _i2.GGetProfileCountData?,
  )? get updateResult;
  @override
  _i2.GGetProfileCountData? get optimisticResponse;
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
  _i2.GGetProfileCountData? parseData(Map<String, dynamic> json) =>
      _i2.GGetProfileCountData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetProfileCountData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetProfileCountData, _i3.GGetProfileCountVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetProfileCountReq> get serializer =>
      _$gGetProfileCountReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetProfileCountReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetProfileCountReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetProfileCountReq.serializer,
        json,
      );
}

abstract class GSearchProfileByTermReq
    implements
        Built<GSearchProfileByTermReq, GSearchProfileByTermReqBuilder>,
        _i1.OperationRequest<_i2.GSearchProfileByTermData,
            _i3.GSearchProfileByTermVars> {
  GSearchProfileByTermReq._();

  factory GSearchProfileByTermReq(
          [void Function(GSearchProfileByTermReqBuilder b) updates]) =
      _$GSearchProfileByTermReq;

  static void _initializeBuilder(GSearchProfileByTermReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchProfileByTerm',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchProfileByTermVars get vars;
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
  _i2.GSearchProfileByTermData? Function(
    _i2.GSearchProfileByTermData?,
    _i2.GSearchProfileByTermData?,
  )? get updateResult;
  @override
  _i2.GSearchProfileByTermData? get optimisticResponse;
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
  _i2.GSearchProfileByTermData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchProfileByTermData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchProfileByTermData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchProfileByTermData,
      _i3.GSearchProfileByTermVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchProfileByTermReq> get serializer =>
      _$gSearchProfileByTermReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchProfileByTermReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfileByTermReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchProfileByTermReq.serializer,
        json,
      );
}

abstract class GSearchProfilesReq
    implements
        Built<GSearchProfilesReq, GSearchProfilesReqBuilder>,
        _i1.OperationRequest<_i2.GSearchProfilesData, _i3.GSearchProfilesVars> {
  GSearchProfilesReq._();

  factory GSearchProfilesReq(
          [void Function(GSearchProfilesReqBuilder b) updates]) =
      _$GSearchProfilesReq;

  static void _initializeBuilder(GSearchProfilesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchProfiles',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchProfilesVars get vars;
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
  _i2.GSearchProfilesData? Function(
    _i2.GSearchProfilesData?,
    _i2.GSearchProfilesData?,
  )? get updateResult;
  @override
  _i2.GSearchProfilesData? get optimisticResponse;
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
  _i2.GSearchProfilesData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchProfilesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchProfilesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchProfilesData, _i3.GSearchProfilesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchProfilesReq> get serializer =>
      _$gSearchProfilesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchProfilesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchProfilesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchProfilesReq.serializer,
        json,
      );
}
