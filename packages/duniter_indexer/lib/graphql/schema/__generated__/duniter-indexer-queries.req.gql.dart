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
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'duniter-indexer-queries.req.gql.g.dart';

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

abstract class GIdentitiesByNameOrPkReq
    implements
        Built<GIdentitiesByNameOrPkReq, GIdentitiesByNameOrPkReqBuilder>,
        _i1.OperationRequest<_i2.GIdentitiesByNameOrPkData,
            _i3.GIdentitiesByNameOrPkVars> {
  GIdentitiesByNameOrPkReq._();

  factory GIdentitiesByNameOrPkReq(
          [void Function(GIdentitiesByNameOrPkReqBuilder b) updates]) =
      _$GIdentitiesByNameOrPkReq;

  static void _initializeBuilder(GIdentitiesByNameOrPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'IdentitiesByNameOrPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GIdentitiesByNameOrPkVars get vars;
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
  _i2.GIdentitiesByNameOrPkData? Function(
    _i2.GIdentitiesByNameOrPkData?,
    _i2.GIdentitiesByNameOrPkData?,
  )? get updateResult;
  @override
  _i2.GIdentitiesByNameOrPkData? get optimisticResponse;
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
  _i2.GIdentitiesByNameOrPkData? parseData(Map<String, dynamic> json) =>
      _i2.GIdentitiesByNameOrPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIdentitiesByNameOrPkData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GIdentitiesByNameOrPkData,
      _i3.GIdentitiesByNameOrPkVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GIdentitiesByNameOrPkReq> get serializer =>
      _$gIdentitiesByNameOrPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIdentitiesByNameOrPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameOrPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIdentitiesByNameOrPkReq.serializer,
        json,
      );
}

abstract class GIdentitiesByPkReq
    implements
        Built<GIdentitiesByPkReq, GIdentitiesByPkReqBuilder>,
        _i1.OperationRequest<_i2.GIdentitiesByPkData, _i3.GIdentitiesByPkVars> {
  GIdentitiesByPkReq._();

  factory GIdentitiesByPkReq(
          [void Function(GIdentitiesByPkReqBuilder b) updates]) =
      _$GIdentitiesByPkReq;

  static void _initializeBuilder(GIdentitiesByPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'IdentitiesByPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GIdentitiesByPkVars get vars;
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
  _i2.GIdentitiesByPkData? Function(
    _i2.GIdentitiesByPkData?,
    _i2.GIdentitiesByPkData?,
  )? get updateResult;
  @override
  _i2.GIdentitiesByPkData? get optimisticResponse;
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
  _i2.GIdentitiesByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GIdentitiesByPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIdentitiesByPkData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GIdentitiesByPkData, _i3.GIdentitiesByPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GIdentitiesByPkReq> get serializer =>
      _$gIdentitiesByPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIdentitiesByPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIdentitiesByPkReq.serializer,
        json,
      );
}

abstract class GIdentitiesByNameReq
    implements
        Built<GIdentitiesByNameReq, GIdentitiesByNameReqBuilder>,
        _i1.OperationRequest<_i2.GIdentitiesByNameData,
            _i3.GIdentitiesByNameVars> {
  GIdentitiesByNameReq._();

  factory GIdentitiesByNameReq(
          [void Function(GIdentitiesByNameReqBuilder b) updates]) =
      _$GIdentitiesByNameReq;

  static void _initializeBuilder(GIdentitiesByNameReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'IdentitiesByName',
    )
    ..executeOnListen = true;

  @override
  _i3.GIdentitiesByNameVars get vars;
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
  _i2.GIdentitiesByNameData? Function(
    _i2.GIdentitiesByNameData?,
    _i2.GIdentitiesByNameData?,
  )? get updateResult;
  @override
  _i2.GIdentitiesByNameData? get optimisticResponse;
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
  _i2.GIdentitiesByNameData? parseData(Map<String, dynamic> json) =>
      _i2.GIdentitiesByNameData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIdentitiesByNameData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GIdentitiesByNameData, _i3.GIdentitiesByNameVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GIdentitiesByNameReq> get serializer =>
      _$gIdentitiesByNameReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIdentitiesByNameReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentitiesByNameReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIdentitiesByNameReq.serializer,
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

abstract class GAccountsByPkReq
    implements
        Built<GAccountsByPkReq, GAccountsByPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsByPkData, _i3.GAccountsByPkVars> {
  GAccountsByPkReq._();

  factory GAccountsByPkReq([void Function(GAccountsByPkReqBuilder b) updates]) =
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
        context: context ?? const _i4.Context(),
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
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAccountsByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsByPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountsByPkData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountsByPkData, _i3.GAccountsByPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

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

abstract class GAccountBasicByPkReq
    implements
        Built<GAccountBasicByPkReq, GAccountBasicByPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountBasicByPkData,
            _i3.GAccountBasicByPkVars> {
  GAccountBasicByPkReq._();

  factory GAccountBasicByPkReq(
          [void Function(GAccountBasicByPkReqBuilder b) updates]) =
      _$GAccountBasicByPkReq;

  static void _initializeBuilder(GAccountBasicByPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountBasicByPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountBasicByPkVars get vars;
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
  _i2.GAccountBasicByPkData? Function(
    _i2.GAccountBasicByPkData?,
    _i2.GAccountBasicByPkData?,
  )? get updateResult;
  @override
  _i2.GAccountBasicByPkData? get optimisticResponse;
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
  _i2.GAccountBasicByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountBasicByPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountBasicByPkData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountBasicByPkData, _i3.GAccountBasicByPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAccountBasicByPkReq> get serializer =>
      _$gAccountBasicByPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountBasicByPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicByPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountBasicByPkReq.serializer,
        json,
      );
}

abstract class GAccountsBasicByPkReq
    implements
        Built<GAccountsBasicByPkReq, GAccountsBasicByPkReqBuilder>,
        _i1.OperationRequest<_i2.GAccountsBasicByPkData,
            _i3.GAccountsBasicByPkVars> {
  GAccountsBasicByPkReq._();

  factory GAccountsBasicByPkReq(
          [void Function(GAccountsBasicByPkReqBuilder b) updates]) =
      _$GAccountsBasicByPkReq;

  static void _initializeBuilder(GAccountsBasicByPkReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountsBasicByPk',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountsBasicByPkVars get vars;
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
  _i2.GAccountsBasicByPkData? Function(
    _i2.GAccountsBasicByPkData?,
    _i2.GAccountsBasicByPkData?,
  )? get updateResult;
  @override
  _i2.GAccountsBasicByPkData? get optimisticResponse;
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
  _i2.GAccountsBasicByPkData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountsBasicByPkData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountsBasicByPkData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountsBasicByPkData, _i3.GAccountsBasicByPkVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAccountsBasicByPkReq> get serializer =>
      _$gAccountsBasicByPkReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountsBasicByPkReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountsBasicByPkReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountsBasicByPkReq.serializer,
        json,
      );
}

abstract class GAccountTransactionsReq
    implements
        Built<GAccountTransactionsReq, GAccountTransactionsReqBuilder>,
        _i1.OperationRequest<_i2.GAccountTransactionsData,
            _i3.GAccountTransactionsVars> {
  GAccountTransactionsReq._();

  factory GAccountTransactionsReq(
          [void Function(GAccountTransactionsReqBuilder b) updates]) =
      _$GAccountTransactionsReq;

  static void _initializeBuilder(GAccountTransactionsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AccountTransactions',
    )
    ..executeOnListen = true;

  @override
  _i3.GAccountTransactionsVars get vars;
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
  _i2.GAccountTransactionsData? Function(
    _i2.GAccountTransactionsData?,
    _i2.GAccountTransactionsData?,
  )? get updateResult;
  @override
  _i2.GAccountTransactionsData? get optimisticResponse;
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
  _i2.GAccountTransactionsData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountTransactionsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountTransactionsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAccountTransactionsData,
      _i3.GAccountTransactionsVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAccountTransactionsReq> get serializer =>
      _$gAccountTransactionsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountTransactionsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTransactionsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountTransactionsReq.serializer,
        json,
      );
}

abstract class GIndexerVersionReq
    implements
        Built<GIndexerVersionReq, GIndexerVersionReqBuilder>,
        _i1.OperationRequest<_i2.GIndexerVersionData, _i3.GIndexerVersionVars> {
  GIndexerVersionReq._();

  factory GIndexerVersionReq(
          [void Function(GIndexerVersionReqBuilder b) updates]) =
      _$GIndexerVersionReq;

  static void _initializeBuilder(GIndexerVersionReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'IndexerVersion',
    )
    ..executeOnListen = true;

  @override
  _i3.GIndexerVersionVars get vars;
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
  _i2.GIndexerVersionData? Function(
    _i2.GIndexerVersionData?,
    _i2.GIndexerVersionData?,
  )? get updateResult;
  @override
  _i2.GIndexerVersionData? get optimisticResponse;
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
  _i2.GIndexerVersionData? parseData(Map<String, dynamic> json) =>
      _i2.GIndexerVersionData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIndexerVersionData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GIndexerVersionData, _i3.GIndexerVersionVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GIndexerVersionReq> get serializer =>
      _$gIndexerVersionReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIndexerVersionReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIndexerVersionReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIndexerVersionReq.serializer,
        json,
      );
}

abstract class GCertFieldsReq
    implements
        Built<GCertFieldsReq, GCertFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GCertFieldsData, _i3.GCertFieldsVars> {
  GCertFieldsReq._();

  factory GCertFieldsReq([void Function(GCertFieldsReqBuilder b) updates]) =
      _$GCertFieldsReq;

  static void _initializeBuilder(GCertFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'CertFields';

  @override
  _i3.GCertFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GCertFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GCertFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCertFieldsData data) => data.toJson();

  static Serializer<GCertFieldsReq> get serializer =>
      _$gCertFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCertFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCertFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCertFieldsReq.serializer,
        json,
      );
}

abstract class GSmithCertFieldsReq
    implements
        Built<GSmithCertFieldsReq, GSmithCertFieldsReqBuilder>,
        _i1
        .FragmentRequest<_i2.GSmithCertFieldsData, _i3.GSmithCertFieldsVars> {
  GSmithCertFieldsReq._();

  factory GSmithCertFieldsReq(
          [void Function(GSmithCertFieldsReqBuilder b) updates]) =
      _$GSmithCertFieldsReq;

  static void _initializeBuilder(GSmithCertFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'SmithCertFields';

  @override
  _i3.GSmithCertFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GSmithCertFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GSmithCertFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSmithCertFieldsData data) =>
      data.toJson();

  static Serializer<GSmithCertFieldsReq> get serializer =>
      _$gSmithCertFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSmithCertFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithCertFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSmithCertFieldsReq.serializer,
        json,
      );
}

abstract class GSmithFieldsReq
    implements
        Built<GSmithFieldsReq, GSmithFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GSmithFieldsData, _i3.GSmithFieldsVars> {
  GSmithFieldsReq._();

  factory GSmithFieldsReq([void Function(GSmithFieldsReqBuilder b) updates]) =
      _$GSmithFieldsReq;

  static void _initializeBuilder(GSmithFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'SmithFields';

  @override
  _i3.GSmithFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GSmithFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GSmithFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSmithFieldsData data) => data.toJson();

  static Serializer<GSmithFieldsReq> get serializer =>
      _$gSmithFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSmithFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSmithFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSmithFieldsReq.serializer,
        json,
      );
}

abstract class GOwnerKeyChangeFieldsReq
    implements
        Built<GOwnerKeyChangeFieldsReq, GOwnerKeyChangeFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GOwnerKeyChangeFieldsData,
            _i3.GOwnerKeyChangeFieldsVars> {
  GOwnerKeyChangeFieldsReq._();

  factory GOwnerKeyChangeFieldsReq(
          [void Function(GOwnerKeyChangeFieldsReqBuilder b) updates]) =
      _$GOwnerKeyChangeFieldsReq;

  static void _initializeBuilder(GOwnerKeyChangeFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'OwnerKeyChangeFields';

  @override
  _i3.GOwnerKeyChangeFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GOwnerKeyChangeFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GOwnerKeyChangeFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GOwnerKeyChangeFieldsData data) =>
      data.toJson();

  static Serializer<GOwnerKeyChangeFieldsReq> get serializer =>
      _$gOwnerKeyChangeFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GOwnerKeyChangeFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOwnerKeyChangeFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GOwnerKeyChangeFieldsReq.serializer,
        json,
      );
}

abstract class GIdentityBasicFieldsReq
    implements
        Built<GIdentityBasicFieldsReq, GIdentityBasicFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GIdentityBasicFieldsData,
            _i3.GIdentityBasicFieldsVars> {
  GIdentityBasicFieldsReq._();

  factory GIdentityBasicFieldsReq(
          [void Function(GIdentityBasicFieldsReqBuilder b) updates]) =
      _$GIdentityBasicFieldsReq;

  static void _initializeBuilder(GIdentityBasicFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'IdentityBasicFields';

  @override
  _i3.GIdentityBasicFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GIdentityBasicFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GIdentityBasicFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIdentityBasicFieldsData data) =>
      data.toJson();

  static Serializer<GIdentityBasicFieldsReq> get serializer =>
      _$gIdentityBasicFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIdentityBasicFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityBasicFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIdentityBasicFieldsReq.serializer,
        json,
      );
}

abstract class GIdentityFieldsReq
    implements
        Built<GIdentityFieldsReq, GIdentityFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GIdentityFieldsData, _i3.GIdentityFieldsVars> {
  GIdentityFieldsReq._();

  factory GIdentityFieldsReq(
          [void Function(GIdentityFieldsReqBuilder b) updates]) =
      _$GIdentityFieldsReq;

  static void _initializeBuilder(GIdentityFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'IdentityFields';

  @override
  _i3.GIdentityFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GIdentityFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GIdentityFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GIdentityFieldsData data) =>
      data.toJson();

  static Serializer<GIdentityFieldsReq> get serializer =>
      _$gIdentityFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GIdentityFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIdentityFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GIdentityFieldsReq.serializer,
        json,
      );
}

abstract class GCommentsIssuedReq
    implements
        Built<GCommentsIssuedReq, GCommentsIssuedReqBuilder>,
        _i1.FragmentRequest<_i2.GCommentsIssuedData, _i3.GCommentsIssuedVars> {
  GCommentsIssuedReq._();

  factory GCommentsIssuedReq(
          [void Function(GCommentsIssuedReqBuilder b) updates]) =
      _$GCommentsIssuedReq;

  static void _initializeBuilder(GCommentsIssuedReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'CommentsIssued';

  @override
  _i3.GCommentsIssuedVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GCommentsIssuedData? parseData(Map<String, dynamic> json) =>
      _i2.GCommentsIssuedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCommentsIssuedData data) =>
      data.toJson();

  static Serializer<GCommentsIssuedReq> get serializer =>
      _$gCommentsIssuedReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCommentsIssuedReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentsIssuedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCommentsIssuedReq.serializer,
        json,
      );
}

abstract class GAccountBasicFieldsReq
    implements
        Built<GAccountBasicFieldsReq, GAccountBasicFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GAccountBasicFieldsData,
            _i3.GAccountBasicFieldsVars> {
  GAccountBasicFieldsReq._();

  factory GAccountBasicFieldsReq(
          [void Function(GAccountBasicFieldsReqBuilder b) updates]) =
      _$GAccountBasicFieldsReq;

  static void _initializeBuilder(GAccountBasicFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'AccountBasicFields';

  @override
  _i3.GAccountBasicFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GAccountBasicFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountBasicFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountBasicFieldsData data) =>
      data.toJson();

  static Serializer<GAccountBasicFieldsReq> get serializer =>
      _$gAccountBasicFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountBasicFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountBasicFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountBasicFieldsReq.serializer,
        json,
      );
}

abstract class GAccountFieldsReq
    implements
        Built<GAccountFieldsReq, GAccountFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GAccountFieldsData, _i3.GAccountFieldsVars> {
  GAccountFieldsReq._();

  factory GAccountFieldsReq(
          [void Function(GAccountFieldsReqBuilder b) updates]) =
      _$GAccountFieldsReq;

  static void _initializeBuilder(GAccountFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'AccountFields';

  @override
  _i3.GAccountFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GAccountFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountFieldsData data) => data.toJson();

  static Serializer<GAccountFieldsReq> get serializer =>
      _$gAccountFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountFieldsReq.serializer,
        json,
      );
}

abstract class GAccountTxsFieldsReq
    implements
        Built<GAccountTxsFieldsReq, GAccountTxsFieldsReqBuilder>,
        _i1
        .FragmentRequest<_i2.GAccountTxsFieldsData, _i3.GAccountTxsFieldsVars> {
  GAccountTxsFieldsReq._();

  factory GAccountTxsFieldsReq(
          [void Function(GAccountTxsFieldsReqBuilder b) updates]) =
      _$GAccountTxsFieldsReq;

  static void _initializeBuilder(GAccountTxsFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'AccountTxsFields';

  @override
  _i3.GAccountTxsFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GAccountTxsFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GAccountTxsFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAccountTxsFieldsData data) =>
      data.toJson();

  static Serializer<GAccountTxsFieldsReq> get serializer =>
      _$gAccountTxsFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAccountTxsFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAccountTxsFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAccountTxsFieldsReq.serializer,
        json,
      );
}

abstract class GTransferFieldsReq
    implements
        Built<GTransferFieldsReq, GTransferFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GTransferFieldsData, _i3.GTransferFieldsVars> {
  GTransferFieldsReq._();

  factory GTransferFieldsReq(
          [void Function(GTransferFieldsReqBuilder b) updates]) =
      _$GTransferFieldsReq;

  static void _initializeBuilder(GTransferFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'TransferFields';

  @override
  _i3.GTransferFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GTransferFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GTransferFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GTransferFieldsData data) =>
      data.toJson();

  static Serializer<GTransferFieldsReq> get serializer =>
      _$gTransferFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GTransferFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTransferFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GTransferFieldsReq.serializer,
        json,
      );
}
