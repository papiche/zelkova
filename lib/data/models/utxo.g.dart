// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utxo.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UtxoCWProxy {
  Utxo txHash(String txHash);

  Utxo amount(double amount);

  Utxo base(int base);

  Utxo outputIndex(int outputIndex);

  Utxo writtenTime(double writtenTime);

  Utxo writtenBlock(double writtenBlock);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Utxo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Utxo(...).copyWith(id: 12, name: "My name")
  /// ````
  Utxo call({
    String? txHash,
    double? amount,
    int? base,
    int? outputIndex,
    double? writtenTime,
    double? writtenBlock,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUtxo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUtxo.copyWith.fieldName(...)`
class _$UtxoCWProxyImpl implements _$UtxoCWProxy {
  const _$UtxoCWProxyImpl(this._value);

  final Utxo _value;

  @override
  Utxo txHash(String txHash) => this(txHash: txHash);

  @override
  Utxo amount(double amount) => this(amount: amount);

  @override
  Utxo base(int base) => this(base: base);

  @override
  Utxo outputIndex(int outputIndex) => this(outputIndex: outputIndex);

  @override
  Utxo writtenTime(double writtenTime) => this(writtenTime: writtenTime);

  @override
  Utxo writtenBlock(double writtenBlock) => this(writtenBlock: writtenBlock);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Utxo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Utxo(...).copyWith(id: 12, name: "My name")
  /// ````
  Utxo call({
    Object? txHash = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? base = const $CopyWithPlaceholder(),
    Object? outputIndex = const $CopyWithPlaceholder(),
    Object? writtenTime = const $CopyWithPlaceholder(),
    Object? writtenBlock = const $CopyWithPlaceholder(),
  }) {
    return Utxo(
      txHash: txHash == const $CopyWithPlaceholder() || txHash == null
          ? _value.txHash
          // ignore: cast_nullable_to_non_nullable
          : txHash as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as double,
      base: base == const $CopyWithPlaceholder() || base == null
          ? _value.base
          // ignore: cast_nullable_to_non_nullable
          : base as int,
      outputIndex:
          outputIndex == const $CopyWithPlaceholder() || outputIndex == null
              ? _value.outputIndex
              // ignore: cast_nullable_to_non_nullable
              : outputIndex as int,
      writtenTime:
          writtenTime == const $CopyWithPlaceholder() || writtenTime == null
              ? _value.writtenTime
              // ignore: cast_nullable_to_non_nullable
              : writtenTime as double,
      writtenBlock:
          writtenBlock == const $CopyWithPlaceholder() || writtenBlock == null
              ? _value.writtenBlock
              // ignore: cast_nullable_to_non_nullable
              : writtenBlock as double,
    );
  }
}

extension $UtxoCopyWith on Utxo {
  /// Returns a callable class that can be used as follows: `instanceOfUtxo.copyWith(...)` or like so:`instanceOfUtxo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UtxoCWProxy get copyWith => _$UtxoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Utxo _$UtxoFromJson(Map<String, dynamic> json) => Utxo(
      txHash: json['txHash'] as String,
      amount: (json['amount'] as num).toDouble(),
      base: json['base'] as int,
      outputIndex: json['outputIndex'] as int,
      writtenTime: (json['writtenTime'] as num).toDouble(),
      writtenBlock: (json['writtenBlock'] as num).toDouble(),
    );

Map<String, dynamic> _$UtxoToJson(Utxo instance) => <String, dynamic>{
      'txHash': instance.txHash,
      'amount': instance.amount,
      'base': instance.base,
      'outputIndex': instance.outputIndex,
      'writtenTime': instance.writtenTime,
      'writtenBlock': instance.writtenBlock,
    };
