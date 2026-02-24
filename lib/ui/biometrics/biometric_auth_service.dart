import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
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

  Future<bool> authenticate({String? localizedReason}) async {
    try {
      final String reason = localizedReason ?? tr('biometric_auth_reason');
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (e) {
      loggerDev('Biometric authentication error', error: e);
      return false;
    }
  }
}
