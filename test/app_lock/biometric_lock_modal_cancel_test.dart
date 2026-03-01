import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ginkgo/ui/widgets/pages/biometric_lock_screen.dart';
import 'package:ginkgo/main.dart';

import '../local_auth_mock.dart';
import '../secure_storage_mock.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    registerMockSecureStorage();
    await EasyLocalization.ensureInitialized();
  });

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
                  result = await Navigator.of(context).push<bool>(
                        MaterialPageRoute<bool>(
                          fullscreenDialog: true,
                          builder: (_) => BiometricLockScreen(
                            onUnlock: () {},
                            allowCancel: true,
                          ),
                        ),
                      ) ??
                      false;
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(
        find.byKey(const Key('biometric_lock_cancel_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('biometric_lock_cancel_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(result, isFalse);
    LocalAuthPlatform.instance = previous;
  });
}
