// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-custom-queries.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAccountsByPkVars> _$gAccountsByPkVarsSerializer =
    new _$GAccountsByPkVarsSerializer();
Serializer<GSearchIdentityVars> _$gSearchIdentityVarsSerializer =
    new _$GSearchIdentityVarsSerializer();
Serializer<GLastIndexedBlockNumberVars>
    _$gLastIndexedBlockNumberVarsSerializer =
    new _$GLastIndexedBlockNumberVarsSerializer();
Serializer<GAccountsByNameOrPkVars> _$gAccountsByNameOrPkVarsSerializer =
    new _$GAccountsByNameOrPkVarsSerializer();

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
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
    ];

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
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchIdentityVarsSerializer
    implements StructuredSerializer<GSearchIdentityVars> {
  @override
  final Iterable<Type> types = const [
    GSearchIdentityVars,
    _$GSearchIdentityVars
  ];
  @override
  final String wireName = 'GSearchIdentityVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchIdentityVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchIdentityVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchIdentityVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GLastIndexedBlockNumberVarsSerializer
    implements StructuredSerializer<GLastIndexedBlockNumberVars> {
  @override
  final Iterable<Type> types = const [
    GLastIndexedBlockNumberVars,
    _$GLastIndexedBlockNumberVars
  ];
  @override
  final String wireName = 'GLastIndexedBlockNumberVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLastIndexedBlockNumberVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GLastIndexedBlockNumberVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GLastIndexedBlockNumberVarsBuilder().build();
  }
}

class _$GAccountsByNameOrPkVarsSerializer
    implements StructuredSerializer<GAccountsByNameOrPkVars> {
  @override
  final Iterable<Type> types = const [
    GAccountsByNameOrPkVars,
    _$GAccountsByNameOrPkVars
  ];
  @override
  final String wireName = 'GAccountsByNameOrPkVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAccountsByNameOrPkVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pattern',
      serializers.serialize(object.pattern,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAccountsByNameOrPkVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAccountsByNameOrPkVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pattern':
          result.pattern = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAccountsByPkVars extends GAccountsByPkVars {
  @override
  final String address;

  factory _$GAccountsByPkVars(
          [void Function(GAccountsByPkVarsBuilder)? updates]) =>
      (new GAccountsByPkVarsBuilder()..update(updates))._build();

  _$GAccountsByPkVars._({required this.address}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        address, r'GAccountsByPkVars', 'address');
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
    return other is GAccountsByPkVars && address == other.address;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAccountsByPkVars')
          ..add('address', address))
        .toString();
  }
}

class GAccountsByPkVarsBuilder
    implements Builder<GAccountsByPkVars, GAccountsByPkVarsBuilder> {
  _$GAccountsByPkVars? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  GAccountsByPkVarsBuilder();

  GAccountsByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
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
    final _$result = _$v ??
        new _$GAccountsByPkVars._(
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'GAccountsByPkVars', 'address'));
    replace(_$result);
    return _$result;
  }
}

class _$GSearchIdentityVars extends GSearchIdentityVars {
  @override
  final String name;

  factory _$GSearchIdentityVars(
          [void Function(GSearchIdentityVarsBuilder)? updates]) =>
      (new GSearchIdentityVarsBuilder()..update(updates))._build();

  _$GSearchIdentityVars._({required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'GSearchIdentityVars', 'name');
  }

  @override
  GSearchIdentityVars rebuild(
          void Function(GSearchIdentityVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchIdentityVarsBuilder toBuilder() =>
      new GSearchIdentityVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchIdentityVars && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchIdentityVars')
          ..add('name', name))
        .toString();
  }
}

class GSearchIdentityVarsBuilder
    implements Builder<GSearchIdentityVars, GSearchIdentityVarsBuilder> {
  _$GSearchIdentityVars? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GSearchIdentityVarsBuilder();

  GSearchIdentityVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchIdentityVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchIdentityVars;
  }

  @override
  void update(void Function(GSearchIdentityVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchIdentityVars build() => _build();

  _$GSearchIdentityVars _build() {
    final _$result = _$v ??
        new _$GSearchIdentityVars._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GSearchIdentityVars', 'name'));
    replace(_$result);
    return _$result;
  }
}

class _$GLastIndexedBlockNumberVars extends GLastIndexedBlockNumberVars {
  factory _$GLastIndexedBlockNumberVars(
          [void Function(GLastIndexedBlockNumberVarsBuilder)? updates]) =>
      (new GLastIndexedBlockNumberVarsBuilder()..update(updates))._build();

  _$GLastIndexedBlockNumberVars._() : super._();

  @override
  GLastIndexedBlockNumberVars rebuild(
          void Function(GLastIndexedBlockNumberVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLastIndexedBlockNumberVarsBuilder toBuilder() =>
      new GLastIndexedBlockNumberVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLastIndexedBlockNumberVars;
  }

  @override
  int get hashCode {
    return 499942498;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GLastIndexedBlockNumberVars')
        .toString();
  }
}

class GLastIndexedBlockNumberVarsBuilder
    implements
        Builder<GLastIndexedBlockNumberVars,
            GLastIndexedBlockNumberVarsBuilder> {
  _$GLastIndexedBlockNumberVars? _$v;

  GLastIndexedBlockNumberVarsBuilder();

  @override
  void replace(GLastIndexedBlockNumberVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLastIndexedBlockNumberVars;
  }

  @override
  void update(void Function(GLastIndexedBlockNumberVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLastIndexedBlockNumberVars build() => _build();

  _$GLastIndexedBlockNumberVars _build() {
    final _$result = _$v ?? new _$GLastIndexedBlockNumberVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GAccountsByNameOrPkVars extends GAccountsByNameOrPkVars {
  @override
  final String pattern;

  factory _$GAccountsByNameOrPkVars(
          [void Function(GAccountsByNameOrPkVarsBuilder)? updates]) =>
      (new GAccountsByNameOrPkVarsBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkVars._({required this.pattern}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        pattern, r'GAccountsByNameOrPkVars', 'pattern');
  }

  @override
  GAccountsByNameOrPkVars rebuild(
          void Function(GAccountsByNameOrPkVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAccountsByNameOrPkVarsBuilder toBuilder() =>
      new GAccountsByNameOrPkVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAccountsByNameOrPkVars && pattern == other.pattern;
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
    return (newBuiltValueToStringHelper(r'GAccountsByNameOrPkVars')
          ..add('pattern', pattern))
        .toString();
  }
}

class GAccountsByNameOrPkVarsBuilder
    implements
        Builder<GAccountsByNameOrPkVars, GAccountsByNameOrPkVarsBuilder> {
  _$GAccountsByNameOrPkVars? _$v;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  GAccountsByNameOrPkVarsBuilder();

  GAccountsByNameOrPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pattern = $v.pattern;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAccountsByNameOrPkVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAccountsByNameOrPkVars;
  }

  @override
  void update(void Function(GAccountsByNameOrPkVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAccountsByNameOrPkVars build() => _build();

  _$GAccountsByNameOrPkVars _build() {
    final _$result = _$v ??
        new _$GAccountsByNameOrPkVars._(
            pattern: BuiltValueNullFieldError.checkNotNull(
                pattern, r'GAccountsByNameOrPkVars', 'pattern'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
