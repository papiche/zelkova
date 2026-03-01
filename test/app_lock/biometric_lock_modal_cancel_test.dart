import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';

import 'package:ginkgo/ui/widgets/pages/biometric_lock_screen.dart';
import 'package:ginkgo/main.dart';

import '../local_auth_mock.dart';

void main() {
  testWidgets('Modal lock screen allows cancel', (WidgetTester tester) async {
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous =
        registerMockLocalAuth(authenticateResult: false);

    bool? result;
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const <Locale>[Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MaterialApp(
          navigatorKey: GinkgoApp.navigatorKey,
          home: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showBiometricLockScreen(force: true);
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('CANCEL'), findsOneWidget);
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();

    expect(result, isFalse);
    LocalAuthPlatform.instance = previous;
  });
}
