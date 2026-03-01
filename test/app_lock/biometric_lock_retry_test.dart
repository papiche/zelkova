import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ginkgo/ui/widgets/pages/biometric_lock_screen.dart';

import '../local_auth_mock.dart';
import '../secure_storage_mock.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    registerMockSecureStorage();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('Retry triggers auth and unlocks', (WidgetTester tester) async {
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous =
        registerMockLocalAuth(authenticateResult: false);

    int unlockCount = 0;
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const <Locale>[Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MaterialApp(
          home: BiometricLockScreen(onUnlock: () => unlockCount++),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(
        find.byKey(const Key('biometric_lock_retry_button')), findsOneWidget);

    setLocalAuthInstance(
      FakeLocalAuthPlatform(authenticateResult: true),
    );

    await tester.tap(find.byKey(const Key('biometric_lock_retry_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(unlockCount, 1);
    LocalAuthPlatform.instance = previous;
  });
}
