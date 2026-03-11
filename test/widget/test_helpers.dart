import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Helper to wrap widgets with necessary providers for testing CreditCard widget
/// This includes EasyLocalization and ResponsiveBreakpoints which are required
/// by the CreditCard widget and its dependencies.
Widget wrapWithTestProviders(Widget child) {
  return EasyLocalization(
    supportedLocales: const <Locale>[Locale('en')],
    startLocale: const Locale('en'),
    fallbackLocale: const Locale('en'),
    useOnlyLangCode: true,
    useFallbackTranslations: true,
    path: 'assets/translations',
    child: Builder(
      builder: (BuildContext context) {
        return ResponsiveBreakpoints.builder(
          breakpoints: <Breakpoint>[
            const Breakpoint(start: 0, end: 360, name: 'SMALL_MOBILE'),
            const Breakpoint(start: 0, end: 480, name: MOBILE),
            const Breakpoint(start: 481, end: 768, name: TABLET),
            const Breakpoint(start: 769, end: 1200, name: DESKTOP),
            const Breakpoint(
              start: 1201,
              end: double.infinity,
              name: '4K',
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Scaffold(
              body: child,
            ),
          ),
        );
      },
    ),
  );
}
