import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'utxo.g.dart';

@JsonSerializable()
@CopyWith()
class Utxo extends Equatable {
  const Utxo(
      {required this.txHash,
      required this.amount,
      required this.base,
      required this.outputIndex,
      required this.writtenTime,
      required this.writtenBlock});

  factory Utxo.fromJson(Map<String, dynamic> json) => _$UtxoFromJson(json);

  Map<String, dynamic> toJson() => _$UtxoToJson(this);

  final String txHash;
  final double amount;
  final int base;
  final int outputIndex;
  final double writtenTime;
  final double writtenBlock;

  @override
  List<Object?> get props =>
      <dynamic>[txHash, amount, base, outputIndex, writtenTime, writtenBlock];
}
