// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-indexer-queries.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLastBlockVars> _$gLastBlockVarsSerializer =
    new _$GLastBlockVarsSerializer();
Serializer<GIdentitiesByNameOrPkVars> _$gIdentitiesByNameOrPkVarsSerializer =
    new _$GIdentitiesByNameOrPkVarsSerializer();
Serializer<GIdentitiesByPkVars> _$gIdentitiesByPkVarsSerializer =
    new _$GIdentitiesByPkVarsSerializer();
Serializer<GIdentitiesByNameVars> _$gIdentitiesByNameVarsSerializer =
    new _$GIdentitiesByNameVarsSerializer();
Serializer<GAccountByPkVars> _$gAccountByPkVarsSerializer =
    new _$GAccountByPkVarsSerializer();
Serializer<GAccountsByPkVars> _$gAccountsByPkVarsSerializer =
    new _$GAccountsByPkVarsSerializer();
Serializer<GAccountBasicByPkVars> _$gAccountBasicByPkVarsSerializer =
    new _$GAccountBasicByPkVarsSerializer();
Serializer<GAccountsBasicByPkVars> _$gAccountsBasicByPkVarsSerializer =
    new _$GAccountsBasicByPkVarsSerializer();
Serializer<GAccountTransactionsVars> _$gAccountTransactionsVarsSerializer =
    new _$GAccountTransactionsVarsSerializer();
Serializer<GCertFieldsVars> _$gCertFieldsVarsSerializer =
    new _$GCertFieldsVarsSerializer();
Serializer<GSmithCertFieldsVars> _$gSmithCertFieldsVarsSerializer =
    new _$GSmithCertFieldsVarsSerializer();
Serializer<GSmithFieldsVars> _$gSmithFieldsVarsSerializer =
    new _$GSmithFieldsVarsSerializer();
Serializer<GOwnerKeyChangeFieldsVars> _$gOwnerKeyChangeFieldsVarsSerializer =
    new _$GOwnerKeyChangeFieldsVarsSerializer();
Serializer<GIdentityBasicFieldsVars> _$gIdentityBasicFieldsVarsSerializer =
    new _$GIdentityBasicFieldsVarsSerializer();
Serializer<GIdentityFieldsVars> _$gIdentityFieldsVarsSerializer =
    new _$GIdentityFieldsVarsSerializer();
Serializer<GCommentsIssuedVars> _$gCommentsIssuedVarsSerializer =
    new _$GCommentsIssuedVarsSerializer();
Serializer<GAccountBasicFieldsVars> _$gAccountBasicFieldsVarsSerializer =
    new _$GAccountBasicFieldsVarsSerializer();
Serializer<GAccountFieldsVars> _$gAccountFieldsVarsSerializer =
    new _$GAccountFieldsVarsSerializer();
Serializer<GAccountTxsFieldsVars> _$gAccountTxsFieldsVarsSerializer =
    new _$GAccountTxsFieldsVarsSerializer();
Serializer<GTransferFieldsVars> _$gTransferFieldsVarsSerializer =
    new _$GTransferFieldsVarsSerializer();

class _$GLastBlockVarsSerializer
    implements StructuredSerializer<GLastBlockVars> {
  @override
  final Iterable<Type> types = const [GLastBlockVars, _$GLastBlockVars];
  @override
  final String wireName = 'GLastBlockVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLastBlockVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GLastBlockVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GLastBlockVarsBuilder().build();
  }
}

class _$GIdentitiesByNameOrPkVarsSerializer
    implements StructuredSerializer<GIdentitiesByNameOrPkVars> {
  @override
  final Iterable<Type> types = const [
    GIdentitiesByNameOrPkVars,
    _$GIdentitiesByNameOrPkVars
  ];
  @override
  final String wireName = 'GIdentitiesByNameOrPkVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByNameOrPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.pattern;
    if (value != null) {
      result
        ..add('pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GIdentitiesByNameOrPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByNameOrPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pattern':
          result.pattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GIdentitiesByPkVarsSerializer
    implements StructuredSerializer<GIdentitiesByPkVars> {
  @override
  final Iterable<Type> types = const [
    GIdentitiesByPkVars,
    _$GIdentitiesByPkVars
  ];
  @override
  final String wireName = 'GIdentitiesByPkVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pubKeys',
      serializers.serialize(object.pubKeys,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GIdentitiesByPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pubKeys':
          result.pubKeys.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GIdentitiesByNameVarsSerializer
    implements StructuredSerializer<GIdentitiesByNameVars> {
  @override
  final Iterable<Type> types = const [
    GIdentitiesByNameVars,
    _$GIdentitiesByNameVars
  ];
  @override
  final String wireName = 'GIdentitiesByNameVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentitiesByNameVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.pattern;
    if (value != null) {
      result
        ..add('pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GIdentitiesByNameVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GIdentitiesByNameVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pattern':
          result.pattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountByPkVarsSerializer
    implements StructuredSerializer<GAccountByPkVars> {
  @override
  final Iterable<Type> types = const [GAccountByPkVars, _$GAccountByPkVars];
  @override
  final String wireName = 'GAccountByPkVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountByPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GAccountByPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountByPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkVarsSerializer
    implements StructuredSerializer<GAccountsByPkVars> {
  @override
  final Iterable<Type> types = const [GAccountsByPkVars, _$GAccountsByPkVars];
  @override
  final String wireName = 'GAccountsByPkVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountsByPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'accountIds',
      serializers.serialize(object.accountIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GAccountsByPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'accountIds':
          result.accountIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountBasicByPkVarsSerializer
    implements StructuredSerializer<GAccountBasicByPkVars> {
  @override
  final Iterable<Type> types = const [
    GAccountBasicByPkVars,
    _$GAccountBasicByPkVars
  ];
  @override
  final String wireName = 'GAccountBasicByPkVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountBasicByPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAccountBasicByPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountBasicByPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsBasicByPkVarsSerializer
    implements StructuredSerializer<GAccountsBasicByPkVars> {
  @override
  final Iterable<Type> types = const [
    GAccountsBasicByPkVars,
    _$GAccountsBasicByPkVars
  ];
  @override
  final String wireName = 'GAccountsBasicByPkVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsBasicByPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'accountIds',
      serializers.serialize(object.accountIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GAccountsBasicByPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsBasicByPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'accountIds':
          result.accountIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountTransactionsVarsSerializer
    implements StructuredSerializer<GAccountTransactionsVars> {
  @override
  final Iterable<Type> types = const [
    GAccountTransactionsVars,
    _$GAccountTransactionsVars
  ];
  @override
  final String wireName = 'GAccountTransactionsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountTransactionsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'accountId',
      serializers.serialize(object.accountId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GAccountTransactionsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountTransactionsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCertFieldsVarsSerializer
    implements StructuredSerializer<GCertFieldsVars> {
  @override
  final Iterable<Type> types = const [GCertFieldsVars, _$GCertFieldsVars];
  @override
  final String wireName = 'GCertFieldsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCertFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GCertFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GCertFieldsVarsBuilder().build();
  }
}

class _$GSmithCertFieldsVarsSerializer
    implements StructuredSerializer<GSmithCertFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GSmithCertFieldsVars,
    _$GSmithCertFieldsVars
  ];
  @override
  final String wireName = 'GSmithCertFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSmithCertFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GSmithCertFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GSmithCertFieldsVarsBuilder().build();
  }
}

class _$GSmithFieldsVarsSerializer
    implements StructuredSerializer<GSmithFieldsVars> {
  @override
  final Iterable<Type> types = const [GSmithFieldsVars, _$GSmithFieldsVars];
  @override
  final String wireName = 'GSmithFieldsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSmithFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GSmithFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GSmithFieldsVarsBuilder().build();
  }
}

class _$GOwnerKeyChangeFieldsVarsSerializer
    implements StructuredSerializer<GOwnerKeyChangeFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GOwnerKeyChangeFieldsVars,
    _$GOwnerKeyChangeFieldsVars
  ];
  @override
  final String wireName = 'GOwnerKeyChangeFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GOwnerKeyChangeFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GOwnerKeyChangeFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GOwnerKeyChangeFieldsVarsBuilder().build();
  }
}

class _$GIdentityBasicFieldsVarsSerializer
    implements StructuredSerializer<GIdentityBasicFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GIdentityBasicFieldsVars,
    _$GIdentityBasicFieldsVars
  ];
  @override
  final String wireName = 'GIdentityBasicFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentityBasicFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GIdentityBasicFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GIdentityBasicFieldsVarsBuilder().build();
  }
}

class _$GIdentityFieldsVarsSerializer
    implements StructuredSerializer<GIdentityFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GIdentityFieldsVars,
    _$GIdentityFieldsVars
  ];
  @override
  final String wireName = 'GIdentityFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GIdentityFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GIdentityFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GIdentityFieldsVarsBuilder().build();
  }
}

class _$GCommentsIssuedVarsSerializer
    implements StructuredSerializer<GCommentsIssuedVars> {
  @override
  final Iterable<Type> types = const [
    GCommentsIssuedVars,
    _$GCommentsIssuedVars
  ];
  @override
  final String wireName = 'GCommentsIssuedVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentsIssuedVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GCommentsIssuedVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GCommentsIssuedVarsBuilder().build();
  }
}

class _$GAccountBasicFieldsVarsSerializer
    implements StructuredSerializer<GAccountBasicFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GAccountBasicFieldsVars,
    _$GAccountBasicFieldsVars
  ];
  @override
  final String wireName = 'GAccountBasicFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountBasicFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GAccountBasicFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GAccountBasicFieldsVarsBuilder().build();
  }
}

class _$GAccountFieldsVarsSerializer
    implements StructuredSerializer<GAccountFieldsVars> {
  @override
  final Iterable<Type> types = const [GAccountFieldsVars, _$GAccountFieldsVars];
  @override
  final String wireName = 'GAccountFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GAccountFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountFieldsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountTxsFieldsVarsSerializer
    implements StructuredSerializer<GAccountTxsFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GAccountTxsFieldsVars,
    _$GAccountTxsFieldsVars
  ];
  @override
  final String wireName = 'GAccountTxsFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountTxsFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GAccountTxsFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountTxsFieldsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GTransferFieldsVarsSerializer
    implements StructuredSerializer<GTransferFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GTransferFieldsVars,
    _$GTransferFieldsVars
  ];
  @override
  final String wireName = 'GTransferFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTransferFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GTransferFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GTransferFieldsVarsBuilder().build();
  }
}

class _$GLastBlockVars extends GLastBlockVars {
  factory _$GLastBlockVars([void Function(GLastBlockVarsBuilder)? updates]) =>
      (new GLastBlockVarsBuilder()..update(updates))._build();

  _$GLastBlockVars._() : super._();

  @override
  GLastBlockVars rebuild(void Function(GLastBlockVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastBlockVarsBuilder toBuilder() =>
      new GLastBlockVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastBlockVars;
  }

  @override
  int get hashCode {
    return 816187239;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GLastBlockVars').toString();
  }
}

class GLastBlockVarsBuilder
    implements Builder<GLastBlockVars, GLastBlockVarsBuilder> {
  _$GLastBlockVars? _$v;

  GLastBlockVarsBuilder();

  @override
  void replace(GLastBlockVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastBlockVars;
  }

  @override
  void update(void Function(GLastBlockVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastBlockVars build() => _build();

  _$GLastBlockVars _build() {
    final _$result = _$v ?? new _$GLastBlockVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByNameOrPkVars extends GIdentitiesByNameOrPkVars {
  @override
  final String? pattern;

  factory _$GIdentitiesByNameOrPkVars(
          [void Function(GIdentitiesByNameOrPkVarsBuilder)? updates]) =>
      (new GIdentitiesByNameOrPkVarsBuilder()..update(updates))._build();

  _$GIdentitiesByNameOrPkVars._({this.pattern}) : super._();

  @override
  GIdentitiesByNameOrPkVars rebuild(
          void Function(GIdentitiesByNameOrPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByNameOrPkVarsBuilder toBuilder() =>
      new GIdentitiesByNameOrPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentitiesByNameOrPkVars && pattern == other.pattern;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pattern.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByNameOrPkVars')
          ..add('pattern', pattern))
        .toString();
  }
}

class GIdentitiesByNameOrPkVarsBuilder
    implements
        Builder<GIdentitiesByNameOrPkVars, GIdentitiesByNameOrPkVarsBuilder> {
  _$GIdentitiesByNameOrPkVars? _$v;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  GIdentitiesByNameOrPkVarsBuilder();

  GIdentitiesByNameOrPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pattern = $v.pattern;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByNameOrPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByNameOrPkVars;
  }

  @override
  void update(void Function(GIdentitiesByNameOrPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByNameOrPkVars build() => _build();

  _$GIdentitiesByNameOrPkVars _build() {
    final _$result = _$v ?? new _$GIdentitiesByNameOrPkVars._(pattern: pattern);
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByPkVars extends GIdentitiesByPkVars {
  @override
  final BuiltList<String> pubKeys;

  factory _$GIdentitiesByPkVars(
          [void Function(GIdentitiesByPkVarsBuilder)? updates]) =>
      (new GIdentitiesByPkVarsBuilder()..update(updates))._build();

  _$GIdentitiesByPkVars._({required this.pubKeys}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        pubKeys, r'GIdentitiesByPkVars', 'pubKeys');
  }

  @override
  GIdentitiesByPkVars rebuild(
          void Function(GIdentitiesByPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByPkVarsBuilder toBuilder() =>
      new GIdentitiesByPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentitiesByPkVars && pubKeys == other.pubKeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pubKeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByPkVars')
          ..add('pubKeys', pubKeys))
        .toString();
  }
}

class GIdentitiesByPkVarsBuilder
    implements Builder<GIdentitiesByPkVars, GIdentitiesByPkVarsBuilder> {
  _$GIdentitiesByPkVars? _$v;

  ListBuilder<String>? _pubKeys;
  ListBuilder<String> get pubKeys =>
      _$this._pubKeys ??= new ListBuilder<String>();
  set pubKeys(ListBuilder<String>? pubKeys) => _$this._pubKeys = pubKeys;

  GIdentitiesByPkVarsBuilder();

  GIdentitiesByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pubKeys = $v.pubKeys.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByPkVars;
  }

  @override
  void update(void Function(GIdentitiesByPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByPkVars build() => _build();

  _$GIdentitiesByPkVars _build() {
    _$GIdentitiesByPkVars _$result;
    try {
      _$result = _$v ?? new _$GIdentitiesByPkVars._(pubKeys: pubKeys.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pubKeys';
        pubKeys.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GIdentitiesByPkVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GIdentitiesByNameVars extends GIdentitiesByNameVars {
  @override
  final String? pattern;

  factory _$GIdentitiesByNameVars(
          [void Function(GIdentitiesByNameVarsBuilder)? updates]) =>
      (new GIdentitiesByNameVarsBuilder()..update(updates))._build();

  _$GIdentitiesByNameVars._({this.pattern}) : super._();

  @override
  GIdentitiesByNameVars rebuild(
          void Function(GIdentitiesByNameVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentitiesByNameVarsBuilder toBuilder() =>
      new GIdentitiesByNameVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentitiesByNameVars && pattern == other.pattern;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pattern.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GIdentitiesByNameVars')
          ..add('pattern', pattern))
        .toString();
  }
}

class GIdentitiesByNameVarsBuilder
    implements Builder<GIdentitiesByNameVars, GIdentitiesByNameVarsBuilder> {
  _$GIdentitiesByNameVars? _$v;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  GIdentitiesByNameVarsBuilder();

  GIdentitiesByNameVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pattern = $v.pattern;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GIdentitiesByNameVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentitiesByNameVars;
  }

  @override
  void update(void Function(GIdentitiesByNameVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentitiesByNameVars build() => _build();

  _$GIdentitiesByNameVars _build() {
    final _$result = _$v ?? new _$GIdentitiesByNameVars._(pattern: pattern);
    replace(_$result);
    return _$result;
  }
}

class _$GAccountByPkVars extends GAccountByPkVars {
  @override
  final String id;
  @override
  final int? limit;
  @override
  final int? offset;

  factory _$GAccountByPkVars(
          [void Function(GAccountByPkVarsBuilder)? updates]) =>
      (new GAccountByPkVarsBuilder()..update(updates))._build();

  _$GAccountByPkVars._({required this.id, this.limit, this.offset})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GAccountByPkVars', 'id');
  }

  @override
  GAccountByPkVars rebuild(void Function(GAccountByPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountByPkVarsBuilder toBuilder() =>
      new GAccountByPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountByPkVars &&
        id == other.id &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountByPkVars')
          ..add('id', id)
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class GAccountByPkVarsBuilder
    implements Builder<GAccountByPkVars, GAccountByPkVarsBuilder> {
  _$GAccountByPkVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GAccountByPkVarsBuilder();

  GAccountByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountByPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountByPkVars;
  }

  @override
  void update(void Function(GAccountByPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountByPkVars build() => _build();

  _$GAccountByPkVars _build() {
    final _$result = _$v ??
        new _$GAccountByPkVars._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GAccountByPkVars', 'id'),
            limit: limit,
            offset: offset);
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByPkVars extends GAccountsByPkVars {
  @override
  final BuiltList<String> accountIds;
  @override
  final int? limit;
  @override
  final int? offset;

  factory _$GAccountsByPkVars(
          [void Function(GAccountsByPkVarsBuilder)? updates]) =>
      (new GAccountsByPkVarsBuilder()..update(updates))._build();

  _$GAccountsByPkVars._({required this.accountIds, this.limit, this.offset})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accountIds, r'GAccountsByPkVars', 'accountIds');
  }

  @override
  GAccountsByPkVars rebuild(void Function(GAccountsByPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByPkVarsBuilder toBuilder() =>
      new GAccountsByPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByPkVars &&
        accountIds == other.accountIds &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountIds.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByPkVars')
          ..add('accountIds', accountIds)
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class GAccountsByPkVarsBuilder
    implements Builder<GAccountsByPkVars, GAccountsByPkVarsBuilder> {
  _$GAccountsByPkVars? _$v;

  ListBuilder<String>? _accountIds;
  ListBuilder<String> get accountIds =>
      _$this._accountIds ??= new ListBuilder<String>();
  set accountIds(ListBuilder<String>? accountIds) =>
      _$this._accountIds = accountIds;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GAccountsByPkVarsBuilder();

  GAccountsByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountIds = $v.accountIds.toBuilder();
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByPkVars;
  }

  @override
  void update(void Function(GAccountsByPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByPkVars build() => _build();

  _$GAccountsByPkVars _build() {
    _$GAccountsByPkVars _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByPkVars._(
              accountIds: accountIds.build(), limit: limit, offset: offset);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accountIds';
        accountIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByPkVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountBasicByPkVars extends GAccountBasicByPkVars {
  @override
  final String id;

  factory _$GAccountBasicByPkVars(
          [void Function(GAccountBasicByPkVarsBuilder)? updates]) =>
      (new GAccountBasicByPkVarsBuilder()..update(updates))._build();

  _$GAccountBasicByPkVars._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GAccountBasicByPkVars', 'id');
  }

  @override
  GAccountBasicByPkVars rebuild(
          void Function(GAccountBasicByPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountBasicByPkVarsBuilder toBuilder() =>
      new GAccountBasicByPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountBasicByPkVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountBasicByPkVars')
          ..add('id', id))
        .toString();
  }
}

class GAccountBasicByPkVarsBuilder
    implements Builder<GAccountBasicByPkVars, GAccountBasicByPkVarsBuilder> {
  _$GAccountBasicByPkVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GAccountBasicByPkVarsBuilder();

  GAccountBasicByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountBasicByPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountBasicByPkVars;
  }

  @override
  void update(void Function(GAccountBasicByPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountBasicByPkVars build() => _build();

  _$GAccountBasicByPkVars _build() {
    final _$result = _$v ??
        new _$GAccountBasicByPkVars._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GAccountBasicByPkVars', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsBasicByPkVars extends GAccountsBasicByPkVars {
  @override
  final BuiltList<String> accountIds;

  factory _$GAccountsBasicByPkVars(
          [void Function(GAccountsBasicByPkVarsBuilder)? updates]) =>
      (new GAccountsBasicByPkVarsBuilder()..update(updates))._build();

  _$GAccountsBasicByPkVars._({required this.accountIds}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accountIds, r'GAccountsBasicByPkVars', 'accountIds');
  }

  @override
  GAccountsBasicByPkVars rebuild(
          void Function(GAccountsBasicByPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsBasicByPkVarsBuilder toBuilder() =>
      new GAccountsBasicByPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsBasicByPkVars && accountIds == other.accountIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsBasicByPkVars')
          ..add('accountIds', accountIds))
        .toString();
  }
}

class GAccountsBasicByPkVarsBuilder
    implements Builder<GAccountsBasicByPkVars, GAccountsBasicByPkVarsBuilder> {
  _$GAccountsBasicByPkVars? _$v;

  ListBuilder<String>? _accountIds;
  ListBuilder<String> get accountIds =>
      _$this._accountIds ??= new ListBuilder<String>();
  set accountIds(ListBuilder<String>? accountIds) =>
      _$this._accountIds = accountIds;

  GAccountsBasicByPkVarsBuilder();

  GAccountsBasicByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountIds = $v.accountIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsBasicByPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsBasicByPkVars;
  }

  @override
  void update(void Function(GAccountsBasicByPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsBasicByPkVars build() => _build();

  _$GAccountsBasicByPkVars _build() {
    _$GAccountsBasicByPkVars _$result;
    try {
      _$result =
          _$v ?? new _$GAccountsBasicByPkVars._(accountIds: accountIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accountIds';
        accountIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsBasicByPkVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountTransactionsVars extends GAccountTransactionsVars {
  @override
  final String accountId;
  @override
  final int? limit;
  @override
  final int? offset;

  factory _$GAccountTransactionsVars(
          [void Function(GAccountTransactionsVarsBuilder)? updates]) =>
      (new GAccountTransactionsVarsBuilder()..update(updates))._build();

  _$GAccountTransactionsVars._(
      {required this.accountId, this.limit, this.offset})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accountId, r'GAccountTransactionsVars', 'accountId');
  }

  @override
  GAccountTransactionsVars rebuild(
          void Function(GAccountTransactionsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountTransactionsVarsBuilder toBuilder() =>
      new GAccountTransactionsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountTransactionsVars &&
        accountId == other.accountId &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountTransactionsVars')
          ..add('accountId', accountId)
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class GAccountTransactionsVarsBuilder
    implements
        Builder<GAccountTransactionsVars, GAccountTransactionsVarsBuilder> {
  _$GAccountTransactionsVars? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GAccountTransactionsVarsBuilder();

  GAccountTransactionsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountTransactionsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountTransactionsVars;
  }

  @override
  void update(void Function(GAccountTransactionsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountTransactionsVars build() => _build();

  _$GAccountTransactionsVars _build() {
    final _$result = _$v ??
        new _$GAccountTransactionsVars._(
            accountId: BuiltValueNullFieldError.checkNotNull(
                accountId, r'GAccountTransactionsVars', 'accountId'),
            limit: limit,
            offset: offset);
    replace(_$result);
    return _$result;
  }
}

class _$GCertFieldsVars extends GCertFieldsVars {
  factory _$GCertFieldsVars([void Function(GCertFieldsVarsBuilder)? updates]) =>
      (new GCertFieldsVarsBuilder()..update(updates))._build();

  _$GCertFieldsVars._() : super._();

  @override
  GCertFieldsVars rebuild(void Function(GCertFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCertFieldsVarsBuilder toBuilder() =>
      new GCertFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCertFieldsVars;
  }

  @override
  int get hashCode {
    return 633575688;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GCertFieldsVars').toString();
  }
}

class GCertFieldsVarsBuilder
    implements Builder<GCertFieldsVars, GCertFieldsVarsBuilder> {
  _$GCertFieldsVars? _$v;

  GCertFieldsVarsBuilder();

  @override
  void replace(GCertFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCertFieldsVars;
  }

  @override
  void update(void Function(GCertFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCertFieldsVars build() => _build();

  _$GCertFieldsVars _build() {
    final _$result = _$v ?? new _$GCertFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GSmithCertFieldsVars extends GSmithCertFieldsVars {
  factory _$GSmithCertFieldsVars(
          [void Function(GSmithCertFieldsVarsBuilder)? updates]) =>
      (new GSmithCertFieldsVarsBuilder()..update(updates))._build();

  _$GSmithCertFieldsVars._() : super._();

  @override
  GSmithCertFieldsVars rebuild(
          void Function(GSmithCertFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSmithCertFieldsVarsBuilder toBuilder() =>
      new GSmithCertFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSmithCertFieldsVars;
  }

  @override
  int get hashCode {
    return 79748027;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GSmithCertFieldsVars').toString();
  }
}

class GSmithCertFieldsVarsBuilder
    implements Builder<GSmithCertFieldsVars, GSmithCertFieldsVarsBuilder> {
  _$GSmithCertFieldsVars? _$v;

  GSmithCertFieldsVarsBuilder();

  @override
  void replace(GSmithCertFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSmithCertFieldsVars;
  }

  @override
  void update(void Function(GSmithCertFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSmithCertFieldsVars build() => _build();

  _$GSmithCertFieldsVars _build() {
    final _$result = _$v ?? new _$GSmithCertFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GSmithFieldsVars extends GSmithFieldsVars {
  factory _$GSmithFieldsVars(
          [void Function(GSmithFieldsVarsBuilder)? updates]) =>
      (new GSmithFieldsVarsBuilder()..update(updates))._build();

  _$GSmithFieldsVars._() : super._();

  @override
  GSmithFieldsVars rebuild(void Function(GSmithFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSmithFieldsVarsBuilder toBuilder() =>
      new GSmithFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSmithFieldsVars;
  }

  @override
  int get hashCode {
    return 634029961;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GSmithFieldsVars').toString();
  }
}

class GSmithFieldsVarsBuilder
    implements Builder<GSmithFieldsVars, GSmithFieldsVarsBuilder> {
  _$GSmithFieldsVars? _$v;

  GSmithFieldsVarsBuilder();

  @override
  void replace(GSmithFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSmithFieldsVars;
  }

  @override
  void update(void Function(GSmithFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSmithFieldsVars build() => _build();

  _$GSmithFieldsVars _build() {
    final _$result = _$v ?? new _$GSmithFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GOwnerKeyChangeFieldsVars extends GOwnerKeyChangeFieldsVars {
  factory _$GOwnerKeyChangeFieldsVars(
          [void Function(GOwnerKeyChangeFieldsVarsBuilder)? updates]) =>
      (new GOwnerKeyChangeFieldsVarsBuilder()..update(updates))._build();

  _$GOwnerKeyChangeFieldsVars._() : super._();

  @override
  GOwnerKeyChangeFieldsVars rebuild(
          void Function(GOwnerKeyChangeFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOwnerKeyChangeFieldsVarsBuilder toBuilder() =>
      new GOwnerKeyChangeFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOwnerKeyChangeFieldsVars;
  }

  @override
  int get hashCode {
    return 1055270346;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GOwnerKeyChangeFieldsVars').toString();
  }
}

class GOwnerKeyChangeFieldsVarsBuilder
    implements
        Builder<GOwnerKeyChangeFieldsVars, GOwnerKeyChangeFieldsVarsBuilder> {
  _$GOwnerKeyChangeFieldsVars? _$v;

  GOwnerKeyChangeFieldsVarsBuilder();

  @override
  void replace(GOwnerKeyChangeFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GOwnerKeyChangeFieldsVars;
  }

  @override
  void update(void Function(GOwnerKeyChangeFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOwnerKeyChangeFieldsVars build() => _build();

  _$GOwnerKeyChangeFieldsVars _build() {
    final _$result = _$v ?? new _$GOwnerKeyChangeFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GIdentityBasicFieldsVars extends GIdentityBasicFieldsVars {
  factory _$GIdentityBasicFieldsVars(
          [void Function(GIdentityBasicFieldsVarsBuilder)? updates]) =>
      (new GIdentityBasicFieldsVarsBuilder()..update(updates))._build();

  _$GIdentityBasicFieldsVars._() : super._();

  @override
  GIdentityBasicFieldsVars rebuild(
          void Function(GIdentityBasicFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentityBasicFieldsVarsBuilder toBuilder() =>
      new GIdentityBasicFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentityBasicFieldsVars;
  }

  @override
  int get hashCode {
    return 585637490;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GIdentityBasicFieldsVars').toString();
  }
}

class GIdentityBasicFieldsVarsBuilder
    implements
        Builder<GIdentityBasicFieldsVars, GIdentityBasicFieldsVarsBuilder> {
  _$GIdentityBasicFieldsVars? _$v;

  GIdentityBasicFieldsVarsBuilder();

  @override
  void replace(GIdentityBasicFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentityBasicFieldsVars;
  }

  @override
  void update(void Function(GIdentityBasicFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentityBasicFieldsVars build() => _build();

  _$GIdentityBasicFieldsVars _build() {
    final _$result = _$v ?? new _$GIdentityBasicFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GIdentityFieldsVars extends GIdentityFieldsVars {
  factory _$GIdentityFieldsVars(
          [void Function(GIdentityFieldsVarsBuilder)? updates]) =>
      (new GIdentityFieldsVarsBuilder()..update(updates))._build();

  _$GIdentityFieldsVars._() : super._();

  @override
  GIdentityFieldsVars rebuild(
          void Function(GIdentityFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GIdentityFieldsVarsBuilder toBuilder() =>
      new GIdentityFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GIdentityFieldsVars;
  }

  @override
  int get hashCode {
    return 971826826;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GIdentityFieldsVars').toString();
  }
}

class GIdentityFieldsVarsBuilder
    implements Builder<GIdentityFieldsVars, GIdentityFieldsVarsBuilder> {
  _$GIdentityFieldsVars? _$v;

  GIdentityFieldsVarsBuilder();

  @override
  void replace(GIdentityFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GIdentityFieldsVars;
  }

  @override
  void update(void Function(GIdentityFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GIdentityFieldsVars build() => _build();

  _$GIdentityFieldsVars _build() {
    final _$result = _$v ?? new _$GIdentityFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GCommentsIssuedVars extends GCommentsIssuedVars {
  factory _$GCommentsIssuedVars(
          [void Function(GCommentsIssuedVarsBuilder)? updates]) =>
      (new GCommentsIssuedVarsBuilder()..update(updates))._build();

  _$GCommentsIssuedVars._() : super._();

  @override
  GCommentsIssuedVars rebuild(
          void Function(GCommentsIssuedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentsIssuedVarsBuilder toBuilder() =>
      new GCommentsIssuedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentsIssuedVars;
  }

  @override
  int get hashCode {
    return 291561414;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GCommentsIssuedVars').toString();
  }
}

class GCommentsIssuedVarsBuilder
    implements Builder<GCommentsIssuedVars, GCommentsIssuedVarsBuilder> {
  _$GCommentsIssuedVars? _$v;

  GCommentsIssuedVarsBuilder();

  @override
  void replace(GCommentsIssuedVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GCommentsIssuedVars;
  }

  @override
  void update(void Function(GCommentsIssuedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentsIssuedVars build() => _build();

  _$GCommentsIssuedVars _build() {
    final _$result = _$v ?? new _$GCommentsIssuedVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GAccountBasicFieldsVars extends GAccountBasicFieldsVars {
  factory _$GAccountBasicFieldsVars(
          [void Function(GAccountBasicFieldsVarsBuilder)? updates]) =>
      (new GAccountBasicFieldsVarsBuilder()..update(updates))._build();

  _$GAccountBasicFieldsVars._() : super._();

  @override
  GAccountBasicFieldsVars rebuild(
          void Function(GAccountBasicFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountBasicFieldsVarsBuilder toBuilder() =>
      new GAccountBasicFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountBasicFieldsVars;
  }

  @override
  int get hashCode {
    return 913040934;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GAccountBasicFieldsVars').toString();
  }
}

class GAccountBasicFieldsVarsBuilder
    implements
        Builder<GAccountBasicFieldsVars, GAccountBasicFieldsVarsBuilder> {
  _$GAccountBasicFieldsVars? _$v;

  GAccountBasicFieldsVarsBuilder();

  @override
  void replace(GAccountBasicFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountBasicFieldsVars;
  }

  @override
  void update(void Function(GAccountBasicFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountBasicFieldsVars build() => _build();

  _$GAccountBasicFieldsVars _build() {
    final _$result = _$v ?? new _$GAccountBasicFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GAccountFieldsVars extends GAccountFieldsVars {
  @override
  final int? first;
  @override
  final int? offset;

  factory _$GAccountFieldsVars(
          [void Function(GAccountFieldsVarsBuilder)? updates]) =>
      (new GAccountFieldsVarsBuilder()..update(updates))._build();

  _$GAccountFieldsVars._({this.first, this.offset}) : super._();

  @override
  GAccountFieldsVars rebuild(
          void Function(GAccountFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountFieldsVarsBuilder toBuilder() =>
      new GAccountFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountFieldsVars &&
        first == other.first &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountFieldsVars')
          ..add('first', first)
          ..add('offset', offset))
        .toString();
  }
}

class GAccountFieldsVarsBuilder
    implements Builder<GAccountFieldsVars, GAccountFieldsVarsBuilder> {
  _$GAccountFieldsVars? _$v;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GAccountFieldsVarsBuilder();

  GAccountFieldsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _first = $v.first;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountFieldsVars;
  }

  @override
  void update(void Function(GAccountFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountFieldsVars build() => _build();

  _$GAccountFieldsVars _build() {
    final _$result =
        _$v ?? new _$GAccountFieldsVars._(first: first, offset: offset);
    replace(_$result);
    return _$result;
  }
}

class _$GAccountTxsFieldsVars extends GAccountTxsFieldsVars {
  @override
  final int? first;
  @override
  final int? offset;

  factory _$GAccountTxsFieldsVars(
          [void Function(GAccountTxsFieldsVarsBuilder)? updates]) =>
      (new GAccountTxsFieldsVarsBuilder()..update(updates))._build();

  _$GAccountTxsFieldsVars._({this.first, this.offset}) : super._();

  @override
  GAccountTxsFieldsVars rebuild(
          void Function(GAccountTxsFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountTxsFieldsVarsBuilder toBuilder() =>
      new GAccountTxsFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountTxsFieldsVars &&
        first == other.first &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountTxsFieldsVars')
          ..add('first', first)
          ..add('offset', offset))
        .toString();
  }
}

class GAccountTxsFieldsVarsBuilder
    implements Builder<GAccountTxsFieldsVars, GAccountTxsFieldsVarsBuilder> {
  _$GAccountTxsFieldsVars? _$v;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GAccountTxsFieldsVarsBuilder();

  GAccountTxsFieldsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _first = $v.first;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountTxsFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountTxsFieldsVars;
  }

  @override
  void update(void Function(GAccountTxsFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountTxsFieldsVars build() => _build();

  _$GAccountTxsFieldsVars _build() {
    final _$result =
        _$v ?? new _$GAccountTxsFieldsVars._(first: first, offset: offset);
    replace(_$result);
    return _$result;
  }
}

class _$GTransferFieldsVars extends GTransferFieldsVars {
  factory _$GTransferFieldsVars(
          [void Function(GTransferFieldsVarsBuilder)? updates]) =>
      (new GTransferFieldsVarsBuilder()..update(updates))._build();

  _$GTransferFieldsVars._() : super._();

  @override
  GTransferFieldsVars rebuild(
          void Function(GTransferFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTransferFieldsVarsBuilder toBuilder() =>
      new GTransferFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTransferFieldsVars;
  }

  @override
  int get hashCode {
    return 96410947;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GTransferFieldsVars').toString();
  }
}

class GTransferFieldsVarsBuilder
    implements Builder<GTransferFieldsVars, GTransferFieldsVarsBuilder> {
  _$GTransferFieldsVars? _$v;

  GTransferFieldsVarsBuilder();

  @override
  void replace(GTransferFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GTransferFieldsVars;
  }

  @override
  void update(void Function(GTransferFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTransferFieldsVars build() => _build();

  _$GTransferFieldsVars _build() {
    final _$result = _$v ?? new _$GTransferFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
