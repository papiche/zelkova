import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:cron/cron.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'app_block_observer.dart';
import 'config/theme.dart';
import 'g1/node_bloc.dart';
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
  final NodeBloc nodeBloc = NodeBloc();

  if (nodeBloc.nodeList.length < 10) {
    // Load nodes from /network/peers
    nodeBloc.loadNodes();
  } else {
    // Try to start with the persisted
  }
  logger(
      'Starting with ${nodeBloc.nodeList.length} duniter nodes and ${nodeBloc.cPlusNodeList.length} c+ nodes');

  final Cron cron = Cron();
  cron.schedule(Schedule.parse('*/45 * * * *'), () async {
    // Every 45m check for faster node (maybe it something costly in terms of
    // bandwidth
    nodeBloc.loadNodes();
  });

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('es'),
        Locale('fr'),
      ],
      fallbackLocale: const Locale('en'),
      useFallbackTranslations: true,
      child: const MyApp(),
    ),
  );
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
          builder: (BuildContext _) => const SkeletonScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: <PageViewModel>[
        for (int i = 1; i <= 5; i++)
          createPageViewModel('intro_${i}_title', 'intro_${i}_description',
              'assets/img/undraw_intro_$i.png'),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      onSkip: () => _onIntroEnd(context),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _skipIntro = !kReleaseMode;

  @override
  Widget build(BuildContext context) {
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
      home: MediaQuery(
        data: const MediaQueryData(),
        child: _skipIntro ? const SkeletonScreen() : const AppIntro(),
      ),
      builder: (BuildContext buildContext, Widget? widget) {
        return ResponsiveWrapper.builder(
          ConnectivityWidgetWrapper(
            message: tr('offline'),
            height: 20,
            child: widget!,
          ),
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
  }
}
