import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
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

import 'app_bloc_observer.dart';
import 'config/theme.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'data/models/app_cubit.dart';
import 'data/models/app_state.dart';
import 'data/models/contact_cubit.dart';
import 'data/models/node_list_cubit.dart';
import 'data/models/node_list_state.dart';
import 'data/models/node_manager.dart';
import 'data/models/payment_cubit.dart';
import 'data/models/transaction_cubit.dart';
import 'g1/api.dart';
import 'shared_prefs.dart';
import 'ui/screens/skeleton_screen.dart';

// logs
final EasyLogger logger = EasyLogger(
  name: 'ginkgo',
  defaultLevel: LevelMessages.debug,
  enableBuildModes: <BuildMode>[
    BuildMode.debug,
    BuildMode.profile,
    BuildMode.release
  ],
  enableLevels: <LevelMessages>[
    LevelMessages.debug,
    LevelMessages.info,
    LevelMessages.error,
    LevelMessages.warning
  ],
);

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final SharedPreferencesHelper shared = SharedPreferencesHelper();
  await shared.init();
  await shared.getWallet();
  assert(shared.getPubKey() != null);

  // .env
  await dotenv.load(
      fileName: kReleaseMode
          ? 'assets/env.production.txt'
          : 'assets/.env.development');

  if (kIsWeb) {
    await Hive.initFlutter();
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  } else {
    final Directory tmpDir = await getTemporaryDirectory();
    Hive.init(tmpDir.toString());
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tmpDir);
  }

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
                create: (BuildContext context) => TransactionsCubit())
            // Add other BlocProviders here if needed
          ], child: const GinkgoApp()),
        ),
      );

  if (!kReleaseMode) {
    await SentryFlutter.init((
      SentryFlutterOptions options,
    ) {
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

  void _onIntroEnd(BuildContext context) {
    context.read<AppCubit>().introViewed();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
          builder: (BuildContext _) => const SkeletonScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext buildContext, AppState state) =>
            IntroductionScreen(
              key: introKey,
              pages: <PageViewModel>[
                for (int i = 1; i <= 5; i++)
                  createPageViewModel(
                      'intro_${i}_title',
                      'intro_${i}_description',
                      'assets/img/undraw_intro_$i.png'),
              ],
              onDone: () => _onIntroEnd(buildContext),
              showSkipButton: true,
              skipOrBackFlex: 0,
              onSkip: () => _onIntroEnd(buildContext),
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
            ));
  }
}

PageViewModel createPageViewModel(
    String title, String body, String imageAsset) {
  return PageViewModel(
    title: tr(title),
    body: tr(body),
    image: Image.asset(imageAsset),
    decoration: const PageDecoration(
      pageColor: Colors.white,
      bodyTextStyle: TextStyle(fontSize: 18),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

class GinkgoApp extends StatefulWidget {
  const GinkgoApp({super.key});

  @override
  State<GinkgoApp> createState() => _GinkgoAppState();
}

class _GinkgoAppState extends State<GinkgoApp> {
  Future<void> _loadNodes(NodeListCubit cubit) async {
    // Load nodes from /network/peers
    NodeManager().loadFromCubit(cubit);
    final int nDuniterNodes = NodeManager().nodeList(NodeType.duniter).length;
    final int nCesiumPlusNodes =
        NodeManager().nodeList(NodeType.cesiumPlus).length;
    logger(
        'Starting with $nDuniterNodes duniter nodes and $nCesiumPlusNodes c+ nodes');
    await fetchDuniterNodes();
    await fetchCesiumPlusNodes();
    logger(
        'Continue with $nDuniterNodes duniter nodes and $nCesiumPlusNodes c+ nodes');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      Once.runHourly('load_nodes',
          callback: () => _loadNodes(nodeContext.read<NodeListCubit>()),
          fallback: () {
            logger('Finished once load nodes');
          });

      Once.runCustom('clear_errors', callback: () {
        NodeManager().cleanErrorStats();
      }, duration: const Duration(minutes: 90));
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
              // const ResponsiveBreakpoint.resize(200, name: MOBILE),
              const ResponsiveBreakpoint.resize(480, name: TABLET),
              const ResponsiveBreakpoint.resize(480, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5)),
          );
        },
      ));
    });
  }
}
