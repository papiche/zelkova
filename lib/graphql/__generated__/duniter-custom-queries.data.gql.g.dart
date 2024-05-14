// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-custom-queries.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAccountsByPkData> _$gAccountsByPkDataSerializer =
    new _$GAccountsByPkDataSerializer();
Serializer<GAccountsByPkData_account_by_pk>
    _$gAccountsByPkDataAccountByPkSerializer =
    new _$GAccountsByPkData_account_by_pkSerializer();
Serializer<GAccountsByPkData_account_by_pk_identity>
    _$gAccountsByPkDataAccountByPkIdentitySerializer =
    new _$GAccountsByPkData_account_by_pk_identitySerializer();
Serializer<GSearchIdentityData> _$gSearchIdentityDataSerializer =
    new _$GSearchIdentityDataSerializer();
Serializer<GSearchIdentityData_search_identity>
    _$gSearchIdentityDataSearchIdentitySerializer =
    new _$GSearchIdentityData_search_identitySerializer();
Serializer<GLastIndexedBlockNumberData>
    _$gLastIndexedBlockNumberDataSerializer =
    new _$GLastIndexedBlockNumberDataSerializer();
Serializer<GLastIndexedBlockNumberData_parameters_by_pk>
    _$gLastIndexedBlockNumberDataParametersByPkSerializer =
    new _$GLastIndexedBlockNumberData_parameters_by_pkSerializer();
Serializer<GAccountsByNameOrPkData> _$gAccountsByNameOrPkDataSerializer =
    new _$GAccountsByNameOrPkDataSerializer();
Serializer<GAccountsByNameOrPkData_account>
    _$gAccountsByNameOrPkDataAccountSerializer =
    new _$GAccountsByNameOrPkData_accountSerializer();
Serializer<GAccountsByNameOrPkData_account_identity>
    _$gAccountsByNameOrPkDataAccountIdentitySerializer =
    new _$GAccountsByNameOrPkData_account_identitySerializer();
Serializer<GAccountsByNameOrPkData_account_identity_account>
    _$gAccountsByNameOrPkDataAccountIdentityAccountSerializer =
    new _$GAccountsByNameOrPkData_account_identity_accountSerializer();
Serializer<GAccountsByNameOrPkData_account_identity_account_identity>
    _$gAccountsByNameOrPkDataAccountIdentityAccountIdentitySerializer =
    new _$GAccountsByNameOrPkData_account_identity_account_identitySerializer();

class _$GAccountsByPkDataSerializer
    implements StructuredSerializer<GAccountsByPkData> {
  @override
  final Iterable<Type> types = const [GAccountsByPkData, _$GAccountsByPkData];
  @override
  final String wireName = 'GAccountsByPkData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountsByPkData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.account_by_pk;
    if (value != null) {
      result
        ..add('account_by_pk')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GAccountsByPkData_account_by_pk)));
    }
    return result;
  }

  @override
  GAccountsByPkData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByPkDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'account_by_pk':
          result.account_by_pk.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAccountsByPkData_account_by_pk))!
              as GAccountsByPkData_account_by_pk);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkData_account_by_pkSerializer
    implements StructuredSerializer<GAccountsByPkData_account_by_pk> {
  @override
  final Iterable<Type> types = const [
    GAccountsByPkData_account_by_pk,
    _$GAccountsByPkData_account_by_pk
  ];
  @override
  final String wireName = 'GAccountsByPkData_account_by_pk';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByPkData_account_by_pk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pubkey',
      serializers.serialize(object.pubkey,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.identity;
    if (value != null) {
      result
        ..add('identity')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GAccountsByPkData_account_by_pk_identity)));
    }
    return result;
  }

  @override
  GAccountsByPkData_account_by_pk deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByPkData_account_by_pkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'identity':
          result.identity.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAccountsByPkData_account_by_pk_identity))!
              as GAccountsByPkData_account_by_pk_identity);
          break;
        case 'pubkey':
          result.pubkey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkData_account_by_pk_identitySerializer
    implements StructuredSerializer<GAccountsByPkData_account_by_pk_identity> {
  @override
  final Iterable<Type> types = const [
    GAccountsByPkData_account_by_pk_identity,
    _$GAccountsByPkData_account_by_pk_identity
  ];
  @override
  final String wireName = 'GAccountsByPkData_account_by_pk_identity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByPkData_account_by_pk_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAccountsByPkData_account_by_pk_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByPkData_account_by_pk_identityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchIdentityDataSerializer
    implements StructuredSerializer<GSearchIdentityData> {
  @override
  final Iterable<Type> types = const [
    GSearchIdentityData,
    _$GSearchIdentityData
  ];
  @override
  final String wireName = 'GSearchIdentityData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchIdentityData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'search_identity',
      serializers.serialize(object.search_identity,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GSearchIdentityData_search_identity)])),
    ];

    return result;
  }

  @override
  GSearchIdentityData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchIdentityDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'search_identity':
          result.search_identity.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GSearchIdentityData_search_identity)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchIdentityData_search_identitySerializer
    implements StructuredSerializer<GSearchIdentityData_search_identity> {
  @override
  final Iterable<Type> types = const [
    GSearchIdentityData_search_identity,
    _$GSearchIdentityData_search_identity
  ];
  @override
  final String wireName = 'GSearchIdentityData_search_identity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchIdentityData_search_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pubkey',
      serializers.serialize(object.pubkey,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSearchIdentityData_search_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchIdentityData_search_identityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'pubkey':
          result.pubkey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GLastIndexedBlockNumberDataSerializer
    implements StructuredSerializer<GLastIndexedBlockNumberData> {
  @override
  final Iterable<Type> types = const [
    GLastIndexedBlockNumberData,
    _$GLastIndexedBlockNumberData
  ];
  @override
  final String wireName = 'GLastIndexedBlockNumberData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLastIndexedBlockNumberData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.parameters_by_pk;
    if (value != null) {
      result
        ..add('parameters_by_pk')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GLastIndexedBlockNumberData_parameters_by_pk)));
    }
    return result;
  }

  @override
  GLastIndexedBlockNumberData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastIndexedBlockNumberDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'parameters_by_pk':
          result.parameters_by_pk.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GLastIndexedBlockNumberData_parameters_by_pk))!
              as GLastIndexedBlockNumberData_parameters_by_pk);
          break;
      }
    }

    return result.build();
  }
}

class _$GLastIndexedBlockNumberData_parameters_by_pkSerializer
    implements
        StructuredSerializer<GLastIndexedBlockNumberData_parameters_by_pk> {
  @override
  final Iterable<Type> types = const [
    GLastIndexedBlockNumberData_parameters_by_pk,
    _$GLastIndexedBlockNumberData_parameters_by_pk
  ];
  @override
  final String wireName = 'GLastIndexedBlockNumberData_parameters_by_pk';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GLastIndexedBlockNumberData_parameters_by_pk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.Gjsonb)));
    }
    return result;
  }

  @override
  GLastIndexedBlockNumberData_parameters_by_pk deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastIndexedBlockNumberData_parameters_by_pkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'value':
          result.value.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.Gjsonb))! as _i2.Gjsonb);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkDataSerializer
    implements StructuredSerializer<GAccountsByNameOrPkData> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData,
    _$GAccountsByNameOrPkData
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'account',
      serializers.serialize(object.account,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GAccountsByNameOrPkData_account)])),
    ];

    return result;
  }

  @override
  GAccountsByNameOrPkData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GAccountsByNameOrPkData_account)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_accountSerializer
    implements StructuredSerializer<GAccountsByNameOrPkData_account> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_account,
    _$GAccountsByNameOrPkData_account
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData_account';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkData_account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.identity;
    if (value != null) {
      result
        ..add('identity')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GAccountsByNameOrPkData_account_identity)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkData_account deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkData_accountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'identity':
          result.identity.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAccountsByNameOrPkData_account_identity))!
              as GAccountsByNameOrPkData_account_identity);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_account_identitySerializer
    implements StructuredSerializer<GAccountsByNameOrPkData_account_identity> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_account_identity,
    _$GAccountsByNameOrPkData_account_identity
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData_account_identity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkData_account_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.account;
    if (value != null) {
      result
        ..add('account')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GAccountsByNameOrPkData_account_identity_account)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkData_account_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkData_account_identityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GAccountsByNameOrPkData_account_identity_account))!
              as GAccountsByNameOrPkData_account_identity_account);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_account_identity_accountSerializer
    implements
        StructuredSerializer<GAccountsByNameOrPkData_account_identity_account> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_account_identity_account,
    _$GAccountsByNameOrPkData_account_identity_account
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData_account_identity_account';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GAccountsByNameOrPkData_account_identity_account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.identity;
    if (value != null) {
      result
        ..add('identity')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GAccountsByNameOrPkData_account_identity_account_identity)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkData_account_identity_account deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GAccountsByNameOrPkData_account_identity_accountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'identity':
          result.identity.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GAccountsByNameOrPkData_account_identity_account_identity))!
              as GAccountsByNameOrPkData_account_identity_account_identity);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_account_identity_account_identitySerializer
    implements
        StructuredSerializer<
            GAccountsByNameOrPkData_account_identity_account_identity> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_account_identity_account_identity,
    _$GAccountsByNameOrPkData_account_identity_account_identity
  ];
  @override
  final String wireName =
      'GAccountsByNameOrPkData_account_identity_account_identity';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GAccountsByNameOrPkData_account_identity_account_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pubkey',
      serializers.serialize(object.pubkey,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkData_account_identity_account_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GAccountsByNameOrPkData_account_identity_account_identityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pubkey':
          result.pubkey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkData extends GAccountsByPkData {
  @override
  final String G__typename;
  @override
  final GAccountsByPkData_account_by_pk? account_by_pk;

  factory _$GAccountsByPkData(
          [void Function(GAccountsByPkDataBuilder)? updates]) =>
      (new GAccountsByPkDataBuilder()..update(updates))._build();

  _$GAccountsByPkData._({required this.G__typename, this.account_by_pk})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByPkData', 'G__typename');
  }

  @override
  GAccountsByPkData rebuild(void Function(GAccountsByPkDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByPkDataBuilder toBuilder() =>
      new GAccountsByPkDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByPkData &&
        G__typename == other.G__typename &&
        account_by_pk == other.account_by_pk;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, account_by_pk.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByPkData')
          ..add('G__typename', G__typename)
          ..add('account_by_pk', account_by_pk))
        .toString();
  }
}

class GAccountsByPkDataBuilder
    implements Builder<GAccountsByPkData, GAccountsByPkDataBuilder> {
  _$GAccountsByPkData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountsByPkData_account_by_pkBuilder? _account_by_pk;
  GAccountsByPkData_account_by_pkBuilder get account_by_pk =>
      _$this._account_by_pk ??= new GAccountsByPkData_account_by_pkBuilder();
  set account_by_pk(GAccountsByPkData_account_by_pkBuilder? account_by_pk) =>
      _$this._account_by_pk = account_by_pk;

  GAccountsByPkDataBuilder() {
    GAccountsByPkData._initializeBuilder(this);
  }

  GAccountsByPkDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _account_by_pk = $v.account_by_pk?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByPkData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByPkData;
  }

  @override
  void update(void Function(GAccountsByPkDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByPkData build() => _build();

  _$GAccountsByPkData _build() {
    _$GAccountsByPkData _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByPkData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAccountsByPkData', 'G__typename'),
              account_by_pk: _account_by_pk?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account_by_pk';
        _account_by_pk?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByPkData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByPkData_account_by_pk
    extends GAccountsByPkData_account_by_pk {
  @override
  final String G__typename;
  @override
  final GAccountsByPkData_account_by_pk_identity? identity;
  @override
  final String pubkey;

  factory _$GAccountsByPkData_account_by_pk(
          [void Function(GAccountsByPkData_account_by_pkBuilder)? updates]) =>
      (new GAccountsByPkData_account_by_pkBuilder()..update(updates))._build();

  _$GAccountsByPkData_account_by_pk._(
      {required this.G__typename, this.identity, required this.pubkey})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByPkData_account_by_pk', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GAccountsByPkData_account_by_pk', 'pubkey');
  }

  @override
  GAccountsByPkData_account_by_pk rebuild(
          void Function(GAccountsByPkData_account_by_pkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByPkData_account_by_pkBuilder toBuilder() =>
      new GAccountsByPkData_account_by_pkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByPkData_account_by_pk &&
        G__typename == other.G__typename &&
        identity == other.identity &&
        pubkey == other.pubkey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jc(_$hash, pubkey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByPkData_account_by_pk')
          ..add('G__typename', G__typename)
          ..add('identity', identity)
          ..add('pubkey', pubkey))
        .toString();
  }
}

class GAccountsByPkData_account_by_pkBuilder
    implements
        Builder<GAccountsByPkData_account_by_pk,
            GAccountsByPkData_account_by_pkBuilder> {
  _$GAccountsByPkData_account_by_pk? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountsByPkData_account_by_pk_identityBuilder? _identity;
  GAccountsByPkData_account_by_pk_identityBuilder get identity =>
      _$this._identity ??=
          new GAccountsByPkData_account_by_pk_identityBuilder();
  set identity(GAccountsByPkData_account_by_pk_identityBuilder? identity) =>
      _$this._identity = identity;

  String? _pubkey;
  String? get pubkey => _$this._pubkey;
  set pubkey(String? pubkey) => _$this._pubkey = pubkey;

  GAccountsByPkData_account_by_pkBuilder() {
    GAccountsByPkData_account_by_pk._initializeBuilder(this);
  }

  GAccountsByPkData_account_by_pkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identity = $v.identity?.toBuilder();
      _pubkey = $v.pubkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByPkData_account_by_pk other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByPkData_account_by_pk;
  }

  @override
  void update(void Function(GAccountsByPkData_account_by_pkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByPkData_account_by_pk build() => _build();

  _$GAccountsByPkData_account_by_pk _build() {
    _$GAccountsByPkData_account_by_pk _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByPkData_account_by_pk._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GAccountsByPkData_account_by_pk', 'G__typename'),
              identity: _identity?.build(),
              pubkey: BuiltValueNullFieldError.checkNotNull(
                  pubkey, r'GAccountsByPkData_account_by_pk', 'pubkey'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        _identity?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByPkData_account_by_pk', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByPkData_account_by_pk_identity
    extends GAccountsByPkData_account_by_pk_identity {
  @override
  final String G__typename;
  @override
  final String? name;

  factory _$GAccountsByPkData_account_by_pk_identity(
          [void Function(GAccountsByPkData_account_by_pk_identityBuilder)?
              updates]) =>
      (new GAccountsByPkData_account_by_pk_identityBuilder()..update(updates))
          ._build();

  _$GAccountsByPkData_account_by_pk_identity._(
      {required this.G__typename, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GAccountsByPkData_account_by_pk_identity', 'G__typename');
  }

  @override
  GAccountsByPkData_account_by_pk_identity rebuild(
          void Function(GAccountsByPkData_account_by_pk_identityBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByPkData_account_by_pk_identityBuilder toBuilder() =>
      new GAccountsByPkData_account_by_pk_identityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByPkData_account_by_pk_identity &&
        G__typename == other.G__typename &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAccountsByPkData_account_by_pk_identity')
          ..add('G__typename', G__typename)
          ..add('name', name))
        .toString();
  }
}

class GAccountsByPkData_account_by_pk_identityBuilder
    implements
        Builder<GAccountsByPkData_account_by_pk_identity,
            GAccountsByPkData_account_by_pk_identityBuilder> {
  _$GAccountsByPkData_account_by_pk_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GAccountsByPkData_account_by_pk_identityBuilder() {
    GAccountsByPkData_account_by_pk_identity._initializeBuilder(this);
  }

  GAccountsByPkData_account_by_pk_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByPkData_account_by_pk_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByPkData_account_by_pk_identity;
  }

  @override
  void update(
      void Function(GAccountsByPkData_account_by_pk_identityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByPkData_account_by_pk_identity build() => _build();

  _$GAccountsByPkData_account_by_pk_identity _build() {
    final _$result = _$v ??
        new _$GAccountsByPkData_account_by_pk_identity._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAccountsByPkData_account_by_pk_identity', 'G__typename'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GSearchIdentityData extends GSearchIdentityData {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchIdentityData_search_identity> search_identity;

  factory _$GSearchIdentityData(
          [void Function(GSearchIdentityDataBuilder)? updates]) =>
      (new GSearchIdentityDataBuilder()..update(updates))._build();

  _$GSearchIdentityData._(
      {required this.G__typename, required this.search_identity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchIdentityData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        search_identity, r'GSearchIdentityData', 'search_identity');
  }

  @override
  GSearchIdentityData rebuild(
          void Function(GSearchIdentityDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchIdentityDataBuilder toBuilder() =>
      new GSearchIdentityDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchIdentityData &&
        G__typename == other.G__typename &&
        search_identity == other.search_identity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, search_identity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchIdentityData')
          ..add('G__typename', G__typename)
          ..add('search_identity', search_identity))
        .toString();
  }
}

class GSearchIdentityDataBuilder
    implements Builder<GSearchIdentityData, GSearchIdentityDataBuilder> {
  _$GSearchIdentityData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchIdentityData_search_identity>? _search_identity;
  ListBuilder<GSearchIdentityData_search_identity> get search_identity =>
      _$this._search_identity ??=
          new ListBuilder<GSearchIdentityData_search_identity>();
  set search_identity(
          ListBuilder<GSearchIdentityData_search_identity>? search_identity) =>
      _$this._search_identity = search_identity;

  GSearchIdentityDataBuilder() {
    GSearchIdentityData._initializeBuilder(this);
  }

  GSearchIdentityDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _search_identity = $v.search_identity.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchIdentityData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchIdentityData;
  }

  @override
  void update(void Function(GSearchIdentityDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchIdentityData build() => _build();

  _$GSearchIdentityData _build() {
    _$GSearchIdentityData _$result;
    try {
      _$result = _$v ??
          new _$GSearchIdentityData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSearchIdentityData', 'G__typename'),
              search_identity: search_identity.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'search_identity';
        search_identity.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSearchIdentityData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchIdentityData_search_identity
    extends GSearchIdentityData_search_identity {
  @override
  final String G__typename;
  @override
  final String pubkey;
  @override
  final String? name;

  factory _$GSearchIdentityData_search_identity(
          [void Function(GSearchIdentityData_search_identityBuilder)?
              updates]) =>
      (new GSearchIdentityData_search_identityBuilder()..update(updates))
          ._build();

  _$GSearchIdentityData_search_identity._(
      {required this.G__typename, required this.pubkey, this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchIdentityData_search_identity', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GSearchIdentityData_search_identity', 'pubkey');
  }

  @override
  GSearchIdentityData_search_identity rebuild(
          void Function(GSearchIdentityData_search_identityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchIdentityData_search_identityBuilder toBuilder() =>
      new GSearchIdentityData_search_identityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchIdentityData_search_identity &&
        G__typename == other.G__typename &&
        pubkey == other.pubkey &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, pubkey.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchIdentityData_search_identity')
          ..add('G__typename', G__typename)
          ..add('pubkey', pubkey)
          ..add('name', name))
        .toString();
  }
}

class GSearchIdentityData_search_identityBuilder
    implements
        Builder<GSearchIdentityData_search_identity,
            GSearchIdentityData_search_identityBuilder> {
  _$GSearchIdentityData_search_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _pubkey;
  String? get pubkey => _$this._pubkey;
  set pubkey(String? pubkey) => _$this._pubkey = pubkey;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GSearchIdentityData_search_identityBuilder() {
    GSearchIdentityData_search_identity._initializeBuilder(this);
  }

  GSearchIdentityData_search_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _pubkey = $v.pubkey;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchIdentityData_search_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchIdentityData_search_identity;
  }

  @override
  void update(
      void Function(GSearchIdentityData_search_identityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchIdentityData_search_identity build() => _build();

  _$GSearchIdentityData_search_identity _build() {
    final _$result = _$v ??
        new _$GSearchIdentityData_search_identity._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GSearchIdentityData_search_identity', 'G__typename'),
            pubkey: BuiltValueNullFieldError.checkNotNull(
                pubkey, r'GSearchIdentityData_search_identity', 'pubkey'),
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$GLastIndexedBlockNumberData extends GLastIndexedBlockNumberData {
  @override
  final String G__typename;
  @override
  final GLastIndexedBlockNumberData_parameters_by_pk? parameters_by_pk;

  factory _$GLastIndexedBlockNumberData(
          [void Function(GLastIndexedBlockNumberDataBuilder)? updates]) =>
      (new GLastIndexedBlockNumberDataBuilder()..update(updates))._build();

  _$GLastIndexedBlockNumberData._(
      {required this.G__typename, this.parameters_by_pk})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLastIndexedBlockNumberData', 'G__typename');
  }

  @override
  GLastIndexedBlockNumberData rebuild(
          void Function(GLastIndexedBlockNumberDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastIndexedBlockNumberDataBuilder toBuilder() =>
      new GLastIndexedBlockNumberDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastIndexedBlockNumberData &&
        G__typename == other.G__typename &&
        parameters_by_pk == other.parameters_by_pk;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, parameters_by_pk.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLastIndexedBlockNumberData')
          ..add('G__typename', G__typename)
          ..add('parameters_by_pk', parameters_by_pk))
        .toString();
  }
}

class GLastIndexedBlockNumberDataBuilder
    implements
        Builder<GLastIndexedBlockNumberData,
            GLastIndexedBlockNumberDataBuilder> {
  _$GLastIndexedBlockNumberData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLastIndexedBlockNumberData_parameters_by_pkBuilder? _parameters_by_pk;
  GLastIndexedBlockNumberData_parameters_by_pkBuilder get parameters_by_pk =>
      _$this._parameters_by_pk ??=
          new GLastIndexedBlockNumberData_parameters_by_pkBuilder();
  set parameters_by_pk(
          GLastIndexedBlockNumberData_parameters_by_pkBuilder?
              parameters_by_pk) =>
      _$this._parameters_by_pk = parameters_by_pk;

  GLastIndexedBlockNumberDataBuilder() {
    GLastIndexedBlockNumberData._initializeBuilder(this);
  }

  GLastIndexedBlockNumberDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _parameters_by_pk = $v.parameters_by_pk?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastIndexedBlockNumberData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastIndexedBlockNumberData;
  }

  @override
  void update(void Function(GLastIndexedBlockNumberDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastIndexedBlockNumberData build() => _build();

  _$GLastIndexedBlockNumberData _build() {
    _$GLastIndexedBlockNumberData _$result;
    try {
      _$result = _$v ??
          new _$GLastIndexedBlockNumberData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GLastIndexedBlockNumberData', 'G__typename'),
              parameters_by_pk: _parameters_by_pk?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'parameters_by_pk';
        _parameters_by_pk?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLastIndexedBlockNumberData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLastIndexedBlockNumberData_parameters_by_pk
    extends GLastIndexedBlockNumberData_parameters_by_pk {
  @override
  final String G__typename;
  @override
  final _i2.Gjsonb? value;

  factory _$GLastIndexedBlockNumberData_parameters_by_pk(
          [void Function(GLastIndexedBlockNumberData_parameters_by_pkBuilder)?
              updates]) =>
      (new GLastIndexedBlockNumberData_parameters_by_pkBuilder()
            ..update(updates))
          ._build();

  _$GLastIndexedBlockNumberData_parameters_by_pk._(
      {required this.G__typename, this.value})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GLastIndexedBlockNumberData_parameters_by_pk', 'G__typename');
  }

  @override
  GLastIndexedBlockNumberData_parameters_by_pk rebuild(
          void Function(GLastIndexedBlockNumberData_parameters_by_pkBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastIndexedBlockNumberData_parameters_by_pkBuilder toBuilder() =>
      new GLastIndexedBlockNumberData_parameters_by_pkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastIndexedBlockNumberData_parameters_by_pk &&
        G__typename == other.G__typename &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GLastIndexedBlockNumberData_parameters_by_pk')
          ..add('G__typename', G__typename)
          ..add('value', value))
        .toString();
  }
}

class GLastIndexedBlockNumberData_parameters_by_pkBuilder
    implements
        Builder<GLastIndexedBlockNumberData_parameters_by_pk,
            GLastIndexedBlockNumberData_parameters_by_pkBuilder> {
  _$GLastIndexedBlockNumberData_parameters_by_pk? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i2.GjsonbBuilder? _value;
  _i2.GjsonbBuilder get value => _$this._value ??= new _i2.GjsonbBuilder();
  set value(_i2.GjsonbBuilder? value) => _$this._value = value;

  GLastIndexedBlockNumberData_parameters_by_pkBuilder() {
    GLastIndexedBlockNumberData_parameters_by_pk._initializeBuilder(this);
  }

  GLastIndexedBlockNumberData_parameters_by_pkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _value = $v.value?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastIndexedBlockNumberData_parameters_by_pk other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastIndexedBlockNumberData_parameters_by_pk;
  }

  @override
  void update(
      void Function(GLastIndexedBlockNumberData_parameters_by_pkBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastIndexedBlockNumberData_parameters_by_pk build() => _build();

  _$GLastIndexedBlockNumberData_parameters_by_pk _build() {
    _$GLastIndexedBlockNumberData_parameters_by_pk _$result;
    try {
      _$result = _$v ??
          new _$GLastIndexedBlockNumberData_parameters_by_pk._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GLastIndexedBlockNumberData_parameters_by_pk',
                  'G__typename'),
              value: _value?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'value';
        _value?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLastIndexedBlockNumberData_parameters_by_pk',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData extends GAccountsByNameOrPkData {
  @override
  final String G__typename;
  @override
  final BuiltList<GAccountsByNameOrPkData_account> account;

  factory _$GAccountsByNameOrPkData(
          [void Function(GAccountsByNameOrPkDataBuilder)? updates]) =>
      (new GAccountsByNameOrPkDataBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkData._(
      {required this.G__typename, required this.account})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameOrPkData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        account, r'GAccountsByNameOrPkData', 'account');
  }

  @override
  GAccountsByNameOrPkData rebuild(
          void Function(GAccountsByNameOrPkDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkDataBuilder toBuilder() =>
      new GAccountsByNameOrPkDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData &&
        G__typename == other.G__typename &&
        account == other.account;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkData')
          ..add('G__typename', G__typename)
          ..add('account', account))
        .toString();
  }
}

class GAccountsByNameOrPkDataBuilder
    implements
        Builder<GAccountsByNameOrPkData, GAccountsByNameOrPkDataBuilder> {
  _$GAccountsByNameOrPkData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GAccountsByNameOrPkData_account>? _account;
  ListBuilder<GAccountsByNameOrPkData_account> get account =>
      _$this._account ??= new ListBuilder<GAccountsByNameOrPkData_account>();
  set account(ListBuilder<GAccountsByNameOrPkData_account>? account) =>
      _$this._account = account;

  GAccountsByNameOrPkDataBuilder() {
    GAccountsByNameOrPkData._initializeBuilder(this);
  }

  GAccountsByNameOrPkDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _account = $v.account.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData;
  }

  @override
  void update(void Function(GAccountsByNameOrPkDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData build() => _build();

  _$GAccountsByNameOrPkData _build() {
    _$GAccountsByNameOrPkData _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAccountsByNameOrPkData', 'G__typename'),
              account: account.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        account.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData_account
    extends GAccountsByNameOrPkData_account {
  @override
  final String G__typename;
  @override
  final GAccountsByNameOrPkData_account_identity? identity;

  factory _$GAccountsByNameOrPkData_account(
          [void Function(GAccountsByNameOrPkData_accountBuilder)? updates]) =>
      (new GAccountsByNameOrPkData_accountBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkData_account._(
      {required this.G__typename, this.identity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameOrPkData_account', 'G__typename');
  }

  @override
  GAccountsByNameOrPkData_account rebuild(
          void Function(GAccountsByNameOrPkData_accountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_accountBuilder toBuilder() =>
      new GAccountsByNameOrPkData_accountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_account &&
        G__typename == other.G__typename &&
        identity == other.identity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkData_account')
          ..add('G__typename', G__typename)
          ..add('identity', identity))
        .toString();
  }
}

class GAccountsByNameOrPkData_accountBuilder
    implements
        Builder<GAccountsByNameOrPkData_account,
            GAccountsByNameOrPkData_accountBuilder> {
  _$GAccountsByNameOrPkData_account? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountsByNameOrPkData_account_identityBuilder? _identity;
  GAccountsByNameOrPkData_account_identityBuilder get identity =>
      _$this._identity ??=
          new GAccountsByNameOrPkData_account_identityBuilder();
  set identity(GAccountsByNameOrPkData_account_identityBuilder? identity) =>
      _$this._identity = identity;

  GAccountsByNameOrPkData_accountBuilder() {
    GAccountsByNameOrPkData_account._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_accountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identity = $v.identity?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData_account other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_account;
  }

  @override
  void update(void Function(GAccountsByNameOrPkData_accountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_account build() => _build();

  _$GAccountsByNameOrPkData_account _build() {
    _$GAccountsByNameOrPkData_account _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkData_account._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GAccountsByNameOrPkData_account', 'G__typename'),
              identity: _identity?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        _identity?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkData_account', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData_account_identity
    extends GAccountsByNameOrPkData_account_identity {
  @override
  final String G__typename;
  @override
  final GAccountsByNameOrPkData_account_identity_account? account;

  factory _$GAccountsByNameOrPkData_account_identity(
          [void Function(GAccountsByNameOrPkData_account_identityBuilder)?
              updates]) =>
      (new GAccountsByNameOrPkData_account_identityBuilder()..update(updates))
          ._build();

  _$GAccountsByNameOrPkData_account_identity._(
      {required this.G__typename, this.account})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GAccountsByNameOrPkData_account_identity', 'G__typename');
  }

  @override
  GAccountsByNameOrPkData_account_identity rebuild(
          void Function(GAccountsByNameOrPkData_account_identityBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_account_identityBuilder toBuilder() =>
      new GAccountsByNameOrPkData_account_identityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_account_identity &&
        G__typename == other.G__typename &&
        account == other.account;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAccountsByNameOrPkData_account_identity')
          ..add('G__typename', G__typename)
          ..add('account', account))
        .toString();
  }
}

class GAccountsByNameOrPkData_account_identityBuilder
    implements
        Builder<GAccountsByNameOrPkData_account_identity,
            GAccountsByNameOrPkData_account_identityBuilder> {
  _$GAccountsByNameOrPkData_account_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountsByNameOrPkData_account_identity_accountBuilder? _account;
  GAccountsByNameOrPkData_account_identity_accountBuilder get account =>
      _$this._account ??=
          new GAccountsByNameOrPkData_account_identity_accountBuilder();
  set account(
          GAccountsByNameOrPkData_account_identity_accountBuilder? account) =>
      _$this._account = account;

  GAccountsByNameOrPkData_account_identityBuilder() {
    GAccountsByNameOrPkData_account_identity._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_account_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _account = $v.account?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData_account_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_account_identity;
  }

  @override
  void update(
      void Function(GAccountsByNameOrPkData_account_identityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_account_identity build() => _build();

  _$GAccountsByNameOrPkData_account_identity _build() {
    _$GAccountsByNameOrPkData_account_identity _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkData_account_identity._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GAccountsByNameOrPkData_account_identity', 'G__typename'),
              account: _account?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        _account?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkData_account_identity',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData_account_identity_account
    extends GAccountsByNameOrPkData_account_identity_account {
  @override
  final String G__typename;
  @override
  final GAccountsByNameOrPkData_account_identity_account_identity? identity;

  factory _$GAccountsByNameOrPkData_account_identity_account(
          [void Function(
                  GAccountsByNameOrPkData_account_identity_accountBuilder)?
              updates]) =>
      (new GAccountsByNameOrPkData_account_identity_accountBuilder()
            ..update(updates))
          ._build();

  _$GAccountsByNameOrPkData_account_identity_account._(
      {required this.G__typename, this.identity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GAccountsByNameOrPkData_account_identity_account', 'G__typename');
  }

  @override
  GAccountsByNameOrPkData_account_identity_account rebuild(
          void Function(GAccountsByNameOrPkData_account_identity_accountBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_account_identity_accountBuilder toBuilder() =>
      new GAccountsByNameOrPkData_account_identity_accountBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_account_identity_account &&
        G__typename == other.G__typename &&
        identity == other.identity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAccountsByNameOrPkData_account_identity_account')
          ..add('G__typename', G__typename)
          ..add('identity', identity))
        .toString();
  }
}

class GAccountsByNameOrPkData_account_identity_accountBuilder
    implements
        Builder<GAccountsByNameOrPkData_account_identity_account,
            GAccountsByNameOrPkData_account_identity_accountBuilder> {
  _$GAccountsByNameOrPkData_account_identity_account? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountsByNameOrPkData_account_identity_account_identityBuilder? _identity;
  GAccountsByNameOrPkData_account_identity_account_identityBuilder
      get identity => _$this._identity ??=
          new GAccountsByNameOrPkData_account_identity_account_identityBuilder();
  set identity(
          GAccountsByNameOrPkData_account_identity_account_identityBuilder?
              identity) =>
      _$this._identity = identity;

  GAccountsByNameOrPkData_account_identity_accountBuilder() {
    GAccountsByNameOrPkData_account_identity_account._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_account_identity_accountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identity = $v.identity?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData_account_identity_account other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_account_identity_account;
  }

  @override
  void update(
      void Function(GAccountsByNameOrPkData_account_identity_accountBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_account_identity_account build() => _build();

  _$GAccountsByNameOrPkData_account_identity_account _build() {
    _$GAccountsByNameOrPkData_account_identity_account _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkData_account_identity_account._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GAccountsByNameOrPkData_account_identity_account',
                  'G__typename'),
              identity: _identity?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        _identity?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkData_account_identity_account',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData_account_identity_account_identity
    extends GAccountsByNameOrPkData_account_identity_account_identity {
  @override
  final String G__typename;
  @override
  final String? name;
  @override
  final String pubkey;

  factory _$GAccountsByNameOrPkData_account_identity_account_identity(
          [void Function(
                  GAccountsByNameOrPkData_account_identity_account_identityBuilder)?
              updates]) =>
      (new GAccountsByNameOrPkData_account_identity_account_identityBuilder()
            ..update(updates))
          ._build();

  _$GAccountsByNameOrPkData_account_identity_account_identity._(
      {required this.G__typename, this.name, required this.pubkey})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GAccountsByNameOrPkData_account_identity_account_identity',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(pubkey,
        r'GAccountsByNameOrPkData_account_identity_account_identity', 'pubkey');
  }

  @override
  GAccountsByNameOrPkData_account_identity_account_identity rebuild(
          void Function(
                  GAccountsByNameOrPkData_account_identity_account_identityBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_account_identity_account_identityBuilder
      toBuilder() =>
          new GAccountsByNameOrPkData_account_identity_account_identityBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_account_identity_account_identity &&
        G__typename == other.G__typename &&
        name == other.name &&
        pubkey == other.pubkey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, pubkey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAccountsByNameOrPkData_account_identity_account_identity')
          ..add('G__typename', G__typename)
          ..add('name', name)
          ..add('pubkey', pubkey))
        .toString();
  }
}

class GAccountsByNameOrPkData_account_identity_account_identityBuilder
    implements
        Builder<GAccountsByNameOrPkData_account_identity_account_identity,
            GAccountsByNameOrPkData_account_identity_account_identityBuilder> {
  _$GAccountsByNameOrPkData_account_identity_account_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _pubkey;
  String? get pubkey => _$this._pubkey;
  set pubkey(String? pubkey) => _$this._pubkey = pubkey;

  GAccountsByNameOrPkData_account_identity_account_identityBuilder() {
    GAccountsByNameOrPkData_account_identity_account_identity
        ._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_account_identity_account_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _name = $v.name;
      _pubkey = $v.pubkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GAccountsByNameOrPkData_account_identity_account_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_account_identity_account_identity;
  }

  @override
  void update(
      void Function(
              GAccountsByNameOrPkData_account_identity_account_identityBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_account_identity_account_identity build() => _build();

  _$GAccountsByNameOrPkData_account_identity_account_identity _build() {
    final _$result = _$v ??
        new _$GAccountsByNameOrPkData_account_identity_account_identity._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GAccountsByNameOrPkData_account_identity_account_identity',
                'G__typename'),
            name: name,
            pubkey: BuiltValueNullFieldError.checkNotNull(
                pubkey,
                r'GAccountsByNameOrPkData_account_identity_account_identity',
                'pubkey'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
