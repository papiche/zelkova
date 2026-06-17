import 'dart:convert';

import 'package:http/http.dart' as http;

import '../env.dart';
import '../ui/logger.dart';

/// Central service for fetching data from Astroport constellation stations.
///
/// The IPFS gateway is derived from UPASSPORT_URL by convention:
///   https://u.{domain} → https://ipfs.{domain}
///
/// Station endpoints served from ~/.zen/tmp/${IPFSNODEID}/:
///   /12345/       → 12345.json  (station state: UPLANETNAME_G1, SWARM, …)
///   /UPLANET/HEX  → secp256k1 hex of UPLANETNAME NOSTR identity
///
/// IMPORTANT — elliptic-curve mismatch:
///   UPLANETNAME_G1 is an Ed25519 key (Ğ1/NaCl/Curve25519).
///   The NOSTR identity is secp256k1 (different mathematical space).
///   They are derived independently by `keygen` and cannot be converted
///   from one to the other.  /UPLANET/HEX provides the correct secp256k1 hex.
class AstroportStationService {
  factory AstroportStationService() => _instance;
  AstroportStationService._internal();
  static final AstroportStationService _instance =
      AstroportStationService._internal();

  String? _cachedUplanetHex;
  String? _cachedNodeHex;

  Map<String, dynamic>? _cachedStationData;
  DateTime? _stationDataFetchedAt;
  static const Duration _stationDataTtl = Duration(minutes: 5);

  /// Derive the IPFS gateway hostname from UPASSPORT_URL.
  /// Returns null when the URL cannot be parsed.
  String? _ipfsHost() {
    try {
      final Uri uri = Uri.parse(Env.upassportUrl);
      final String host = uri.host;
      if (host.startsWith('u.')) {
        return 'ipfs.${host.substring(2)}';
      }
      final List<String> parts = host.split('.');
      if (parts.length < 2) return null;
      parts[0] = 'ipfs';
      return parts.join('.');
    } catch (_) {
      return null;
    }
  }

  /// Fetch the station's 12345.json (cached 5 min).
  ///
  /// Returns the parsed JSON map, or null on network / parse error.
  Future<Map<String, dynamic>?> fetchStationData() async {
    if (_cachedStationData != null && _stationDataFetchedAt != null &&
        DateTime.now().difference(_stationDataFetchedAt!) < _stationDataTtl) {
      return _cachedStationData;
    }
    final String? host = _ipfsHost();
    if (host == null) return null;
    try {
      final http.Response response = await http
          .get(Uri.https(host, '/12345/'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        _cachedStationData =
            jsonDecode(response.body) as Map<String, dynamic>;
        _stationDataFetchedAt = DateTime.now();
        return _cachedStationData;
      }
    } catch (e) {
      loggerDev('AstroportStationService: 12345.json error: $e');
    }
    return null;
  }

  /// Fetch the secp256k1 hex pubkey of the NODE's NOSTR identity (NODEHEX).
  ///
  /// This is the BRO daemon's identity (from ~/.zen/game/secret.nostr).
  /// Published in 12345.json as the "NODEHEX" field.
  /// Zelkova uses this pubkey to send NIP-44 DMs to the BRO AI assistant.
  Future<String?> fetchNodeHex() async {
    if (_cachedNodeHex != null) return _cachedNodeHex;
    final Map<String, dynamic>? data = await fetchStationData();
    if (data != null) {
      final String? hex = data['NODEHEX'] as String?;
      if (hex != null && hex.length == 64) {
        _cachedNodeHex = hex;
        loggerDev('AstroportStationService: NODEHEX → ${hex.substring(0, 8)}…');
        return hex;
      }
    }
    return null;
  }

  /// Fetch the secp256k1 hex pubkey of UPLANETNAME's NOSTR identity.
  ///
  /// Written by UPLANET.refresh.sh:
  ///   keygen -t nostr "${UPLANETNAME}" "${UPLANETNAME}" | nostr2hex.py \
  ///     > ~/.zen/tmp/${IPFSNODEID}/UPLANET/HEX
  ///
  /// This key publishes the station's kind-0 profile (display identity).
  /// Cached in memory after the first successful fetch.
  Future<String?> fetchUplanetHex() async {
    if (_cachedUplanetHex != null) return _cachedUplanetHex;
    return _fetchHexFile('/UPLANET/HEX', 'UPLANET/HEX').then((String? v) {
      _cachedUplanetHex = v;
      return v;
    });
  }

  String? _cachedUplanetG1Hex;

  /// Fetch the secp256k1 hex pubkey of the cooperative config NOSTR identity.
  ///
  /// Written by UPLANET.refresh.sh (adjacent to UPLANET/HEX):
  ///   keygen -t nostr "${UPLANETNAME}.G1" "${UPLANETNAME}.G1" | nostr2hex.py \
  ///     > ~/.zen/tmp/${IPFSNODEID}/UPLANET/G1HEX
  ///
  /// This key publishes kind 30800 d="cooperative-config" events that contain
  /// the Open Collective contribution URLs (OC_URL_CLOUD, OC_URL_MEMBRE,
  /// OC_URL_SATELLITE, OC_URL_CONSTELLATION) and other cooperative ENV data.
  ///
  /// IMPORTANT — not derivable from UPLANETNAME_G1 (Ed25519/Curve25519):
  ///   UPLANETNAME_G1 and this key live in different elliptic-curve spaces.
  ///   They are produced independently by `keygen` with different seeds.
  Future<String?> fetchUplanetG1Hex() async {
    if (_cachedUplanetG1Hex != null) return _cachedUplanetG1Hex;
    return _fetchHexFile('/UPLANET/G1HEX', 'UPLANET/G1HEX').then((String? v) {
      _cachedUplanetG1Hex = v;
      return v;
    });
  }

  /// Internal helper — fetch a single-line 64-char hex file from the station.
  Future<String?> _fetchHexFile(String path, String label) async {
    final String? host = _ipfsHost();
    if (host == null) return null;
    try {
      final http.Response response = await http
          .get(Uri.https(host, path))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final String hex = response.body.trim();
        if (hex.length == 64) {
          loggerDev('AstroportStationService: $label → ${hex.substring(0, 8)}…');
          return hex;
        }
      }
    } catch (e) {
      loggerDev('AstroportStationService: $label error: $e');
    }
    return null;
  }

  /// Clear cached values (e.g. after a station change).
  void clearCache() {
    _cachedUplanetHex = null;
    _cachedUplanetG1Hex = null;
    _cachedNodeHex = null;
    _cachedStationData = null;
    _stationDataFetchedAt = null;
  }
}
