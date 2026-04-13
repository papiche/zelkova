import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:zelkova/data/models/app_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Helpers para tests de Patrol
///
/// Proporciona utilidades para:
/// - Resetear el estado de la intro
/// - Preparar el ambiente de prueba
/// - Limpiar estado después de pruebas

// ignore_for_file: avoid_classes_with_only_static_members

class PatrolTestHelpers {
  /// Resetea el estado del AppCubit para simular un primer arranque
  /// (intro no visto)
  static Future<void> resetIntroState() async {
    try {
      // Limpiar el storage de HydratedBloc
      await HydratedBloc.storage.clear();

      // Resetear o recrear el AppCubit
      final GetIt getIt = GetIt.instance;
      if (getIt.isRegistered<AppCubit>()) {
        getIt.unregister<AppCubit>();
      }

      // Crear una nueva instancia con estado limpio
      final AppCubit appCubit = AppCubit();
      getIt.registerSingleton<AppCubit>(appCubit);

      debugPrint('✓ Intro state resetted');
    } catch (e) {
      debugPrint('✗ Error resetting intro state: $e');
      rethrow;
    }
  }

  /// Marca el intro como visto en el AppCubit
  /// Útil para pruebas que necesitan saltarse el intro
  static Future<void> markIntroAsViewed() async {
    try {
      final GetIt getIt = GetIt.instance;
      if (getIt.isRegistered<AppCubit>()) {
        final AppCubit appCubit = getIt.get<AppCubit>();
        appCubit.introViewed();
        debugPrint('✓ Intro marked as viewed');
      } else {
        throw Exception('AppCubit not registered in GetIt');
      }
    } catch (e) {
      debugPrint('✗ Error marking intro as viewed: $e');
      rethrow;
    }
  }

  /// Obtiene el estado actual del intro desde AppCubit
  static bool getIntroViewedState() {
    try {
      final GetIt getIt = GetIt.instance;
      if (getIt.isRegistered<AppCubit>()) {
        final AppCubit appCubit = getIt.get<AppCubit>();
        return appCubit.isIntroViewed;
      }
      return false;
    } catch (e) {
      debugPrint('✗ Error getting intro state: $e');
      return false;
    }
  }

  /// Limpia el estado después de cada test
  /// Llamar en tearDown de los tests
  static Future<void> cleanupAfterTest() async {
    try {
      await HydratedBloc.storage.clear();
      debugPrint('✓ Test cleanup completed');
    } catch (e) {
      debugPrint('✗ Error during cleanup: $e');
    }
  }
}
