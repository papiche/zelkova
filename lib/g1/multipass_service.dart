import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../env.dart';
import '../ui/logger.dart';

// ── Typed exceptions ──────────────────────────────────────────────────────────

/// L'email est déjà enregistré — l'API demande le code PASS (HTTP 409).
class MultipassExistsException implements Exception {
  const MultipassExistsException();
  @override
  String toString() => 'MULTIPASS_EXISTS';
}

/// Le code PASS fourni est incorrect (HTTP 401).
class MultipassInvalidPassException implements Exception {
  const MultipassInvalidPassException();
  @override
  String toString() => 'INVALID_PASS';
}

/// Le fichier .pass est absent sur ce nœud (HTTP 503).
class MultipassPassUnavailableException implements Exception {
  const MultipassPassUnavailableException();
  @override
  String toString() => 'PASS_UNAVAILABLE';
}

// ── OcUrls ────────────────────────────────────────────────────────────────────

/// OC contribution URLs returned by the server
class OcUrls {
  OcUrls({
    this.satellite = '',
    this.constellation = '',
    this.cloud = '',
    this.membre = '',
  });

  factory OcUrls.fromJson(Map<String, dynamic>? json) {
    if (json == null) return OcUrls();
    return OcUrls(
      satellite: json['satellite'] as String? ?? '',
      constellation: json['constellation'] as String? ?? '',
      cloud: json['cloud'] as String? ?? '',
      membre: json['membre'] as String? ?? '',
    );
  }

  final String satellite;
  final String constellation;
  final String cloud;
  final String membre;
}

// ── MultipassResponse ─────────────────────────────────────────────────────────

/// Response from the UPassport /g1nostr MULTIPASS creation endpoint
class MultipassResponse {
  MultipassResponse({
    required this.email,
    required this.salt,
    required this.pepper,
    required this.nsec,
    required this.g1pub,
    required this.npub,
    required this.hex,
    required this.nostrns,
    required this.lat,
    required this.lon,
    required this.ssssPlayer,
    required this.isOrigin,
    required this.ocUrls,
    required this.uplanetHome,
    required this.uplanetnameG1,
  });

  factory MultipassResponse.fromJson(Map<String, dynamic> json) {
    return MultipassResponse(
      email: json['email'] as String? ?? '',
      salt: json['salt'] as String? ?? '',
      pepper: json['pepper'] as String? ?? '',
      nsec: json['nsec'] as String? ?? '',
      g1pub: json['g1pub'] as String? ?? '',
      npub: json['npub'] as String? ?? '',
      hex: json['hex'] as String? ?? '',
      nostrns: json['nostrns'] as String? ?? '',
      lat: json['lat'] as String? ?? '',
      lon: json['lon'] as String? ?? '',
      ssssPlayer: (json['ssss'] ?? json['ssss_player']) as String? ?? '',
      isOrigin: json['is_origin'] as bool? ?? false,
      ocUrls: OcUrls.fromJson(json['oc_urls'] as Map<String, dynamic>?),
      uplanetHome: json['uplanet_home'] as String? ?? '',
      uplanetnameG1: json['uplanetname_g1'] as String? ?? '',
    );
  }

  final String email;
  final String salt;
  final String pepper;
  final String nsec;
  final String g1pub;
  final String npub;
  final String hex;
  final String nostrns;
  final String lat;
  final String lon;
  final String ssssPlayer;
  final bool isOrigin;
  final OcUrls ocUrls;
  final String uplanetHome;
  final String uplanetnameG1;
}

// ── MultipassService ──────────────────────────────────────────────────────────

/// Service to create or recover a MULTIPASS identity via UPassport API
class MultipassService {
  static const Duration _timeout = Duration(seconds: 60);

  /// Create a new MULTIPASS or recover an existing one via UPassport /g1nostr.
  ///
  /// **New MULTIPASS** (email unknown to server): creates all keys and returns JSON.
  ///
  /// **Existing MULTIPASS** (email known to server):
  /// - Without [passCode] → throws [MultipassExistsException] (HTTP 409)
  /// - With correct [passCode] → returns existing MULTIPASS JSON (HTTP 200)
  /// - With wrong [passCode]   → throws [MultipassInvalidPassException] (HTTP 401)
  ///
  /// **ATOMIC birth profile** (optional): if [birthDatetime] is provided,
  /// the server stores it for Dreamspell/ondulatory profiling.
  /// Format: `"YYYY-MM-DDTHH:MM"` (ISO 8601, local time of birth place).
  static Future<MultipassResponse> createMultipass({
    required String email,
    required String lang,
    required String lat,
    required String lon,
    String? passCode,
    String? serverUrl,
    // ATOMIC birth/conception profile (optional)
    String? birthDatetime,
    String? conceptionDatetime,
    String? birthPlace,
    String? conceptionPlace,
    String? birthWeight,
    // Clés PBKDF2-SHA256 dérivées côté client (base64url 43 chars)
    String? salt,
    String? pepper,
  }) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/g1nostr');

    final Map<String, String> body = <String, String>{
      'email': email,
      'lang': lang,
      'lat': lat,
      'lon': lon,
      'format': 'json',
      if (passCode != null && passCode.isNotEmpty) 'pass_code': passCode,
      if (salt != null && salt.isNotEmpty) 'salt': salt,
      if (pepper != null && pepper.isNotEmpty) 'pepper': pepper,
      if (birthDatetime != null && birthDatetime.isNotEmpty)
        'birth_datetime': birthDatetime,
      if (conceptionDatetime != null && conceptionDatetime.isNotEmpty)
        'conception_datetime': conceptionDatetime,
      if (birthPlace != null && birthPlace.isNotEmpty)
        'birth_place': birthPlace,
      if (conceptionPlace != null && conceptionPlace.isNotEmpty)
        'conception_place': conceptionPlace,
      if (birthWeight != null && birthWeight.isNotEmpty)
        'birth_weight': birthWeight,
    };

    final http.Response response = await http
        .post(uri, body: body)
        .timeout(_timeout);

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        return MultipassResponse.fromJson(data);
      case 401:
        throw const MultipassInvalidPassException();
      case 409:
        throw const MultipassExistsException();
      case 503:
        throw const MultipassPassUnavailableException();
      default:
        Map<String, dynamic>? errMap;
        try {
          errMap = jsonDecode(response.body) as Map<String, dynamic>?;
        } catch (_) {}
        final String msg = errMap?['error'] as String?
            ?? errMap?['detail'] as String?
            ?? 'MULTIPASS creation failed (${response.statusCode})';
        throw Exception(msg);
    }
  }

  /// Upload a profile image (avatar/banner) to the UPassport API.
  ///
  /// Returns the IPFS URL (or local fallback URL) of the uploaded image,
  /// or null on failure.
  static Future<String?> uploadImage({
    required String npub,
    required Uint8List imageBytes,
    required String imageType, // 'avatar', 'banner', 'logo'
    String filename = 'image.jpg',
    String? serverUrl,
  }) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/api/upload/image');
    loggerDev('[API] POST $uri type=$imageType filename=$filename');

    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..fields['npub'] = npub
      ..fields['type'] = imageType
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: filename,
      ));

    try {
      final http.StreamedResponse streamedResponse =
          await request.send().timeout(_timeout);
      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        final String? ipfsUrl = data['ipfs_url'] as String?;
        final String? localUrl = data['local_url'] as String?;
        if (ipfsUrl != null && ipfsUrl.isNotEmpty) {
          loggerDev('[API] Upload OK → $ipfsUrl');
          return ipfsUrl;
        }
        if (localUrl != null && localUrl.isNotEmpty) {
          loggerDev('[API] Upload OK (local) → $localUrl');
          return '$baseUrl$localUrl';
        }
        return data['url'] as String?;
      }
      loggerDev('[API] Upload failed: ${response.statusCode} ${response.body}');
    } catch (e) {
      loggerDev('[API] Upload error: $e');
    }
    return null;
  }
}
