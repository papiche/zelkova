// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utxo_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UtxoLoadedCWProxy {
  UtxoLoaded utxos(List<Utxo> utxos);

  UtxoLoaded consumedUtxos(Map<String, Utxo>? consumedUtxos);

  UtxoLoaded hasNextPage(bool hasNextPage);

  UtxoLoaded cursor(String? cursor);

  UtxoLoaded total(double total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UtxoLoaded(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UtxoLoaded(...).copyWith(id: 12, name: "My name")
  /// ````
  UtxoLoaded call({
    List<Utxo>? utxos,
    Map<String, Utxo>? consumedUtxos,
    bool? hasNextPage,
    String? cursor,
    double? total,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUtxoLoaded.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUtxoLoaded.copyWith.fieldName(...)`
class _$UtxoLoadedCWProxyImpl implements _$UtxoLoadedCWProxy {
  const _$UtxoLoadedCWProxyImpl(this._value);

  final UtxoLoaded _value;

  @override
  UtxoLoaded utxos(List<Utxo> utxos) => this(utxos: utxos);

  @override
  UtxoLoaded consumedUtxos(Map<String, Utxo>? consumedUtxos) =>
      this(consumedUtxos: consumedUtxos);

  @override
  UtxoLoaded hasNextPage(bool hasNextPage) => this(hasNextPage: hasNextPage);

  @override
  UtxoLoaded cursor(String? cursor) => this(cursor: cursor);

  @override
  UtxoLoaded total(double total) => this(total: total);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UtxoLoaded(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UtxoLoaded(...).copyWith(id: 12, name: "My name")
  /// ````
  UtxoLoaded call({
    Object? utxos = const $CopyWithPlaceholder(),
    Object? consumedUtxos = const $CopyWithPlaceholder(),
    Object? hasNextPage = const $CopyWithPlaceholder(),
    Object? cursor = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return UtxoLoaded(
      utxos: utxos == const $CopyWithPlaceholder() || utxos == null
          ? _value.utxos
          // ignore: cast_nullable_to_non_nullable
          : utxos as List<Utxo>,
      consumedUtxos: consumedUtxos == const $CopyWithPlaceholder()
          ? _value.consumedUtxos
          // ignore: cast_nullable_to_non_nullable
          : consumedUtxos as Map<String, Utxo>?,
      hasNextPage:
          hasNextPage == const $CopyWithPlaceholder() || hasNextPage == null
              ? _value.hasNextPage
              // ignore: cast_nullable_to_non_nullable
              : hasNextPage as bool,
      cursor: cursor == const $CopyWithPlaceholder()
          ? _value.cursor
          // ignore: cast_nullable_to_non_nullable
          : cursor as String?,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as double,
    );
  }
}

extension $UtxoLoadedCopyWith on UtxoLoaded {
  /// Returns a callable class that can be used as follows: `instanceOfUtxoLoaded.copyWith(...)` or like so:`instanceOfUtxoLoaded.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UtxoLoadedCWProxy get copyWith => _$UtxoLoadedCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtxoLoaded _$UtxoLoadedFromJson(Map<String, dynamic> json) => UtxoLoaded(
      utxos: (json['utxos'] as List<dynamic>)
          .map((e) => Utxo.fromJson(e as Map<String, dynamic>))
          .toList(),
      consumedUtxos: (json['consumedUtxos'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Utxo.fromJson(e as Map<String, dynamic>)),
      ),
      hasNextPage: json['hasNextPage'] as bool,
      cursor: json['cursor'] as String?,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$UtxoLoadedToJson(UtxoLoaded instance) =>
    <String, dynamic>{
      'utxos': instance.utxos,
      'consumedUtxos': instance.consumedUtxos,
      'total': instance.total,
      'hasNextPage': instance.hasNextPage,
      'cursor': instance.cursor,
    };
