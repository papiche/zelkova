import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../g1/api.dart';
import 'node.dart';
import 'utxo.dart';
import 'utxo_state.dart';

class UtxoCubit extends HydratedCubit<UtxoState> {
  UtxoCubit() : super(UtxoInitial());

  @override
  String get storagePrefix => kIsWeb ? 'UtxoCubit' : super.storagePrefix;

  @override
  UtxoState? fromJson(Map<String, dynamic> json) {
    return UtxoLoaded.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UtxoState state) {
    return state is UtxoLoaded ? state.toJson() : <String, dynamic>{};
  }

  Future<void> fetchUtxos(String myPubKey) async {
    emit(UtxosLoading());
    try {
      bool hasMore = true;
      while (hasMore) {
        // For now I get all the utxos (lets improve this in the future, only getting the amount needed)
        final Tuple2<Map<String, dynamic>?, Node> utxoDataResult =
            await gvaFetchUtxosOfScript(
                pubKeyRaw: myPubKey,
                cursor:
                    state is UtxoLoaded ? (state as UtxoLoaded).cursor : null);
        if (utxoDataResult.item1 != null) {
          final List<Utxo> utxos = <Utxo>[];
          double total = state is UtxoLoaded ? (state as UtxoLoaded).total : 0;
          for (final dynamic utxoRaw
              in utxoDataResult.item1!['utxos'] as List<dynamic>) {
            final Utxo utxo = Utxo.fromJson(utxoRaw as Map<String, dynamic>);
            total += utxo.amount;
            utxos.add(utxo);
          }
          hasMore = utxoDataResult.item1!['hasNextPage'] as bool;
          final UtxoState newState = UtxoLoaded(
              utxos: utxos,
              total: total,
              hasNextPage: utxoDataResult.item1!['hasNextPage'] as bool,
              cursor: utxoDataResult.item1!['endCursor'] as String?);
          emit(newState);
        }
      }
    } catch (e) {
      emit(UtxosError(e.toString()));
    }
  }

  List<Utxo>? consume(double amount) {
    final List<Utxo> selectedUtxos = <Utxo>[];
    double coveredAmount = 0;
    final Map<String, Utxo> updatedConsumedUtxos = <String, Utxo>{};

    if (state is UtxoLoaded) {
      final UtxoLoaded currentState = state as UtxoLoaded;

      for (final Utxo utxo in currentState.utxos) {
        if (coveredAmount >= amount) {
          break;
        }

        double availableAmount = utxo.amount;
        if (currentState.consumedUtxos.containsKey(utxo.txHash)) {
          availableAmount = currentState.consumedUtxos[utxo.txHash]!.amount;
          if (availableAmount == 0) {
            // It's totally consumed, so skip it (but keep the record)
            updatedConsumedUtxos[utxo.txHash] = utxo;
            continue;
          }
        }

        final double consumeAmount =
            (amount - coveredAmount).clamp(0, availableAmount);
        coveredAmount += consumeAmount;

        // Update consumed UTXOs
        final Utxo updatedUtxo =
            currentState.consumedUtxos.containsKey(utxo.txHash)
                ? currentState.consumedUtxos[utxo.txHash]!
                    .copyWith(amount: availableAmount - consumeAmount)
                : utxo.copyWith(amount: utxo.amount - consumeAmount);
        updatedConsumedUtxos[utxo.txHash] = updatedUtxo;

        if (consumeAmount > 0)
          selectedUtxos.add(utxo.copyWith(amount: consumeAmount));
      }

      if (coveredAmount < amount) {
        emit(UtxosError('Insufficient UTXOs to cover the requested amount'));
        return null;
      }

      // Emit a new state
      emit(currentState.copyWith(
        consumedUtxos: updatedConsumedUtxos,
        // Update other fields if necessary
      ));
      return selectedUtxos;
    } else {
      emit(UtxosError('Wrong utxo state'));
      return null;
    }
  }
}
