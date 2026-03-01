import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

import 'package:ginkgo/ui/biometrics/biometric_auth_service.dart';

import '../local_auth_mock.dart';

void main() {
  test('isBiometricSupported returns false when notEnrolled', () async {
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous = registerMockLocalAuth(
      authenticateError: PlatformException(code: auth_error.notEnrolled),
    );

    final BiometricAuthService service = BiometricAuthService();
    final bool supported = await service.isBiometricSupported();

    expect(supported, isFalse);
    LocalAuthPlatform.instance = previous;
  });
}
