import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/services/background_wallet_sync_service.dart';

void main() {
  group('BackgroundWalletSyncService', () {
    group('syncWallets', () {
      test('returns true when publicKeys is empty', () async {
        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: <String>[],
          fetch: (String _) async {},
        );
        expect(result, isTrue);
      });

      test('calls fetch exactly once per public key', () async {
        final List<String> callOrder = <String>[];
        final List<String> publicKeys = <String>['pub1', 'pub2', 'pub3'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (String pubKey) async {
            callOrder.add(pubKey);
          },
        );

        expect(callOrder, equals(<String>['pub1', 'pub2', 'pub3']));
      });

      test('fetches are sequential (awaited in order)', () async {
        final List<String> order = <String>[];
        final List<String> publicKeys = <String>['pub1', 'pub2'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (String pubKey) async {
            order.add('start-$pubKey');
            await Future<void>.delayed(const Duration(milliseconds: 10));
            order.add('end-$pubKey');
          },
        );

        // Verify interleaving would have occurred if concurrent
        expect(
            order,
            equals(
                <String>['start-pub1', 'end-pub1', 'start-pub2', 'end-pub2']));
      });

      test('returns true on successful sync', () async {
        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: <String>['pub1', 'pub2'],
          fetch: (String _) async {},
        );
        expect(result, isTrue);
      });

      test('continues with next wallet if one fetch throws', () async {
        final List<String> callOrder = <String>[];
        final List<String> publicKeys = <String>['pub1', 'pub2', 'pub3'];

        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (String pubKey) async {
            if (pubKey == 'pub2') {
              throw Exception('Fetch failed for pub2');
            }
            callOrder.add(pubKey);
          },
        );

        // Should return true (error was handled)
        expect(result, isTrue);
        // pub1 and pub3 should still have been fetched
        expect(callOrder, equals(<String>['pub1', 'pub3']));
      });

      test('returns true even if all fetches throw', () async {
        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: <String>['pub1', 'pub2'],
          fetch: (String _) async {
            throw Exception('All fetches fail');
          },
        );

        expect(result, isTrue);
      });

      test('handles large public key lists', () async {
        final List<String> publicKeys =
            List<String>.generate(100, (int i) => 'pub_$i');
        int callCount = 0;

        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (String _) async {
            callCount++;
          },
        );

        expect(result, isTrue);
        expect(callCount, equals(100));
      });

      test('returns true when fetch completes with delay', () async {
        final bool result = await BackgroundWalletSyncService.syncWallets(
          publicKeys: <String>['pub1'],
          fetch: (String _) async {
            await Future<void>.delayed(const Duration(milliseconds: 50));
          },
        );

        expect(result, isTrue);
      });

      test('preserves order of public keys during fetch', () async {
        final List<String> order = <String>[];
        final List<String> publicKeys = <String>['pub_z', 'pub_a', 'pub_m'];

        await BackgroundWalletSyncService.syncWallets(
          publicKeys: publicKeys,
          fetch: (String pubKey) async {
            order.add(pubKey);
          },
        );

        expect(order, equals(<String>['pub_z', 'pub_a', 'pub_m']));
      });
    });
  });
}
