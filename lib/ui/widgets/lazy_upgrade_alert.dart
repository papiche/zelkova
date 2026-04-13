import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../../ui/in_dev_helper.dart';
import '../../ui/logger.dart';
import 'upgrader_localization.dart';

/// LazyUpgradeAlert - Lazy and safe Upgrader initialization
///
/// This widget encapsulates the initialization of `UpgradeAlert` to ensure that:
/// 1. The Upgrader is not instantiated until it is really needed
/// 2. It only works on supported platforms (native Android/iOS)
/// 3. It is cleaned up correctly in development mode
///
/// **Supported platforms:**
/// - ✅ Native Android (Play Store scraping)
/// - ✅ Native iOS (App Store integration)
/// - ❌ Web (not needed, updates automatically)
/// - ❌ Desktop (Linux/macOS/Windows - no distribution mechanism)
///
/// **Problem it solves:**
/// The original `UpgradeAlert` could block global events or cause interference
/// with widgets under construction. By using lazy loading, we ensure that it only
/// initializes when the user has already passed the intro. Additionally, we avoid showing
/// the upgrader on platforms where it is not applicable.
///
/// **Usage:**
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
        messages: ZelkovaUpgraderMessages(),
      );

      // In development, clear settings to avoid corrupted states
      // this forces re-evaluation of the upgrader state
      if (inDevelopment) {
        await Upgrader.clearSavedSettings();
        logger('Upgrader: Settings cleared (development mode)');
      }

      // Log useful information
      if (inDevelopment) {
        final String platformName = kIsWeb
            ? 'Web'
            : Platform.isAndroid
                ? 'Android'
                : Platform.isIOS
                    ? 'iOS'
                    : Platform.isLinux
                        ? 'Linux'
                        : Platform.isMacOS
                            ? 'macOS'
                            : Platform.isWindows
                                ? 'Windows'
                                : 'Unknown';
        logger('Upgrader: Initialized successfully on $platformName');
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
    // If not yet initialized, show only the child widget
    if (!_isInitialized) {
      return widget.child;
    }

    // Detectar si estamos en plataforma que soporta upgrader
    final bool isSupportedPlatform =
        !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    // Solo mostrar UpgradeAlert en Android/iOS nativos
    if (!isSupportedPlatform) {
      if (inDevelopment) {
        final String platformName = kIsWeb
            ? 'Web'
            : Platform.isLinux
                ? 'Linux'
                : Platform.isMacOS
                    ? 'macOS'
                    : Platform.isWindows
                        ? 'Windows'
                        : 'Unknown';
        logger(
            'Upgrader: Disabled on $platformName (not a supported platform)');
      }
      return widget.child;
    }

    // Una vez inicializado y en plataforma soportada, envolver con UpgradeAlert
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
