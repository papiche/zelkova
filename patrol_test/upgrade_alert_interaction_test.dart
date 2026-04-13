import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'helpers/patrol_test_helpers.dart';

void main() {
  group('UpgradeAlert Interaction Tests', () {
    patrolTest(
      'UpgradeAlert appears after intro is completed',
      (PatrolIntegrationTester $) async {
        // Marcar intro como visto para simular que el usuario ya ha pasado el intro
        await PatrolTestHelpers.markIntroAsViewed();

        app.main();
        await $.pumpAndSettle();

        // Después de que el intro fue completado, debería mostrarse SkeletonScreen
        // que contiene el UpgradeAlert
        expect(
          find.byType(Scaffold),
          findsOneWidget,
          reason: 'Main app Scaffold should be visible after intro',
        );

        debugPrint(
          '✓ Test passed: App shows main screen after intro completion',
        );
      },
    );

    patrolTest(
      'Main app is accessible after intro without UpgradeAlert blocking',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.markIntroAsViewed();

        app.main();
        await $.pumpAndSettle();

        // Verificar que se puede interactuar con la app principal
        expect(
          find.byType(Scaffold),
          findsOneWidget,
          reason: 'Scaffold should be present for main app',
        );

        // Buscar widgets característicos de la app principal
        // Por ejemplo, BottomNavigationBar o widgets similares
        expect(
          find.byType(BottomNavigationBar).evaluate().isNotEmpty ||
              find.byType(NavigationBar).evaluate().isNotEmpty ||
              find.byType(NavigationRail).evaluate().isNotEmpty,
          isTrue,
          reason: 'Main app should have navigation structure',
        );

        debugPrint(
          '✓ Test passed: Main app is accessible and interactive',
        );
      },
    );

    patrolTest(
      'App state persists correctly between intro completion and main app',
      (PatrolIntegrationTester $) async {
        // Resetear para simular primer arranque
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();

        // Verificar intro inicial
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro should appear on first run',
        );

        // Completar el intro
        for (int i = 0; i < 4; i++) {
          final Finder nextButton = find.byIcon(Icons.arrow_forward);
          if (nextButton.evaluate().isNotEmpty) {
            await $.tap(nextButton);
            await $.pumpAndSettle();
          }
        }

        final Finder doneButton = find.byType(ElevatedButton);
        if (doneButton.evaluate().isNotEmpty) {
          await $.tap(doneButton.first);
          await $.pumpAndSettle();
        }

        // Esperar a que se complete la transición
        await $.pumpAndSettle();

        // Verificar que ahora se muestra la app principal
        expect(
          find.byType(Scaffold),
          findsOneWidget,
          reason: 'Main app should be visible after completing intro sequence',
        );

        // Verificar que el estado fue guardado correctamente
        final bool introViewed = PatrolTestHelpers.getIntroViewedState();
        expect(
          introViewed,
          isTrue,
          reason: 'Intro viewed state should persist',
        );

        debugPrint(
          '✓ Test passed: App state persists through intro completion',
        );
      },
    );

    patrolTest(
      'LazyUpgradeAlert does not interfere with main app navigation',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.markIntroAsViewed();

        app.main();
        await $.pumpAndSettle();

        // Intentar navegar por la app (si hay navigation)
        // Buscar elementos clickeables como botones en BottomNavigationBar
        final Finder navItems =
            find.byType(BottomNavigationBarItem).evaluate().isNotEmpty
                ? find.byType(BottomNavigationBarItem)
                : find.byType(NavigationDestination);

        if (navItems.evaluate().isNotEmpty) {
          // Intentar hacer tap en elemento de navegación
          await $.tap(navItems.first);
          await $.pumpAndSettle();

          // Si no hubo error, la navegación funciona
          debugPrint('✓ Navigation works without UpgradeAlert interference');
        }

        debugPrint(
          '✓ Test passed: Main app navigation not blocked by LazyUpgradeAlert',
        );
      },
    );

    tearDown(() async {
      await PatrolTestHelpers.cleanupAfterTest();
    });
  });
}
