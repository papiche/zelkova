import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import '../../storage_keys.dart';
import '../logger.dart';

class BiometricAuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricSupported() async {
    if (kIsWeb) {
      return false;
    }
    if (Platform.isLinux) {
      return false;
    }
    try {
      final bool isSupported = await _auth.isDeviceSupported();
      if (!isSupported) {
        return false;
      }
      final List<BiometricType> available =
          await _auth.getAvailableBiometrics();
      return available.isNotEmpty;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        return false;
      }
      loggerDev('Biometric support check error', error: e);
      return false;
    } catch (e) {
      loggerDev('Biometric support check error', error: e);
      return false;
    }
  }

  Future<bool> isBiometricEnabled() async {
    if (!await isBiometricSupported()) {
      return false;
    }
    final String? value =
        await _storage.read(key: StorageKeys.biometricEnabledKey);
    return value == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: StorageKeys.biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  Future<BiometricAuthResult> authenticateDetailed(
      {String? localizedReason}) async {
    try {
      final String reason = localizedReason ?? tr('biometric_auth_reason');
      final bool didAuth = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          // useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return BiometricAuthResult(
        status: didAuth
            ? BiometricAuthStatus.success
            : BiometricAuthStatus.notAuthenticated,
      );
    } on PlatformException catch (e) {
      return BiometricAuthResult(
        status: _mapPlatformCodeToStatus(e.code),
        platformCode: e.code,
        error: e,
      );
    } catch (e) {
      loggerDev('Biometric authentication error', error: e);
      return BiometricAuthResult(
        status: BiometricAuthStatus.otherError,
        error: e,
      );
    }
  }

  Future<bool> authenticate({String? localizedReason}) async {
    final BiometricAuthResult result =
        await authenticateDetailed(localizedReason: localizedReason);
    return result.status == BiometricAuthStatus.success;
  }

  BiometricAuthStatus _mapPlatformCodeToStatus(String code) {
    switch (code) {
      case auth_error.notAvailable:
        return BiometricAuthStatus.notAvailable;
      case auth_error.notEnrolled:
        return BiometricAuthStatus.notEnrolled;
      case auth_error.lockedOut:
        return BiometricAuthStatus.lockedOut;
      case auth_error.permanentlyLockedOut:
        return BiometricAuthStatus.permanentlyLockedOut;
      case auth_error.passcodeNotSet:
        return BiometricAuthStatus.passcodeNotSet;
      default:
        return BiometricAuthStatus.otherError;
    }
  }
}

enum BiometricAuthStatus {
  success,
  notAuthenticated,
  notAvailable,
  notEnrolled,
  lockedOut,
  permanentlyLockedOut,
  passcodeNotSet,
  otherError,
}

class BiometricAuthResult {
  const BiometricAuthResult({
    required this.status,
    this.platformCode,
    this.error,
  });

  final BiometricAuthStatus status;
  final String? platformCode;
  final Object? error;
}
