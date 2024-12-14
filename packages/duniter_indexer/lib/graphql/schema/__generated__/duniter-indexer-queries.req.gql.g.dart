// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-indexer-queries.req.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLastBlockReq> _$gLastBlockReqSerializer =
    new _$GLastBlockReqSerializer();
Serializer<GIdentitiesByNameOrPkReq> _$gIdentitiesByNameOrPkReqSerializer =
    new _$GIdentitiesByNameOrPkReqSerializer();
Serializer<GIdentitiesByPkReq> _$gIdentitiesByPkReqSerializer =
    new _$GIdentitiesByPkReqSerializer();
Serializer<GIdentitiesByNameReq> _$gIdentitiesByNameReqSerializer =
    new _$GIdentitiesByNameReqSerializer();
Serializer<GAccountByPkReq> _$gAccountByPkReqSerializer =
    new _$GAccountByPkReqSerializer();
Serializer<GAccountsByPkReq> _$gAccountsByPkReqSerializer =
    new _$GAccountsByPkReqSerializer();
Serializer<GAccountBasicByPkReq> _$gAccountBasicByPkReqSerializer =
    new _$GAccountBasicByPkReqSerializer();
Serializer<GAccountsBasicByPkReq> _$gAccountsBasicByPkReqSerializer =
    new _$GAccountsBasicByPkReqSerializer();
Serializer<GAccountTransactionsReq> _$gAccountTransactionsReqSerializer =
    new _$GAccountTransactionsReqSerializer();
Serializer<GCertFieldsReq> _$gCertFieldsReqSerializer =
    new _$GCertFieldsReqSerializer();
Serializer<GSmithCertFieldsReq> _$gSmithCertFieldsReqSerializer =
    new _$GSmithCertFieldsReqSerializer();
Serializer<GSmithFieldsReq> _$gSmithFieldsReqSerializer =
    new _$GSmithFieldsReqSerializer();
Serializer<GOwnerKeyChangeFieldsReq> _$gOwnerKeyChangeFieldsReqSerializer =
    new _$GOwnerKeyChangeFieldsReqSerializer();
Serializer<GIdentityBasicFieldsReq> _$gIdentityBasicFieldsReqSerializer =
    new _$GIdentityBasicFieldsReqSerializer();
Serializer<GIdentityFieldsReq> _$gIdentityFieldsReqSerializer =
    new _$GIdentityFieldsReqSerializer();
Serializer<GCommentsIssuedReq> _$gCommentsIssuedReqSerializer =
    new _$GCommentsIssuedReqSerializer();
Serializer<GAccountBasicFieldsReq> _$gAccountBasicFieldsReqSerializer =
    new _$GAccountBasicFieldsReqSerializer();
Serializer<GAccountFieldsReq> _$gAccountFieldsReqSerializer =
    new _$GAccountFieldsReqSerializer();
Serializer<GAccountTxsFieldsReq> _$gAccountTxsFieldsReqSerializer =
    new _$GAccountTxsFieldsReqSerializer();
Serializer<GTransferFieldsReq> _$gTransferFieldsReqSerializer =
    new _$GTransferFieldsReqSerializer();

class _$GLastBlockReqSerializer implements StructuredSerializer<GLastBlockReq> {
  @override
  final Iterable<Type> types = const [GLastBlockReq, _$GLastBlockReq];
  @override
  final String wireName = 'GLastBlockReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLastBlockReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GLastBlockVars)),
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
            specifiedType: const FullType(_i2.GLastBlockData)));
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
  GLastBlockReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastBlockReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GLastBlockVars))!
              as _i3.GLastBlockVars);
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
                  specifiedType: const FullType(_i2.GLastBlockData))!
              as _i2.GLastBlockData);
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

class _$GIdentitiesByNameOrPkReqSerializer
    implements StructuredSerializer<GIdentitiesByNameOrPkReq> {
  @override
  final Iterable<Type> types = const [
    GIdentitiesByNameOrPkReq,
    _$GIdentitiesByNameOrPkReq
  ];
  @override
  final String wireName = 'GIdentitiesByNameOrPkReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByNameOrPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GIdentitiesByNameOrPkVars)),
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
            specifiedType: const FullType(_i2.GIdentitiesByNameOrPkData)));
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
  GIdentitiesByNameOrPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByNameOrPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GIdentitiesByNameOrPkVars))!
              as _i3.GIdentitiesByNameOrPkVars);
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
                  specifiedType: const FullType(_i2.GIdentitiesByNameOrPkData))!
              as _i2.GIdentitiesByNameOrPkData);
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

class _$GIdentitiesByPkReqSerializer
    implements StructuredSerializer<GIdentitiesByPkReq> {
  @override
  final Iterable<Type> types = const [GIdentitiesByPkReq, _$GIdentitiesByPkReq];
  @override
  final String wireName = 'GIdentitiesByPkReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GIdentitiesByPkVars)),
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
            specifiedType: const FullType(_i2.GIdentitiesByPkData)));
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
  GIdentitiesByPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GIdentitiesByPkVars))!
              as _i3.GIdentitiesByPkVars);
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
                  specifiedType: const FullType(_i2.GIdentitiesByPkData))!
              as _i2.GIdentitiesByPkData);
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

class _$GIdentitiesByNameReqSerializer
    implements StructuredSerializer<GIdentitiesByNameReq> {
  @override
  final Iterable<Type> types = const [
    GIdentitiesByNameReq,
    _$GIdentitiesByNameReq
  ];
  @override
  final String wireName = 'GIdentitiesByNameReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByNameReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GIdentitiesByNameVars)),
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
            specifiedType: const FullType(_i2.GIdentitiesByNameData)));
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
  GIdentitiesByNameReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByNameReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GIdentitiesByNameVars))!
              as _i3.GIdentitiesByNameVars);
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
                  specifiedType: const FullType(_i2.GIdentitiesByNameData))!
              as _i2.GIdentitiesByNameData);
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

class _$GAccountByPkReqSerializer
    implements StructuredSerializer<GAccountByPkReq> {
  @override
  final Iterable<Type> types = const [GAccountByPkReq, _$GAccountByPkReq];
  @override
  final String wireName = 'GAccountByPkReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountByPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountByPkVars)),
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
            specifiedType: const FullType(_i2.GAccountByPkData)));
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
  GAccountByPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountByPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountByPkVars))!
              as _i3.GAccountByPkVars);
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
                  specifiedType: const FullType(_i2.GAccountByPkData))!
              as _i2.GAccountByPkData);
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

class _$GAccountBasicByPkReqSerializer
    implements StructuredSerializer<GAccountBasicByPkReq> {
  @override
  final Iterable<Type> types = const [
    GAccountBasicByPkReq,
    _$GAccountBasicByPkReq
  ];
  @override
  final String wireName = 'GAccountBasicByPkReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountBasicByPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountBasicByPkVars)),
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
            specifiedType: const FullType(_i2.GAccountBasicByPkData)));
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
  GAccountBasicByPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountBasicByPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountBasicByPkVars))!
              as _i3.GAccountBasicByPkVars);
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
                  specifiedType: const FullType(_i2.GAccountBasicByPkData))!
              as _i2.GAccountBasicByPkData);
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

class _$GAccountsBasicByPkReqSerializer
    implements StructuredSerializer<GAccountsBasicByPkReq> {
  @override
  final Iterable<Type> types = const [
    GAccountsBasicByPkReq,
    _$GAccountsBasicByPkReq
  ];
  @override
  final String wireName = 'GAccountsBasicByPkReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsBasicByPkReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountsBasicByPkVars)),
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
            specifiedType: const FullType(_i2.GAccountsBasicByPkData)));
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
  GAccountsBasicByPkReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsBasicByPkReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountsBasicByPkVars))!
              as _i3.GAccountsBasicByPkVars);
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
                  specifiedType: const FullType(_i2.GAccountsBasicByPkData))!
              as _i2.GAccountsBasicByPkData);
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

class _$GAccountTransactionsReqSerializer
    implements StructuredSerializer<GAccountTransactionsReq> {
  @override
  final Iterable<Type> types = const [
    GAccountTransactionsReq,
    _$GAccountTransactionsReq
  ];
  @override
  final String wireName = 'GAccountTransactionsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountTransactionsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountTransactionsVars)),
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
            specifiedType: const FullType(_i2.GAccountTransactionsData)));
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
  GAccountTransactionsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountTransactionsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountTransactionsVars))!
              as _i3.GAccountTransactionsVars);
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
                  specifiedType: const FullType(_i2.GAccountTransactionsData))!
              as _i2.GAccountTransactionsData);
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

class _$GCertFieldsReqSerializer
    implements StructuredSerializer<GCertFieldsReq> {
  @override
  final Iterable<Type> types = const [GCertFieldsReq, _$GCertFieldsReq];
  @override
  final String wireName = 'GCertFieldsReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCertFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GCertFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCertFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCertFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GCertFieldsVars))!
              as _i3.GCertFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GSmithCertFieldsReqSerializer
    implements StructuredSerializer<GSmithCertFieldsReq> {
  @override
  final Iterable<Type> types = const [
    GSmithCertFieldsReq,
    _$GSmithCertFieldsReq
  ];
  @override
  final String wireName = 'GSmithCertFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSmithCertFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GSmithCertFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSmithCertFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSmithCertFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GSmithCertFieldsVars))!
              as _i3.GSmithCertFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GSmithFieldsReqSerializer
    implements StructuredSerializer<GSmithFieldsReq> {
  @override
  final Iterable<Type> types = const [GSmithFieldsReq, _$GSmithFieldsReq];
  @override
  final String wireName = 'GSmithFieldsReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSmithFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GSmithFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSmithFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSmithFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GSmithFieldsVars))!
              as _i3.GSmithFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GOwnerKeyChangeFieldsReqSerializer
    implements StructuredSerializer<GOwnerKeyChangeFieldsReq> {
  @override
  final Iterable<Type> types = const [
    GOwnerKeyChangeFieldsReq,
    _$GOwnerKeyChangeFieldsReq
  ];
  @override
  final String wireName = 'GOwnerKeyChangeFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GOwnerKeyChangeFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GOwnerKeyChangeFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GOwnerKeyChangeFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GOwnerKeyChangeFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GOwnerKeyChangeFieldsVars))!
              as _i3.GOwnerKeyChangeFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GIdentityBasicFieldsReqSerializer
    implements StructuredSerializer<GIdentityBasicFieldsReq> {
  @override
  final Iterable<Type> types = const [
    GIdentityBasicFieldsReq,
    _$GIdentityBasicFieldsReq
  ];
  @override
  final String wireName = 'GIdentityBasicFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentityBasicFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GIdentityBasicFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GIdentityBasicFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentityBasicFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GIdentityBasicFieldsVars))!
              as _i3.GIdentityBasicFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GIdentityFieldsReqSerializer
    implements StructuredSerializer<GIdentityFieldsReq> {
  @override
  final Iterable<Type> types = const [GIdentityFieldsReq, _$GIdentityFieldsReq];
  @override
  final String wireName = 'GIdentityFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentityFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GIdentityFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GIdentityFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentityFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GIdentityFieldsVars))!
              as _i3.GIdentityFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GCommentsIssuedReqSerializer
    implements StructuredSerializer<GCommentsIssuedReq> {
  @override
  final Iterable<Type> types = const [GCommentsIssuedReq, _$GCommentsIssuedReq];
  @override
  final String wireName = 'GCommentsIssuedReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentsIssuedReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GCommentsIssuedVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCommentsIssuedReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GCommentsIssuedReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GCommentsIssuedVars))!
              as _i3.GCommentsIssuedVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountBasicFieldsReqSerializer
    implements StructuredSerializer<GAccountBasicFieldsReq> {
  @override
  final Iterable<Type> types = const [
    GAccountBasicFieldsReq,
    _$GAccountBasicFieldsReq
  ];
  @override
  final String wireName = 'GAccountBasicFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountBasicFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountBasicFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAccountBasicFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountBasicFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountBasicFieldsVars))!
              as _i3.GAccountBasicFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountFieldsReqSerializer
    implements StructuredSerializer<GAccountFieldsReq> {
  @override
  final Iterable<Type> types = const [GAccountFieldsReq, _$GAccountFieldsReq];
  @override
  final String wireName = 'GAccountFieldsReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAccountFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountFieldsVars))!
              as _i3.GAccountFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountTxsFieldsReqSerializer
    implements StructuredSerializer<GAccountTxsFieldsReq> {
  @override
  final Iterable<Type> types = const [
    GAccountTxsFieldsReq,
    _$GAccountTxsFieldsReq
  ];
  @override
  final String wireName = 'GAccountTxsFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountTxsFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GAccountTxsFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAccountTxsFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountTxsFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAccountTxsFieldsVars))!
              as _i3.GAccountTxsFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GTransferFieldsReqSerializer
    implements StructuredSerializer<GTransferFieldsReq> {
  @override
  final Iterable<Type> types = const [GTransferFieldsReq, _$GTransferFieldsReq];
  @override
  final String wireName = 'GTransferFieldsReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTransferFieldsReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GTransferFieldsVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GTransferFieldsReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GTransferFieldsReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GTransferFieldsVars))!
              as _i3.GTransferFieldsVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GLastBlockReq extends GLastBlockReq {
  @override
  final _i3.GLastBlockVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GLastBlockData? Function(_i2.GLastBlockData?, _i2.GLastBlockData?)?
      updateResult;
  @override
  final _i2.GLastBlockData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GLastBlockReq([void Function(GLastBlockReqBuilder)? updates]) =>
      (new GLastBlockReqBuilder()..update(updates))._build();

  _$GLastBlockReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GLastBlockReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GLastBlockReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GLastBlockReq', 'executeOnListen');
  }

  @override
  GLastBlockReq rebuild(void Function(GLastBlockReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastBlockReqBuilder toBuilder() => new GLastBlockReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GLastBlockReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLastBlockReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GLastBlockReqBuilder
    implements Builder<GLastBlockReq, GLastBlockReqBuilder> {
  _$GLastBlockReq? _$v;

  _i3.GLastBlockVarsBuilder? _vars;
  _i3.GLastBlockVarsBuilder get vars =>
      _$this._vars ??= new _i3.GLastBlockVarsBuilder();
  set vars(_i3.GLastBlockVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GLastBlockData? Function(_i2.GLastBlockData?, _i2.GLastBlockData?)?
      _updateResult;
  _i2.GLastBlockData? Function(_i2.GLastBlockData?, _i2.GLastBlockData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GLastBlockData? Function(
                  _i2.GLastBlockData?, _i2.GLastBlockData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GLastBlockDataBuilder? _optimisticResponse;
  _i2.GLastBlockDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GLastBlockDataBuilder();
  set optimisticResponse(_i2.GLastBlockDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GLastBlockReqBuilder() {
    GLastBlockReq._initializeBuilder(this);
  }

  GLastBlockReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastBlockReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastBlockReq;
  }

  @override
  void update(void Function(GLastBlockReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastBlockReq build() => _build();

  _$GLastBlockReq _build() {
    _$GLastBlockReq _$result;
    try {
      _$result = _$v ??
          new _$GLastBlockReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GLastBlockReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GLastBlockReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLastBlockReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByNameOrPkReq extends GIdentitiesByNameOrPkReq {
  @override
  final _i3.GIdentitiesByNameOrPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GIdentitiesByNameOrPkData? Function(
          _i2.GIdentitiesByNameOrPkData?, _i2.GIdentitiesByNameOrPkData?)?
      updateResult;
  @override
  final _i2.GIdentitiesByNameOrPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GIdentitiesByNameOrPkReq(
          [void Function(GIdentitiesByNameOrPkReqBuilder)? updates]) =>
      (new GIdentitiesByNameOrPkReqBuilder()..update(updates))._build();

  _$GIdentitiesByNameOrPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GIdentitiesByNameOrPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GIdentitiesByNameOrPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GIdentitiesByNameOrPkReq', 'executeOnListen');
  }

  @override
  GIdentitiesByNameOrPkReq rebuild(
          void Function(GIdentitiesByNameOrPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByNameOrPkReqBuilder toBuilder() =>
      new GIdentitiesByNameOrPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GIdentitiesByNameOrPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByNameOrPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GIdentitiesByNameOrPkReqBuilder
    implements
        Builder<GIdentitiesByNameOrPkReq, GIdentitiesByNameOrPkReqBuilder> {
  _$GIdentitiesByNameOrPkReq? _$v;

  _i3.GIdentitiesByNameOrPkVarsBuilder? _vars;
  _i3.GIdentitiesByNameOrPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GIdentitiesByNameOrPkVarsBuilder();
  set vars(_i3.GIdentitiesByNameOrPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GIdentitiesByNameOrPkData? Function(
          _i2.GIdentitiesByNameOrPkData?, _i2.GIdentitiesByNameOrPkData?)?
      _updateResult;
  _i2.GIdentitiesByNameOrPkData? Function(
          _i2.GIdentitiesByNameOrPkData?, _i2.GIdentitiesByNameOrPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GIdentitiesByNameOrPkData? Function(
                  _i2.GIdentitiesByNameOrPkData?,
                  _i2.GIdentitiesByNameOrPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GIdentitiesByNameOrPkDataBuilder? _optimisticResponse;
  _i2.GIdentitiesByNameOrPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GIdentitiesByNameOrPkDataBuilder();
  set optimisticResponse(
          _i2.GIdentitiesByNameOrPkDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GIdentitiesByNameOrPkReqBuilder() {
    GIdentitiesByNameOrPkReq._initializeBuilder(this);
  }

  GIdentitiesByNameOrPkReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByNameOrPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByNameOrPkReq;
  }

  @override
  void update(void Function(GIdentitiesByNameOrPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByNameOrPkReq build() => _build();

  _$GIdentitiesByNameOrPkReq _build() {
    _$GIdentitiesByNameOrPkReq _$result;
    try {
      _$result = _$v ??
          new _$GIdentitiesByNameOrPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GIdentitiesByNameOrPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen,
                  r'GIdentitiesByNameOrPkReq',
                  'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentitiesByNameOrPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByPkReq extends GIdentitiesByPkReq {
  @override
  final _i3.GIdentitiesByPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GIdentitiesByPkData? Function(
      _i2.GIdentitiesByPkData?, _i2.GIdentitiesByPkData?)? updateResult;
  @override
  final _i2.GIdentitiesByPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GIdentitiesByPkReq(
          [void Function(GIdentitiesByPkReqBuilder)? updates]) =>
      (new GIdentitiesByPkReqBuilder()..update(updates))._build();

  _$GIdentitiesByPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GIdentitiesByPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GIdentitiesByPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GIdentitiesByPkReq', 'executeOnListen');
  }

  @override
  GIdentitiesByPkReq rebuild(
          void Function(GIdentitiesByPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByPkReqBuilder toBuilder() =>
      new GIdentitiesByPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GIdentitiesByPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GIdentitiesByPkReqBuilder
    implements Builder<GIdentitiesByPkReq, GIdentitiesByPkReqBuilder> {
  _$GIdentitiesByPkReq? _$v;

  _i3.GIdentitiesByPkVarsBuilder? _vars;
  _i3.GIdentitiesByPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GIdentitiesByPkVarsBuilder();
  set vars(_i3.GIdentitiesByPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GIdentitiesByPkData? Function(
      _i2.GIdentitiesByPkData?, _i2.GIdentitiesByPkData?)? _updateResult;
  _i2.GIdentitiesByPkData? Function(
          _i2.GIdentitiesByPkData?, _i2.GIdentitiesByPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GIdentitiesByPkData? Function(
                  _i2.GIdentitiesByPkData?, _i2.GIdentitiesByPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GIdentitiesByPkDataBuilder? _optimisticResponse;
  _i2.GIdentitiesByPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GIdentitiesByPkDataBuilder();
  set optimisticResponse(_i2.GIdentitiesByPkDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GIdentitiesByPkReqBuilder() {
    GIdentitiesByPkReq._initializeBuilder(this);
  }

  GIdentitiesByPkReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByPkReq;
  }

  @override
  void update(void Function(GIdentitiesByPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByPkReq build() => _build();

  _$GIdentitiesByPkReq _build() {
    _$GIdentitiesByPkReq _$result;
    try {
      _$result = _$v ??
          new _$GIdentitiesByPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GIdentitiesByPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GIdentitiesByPkReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentitiesByPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByNameReq extends GIdentitiesByNameReq {
  @override
  final _i3.GIdentitiesByNameVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GIdentitiesByNameData? Function(
      _i2.GIdentitiesByNameData?, _i2.GIdentitiesByNameData?)? updateResult;
  @override
  final _i2.GIdentitiesByNameData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GIdentitiesByNameReq(
          [void Function(GIdentitiesByNameReqBuilder)? updates]) =>
      (new GIdentitiesByNameReqBuilder()..update(updates))._build();

  _$GIdentitiesByNameReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GIdentitiesByNameReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GIdentitiesByNameReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GIdentitiesByNameReq', 'executeOnListen');
  }

  @override
  GIdentitiesByNameReq rebuild(
          void Function(GIdentitiesByNameReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByNameReqBuilder toBuilder() =>
      new GIdentitiesByNameReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GIdentitiesByNameReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByNameReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GIdentitiesByNameReqBuilder
    implements Builder<GIdentitiesByNameReq, GIdentitiesByNameReqBuilder> {
  _$GIdentitiesByNameReq? _$v;

  _i3.GIdentitiesByNameVarsBuilder? _vars;
  _i3.GIdentitiesByNameVarsBuilder get vars =>
      _$this._vars ??= new _i3.GIdentitiesByNameVarsBuilder();
  set vars(_i3.GIdentitiesByNameVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GIdentitiesByNameData? Function(
      _i2.GIdentitiesByNameData?, _i2.GIdentitiesByNameData?)? _updateResult;
  _i2.GIdentitiesByNameData? Function(
          _i2.GIdentitiesByNameData?, _i2.GIdentitiesByNameData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GIdentitiesByNameData? Function(
                  _i2.GIdentitiesByNameData?, _i2.GIdentitiesByNameData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GIdentitiesByNameDataBuilder? _optimisticResponse;
  _i2.GIdentitiesByNameDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GIdentitiesByNameDataBuilder();
  set optimisticResponse(
          _i2.GIdentitiesByNameDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GIdentitiesByNameReqBuilder() {
    GIdentitiesByNameReq._initializeBuilder(this);
  }

  GIdentitiesByNameReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByNameReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByNameReq;
  }

  @override
  void update(void Function(GIdentitiesByNameReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByNameReq build() => _build();

  _$GIdentitiesByNameReq _build() {
    _$GIdentitiesByNameReq _$result;
    try {
      _$result = _$v ??
          new _$GIdentitiesByNameReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GIdentitiesByNameReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GIdentitiesByNameReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentitiesByNameReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountByPkReq extends GAccountByPkReq {
  @override
  final _i3.GAccountByPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountByPkData? Function(
      _i2.GAccountByPkData?, _i2.GAccountByPkData?)? updateResult;
  @override
  final _i2.GAccountByPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GAccountByPkReq([void Function(GAccountByPkReqBuilder)? updates]) =>
      (new GAccountByPkReqBuilder()..update(updates))._build();

  _$GAccountByPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GAccountByPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountByPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountByPkReq', 'executeOnListen');
  }

  @override
  GAccountByPkReq rebuild(void Function(GAccountByPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountByPkReqBuilder toBuilder() =>
      new GAccountByPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountByPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountByPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GAccountByPkReqBuilder
    implements Builder<GAccountByPkReq, GAccountByPkReqBuilder> {
  _$GAccountByPkReq? _$v;

  _i3.GAccountByPkVarsBuilder? _vars;
  _i3.GAccountByPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountByPkVarsBuilder();
  set vars(_i3.GAccountByPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountByPkData? Function(_i2.GAccountByPkData?, _i2.GAccountByPkData?)?
      _updateResult;
  _i2.GAccountByPkData? Function(_i2.GAccountByPkData?, _i2.GAccountByPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountByPkData? Function(
                  _i2.GAccountByPkData?, _i2.GAccountByPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountByPkDataBuilder? _optimisticResponse;
  _i2.GAccountByPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountByPkDataBuilder();
  set optimisticResponse(_i2.GAccountByPkDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GAccountByPkReqBuilder() {
    GAccountByPkReq._initializeBuilder(this);
  }

  GAccountByPkReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountByPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountByPkReq;
  }

  @override
  void update(void Function(GAccountByPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountByPkReq build() => _build();

  _$GAccountByPkReq _build() {
    _$GAccountByPkReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountByPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountByPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GAccountByPkReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountByPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
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
  @override
  final _i4.Context? context;

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
      required this.executeOnListen,
      this.context})
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
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
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
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

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
      _context = $v.context;
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
                  executeOnListen, r'GAccountsByPkReq', 'executeOnListen'),
              context: context);
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

class _$GAccountBasicByPkReq extends GAccountBasicByPkReq {
  @override
  final _i3.GAccountBasicByPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountBasicByPkData? Function(
      _i2.GAccountBasicByPkData?, _i2.GAccountBasicByPkData?)? updateResult;
  @override
  final _i2.GAccountBasicByPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GAccountBasicByPkReq(
          [void Function(GAccountBasicByPkReqBuilder)? updates]) =>
      (new GAccountBasicByPkReqBuilder()..update(updates))._build();

  _$GAccountBasicByPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountBasicByPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountBasicByPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountBasicByPkReq', 'executeOnListen');
  }

  @override
  GAccountBasicByPkReq rebuild(
          void Function(GAccountBasicByPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountBasicByPkReqBuilder toBuilder() =>
      new GAccountBasicByPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountBasicByPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountBasicByPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GAccountBasicByPkReqBuilder
    implements Builder<GAccountBasicByPkReq, GAccountBasicByPkReqBuilder> {
  _$GAccountBasicByPkReq? _$v;

  _i3.GAccountBasicByPkVarsBuilder? _vars;
  _i3.GAccountBasicByPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountBasicByPkVarsBuilder();
  set vars(_i3.GAccountBasicByPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountBasicByPkData? Function(
      _i2.GAccountBasicByPkData?, _i2.GAccountBasicByPkData?)? _updateResult;
  _i2.GAccountBasicByPkData? Function(
          _i2.GAccountBasicByPkData?, _i2.GAccountBasicByPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountBasicByPkData? Function(
                  _i2.GAccountBasicByPkData?, _i2.GAccountBasicByPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountBasicByPkDataBuilder? _optimisticResponse;
  _i2.GAccountBasicByPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountBasicByPkDataBuilder();
  set optimisticResponse(
          _i2.GAccountBasicByPkDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GAccountBasicByPkReqBuilder() {
    GAccountBasicByPkReq._initializeBuilder(this);
  }

  GAccountBasicByPkReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountBasicByPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountBasicByPkReq;
  }

  @override
  void update(void Function(GAccountBasicByPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountBasicByPkReq build() => _build();

  _$GAccountBasicByPkReq _build() {
    _$GAccountBasicByPkReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountBasicByPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountBasicByPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GAccountBasicByPkReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountBasicByPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsBasicByPkReq extends GAccountsBasicByPkReq {
  @override
  final _i3.GAccountsBasicByPkVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountsBasicByPkData? Function(
      _i2.GAccountsBasicByPkData?, _i2.GAccountsBasicByPkData?)? updateResult;
  @override
  final _i2.GAccountsBasicByPkData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GAccountsBasicByPkReq(
          [void Function(GAccountsBasicByPkReqBuilder)? updates]) =>
      (new GAccountsBasicByPkReqBuilder()..update(updates))._build();

  _$GAccountsBasicByPkReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountsBasicByPkReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountsBasicByPkReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountsBasicByPkReq', 'executeOnListen');
  }

  @override
  GAccountsBasicByPkReq rebuild(
          void Function(GAccountsBasicByPkReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsBasicByPkReqBuilder toBuilder() =>
      new GAccountsBasicByPkReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountsBasicByPkReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsBasicByPkReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GAccountsBasicByPkReqBuilder
    implements Builder<GAccountsBasicByPkReq, GAccountsBasicByPkReqBuilder> {
  _$GAccountsBasicByPkReq? _$v;

  _i3.GAccountsBasicByPkVarsBuilder? _vars;
  _i3.GAccountsBasicByPkVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountsBasicByPkVarsBuilder();
  set vars(_i3.GAccountsBasicByPkVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountsBasicByPkData? Function(
      _i2.GAccountsBasicByPkData?, _i2.GAccountsBasicByPkData?)? _updateResult;
  _i2.GAccountsBasicByPkData? Function(
          _i2.GAccountsBasicByPkData?, _i2.GAccountsBasicByPkData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountsBasicByPkData? Function(
                  _i2.GAccountsBasicByPkData?, _i2.GAccountsBasicByPkData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountsBasicByPkDataBuilder? _optimisticResponse;
  _i2.GAccountsBasicByPkDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountsBasicByPkDataBuilder();
  set optimisticResponse(
          _i2.GAccountsBasicByPkDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GAccountsBasicByPkReqBuilder() {
    GAccountsBasicByPkReq._initializeBuilder(this);
  }

  GAccountsBasicByPkReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsBasicByPkReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsBasicByPkReq;
  }

  @override
  void update(void Function(GAccountsBasicByPkReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsBasicByPkReq build() => _build();

  _$GAccountsBasicByPkReq _build() {
    _$GAccountsBasicByPkReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountsBasicByPkReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountsBasicByPkReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen, r'GAccountsBasicByPkReq', 'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsBasicByPkReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountTransactionsReq extends GAccountTransactionsReq {
  @override
  final _i3.GAccountTransactionsVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GAccountTransactionsData? Function(
          _i2.GAccountTransactionsData?, _i2.GAccountTransactionsData?)?
      updateResult;
  @override
  final _i2.GAccountTransactionsData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GAccountTransactionsReq(
          [void Function(GAccountTransactionsReqBuilder)? updates]) =>
      (new GAccountTransactionsReqBuilder()..update(updates))._build();

  _$GAccountTransactionsReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountTransactionsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        operation, r'GAccountTransactionsReq', 'operation');
    BuiltValueNullFieldError.checkNotNull(
        executeOnListen, r'GAccountTransactionsReq', 'executeOnListen');
  }

  @override
  GAccountTransactionsReq rebuild(
          void Function(GAccountTransactionsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountTransactionsReqBuilder toBuilder() =>
      new GAccountTransactionsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is GAccountTransactionsReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == _$dynamicOther.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
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
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountTransactionsReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GAccountTransactionsReqBuilder
    implements
        Builder<GAccountTransactionsReq, GAccountTransactionsReqBuilder> {
  _$GAccountTransactionsReq? _$v;

  _i3.GAccountTransactionsVarsBuilder? _vars;
  _i3.GAccountTransactionsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountTransactionsVarsBuilder();
  set vars(_i3.GAccountTransactionsVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GAccountTransactionsData? Function(
          _i2.GAccountTransactionsData?, _i2.GAccountTransactionsData?)?
      _updateResult;
  _i2.GAccountTransactionsData? Function(
          _i2.GAccountTransactionsData?, _i2.GAccountTransactionsData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GAccountTransactionsData? Function(
                  _i2.GAccountTransactionsData?, _i2.GAccountTransactionsData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GAccountTransactionsDataBuilder? _optimisticResponse;
  _i2.GAccountTransactionsDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= new _i2.GAccountTransactionsDataBuilder();
  set optimisticResponse(
          _i2.GAccountTransactionsDataBuilder? optimisticResponse) =>
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

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GAccountTransactionsReqBuilder() {
    GAccountTransactionsReq._initializeBuilder(this);
  }

  GAccountTransactionsReqBuilder get _$this {
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
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountTransactionsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountTransactionsReq;
  }

  @override
  void update(void Function(GAccountTransactionsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountTransactionsReq build() => _build();

  _$GAccountTransactionsReq _build() {
    _$GAccountTransactionsReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountTransactionsReq._(
              vars: vars.build(),
              operation: BuiltValueNullFieldError.checkNotNull(
                  operation, r'GAccountTransactionsReq', 'operation'),
              requestId: requestId,
              updateResult: updateResult,
              optimisticResponse: _optimisticResponse?.build(),
              updateCacheHandlerKey: updateCacheHandlerKey,
              updateCacheHandlerContext: updateCacheHandlerContext,
              fetchPolicy: fetchPolicy,
              executeOnListen: BuiltValueNullFieldError.checkNotNull(
                  executeOnListen,
                  r'GAccountTransactionsReq',
                  'executeOnListen'),
              context: context);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountTransactionsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCertFieldsReq extends GCertFieldsReq {
  @override
  final _i3.GCertFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GCertFieldsReq([void Function(GCertFieldsReqBuilder)? updates]) =>
      (new GCertFieldsReqBuilder()..update(updates))._build();

  _$GCertFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GCertFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GCertFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GCertFieldsReq', 'idFields');
  }

  @override
  GCertFieldsReq rebuild(void Function(GCertFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCertFieldsReqBuilder toBuilder() =>
      new GCertFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCertFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCertFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GCertFieldsReqBuilder
    implements Builder<GCertFieldsReq, GCertFieldsReqBuilder> {
  _$GCertFieldsReq? _$v;

  _i3.GCertFieldsVarsBuilder? _vars;
  _i3.GCertFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GCertFieldsVarsBuilder();
  set vars(_i3.GCertFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GCertFieldsReqBuilder() {
    GCertFieldsReq._initializeBuilder(this);
  }

  GCertFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCertFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCertFieldsReq;
  }

  @override
  void update(void Function(GCertFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCertFieldsReq build() => _build();

  _$GCertFieldsReq _build() {
    _$GCertFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GCertFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GCertFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GCertFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCertFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSmithCertFieldsReq extends GSmithCertFieldsReq {
  @override
  final _i3.GSmithCertFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GSmithCertFieldsReq(
          [void Function(GSmithCertFieldsReqBuilder)? updates]) =>
      (new GSmithCertFieldsReqBuilder()..update(updates))._build();

  _$GSmithCertFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GSmithCertFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GSmithCertFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GSmithCertFieldsReq', 'idFields');
  }

  @override
  GSmithCertFieldsReq rebuild(
          void Function(GSmithCertFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSmithCertFieldsReqBuilder toBuilder() =>
      new GSmithCertFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSmithCertFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSmithCertFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GSmithCertFieldsReqBuilder
    implements Builder<GSmithCertFieldsReq, GSmithCertFieldsReqBuilder> {
  _$GSmithCertFieldsReq? _$v;

  _i3.GSmithCertFieldsVarsBuilder? _vars;
  _i3.GSmithCertFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GSmithCertFieldsVarsBuilder();
  set vars(_i3.GSmithCertFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GSmithCertFieldsReqBuilder() {
    GSmithCertFieldsReq._initializeBuilder(this);
  }

  GSmithCertFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSmithCertFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSmithCertFieldsReq;
  }

  @override
  void update(void Function(GSmithCertFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSmithCertFieldsReq build() => _build();

  _$GSmithCertFieldsReq _build() {
    _$GSmithCertFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GSmithCertFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GSmithCertFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GSmithCertFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSmithCertFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSmithFieldsReq extends GSmithFieldsReq {
  @override
  final _i3.GSmithFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GSmithFieldsReq([void Function(GSmithFieldsReqBuilder)? updates]) =>
      (new GSmithFieldsReqBuilder()..update(updates))._build();

  _$GSmithFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GSmithFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GSmithFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GSmithFieldsReq', 'idFields');
  }

  @override
  GSmithFieldsReq rebuild(void Function(GSmithFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSmithFieldsReqBuilder toBuilder() =>
      new GSmithFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSmithFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSmithFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GSmithFieldsReqBuilder
    implements Builder<GSmithFieldsReq, GSmithFieldsReqBuilder> {
  _$GSmithFieldsReq? _$v;

  _i3.GSmithFieldsVarsBuilder? _vars;
  _i3.GSmithFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GSmithFieldsVarsBuilder();
  set vars(_i3.GSmithFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GSmithFieldsReqBuilder() {
    GSmithFieldsReq._initializeBuilder(this);
  }

  GSmithFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSmithFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSmithFieldsReq;
  }

  @override
  void update(void Function(GSmithFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSmithFieldsReq build() => _build();

  _$GSmithFieldsReq _build() {
    _$GSmithFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GSmithFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GSmithFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GSmithFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSmithFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GOwnerKeyChangeFieldsReq extends GOwnerKeyChangeFieldsReq {
  @override
  final _i3.GOwnerKeyChangeFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GOwnerKeyChangeFieldsReq(
          [void Function(GOwnerKeyChangeFieldsReqBuilder)? updates]) =>
      (new GOwnerKeyChangeFieldsReqBuilder()..update(updates))._build();

  _$GOwnerKeyChangeFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GOwnerKeyChangeFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GOwnerKeyChangeFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GOwnerKeyChangeFieldsReq', 'idFields');
  }

  @override
  GOwnerKeyChangeFieldsReq rebuild(
          void Function(GOwnerKeyChangeFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOwnerKeyChangeFieldsReqBuilder toBuilder() =>
      new GOwnerKeyChangeFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOwnerKeyChangeFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOwnerKeyChangeFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GOwnerKeyChangeFieldsReqBuilder
    implements
        Builder<GOwnerKeyChangeFieldsReq, GOwnerKeyChangeFieldsReqBuilder> {
  _$GOwnerKeyChangeFieldsReq? _$v;

  _i3.GOwnerKeyChangeFieldsVarsBuilder? _vars;
  _i3.GOwnerKeyChangeFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GOwnerKeyChangeFieldsVarsBuilder();
  set vars(_i3.GOwnerKeyChangeFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GOwnerKeyChangeFieldsReqBuilder() {
    GOwnerKeyChangeFieldsReq._initializeBuilder(this);
  }

  GOwnerKeyChangeFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOwnerKeyChangeFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GOwnerKeyChangeFieldsReq;
  }

  @override
  void update(void Function(GOwnerKeyChangeFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOwnerKeyChangeFieldsReq build() => _build();

  _$GOwnerKeyChangeFieldsReq _build() {
    _$GOwnerKeyChangeFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GOwnerKeyChangeFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GOwnerKeyChangeFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GOwnerKeyChangeFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GOwnerKeyChangeFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentityBasicFieldsReq extends GIdentityBasicFieldsReq {
  @override
  final _i3.GIdentityBasicFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GIdentityBasicFieldsReq(
          [void Function(GIdentityBasicFieldsReqBuilder)? updates]) =>
      (new GIdentityBasicFieldsReqBuilder()..update(updates))._build();

  _$GIdentityBasicFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GIdentityBasicFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GIdentityBasicFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GIdentityBasicFieldsReq', 'idFields');
  }

  @override
  GIdentityBasicFieldsReq rebuild(
          void Function(GIdentityBasicFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentityBasicFieldsReqBuilder toBuilder() =>
      new GIdentityBasicFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentityBasicFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentityBasicFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GIdentityBasicFieldsReqBuilder
    implements
        Builder<GIdentityBasicFieldsReq, GIdentityBasicFieldsReqBuilder> {
  _$GIdentityBasicFieldsReq? _$v;

  _i3.GIdentityBasicFieldsVarsBuilder? _vars;
  _i3.GIdentityBasicFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GIdentityBasicFieldsVarsBuilder();
  set vars(_i3.GIdentityBasicFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GIdentityBasicFieldsReqBuilder() {
    GIdentityBasicFieldsReq._initializeBuilder(this);
  }

  GIdentityBasicFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentityBasicFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentityBasicFieldsReq;
  }

  @override
  void update(void Function(GIdentityBasicFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentityBasicFieldsReq build() => _build();

  _$GIdentityBasicFieldsReq _build() {
    _$GIdentityBasicFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GIdentityBasicFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GIdentityBasicFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GIdentityBasicFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentityBasicFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentityFieldsReq extends GIdentityFieldsReq {
  @override
  final _i3.GIdentityFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GIdentityFieldsReq(
          [void Function(GIdentityFieldsReqBuilder)? updates]) =>
      (new GIdentityFieldsReqBuilder()..update(updates))._build();

  _$GIdentityFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GIdentityFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GIdentityFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GIdentityFieldsReq', 'idFields');
  }

  @override
  GIdentityFieldsReq rebuild(
          void Function(GIdentityFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentityFieldsReqBuilder toBuilder() =>
      new GIdentityFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentityFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentityFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GIdentityFieldsReqBuilder
    implements Builder<GIdentityFieldsReq, GIdentityFieldsReqBuilder> {
  _$GIdentityFieldsReq? _$v;

  _i3.GIdentityFieldsVarsBuilder? _vars;
  _i3.GIdentityFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GIdentityFieldsVarsBuilder();
  set vars(_i3.GIdentityFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GIdentityFieldsReqBuilder() {
    GIdentityFieldsReq._initializeBuilder(this);
  }

  GIdentityFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentityFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentityFieldsReq;
  }

  @override
  void update(void Function(GIdentityFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentityFieldsReq build() => _build();

  _$GIdentityFieldsReq _build() {
    _$GIdentityFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GIdentityFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GIdentityFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GIdentityFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentityFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCommentsIssuedReq extends GCommentsIssuedReq {
  @override
  final _i3.GCommentsIssuedVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GCommentsIssuedReq(
          [void Function(GCommentsIssuedReqBuilder)? updates]) =>
      (new GCommentsIssuedReqBuilder()..update(updates))._build();

  _$GCommentsIssuedReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GCommentsIssuedReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GCommentsIssuedReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GCommentsIssuedReq', 'idFields');
  }

  @override
  GCommentsIssuedReq rebuild(
          void Function(GCommentsIssuedReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentsIssuedReqBuilder toBuilder() =>
      new GCommentsIssuedReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentsIssuedReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCommentsIssuedReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GCommentsIssuedReqBuilder
    implements Builder<GCommentsIssuedReq, GCommentsIssuedReqBuilder> {
  _$GCommentsIssuedReq? _$v;

  _i3.GCommentsIssuedVarsBuilder? _vars;
  _i3.GCommentsIssuedVarsBuilder get vars =>
      _$this._vars ??= new _i3.GCommentsIssuedVarsBuilder();
  set vars(_i3.GCommentsIssuedVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GCommentsIssuedReqBuilder() {
    GCommentsIssuedReq._initializeBuilder(this);
  }

  GCommentsIssuedReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCommentsIssuedReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCommentsIssuedReq;
  }

  @override
  void update(void Function(GCommentsIssuedReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentsIssuedReq build() => _build();

  _$GCommentsIssuedReq _build() {
    _$GCommentsIssuedReq _$result;
    try {
      _$result = _$v ??
          new _$GCommentsIssuedReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GCommentsIssuedReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GCommentsIssuedReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GCommentsIssuedReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountBasicFieldsReq extends GAccountBasicFieldsReq {
  @override
  final _i3.GAccountBasicFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GAccountBasicFieldsReq(
          [void Function(GAccountBasicFieldsReqBuilder)? updates]) =>
      (new GAccountBasicFieldsReqBuilder()..update(updates))._build();

  _$GAccountBasicFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountBasicFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GAccountBasicFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GAccountBasicFieldsReq', 'idFields');
  }

  @override
  GAccountBasicFieldsReq rebuild(
          void Function(GAccountBasicFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountBasicFieldsReqBuilder toBuilder() =>
      new GAccountBasicFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountBasicFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountBasicFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GAccountBasicFieldsReqBuilder
    implements Builder<GAccountBasicFieldsReq, GAccountBasicFieldsReqBuilder> {
  _$GAccountBasicFieldsReq? _$v;

  _i3.GAccountBasicFieldsVarsBuilder? _vars;
  _i3.GAccountBasicFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountBasicFieldsVarsBuilder();
  set vars(_i3.GAccountBasicFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GAccountBasicFieldsReqBuilder() {
    GAccountBasicFieldsReq._initializeBuilder(this);
  }

  GAccountBasicFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountBasicFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountBasicFieldsReq;
  }

  @override
  void update(void Function(GAccountBasicFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountBasicFieldsReq build() => _build();

  _$GAccountBasicFieldsReq _build() {
    _$GAccountBasicFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountBasicFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GAccountBasicFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GAccountBasicFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountBasicFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountFieldsReq extends GAccountFieldsReq {
  @override
  final _i3.GAccountFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GAccountFieldsReq(
          [void Function(GAccountFieldsReqBuilder)? updates]) =>
      (new GAccountFieldsReqBuilder()..update(updates))._build();

  _$GAccountFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GAccountFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GAccountFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GAccountFieldsReq', 'idFields');
  }

  @override
  GAccountFieldsReq rebuild(void Function(GAccountFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountFieldsReqBuilder toBuilder() =>
      new GAccountFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GAccountFieldsReqBuilder
    implements Builder<GAccountFieldsReq, GAccountFieldsReqBuilder> {
  _$GAccountFieldsReq? _$v;

  _i3.GAccountFieldsVarsBuilder? _vars;
  _i3.GAccountFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountFieldsVarsBuilder();
  set vars(_i3.GAccountFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GAccountFieldsReqBuilder() {
    GAccountFieldsReq._initializeBuilder(this);
  }

  GAccountFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountFieldsReq;
  }

  @override
  void update(void Function(GAccountFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountFieldsReq build() => _build();

  _$GAccountFieldsReq _build() {
    _$GAccountFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GAccountFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GAccountFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountTxsFieldsReq extends GAccountTxsFieldsReq {
  @override
  final _i3.GAccountTxsFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GAccountTxsFieldsReq(
          [void Function(GAccountTxsFieldsReqBuilder)? updates]) =>
      (new GAccountTxsFieldsReqBuilder()..update(updates))._build();

  _$GAccountTxsFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        vars, r'GAccountTxsFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GAccountTxsFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GAccountTxsFieldsReq', 'idFields');
  }

  @override
  GAccountTxsFieldsReq rebuild(
          void Function(GAccountTxsFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountTxsFieldsReqBuilder toBuilder() =>
      new GAccountTxsFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountTxsFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountTxsFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GAccountTxsFieldsReqBuilder
    implements Builder<GAccountTxsFieldsReq, GAccountTxsFieldsReqBuilder> {
  _$GAccountTxsFieldsReq? _$v;

  _i3.GAccountTxsFieldsVarsBuilder? _vars;
  _i3.GAccountTxsFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GAccountTxsFieldsVarsBuilder();
  set vars(_i3.GAccountTxsFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GAccountTxsFieldsReqBuilder() {
    GAccountTxsFieldsReq._initializeBuilder(this);
  }

  GAccountTxsFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountTxsFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountTxsFieldsReq;
  }

  @override
  void update(void Function(GAccountTxsFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountTxsFieldsReq build() => _build();

  _$GAccountTxsFieldsReq _build() {
    _$GAccountTxsFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GAccountTxsFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GAccountTxsFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GAccountTxsFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountTxsFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTransferFieldsReq extends GTransferFieldsReq {
  @override
  final _i3.GTransferFieldsVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GTransferFieldsReq(
          [void Function(GTransferFieldsReqBuilder)? updates]) =>
      (new GTransferFieldsReqBuilder()..update(updates))._build();

  _$GTransferFieldsReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(vars, r'GTransferFieldsReq', 'vars');
    BuiltValueNullFieldError.checkNotNull(
        document, r'GTransferFieldsReq', 'document');
    BuiltValueNullFieldError.checkNotNull(
        idFields, r'GTransferFieldsReq', 'idFields');
  }

  @override
  GTransferFieldsReq rebuild(
          void Function(GTransferFieldsReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTransferFieldsReqBuilder toBuilder() =>
      new GTransferFieldsReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTransferFieldsReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTransferFieldsReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GTransferFieldsReqBuilder
    implements Builder<GTransferFieldsReq, GTransferFieldsReqBuilder> {
  _$GTransferFieldsReq? _$v;

  _i3.GTransferFieldsVarsBuilder? _vars;
  _i3.GTransferFieldsVarsBuilder get vars =>
      _$this._vars ??= new _i3.GTransferFieldsVarsBuilder();
  set vars(_i3.GTransferFieldsVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GTransferFieldsReqBuilder() {
    GTransferFieldsReq._initializeBuilder(this);
  }

  GTransferFieldsReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTransferFieldsReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GTransferFieldsReq;
  }

  @override
  void update(void Function(GTransferFieldsReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTransferFieldsReq build() => _build();

  _$GTransferFieldsReq _build() {
    _$GTransferFieldsReq _$result;
    try {
      _$result = _$v ??
          new _$GTransferFieldsReq._(
              vars: vars.build(),
              document: BuiltValueNullFieldError.checkNotNull(
                  document, r'GTransferFieldsReq', 'document'),
              fragmentName: fragmentName,
              idFields: BuiltValueNullFieldError.checkNotNull(
                  idFields, r'GTransferFieldsReq', 'idFields'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GTransferFieldsReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
