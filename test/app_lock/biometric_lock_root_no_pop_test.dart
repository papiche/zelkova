import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/ui/widgets/pages/biometric_lock_screen.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_auth_mock.dart';
import '../secure_storage_mock.dart';

class _TestObserver extends NavigatorObserver {
  int popCount = 0;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    popCount++;
    super.didPop(route, previousRoute);
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
    registerMockSecureStorage();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('Root lock screen does not pop on biometric false',
      (WidgetTester tester) async {
    registerBaselineLocalAuth();
    final LocalAuthPlatform previous = registerMockLocalAuth();
    final _TestObserver observer = _TestObserver();

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const <Locale>[Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MaterialApp(
          navigatorObservers: <NavigatorObserver>[observer],
          home: BiometricLockScreen(onUnlock: () {}),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(observer.popCount, 0);
    expect(find.byType(BiometricLockScreen), findsOneWidget);

    LocalAuthPlatform.instance = previous;
  });
}
