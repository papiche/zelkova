// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-custom-queries.req.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAccountsByPkReq> _$gAccountsByPkReqSerializer =
    new _$GAccountsByPkReqSerializer();
Serializer<GSearchIdentityReq> _$gSearchIdentityReqSerializer =
    new _$GSearchIdentityReqSerializer();
Serializer<GLastIndexedBlockNumberReq> _$gLastIndexedBlockNumberReqSerializer =
    new _$GLastIndexedBlockNumberReqSerializer();
Serializer<GAccountsByNameOrPkReq> _$gAccountsByNameOrPkReqSerializer =
    new _$GAccountsByNameOrPkReqSerializer();

class _$GAccountsByPkReqSerializer
    implements StructuredSerializer<GAccountsByPkReq> {
  @override
  final Iterable<Type> types = const [GAccountsByPkReq, _$GAccountsByPkReq];
  @override
  final String wireName = 'GAccountsByPkReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountsByPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountsByPkVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GAccountsByPkData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GAccountsByPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountsByPkVars))!
              as _i3.GAccountsByPkVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GAccountsByPkData))!
              as _i2.GAccountsByPkData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchIdentityReqSerializer
    implements StructuredSerializer<GSearchIdentityReq> {
  @override
  final Iterable<Type> types = const [GSearchIdentityReq, _$GSearchIdentityReq];
  @override
  final String wireName = 'GSearchIdentityReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchIdentityReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GSearchIdentityVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GSearchIdentityData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GSearchIdentityReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchIdentityReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GSearchIdentityVars))!
              as _i3.GSearchIdentityVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GSearchIdentityData))!
              as _i2.GSearchIdentityData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GLastIndexedBlockNumberReqSerializer
    implements StructuredSerializer<GLastIndexedBlockNumberReq> {
  @override
  final Iterable<Type> types = const [
    GLastIndexedBlockNumberReq,
    _$GLastIndexedBlockNumberReq
  ];
  @override
  final String wireName = 'GLastIndexedBlockNumberReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLastIndexedBlockNumberReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GLastIndexedBlockNumberVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GLastIndexedBlockNumberData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GLastIndexedBlockNumberReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastIndexedBlockNumberReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i3.GLastIndexedBlockNumberVars))!
              as _i3.GLastIndexedBlockNumberVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i2.GLastIndexedBlockNumberData))!
              as _i2.GLastIndexedBlockNumberData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkReqSerializer
    implements StructuredSerializer<GAccountsByNameOrPkReq> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkReq,
    _$GAccountsByNameOrPkReq
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountsByNameOrPkVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GAccountsByNameOrPkData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountsByNameOrPkVars))!
              as _i3.GAccountsByNameOrPkVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GAccountsByNameOrPkData))!
              as _i2.GAccountsByNameOrPkData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkReq extends GAccountsByPkReq {
  @override
  final _i3.GAccountsByPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountsByPkData? Function(
      _i2.GAccountsByPkData?, _i2.GAccountsByPkData?)? updateResult;
  @override
  final _i2.GAccountsByPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GAccountsByPkReq(
          [void Function(GAccountsByPkReqBuilder)? updates]) =>
      (new GAccountsByPkReqBuilder()..update(updates))._build();

  _$GAccountsByPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GAccountsByPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountsByPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountsByPkReq', 'executeOnListen');
  }

  @override
  GAccountsByPkReq rebuild(void Function(GAccountsByPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByPkReqBuilder toBuilder() =>
      new GAccountsByPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountsByPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GAccountsByPkReqBuilder
    implements Builder<GAccountsByPkReq, GAccountsByPkReqBuilder> {
  _$GAccountsByPkReq? _$v;

  _i3.GAccountsByPkVarsBuilder? _vars;
  _i3.GAccountsByPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountsByPkVarsBuilder();
  set vars(_i3.GAccountsByPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountsByPkData? Function(
      _i2.GAccountsByPkData?, _i2.GAccountsByPkData?)? _updateResult;
  _i2.GAccountsByPkData? Function(
          _i2.GAccountsByPkData?, _i2.GAccountsByPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountsByPkData? Function(
                  _i2.GAccountsByPkData?, _i2.GAccountsByPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountsByPkDataBuilder? _optimisticResponse;
  _i2.GAccountsByPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountsByPkDataBuilder();
  set optimisticResponse(_i2.GAccountsByPkDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GAccountsByPkReqBuilder() {
    GAccountsByPkReq._initializeBuilder(this);
  }

  GAccountsByPkReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByPkReq;
  }

  @override
  void update(void Function(GAccountsByPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByPkReq build() => _build();

  _$GAccountsByPkReq _build() {
    _$GAccountsByPkReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountsByPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GAccountsByPkReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchIdentityReq extends GSearchIdentityReq {
  @override
  final _i3.GSearchIdentityVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GSearchIdentityData? Function(
      _i2.GSearchIdentityData?, _i2.GSearchIdentityData?)? updateResult;
  @override
  final _i2.GSearchIdentityData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GSearchIdentityReq(
          [void Function(GSearchIdentityReqBuilder)? updates]) =>
      (new GSearchIdentityReqBuilder()..update(updates))._build();

  _$GSearchIdentityReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GSearchIdentityReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GSearchIdentityReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GSearchIdentityReq', 'executeOnListen');
  }

  @override
  GSearchIdentityReq rebuild(
          void Function(GSearchIdentityReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchIdentityReqBuilder toBuilder() =>
      new GSearchIdentityReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GSearchIdentityReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchIdentityReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GSearchIdentityReqBuilder
    implements Builder<GSearchIdentityReq, GSearchIdentityReqBuilder> {
  _$GSearchIdentityReq? _$v;

  _i3.GSearchIdentityVarsBuilder? _vars;
  _i3.GSearchIdentityVarsBuilder get vars =>
      _$this._vars ??= new _i3.GSearchIdentityVarsBuilder();
  set vars(_i3.GSearchIdentityVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GSearchIdentityData? Function(
      _i2.GSearchIdentityData?, _i2.GSearchIdentityData?)? _updateResult;
  _i2.GSearchIdentityData? Function(
          _i2.GSearchIdentityData?, _i2.GSearchIdentityData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GSearchIdentityData? Function(
                  _i2.GSearchIdentityData?, _i2.GSearchIdentityData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GSearchIdentityDataBuilder? _optimisticResponse;
  _i2.GSearchIdentityDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GSearchIdentityDataBuilder();
  set optimisticResponse(_i2.GSearchIdentityDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GSearchIdentityReqBuilder() {
    GSearchIdentityReq._initializeBuilder(this);
  }

  GSearchIdentityReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchIdentityReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchIdentityReq;
  }

  @override
  void update(void Function(GSearchIdentityReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchIdentityReq build() => _build();

  _$GSearchIdentityReq _build() {
    _$GSearchIdentityReq _$result;
    try {
      _$result = _$v ??
          new _$GSearchIdentityReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GSearchIdentityReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GSearchIdentityReq', 'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSearchIdentityReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLastIndexedBlockNumberReq extends GLastIndexedBlockNumberReq {
  @override
  final _i3.GLastIndexedBlockNumberVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GLastIndexedBlockNumberData? Function(
          _i2.GLastIndexedBlockNumberData?, _i2.GLastIndexedBlockNumberData?)?
      updateResult;
  @override
  final _i2.GLastIndexedBlockNumberData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GLastIndexedBlockNumberReq(
          [void Function(GLastIndexedBlockNumberReqBuilder)? updates]) =>
      (new GLastIndexedBlockNumberReqBuilder()..update(updates))._build();

  _$GLastIndexedBlockNumberReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GLastIndexedBlockNumberReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GLastIndexedBlockNumberReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GLastIndexedBlockNumberReq', 'executeOnListen');
  }

  @override
  GLastIndexedBlockNumberReq rebuild(
          void Function(GLastIndexedBlockNumberReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastIndexedBlockNumberReqBuilder toBuilder() =>
      new GLastIndexedBlockNumberReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GLastIndexedBlockNumberReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLastIndexedBlockNumberReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GLastIndexedBlockNumberReqBuilder
    implements
        Builder<GLastIndexedBlockNumberReq, GLastIndexedBlockNumberReqBuilder> {
  _$GLastIndexedBlockNumberReq? _$v;

  _i3.GLastIndexedBlockNumberVarsBuilder? _vars;
  _i3.GLastIndexedBlockNumberVarsBuilder get vars =>
      _$this._vars ??= new _i3.GLastIndexedBlockNumberVarsBuilder();
  set vars(_i3.GLastIndexedBlockNumberVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GLastIndexedBlockNumberData? Function(
          _i2.GLastIndexedBlockNumberData?, _i2.GLastIndexedBlockNumberData?)?
      _updateResult;
  _i2.GLastIndexedBlockNumberData? Function(
          _i2.GLastIndexedBlockNumberData?, _i2.GLastIndexedBlockNumberData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GLastIndexedBlockNumberData? Function(
                  _i2.GLastIndexedBlockNumberData?,
                  _i2.GLastIndexedBlockNumberData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GLastIndexedBlockNumberDataBuilder? _optimisticResponse;
  _i2.GLastIndexedBlockNumberDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??=
          new _i2.GLastIndexedBlockNumberDataBuilder();
  set optimisticResponse(
          _i2.GLastIndexedBlockNumberDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GLastIndexedBlockNumberReqBuilder() {
    GLastIndexedBlockNumberReq._initializeBuilder(this);
  }

  GLastIndexedBlockNumberReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastIndexedBlockNumberReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastIndexedBlockNumberReq;
  }

  @override
  void update(void Function(GLastIndexedBlockNumberReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastIndexedBlockNumberReq build() => _build();

  _$GLastIndexedBlockNumberReq _build() {
    _$GLastIndexedBlockNumberReq _$result;
    try {
      _$result = _$v ??
          new _$GLastIndexedBlockNumberReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GLastIndexedBlockNumberReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen,
                  r'GLastIndexedBlockNumberReq',
                  'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLastIndexedBlockNumberReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkReq extends GAccountsByNameOrPkReq {
  @override
  final _i3.GAccountsByNameOrPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountsByNameOrPkData? Function(
      _i2.GAccountsByNameOrPkData?, _i2.GAccountsByNameOrPkData?)? updateResult;
  @override
  final _i2.GAccountsByNameOrPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;

  factory _$GAccountsByNameOrPkReq(
          [void Function(GAccountsByNameOrPkReqBuilder)? updates]) =>
      (new GAccountsByNameOrPkReqBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountsByNameOrPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountsByNameOrPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountsByNameOrPkReq', 'executeOnListen');
  }

  @override
  GAccountsByNameOrPkReq rebuild(
          void Function(GAccountsByNameOrPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkReqBuilder toBuilder() =>
      new GAccountsByNameOrPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountsByNameOrPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen))
        .toString();
  }
}

class GAccountsByNameOrPkReqBuilder
    implements Builder<GAccountsByNameOrPkReq, GAccountsByNameOrPkReqBuilder> {
  _$GAccountsByNameOrPkReq? _$v;

  _i3.GAccountsByNameOrPkVarsBuilder? _vars;
  _i3.GAccountsByNameOrPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountsByNameOrPkVarsBuilder();
  set vars(_i3.GAccountsByNameOrPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountsByNameOrPkData? Function(
          _i2.GAccountsByNameOrPkData?, _i2.GAccountsByNameOrPkData?)?
      _updateResult;
  _i2.GAccountsByNameOrPkData? Function(
          _i2.GAccountsByNameOrPkData?, _i2.GAccountsByNameOrPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountsByNameOrPkData? Function(
                  _i2.GAccountsByNameOrPkData?, _i2.GAccountsByNameOrPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountsByNameOrPkDataBuilder? _optimisticResponse;
  _i2.GAccountsByNameOrPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountsByNameOrPkDataBuilder();
  set optimisticResponse(
          _i2.GAccountsByNameOrPkDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  GAccountsByNameOrPkReqBuilder() {
    GAccountsByNameOrPkReq._initializeBuilder(this);
  }

  GAccountsByNameOrPkReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkReq;
  }

  @override
  void update(void Function(GAccountsByNameOrPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkReq build() => _build();

  _$GAccountsByNameOrPkReq _build() {
    _$GAccountsByNameOrPkReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountsByNameOrPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen,
                  r'GAccountsByNameOrPkReq',
                  'executeOnListen'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
