import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_skill/flutter_skill.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:once/once.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
// WorkManager is only available on Android and iOS
// On Web, this import is conditionally excluded and code paths are guarded with kIsWeb
import 'package:workmanager/workmanager.dart';

import 'app_bloc_observer.dart';
import 'custom_banner.dart';
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
import 'data/models/transaction.dart';
import 'env.dart';
import 'g1/api.dart';
import 'g1/distance_precompute.dart';
import 'g1/distance_precompute_provider.dart';
import 'g1/g1_helper.dart';
// import 'services/g1_genesis_service.dart'; // DEPRECATED: Removed with forced V2 mode
import 'g1/nostr/nostr_relay_service.dart';
import 'g1/service_manager.dart';
import 'g1/zen_tag_service.dart';
import 'services/background_wallet_sync_service.dart';
import 'services/nip101_service.dart';
import 'services/open_collective_service.dart';
import 'services/upassport_api_service.dart';
import 'shared_prefs_helper.dart';
import 'shared_prefs_helper_v2.dart';
import 'ui/biometrics/biometric_auth_service.dart';
import 'ui/contacts_cache.dart';
import 'ui/in_dev_helper.dart';
import 'ui/logger.dart';
import 'ui/notification_controller.dart';
import 'ui/notification_translations_helper.dart';
import 'ui/pay_helper.dart';
import 'ui/screens/skeleton_screen.dart';
import 'ui/screens/wallet_creation_screen.dart';
import 'ui/ui_helpers.dart';
import 'ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'ui/widgets/lazy_upgrade_alert.dart';
import 'ui/widgets/pages/biometric_lock_screen.dart';

const String fetchWalletsTransactionsTask =
    'one.astroport.zelkova.fetchWalletsTransactionsTask';
const String debugBackgroundPingTask =
    'one.astroport.zelkova.debugBackgroundPingTask';

/// Helper function to detect if the error is a duplicate keyboard event
/// This is a known Flutter issue where the HardwareKeyboard layer
/// receives duplicate key press events.
bool _isKeyboardDuplicateEventError(FlutterErrorDetails details) {
  final String exceptionString = details.exceptionAsString();
  return exceptionString.contains('_pressedKeys.containsKey') &&
      exceptionString.contains('KeyDownEvent') &&
      exceptionString.contains('hardware_keyboard.dart');
}

@pragma(
  'vm:entry-point',
) // Mandatory if the App is obfuscated or using Flutter 3.1+
void workManagerCallbackDispatcher() {
  Workmanager().executeTask((
    String task,
    Map<String, dynamic>? inputData,
  ) async {
    try {
      logger.info(
        '---------- Start fetchTransactionsTask Workmanager background task: $task',
      );

      // Handle null task case
      if (task.isEmpty) {
        logger.warning('Received null or empty task in WorkManager');
        return Future<bool>.value(true);
      }

      switch (task) {
        case fetchWalletsTransactionsTask:
          await NotificationController.initializeLocalNotifications();
          await fetchTransactionsFromBackground();
          break;
        case debugBackgroundPingTask:
          // Debug-only deterministic ping task (dev builds only)
          await NotificationController.initializeLocalNotifications();
          final String timestamp = DateTime.now().toIso8601String();
          await NotificationController.notify(
            title: '[DEBUG] Background Task Executed',
            desc: 'Debug background ping at $timestamp',
            id: 'debug_ping_${DateTime.now().millisecondsSinceEpoch}',
          );
          logger.info('Debug background ping task executed at $timestamp');
          break;
        case Workmanager.iOSBackgroundTask:
          logger.info('iOS background task received');
          break;
        default:
          logger.warning('Unknown Dart task: $task');
          break;
      }
      logger.info(
        '---------- End fetchTransactionsTask Workmanager background task',
      );
    } catch (err, stacktrace) {
      log.e('Error in WorkManager task: $err',
          error: err, stackTrace: stacktrace);
      await Sentry.captureException(err, stackTrace: stacktrace);
    }
    return Future<bool>.value(true);
  });
}

void main() async {
  // Wrap the entire bootstrap in runZonedGuarded to catch async uncaught errors.
  runZonedGuarded(() async {
    // Initialize Flutter binding first.
    WidgetsFlutterBinding.ensureInitialized();

    // Enable Flutter Skill automation in debug mode.
    if (kDebugMode) {
      FlutterSkillBinding.ensureInitialized();
    }
    // Forward Flutter framework errors to the default presenter (and your logs).
    FlutterError.onError = (FlutterErrorDetails details) {
      // Ignore known keyboard event duplicate issue
      // See: https://github.com/flutter/flutter/issues/99933
      if (_isKeyboardDuplicateEventError(details)) {
        logger.warning(
            'Ignoring duplicate keyboard event: ${details.exceptionAsString()}');
        return;
      }
      FlutterError.presentError(details);
    };

    // Catch top-level uncaught errors on the platform dispatcher.
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      // Ignore known keyboard event duplicate issue
      if (error is AssertionError &&
          error.toString().contains('_pressedKeys.containsKey')) {
        logger.warning('Ignoring duplicate keyboard event assertion');
        return true;
      }
      logger('Top-level error: $error\n$stack');
      return true;
    };

    logger.info('Starting Ẑelkova app');

    // Initialize Workmanager for background task scheduling (mobile only, not Web)
    // Web platform does not support background tasks via WorkManager
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await Workmanager().initialize(workManagerCallbackDispatcher);

      // Register periodic background task immediately after initialization
      // Using ExistingPeriodicWorkPolicy.update to replace any existing task
      await Workmanager().registerPeriodicTask(
        fetchWalletsTransactionsTask,
        fetchWalletsTransactionsTask,
        inputData: <String, dynamic>{},
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
        ),
        frequency: const Duration(minutes: 16),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
      );
      logger.info('WorkManager periodic task registered');

      // Register debug ping task (dev builds only) for deterministic background testing
      if (inDevelopment) {
        await Workmanager().registerOneOffTask(
          debugBackgroundPingTask,
          debugBackgroundPingTask,
          initialDelay: const Duration(seconds: 10),
          constraints: Constraints(
            networkType: NetworkType.connected,
          ),
        );
        logger.info('Debug background ping task registered (dev build)');
      }
    } else if (kIsWeb) {
      logger.info(
          'Workmanager skipped (Web platform does not support background tasks)');
    }
    logger.info('Workmanager initialization complete');

    await NotificationController.initializeLocalNotifications();
    logger.info('NotificationController initialized');

    // Define themes and pass them to the app widget.
    const int seedColor = 0xff98FB98;
    final int seedColorDark = colorToValue(Colors.lightGreen);

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

    // Initialize i18n and high refresh rate on Android.
    await EasyLocalization.ensureInitialized();

    if (!kIsWeb && Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // Init shared prefs and ensure a default wallet exists.
    SharedPreferencesHelper.configure(useV2: true);
    final SharedPreferencesHelper shared = SharedPreferencesHelper();
    await shared.init();

    /* if (shared.isEmpty) {
      await shared.createDefWalletIfNotExist();
    }
    assert(shared.getPubKey() != null); */

    // Initialize storage layers (Hydrated + Hive + Ferry cache).
    await hiveInit();

    // PWA install hook.
    try {
      PWAInstall().setup(
        installCallback: () {
          logger('APP INSTALLED!');
        },
      );
    } catch (e) {
      logger.warning('PWA Install setup failed: $e');
    }

    // Bloc observer for debugging.
    Bloc.observer = AppBlocObserver();

    // Init cache and timeago locales.
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
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('da_short', timeago.DaShortMessages());

    // Register singletons.
    await initGetItAll();

    // Run the app with forced portrait orientation.
    void appRunner() =>
        SystemChrome.setPreferredOrientations(<DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]).then((_) {
          runApp(
            ChangeNotifierProvider<SharedPreferencesHelper>(
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
                  Locale('da'),
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
                // https://stackoverflow.com/a/77799043
                child: MultiBlocProvider(
                  providers: <BlocProvider<dynamic>>[
                    BlocProvider<BottomNavCubit>(
                      create: (BuildContext context) => BottomNavCubit(),
                    ),
                    BlocProvider<AppCubit>(
                      create: (BuildContext context) =>
                          GetIt.instance.get<AppCubit>(),
                    ),
                    BlocProvider<PaymentCubit>(
                      create: (BuildContext context) => PaymentCubit(),
                    ),
                    BlocProvider<NodeListCubit>(
                      create: (BuildContext context) =>
                          GetIt.instance.get<NodeListCubit>(),
                    ),
                    BlocProvider<ContactsCubit>(
                      create: (BuildContext context) => ContactsCubit(),
                    ),
                    BlocProvider<MultiWalletTransactionCubit>(
                      create: (BuildContext context) =>
                          GetIt.instance.get<MultiWalletTransactionCubit>(),
                    ),
                    BlocProvider<ThemeCubit>(
                      create: (BuildContext context) => ThemeCubit(),
                    ),
                    // Add other BlocProviders here if needed
                  ],
                  child: ZelkovaApp(
                    darkTheme: darkTheme,
                    lightTheme: lightTheme,
                  ),
                ),
              ),
            ),
          );
        });
    const bool enableSentry = false;
    // ignore: dead_code
    if (!kIsWeb && inDevelopment && enableSentry) {
      // Only use sentry in development
      await SentryFlutter.init((SentryFlutterOptions options) {
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
  }, (Object error, StackTrace stack) async {
    // Last-chance catch for any uncaught error within the zone.
    log.e('UNCAUGHT (zone)', error: error, stackTrace: stack);
    // Optionally report to Sentry here.
    // await Sentry.captureException(error, stackTrace: stack);
  });
}

class AppIntro extends StatefulWidget {
  const AppIntro({super.key});

  @override
  State<AppIntro> createState() => _AppIntro();
}

class _AppIntro extends State<AppIntro> {
  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>(debugLabel: 'intro');

  void _onIntroEnd(BuildContext context, AppCubit cubit) {
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      if (!context.mounted) {
        return;
      }
      cubit.introViewed();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext _) => const FeedbackAndSkeletonScreen(),
        ),
      );
    });
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
              createPageViewModel(
                'intro_${i}_title',
                'intro_${i}_description',
                'assets/img/undraw_intro_$i.png',
                context,
              ),
          ],
          onDone: () => _onIntroEnd(buildContext, cubit),
          showSkipButton: true,
          skipOrBackFlex: 0,
          onSkip: () => _onIntroEnd(buildContext, cubit),
          nextFlex: 0,
          skip: Text(tr('skip')),
          next: const Icon(Icons.arrow_forward),
          done: Text(
            tr('start'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
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
      },
    );
  }
}

/*
void printCubitStateSize(String cubitName, HydratedCubit cubit) {
  final String jsonState = jsonEncode(cubit.state);
  print('Size of $cubitName in bytes: ${jsonState.length}');
}
*/

PageViewModel createPageViewModel(
  String title,
  String body,
  String imageAsset,
  BuildContext context,
) {
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
      pageColor: colorScheme.surface,
    ),
  );
}

class ZelkovaApp extends StatefulWidget {
  const ZelkovaApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
  });

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'main nav');

  // Global RouteObserver to allow pages to react when they regain focus
  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  final ThemeData darkTheme;
  final ThemeData lightTheme;

  @override
  State<ZelkovaApp> createState() => _ZelkovaAppState();
}

class _ZelkovaAppState extends State<ZelkovaApp> {
  /// Migration flag to clear old gtest nodes (one-time operation)
  static const String _v2NodesMigrationKey = 'v2_nodes_migration_2026_03_07';

  /// Timer for periodic G1 production readiness detection (30s intervals).
  /// Active only when in test mode (V2 not auto-activated).
  /// Automatically stopped when G1 is detected or app is disposed.
  // Timer? _v2DetectionTimer; // DEPRECATED: Commented out with forced V2 mode

  Future<void> _loadNodes() async {
    _printNodeStatus();
    // In the future only load nodes by type
    final bool useV2 = context.read<AppCubit>().isV2;

    // Load all node types in parallel for better performance
    final List<NodeType> nodeTypesToLoad = NodeType.values
        .where((NodeType nodeType) => nodeType != NodeType.duniterIndexer)
        .toList();

    await Future.wait(
      nodeTypesToLoad.map((NodeType nodeType) =>
          fetchNodes(nodeType, useV2).catchError((Object e) {
            logger('Error loading nodes for $nodeType: $e');
          })),
      // eagerError: false, // Continue even if some node types fail
    );

    _printNodeStatus(prefix: 'Continuing');
  }

  void _printNodeStatus({String prefix = 'Starting'}) {
    final int nCesiumPlusNodes =
        NodeManager().nodeList(NodeType.cesiumPlus).length;
    logger(
      '$nCesiumPlusNodes c+ nodes',
    );
    if (!kReleaseMode) {
      logger('${NodeManager().nodeList(NodeType.cesiumPlus)}');
    }
  }

  /// Monitors G1 (Duniter V2 production) readiness and auto-activates when available.
  ///
  /// **Flow:**
  /// 1. On app startup, checks if G1 genesis hash is available (cache-first)
  /// 2. If available → immediately activates V2 production mode
  /// 3. If not available → starts 30-second polling to detect when G1 goes live
  /// 4. When detected → automatically activates V2, loads production nodes, stops polling
  /// 5. If G1 disappears → reverts to gtest, resumes polling
  ///
  /// **Safety:**
  /// - Only runs if app is mounted (checks `mounted` flag)
  /// - Respects manual V2 activation (doesn't override user choice)
  /// - Fail-safe: Network errors don't crash or affect current state
  ///
  /// **Key points:**
  /// - `v2AutoActivated=true` indicates auto-activation (distinguishes from manual)
  /// - Settings switch is hidden when auto-activated (no user control needed)
  /// - Polling stops immediately when G1 is detected (saves resources)
  ///
  /// See: [G1GenesisService] for hash validation and caching logic
  Future<void> _migrateV2NodesIfNeeded() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool migrationDone = prefs.getBool(_v2NodesMigrationKey) ?? false;

    if (!migrationDone) {
      logger('Running V2 nodes migration: clearing old gtest node cache');

      // Clear only V2 nodes (endpoint + squid indexer)
      final NodeListCubit nodeListCubit = GetIt.instance.get<NodeListCubit>();
      nodeListCubit.clearV2Nodes();

      // Mark migration as completed
      await prefs.setBool(_v2NodesMigrationKey, true);

      logger(
          'V2 nodes migration completed. New nodes will be loaded from .env');
    }
  }

  /// Forces V2 mode permanently (no detection, no manual toggle)
  /// In the future, this will be replaced by network selection feature
  void _forceV2Mode() {
    final AppCubit appCubit = context.read<AppCubit>();

    // If not already in V2, activate it
    if (!appCubit.isV2) {
      logger('Forcing V2 mode (permanent configuration)');
      appCubit.setV2Mode(true);
    }

    // Configure storage and services for V2
    SharedPreferencesHelper.configure(useV2: true);
    GetIt.instance<ServiceManager>().updateService(true);

    logger('V2 mode is now active (forced)');
  }

  // DEPRECATED: G1 genesis auto-detection (forced V2 mode now)
  // Preserved for reference - will be replaced by network selection feature
  /*
  Future<void> _checkG1Genesis() async {
    final AppCubit appCubit = context.read<AppCubit>();

    // Don't interfere if user manually activated v2 mode
    if (appCubit.isV2 && !appCubit.isV2AutoActivated) {
      return;
    }

    // Check if G1 production is ready
    final bool ready = await G1GenesisService.initializeAtStartup();
    if (ready && mounted) {
      _activateV2Production();
      return;
    }

    // Not ready yet → start polling every 30s
    _v2DetectionTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final bool changed = await G1GenesisService.backgroundCheck();
      if (!changed || !mounted) {
        return;
      }

      final bool nowReady = await G1GenesisService.initializeAtStartup();
      if (nowReady) {
        _v2DetectionTimer?.cancel();
        _activateV2Production();
      } else if (mounted) {
        final AppCubit appCubit = context.read<AppCubit>();
        if (appCubit.isV2AutoActivated) {
          // Hash disappeared → revert if it was auto-activated
          _deactivateV2Production();
        }
      }
    });
  }

  /// Activates V2 production mode when G1 genesis hash is detected.
  ///
  /// **Actions performed:**
  /// 1. Sets `v2AutoActivated=true` to distinguish from manual activation
  /// 2. Reconfigures storage to use V2 (secure storage)
  /// 3. Updates service manager for V2 endpoints
  /// 4. Clears contacts cache (may differ between gtest and production)
  /// 5. Loads production V2 nodes from remote `g1.json` (not from `.env`)
  ///
  /// **After this:**
  /// - Settings V2 switch is hidden (auto-activated state)
  /// - App uses production V2 endpoints exclusively
  /// - Genesis hash is cached for fast startup next time
  ///
  /// See: [G1GenesisService.initializeAtStartup] for hash validation
  void _activateV2Production() {
    context.read<AppCubit>().autoActivateV2();
    SharedPreferencesHelper.configure(useV2: true);
    GetIt.instance<ServiceManager>().updateService(true);
    ContactsCache().clear();
    fetchNodesIfNotReady(v2Only: true);
    logger('Auto-activated V2 production mode');
  }

  /// Reverts to gtest (test mode) when G1 genesis hash disappears.
  ///
  /// **Triggered when:**
  /// - Background polling detects hash is no longer available
  /// - G1 production becomes temporarily unavailable
  /// - Remote endpoint returns empty/invalid response
  ///
  /// **Actions performed:**
  /// 1. Sets `v2AutoActivated=false` (revert to manual control)
  /// 2. Reconfigures storage back to V1 (SharedPreferences)
  /// 3. Updates service manager for gtest endpoints
  /// 4. Loads gtest V2 nodes from `.env` defaults
  ///
  /// **After this:**
  /// - Settings V2 switch becomes visible again (expert mode)
  /// - App uses gtest V2 endpoints
  /// - Genesis hash is cleared from cache
  /// - Polling resumes to detect when G1 returns
  ///
  /// See: [G1GenesisService.backgroundCheck] for state change detection
  void _deactivateV2Production() {
    context.read<AppCubit>().deactivateAutoV2();
    SharedPreferencesHelper.configure(useV2: false);
    GetIt.instance<ServiceManager>().updateService(false);
    fetchNodesIfNotReady(v2Only: false);
    logger('Reverted to gtest mode (G1 hash disappeared)');
  }
  */

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      unawaited(_initDeepLinkListener());
    }
    // Only after at least the action method is set, the notification events are delivered
    NotificationController.startListeningNotificationEvents();

    // One-time migration: clear old gtest nodes
    _migrateV2NodesIfNeeded();

    // Force V2 mode permanently
    _forceV2Mode();

    // Schedule periodic/one-off tasks using Once/Timer.
    initCronTask();

    // Warm up contacts cache with current ContactsCubit state.
    ContactsCache().addContacts(context.read<ContactsCubit>().state.contacts);

    // Kick off nodes/tx fetch if online.
    ConnectivityWidgetWrapperWrapper.isConnected.then((bool isConnected) {
      if (isConnected) {
        fetchNodesIfNotReady(v2Only: true);
        // Fetch transactions (and balance) here too on start
        if (mounted) {
          fetchTransactions(context);
        }
      }
    });

    // Clean MultiWalletTransactionCubit state before launching the app
    context.read<MultiWalletTransactionCubit>().autoCleanState();
    // This is consuming a lot of time and may delay app start, only for dev
    // context.read<MultiWalletTransactionCubit>().printStateStats();

    SharedPreferencesHelper().refreshWalletsInfo();

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
    } */
  }

  void initCronTask() {
    // once only runs on startup, if we need something to run every time after
    // the app is opened, we need to use a timer
    Timer(const Duration(hours: 1), () async {
      logger('---------- fetchNodes via timer');
      final bool isConnected =
          await ConnectivityWidgetWrapperWrapper.isConnected;
      if (isConnected) {
        _loadNodes();
      }
    });

    // Hourly nodes load (Once).
    Once.runHourly(
      'load_nodes',
      callback: () async {
        final bool isConnected =
            await ConnectivityWidgetWrapperWrapper.isConnected;
        if (isConnected) {
          logger('Load nodes via once');
          _loadNodes();
        }
      },
      fallback: () {
        _printNodeStatus(prefix: 'After once hourly fallback');
      },
    );

    // Daily cleanups.
    Once.runDaily(
      'clear_errors',
      callback: () {
        logger('clearErrors via once');
        NodeManager().cleanErrorStats();
      },
    );

    Once.runDaily(
      'clear_cache',
      callback: () {
        logger('clear cache via once');
        ContactsCache().clear();
      },
    );

    // One-off avatar resize after first run.
    Once.runOnce(
      'resize_avatars',
      callback: () {
        logger('resize avatar via once');
        context.read<ContactsCubit>().resizeAvatars();
      },
    );

    // Clear tx cubit daily to keep memory small.
    Once.runDaily(
      'clear_tx_cubit',
      callback: () {
        logger('clear tx cubit via once');
        context.read<MultiWalletTransactionCubit>().clearState();
      },
    );

    // Reminder to export backups.
    final int remindMeIn = context.read<AppCubit>().recentExportReminderInDays;

    Once.runCustom(
      'remind_backups',
      callback: () {
        logger('---------- remind backups in $remindMeIn days');
        context.read<AppCubit>().setHasRecentExport(false);
      },
      duration: inDevelopment
          ? Duration(minutes: remindMeIn)
          : Duration(days: remindMeIn),
    );
    // Fetch transactions after a short delay on startup.
    Timer(const Duration(minutes: 5), () async {
      logger('---------- fetchTransactions via timer');
      fetchTransactions(context);
    });
    Once.runCustom(
      'fetch_txs',
      callback: () {
        logger('---------- fetchTransactions via once');
        // Disabled to check the back development
        // if (!inDevelopment) {
        fetchTransactions(context);
      },
      duration: const Duration(minutes: 5),
    );

    // Hourly distance precompute (v2 only).
    Once.runHourly(
      'fetch_distance_precompute',
      callback: () async {
        logger('---------- fetchDistanceEvaluation via once');
        final AppCubit appCubit = context.read<AppCubit>();
        if (appCubit.isV2) {
          final DistancePrecompute? dP =
              await DistancePrecomputeProvider().fetchDistancePrecompute();
          if (dP != null) {
            appCubit.setDistancePreCompute(dP);
          }
        }
      },
    );

    // Hourly wallets info refresh.
    Once.runHourly(
      'refresh_wallet_info',
      callback: () async {
        logger('---------- refresh wallets info via once');
        SharedPreferencesHelper().refreshWalletsInfo();
      },
    );
  }

  @override
  void dispose() {
    // _v2DetectionTimer?.cancel();  // COMMENTED: No longer used (forced V2 mode)
    ContactsCache().dispose();
    _disposeDeepLinkListener();
    /* GetIt.instance<NodeListCubit>().closeCubit();
     GetIt.instance<MultiWalletTransactionCubit>().closeCubit(); */
    super.dispose();
  }

  StreamSubscription<dynamic>? _sub;

  Future<void> _initDeepLinkListener() async {
    // TODO(vjrj): Configure properly Windows
    if (Platform.isAndroid || kIsWeb || Platform.isLinux || Platform.isIOS) {
      final AppLinks appLinks = AppLinks(); // AppLinks is singleton
      _sub = appLinks.stringLinkStream.listen(
        (String? link) async {
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
        },
        onError: (Object err) {
          if (!mounted) {
            return;
          }
          logger('got err: $err');
        },
      );
    }
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
            child: BlocBuilder<ThemeCubit, ThemeModeState>(
              builder: (BuildContext context, ThemeModeState themeState) {
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
                    /// Localization is not available for the title.
                    title: 'Ẑelkova',
                    navigatorKey: ZelkovaApp.navigatorKey,
                    navigatorObservers: <NavigatorObserver>[
                      ZelkovaApp.routeObserver,
                    ],
                    scaffoldMessengerKey: globalMessengerKey,

                    /// Theme stuff
                    theme: widget.lightTheme,
                    highContrastTheme: widget.darkTheme,
                    darkTheme: widget.darkTheme,
                    themeMode: themeState.themeMode,

                    /// Localization stuff
                    localizationsDelegates: context.localizationDelegates
                      ..addAll(<LocalizationsDelegate<dynamic>>[
                        MaterialLocalizationsEo.delegate,
                        CupertinoLocalizationsEo.delegate,
                      ]),
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    home: const AppStart(),
                    builder: (BuildContext c, Widget? widget) {
                      NotificationController.locale = c.locale;
                      return ConnectivityWidgetWrapperWrapper(
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                tr('offline'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 110),
                          ],
                        ),
                        child: c.watch<AppCubit>().isV2
                            ? CustomBanner(
                                message: 'V2',
                                color: Colors.green,
                                child: _buildMaterialAppChild(c, widget),
                              )
                            : _buildMaterialAppChild(c, widget),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  MaxWidthBox _buildMaterialAppChild(BuildContext context, Widget? child) {
    return MaxWidthBox(
      maxWidth:
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 960 : 480,
      backgroundColor: const Color(0xFFF5F5F5),
      child: BouncingScrollWrapper.builder(
        context,
        child!,
        dragWithMouse: true,
      ),
    );
  }
}

class FeedbackAndSkeletonScreen extends StatelessWidget {
  const FeedbackAndSkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Commented as currently there is an issue with the main theme
     https://github.com/ueman/feedback/issues/317
     return BetterFeedback(
        theme: FeedbackThemeData(
          background: Colors.grey,
          feedbackSheetColor: Colors.grey[50]!,
          drawColors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
          ],
        ),
        localizationsDelegates: context.localizationDelegates
          ..add(CustomFeedbackLocalizationsDelegate()),
        child: const SkeletonScreen());
     */

    return const SkeletonScreen();
  }
}

Future<void> initGetItAll() async {
  final GetIt getIt = GetIt.instance;
  if (!getIt.isRegistered<MultiWalletTransactionCubit>()) {
    getIt.registerSingleton<MultiWalletTransactionCubit>(
      MultiWalletTransactionCubit(),
    );
    final AppCubit appCubit = AppCubit();
    getIt.registerSingleton<AppCubit>(appCubit);
    getIt.registerSingleton<NodeListCubit>(NodeListCubit());
    getIt.registerSingleton<ServiceManager>(
      ServiceManager(),
    );

    // Connect NOSTR relay if MULTIPASS exists
    _initNostrRelay();

    // Initialize ZEN constellation tag (fetches UPLANETNAME_G1)
    _initZenTag();

    // Register new services for NIP-101, Open Collective, UPassport integration
    _registerNewServices();
  }
}

/// Register the new services (OpenCollectiveService, UPassportApiService, Nip101Service)
/// as singletons in GetIt for dependency injection.
void _registerNewServices() {
  final GetIt getIt = GetIt.instance;

  // NostrRelayService is already a singleton via factory, ensure it's registered
  if (!getIt.isRegistered<NostrRelayService>()) {
    getIt.registerSingleton<NostrRelayService>(NostrRelayService());
  }

  // OpenCollectiveService - use empty configuration for now; will be configured later via NOSTR
  if (!getIt.isRegistered<OpenCollectiveService>()) {
    getIt.registerSingleton<OpenCollectiveService>(OpenCollectiveService.empty());
  }

  // UPassportApiService
  if (!getIt.isRegistered<UPassportApiService>()) {
    getIt.registerSingleton<UPassportApiService>(UPassportApiService());
  }

  // Nip101Service depends on NostrRelayService
  if (!getIt.isRegistered<Nip101Service>()) {
    final NostrRelayService relayService = getIt.get<NostrRelayService>();
    getIt.registerSingleton<Nip101Service>(Nip101Service(relayService));
  }

  loggerDev('[initGetItAll] New services registered for NIP-101 integration');
}

Future<void> _initZenTag() async {
  try {
    await ZenTagService().init();
  } catch (e) {
    // Non-blocking: ZEN tag is optional
  }
}

Future<void> _initNostrRelay() async {
  try {
    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    if (nsec != null && nsec.isNotEmpty) {
      final String relayUrl = Env.resolvedNostrRelay;
      NostrRelayService().connect(relayUrl);
    }
  } catch (e) {
    // Non-blocking: NOSTR relay is optional
  }
}

Future<void> fetchTransactionsFromBackground([bool init = true]) async {
  try {
    if (init) {
      await hiveInit();
      if (SharedPreferencesHelper().isEmpty) {
        await SharedPreferencesHelper().init();
      }
      try {
        await initGetItAll();
        // await NotificationController.initializeLocalNotifications();
      } catch (e) {
        // We should try to do this better
        loggerDev(e.toString());
        if (inDevelopment) {
          NotificationController.notify(
            title: 'Background process failed',
            desc: e.toString(),
            id: DateTime.now().toIso8601String(),
          );
        }
      }
    }
    loggerDev('Initialized background context');

    // Load notification translations for background isolate
    // Get the user's preferred language from SharedPreferences (set by easy_localization)
    // The locale is stored with key 'locale' as a string like 'es_ES' or 'en_UK'
    String localeCode = 'en'; // Default fallback
    String countryCode = 'UK'; // Default fallback
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedLocale = prefs.getString('locale');
      if (storedLocale != null && storedLocale.isNotEmpty) {
        // Extract language and country codes from stored locale (e.g., 'es_ES' -> 'es', 'ES')
        final List<String> parts = storedLocale.split('_');
        localeCode = parts.first;
        if (parts.length > 1) {
          countryCode = parts[1];
        }
        loggerDev(
            'Read user locale from SharedPreferences: $storedLocale -> ${localeCode}_$countryCode');
      } else {
        loggerDev(
            'No stored locale found in SharedPreferences, using default: ${localeCode}_$countryCode');
      }
    } catch (e) {
      loggerDev(
          'Error reading locale from SharedPreferences: $e, using default: ${localeCode}_$countryCode');
    }

    // Set NotificationController.locale so that notifyTransaction() uses the correct language
    NotificationController.locale = Locale(localeCode, countryCode);
    loggerDev(
        'Set NotificationController.locale to: $localeCode ($countryCode)');

    await NotificationTranslationsHelper.loadTranslations(localeCode);
    loggerDev('Loaded notification translations for locale: $localeCode');

    // Configure SharedPreferencesHelper for correct V1/V2 storage mode in background
    final AppCubit appCubit = GetIt.instance.get<AppCubit>();
    SharedPreferencesHelper.configure(useV2: appCubit.isV2);

    final GetIt getIt = GetIt.instance;
    final MultiWalletTransactionCubit transCubit =
        getIt.get<MultiWalletTransactionCubit>();

    // Use BackgroundWalletSyncService to await all fetches sequentially
    final bool syncSuccess = await BackgroundWalletSyncService.syncWallets(
      publicKeys: SharedPreferencesHelper().publicKeys,
      fetch: (String pubKey) => transCubit.fetchTransactions(
        pubKey: pubKey,
        isConnectedOverride:
            true, // Force fetch even if connectivity check fails
      ),
    );

    if (!syncSuccess) {
      loggerDev('Background wallet sync failed');
    }

    if (inDevelopment) {
      NotificationController.notify(
        title: 'Background process ended correctly',
        desc: '',
        id: DateTime.now().toIso8601String(),
      );
    }
  } catch (e) {
    // We should try to do this better
    loggerDev(e.toString());
  }
}

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  final BiometricAuthService _authService = BiometricAuthService();
  bool _isAppLocked = true;
  bool _biometricSupported = false;
  bool _initializing = true;
  late AppLifecycleReactor _reactor;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _reactor = AppLifecycleReactor(
      lockAfter: Duration(minutes: inDevelopment ? 1 : 5),
      onRequireBiometricLock: _lockApp,
    )..start();
  }

  Future<void> _initializeApp() async {
    _biometricSupported = await _authService.isBiometricSupported();
    final bool biometricEnabled = await _authService.isBiometricEnabled();

    _isAppLocked = biometricEnabled && _biometricSupported;
    setState(() => _initializing = false);
  }

  Future<void> _lockApp() async {
    BiometricLockState().reset();
    final bool enabled = await _authService.isBiometricEnabled();
    final bool supported = await _authService.isBiometricSupported();

    if (enabled && supported) {
      setState(() => _isAppLocked = true);
    }
  }

  Future<void> _unlockApp() async {
    if (_isAppLocked) {
      setState(() => _isAppLocked = false);
      _reactor.resetTimer();
      return;
    }

    final bool success = await showBiometricLockScreen();
    if (success) {
      setState(() => _isAppLocked = false);
    }
  }

  @override
  void dispose() {
    _reactor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool introViewed = GetIt.instance.get<AppCubit>().isIntroViewed;
    if (_initializing) {
      return const SizedBox.shrink();
    }

    if (SharedPreferencesHelper().isEmpty) {
      return const WalletCreationScreen();
    }

    // Don't show tutorial in development
    if (inDevelopment || introViewed) {
      final Widget child = _isAppLocked
          ? BiometricLockScreen(onUnlock: () => _unlockApp())
          : const LazyUpgradeAlert(
              child: FeedbackAndSkeletonScreen(),
            );
      return child;
    } else {
      return const AppIntro();
    }
  }
}

class AppLifecycleReactor with WidgetsBindingObserver {
  AppLifecycleReactor({
    required this.lockAfter,
    required this.onRequireBiometricLock,
  });

  void resetTimer() => _lastPaused = DateTime.now();

  DateTime? _lastPaused;
  final Duration lockAfter;
  final VoidCallback onRequireBiometricLock;

  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lastPaused = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      if (_lastPaused == null) {
        return;
      }

      final bool shouldLock =
          DateTime.now().difference(_lastPaused!) > lockAfter;

      _lastPaused = null;

      if (shouldLock) {
        onRequireBiometricLock();
      }
    }
  }
}

Future<void> hiveInit() async {
  // Hydrated storage
  loggerDev('Initializing Hydrated storage');
  await _migrateDesktopHiveStorage();
  final HydratedStorageDirectory storageDir = kIsWeb
      ? HydratedStorageDirectory.web
      : HydratedStorageDirectory(
          (await getAppDataDirectory()).path,
        );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: storageDir,
  );

  await _clearCacheIfNeeded(storageDir);

  try {
    loggerDev('Initializing Hive');
    await _initHiveStorage().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException('Hive initialization timed out');
      },
    );
  } catch (e) {
    log.e('Error initializing Hive', error: e);
    // If there is an error, we should delete the old hive files
    await Hive.deleteFromDisk();
    await _initHiveStorage();
  }

  loggerDev('Reset hive old keys');
  if (kIsWeb) {
    final Box<dynamic> box = await Hive.openBox(
      'hydrated_box',
      path: HydratedStorageDirectory.web.path,
    );
    final List<dynamic> keysToDelete =
        box.keys.where((dynamic key) => '$key'.startsWith('minified')).toList();
    box.deleteAll(keysToDelete);
    // This should we done after init
    // await HydratedBloc.storage.clear();
    box.close();
  }
}

Future<void> _initHiveStorage() async {
  if (kIsWeb) {
    await Hive.initFlutter();
    return;
  }
  final Directory appDataDir = await getAppDataDirectory();
  Hive.init(appDataDir.path);
  _registerHiveAdapters();
}

void _registerHiveAdapters() {
  final ColorAdapter colorAdapter = ColorAdapter();
  if (!Hive.isAdapterRegistered(colorAdapter.typeId)) {
    Hive.registerAdapter(colorAdapter);
  }
  const TimeOfDayAdapter timeOfDayAdapter = TimeOfDayAdapter();
  if (!Hive.isAdapterRegistered(timeOfDayAdapter.typeId)) {
    Hive.registerAdapter(timeOfDayAdapter);
  }
}

Future<void> _migrateDesktopHiveStorage() async {
  if (!isDesktopPlatform()) {
    return;
  }

  try {
    final Directory oldDir = await getApplicationDocumentsDirectory();
    final Directory newDir = await getAppDataDirectory();

    if (oldDir.path == newDir.path) {
      return;
    }

    if (!oldDir.existsSync()) {
      return;
    }

    await newDir.create(recursive: true);
    final List<FileSystemEntity> entries = oldDir.listSync(followLinks: false);

    for (final FileSystemEntity entity in entries) {
      if (entity is! File) {
        continue;
      }

      final String fileName = path.basename(entity.path);
      if (!_isHiveStorageFile(fileName)) {
        continue;
      }

      final File targetFile = File(path.join(newDir.path, fileName));
      if (targetFile.existsSync()) {
        continue;
      }

      await entity.copy(targetFile.path);
      await entity.delete();
    }
  } catch (e, stacktrace) {
    loggerDev('Failed to migrate hive storage: $e');
    await Sentry.captureException(e, stackTrace: stacktrace);
  }
}

bool _isHiveStorageFile(String fileName) {
  return fileName.endsWith('.hive') || fileName.endsWith('.hive.lock');
}

Future<void> _clearCacheIfNeeded(HydratedStorageDirectory storageDir) async {
  final List<String> boxes = <String>['contacts_cache', 'ferry-graphql-cache'];

  for (final String boxName in boxes) {
    loggerDev("Checking $boxName cache's size");

    if (!kIsWeb) {
      final String cachePath = '${storageDir.path}/$boxName.hive';

      final File cacheFile = File(cachePath);
      if (cacheFile.existsSync()) {
        final int cacheSize = cacheFile.lengthSync();
        const int maxCacheSize = 100000000;

        if (cacheSize > maxCacheSize) {
          loggerDev('Cache $boxName exceeds limit. Clearing cache...');
          await cacheFile.delete();
        } else {
          loggerDev('Cache $boxName size is within limits.');
        }
      } else {
        loggerDev('Cache $boxName file does not exist.');
      }
    }
  } // TODO(vjrj): do something for web too
}

Future<void> fetchTransactions(BuildContext context) async {
  final MultiWalletTransactionCubit transCubit =
      context.read<MultiWalletTransactionCubit>();

  // Execute all requests in parallel without blocking (fire-and-forget)
  // This prevents blocking the UI while requests are being made
  final List<String> publicKeys = SharedPreferencesHelper().publicKeys;

  // Use unawaited to avoid blocking the main thread
  // Requests will be executed in parallel in the background
  unawaited(
    Future.wait(
      publicKeys.map((String pubKey) =>
          transCubit.fetchTransactions(pubKey: pubKey).catchError((Object e) {
            logger('Error fetching transactions for $pubKey: $e');
            return <Transaction>[];
          })),
      // eagerError: false, // Continue even if some requests fail
    ),
  );
}
