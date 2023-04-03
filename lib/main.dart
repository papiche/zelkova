import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:once/once.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'app_bloc_observer.dart';
import 'config/theme.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'data/models/app_cubit.dart';
import 'data/models/app_state.dart';
import 'data/models/contact_cubit.dart';
import 'data/models/node_list_cubit.dart';
import 'data/models/node_list_state.dart';
import 'data/models/node_manager.dart';
import 'data/models/node_type.dart';
import 'data/models/payment_cubit.dart';
import 'data/models/transaction_cubit.dart';
import 'g1/api.dart';
import 'shared_prefs.dart';
import 'ui/contacts_cache.dart';
import 'ui/logger.dart';
import 'ui/screens/skeleton_screen.dart';
import 'ui/ui_helpers.dart';

void main() async {
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

  if (kIsWeb) {
    // It seems is redundant
    // await Hive.initFlutter();
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  } else {
    final Directory tmpDir = await getTemporaryDirectory();
    Hive.init(tmpDir.toString());
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tmpDir);
  }

  Bloc.observer = AppBlocObserver();

  // Reset hive during developing
  if (!kReleaseMode) {
    // Once.clearAll();
    // await HydratedBloc.storage.clear();
  }

  void appRunner() => runApp(
        EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const <Locale>[
            Locale('en'),
            Locale('es'),
            Locale('fr'),
            Locale('ca'),
            Locale('de'),
            Locale('nl'),
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
            BlocProvider<TransactionsCubit>(
                create: (BuildContext context) => TransactionsCubit()),
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

  @override
  State<GinkgoApp> createState() => _GinkgoAppState();
}

class _GinkgoAppState extends State<GinkgoApp> {
  Future<void> _loadNodes() async {
    _printNodeStatus();
    await fetchDuniterNodes(NodeType.duniter);
    await fetchCesiumPlusNodes();
    await fetchDuniterNodes(NodeType.gva);

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
  }

  @override
  void initState() {
    super.initState();
    ContactsCache().init();
    NodeManager().loadFromCubit(context.read<NodeListCubit>());
  }

  @override
  void dispose() {
    ContactsCache().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      Once.runHourly('load_nodes',
          callback: () => _loadNodes(),
          fallback: () {
            _printNodeStatus(prefix: 'After once hourly having');
          });
      Once.runCustom('clear_errors', callback: () {
        NodeManager().cleanErrorStats();
      }, duration: const Duration(minutes: 90));
      Once.runCustom('fetch_transactions', callback: () {
        fetchTransactions(context);
      }, duration: const Duration(minutes: 10));
      fetchTransactions(context);
      return ConnectivityAppWrapper(
          app: MaterialApp(
        /// Localization is not available for the title.
        title: 'Ğ1nkgo',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),

        /// Theme stuff

        /// Localization stuff
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: context.read<AppCubit>().isIntroViewed
            ? const SkeletonScreen()
            : const AppIntro(),
        builder: (BuildContext buildContext, Widget? widget) {
          return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(
                context,
                ConnectivityWidgetWrapper(
                  message: tr('offline'),
                  height: 20,
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
      ));
    });
  }
}
