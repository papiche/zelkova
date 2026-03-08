import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/app_cubit.dart';
import 'package:ginkgo/data/models/app_state.dart';
import 'package:ginkgo/g1/currency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hive_ce/hive.dart';

void main() {
  group('AppCubit', () {
    late AppCubit appCubit;

    setUpAll(() async {
      // Initialize Hive for testing
      Hive.init('test_hive');
      final HydratedStorageDirectory testDir =
          HydratedStorageDirectory(Directory.systemTemp.path);
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: testDir,
      );
    });

    tearDownAll(() async {
      await HydratedBloc.storage!.clear();
      await Hive.deleteBoxFromDisk('AppCubit');
    });

    setUp(() {
      appCubit = AppCubit();
    });

    tearDown(() async {
      await appCubit.close();
    });

    group('setUd()', () {
      test('should emit new state when setUd is called before close', () async {
        final double testUd = 11.48;

        appCubit.setUd(testUd);

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        // Verify the state has been updated to the test UD
        expect(appCubit.state.currentUd, equals(testUd));
      });

      test('should not throw when setUd is called after close', () async {
        await appCubit.close();

        // Should not throw
        expect(
          () => appCubit.setUd(11.48),
          returnsNormally,
        );
      });

      test('should not change state when cubit is already closed', () async {
        final double testUd = 11.48;

        // Get the initial state
        final AppState initialState = appCubit.state;

        // Close the cubit
        await appCubit.close();

        // Call setUd after close
        appCubit.setUd(testUd);

        // Verify the state hasn't changed
        expect(appCubit.state, equals(initialState));
      });

      test('should handle concurrent setUd calls and disposal', () async {
        final double testUd = 11.48;

        // Start a setUd call that completes after close
        final Future<void> future1 = Future.delayed(
          const Duration(milliseconds: 10),
          () => appCubit.setUd(testUd),
        );

        // Close while operations might be in flight
        await Future.delayed(const Duration(milliseconds: 5));
        await appCubit.close();

        // Wait for all operations to complete
        await future1;

        // Should not throw and state should be valid
        expect(appCubit.state, isA<AppState>());
      });

      test('should preserve UD value when successfully emitted', () async {
        final double testUd = 11.50;

        appCubit.setUd(testUd);

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.currentUd, equals(testUd));
      });

      test('should update currentUdLastUpdate when UD is set', () async {
        final double testUd = 11.48;
        final DateTime beforeUpdate = DateTime.now();

        appCubit.setUd(testUd);

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        final DateTime? updateTime = appCubit.currentUdLastUpdate;
        expect(updateTime, isNotNull);
        expect(
          updateTime!
              .isAfter(beforeUpdate.subtract(const Duration(seconds: 1))),
          isTrue,
        );
      });

      test('should skip setUd when isClosed is true', () async {
        final double testUd = 12.0; // Use a different value
        final double stateBeforeClose = appCubit.state.currentUd;

        // Close the cubit
        await appCubit.close();

        // Call setUd after close
        appCubit.setUd(testUd);

        // Verify the state hasn't changed from what it was before close
        expect(appCubit.state.currentUd, equals(stateBeforeClose));
        expect(appCubit.state.currentUd, isNot(testUd));
      });
    });

    group('shouldUpdateUd()', () {
      test('should return false after UD has been set (persisted state)', () {
        // Note: Due to HydratedCubit persistence, if a previous test set UD,
        // this test will see currentUdLastUpdate as not null
        // We just verify the logic works correctly
        final bool shouldUpdate = appCubit.shouldUpdateUd();
        expect(shouldUpdate, isFalse); // UD was set by previous test
      });

      test('should return false when UD was updated less than 24 hours ago',
          () async {
        final double testUd = 11.49;

        appCubit.setUd(testUd);

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.shouldUpdateUd(), isFalse);
      });
    });

    group('Currency methods', () {
      test('should emit state with G1 currency', () async {
        appCubit.setG1Currency();

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.currency, equals(Currency.G1));
      });

      test('should emit state with DU currency', () async {
        appCubit.setDUCurrency();

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.currency, equals(Currency.DU));
      });
    });

    group('V2 mode', () {
      test('should emit state with v2mode enabled', () async {
        appCubit.setV2Mode(true);

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.isV2, isTrue);
      });

      test('should auto-activate V2', () async {
        appCubit.autoActivateV2();

        // Give the emit a chance to complete
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.isV2, isTrue);
        expect(appCubit.isV2AutoActivated, isTrue);
      });

      test('should deactivate auto V2', () async {
        appCubit.autoActivateV2();
        await Future.delayed(const Duration(milliseconds: 10));

        appCubit.deactivateAutoV2();
        await Future.delayed(const Duration(milliseconds: 10));

        expect(appCubit.isV2, isFalse);
        expect(appCubit.isV2AutoActivated, isFalse);
      });
    });

    group('Lifecycle tests', () {
      test('should be closeable without errors', () async {
        expect(
          appCubit.close(),
          completes,
        );
      });

      test('isClosed should be true after close', () async {
        await appCubit.close();

        expect(appCubit.isClosed, isTrue);
      });

      test('multiple close calls should not throw', () async {
        await appCubit.close();

        // Second close should not throw
        expect(
          appCubit.close(),
          completes,
        );
      });
    });
  });
}
