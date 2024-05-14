import 'dart:async';
import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:cron/cron.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uni_links/uni_links.dart';
import 'package:workmanager/workmanager.dart';

import 'app_bloc_observer.dart';
import 'custom_feedback_localization.dart';
import 'data/eo_timeago_support.dart';
import 'data/eu_timeago_support.dart';
import 'data/gl_timeago_support.dart';
import 'data/models/app_cubit.dart';
import 'data/models/app_state.dart';
import 'data/models/bottom_nav_cubit.dart';
import 'data/models/contact_cubit.dart';
import 'data/models/multi_wallet_transaction_cubit.dart';
import 'data/models/node_list_cubit.dart';
import 'data/models/node_list_state.dart';
import 'data/models/node_manager.dart';
import 'data/models/node_type.dart';
import 'data/models/payment_cubit.dart';
import 'data/models/theme_cubit.dart';
import 'data/models/transaction_cubit_remove.dart';
import 'data/models/utxo_cubit.dart';
import 'env.dart';
import 'g1/api.dart';
import 'g1/g1_helper.dart';
import 'shared_prefs_helper.dart';
import 'ui/contacts_cache.dart';
import 'ui/logger.dart';
import 'ui/notification_controller.dart';
import 'ui/pay_helper.dart';
import 'ui/screens/skeleton_screen.dart';
import 'ui/ui_helpers.dart';
import 'ui/widgets/connectivity_widget_wrapper_wrapper.dart';

const String fetchWalletsTransactionsTask =
    'org.comunes.ginkgo.fetchWalletsTransactionsTask';

void main() async {
  await NotificationController.initializeLocalNotifications();

  // const int seedColorOld = 0xff526600;

  const int seedColor = 0xff98FB98;
  final int seedColorDark = Colors.lightGreen.value;
  final ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(seedColor),
      // brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  final ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(seedColorDark),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  // To resolve Let's Encrypt SSL certificate problems with Android 7.1.1 and below
  if (!kIsWeb && Platform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }

  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final SharedPreferencesHelper shared = SharedPreferencesHelper();
  await shared.init();
  if (shared.cesiumCards.isEmpty) {
    await shared.getWallet();
  }
  assert(shared.getPubKey() != null);

  await hydratedInit();

  PWAInstall().setup(installCallback: () {
    logger('APP INSTALLED!');
  });

  Bloc.observer = AppBlocObserver();

  await ContactsCache().init();
  timeago.setLocaleMessages('eo', EoMessages());
  timeago.setLocaleMessages('eo_short', EoShortMessages());
  timeago.setLocaleMessages('eu', EuMessages());
  timeago.setLocaleMessages('eu_short', EuShortMessages());
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('de_short', timeago.DeShortMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
  timeago.setLocaleMessages('ca', timeago.CaMessages());
  timeago.setLocaleMessages('ca_short', timeago.CaShortMessages());
  timeago.setLocaleMessages('nl', timeago.NlMessages());
  timeago.setLocaleMessages('nl_short', timeago.NlShortMessages());
  timeago.setLocaleMessages('it', timeago.ItMessages());
  timeago.setLocaleMessages('it_short', timeago.ItShortMessages());
  timeago.setLocaleMessages('pt', timeago.PtBrMessages());
  timeago.setLocaleMessages('pt_short', timeago.PtBrShortMessages());
  timeago.setLocaleMessages('gl', GlMessages());
  timeago.setLocaleMessages('gl_short', GlShortMessages());

  void appRunner() => SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]).then((_) {
        runApp(ChangeNotifierProvider<SharedPreferencesHelper>(
            create: (BuildContext context) => SharedPreferencesHelper(),
            child: EasyLocalization(
              path: 'assets/translations',
              supportedLocales: const <Locale>[
                // Asturian is not supported in flutter
                // More info: https://docs.flutter.dev/development/accessibility-and-localization/internationalization#adding-support-for-a-new-language
                // Meantime we use this workaround:
                // https://github.com/aissat/easy_localization/issues/220#issuecomment-846035493
                Locale('es', 'AST'),
                Locale('ca'),
                Locale('de'),
                Locale('en'),
                Locale('eo'),
                Locale('es'),
                Locale('eu'),
                Locale('fr'),
                Locale('gl'),
                Locale('it'),
                Locale('nl'),
                Locale('pt'),
              ],
              fallbackLocale: const Locale('en'),
              useFallbackTranslations: true,
              child: MultiBlocProvider(
                  providers: <BlocProvider<dynamic>>[
                    BlocProvider<BottomNavCubit>(
                        create: (BuildContext context) => BottomNavCubit()),
                    BlocProvider<AppCubit>(
                        create: (BuildContext context) => AppCubit()),
                    BlocProvider<PaymentCubit>(
                        create: (BuildContext context) => PaymentCubit()),
                    BlocProvider<NodeListCubit>(
                        create: (BuildContext context) => NodeListCubit()),
                    BlocProvider<ContactsCubit>(
                        create: (BuildContext context) => ContactsCubit()),
                    BlocProvider<UtxoCubit>(
                        create: (BuildContext context) => UtxoCubit()),
                    // TODO(vjrj): Remove when clean the state of this after upgrades
                    BlocProvider<TransactionCubitRemove>(
                        create: (BuildContext context) =>
                            TransactionCubitRemove()),
                    BlocProvider<MultiWalletTransactionCubit>(
                        create: (BuildContext context) =>
                            MultiWalletTransactionCubit()),
                    BlocProvider<ThemeCubit>(
                        create: (BuildContext context) => ThemeCubit()),
                    // Add other BlocProviders here if needed
                  ],
                  child:
                      GinkgoApp(darkTheme: darkTheme, lightTheme: lightTheme)),
            )));
      });
  if (!kIsWeb && inDevelopment) {
    // Only use sentry in development
    await SentryFlutter.init((
      SentryFlutterOptions options,
    ) {
      options.tracesSampleRate = 1.0;
      options.reportPackages = false;
      // options.addInAppInclude('sentry_flutter_example');
      options.considerInAppFramesByDefault = false;
      // options.attachThreads = true;
      // options.enableWindowMetricBreadcrumbs = true;
      options.addIntegration(LoggingIntegration());
      options.sendDefaultPii = true;
      options.reportSilentFlutterErrors = true;
      // options.attachScreenshot = true;
      // options.screenshotQuality = SentryScreenshotQuality.low;
      // This fails:
      // options.attachViewHierarchy = true;
      // We can enable Sentry debug logging during development. This is likely
      // going to log too much for your app, but can be useful when figuring out
      // configuration issues, e.g. finding out why your events are not uploaded.
      options.debug = false;

      options.maxRequestBodySize = MaxRequestBodySize.always;
      options.maxResponseBodySize = MaxResponseBodySize.always;

      // options.release = version;
      // options.environment = 'production';
      // options.beforeSend = (SentryEvent event, {dynamic hint}) {
      //  return event;
      //};

      options.dsn = Env.sentryDsn;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      // options.tracesSampleRate = 1.0;
    }, appRunner: appRunner);
  } else {
    appRunner();
  }
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void workManagerCallbackDispatcher() {
  Workmanager()
      .executeTask((String task, Map<String, dynamic>? inputData) async {
    try {
      loggerDev(
          '---------- Start fetchTransactionsTask Workmanager background task');
      switch (task) {
        case fetchWalletsTransactionsTask:
          await NotificationController.initializeLocalNotifications();
          fetchTransactionsFromBackground();
          break;
        case Workmanager.iOSBackgroundTask:
          break;
      }
      loggerDev(
          '---------- End fetchTransactionsTask Workmanager background task');
    } catch (err, stacktrace) {
      logger(err.toString());
      await Sentry.captureException(err, stackTrace: stacktrace);
    }
    return Future<bool>.value(true);
  });
}

class AppIntro extends StatefulWidget {
  const AppIntro({super.key});

  @override
  State<AppIntro> createState() => _AppIntro();
}

class _AppIntro extends State<AppIntro> {
  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context, AppCubit cubit) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
          builder: (BuildContext _) => const FeedbackAndSkeletonScreen()),
    );
    cubit.introViewed();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext buildContext, AppState state) {
      final AppCubit cubit = context.read<AppCubit>();
      return IntroductionScreen(
        key: introKey,
        pages: <PageViewModel>[
          for (int i = 1; i <= 5; i++)
            createPageViewModel('intro_${i}_title', 'intro_${i}_description',
                'assets/img/undraw_intro_$i.png', context),
        ],
        onDone: () => _onIntroEnd(buildContext, cubit),
        showSkipButton: true,
        skipOrBackFlex: 0,
        onSkip: () => _onIntroEnd(buildContext, cubit),
        nextFlex: 0,
        skip: Text(tr('skip')),
        next: const Icon(Icons.arrow_forward),
        done: Text(tr('start'),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeColor: Colors.blueAccent,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      );
    });
  }
}

/*
void printCubitStateSize(String cubitName, HydratedCubit cubit) {
  final String jsonState = jsonEncode(cubit.state);
  print('Size of $cubitName in bytes: ${jsonState.length}');
}
*/

PageViewModel createPageViewModel(
    String title, String body, String imageAsset, BuildContext context) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final TextStyle titleStyle = TextStyle(
    color: colorScheme.primary,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );
  final TextStyle bodyStyle = TextStyle(
    color: colorScheme.onSurface,
    fontSize: 18.0,
  );

  return PageViewModel(
    title: tr(title),
    body: tr(body),
    image: Image.asset(imageAsset),
    decoration: PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      pageColor: colorScheme.background,
    ),
  );
}

class GinkgoApp extends StatefulWidget {
  const GinkgoApp(
      {super.key, required this.lightTheme, required this.darkTheme});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final ThemeData darkTheme;
  final ThemeData lightTheme;

  @override
  State<GinkgoApp> createState() => _GinkgoAppState();
}

class _GinkgoAppState extends State<GinkgoApp> {
  late ScheduledTask fetchTxsCronTask;

  Future<void> _loadNodes() async {
    _printNodeStatus();
    for (final NodeType nodeType in NodeType.values) {
      await fetchNodes(nodeType, false);
    }
    _printNodeStatus(prefix: 'Continuing');
  }

  void _printNodeStatus({String prefix = 'Starting'}) {
    final int nDuniterNodes = NodeManager().nodeList(NodeType.duniter).length;
    final int nCesiumPlusNodes =
        NodeManager().nodeList(NodeType.cesiumPlus).length;
    final int nGvaNodes = NodeManager().nodeList(NodeType.gva).length;
    logger(
        '$prefix with $nDuniterNodes duniter nodes, $nCesiumPlusNodes c+ nodes, and $nGvaNodes gva nodes');
    if (!kReleaseMode) {
      logger('${NodeManager().nodeList(NodeType.cesiumPlus)}');
    }
    if (!kReleaseMode) {
      logger('${NodeManager().nodeList(NodeType.gva)}');
    }
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initDeepLinkListener();
    }
    NodeManager().loadFromCubit(context.read<NodeListCubit>());
    // Only after at least the action method is set, the notification events are delivered
    NotificationController.startListeningNotificationEvents();
    // Wipe Old Transactions Cubit
    context.read<TransactionCubitRemove>().clear();
    context.read<TransactionCubitRemove>().close();
    Once.runHourly('load_nodes', callback: () async {
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      if (isConnected) {
        logger('Load nodes via once');
        _loadNodes();
      }
    }, fallback: () {
      _printNodeStatus(prefix: 'After once hourly having');
    });
    Once.runDaily('clear_errors', callback: () {
      logger('clearErrors via once');
      NodeManager().cleanErrorStats();
    });
    Once.runDaily('clear_cache', callback: () {
      logger('clear cache via once');
      ContactsCache().clear();
    });
    Once.runOnce('resize_avatars', callback: () {
      logger('resize avatar via once');
      context.read<ContactsCubit>().resizeAvatars();
    });
    Once.runDaily('clear_tx_cubit', callback: () {
      logger('clear tx cubit via once');
      context.read<MultiWalletTransactionCubit>().clearState();
    });

    initGetItAll();

    ContactsCache().addContacts(context.read<ContactsCubit>().state.contacts);

    fetchTxsCronTask = Cron()
        .schedule(Schedule.parse(kReleaseMode ? '*/10 * * * *' : '*/5 * * * *'),
            () async {
      logger('---------- fetchTransactions via cron');
      // Disabled to check the back development
      // if (!inDevelopment) {
      fetchTransactions(context);
      // }
    });

    if (inDevelopment) {
      // Try to test auto-recover from empty node-list;
      NodeManager().endpointNodes.clear();
      NodeManager().gvaNodes.clear();
      NodeManager().duniterNodes.clear();
    }

    ConnectivityWidgetWrapperWrapper.isConnected.then((bool isConnected) {
      if (isConnected) {
        fetchNodesIfNotReady();
        // Fetch transactions (and balance) here too on start
        fetchTransactions(context);
      }
    });

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      Workmanager().initialize(
          workManagerCallbackDispatcher); // The top level function, aka callbackDispatcher
      /* , isInDebugMode:
              true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
          ); */
      Workmanager().registerPeriodicTask(
        fetchWalletsTransactionsTask,
        fetchWalletsTransactionsTask,
        frequency: const Duration(minutes: 15),
      );
    }

    /*  if (inDevelopment) {
      printCubitStateSize(
          'multiTxCubit', context.read<MultiWalletTransactionCubit>());
      printCubitStateSize('TxCubit', context.read<TransactionCubitRemove>());
      printCubitStateSize('nodeCubit', context.read<NodeListCubit>());
      printCubitStateSize('paymentCubit', context.read<PaymentCubit>());
      printCubitStateSize('AppCubit', context.read<AppCubit>());
      printCubitStateSize('BottomNavCubit', context.read<BottomNavCubit>());
      // printCubitStateSize('ContactsCubit', context.read<ContactsCubit>());
      printCubitStateSize('ThemeCubit', context.read<ThemeCubit>());
      printCubitStateSize('UtxoCubit', context.read<UtxoCubit>());
    } */
  }

  @override
  void dispose() {
    ContactsCache().dispose();
    _disposeDeepLinkListener();
    fetchTxsCronTask.cancel();
    Workmanager().cancelAll();
    super.dispose();
  }

  late StreamSubscription<dynamic>? _sub;

  Future<void> _initDeepLinkListener() async {
    _sub = linkStream.listen((String? link) async {
      if (!mounted) {
        return;
      }
      if (link != null) {
        logger('got link: $link');
        if (parseScannedUri(link) != null) {
          await onKeyScanned(context, link);
          if (!mounted) {
            return;
          } else {
            context.read<BottomNavCubit>().updateIndex(0);
          }
        }
      }
    }, onError: (Object err) {
      if (!mounted) {
        return;
      }
      logger('got err: $err');
    });
  }

  void _disposeDeepLinkListener() {
    if (_sub != null) {
      _sub!.cancel();
      _sub = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      return ConnectivityAppWrapper(
          app: FilesystemPickerDefaultOptions(
              fileTileSelectMode: FileTileSelectMode.wholeTile,
              theme: FilesystemPickerTheme(
                topBar: FilesystemPickerTopBarThemeData(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: MaterialApp(
                /// Localization is not available for the title.
                title: 'Ğ1nkgo',
                theme: widget.lightTheme,
                darkTheme: widget.darkTheme,
                navigatorKey: GinkgoApp.navigatorKey,
                scaffoldMessengerKey: globalMessengerKey,

                /// Theme stuff
                themeMode: context.watch<ThemeCubit>().state.themeMode,

                /// Localization stuff
                localizationsDelegates: context.localizationDelegates
                  ..addAll(<LocalizationsDelegate<dynamic>>[
                    MaterialLocalizationsEo.delegate,
                    CupertinoLocalizationsEo.delegate
                  ]),
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                home: context.read<AppCubit>().isIntroViewed
                    ? const FeedbackAndSkeletonScreen()
                    : const AppIntro(),
                builder: (BuildContext buildContext, Widget? widget) {
                  NotificationController.locale = context.locale;
                  return ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(
                        context,
                        ConnectivityWidgetWrapperWrapper(
                          offlineWidget: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.cloud_off,
                                size: 48,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 6),
                              Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Text(
                                    tr('offline'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                    ),
                                  )),
                              const SizedBox(height: 110),
                            ],
                          ),
                          child: widget!,
                        )),
                    maxWidth: 480,
                    minWidth: 480,
                    // defaultScale: true,
                    breakpoints: <ResponsiveBreakpoint>[
                      const ResponsiveBreakpoint.resize(200, name: MOBILE),
                      const ResponsiveBreakpoint.resize(480, name: TABLET),
                      const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ],
                    background: Container(color: const Color(0xFFF5F5F5)),
                  );
                },
              )));
    });
  }
}

class FeedbackAndSkeletonScreen extends StatelessWidget {
  const FeedbackAndSkeletonScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
        localizationsDelegates: context.localizationDelegates
          ..add(CustomFeedbackLocalizationsDelegate()),
        child: const SkeletonScreen());
  }
}
