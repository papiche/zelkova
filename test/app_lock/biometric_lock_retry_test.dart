import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

import 'package:ginkgo/ui/widgets/pages/biometric_lock_screen.dart';

import '../local_auth_mock.dart';

void main() {
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

    await tester.pumpAndSettle();
    expect(find.text('RETRY'), findsOneWidget);

    setLocalAuthInstance(
      FakeLocalAuthPlatform(authenticateResult: true),
    );

    await tester.tap(find.text('RETRY'));
    await tester.pumpAndSettle();

    expect(unlockCount, 1);
    LocalAuthPlatform.instance = previous;
  });
}
