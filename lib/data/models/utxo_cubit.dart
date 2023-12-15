import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../g1/api.dart';
import '../../ui/logger.dart';
import 'node.dart';
import 'utxo.dart';
import 'utxo_state.dart';

class UtxoCubit extends HydratedCubit<UtxoState> {
  UtxoCubit() : super(UtxoInitial());

  @override
  String get storagePrefix => kIsWeb ? 'UtxoCubit' : super.storagePrefix;

  @override
  UtxoState? fromJson(Map<String, dynamic> json) {
    try {
      return UtxoLoaded.fromJson(json);
    } catch (e) {
      return UtxoInitial();
    }
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
        loggerDev('utxoDataResult: $utxoDataResult');

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
    if (state is UtxoLoaded) {
      final UtxoLoaded currentState = state as UtxoLoaded;

      final List<Utxo> selectedUtxos = <Utxo>[];
      double total = 0.0;

      final List<Utxo> sortedUtxos = List<Utxo>.from(currentState.utxos)
        ..sort((Utxo a, Utxo b) => b.amount.compareTo(a.amount));

      for (final Utxo utxo in sortedUtxos) {
        if (total >= amount) {
          break;
        }
        selectedUtxos.add(utxo);
        total += utxo.amount;
      }

      if (total < amount) {
        const String error = 'Insufficient UTXOs to cover the requested amount';
        emit(UtxosError(error));
        throw Exception(error);
      }

      final List<Utxo> updatedUtxos = currentState.utxos
          .where((Utxo utxo) => !selectedUtxos.contains(utxo))
          .toList();

      emit(currentState.copyWith(utxos: updatedUtxos));
      return selectedUtxos;
    } else {
      const String error = 'Wrong utxo state';
      emit(UtxosError(error));
      throw Exception(error);
    }
  }

  void resetConsumedUtxos() {
    if (state is UtxoLoaded) {
      emit((state as UtxoLoaded).copyWith(consumedUtxos: <String, Utxo>{}));
    } else {
      emit(UtxosError('Wrong utxo state'));
    }
  }

  void addUtxos(List<Utxo> newUtxos) {
    if (state is UtxoLoaded) {
      final UtxoLoaded currentState = state as UtxoLoaded;
      final List<Utxo> updatedUtxos = List<Utxo>.from(currentState.utxos)
        ..addAll(newUtxos);
      emit(currentState.copyWith(utxos: updatedUtxos));
    } else {
      emit(UtxosError('Wrong utxo state'));
    }
  }
}
