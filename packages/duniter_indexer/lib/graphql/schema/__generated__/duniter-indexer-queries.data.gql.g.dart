// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-indexer-queries.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAccountsByNameOrPkData> _$gAccountsByNameOrPkDataSerializer =
    new _$GAccountsByNameOrPkDataSerializer();
Serializer<GAccountsByNameOrPkData_identity>
    _$gAccountsByNameOrPkDataIdentitySerializer =
    new _$GAccountsByNameOrPkData_identitySerializer();
Serializer<GAccountsByNameOrPkData_identity_account>
    _$gAccountsByNameOrPkDataIdentityAccountSerializer =
    new _$GAccountsByNameOrPkData_identity_accountSerializer();
Serializer<GAccountsByNameData> _$gAccountsByNameDataSerializer =
    new _$GAccountsByNameDataSerializer();
Serializer<GAccountsByNameData_identity>
    _$gAccountsByNameDataIdentitySerializer =
    new _$GAccountsByNameData_identitySerializer();
Serializer<GAccountsByNameData_identity_account>
    _$gAccountsByNameDataIdentityAccountSerializer =
    new _$GAccountsByNameData_identity_accountSerializer();
Serializer<GAccountByPkData> _$gAccountByPkDataSerializer =
    new _$GAccountByPkDataSerializer();
Serializer<GAccountByPkData_accountByPk>
    _$gAccountByPkDataAccountByPkSerializer =
    new _$GAccountByPkData_accountByPkSerializer();
Serializer<GLastBlockData> _$gLastBlockDataSerializer =
    new _$GLastBlockDataSerializer();
Serializer<GLastBlockData_block> _$gLastBlockDataBlockSerializer =
    new _$GLastBlockData_blockSerializer();
Serializer<GGetHistoryAndBalanceData> _$gGetHistoryAndBalanceDataSerializer =
    new _$GGetHistoryAndBalanceDataSerializer();
Serializer<GGetHistoryAndBalanceData_account>
    _$gGetHistoryAndBalanceDataAccountSerializer =
    new _$GGetHistoryAndBalanceData_accountSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersIssued>
    _$gGetHistoryAndBalanceDataAccountTransfersIssuedSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersIssuedSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersIssued_to>
    _$gGetHistoryAndBalanceDataAccountTransfersIssuedToSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersIssued_toSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersIssued_from>
    _$gGetHistoryAndBalanceDataAccountTransfersIssuedFromSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersIssued_fromSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersIssued_comment>
    _$gGetHistoryAndBalanceDataAccountTransfersIssuedCommentSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersIssued_commentSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersReceived>
    _$gGetHistoryAndBalanceDataAccountTransfersReceivedSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersReceivedSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersReceived_from>
    _$gGetHistoryAndBalanceDataAccountTransfersReceivedFromSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersReceived_fromSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersReceived_to>
    _$gGetHistoryAndBalanceDataAccountTransfersReceivedToSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersReceived_toSerializer();
Serializer<GGetHistoryAndBalanceData_account_transfersReceived_comment>
    _$gGetHistoryAndBalanceDataAccountTransfersReceivedCommentSerializer =
    new _$GGetHistoryAndBalanceData_account_transfersReceived_commentSerializer();

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
      'identity',
      serializers.serialize(object.identity,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GAccountsByNameOrPkData_identity)])),
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
        case 'identity':
          result.identity.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GAccountsByNameOrPkData_identity)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_identitySerializer
    implements StructuredSerializer<GAccountsByNameOrPkData_identity> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_identity,
    _$GAccountsByNameOrPkData_identity
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData_identity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkData_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isMember',
      serializers.serialize(object.isMember,
          specifiedType: const FullType(bool)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdOn',
      serializers.serialize(object.createdOn,
          specifiedType: const FullType(int)),
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.accountId;
    if (value != null) {
      result
        ..add('accountId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GIdentityStatusEnum)));
    }
    value = object.account;
    if (value != null) {
      result
        ..add('account')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GAccountsByNameOrPkData_identity_account)));
    }
    return result;
  }

  @override
  GAccountsByNameOrPkData_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkData_identityBuilder();

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
        case 'isMember':
          result.isMember = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GIdentityStatusEnum))
              as _i2.GIdentityStatusEnum?;
          break;
        case 'createdOn':
          result.createdOn = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAccountsByNameOrPkData_identity_account))!
              as GAccountsByNameOrPkData_identity_account);
          break;
        case 'index':
          result.index = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData_identity_accountSerializer
    implements StructuredSerializer<GAccountsByNameOrPkData_identity_account> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkData_identity_account,
    _$GAccountsByNameOrPkData_identity_account
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkData_identity_account';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkData_identity_account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isActive',
      serializers.serialize(object.isActive,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GAccountsByNameOrPkData_identity_account deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkData_identity_accountBuilder();

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
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameDataSerializer
    implements StructuredSerializer<GAccountsByNameData> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameData,
    _$GAccountsByNameData
  ];
  @override
  final String wireName = 'GAccountsByNameData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'identity',
      serializers.serialize(object.identity,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GAccountsByNameData_identity)])),
    ];

    return result;
  }

  @override
  GAccountsByNameData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameDataBuilder();

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
              specifiedType: const FullType(BuiltList, const [
                const FullType(GAccountsByNameData_identity)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameData_identitySerializer
    implements StructuredSerializer<GAccountsByNameData_identity> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameData_identity,
    _$GAccountsByNameData_identity
  ];
  @override
  final String wireName = 'GAccountsByNameData_identity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameData_identity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isMember',
      serializers.serialize(object.isMember,
          specifiedType: const FullType(bool)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'createdOn',
      serializers.serialize(object.createdOn,
          specifiedType: const FullType(int)),
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.accountId;
    if (value != null) {
      result
        ..add('accountId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GIdentityStatusEnum)));
    }
    value = object.account;
    if (value != null) {
      result
        ..add('account')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GAccountsByNameData_identity_account)));
    }
    return result;
  }

  @override
  GAccountsByNameData_identity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameData_identityBuilder();

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
        case 'isMember':
          result.isMember = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GIdentityStatusEnum))
              as _i2.GIdentityStatusEnum?;
          break;
        case 'createdOn':
          result.createdOn = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAccountsByNameData_identity_account))!
              as GAccountsByNameData_identity_account);
          break;
        case 'index':
          result.index = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameData_identity_accountSerializer
    implements StructuredSerializer<GAccountsByNameData_identity_account> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameData_identity_account,
    _$GAccountsByNameData_identity_account
  ];
  @override
  final String wireName = 'GAccountsByNameData_identity_account';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameData_identity_account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isActive',
      serializers.serialize(object.isActive,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GAccountsByNameData_identity_account deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameData_identity_accountBuilder();

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
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountByPkDataSerializer
    implements StructuredSerializer<GAccountByPkData> {
  @override
  final Iterable<Type> types = const [GAccountByPkData, _$GAccountByPkData];
  @override
  final String wireName = 'GAccountByPkData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAccountByPkData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.accountByPk;
    if (value != null) {
      result
        ..add('accountByPk')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GAccountByPkData_accountByPk)));
    }
    return result;
  }

  @override
  GAccountByPkData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountByPkDataBuilder();

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
        case 'accountByPk':
          result.accountByPk.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GAccountByPkData_accountByPk))!
              as GAccountByPkData_accountByPk);
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountByPkData_accountByPkSerializer
    implements StructuredSerializer<GAccountByPkData_accountByPk> {
  @override
  final Iterable<Type> types = const [
    GAccountByPkData_accountByPk,
    _$GAccountByPkData_accountByPk
  ];
  @override
  final String wireName = 'GAccountByPkData_accountByPk';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountByPkData_accountByPk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isActive',
      serializers.serialize(object.isActive,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GAccountByPkData_accountByPk deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountByPkData_accountByPkBuilder();

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
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GLastBlockDataSerializer
    implements StructuredSerializer<GLastBlockData> {
  @override
  final Iterable<Type> types = const [GLastBlockData, _$GLastBlockData];
  @override
  final String wireName = 'GLastBlockData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLastBlockData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'block',
      serializers.serialize(object.block,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GLastBlockData_block)])),
    ];

    return result;
  }

  @override
  GLastBlockData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastBlockDataBuilder();

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
        case 'block':
          result.block.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GLastBlockData_block)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GLastBlockData_blockSerializer
    implements StructuredSerializer<GLastBlockData_block> {
  @override
  final Iterable<Type> types = const [
    GLastBlockData_block,
    _$GLastBlockData_block
  ];
  @override
  final String wireName = 'GLastBlockData_block';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLastBlockData_block object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GLastBlockData_block deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLastBlockData_blockBuilder();

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
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceDataSerializer
    implements StructuredSerializer<GGetHistoryAndBalanceData> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData,
    _$GGetHistoryAndBalanceData
  ];
  @override
  final String wireName = 'GGetHistoryAndBalanceData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetHistoryAndBalanceData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'account',
      serializers.serialize(object.account,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GGetHistoryAndBalanceData_account)])),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetHistoryAndBalanceDataBuilder();

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
                const FullType(GGetHistoryAndBalanceData_account)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_accountSerializer
    implements StructuredSerializer<GGetHistoryAndBalanceData_account> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account,
    _$GGetHistoryAndBalanceData_account
  ];
  @override
  final String wireName = 'GGetHistoryAndBalanceData_account';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetHistoryAndBalanceData_account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'transfersIssued',
      serializers.serialize(object.transfersIssued,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_transfersIssued)
          ])),
      'transfersReceived',
      serializers.serialize(object.transfersReceived,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GGetHistoryAndBalanceData_account_transfersReceived)
          ])),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetHistoryAndBalanceData_accountBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'transfersIssued':
          result.transfersIssued.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GGetHistoryAndBalanceData_account_transfersIssued)
              ]))! as BuiltList<Object?>);
          break;
        case 'transfersReceived':
          result.transfersReceived.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GGetHistoryAndBalanceData_account_transfersReceived)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssuedSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersIssued> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersIssued,
    _$GGetHistoryAndBalanceData_account_transfersIssued
  ];
  @override
  final String wireName = 'GGetHistoryAndBalanceData_account_transfersIssued';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersIssued object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'blockNumber',
      serializers.serialize(object.blockNumber,
          specifiedType: const FullType(int)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(_i2.Gtimestamptz)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(_i2.Gnumeric)),
    ];
    Object? value;
    value = object.to;
    if (value != null) {
      result
        ..add('to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersIssued_to)));
    }
    value = object.from;
    if (value != null) {
      result
        ..add('from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersIssued_from)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersIssued_comment)));
    }
    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersIssuedBuilder();

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
        case 'blockNumber':
          result.blockNumber = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'timestamp':
          result.timestamp.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.Gtimestamptz))!
              as _i2.Gtimestamptz);
          break;
        case 'amount':
          result.amount.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.Gnumeric))! as _i2.Gnumeric);
          break;
        case 'to':
          result.to.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersIssued_to))!
              as GGetHistoryAndBalanceData_account_transfersIssued_to);
          break;
        case 'from':
          result.from.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersIssued_from))!
              as GGetHistoryAndBalanceData_account_transfersIssued_from);
          break;
        case 'comment':
          result.comment.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersIssued_comment))!
              as GGetHistoryAndBalanceData_account_transfersIssued_comment);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_toSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersIssued_to> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersIssued_to,
    _$GGetHistoryAndBalanceData_account_transfersIssued_to
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersIssued_to';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersIssued_to object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_to deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersIssued_toBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_fromSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersIssued_from> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersIssued_from,
    _$GGetHistoryAndBalanceData_account_transfersIssued_from
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersIssued_from';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersIssued_from object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_from deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_commentSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersIssued_comment> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersIssued_comment,
    _$GGetHistoryAndBalanceData_account_transfersIssued_comment
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersIssued_comment';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersIssued_comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'remark',
      serializers.serialize(object.remark,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_comment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder();

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
        case 'remark':
          result.remark = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceivedSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersReceived> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersReceived,
    _$GGetHistoryAndBalanceData_account_transfersReceived
  ];
  @override
  final String wireName = 'GGetHistoryAndBalanceData_account_transfersReceived';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersReceived object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'blockNumber',
      serializers.serialize(object.blockNumber,
          specifiedType: const FullType(int)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(_i2.Gtimestamptz)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(_i2.Gnumeric)),
    ];
    Object? value;
    value = object.from;
    if (value != null) {
      result
        ..add('from')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersReceived_from)));
    }
    value = object.to;
    if (value != null) {
      result
        ..add('to')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersReceived_to)));
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GGetHistoryAndBalanceData_account_transfersReceived_comment)));
    }
    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersReceivedBuilder();

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
        case 'blockNumber':
          result.blockNumber = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'timestamp':
          result.timestamp.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.Gtimestamptz))!
              as _i2.Gtimestamptz);
          break;
        case 'amount':
          result.amount.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.Gnumeric))! as _i2.Gnumeric);
          break;
        case 'from':
          result.from.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersReceived_from))!
              as GGetHistoryAndBalanceData_account_transfersReceived_from);
          break;
        case 'to':
          result.to.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersReceived_to))!
              as GGetHistoryAndBalanceData_account_transfersReceived_to);
          break;
        case 'comment':
          result.comment.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GGetHistoryAndBalanceData_account_transfersReceived_comment))!
              as GGetHistoryAndBalanceData_account_transfersReceived_comment);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_fromSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersReceived_from> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersReceived_from,
    _$GGetHistoryAndBalanceData_account_transfersReceived_from
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersReceived_from';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersReceived_from object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_from deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_toSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersReceived_to> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersReceived_to,
    _$GGetHistoryAndBalanceData_account_transfersReceived_to
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersReceived_to';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersReceived_to object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_to deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersReceived_toBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_commentSerializer
    implements
        StructuredSerializer<
            GGetHistoryAndBalanceData_account_transfersReceived_comment> {
  @override
  final Iterable<Type> types = const [
    GGetHistoryAndBalanceData_account_transfersReceived_comment,
    _$GGetHistoryAndBalanceData_account_transfersReceived_comment
  ];
  @override
  final String wireName =
      'GGetHistoryAndBalanceData_account_transfersReceived_comment';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GGetHistoryAndBalanceData_account_transfersReceived_comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'remark',
      serializers.serialize(object.remark,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_comment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder();

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
        case 'remark':
          result.remark = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByNameOrPkData extends GAccountsByNameOrPkData {
  @override
  final String G__typename;
  @override
  final BuiltList<GAccountsByNameOrPkData_identity> identity;

  factory _$GAccountsByNameOrPkData(
          [void Function(GAccountsByNameOrPkDataBuilder)? updates]) =>
      (new GAccountsByNameOrPkDataBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkData._(
      {required this.G__typename, required this.identity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameOrPkData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        identity, r'GAccountsByNameOrPkData', 'identity');
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
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkData')
          ..add('G__typename', G__typename)
          ..add('identity', identity))
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

  ListBuilder<GAccountsByNameOrPkData_identity>? _identity;
  ListBuilder<GAccountsByNameOrPkData_identity> get identity =>
      _$this._identity ??= new ListBuilder<GAccountsByNameOrPkData_identity>();
  set identity(ListBuilder<GAccountsByNameOrPkData_identity>? identity) =>
      _$this._identity = identity;

  GAccountsByNameOrPkDataBuilder() {
    GAccountsByNameOrPkData._initializeBuilder(this);
  }

  GAccountsByNameOrPkDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identity = $v.identity.toBuilder();
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
              identity: identity.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        identity.build();
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

class _$GAccountsByNameOrPkData_identity
    extends GAccountsByNameOrPkData_identity {
  @override
  final String G__typename;
  @override
  final bool isMember;
  @override
  final String name;
  @override
  final String? accountId;
  @override
  final _i2.GIdentityStatusEnum? status;
  @override
  final int createdOn;
  @override
  final GAccountsByNameOrPkData_identity_account? account;
  @override
  final int index;

  factory _$GAccountsByNameOrPkData_identity(
          [void Function(GAccountsByNameOrPkData_identityBuilder)? updates]) =>
      (new GAccountsByNameOrPkData_identityBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkData_identity._(
      {required this.G__typename,
      required this.isMember,
      required this.name,
      this.accountId,
      this.status,
      required this.createdOn,
      this.account,
      required this.index})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameOrPkData_identity', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        isMember, r'GAccountsByNameOrPkData_identity', 'isMember');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GAccountsByNameOrPkData_identity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdOn, r'GAccountsByNameOrPkData_identity', 'createdOn');
    BuiltValueNullFieldError.checkNotNull(
        index, r'GAccountsByNameOrPkData_identity', 'index');
  }

  @override
  GAccountsByNameOrPkData_identity rebuild(
          void Function(GAccountsByNameOrPkData_identityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_identityBuilder toBuilder() =>
      new GAccountsByNameOrPkData_identityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_identity &&
        G__typename == other.G__typename &&
        isMember == other.isMember &&
        name == other.name &&
        accountId == other.accountId &&
        status == other.status &&
        createdOn == other.createdOn &&
        account == other.account &&
        index == other.index;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isMember.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdOn.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkData_identity')
          ..add('G__typename', G__typename)
          ..add('isMember', isMember)
          ..add('name', name)
          ..add('accountId', accountId)
          ..add('status', status)
          ..add('createdOn', createdOn)
          ..add('account', account)
          ..add('index', index))
        .toString();
  }
}

class GAccountsByNameOrPkData_identityBuilder
    implements
        Builder<GAccountsByNameOrPkData_identity,
            GAccountsByNameOrPkData_identityBuilder> {
  _$GAccountsByNameOrPkData_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isMember;
  bool? get isMember => _$this._isMember;
  set isMember(bool? isMember) => _$this._isMember = isMember;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  _i2.GIdentityStatusEnum? _status;
  _i2.GIdentityStatusEnum? get status => _$this._status;
  set status(_i2.GIdentityStatusEnum? status) => _$this._status = status;

  int? _createdOn;
  int? get createdOn => _$this._createdOn;
  set createdOn(int? createdOn) => _$this._createdOn = createdOn;

  GAccountsByNameOrPkData_identity_accountBuilder? _account;
  GAccountsByNameOrPkData_identity_accountBuilder get account =>
      _$this._account ??= new GAccountsByNameOrPkData_identity_accountBuilder();
  set account(GAccountsByNameOrPkData_identity_accountBuilder? account) =>
      _$this._account = account;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  GAccountsByNameOrPkData_identityBuilder() {
    GAccountsByNameOrPkData_identity._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isMember = $v.isMember;
      _name = $v.name;
      _accountId = $v.accountId;
      _status = $v.status;
      _createdOn = $v.createdOn;
      _account = $v.account?.toBuilder();
      _index = $v.index;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_identity;
  }

  @override
  void update(void Function(GAccountsByNameOrPkData_identityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_identity build() => _build();

  _$GAccountsByNameOrPkData_identity _build() {
    _$GAccountsByNameOrPkData_identity _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameOrPkData_identity._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GAccountsByNameOrPkData_identity', 'G__typename'),
              isMember: BuiltValueNullFieldError.checkNotNull(
                  isMember, r'GAccountsByNameOrPkData_identity', 'isMember'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'GAccountsByNameOrPkData_identity', 'name'),
              accountId: accountId,
              status: status,
              createdOn: BuiltValueNullFieldError.checkNotNull(
                  createdOn, r'GAccountsByNameOrPkData_identity', 'createdOn'),
              account: _account?.build(),
              index: BuiltValueNullFieldError.checkNotNull(
                  index, r'GAccountsByNameOrPkData_identity', 'index'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        _account?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameOrPkData_identity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkData_identity_account
    extends GAccountsByNameOrPkData_identity_account {
  @override
  final String G__typename;
  @override
  final bool isActive;

  factory _$GAccountsByNameOrPkData_identity_account(
          [void Function(GAccountsByNameOrPkData_identity_accountBuilder)?
              updates]) =>
      (new GAccountsByNameOrPkData_identity_accountBuilder()..update(updates))
          ._build();

  _$GAccountsByNameOrPkData_identity_account._(
      {required this.G__typename, required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GAccountsByNameOrPkData_identity_account', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        isActive, r'GAccountsByNameOrPkData_identity_account', 'isActive');
  }

  @override
  GAccountsByNameOrPkData_identity_account rebuild(
          void Function(GAccountsByNameOrPkData_identity_accountBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkData_identity_accountBuilder toBuilder() =>
      new GAccountsByNameOrPkData_identity_accountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkData_identity_account &&
        G__typename == other.G__typename &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GAccountsByNameOrPkData_identity_account')
          ..add('G__typename', G__typename)
          ..add('isActive', isActive))
        .toString();
  }
}

class GAccountsByNameOrPkData_identity_accountBuilder
    implements
        Builder<GAccountsByNameOrPkData_identity_account,
            GAccountsByNameOrPkData_identity_accountBuilder> {
  _$GAccountsByNameOrPkData_identity_account? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  GAccountsByNameOrPkData_identity_accountBuilder() {
    GAccountsByNameOrPkData_identity_account._initializeBuilder(this);
  }

  GAccountsByNameOrPkData_identity_accountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkData_identity_account other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkData_identity_account;
  }

  @override
  void update(
      void Function(GAccountsByNameOrPkData_identity_accountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkData_identity_account build() => _build();

  _$GAccountsByNameOrPkData_identity_account _build() {
    final _$result = _$v ??
        new _$GAccountsByNameOrPkData_identity_account._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAccountsByNameOrPkData_identity_account', 'G__typename'),
            isActive: BuiltValueNullFieldError.checkNotNull(isActive,
                r'GAccountsByNameOrPkData_identity_account', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameData extends GAccountsByNameData {
  @override
  final String G__typename;
  @override
  final BuiltList<GAccountsByNameData_identity> identity;

  factory _$GAccountsByNameData(
          [void Function(GAccountsByNameDataBuilder)? updates]) =>
      (new GAccountsByNameDataBuilder()..update(updates))._build();

  _$GAccountsByNameData._({required this.G__typename, required this.identity})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        identity, r'GAccountsByNameData', 'identity');
  }

  @override
  GAccountsByNameData rebuild(
          void Function(GAccountsByNameDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameDataBuilder toBuilder() =>
      new GAccountsByNameDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameData &&
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
    return (newBuiltValueToStringHelper(r'GAccountsByNameData')
          ..add('G__typename', G__typename)
          ..add('identity', identity))
        .toString();
  }
}

class GAccountsByNameDataBuilder
    implements Builder<GAccountsByNameData, GAccountsByNameDataBuilder> {
  _$GAccountsByNameData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GAccountsByNameData_identity>? _identity;
  ListBuilder<GAccountsByNameData_identity> get identity =>
      _$this._identity ??= new ListBuilder<GAccountsByNameData_identity>();
  set identity(ListBuilder<GAccountsByNameData_identity>? identity) =>
      _$this._identity = identity;

  GAccountsByNameDataBuilder() {
    GAccountsByNameData._initializeBuilder(this);
  }

  GAccountsByNameDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _identity = $v.identity.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameData;
  }

  @override
  void update(void Function(GAccountsByNameDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameData build() => _build();

  _$GAccountsByNameData _build() {
    _$GAccountsByNameData _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAccountsByNameData', 'G__typename'),
              identity: identity.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        identity.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameData_identity extends GAccountsByNameData_identity {
  @override
  final String G__typename;
  @override
  final bool isMember;
  @override
  final String name;
  @override
  final String? accountId;
  @override
  final _i2.GIdentityStatusEnum? status;
  @override
  final int createdOn;
  @override
  final GAccountsByNameData_identity_account? account;
  @override
  final int index;

  factory _$GAccountsByNameData_identity(
          [void Function(GAccountsByNameData_identityBuilder)? updates]) =>
      (new GAccountsByNameData_identityBuilder()..update(updates))._build();

  _$GAccountsByNameData_identity._(
      {required this.G__typename,
      required this.isMember,
      required this.name,
      this.accountId,
      this.status,
      required this.createdOn,
      this.account,
      required this.index})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameData_identity', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        isMember, r'GAccountsByNameData_identity', 'isMember');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GAccountsByNameData_identity', 'name');
    BuiltValueNullFieldError.checkNotNull(
        createdOn, r'GAccountsByNameData_identity', 'createdOn');
    BuiltValueNullFieldError.checkNotNull(
        index, r'GAccountsByNameData_identity', 'index');
  }

  @override
  GAccountsByNameData_identity rebuild(
          void Function(GAccountsByNameData_identityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameData_identityBuilder toBuilder() =>
      new GAccountsByNameData_identityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameData_identity &&
        G__typename == other.G__typename &&
        isMember == other.isMember &&
        name == other.name &&
        accountId == other.accountId &&
        status == other.status &&
        createdOn == other.createdOn &&
        account == other.account &&
        index == other.index;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isMember.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdOn.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameData_identity')
          ..add('G__typename', G__typename)
          ..add('isMember', isMember)
          ..add('name', name)
          ..add('accountId', accountId)
          ..add('status', status)
          ..add('createdOn', createdOn)
          ..add('account', account)
          ..add('index', index))
        .toString();
  }
}

class GAccountsByNameData_identityBuilder
    implements
        Builder<GAccountsByNameData_identity,
            GAccountsByNameData_identityBuilder> {
  _$GAccountsByNameData_identity? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isMember;
  bool? get isMember => _$this._isMember;
  set isMember(bool? isMember) => _$this._isMember = isMember;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  _i2.GIdentityStatusEnum? _status;
  _i2.GIdentityStatusEnum? get status => _$this._status;
  set status(_i2.GIdentityStatusEnum? status) => _$this._status = status;

  int? _createdOn;
  int? get createdOn => _$this._createdOn;
  set createdOn(int? createdOn) => _$this._createdOn = createdOn;

  GAccountsByNameData_identity_accountBuilder? _account;
  GAccountsByNameData_identity_accountBuilder get account =>
      _$this._account ??= new GAccountsByNameData_identity_accountBuilder();
  set account(GAccountsByNameData_identity_accountBuilder? account) =>
      _$this._account = account;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  GAccountsByNameData_identityBuilder() {
    GAccountsByNameData_identity._initializeBuilder(this);
  }

  GAccountsByNameData_identityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isMember = $v.isMember;
      _name = $v.name;
      _accountId = $v.accountId;
      _status = $v.status;
      _createdOn = $v.createdOn;
      _account = $v.account?.toBuilder();
      _index = $v.index;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameData_identity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameData_identity;
  }

  @override
  void update(void Function(GAccountsByNameData_identityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameData_identity build() => _build();

  _$GAccountsByNameData_identity _build() {
    _$GAccountsByNameData_identity _$result;
    try {
      _$result = _$v ??
          new _$GAccountsByNameData_identity._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAccountsByNameData_identity', 'G__typename'),
              isMember: BuiltValueNullFieldError.checkNotNull(
                  isMember, r'GAccountsByNameData_identity', 'isMember'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'GAccountsByNameData_identity', 'name'),
              accountId: accountId,
              status: status,
              createdOn: BuiltValueNullFieldError.checkNotNull(
                  createdOn, r'GAccountsByNameData_identity', 'createdOn'),
              account: _account?.build(),
              index: BuiltValueNullFieldError.checkNotNull(
                  index, r'GAccountsByNameData_identity', 'index'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        _account?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountsByNameData_identity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameData_identity_account
    extends GAccountsByNameData_identity_account {
  @override
  final String G__typename;
  @override
  final bool isActive;

  factory _$GAccountsByNameData_identity_account(
          [void Function(GAccountsByNameData_identity_accountBuilder)?
              updates]) =>
      (new GAccountsByNameData_identity_accountBuilder()..update(updates))
          ._build();

  _$GAccountsByNameData_identity_account._(
      {required this.G__typename, required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountsByNameData_identity_account', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        isActive, r'GAccountsByNameData_identity_account', 'isActive');
  }

  @override
  GAccountsByNameData_identity_account rebuild(
          void Function(GAccountsByNameData_identity_accountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameData_identity_accountBuilder toBuilder() =>
      new GAccountsByNameData_identity_accountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameData_identity_account &&
        G__typename == other.G__typename &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByNameData_identity_account')
          ..add('G__typename', G__typename)
          ..add('isActive', isActive))
        .toString();
  }
}

class GAccountsByNameData_identity_accountBuilder
    implements
        Builder<GAccountsByNameData_identity_account,
            GAccountsByNameData_identity_accountBuilder> {
  _$GAccountsByNameData_identity_account? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  GAccountsByNameData_identity_accountBuilder() {
    GAccountsByNameData_identity_account._initializeBuilder(this);
  }

  GAccountsByNameData_identity_accountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameData_identity_account other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameData_identity_account;
  }

  @override
  void update(
      void Function(GAccountsByNameData_identity_accountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameData_identity_account build() => _build();

  _$GAccountsByNameData_identity_account _build() {
    final _$result = _$v ??
        new _$GAccountsByNameData_identity_account._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAccountsByNameData_identity_account', 'G__typename'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'GAccountsByNameData_identity_account', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

class _$GAccountByPkData extends GAccountByPkData {
  @override
  final String G__typename;
  @override
  final GAccountByPkData_accountByPk? accountByPk;

  factory _$GAccountByPkData(
          [void Function(GAccountByPkDataBuilder)? updates]) =>
      (new GAccountByPkDataBuilder()..update(updates))._build();

  _$GAccountByPkData._({required this.G__typename, this.accountByPk})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountByPkData', 'G__typename');
  }

  @override
  GAccountByPkData rebuild(void Function(GAccountByPkDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountByPkDataBuilder toBuilder() =>
      new GAccountByPkDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountByPkData &&
        G__typename == other.G__typename &&
        accountByPk == other.accountByPk;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, accountByPk.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountByPkData')
          ..add('G__typename', G__typename)
          ..add('accountByPk', accountByPk))
        .toString();
  }
}

class GAccountByPkDataBuilder
    implements Builder<GAccountByPkData, GAccountByPkDataBuilder> {
  _$GAccountByPkData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAccountByPkData_accountByPkBuilder? _accountByPk;
  GAccountByPkData_accountByPkBuilder get accountByPk =>
      _$this._accountByPk ??= new GAccountByPkData_accountByPkBuilder();
  set accountByPk(GAccountByPkData_accountByPkBuilder? accountByPk) =>
      _$this._accountByPk = accountByPk;

  GAccountByPkDataBuilder() {
    GAccountByPkData._initializeBuilder(this);
  }

  GAccountByPkDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _accountByPk = $v.accountByPk?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountByPkData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountByPkData;
  }

  @override
  void update(void Function(GAccountByPkDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountByPkData build() => _build();

  _$GAccountByPkData _build() {
    _$GAccountByPkData _$result;
    try {
      _$result = _$v ??
          new _$GAccountByPkData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GAccountByPkData', 'G__typename'),
              accountByPk: _accountByPk?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accountByPk';
        _accountByPk?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAccountByPkData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAccountByPkData_accountByPk extends GAccountByPkData_accountByPk {
  @override
  final String G__typename;
  @override
  final bool isActive;

  factory _$GAccountByPkData_accountByPk(
          [void Function(GAccountByPkData_accountByPkBuilder)? updates]) =>
      (new GAccountByPkData_accountByPkBuilder()..update(updates))._build();

  _$GAccountByPkData_accountByPk._(
      {required this.G__typename, required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAccountByPkData_accountByPk', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        isActive, r'GAccountByPkData_accountByPk', 'isActive');
  }

  @override
  GAccountByPkData_accountByPk rebuild(
          void Function(GAccountByPkData_accountByPkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountByPkData_accountByPkBuilder toBuilder() =>
      new GAccountByPkData_accountByPkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountByPkData_accountByPk &&
        G__typename == other.G__typename &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountByPkData_accountByPk')
          ..add('G__typename', G__typename)
          ..add('isActive', isActive))
        .toString();
  }
}

class GAccountByPkData_accountByPkBuilder
    implements
        Builder<GAccountByPkData_accountByPk,
            GAccountByPkData_accountByPkBuilder> {
  _$GAccountByPkData_accountByPk? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  GAccountByPkData_accountByPkBuilder() {
    GAccountByPkData_accountByPk._initializeBuilder(this);
  }

  GAccountByPkData_accountByPkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountByPkData_accountByPk other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountByPkData_accountByPk;
  }

  @override
  void update(void Function(GAccountByPkData_accountByPkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountByPkData_accountByPk build() => _build();

  _$GAccountByPkData_accountByPk _build() {
    final _$result = _$v ??
        new _$GAccountByPkData_accountByPk._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GAccountByPkData_accountByPk', 'G__typename'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'GAccountByPkData_accountByPk', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

class _$GLastBlockData extends GLastBlockData {
  @override
  final String G__typename;
  @override
  final BuiltList<GLastBlockData_block> block;

  factory _$GLastBlockData([void Function(GLastBlockDataBuilder)? updates]) =>
      (new GLastBlockDataBuilder()..update(updates))._build();

  _$GLastBlockData._({required this.G__typename, required this.block})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLastBlockData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(block, r'GLastBlockData', 'block');
  }

  @override
  GLastBlockData rebuild(void Function(GLastBlockDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastBlockDataBuilder toBuilder() =>
      new GLastBlockDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastBlockData &&
        G__typename == other.G__typename &&
        block == other.block;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, block.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLastBlockData')
          ..add('G__typename', G__typename)
          ..add('block', block))
        .toString();
  }
}

class GLastBlockDataBuilder
    implements Builder<GLastBlockData, GLastBlockDataBuilder> {
  _$GLastBlockData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GLastBlockData_block>? _block;
  ListBuilder<GLastBlockData_block> get block =>
      _$this._block ??= new ListBuilder<GLastBlockData_block>();
  set block(ListBuilder<GLastBlockData_block>? block) => _$this._block = block;

  GLastBlockDataBuilder() {
    GLastBlockData._initializeBuilder(this);
  }

  GLastBlockDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _block = $v.block.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastBlockData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastBlockData;
  }

  @override
  void update(void Function(GLastBlockDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastBlockData build() => _build();

  _$GLastBlockData _build() {
    _$GLastBlockData _$result;
    try {
      _$result = _$v ??
          new _$GLastBlockData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GLastBlockData', 'G__typename'),
              block: block.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'block';
        block.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLastBlockData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLastBlockData_block extends GLastBlockData_block {
  @override
  final String G__typename;
  @override
  final int height;

  factory _$GLastBlockData_block(
          [void Function(GLastBlockData_blockBuilder)? updates]) =>
      (new GLastBlockData_blockBuilder()..update(updates))._build();

  _$GLastBlockData_block._({required this.G__typename, required this.height})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLastBlockData_block', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        height, r'GLastBlockData_block', 'height');
  }

  @override
  GLastBlockData_block rebuild(
          void Function(GLastBlockData_blockBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastBlockData_blockBuilder toBuilder() =>
      new GLastBlockData_blockBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastBlockData_block &&
        G__typename == other.G__typename &&
        height == other.height;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLastBlockData_block')
          ..add('G__typename', G__typename)
          ..add('height', height))
        .toString();
  }
}

class GLastBlockData_blockBuilder
    implements Builder<GLastBlockData_block, GLastBlockData_blockBuilder> {
  _$GLastBlockData_block? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  GLastBlockData_blockBuilder() {
    GLastBlockData_block._initializeBuilder(this);
  }

  GLastBlockData_blockBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _height = $v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLastBlockData_block other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastBlockData_block;
  }

  @override
  void update(void Function(GLastBlockData_blockBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastBlockData_block build() => _build();

  _$GLastBlockData_block _build() {
    final _$result = _$v ??
        new _$GLastBlockData_block._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GLastBlockData_block', 'G__typename'),
            height: BuiltValueNullFieldError.checkNotNull(
                height, r'GLastBlockData_block', 'height'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData extends GGetHistoryAndBalanceData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetHistoryAndBalanceData_account> account;

  factory _$GGetHistoryAndBalanceData(
          [void Function(GGetHistoryAndBalanceDataBuilder)? updates]) =>
      (new GGetHistoryAndBalanceDataBuilder()..update(updates))._build();

  _$GGetHistoryAndBalanceData._(
      {required this.G__typename, required this.account})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetHistoryAndBalanceData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        account, r'GGetHistoryAndBalanceData', 'account');
  }

  @override
  GGetHistoryAndBalanceData rebuild(
          void Function(GGetHistoryAndBalanceDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceDataBuilder toBuilder() =>
      new GGetHistoryAndBalanceDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData &&
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
    return (newBuiltValueToStringHelper(r'GGetHistoryAndBalanceData')
          ..add('G__typename', G__typename)
          ..add('account', account))
        .toString();
  }
}

class GGetHistoryAndBalanceDataBuilder
    implements
        Builder<GGetHistoryAndBalanceData, GGetHistoryAndBalanceDataBuilder> {
  _$GGetHistoryAndBalanceData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetHistoryAndBalanceData_account>? _account;
  ListBuilder<GGetHistoryAndBalanceData_account> get account =>
      _$this._account ??= new ListBuilder<GGetHistoryAndBalanceData_account>();
  set account(ListBuilder<GGetHistoryAndBalanceData_account>? account) =>
      _$this._account = account;

  GGetHistoryAndBalanceDataBuilder() {
    GGetHistoryAndBalanceData._initializeBuilder(this);
  }

  GGetHistoryAndBalanceDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _account = $v.account.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData;
  }

  @override
  void update(void Function(GGetHistoryAndBalanceDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData build() => _build();

  _$GGetHistoryAndBalanceData _build() {
    _$GGetHistoryAndBalanceData _$result;
    try {
      _$result = _$v ??
          new _$GGetHistoryAndBalanceData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetHistoryAndBalanceData', 'G__typename'),
              account: account.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'account';
        account.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetHistoryAndBalanceData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account
    extends GGetHistoryAndBalanceData_account {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final BuiltList<GGetHistoryAndBalanceData_account_transfersIssued>
      transfersIssued;
  @override
  final BuiltList<GGetHistoryAndBalanceData_account_transfersReceived>
      transfersReceived;

  factory _$GGetHistoryAndBalanceData_account(
          [void Function(GGetHistoryAndBalanceData_accountBuilder)? updates]) =>
      (new GGetHistoryAndBalanceData_accountBuilder()..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account._(
      {required this.G__typename,
      required this.id,
      required this.transfersIssued,
      required this.transfersReceived})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetHistoryAndBalanceData_account', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetHistoryAndBalanceData_account', 'id');
    BuiltValueNullFieldError.checkNotNull(transfersIssued,
        r'GGetHistoryAndBalanceData_account', 'transfersIssued');
    BuiltValueNullFieldError.checkNotNull(transfersReceived,
        r'GGetHistoryAndBalanceData_account', 'transfersReceived');
  }

  @override
  GGetHistoryAndBalanceData_account rebuild(
          void Function(GGetHistoryAndBalanceData_accountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_accountBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_accountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account &&
        G__typename == other.G__typename &&
        id == other.id &&
        transfersIssued == other.transfersIssued &&
        transfersReceived == other.transfersReceived;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, transfersIssued.hashCode);
    _$hash = $jc(_$hash, transfersReceived.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetHistoryAndBalanceData_account')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('transfersIssued', transfersIssued)
          ..add('transfersReceived', transfersReceived))
        .toString();
  }
}

class GGetHistoryAndBalanceData_accountBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account,
            GGetHistoryAndBalanceData_accountBuilder> {
  _$GGetHistoryAndBalanceData_account? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<GGetHistoryAndBalanceData_account_transfersIssued>?
      _transfersIssued;
  ListBuilder<GGetHistoryAndBalanceData_account_transfersIssued>
      get transfersIssued => _$this._transfersIssued ??=
          new ListBuilder<GGetHistoryAndBalanceData_account_transfersIssued>();
  set transfersIssued(
          ListBuilder<GGetHistoryAndBalanceData_account_transfersIssued>?
              transfersIssued) =>
      _$this._transfersIssued = transfersIssued;

  ListBuilder<GGetHistoryAndBalanceData_account_transfersReceived>?
      _transfersReceived;
  ListBuilder<GGetHistoryAndBalanceData_account_transfersReceived>
      get transfersReceived => _$this._transfersReceived ??= new ListBuilder<
          GGetHistoryAndBalanceData_account_transfersReceived>();
  set transfersReceived(
          ListBuilder<GGetHistoryAndBalanceData_account_transfersReceived>?
              transfersReceived) =>
      _$this._transfersReceived = transfersReceived;

  GGetHistoryAndBalanceData_accountBuilder() {
    GGetHistoryAndBalanceData_account._initializeBuilder(this);
  }

  GGetHistoryAndBalanceData_accountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _transfersIssued = $v.transfersIssued.toBuilder();
      _transfersReceived = $v.transfersReceived.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account;
  }

  @override
  void update(
      void Function(GGetHistoryAndBalanceData_accountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account build() => _build();

  _$GGetHistoryAndBalanceData_account _build() {
    _$GGetHistoryAndBalanceData_account _$result;
    try {
      _$result = _$v ??
          new _$GGetHistoryAndBalanceData_account._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GGetHistoryAndBalanceData_account', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GGetHistoryAndBalanceData_account', 'id'),
              transfersIssued: transfersIssued.build(),
              transfersReceived: transfersReceived.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transfersIssued';
        transfersIssued.build();
        _$failedField = 'transfersReceived';
        transfersReceived.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetHistoryAndBalanceData_account', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued
    extends GGetHistoryAndBalanceData_account_transfersIssued {
  @override
  final String G__typename;
  @override
  final int blockNumber;
  @override
  final _i2.Gtimestamptz timestamp;
  @override
  final _i2.Gnumeric amount;
  @override
  final GGetHistoryAndBalanceData_account_transfersIssued_to? to;
  @override
  final GGetHistoryAndBalanceData_account_transfersIssued_from? from;
  @override
  final GGetHistoryAndBalanceData_account_transfersIssued_comment? comment;

  factory _$GGetHistoryAndBalanceData_account_transfersIssued(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssuedBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersIssuedBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersIssued._(
      {required this.G__typename,
      required this.blockNumber,
      required this.timestamp,
      required this.amount,
      this.to,
      this.from,
      this.comment})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GGetHistoryAndBalanceData_account_transfersIssued', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(blockNumber,
        r'GGetHistoryAndBalanceData_account_transfersIssued', 'blockNumber');
    BuiltValueNullFieldError.checkNotNull(timestamp,
        r'GGetHistoryAndBalanceData_account_transfersIssued', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'GGetHistoryAndBalanceData_account_transfersIssued', 'amount');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersIssuedBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersIssuedBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersIssuedBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersIssued &&
        G__typename == other.G__typename &&
        blockNumber == other.blockNumber &&
        timestamp == other.timestamp &&
        amount == other.amount &&
        to == other.to &&
        from == other.from &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersIssued')
          ..add('G__typename', G__typename)
          ..add('blockNumber', blockNumber)
          ..add('timestamp', timestamp)
          ..add('amount', amount)
          ..add('to', to)
          ..add('from', from)
          ..add('comment', comment))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersIssuedBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersIssued,
            GGetHistoryAndBalanceData_account_transfersIssuedBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersIssued? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  _i2.GtimestamptzBuilder? _timestamp;
  _i2.GtimestamptzBuilder get timestamp =>
      _$this._timestamp ??= new _i2.GtimestamptzBuilder();
  set timestamp(_i2.GtimestamptzBuilder? timestamp) =>
      _$this._timestamp = timestamp;

  _i2.GnumericBuilder? _amount;
  _i2.GnumericBuilder get amount =>
      _$this._amount ??= new _i2.GnumericBuilder();
  set amount(_i2.GnumericBuilder? amount) => _$this._amount = amount;

  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder? _to;
  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder get to =>
      _$this._to ??=
          new GGetHistoryAndBalanceData_account_transfersIssued_toBuilder();
  set to(GGetHistoryAndBalanceData_account_transfersIssued_toBuilder? to) =>
      _$this._to = to;

  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder? _from;
  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder get from =>
      _$this._from ??=
          new GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder();
  set from(
          GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder?
              from) =>
      _$this._from = from;

  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder? _comment;
  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder
      get comment => _$this._comment ??=
          new GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder();
  set comment(
          GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder?
              comment) =>
      _$this._comment = comment;

  GGetHistoryAndBalanceData_account_transfersIssuedBuilder() {
    GGetHistoryAndBalanceData_account_transfersIssued._initializeBuilder(this);
  }

  GGetHistoryAndBalanceData_account_transfersIssuedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _blockNumber = $v.blockNumber;
      _timestamp = $v.timestamp.toBuilder();
      _amount = $v.amount.toBuilder();
      _to = $v.to?.toBuilder();
      _from = $v.from?.toBuilder();
      _comment = $v.comment?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersIssued other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersIssued;
  }

  @override
  void update(
      void Function(GGetHistoryAndBalanceData_account_transfersIssuedBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersIssued _build() {
    _$GGetHistoryAndBalanceData_account_transfersIssued _$result;
    try {
      _$result = _$v ??
          new _$GGetHistoryAndBalanceData_account_transfersIssued._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GGetHistoryAndBalanceData_account_transfersIssued',
                  'G__typename'),
              blockNumber: BuiltValueNullFieldError.checkNotNull(
                  blockNumber,
                  r'GGetHistoryAndBalanceData_account_transfersIssued',
                  'blockNumber'),
              timestamp: timestamp.build(),
              amount: amount.build(),
              to: _to?.build(),
              from: _from?.build(),
              comment: _comment?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'timestamp';
        timestamp.build();
        _$failedField = 'amount';
        amount.build();
        _$failedField = 'to';
        _to?.build();
        _$failedField = 'from';
        _from?.build();
        _$failedField = 'comment';
        _comment?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetHistoryAndBalanceData_account_transfersIssued',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_to
    extends GGetHistoryAndBalanceData_account_transfersIssued_to {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GGetHistoryAndBalanceData_account_transfersIssued_to(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersIssued_toBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_to._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GGetHistoryAndBalanceData_account_transfersIssued_to', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetHistoryAndBalanceData_account_transfersIssued_to', 'id');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_to rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersIssued_toBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersIssued_to &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersIssued_to')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersIssued_toBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersIssued_to,
            GGetHistoryAndBalanceData_account_transfersIssued_toBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersIssued_to? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder() {
    GGetHistoryAndBalanceData_account_transfersIssued_to._initializeBuilder(
        this);
  }

  GGetHistoryAndBalanceData_account_transfersIssued_toBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersIssued_to other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersIssued_to;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_toBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_to build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_to _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersIssued_to._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersIssued_to',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GGetHistoryAndBalanceData_account_transfersIssued_to', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_from
    extends GGetHistoryAndBalanceData_account_transfersIssued_from {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GGetHistoryAndBalanceData_account_transfersIssued_from(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_from._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetHistoryAndBalanceData_account_transfersIssued_from',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetHistoryAndBalanceData_account_transfersIssued_from', 'id');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_from rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersIssued_from &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersIssued_from')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersIssued_from,
            GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersIssued_from? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder() {
    GGetHistoryAndBalanceData_account_transfersIssued_from._initializeBuilder(
        this);
  }

  GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersIssued_from other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersIssued_from;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_fromBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_from build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_from _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersIssued_from._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersIssued_from',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GGetHistoryAndBalanceData_account_transfersIssued_from',
                'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersIssued_comment
    extends GGetHistoryAndBalanceData_account_transfersIssued_comment {
  @override
  final String G__typename;
  @override
  final String remark;

  factory _$GGetHistoryAndBalanceData_account_transfersIssued_comment(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_comment._(
      {required this.G__typename, required this.remark})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetHistoryAndBalanceData_account_transfersIssued_comment',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(remark,
        r'GGetHistoryAndBalanceData_account_transfersIssued_comment', 'remark');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_comment rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder
      toBuilder() =>
          new GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersIssued_comment &&
        G__typename == other.G__typename &&
        remark == other.remark;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, remark.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersIssued_comment')
          ..add('G__typename', G__typename)
          ..add('remark', remark))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersIssued_comment,
            GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersIssued_comment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _remark;
  String? get remark => _$this._remark;
  set remark(String? remark) => _$this._remark = remark;

  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder() {
    GGetHistoryAndBalanceData_account_transfersIssued_comment
        ._initializeBuilder(this);
  }

  GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _remark = $v.remark;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetHistoryAndBalanceData_account_transfersIssued_comment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersIssued_comment;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersIssued_commentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersIssued_comment build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersIssued_comment _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersIssued_comment._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersIssued_comment',
                'G__typename'),
            remark: BuiltValueNullFieldError.checkNotNull(
                remark,
                r'GGetHistoryAndBalanceData_account_transfersIssued_comment',
                'remark'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived
    extends GGetHistoryAndBalanceData_account_transfersReceived {
  @override
  final String G__typename;
  @override
  final int blockNumber;
  @override
  final _i2.Gtimestamptz timestamp;
  @override
  final _i2.Gnumeric amount;
  @override
  final GGetHistoryAndBalanceData_account_transfersReceived_from? from;
  @override
  final GGetHistoryAndBalanceData_account_transfersReceived_to? to;
  @override
  final GGetHistoryAndBalanceData_account_transfersReceived_comment? comment;

  factory _$GGetHistoryAndBalanceData_account_transfersReceived(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceivedBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersReceivedBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersReceived._(
      {required this.G__typename,
      required this.blockNumber,
      required this.timestamp,
      required this.amount,
      this.from,
      this.to,
      this.comment})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GGetHistoryAndBalanceData_account_transfersReceived', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(blockNumber,
        r'GGetHistoryAndBalanceData_account_transfersReceived', 'blockNumber');
    BuiltValueNullFieldError.checkNotNull(timestamp,
        r'GGetHistoryAndBalanceData_account_transfersReceived', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(amount,
        r'GGetHistoryAndBalanceData_account_transfersReceived', 'amount');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersReceivedBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersReceivedBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersReceivedBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersReceived &&
        G__typename == other.G__typename &&
        blockNumber == other.blockNumber &&
        timestamp == other.timestamp &&
        amount == other.amount &&
        from == other.from &&
        to == other.to &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersReceived')
          ..add('G__typename', G__typename)
          ..add('blockNumber', blockNumber)
          ..add('timestamp', timestamp)
          ..add('amount', amount)
          ..add('from', from)
          ..add('to', to)
          ..add('comment', comment))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersReceivedBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersReceived,
            GGetHistoryAndBalanceData_account_transfersReceivedBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersReceived? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  _i2.GtimestamptzBuilder? _timestamp;
  _i2.GtimestamptzBuilder get timestamp =>
      _$this._timestamp ??= new _i2.GtimestamptzBuilder();
  set timestamp(_i2.GtimestamptzBuilder? timestamp) =>
      _$this._timestamp = timestamp;

  _i2.GnumericBuilder? _amount;
  _i2.GnumericBuilder get amount =>
      _$this._amount ??= new _i2.GnumericBuilder();
  set amount(_i2.GnumericBuilder? amount) => _$this._amount = amount;

  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder? _from;
  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder get from =>
      _$this._from ??=
          new GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder();
  set from(
          GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder?
              from) =>
      _$this._from = from;

  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder? _to;
  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder get to =>
      _$this._to ??=
          new GGetHistoryAndBalanceData_account_transfersReceived_toBuilder();
  set to(GGetHistoryAndBalanceData_account_transfersReceived_toBuilder? to) =>
      _$this._to = to;

  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder? _comment;
  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
      get comment => _$this._comment ??=
          new GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder();
  set comment(
          GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder?
              comment) =>
      _$this._comment = comment;

  GGetHistoryAndBalanceData_account_transfersReceivedBuilder() {
    GGetHistoryAndBalanceData_account_transfersReceived._initializeBuilder(
        this);
  }

  GGetHistoryAndBalanceData_account_transfersReceivedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _blockNumber = $v.blockNumber;
      _timestamp = $v.timestamp.toBuilder();
      _amount = $v.amount.toBuilder();
      _from = $v.from?.toBuilder();
      _to = $v.to?.toBuilder();
      _comment = $v.comment?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersReceived other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersReceived;
  }

  @override
  void update(
      void Function(GGetHistoryAndBalanceData_account_transfersReceivedBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersReceived _build() {
    _$GGetHistoryAndBalanceData_account_transfersReceived _$result;
    try {
      _$result = _$v ??
          new _$GGetHistoryAndBalanceData_account_transfersReceived._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GGetHistoryAndBalanceData_account_transfersReceived',
                  'G__typename'),
              blockNumber: BuiltValueNullFieldError.checkNotNull(
                  blockNumber,
                  r'GGetHistoryAndBalanceData_account_transfersReceived',
                  'blockNumber'),
              timestamp: timestamp.build(),
              amount: amount.build(),
              from: _from?.build(),
              to: _to?.build(),
              comment: _comment?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'timestamp';
        timestamp.build();
        _$failedField = 'amount';
        amount.build();
        _$failedField = 'from';
        _from?.build();
        _$failedField = 'to';
        _to?.build();
        _$failedField = 'comment';
        _comment?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetHistoryAndBalanceData_account_transfersReceived',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_from
    extends GGetHistoryAndBalanceData_account_transfersReceived_from {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GGetHistoryAndBalanceData_account_transfersReceived_from(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_from._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetHistoryAndBalanceData_account_transfersReceived_from',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetHistoryAndBalanceData_account_transfersReceived_from', 'id');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_from rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersReceived_from &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersReceived_from')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersReceived_from,
            GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersReceived_from? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder() {
    GGetHistoryAndBalanceData_account_transfersReceived_from._initializeBuilder(
        this);
  }

  GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersReceived_from other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersReceived_from;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_fromBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_from build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_from _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersReceived_from._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersReceived_from',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GGetHistoryAndBalanceData_account_transfersReceived_from',
                'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_to
    extends GGetHistoryAndBalanceData_account_transfersReceived_to {
  @override
  final String G__typename;
  @override
  final String id;

  factory _$GGetHistoryAndBalanceData_account_transfersReceived_to(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersReceived_toBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_to._(
      {required this.G__typename, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetHistoryAndBalanceData_account_transfersReceived_to',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetHistoryAndBalanceData_account_transfersReceived_to', 'id');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_to rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder toBuilder() =>
      new GGetHistoryAndBalanceData_account_transfersReceived_toBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetHistoryAndBalanceData_account_transfersReceived_to &&
        G__typename == other.G__typename &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersReceived_to')
          ..add('G__typename', G__typename)
          ..add('id', id))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersReceived_toBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersReceived_to,
            GGetHistoryAndBalanceData_account_transfersReceived_toBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersReceived_to? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder() {
    GGetHistoryAndBalanceData_account_transfersReceived_to._initializeBuilder(
        this);
  }

  GGetHistoryAndBalanceData_account_transfersReceived_toBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetHistoryAndBalanceData_account_transfersReceived_to other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetHistoryAndBalanceData_account_transfersReceived_to;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_toBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_to build() => _build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_to _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersReceived_to._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersReceived_to',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id,
                r'GGetHistoryAndBalanceData_account_transfersReceived_to',
                'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetHistoryAndBalanceData_account_transfersReceived_comment
    extends GGetHistoryAndBalanceData_account_transfersReceived_comment {
  @override
  final String G__typename;
  @override
  final String remark;

  factory _$GGetHistoryAndBalanceData_account_transfersReceived_comment(
          [void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder)?
              updates]) =>
      (new GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder()
            ..update(updates))
          ._build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_comment._(
      {required this.G__typename, required this.remark})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GGetHistoryAndBalanceData_account_transfersReceived_comment',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        remark,
        r'GGetHistoryAndBalanceData_account_transfersReceived_comment',
        'remark');
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_comment rebuild(
          void Function(
                  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
      toBuilder() =>
          new GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetHistoryAndBalanceData_account_transfersReceived_comment &&
        G__typename == other.G__typename &&
        remark == other.remark;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, remark.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetHistoryAndBalanceData_account_transfersReceived_comment')
          ..add('G__typename', G__typename)
          ..add('remark', remark))
        .toString();
  }
}

class GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
    implements
        Builder<GGetHistoryAndBalanceData_account_transfersReceived_comment,
            GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder> {
  _$GGetHistoryAndBalanceData_account_transfersReceived_comment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _remark;
  String? get remark => _$this._remark;
  set remark(String? remark) => _$this._remark = remark;

  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder() {
    GGetHistoryAndBalanceData_account_transfersReceived_comment
        ._initializeBuilder(this);
  }

  GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _remark = $v.remark;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GGetHistoryAndBalanceData_account_transfersReceived_comment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v =
        other as _$GGetHistoryAndBalanceData_account_transfersReceived_comment;
  }

  @override
  void update(
      void Function(
              GGetHistoryAndBalanceData_account_transfersReceived_commentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetHistoryAndBalanceData_account_transfersReceived_comment build() =>
      _build();

  _$GGetHistoryAndBalanceData_account_transfersReceived_comment _build() {
    final _$result = _$v ??
        new _$GGetHistoryAndBalanceData_account_transfersReceived_comment._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GGetHistoryAndBalanceData_account_transfersReceived_comment',
                'G__typename'),
            remark: BuiltValueNullFieldError.checkNotNull(
                remark,
                r'GGetHistoryAndBalanceData_account_transfersReceived_comment',
                'remark'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
