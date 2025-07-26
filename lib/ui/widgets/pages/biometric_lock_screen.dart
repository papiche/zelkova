import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../biometrics/biometric_auth_service.dart';

class BiometricLockScreen extends StatefulWidget {
  const BiometricLockScreen({
    super.key,
    required this.onUnlock,
  });

  final VoidCallback onUnlock;

  @override
  State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}

class _BiometricLockScreenState extends State<BiometricLockScreen> {
  final BiometricAuthService authService = BiometricAuthService();

  @override
  void initState() {
    super.initState();
    _startAuth(); // inicia autenticación al construir
  }

  Future<void> _startAuth() async {
    final bool result = await authService.authenticate();
    if (!mounted) {
      return;
    }

    if (result) {
      BiometricLockState().unlocked = true;
      widget.onUnlock();
    } else {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/logo.png',
                fit: BoxFit.scaleDown,
                height: 100.0,
              ),
              const SizedBox(height: 24),
              Icon(Icons.lock,
                  size: 60,
                  color: isDarkMode ? Colors.white70 : Colors.blueGrey),
              const SizedBox(height: 32),
              Text(
                tr('app_lock_title'),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                tr('app_lock_subtitle'),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(),
              // opcional para mostrar que está esperando
            ],
          ),
        ),
      ),
    );
  }
}

class BiometricLockState {
  factory BiometricLockState() => _instance;

  BiometricLockState._internal();

  static final BiometricLockState _instance = BiometricLockState._internal();

  bool unlocked = false;

  bool get isUnlocked => unlocked;

  void reset() => unlocked = false;
}

Future<bool> showBiometricLockScreen({bool force = false}) async {
  final BiometricLockState lockState = BiometricLockState();

  if (!force && lockState.isUnlocked) {
    return true;
  }

  final BiometricAuthService authService = BiometricAuthService();
  final bool supported = await authService.isBiometricSupported();
  final bool enabled = await authService.isBiometricEnabled();

  if (!supported || !enabled) {
    return false;
  }

  final NavigatorState? navigator = GinkgoApp.navigatorKey.currentState;
  if (navigator == null) {
    return false;
  }

  final bool result = await navigator.push<bool>(
        MaterialPageRoute<bool>(
          builder: (_) => BiometricLockScreen(
            onUnlock: () => navigator.pop(true),
          ),
          fullscreenDialog: true,
        ),
      ) ??
      false;

  lockState.unlocked = result;
  return result;
}
