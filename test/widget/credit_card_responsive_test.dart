import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/data/models/stored_account.dart';
import 'package:ginkgo/data/models/wallet_themes.dart';
import 'package:ginkgo/ui/widgets/first_screen/credit_card.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  // Valid public key in Base58 format to avoid Base58Exception
  const String validPubKey = '5EJJaVomWJkcVvXKVHwYe5FNaEbyMVB5FZKqPHt8xm9h';
  const String validAddress =
      'g1Kh4xMpBNcU61ruXtL48RLGPiqrQ24Et4basXFDqKkH9kuAn';

  final StoredAccount testAccount = StoredAccount(
    pubKey: validPubKey,
    address: validAddress,
    contact: Contact(
      pubKey: validPubKey,
      name: 'Test Wallet',
    ),
    theme: WalletThemes.theme3,
    type: AccountType.v1PasswordLess,
  );

  // Helper function to build the widget tree WITHOUT EasyLocalization
  // This avoids the issue of EasyLocalization failing to load assets between tests
  Widget buildTestWidget(StoredAccount account) {
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
        home: Scaffold(
          body: CreditCard(account: account),
        ),
      ),
    );
  }

  testWidgets('CreditCard renders correctly on mobile portrait (360x800)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.reset());

    await tester.pumpWidget(buildTestWidget(testAccount));
    await tester.pumpAndSettle();

    final Finder cardFinder = find.byType(Card);
    expect(cardFinder, findsOneWidget);

    final RenderBox cardBox = tester.renderObject(cardFinder);
    final double width = cardBox.size.width;
    final double height = cardBox.size.height;
    final double ratio = width / height;

    debugPrint(
        '📐 Mobile (360x800): Card ${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)}, Ratio: ${ratio.toStringAsFixed(2)}');

    expect(ratio, closeTo(1.58, 0.01),
        reason: 'Card should have 1.58 aspect ratio on mobile, got $ratio');
  });

  testWidgets('CreditCard maintains aspect ratio on tablet (768x1024)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.reset());

    await tester.pumpWidget(buildTestWidget(testAccount));
    await tester.pumpAndSettle();

    final Finder cardFinder = find.byType(Card);
    expect(cardFinder, findsOneWidget,
        reason: 'Should find one Card widget on tablet');

    final RenderBox cardBox = tester.renderObject(cardFinder);
    final double width = cardBox.size.width;
    final double height = cardBox.size.height;
    final double ratio = width / height;

    debugPrint(
        '📐 Tablet (768x1024): Card ${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)}, Ratio: ${ratio.toStringAsFixed(2)}');

    expect(ratio, closeTo(1.58, 0.01),
        reason: 'Card should have 1.58 aspect ratio on tablet, got $ratio');
  });

  testWidgets('CreditCard maintains aspect ratio on desktop (1920x1080)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.reset());

    // On desktop, the card is typically in a constrained container
    // (e.g., in a row with other widgets). Simulate this by wrapping in a SizedBox
    await tester.pumpWidget(
      ResponsiveBreakpoints.builder(
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
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 800,
                // Constrain width on desktop to simulate real layout
                child: CreditCard(account: testAccount),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Finder cardFinder = find.byType(Card);
    expect(cardFinder, findsOneWidget,
        reason: 'Should find one Card widget on desktop');

    final RenderBox cardBox = tester.renderObject(cardFinder);
    final double width = cardBox.size.width;
    final double height = cardBox.size.height;
    final double ratio = width / height;

    debugPrint(
        '📐 Desktop (1920x1080): Card ${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)}, Ratio: ${ratio.toStringAsFixed(2)}');

    expect(ratio, closeTo(1.58, 0.01),
        reason: 'Card should have 1.58 aspect ratio on desktop, got $ratio');
  });
}
