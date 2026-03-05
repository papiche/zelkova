import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../../ui/in_dev_helper.dart';
import '../../ui/logger.dart';
import 'upgrader_localization.dart';

/// LazyUpgradeAlert - Inicialización perezosa y segura del Upgrader
///
/// Este widget encapsula la inicialización del `UpgradeAlert` para asegurar que:
/// 1. El Upgrader no se instancia hasta que sea realmente necesario
/// 2. No interfiere con otros widgets (como el intro screen)
/// 3. Se limpia correctamente en modo desarrollo
///
/// **Problema que soluciona:**
/// El `UpgradeAlert` original podía bloquear eventos globales o causar interferencias
/// con widgets en construcción. Al usar lazy loading, garantizamos que solo se
/// inicializa cuando el usuario ya ha pasado el intro.
///
/// **Uso:**
/// ```dart
/// LazyUpgradeAlert(
///   child: FeedbackAndSkeletonScreen(),
/// )
/// ```
class LazyUpgradeAlert extends StatefulWidget {
  const LazyUpgradeAlert({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<LazyUpgradeAlert> createState() => _LazyUpgradeAlertState();
}

class _LazyUpgradeAlertState extends State<LazyUpgradeAlert> {
  late Upgrader _upgrader;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeUpgrader();
  }

  Future<void> _initializeUpgrader() async {
    try {
      _upgrader = Upgrader(
        debugLogging: true,
        messages: GinkgoUpgraderMessages(),
      );

      // En desarrollo, limpiar settings para evitar estados corruptos
      // esto fuerza re-evaluación del estado del upgrader
      if (inDevelopment) {
        await Upgrader.clearSavedSettings();
      }

      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      logger('Error initializing Upgrader: $e');
      if (mounted) {
        setState(() => _isInitialized = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si aún no se ha inicializado, mostrar solo el widget hijo
    if (!_isInitialized) {
      return widget.child;
    }

    // Una vez inicializado, envolver con UpgradeAlert
    return UpgradeAlert(
      upgrader: _upgrader,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    // No necesitamos limpiar el Upgrader ya que es stateless internamente
    super.dispose();
  }
}
