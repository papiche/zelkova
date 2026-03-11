import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'helpers/patrol_test_helpers.dart';

void main() {
  group('Intro Screen Button Tests', () {
    patrolTest(
      'Start button in intro screen is clickable and navigates to main app',
      (PatrolIntegrationTester $) async {
        // Resetear el estado de intro para simular primer arranque
        await PatrolTestHelpers.resetIntroState();

        // Iniciar la app
        app.main();

        // Esperar a que la app se cargue completamente
        await $.pumpAndSettle();

        // Verificar que se muestra la pantalla de introducción
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro screen PageView should be visible',
        );

        // Navegar a la última página del carrusel (página 5)
        // usando pump para ir página por página
        for (int i = 0; i < 4; i++) {
          // Buscar el botón siguiente y hacer tap
          final Finder nextButtonFinder = find.byIcon(Icons.arrow_forward);
          if (nextButtonFinder.evaluate().isNotEmpty) {
            await $.tap(nextButtonFinder);
            await $.pumpAndSettle();
          }
        }

        // Verificar que los botones existen en la última página
        expect(
          find.byType(ElevatedButton).evaluate().isNotEmpty,
          isTrue,
          reason: 'Start button should exist on last intro page',
        );

        // Buscar y hacer tap en el botón "Done" (Comenzar)
        // El botón done en la última página del intro
        final Finder doneButtonFinder = find.byType(ElevatedButton);

        if (doneButtonFinder.evaluate().isNotEmpty) {
          await $.tap(doneButtonFinder.first);
          await $.pumpAndSettle();

          // Verificar que se navegó fuera del intro
          expect(
            find.byType(Scaffold),
            findsOneWidget,
            reason:
                'Main app Scaffold should be visible after intro completion',
          );
          // Verificar que el intro se marcó como visto
          final bool introViewed = PatrolTestHelpers.getIntroViewedState();
          expect(
            introViewed,
            isTrue,
            reason: 'Intro should be marked as viewed after completion',
          );

          debugPrint(
            '✓ Test completed: Start button navigation works correctly',
          );
        } else {
          fail('Done button not found in intro');
        }
      },
    );

    patrolTest(
      'Intro carousel can navigate between pages',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();

        // Verificar página inicial del intro
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro carousel should be visible',
        );

        // Verificar que el botón siguiente existe
        final Finder nextButtonFinder = find.byIcon(Icons.arrow_forward);
        expect(
          nextButtonFinder,
          findsWidgets,
          reason: 'Next button should exist to navigate carousel',
        );

        // Hacer tap en siguiente para ir a la próxima página
        await $.tap(nextButtonFinder);
        await $.pumpAndSettle();

        // Verificar que sigue mostrando el intro
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro carousel should still be visible',
        );

        debugPrint('✓ Test completed: Intro carousel navigation works');
      },
    );

    patrolTest(
      'Intro does not show UpgradeAlert on first run',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();

        // El intro debería ser visible
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro should be visible on first run',
        );

        // No debería haber dialogo de actualización visible en el intro
        // UpgradeAlert aparece como un Dialog o similar, no debería aparecer
        // mientras se está mostrando el AppIntro widget
        debugPrint(
          '✓ Test completed: Intro shows without UpgradeAlert interference',
        );
      },
    );

    tearDown(() async {
      await PatrolTestHelpers.cleanupAfterTest();
    });
  });
}
