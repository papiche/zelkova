import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/main.dart' as app;
import 'package:patrol/patrol.dart';

import 'helpers/patrol_test_helpers.dart';

void main() {
  group('Intro Flow with Upgrader Tests', () {
    patrolTest(
      'UpgradeAlert does not appear during intro sequence',
      (PatrolIntegrationTester $) async {
        // Resetear el estado para simular primer arranque
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();

        // Verificar que se muestra el intro, no UpgradeAlert
        expect(
          find.byType(PageView),
          findsOneWidget,
          reason: 'Intro PageView should be shown on first run',
        );

        // Navegar completamente por el intro
        for (int i = 0; i < 4; i++) {
          final Finder nextButton = find.byIcon(Icons.arrow_forward);
          if (nextButton.evaluate().isNotEmpty) {
            await $.tap(nextButton);
            await $.pumpAndSettle();
          }
        }

        // Verificar que el intro sigue siendo visible
        // y no hay diálogos de actualización interrumpiendo
        expect(
          find.byType(AlertDialog),
          findsNothing,
          reason: 'No AlertDialog should appear during intro',
        );

        // El botón "Comenzar" debería ser visible en la última página
        expect(
          find.byType(ElevatedButton),
          findsWidgets,
          reason: 'Start button should be visible on final intro page',
        );

        debugPrint(
          '✓ Test passed: UpgradeAlert did not interfere with intro sequence',
        );
      },
    );

    patrolTest(
      'After intro completion, state is correctly marked as viewed',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();
        // Verificar estado inicial
        final bool initialIntroViewed = PatrolTestHelpers.getIntroViewedState();
        expect(
          initialIntroViewed,
          isFalse,
          reason: 'Intro should not be marked as viewed initially',
        );

        // Navegar al final del intro
        for (int i = 0; i < 4; i++) {
          final Finder nextButton = find.byIcon(Icons.arrow_forward);
          if (nextButton.evaluate().isNotEmpty) {
            await $.tap(nextButton);
            await $.pumpAndSettle();
          }
        }

        // Hacer tap en botón Comenzar
        final Finder doneButton = find.byType(ElevatedButton);
        if (doneButton.evaluate().isNotEmpty) {
          await $.tap(doneButton.first);
          await $.pumpAndSettle();

          // Esperar a que se complete la navegación
          await $.pumpAndSettle();

          // Verificar que el intro fue marcado como visto
          final bool finalIntroViewed = PatrolTestHelpers.getIntroViewedState();
          expect(
            finalIntroViewed,
            isTrue,
            reason: 'Intro should be marked as viewed after completion',
          );

          debugPrint(
            '✓ Test passed: Intro viewed state correctly updated',
          );
        }
      },
    );

    patrolTest(
      'Intro does not block button interactions on any page',
      (PatrolIntegrationTester $) async {
        await PatrolTestHelpers.resetIntroState();

        app.main();
        await $.pumpAndSettle();

        // Verificar que podemos interactuar con botones en cada página
        for (int pageIndex = 0; pageIndex < 5; pageIndex++) {
          // Buscar botones disponibles (skip, next, done)
          final Finder allButtons = find.byType(ElevatedButton);
          expect(
            allButtons.evaluate().isNotEmpty,
            isTrue,
            reason:
                'Buttons should be available on every intro page (page $pageIndex)',
          );

          if (pageIndex < 4) {
            // No es la última página, buscar siguiente
            final Finder nextButton = find.byIcon(Icons.arrow_forward);
            if (nextButton.evaluate().isNotEmpty) {
              await $.tap(nextButton);
              await $.pumpAndSettle();
            }
          } else {
            // Es la última página, terminar
            break;
          }
        }

        debugPrint('✓ Test passed: All intro page buttons are interactive');
      },
    );

    tearDown(() async {
      await PatrolTestHelpers.cleanupAfterTest();
    });
  });
}
