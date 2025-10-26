import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/data/models/wallet_themes.dart';
import 'package:ginkgo/ui/widgets/first_screen/credit_card.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CreditCard aspect ratio test', (WidgetTester tester) async {
    const String validPubKey = '5EJJaVomWJkcVvXKVHwYe5FNaEbyMVB5FZKqPHt8xm9h';
    const String validAddress =
        'g1Kh4xMpBNcU61ruXtL48RLGPiqrQ24Et4basXFDqKkH9kuAn';

    final StoredAccount testAccount = StoredAccount(
      pubKey: validPubKey,
      address: validAddress,
      contact: Contact(pubKey: validPubKey, name: 'Test'),
      theme: WalletThemes.theme3,
      type: AccountType.v1PasswordLess,
    );

    // Test in a simple Scaffold
    await tester.pumpWidget(
      EasyLocalization(
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
                  body: CreditCard(account: testAccount),
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    final RenderBox cardBox = tester.renderObject(find.byType(Card));
    final double width = cardBox.size.width;
    final double height = cardBox.size.height;
    final double actualRatio = width / height;

    debugPrint('══════════════════════════════════════════════');
    debugPrint('TEST 1: Simple Scaffold');
    debugPrint(
        'Rendered: ${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)}');
    debugPrint('Actual ratio: ${actualRatio.toStringAsFixed(3)}');
    debugPrint('Expected ratio: 1.580');
    debugPrint(
        'Match: ${(actualRatio - 1.58).abs() < 0.01 ? "✓ PASS" : "✗ FAIL"}');
    debugPrint('══════════════════════════════════════════════');

    expect(actualRatio, closeTo(1.58, 0.01),
        reason: 'Card should have 1.58 aspect ratio, got $actualRatio');
  });
}
