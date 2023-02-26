import 'dart:io';

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
import 'package:path_provider/path_provider.dart';

import 'config/theme.dart';
import 'cubit/theme_cubit.dart';
import 'ui/screens/skeleton_screen.dart';

// logs
final EasyLogger logger = EasyLogger(
  name: tr('app_name'),
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

  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

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

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('de'),
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
    // Navegar a la pantalla de inicio de la aplicación después de que se complete la introducción
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SkeletonScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: <PageViewModel>[
        for (int i = 1; i <= 5; i++)
          createPageViewModel('intro_${i}_title', 'intro_${i}_description',
              'assets/img/undraw_intro_$i.png')
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      // FIXME
      skip: const Text('Saltar'),
      next: const Icon(Icons.arrow_forward),
      // FIXME
      done:
          const Text('Empezar', style: TextStyle(fontWeight: FontWeight.w600)),
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (BuildContext context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeModeState>(
        builder: (BuildContext context, ThemeModeState state) {
          return MaterialApp(
            /// Localization is not available for the title.
            title: 'Flutter Production Boilerplate',

            /// Theme stuff
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode,

            /// Localization stuff
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            home: const MediaQuery(data: MediaQueryData(), child: AppIntro()),
          );
        },
      ),
    );
  }
}
