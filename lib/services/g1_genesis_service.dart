// DEPRECATED: G1 genesis auto-detection service
// This file is preserved for reference but no longer used
// App now forces V2 mode permanently (will be replaced by network selection)
//
// Original implementation based on Gecko's approach:
// https://forum.duniter.org/t/gecko-talks-user-support/9372/590

/*
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/logger.dart';

// ignore: avoid_classes_with_only_static_members
/// Service for automatic G1 (production V2) readiness detection.
///
/// This service monitors a remote endpoint to detect when G1 (Duniter V2
/// production) becomes available. When a valid genesis hash is detected,
/// the app can automatically activate V2 mode without user intervention.
///
/// **Implementation based on Gecko's approach** (Duniter forum post #590):
/// https://forum.duniter.org/t/gecko-talks-user-support/9372/590
///
/// Poka (Gecko author) explains the strategy:
/// > "Tant que la string est vide ou invalide, ça continue le processus normal.
/// > Mais si un hash genesis apparaît, alors Gecko se connecte automatiquement
/// > au réseau G1, et garde en cache ce hash genesis pour le réseau.
/// > Ça pull également non-stop toutes les 30 secondes pendant le cycle de vie
/// > de l'app et se connecte automatiquement au réseau G1 si le hash valide
/// > apparaît."
///
/// **Key features:**
/// - **Cache-first approach**: Uses local cache for fast startup (no network)
/// - **Background polling**: 30-second intervals to auto-activate when ready
/// - **Fail-safe**: Network errors preserve existing cache (no state change)
/// - **Reversible**: If hash disappears, reverts to test mode (gtest)
///
/// **Genesis hash validation:**
/// Remote endpoint: https://get-g1-genesis-hash.p2p.legal
/// Response format: `{"hash": "0x..."}`
/// - When hash is empty or invalid: G1 not ready yet
/// - When hash is valid (0x + 64 hex chars): G1 is production-ready
/// - Hash is cached for fast startup without network calls
///
/// **Node discovery strategy** (after G1 is detected):
/// Per Gecko's design, nodes are discovered in two phases:
/// 1. **Bootstrap**: Load seed nodes from g1.json (Duniter Git repository)
/// 2. **P2P Discovery**: Query each seed node for its peers, recursively
///    - This finds the complete healthy node set without hardcoded lists
///    - Adapts automatically when nodes join/leave production network
///
/// NOTE: `.env` files contain ONLY gtest defaults (test network).
/// Production V2 endpoints (g1.p2p.legal, g1-squid.axiom-team.fr) are
/// discovered dynamically, NOT from environment variables.
///
/// **Why this approach?**
/// - Day of G1 migration, poka only needs to set the genesis hash
/// - Gecko/Ginkgo connects automatically in ~30 seconds
/// - No need to wait for app store validation or release updates
/// - Users can install app in advance, before migration date
///
/// **Usage example:**
/// ```dart
/// // Check at startup (cache-first, ~1ms if cached)
/// final bool isProduction = await G1GenesisService.initializeAtStartup();
///
/// // In periodic timer (every 30s during app lifecycle in test mode):
/// if (await G1GenesisService.backgroundCheck()) {
///   // State changed: activate or deactivate V2 production mode
///   // Node loading automatically follows via fetchNodesIfNotReady()
/// }
/// ```
class G1GenesisService {
  /// Remote endpoint providing the G1 genesis hash.
  /// Returns JSON: `{"hash": "0x..."}`
  static const String _remoteUrl = 'https://get-g1-genesis-hash.p2p.legal';

  /// SharedPreferences key for caching the genesis hash.
  static const String _cacheKey = 'g1GenesisHash';

  /// Regex pattern for validating genesis hash format.
  /// Must match: `0x` followed by exactly 64 hexadecimal characters (0-9, a-f, A-F).
  static final RegExp _hashPattern = RegExp(r'^0x[0-9a-fA-F]{64}$');

  /// Checks if G1 is ready at application startup.
  /// 1. Checks local cache first (fast path)
  /// 2. If cache empty or invalid, fetches from remote with 5s timeout
  /// 3. Caches valid hash for future startup checks
  ///
  /// **Returns:**
  /// - `true`: Valid G1 genesis hash is available (from cache or network)
  /// - `false`: No valid hash available (cache empty, network down, or invalid format)
  ///
  /// **Performance:**
  /// - Cache hit: ~1ms (no network call)
  /// - Cache miss: ~5-7s (network call with timeout)
  static Future<bool> initializeAtStartup() async {
    // Step 1: Check local cache first (fast path for known state)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedHash = prefs.getString(_cacheKey);
    if (cachedHash != null && _hashPattern.hasMatch(cachedHash)) {
      logger('G1 genesis hash loaded from cache: $cachedHash');
      return true;
    }

    // Step 2: No valid cache → fetch from remote endpoint
    try {
      final String? hash = await _fetchRemoteHash();
      if (hash != null && hash.isNotEmpty && _hashPattern.hasMatch(hash)) {
        // Valid hash received → cache it for faster startup next time
        await prefs.setString(_cacheKey, hash);
        logger('G1 genesis hash fetched from remote and cached: $hash');
        return true;
      }
      // Empty or invalid hash → G1 not ready yet
      logger('G1 genesis hash not available or invalid');
      return false;
    } catch (e) {
      logger('Failed to fetch G1 genesis hash: $e');
      return false;
    }
  }

  /// Background check to detect state changes in G1 production readiness.
  ///
  /// This method should be called periodically (e.g., every 30 seconds) while
  /// the app is in test mode. It detects three types of state changes:
  /// 1. **Hash appeared**: Remote returned valid hash, cache was empty
  /// 2. **Hash changed**: Remote hash differs from cached hash
  /// 3. **Hash disappeared**: Remote returned empty/invalid, cache had valid hash
  ///
  /// **Fail-safe behavior:**
  /// - On network errors, returns `false` and preserves existing cache
  /// - On network timeout (5s), treated as no state change
  /// - Never crashes, always returns a bool result
  ///
  /// **Returns:**
  /// - `true`: State has changed (hash appeared/disappeared/updated)
  ///   → Caller should activate/deactivate V2 production mode
  /// - `false`: No state change detected (same hash or network error)
  ///   → No action needed
  ///
  /// **State transitions:**
  /// ```
  /// Cache: empty    →  Remote: valid hash   → Returns: true
  /// Cache: valid    →  Remote: same hash    → Returns: false
  /// Cache: valid    →  Remote: new hash     → Returns: true
  /// Cache: valid    →  Remote: empty/invalid→ Returns: true
  /// Cache: any      →  Remote: error/timeout→ Returns: false
  /// ```
  static Future<bool> backgroundCheck() async {
    try {
      // Fetch remote hash (returns null only on network errors)
      final String? remoteHash = await _fetchRemoteHash();
      if (remoteHash == null) {
        // Network error → fail-safe: keep cache as-is, no state change
        return false;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? cachedHash = prefs.getString(_cacheKey);

      // Case 1: Remote returned a valid hash different from cache
      if (remoteHash.isNotEmpty &&
          _hashPattern.hasMatch(remoteHash) &&
          remoteHash != cachedHash) {
        // Hash appeared or changed → update cache and signal state change
        await prefs.setString(_cacheKey, remoteHash);
        logger('G1 genesis hash updated from $cachedHash to $remoteHash');
        return true; // Signal caller to activate V2 production mode
      }

      // Case 2: Remote returned empty/invalid hash but we have a cached hash
      if ((remoteHash.isEmpty || !_hashPattern.hasMatch(remoteHash)) &&
          cachedHash != null) {
        // Hash disappeared → clear cache and signal state change
        await prefs.remove(_cacheKey);
        logger('G1 genesis hash reset: remote returned empty/invalid');
        return true; // Signal caller to revert to gtest (test mode)
      }

      // No state change detected
      return false;
    } catch (e) {
      // Should not happen since exceptions are caught in _fetchRemoteHash,
      // but handle gracefully to never crash
      logger('Background G1 genesis check failed: $e');
      return false;
    }
  }

  /// Manually clears the cached genesis hash.
  ///
  /// Useful for:
  /// - Resetting to test mode after successful V2 activation
  /// - Testing/debugging cache behavior
  /// - Force-reverting to gtest if needed
  ///
  /// **Note:** This is destructive and immediately reverts to test mode behavior.
  static Future<void> clearCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    logger('G1 genesis hash cache cleared');
  }

  /// Fetches the genesis hash from the remote endpoint.
  ///
  /// **Return values:**
  /// - **Non-empty string**: Valid or invalid hash from remote (could be empty string)
  /// - **Empty string**: Server returned 200 but no hash in JSON response
  /// - **null**: Network error (timeout, HTTP error, parse error, etc.)
  ///
  /// **Timeout:**
  /// HTTP requests have a 5-second timeout. If the endpoint doesn't respond
  /// within 5 seconds, this method returns null (network error).
  ///
  /// **Expected remote response format:**
  /// ```json
  /// {"hash": "0x1234567890abcdef..."}
  /// ```
  ///
  /// If the hash key is missing or null, an empty string is returned.
  static Future<String?> _fetchRemoteHash() async {
    try {
      // Fetch with 5-second timeout to avoid long waits
      final http.Response response = await http
          .get(Uri.parse(_remoteUrl))
          .timeout(const Duration(seconds: 5));

      // Only handle successful HTTP 200 responses
      if (response.statusCode == 200) {
        // Parse JSON response
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        // Extract hash, defaulting to empty string if missing
        final String hash = (data['hash'] as String?) ?? '';
        return hash;
      }

      // Non-200 HTTP status → treat as network error
      logger('Failed to fetch G1 genesis hash: HTTP ${response.statusCode}');
      return null;
    } catch (e) {
      // Any exception (timeout, parse error, connection error, etc.)
      logger('Network error fetching G1 genesis hash: $e');
      return null;
    }
  }
}
*/
