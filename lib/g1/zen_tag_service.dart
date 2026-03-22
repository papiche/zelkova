import 'dart:convert';

import 'package:http/http.dart' as http;

import '../env.dart';
import '../shared_prefs_helper_v2.dart';
import '../ui/logger.dart';

/// Service to manage the `:ZEN:XXXXXXXX` address suffix that isolates
/// Ẑinckgo wallets from base Ginkgo wallets within a constellation.
///
/// The tag is derived from `UPLANETNAME_G1` — the cooperative central wallet
/// pubkey (uplanet.G1.dunikey), NOT to be confused with UPLANETG1PUB
/// (uplanet.dunikey = swarm identity).
///
/// Addresses displayed in QR codes and clipboard get the suffix appended.
/// The suffix is stripped before payment via `extractPublicKey()`.
class ZenTagService {
  factory ZenTagService() => _instance;
  ZenTagService._internal();
  static final ZenTagService _instance = ZenTagService._internal();

  String? _uplanetnameG1;
  bool _fetching = false;

  /// The cached UPLANETNAME_G1 pubkey (cooperative central wallet).
  String? get uplanetnameG1 => _uplanetnameG1;

  /// The 8-char tag derived from UPLANETNAME_G1.
  /// Returns null if not yet resolved.
  String? get zenTag {
    if (_uplanetnameG1 == null || _uplanetnameG1!.length < 8) return null;
    return _uplanetnameG1!.substring(0, 8);
  }

  /// Whether the ZEN tag is available.
  bool get isAvailable => zenTag != null;

  /// Initialize the service — fetch UPLANETNAME_G1 from MULTIPASS data
  /// or station 12345.json. Safe to call multiple times.
  Future<void> init() async {
    if (_uplanetnameG1 != null && _uplanetnameG1!.isNotEmpty) return;
    if (_fetching) return;
    _fetching = true;

    try {
      // 1. Try MULTIPASS stored data
      final Map<String, dynamic>? data =
          await SharedPreferencesHelperV2().getMultipassData();
      final String fromMultipass =
          data?['uplanetname_g1'] as String? ?? '';
      if (fromMultipass.length >= 8) {
        _uplanetnameG1 = fromMultipass;
        loggerDev('ZenTagService: resolved from MULTIPASS: $zenTag');
        return;
      }

      // 2. Fallback: fetch from station 12345.json
      _uplanetnameG1 = await _fetchFromStation();
      if (isAvailable) {
        loggerDev('ZenTagService: resolved from 12345.json: $zenTag');
      } else {
        loggerDev('ZenTagService: UPLANETNAME_G1 not available');
      }
    } catch (e) {
      loggerDev('ZenTagService: init error: $e');
    } finally {
      _fetching = false;
    }
  }

  /// Fetch UPLANETNAME_G1 from the station's 12345.json.
  /// Convention: UPASSPORT_URL = https://u.{domain}
  ///           → IPFS gateway  = https://ipfs.{domain}
  ///           → 12345.json    = https://ipfs.{domain}/12345/
  Future<String> _fetchFromStation() async {
    try {
      final Uri upassportUri = Uri.parse(Env.upassportUrl);
      final String host = upassportUri.host;
      String ipfsHost;
      if (host.startsWith('u.')) {
        ipfsHost = 'ipfs.${host.substring(2)}';
      } else {
        final List<String> parts = host.split('.');
        if (parts.length >= 2) {
          parts[0] = 'ipfs';
          ipfsHost = parts.join('.');
        } else {
          return '';
        }
      }

      final Uri stationUrl = Uri.https(ipfsHost, '/12345/');
      final http.Response response = await http
          .get(stationUrl)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> stationData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return stationData['UPLANETNAME_G1'] as String? ?? '';
      }
    } catch (e) {
      loggerDev('ZenTagService: station fetch error: $e');
    }
    return '';
  }

  /// Append `:ZEN:XXXXXXXX` suffix to an address for display/QR/clipboard.
  /// Returns the address unchanged if the tag is not available.
  String tagAddress(String address) {
    final String? tag = zenTag;
    // Don't double-tag
    if (address.contains(':ZEN')) return address;

    if (tag == null) {
      return '$address:ZEN';
    }
    return '$address:ZEN:$tag';
  }

  /// Check if an address has a `:ZEN` tag.
  static bool hasZenTag(String address) => address.contains(':ZEN');

  /// Validate that a tagged address matches our constellation's tag.
  /// Returns true if no tag present (permissive) or tag matches.
  bool validateTag(String address) {
    if (!hasZenTag(address)) return true;
    final String? ourTag = zenTag;
    if (ourTag == null) return true; // Can't validate, accept
    
    final int idx = address.indexOf(':ZEN');
    // Handle :ZEN (no tag)
    if (idx + 4 >= address.length) return true;
    
    // Handle :ZEN:TAG
    if (address.length > idx + 5 && address[idx + 4] == ':') {
       final String theirTag = address.substring(idx + 5);
       return theirTag == ourTag;
    }
    
    return true;
  }

  /// Strip `:ZEN:XXXXXXXX` suffix from an address.
  /// This is also done by `extractPublicKey()` which splits on `:`.
  static String stripTag(String address) {
    final int idx = address.indexOf(':ZEN');
    if (idx < 0) return address;
    return address.substring(0, idx);
  }

  /// Set UPLANETNAME_G1 directly (e.g. from API response).
  void setUplanetnameG1(String value) {
    if (value.length >= 8) {
      _uplanetnameG1 = value;
    }
  }
}
