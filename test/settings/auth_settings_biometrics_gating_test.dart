import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/shared_prefs_helper.dart';
import 'package:zelkova/ui/biometrics/biometric_auth_service.dart';
import 'package:zelkova/ui/widgets/pages/authentication_settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../secure_storage_mock.dart';
import '../widget/widget_test_helper.dart';

class _FakeBiometricAuthService extends BiometricAuthService {
  @override
  Future<bool> isBiometricSupported() async => true;

  @override
  Future<bool> isBiometricEnabled() async => false;

  @override
  Future<void> setBiometricEnabled(bool enabled) async {}
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    registerMockSecureStorage();
    SharedPreferencesHelper.configure(useV2: false);
    await SharedPreferencesHelper().init();
    SharedPreferencesHelper().accountsClear();
    await initializeEasyLocalization();
  });

  testWidgets('Biometrics switch disabled without unlock method',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestableWidget(
        AuthenticationSettingsPage(
          biometricAuth: _FakeBiometricAuthService(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final Finder switchTileFinder = find.byType(SwitchListTile);
    expect(switchTileFinder, findsOneWidget);

    final SwitchListTile tile = tester.widget<SwitchListTile>(switchTileFinder);
    expect(tile.onChanged, isNull);
    expect(find.byKey(const Key('auth_biometrics_requires_unlock_method')),
        findsOneWidget);
  });
}
