import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'utxo.dart';

part 'utxo_state.g.dart';

abstract class UtxoState {}

class UtxoInitial extends UtxoState {}

class UtxosLoading extends UtxoState {}

class UtxosError extends UtxoState {
  UtxosError(this.message);

  final String message;
}

@JsonSerializable()
@CopyWith()
class UtxoLoaded extends UtxoState with EquatableMixin {
  UtxoLoaded(
      {required this.utxos,
      Map<String, Utxo>? consumedUtxos,
      required this.hasNextPage,
      required this.cursor,
      this.total = 0.0})
      : consumedUtxos = consumedUtxos ?? <String, Utxo>{};

  factory UtxoLoaded.fromJson(Map<String, dynamic> json) =>
      _$UtxoLoadedFromJson(json);

  final List<Utxo> utxos;
  final Map<String, Utxo> consumedUtxos;
  final double total;
  final bool hasNextPage;
  final String? cursor;

  Map<String, dynamic> toJson() => _$UtxoLoadedToJson(this);

  @override
  List<Object?> get props =>
      <Object?>[utxos, consumedUtxos, hasNextPage, cursor, total];
}
