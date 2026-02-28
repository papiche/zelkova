import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/services/background_wallet_sync_service.dart';

void main() {
  group('BackgroundWalletSyncService', () {
    group('syncWallets', () {
      test('returns true when publicKeys is empty', () async {
        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: [],
          fetch: (_) async {},
        );
        expect(result, isTrue);
      });

      test('calls fetch exactly once per public key', () async {
        final callOrder = <String>[];
        final publicKeys = ['pub1', 'pub2', 'pub3'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (pubKey) async {
            callOrder.add(pubKey);
          },
        );

        expect(callOrder, equals(['pub1', 'pub2', 'pub3']));
      });

      test('fetches are sequential (awaited in order)', () async {
        final order = <String>[];
        final publicKeys = ['pub1', 'pub2'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (pubKey) async {
            order.add('start-$pubKey');
            await Future.delayed(Duration(milliseconds: 10));
            order.add('end-$pubKey');
          },
        );

        // Verify interleaving would have occurred if concurrent
        expect(order,
            equals(['start-pub1', 'end-pub1', 'start-pub2', 'end-pub2']));
      });

      test('returns true on successful sync', () async {
        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: ['pub1', 'pub2'],
          fetch: (_) async {},
        );
        expect(result, isTrue);
      });

      test('continues with next wallet if one fetch throws', () async {
        final callOrder = <String>[];
        final publicKeys = ['pub1', 'pub2', 'pub3'];

        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (pubKey) async {
            if (pubKey == 'pub2') {
              throw Exception('Fetch failed for pub2');
            }
            callOrder.add(pubKey);
          },
        );

        // Should return true (error was handled)
        expect(result, isTrue);
        // pub1 and pub3 should still have been fetched
        expect(callOrder, equals(['pub1', 'pub3']));
      });

      test('returns true even if all fetches throw', () async {
        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: ['pub1', 'pub2'],
          fetch: (_) async {
            throw Exception('All fetches fail');
          },
        );

        expect(result, isTrue);
      });

      test('handles large public key lists', () async {
        final publicKeys = List.generate(100, (i) => 'pub_$i');
        var callCount = 0;

        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (_) async {
            callCount++;
          },
        );

        expect(result, isTrue);
        expect(callCount, equals(100));
      });

      test('returns true when fetch completes with delay', () async {
        final result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: ['pub1'],
          fetch: (_) async {
            await Future.delayed(Duration(milliseconds: 50));
          },
        );

        expect(result, isTrue);
      });

      test('preserves order of public keys during fetch', () async {
        final order = <String>[];
        final publicKeys = ['pub_z', 'pub_a', 'pub_m'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (pubKey) async {
            order.add(pubKey);
          },
        );

        expect(order, equals(['pub_z', 'pub_a', 'pub_m']));
      });
    });
  });
}
