import '../ui/logger.dart';

// ignore: avoid_classes_with_only_static_members
/// Service for deterministic, awaited background wallet synchronization.
///
/// This service provides a pure-Dart, headless-safe interface for fetching
/// transactions across multiple wallets in a background isolate context.
///
/// **Design goals:**
/// - Sequentially fetch transactions for all wallets, awaiting each fetch
/// - Return only after all work is complete (no fire-and-forget futures)
/// - No UI operations, no permission dialogs, no context-dependent code
/// - Deterministic and testable (accepts a custom fetch function)
///
/// **Usage in WorkManager callback:**
/// ```dart
/// await BackgroundWalletSyncService.syncWallets(
///   publicKeys: ['pubKey1', 'pubKey2'],
///   fetch: (pubKey) => transCubit.fetchTransactions(pubKey: pubKey),
/// );
/// ```
///
/// **Testing:**
/// ```dart
/// await BackgroundWalletSyncService.syncWallets(
///   publicKeys: ['test1', 'test2'],
///   fetch: (pubKey) async {
///     // Mock implementation
///   },
/// );
/// ```
class BackgroundWalletSyncService {
  /// Synchronously fetches transactions for all wallets, awaiting each fetch.
  ///
  /// **Parameters:**
  /// - `publicKeys`: List of wallet public keys to sync
  /// - `fetch`: Async callback that performs the fetch for a single public key
  ///   (typically `transCubit.fetchTransactions(pubKey: pubKey)`)
  ///
  /// **Behavior:**
  /// - Fetches are executed sequentially (one at a time)
  /// - All fetches are awaited before returning
  /// - If any fetch throws, logs the error but continues with next wallet
  /// - Returns `true` if all fetches completed (successfully or with logged errors)
  /// - Returns `false` only if the input is invalid or other catastrophic error
  ///
  /// **Example:**
  /// ```dart
  /// final success = await BackgroundWalletSyncService.syncWallets(
  ///   publicKeys: ['pub1', 'pub2', 'pub3'],
  ///   fetch: (pubKey) => transCubit.fetchTransactions(pubKey: pubKey),
  /// );
  /// if (!success) {
  ///   loggerDev('Background sync aborted due to invalid input');
  /// }
  /// ```
  static Future<bool> syncWallets({
    required List<String> publicKeys,
    required Future<void> Function(String pubKey) fetch,
  }) async {
    try {
      // Validate input
      if (publicKeys.isEmpty) {
        loggerDev(
            'BackgroundWalletSyncService.syncWallets: no public keys provided');
        return true; // Not an error, just nothing to sync
      }

      if (fetch == null) {
        loggerDev(
            'BackgroundWalletSyncService.syncWallets: fetch callback is null');
        return false;
      }

      // Sequential fetch: await each wallet before moving to the next
      for (final String pubKey in publicKeys) {
        try {
          loggerDev('BackgroundWalletSyncService: syncing pubKey=$pubKey');
          await fetch(pubKey);
          loggerDev('BackgroundWalletSyncService: completed pubKey=$pubKey');
        } catch (e) {
          loggerDev(
              'BackgroundWalletSyncService: error syncing pubKey=$pubKey: $e');
          // Continue with next wallet on error
        }
      }

      loggerDev('BackgroundWalletSyncService.syncWallets: all wallets synced');
      return true;
    } catch (e) {
      loggerDev(
          'BackgroundWalletSyncService.syncWallets: unexpected error: $e');
      return false;
    }
  }
}
