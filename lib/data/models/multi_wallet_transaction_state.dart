import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'transaction_state.dart';

part 'multi_wallet_transaction_state.g.dart';

@JsonSerializable()
@CopyWith()
class MultiWalletTransactionState extends Equatable {
  const MultiWalletTransactionState(this.map);

  factory MultiWalletTransactionState.fromJson(Map<String, dynamic> json) =>
      _$MultiWalletTransactionStateFromJson(json);

  final Map<String, TransactionState> map;

  Map<String, dynamic> toJson() => _$MultiWalletTransactionStateToJson(this);

  @override
  List<Object?> get props => <dynamic>[map];
}
