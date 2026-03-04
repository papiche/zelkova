import 'dart:js_interop';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/web.dart' as web;
import 'package:web_browser_detect/web_browser_detect.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import '../../data/models/stored_account.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/first_screen/card_text_style.dart';
import '../widgets/first_screen/contact_search_page.dart';
import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/first_tutorial.dart';
import '../widgets/first_screen/pay_contact_search_button.dart';
import '../widgets/first_screen/pay_form.dart';
import '../widgets/first_screen/pay_qr_button.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Tutorial tutorial;
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  bool _braveWarningShown = false;

  @override
  void initState() {
    tutorial = FirstTutorial(
        context, context.read<AppCubit>().wasTutorialShown('first_screen'));
    super.initState();
    // Show tutorial only in release mode (not in development)
    if (kReleaseMode &&
        context.read<BottomNavCubit>().state == 0 &&
        !context.read<AppCubit>().isWalletCreatedViewed) {
      tutorial.showTutorial();
      context.read<AppCubit>().walletCreatedViewed();
    }

    _scrollController.addListener(() {
      // Detect when the AppBar is collapsed
      final bool isCollapsed = _scrollController.hasClients &&
          _scrollController.offset > (240 - kToolbarHeight - 50);
      if (_isCollapsed != isCollapsed) {
        setState(() {
          _isCollapsed = isCollapsed;
        });
      }
    });

    // Show Brave warning on init if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBraveWarningIfNeeded();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showBraveWarningIfNeeded() async {
    if (!mounted) {
      return;
    }

    if (kIsWeb && !_braveWarningShown) {
      final AppCubit appCubit = context.read<AppCubit>();

      // Show Brave warning dialog (only once per session)
      if (!appCubit.isWarningBraveViewed && _isBraveBrowser()) {
        _braveWarningShown = true;

        if (!mounted) {
          return;
        }

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) => AlertDialog(
            title: Row(
              children: <Widget>[
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 32),
                const SizedBox(width: 10),
                Expanded(child: Text(tr('brave_warning_title'))),
              ],
            ),
            content: SingleChildScrollView(
              child: Text(tr('brave_warning_desc')),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.read<AppCubit>().warningBraveViewed();
                  Navigator.of(dialogContext).pop();
                },
                child: Text(tr('brave_warning_understand')),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AppCubit>().warningBraveViewed();
                  Navigator.of(dialogContext).pop();
                  // Navigate to export section (Info screen - index 4)
                  context.read<BottomNavCubit>().getFifthScreen();
                },
                child: Text(tr('brave_warning_export_now')),
              ),
            ],
          ),
        );
      }
    }
  }

  /// Detects if the browser is Brave using multiple methods
  bool _isBraveBrowser() {
    if (!kIsWeb) {
      return false;
    }

    // Method 1: Try using web_browser_detect package
    try {
      final Browser? browser = Browser.detectOrNull();
      if (browser != null && browser.browserAgent == BrowserAgent.brave) {
        return true;
      }
    } catch (e) {
      // Ignore errors from web_browser_detect
    }

    // Method 2: Check user agent string for Brave indicators
    try {
      final String userAgent =
          (web.window.navigator.userAgent as JSString).toDart;

      // Brave explicitly identifies itself in user agent
      if (userAgent.contains('Brave')) {
        return true;
      }

      // Check for brave-specific patterns (case-insensitive)
      if (userAgent.toLowerCase().contains('brave')) {
        return true;
      }
    } catch (e) {
      // Ignore errors
    }

    // Method 3: Check for navigator.brave API (if available)
    // This is the most reliable method as Brave browser exposes navigator.brave
    try {
      // Try to access navigator.brave property dynamically
      final dynamic navigator = web.window.navigator;
      final dynamic braveProp = (navigator as JSObject)['brave'];
      if (braveProp != null && braveProp != false) {
        return true;
      }
    } catch (e) {
      // Ignore errors
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AppCubit, AppState>(
          builder: (BuildContext context, AppState appState) {
        final PaymentStatus paymentStatus =
            context.read<PaymentCubit>().state.status;
        if (paymentStatus == PaymentStatus.sending ||
            paymentStatus == PaymentStatus.isSent) {
          context.read<PaymentCubit>().reset();
        }
        return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
            SharedPreferencesHelper prefsHelper, Widget? child) {
          return BlocBuilder<PaymentCubit, PaymentState>(
              builder: (BuildContext context, PaymentState state) =>
                  Stack(children: <Widget>[
                    Scaffold(
                      drawer: const CardDrawer(),
                      body: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          // Check if screen width is considered large (e.g., tablet or desktop)
                          final bool isLargeScreen =
                              ResponsiveBreakpoints.of(context)
                                  .largerThan(TABLET);

                          final StoredAccount account =
                              prefsHelper.getCurrentAccount();
                          final String publicKey = account.type.isV2
                              ? account.address
                              : account.pubKey;

                          // Calculate expandedHeight based on card aspect ratio
                          // Card aspect ratio is 1.58, so height = width / 1.58
                          // Add padding (top: 80, bottom: 16) = 96
                          final double cardWidth = constraints.maxWidth -
                              32; // minus horizontal padding
                          final double cardHeight = cardWidth / 1.58;
                          final double expandedHeight =
                              isLargeScreen ? 0 : (cardHeight + 96);

                          return CustomScrollView(
                            controller: _scrollController,
                            slivers: <Widget>[
                              SliverAppBar(
                                title: _isCollapsed
                                    ? Container()
                                    : Text(tr('credit_card_title')),
                                expandedHeight: expandedHeight,
                                // floating: false,
                                pinned: true,
                                backgroundColor:
                                    _isCollapsed ? Colors.transparent : null,
                                leading: context
                                        .watch<AppCubit>()
                                        .hasRecentExport
                                    ? null
                                    : Builder(
                                        builder: (BuildContext context) =>
                                            IconButton(
                                                icon: Badge(
                                                  backgroundColor: Colors.red,
                                                  label: const Text('!',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  child: Icon(Icons.menu,
                                                      color: _isCollapsed
                                                          ? Colors.white
                                                          : null),
                                                ),
                                                onPressed: () {
                                                  Scaffold.of(context)
                                                      .openDrawer();
                                                })),
                                actions: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.info_outline,
                                        color:
                                            _isCollapsed ? Colors.white : null),
                                    onPressed: () {
                                      tutorial.showTutorial(showAlways: true);
                                    },
                                  ),
                                ],
                                flexibleSpace: Container(
                                  decoration: _isCollapsed
                                      ? BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: <Color>[
                                              prefsHelper
                                                  .getTheme()
                                                  .primaryColor,
                                              prefsHelper
                                                  .getTheme()
                                                  .secondaryColor
                                            ],
                                          ),
                                        )
                                      : null,
                                  child: FlexibleSpaceBar(
                                    title: Text(
                                      _isCollapsed
                                          ? simplifyPubKey(
                                              extractPublicKey(publicKey))
                                          : '',
                                      style: cardTextStyle(context),
                                    ),
                                    background: isLargeScreen
                                        ? null
                                        : Container(
                                            padding: const EdgeInsets.only(
                                              top: 80,
                                              left: 16,
                                              right: 16,
                                              bottom: 16,
                                            ),
                                            child: CreditCard(
                                              key: creditCardKey,
                                              account: prefsHelper
                                                  .getCurrentAccount(),
                                              isV2Mode: context
                                                  .read<AppCubit>()
                                                  .state
                                                  .v2mode,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                sliver: SliverList(
                                  delegate: SliverChildListDelegate(
                                    <Widget>[
                                      if (isLargeScreen) ...<Widget>[
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: CreditCard(
                                                key: creditCardKey,
                                                account: prefsHelper
                                                    .getCurrentAccount(),
                                                isV2Mode: context
                                                    .read<AppCubit>()
                                                    .state
                                                    .v2mode,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(children: <Widget>[
                                                    Flexible(
                                                      child:
                                                          PayContactSearchButton(
                                                        key: paySearchUserKey,
                                                        searchUse:
                                                            SearchUse.payment,
                                                        btnText: tr(
                                                            'search_user_btn'),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const PayQrButton(),
                                                  ]),
                                                  const SizedBox(height: 10),
                                                  const PayForm(),
                                                  const BottomWidget(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ] else ...<Widget>[
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: .4),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(children: <Widget>[
                                          Flexible(
                                              child: PayContactSearchButton(
                                                  key: paySearchUserKey,
                                                  searchUse: SearchUse.payment,
                                                  btnText:
                                                      tr('search_user_btn'))),
                                          const SizedBox(width: 10),
                                          const PayQrButton()
                                        ]),
                                        const SizedBox(height: 10),
                                        const PayForm(),
                                        const BottomWidget(),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (state.status == PaymentStatus.sending)
                      Container(
                        color: Colors.black.withValues(alpha: 0.5),
                        child: Center(
                          child: !context.read<AppCubit>().isV2
                              ? const CircularProgressIndicator()
                              :
                              // Nothing
                              const SizedBox.shrink(),
                        ),
                      ),
                  ]));
        });
      });
}
