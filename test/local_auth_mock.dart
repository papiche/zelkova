import 'package:flutter/services.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

class _TestLocalAuthPlatform extends LocalAuthPlatform {
  _TestLocalAuthPlatform() : super();
}

class FakeLocalAuthPlatform extends LocalAuthPlatform {
  FakeLocalAuthPlatform({
    this.authenticateResult = false,
    this.authenticateError,
    this.deviceSupported = true,
    List<BiometricType>? enrolledBiometrics,
  }) : enrolledBiometrics = <BiometricType>[] {
    this.enrolledBiometrics =
        enrolledBiometrics ?? <BiometricType>[BiometricType.strong];
  }

  bool authenticateResult;
  PlatformException? authenticateError;
  bool deviceSupported;
  List<BiometricType> enrolledBiometrics;

  @override
  Future<bool> authenticate({
    required String localizedReason,
    required Iterable<AuthMessages> authMessages,
    AuthenticationOptions options = const AuthenticationOptions(),
  }) async {
    if (authenticateError != null) {
      throw authenticateError!;
    }
    return authenticateResult;
  }

  @override
  Future<bool> isDeviceSupported() async => deviceSupported;

  @override
  Future<List<BiometricType>> getEnrolledBiometrics() async =>
      enrolledBiometrics;
}

void setLocalAuthInstance(LocalAuthPlatform instance) {
  LocalAuthPlatform.instance = instance;
}

LocalAuthPlatform registerMockLocalAuth({
  bool authenticateResult = false,
  PlatformException? authenticateError,
  bool deviceSupported = true,
  List<BiometricType>? enrolledBiometrics,
}) {
  final LocalAuthPlatform previous = LocalAuthPlatform.instance;
  LocalAuthPlatform.instance = FakeLocalAuthPlatform(
    authenticateResult: authenticateResult,
    authenticateError: authenticateError,
    deviceSupported: deviceSupported,
    enrolledBiometrics: enrolledBiometrics,
  );
  return previous;
}

LocalAuthPlatform registerBaselineLocalAuth() {
  final LocalAuthPlatform previous = LocalAuthPlatform.instance;
  LocalAuthPlatform.instance = _TestLocalAuthPlatform();
  return previous;
}
