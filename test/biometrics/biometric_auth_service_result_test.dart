import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/ui/biometrics/biometric_auth_service.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

import '../local_auth_mock.dart';

void main() {
  test('authenticateDetailed maps lockedOut status', () async {
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous = registerMockLocalAuth(
      authenticateError: PlatformException(code: auth_error.lockedOut),
    );

    final BiometricAuthService service = BiometricAuthService();
    final BiometricAuthResult result = await service.authenticateDetailed(
      localizedReason: 'test',
    );

    expect(result.status, BiometricAuthStatus.lockedOut);
    LocalAuthPlatform.instance = previous;
  });
}
