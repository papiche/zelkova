// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duniter-datapod-queries.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetProfileByAddressVars> _$gGetProfileByAddressVarsSerializer =
    new _$GGetProfileByAddressVarsSerializer();
Serializer<GGetProfilesByAddressVars> _$gGetProfilesByAddressVarsSerializer =
    new _$GGetProfilesByAddressVarsSerializer();
Serializer<GGetProfileCountVars> _$gGetProfileCountVarsSerializer =
    new _$GGetProfileCountVarsSerializer();
Serializer<GSearchProfileByTermVars> _$gSearchProfileByTermVarsSerializer =
    new _$GSearchProfileByTermVarsSerializer();
Serializer<GSearchProfilesVars> _$gSearchProfilesVarsSerializer =
    new _$GSearchProfilesVarsSerializer();

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

class _$GGetProfilesByAddressVarsSerializer
    implements StructuredSerializer<GGetProfilesByAddressVars> {
  @override
  final Iterable<Type> types = const [
    GGetProfilesByAddressVars,
    _$GGetProfilesByAddressVars
  ];
  @override
  final String wireName = 'GGetProfilesByAddressVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetProfilesByAddressVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pubkeys',
      serializers.serialize(object.pubkeys,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GGetProfilesByAddressVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetProfilesByAddressVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pubkeys':
          result.pubkeys.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$GSearchProfileByTermVarsSerializer
    implements StructuredSerializer<GSearchProfileByTermVars> {
  @override
  final Iterable<Type> types = const [
    GSearchProfileByTermVars,
    _$GSearchProfileByTermVars
  ];
  @override
  final String wireName = 'GSearchProfileByTermVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfileByTermVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pattern',
      serializers.serialize(object.pattern,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchProfileByTermVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfileByTermVarsBuilder();

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

class _$GSearchProfilesVarsSerializer
    implements StructuredSerializer<GSearchProfilesVars> {
  @override
  final Iterable<Type> types = const [
    GSearchProfilesVars,
    _$GSearchProfilesVars
  ];
  @override
  final String wireName = 'GSearchProfilesVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchProfilesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'searchTermLower',
      serializers.serialize(object.searchTermLower,
          specifiedType: const FullType(String)),
      'searchTerm',
      serializers.serialize(object.searchTerm,
          specifiedType: const FullType(String)),
      'searchTermCapitalized',
      serializers.serialize(object.searchTermCapitalized,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchProfilesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchProfilesVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'searchTermLower':
          result.searchTermLower = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'searchTerm':
          result.searchTerm = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'searchTermCapitalized':
          result.searchTermCapitalized = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
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

class _$GGetProfilesByAddressVars extends GGetProfilesByAddressVars {
  @override
  final BuiltList<String> pubkeys;

  factory _$GGetProfilesByAddressVars(
          [void Function(GGetProfilesByAddressVarsBuilder)? updates]) =>
      (new GGetProfilesByAddressVarsBuilder()..update(updates))._build();

  _$GGetProfilesByAddressVars._({required this.pubkeys}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        pubkeys, r'GGetProfilesByAddressVars', 'pubkeys');
  }

  @override
  GGetProfilesByAddressVars rebuild(
          void Function(GGetProfilesByAddressVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetProfilesByAddressVarsBuilder toBuilder() =>
      new GGetProfilesByAddressVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetProfilesByAddressVars && pubkeys == other.pubkeys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pubkeys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetProfilesByAddressVars')
          ..add('pubkeys', pubkeys))
        .toString();
  }
}

class GGetProfilesByAddressVarsBuilder
    implements
        Builder<GGetProfilesByAddressVars, GGetProfilesByAddressVarsBuilder> {
  _$GGetProfilesByAddressVars? _$v;

  ListBuilder<String>? _pubkeys;
  ListBuilder<String> get pubkeys =>
      _$this._pubkeys ??= new ListBuilder<String>();
  set pubkeys(ListBuilder<String>? pubkeys) => _$this._pubkeys = pubkeys;

  GGetProfilesByAddressVarsBuilder();

  GGetProfilesByAddressVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pubkeys = $v.pubkeys.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetProfilesByAddressVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetProfilesByAddressVars;
  }

  @override
  void update(void Function(GGetProfilesByAddressVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetProfilesByAddressVars build() => _build();

  _$GGetProfilesByAddressVars _build() {
    _$GGetProfilesByAddressVars _$result;
    try {
      _$result =
          _$v ?? new _$GGetProfilesByAddressVars._(pubkeys: pubkeys.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pubkeys';
        pubkeys.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetProfilesByAddressVars', _$failedField, e.toString());
      }
      rethrow;
    }
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

class _$GSearchProfileByTermVars extends GSearchProfileByTermVars {
  @override
  final String pattern;

  factory _$GSearchProfileByTermVars(
          [void Function(GSearchProfileByTermVarsBuilder)? updates]) =>
      (new GSearchProfileByTermVarsBuilder()..update(updates))._build();

  _$GSearchProfileByTermVars._({required this.pattern}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        pattern, r'GSearchProfileByTermVars', 'pattern');
  }

  @override
  GSearchProfileByTermVars rebuild(
          void Function(GSearchProfileByTermVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfileByTermVarsBuilder toBuilder() =>
      new GSearchProfileByTermVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfileByTermVars && pattern == other.pattern;
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
    return (newBuiltValueToStringHelper(r'GSearchProfileByTermVars')
          ..add('pattern', pattern))
        .toString();
  }
}

class GSearchProfileByTermVarsBuilder
    implements
        Builder<GSearchProfileByTermVars, GSearchProfileByTermVarsBuilder> {
  _$GSearchProfileByTermVars? _$v;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  GSearchProfileByTermVarsBuilder();

  GSearchProfileByTermVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pattern = $v.pattern;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchProfileByTermVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfileByTermVars;
  }

  @override
  void update(void Function(GSearchProfileByTermVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfileByTermVars build() => _build();

  _$GSearchProfileByTermVars _build() {
    final _$result = _$v ??
        new _$GSearchProfileByTermVars._(
            pattern: BuiltValueNullFieldError.checkNotNull(
                pattern, r'GSearchProfileByTermVars', 'pattern'));
    replace(_$result);
    return _$result;
  }
}

class _$GSearchProfilesVars extends GSearchProfilesVars {
  @override
  final String searchTermLower;
  @override
  final String searchTerm;
  @override
  final String searchTermCapitalized;

  factory _$GSearchProfilesVars(
          [void Function(GSearchProfilesVarsBuilder)? updates]) =>
      (new GSearchProfilesVarsBuilder()..update(updates))._build();

  _$GSearchProfilesVars._(
      {required this.searchTermLower,
      required this.searchTerm,
      required this.searchTermCapitalized})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        searchTermLower, r'GSearchProfilesVars', 'searchTermLower');
    BuiltValueNullFieldError.checkNotNull(
        searchTerm, r'GSearchProfilesVars', 'searchTerm');
    BuiltValueNullFieldError.checkNotNull(
        searchTermCapitalized, r'GSearchProfilesVars', 'searchTermCapitalized');
  }

  @override
  GSearchProfilesVars rebuild(
          void Function(GSearchProfilesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchProfilesVarsBuilder toBuilder() =>
      new GSearchProfilesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchProfilesVars &&
        searchTermLower == other.searchTermLower &&
        searchTerm == other.searchTerm &&
        searchTermCapitalized == other.searchTermCapitalized;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, searchTermLower.hashCode);
    _$hash = $jc(_$hash, searchTerm.hashCode);
    _$hash = $jc(_$hash, searchTermCapitalized.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchProfilesVars')
          ..add('searchTermLower', searchTermLower)
          ..add('searchTerm', searchTerm)
          ..add('searchTermCapitalized', searchTermCapitalized))
        .toString();
  }
}

class GSearchProfilesVarsBuilder
    implements Builder<GSearchProfilesVars, GSearchProfilesVarsBuilder> {
  _$GSearchProfilesVars? _$v;

  String? _searchTermLower;
  String? get searchTermLower => _$this._searchTermLower;
  set searchTermLower(String? searchTermLower) =>
      _$this._searchTermLower = searchTermLower;

  String? _searchTerm;
  String? get searchTerm => _$this._searchTerm;
  set searchTerm(String? searchTerm) => _$this._searchTerm = searchTerm;

  String? _searchTermCapitalized;
  String? get searchTermCapitalized => _$this._searchTermCapitalized;
  set searchTermCapitalized(String? searchTermCapitalized) =>
      _$this._searchTermCapitalized = searchTermCapitalized;

  GSearchProfilesVarsBuilder();

  GSearchProfilesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _searchTermLower = $v.searchTermLower;
      _searchTerm = $v.searchTerm;
      _searchTermCapitalized = $v.searchTermCapitalized;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchProfilesVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchProfilesVars;
  }

  @override
  void update(void Function(GSearchProfilesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchProfilesVars build() => _build();

  _$GSearchProfilesVars _build() {
    final _$result = _$v ??
        new _$GSearchProfilesVars._(
            searchTermLower: BuiltValueNullFieldError.checkNotNull(
                searchTermLower, r'GSearchProfilesVars', 'searchTermLower'),
            searchTerm: BuiltValueNullFieldError.checkNotNull(
                searchTerm, r'GSearchProfilesVars', 'searchTerm'),
            searchTermCapitalized: BuiltValueNullFieldError.checkNotNull(
                searchTermCapitalized,
                r'GSearchProfilesVars',
                'searchTermCapitalized'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
