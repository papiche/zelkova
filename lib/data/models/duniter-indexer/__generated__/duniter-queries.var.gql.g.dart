// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-queries.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAccountsByNameOrPkVars> _$gAccountsByNameOrPkVarsSerializer =
    new _$GAccountsByNameOrPkVarsSerializer();
Serializer<GAccountByPkVars> _$gAccountByPkVarsSerializer =
    new _$GAccountByPkVarsSerializer();
Serializer<GLastBlockVars> _$gLastBlockVarsSerializer =
    new _$GLastBlockVarsSerializer();

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
      }
    }

    return result.build();
  }
}

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

class _$GAccountsByNameOrPkVars extends GAccountsByNameOrPkVars {
  @override
  final String? pattern;

  factory _$GAccountsByNameOrPkVars(
          [void Function(GAccountsByNameOrPkVarsBuilder)? updates]) =>
      (new GAccountsByNameOrPkVarsBuilder()..update(updates))._build();

  _$GAccountsByNameOrPkVars._({this.pattern}) : super._();

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
    final _$result = _$v ?? new _$GAccountsByNameOrPkVars._(pattern: pattern);
    replace(_$result);
    return _$result;
  }
}

class _$GAccountByPkVars extends GAccountByPkVars {
  @override
  final String id;

  factory _$GAccountByPkVars(
          [void Function(GAccountByPkVarsBuilder)? updates]) =>
      (new GAccountByPkVarsBuilder()..update(updates))._build();

  _$GAccountByPkVars._({required this.id}) : super._() {
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
    return other is GAccountByPkVars && id == other.id;
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
    return (newBuiltValueToStringHelper(r'GAccountByPkVars')..add('id', id))
        .toString();
  }
}

class GAccountByPkVarsBuilder
    implements Builder<GAccountByPkVars, GAccountByPkVarsBuilder> {
  _$GAccountByPkVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GAccountByPkVarsBuilder();

  GAccountByPkVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
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
                id, r'GAccountByPkVars', 'id'));
    replace(_$result);
    return _$result;
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
