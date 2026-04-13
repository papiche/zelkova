import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:zelkova/ui/secure_unlock_widget.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_auth_mock.dart';
import '../secure_storage_mock.dart';

void main() {
  test('walletV2Auth falls back when biometric returns false', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    registerMockSecureStorage();
    SharedPreferencesHelper.configure(useV2: true);
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    await helper.init(onlyV2: true);
    await helper.createDefWalletIfNotExist();
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous = registerMockLocalAuth();

    final Uint8List fallbackKey = Uint8List.fromList(<int>[1, 2, 3, 4]);
    final bool result = await walletV2Auth(
      requestUnlockOverride: () async => fallbackKey,
    );

    expect(result, isTrue);
    LocalAuthPlatform.instance = previous;
  });
}
