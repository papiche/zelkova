// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-datapod-queries.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetProfileByAddressVars> _$gGetProfileByAddressVarsSerializer =
    new _$GGetProfileByAddressVarsSerializer();
Serializer<GGetProfileCountVars> _$gGetProfileCountVarsSerializer =
    new _$GGetProfileCountVarsSerializer();

class _$GGetProfileByAddressVarsSerializer
    implements StructuredSerializer<GGetProfileByAddressVars> {
  @override
  final Iterable<Type> types = const [
    GGetProfileByAddressVars,
    _$GGetProfileByAddressVars
  ];
  @override
  final String wireName = 'GGetProfileByAddressVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileByAddressVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pubkey',
      serializers.serialize(object.pubkey,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetProfileByAddressVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfileByAddressVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pubkey':
          result.pubkey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetProfileCountVarsSerializer
    implements StructuredSerializer<GGetProfileCountVars> {
  @override
  final Iterable<Type> types = const [
    GGetProfileCountVars,
    _$GGetProfileCountVars
  ];
  @override
  final String wireName = 'GGetProfileCountVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfileCountVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetProfileCountVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetProfileCountVarsBuilder().build();
  }
}

class _$GGetProfileByAddressVars extends GGetProfileByAddressVars {
  @override
  final String pubkey;

  factory _$GGetProfileByAddressVars(
          [void Function(GGetProfileByAddressVarsBuilder)? updates]) =>
      (new GGetProfileByAddressVarsBuilder()..update(updates))._build();

  _$GGetProfileByAddressVars._({required this.pubkey}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        pubkey, r'GGetProfileByAddressVars', 'pubkey');
  }

  @override
  GGetProfileByAddressVars rebuild(
          void Function(GGetProfileByAddressVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileByAddressVarsBuilder toBuilder() =>
      new GGetProfileByAddressVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileByAddressVars && pubkey == other.pubkey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pubkey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetProfileByAddressVars')
          ..add('pubkey', pubkey))
        .toString();
  }
}

class GGetProfileByAddressVarsBuilder
    implements
        Builder<GGetProfileByAddressVars, GGetProfileByAddressVarsBuilder> {
  _$GGetProfileByAddressVars? _$v;

  String? _pubkey;
  String? get pubkey => _$this._pubkey;
  set pubkey(String? pubkey) => _$this._pubkey = pubkey;

  GGetProfileByAddressVarsBuilder();

  GGetProfileByAddressVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pubkey = $v.pubkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfileByAddressVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileByAddressVars;
  }

  @override
  void update(void Function(GGetProfileByAddressVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileByAddressVars build() => _build();

  _$GGetProfileByAddressVars _build() {
    final _$result = _$v ??
        new _$GGetProfileByAddressVars._(
            pubkey: BuiltValueNullFieldError.checkNotNull(
                pubkey, r'GGetProfileByAddressVars', 'pubkey'));
    replace(_$result);
    return _$result;
  }
}

class _$GGetProfileCountVars extends GGetProfileCountVars {
  factory _$GGetProfileCountVars(
          [void Function(GGetProfileCountVarsBuilder)? updates]) =>
      (new GGetProfileCountVarsBuilder()..update(updates))._build();

  _$GGetProfileCountVars._() : super._();

  @override
  GGetProfileCountVars rebuild(
          void Function(GGetProfileCountVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfileCountVarsBuilder toBuilder() =>
      new GGetProfileCountVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfileCountVars;
  }

  @override
  int get hashCode {
    return 701190907;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetProfileCountVars').toString();
  }
}

class GGetProfileCountVarsBuilder
    implements Builder<GGetProfileCountVars, GGetProfileCountVarsBuilder> {
  _$GGetProfileCountVars? _$v;

  GGetProfileCountVarsBuilder();

  @override
  void replace(GGetProfileCountVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfileCountVars;
  }

  @override
  void update(void Function(GGetProfileCountVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfileCountVars build() => _build();

  _$GGetProfileCountVars _build() {
    final _$result = _$v ?? new _$GGetProfileCountVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
