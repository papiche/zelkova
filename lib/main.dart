import 'dart:async';
import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';
import 'package:once/once.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:uni_links/uni_links.dart';

import 'app_bloc_observer.dart';
import 'config/theme.dart';
import 'custom_feedback_localization.dart';
import 'data/models/app_cubit.dart';
import 'data/models/app_state.dart';
import 'data/models/bottom_nav_cubit.dart';
import 'data/models/contact_cubit.dart';
import 'data/models/node_list_cubit.dart';
import 'data/models/node_list_state.dart';
import 'data/models/node_manager.dart';
import 'data/models/node_type.dart';
import 'data/models/payment_cubit.dart';
import 'data/models/theme_cubit.dart';
import 'data/models/transaction_cubit.dart';
import 'g1/api.dart';
import 'g1/g1_helper.dart';
import 'shared_prefs.dart';
import 'ui/contacts_cache.dart';
import 'ui/logger.dart';
import 'ui/notification_controller.dart';
import 'ui/screens/skeleton_screen.dart';
import 'ui/ui_helpers.dart';
import 'ui/widgets/connectivity_widget_wrapper_wrapper.dart';
import 'ui/widgets/first_screen/contact_search_page.dart';

void main() async {
  await NotificationController.initializeLocalNotifications();

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

  // .env
  await dotenv.load(
      fileName: kReleaseMode
          ? 'assets/env.production.txt'
          : 'assets/.env.development');

  final SharedPreferencesHelper shared = SharedPreferencesHelper();
  await shared.init();
  await shared.getWallet();
  assert(shared.getPubKey() != null);

  await Hive.initFlutter();

  // Reset hive old keys
  if (kIsWeb) {
    final Box<dynamic> box = await Hive.openBox('hydrated_box',
        path: HydratedStorage.webStorageDirectory.path);
    final List<dynamic> keysToDelete =
        box.keys.where((dynamic key) => '$key'.startsWith('minified')).toList();
    box.deleteAll(keysToDelete);
    // This should we done after init
    // await HydratedBloc.storage.clear();
    box.close();
  }

  if (kIsWeb) {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  } else {
    final Directory tmpDir = await getTemporaryDirectory();
    Hive.init(tmpDir.toString());
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tmpDir);
  }

  PWAInstall().setup(installCallback: () {
    logger('APP INSTALLED!');
  });

  Bloc.observer = AppBlocObserver();

  void appRunner() => runApp(
        EasyLocalization(
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
          child: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
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
            BlocProvider<TransactionCubit>(
                create: (BuildContext context) => TransactionCubit()),
            BlocProvider<ThemeCubit>(
                create: (BuildContext context) => ThemeCubit()),
            // Add other BlocProviders here if needed
          ], child: const GinkgoApp()),
        ),
      );

  if (kReleaseMode) {
    // Only use sentry in production
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

      options.dsn = "${dotenv.env['SENTRY_DSN']}";
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      // options.tracesSampleRate = 1.0;
    }, appRunner: appRunner);
  } else {
    appRunner();
  }
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
    cubit.introViewed();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
          builder: (BuildContext _) => const SkeletonScreen()),
    );
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
  const GinkgoApp({super.key});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<GinkgoApp> createState() => _GinkgoAppState();
}

class _GinkgoAppState extends State<GinkgoApp> {
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
    _initDeepLinkListener();
    NodeManager().loadFromCubit(context.read<NodeListCubit>());
    // Only after at least the action method is set, the notification events are delivered
    NotificationController.startListeningNotificationEvents();
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
      ContactsCache().addContacts(context.read<ContactsCubit>().state.contacts);
    });
    Once.runOnce('resize_avatars', callback: () {
      logger('resize avatar via once');
      context.read<ContactsCubit>().resizeAvatars();
    });
  }

  @override
  void dispose() {
    ContactsCache().dispose();
    _disposeDeepLinkListener();
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ContactSearchPage(uri: link);
            },
          );
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
                theme: ThemeData(
                    useMaterial3: true, colorScheme: lightColorScheme),
                darkTheme:
                    ThemeData(useMaterial3: true, colorScheme: darkColorScheme),

                navigatorKey: GinkgoApp.navigatorKey,
                scaffoldMessengerKey: globalMessengerKey,

                /// Theme stuff
                themeMode: context.watch<ThemeCubit>().state.themeMode,

                /// Localization stuff
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                home: context.read<AppCubit>().isIntroViewed
                    ? BetterFeedback(
                        localizationsDelegates: context.localizationDelegates
                          ..add(CustomFeedbackLocalizationsDelegate()),
                        child: const SkeletonScreen())
                    : const AppIntro(),
                builder: (BuildContext buildContext, Widget? widget) {
                  NotificationController.locale = context.locale;
                  return ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(
                        context,
                        ConnectivityWidgetWrapperWrapper(
                          //message: tr('offline'),
                          //height: 18,

                          offlineWidget: /* Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: */
                              Column(
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
