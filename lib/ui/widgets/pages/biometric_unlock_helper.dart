import '../../biometrics/biometric_auth_service.dart';

mixin BiometricUnlockHelper {
  static final BiometricAuthService _authService = BiometricAuthService();
  static bool _isUnlocked = false;

  static Future<bool> requestUnlock({bool force = false}) async {
    if (!force && _isUnlocked) {
      return true;
    }

    final bool isSupported = await _authService.isBiometricSupported();
    final bool isEnabled = await _authService.isBiometricEnabled();

    if (!isSupported || !isEnabled) {
      return false;
    }

    final bool authenticated = await _authService.authenticate();
    _isUnlocked = authenticated;
    return authenticated;
  }

  static void reset() {
    _isUnlocked = false;
  }
}
