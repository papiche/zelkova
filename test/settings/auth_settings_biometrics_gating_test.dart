import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ginkgo/ui/widgets/pages/authentication_settings_page.dart';

import '../secure_storage_mock.dart';

void main() {
  testWidgets('Biometrics switch disabled without unlock method',
      (WidgetTester tester) async {
    registerMockSecureStorage();

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const <Locale>[Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MaterialApp(
          home: AuthenticationSettingsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final Finder switchTileFinder = find.byType(SwitchListTile);
    expect(switchTileFinder, findsOneWidget);

    final SwitchListTile tile = tester.widget<SwitchListTile>(switchTileFinder);
    expect(tile.onChanged, isNull);
    expect(find.text('You need to set a pattern or password first'),
        findsOneWidget);
  });
}
