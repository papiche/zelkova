import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

import 'package:ginkgo/ui/secure_unlock_widget.dart';

import '../local_auth_mock.dart';
import '../secure_storage_mock.dart';
import 'package:ginkgo/shared_prefs_helper.dart';

void main() {
  test('walletV2Auth falls back when biometric returns false', () async {
    registerMockSecureStorage();
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    await helper.init(onlyV2: true);
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous =
        registerMockLocalAuth(authenticateResult: false);

    final Uint8List fallbackKey = Uint8List.fromList(<int>[1, 2, 3, 4]);
    final bool result = await walletV2Auth(
      requestUnlockOverride: () async => fallbackKey,
    );

    expect(result, isTrue);
    LocalAuthPlatform.instance = previous;
  });
}
