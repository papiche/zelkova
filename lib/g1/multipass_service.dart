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

/// Les données biométriques appartiennent à une autre identité (HTTP 409 IDENTITY_CONFLICT).
class MultipassIdentityConflictException implements Exception {
  const MultipassIdentityConflictException();
  @override
  String toString() => 'IDENTITY_CONFLICT';
}

/// Activation ATOM4LOVE demandée pour un email dont le compte principal
/// n'existe pas encore (HTTP 404 PRIMARY_ACCOUNT_NOT_FOUND).
class Atom4LovePrimaryAccountNotFoundException implements Exception {
  const Atom4LovePrimaryAccountNotFoundException();
  @override
  String toString() => 'PRIMARY_ACCOUNT_NOT_FOUND';
}

/// Échec de l'activation ATOM4LOVE côté serveur (HTTP 500 ACTIVATION_FAILED).
class Atom4LoveActivationFailedException implements Exception {
  const Atom4LoveActivationFailedException([this.message = '']);
  final String message;
  @override
  String toString() => 'ACTIVATION_FAILED: $message';
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

// ── Atom4LoveActivationResponse ───────────────────────────────────────────────

/// Response from the UPassport /g1nostr ATOM4LOVE activation (+a4l email
/// convention). No new MULTIPASS is created — [loveNsec]/[loveNpub]/[loveHex]
/// are a dedicated NOSTR keypair (deterministically derived from the birth
/// data), scoped to the "love" DM channel and the kind 30078 d=atom4love
/// resonance event, distinct from the account's main NOSTR identity.
class Atom4LoveActivationResponse {
  Atom4LoveActivationResponse({
    required this.email,
    required this.loveNsec,
    required this.loveNpub,
    required this.loveHex,
    required this.kinNum,
    required this.personalPhase,
  });

  factory Atom4LoveActivationResponse.fromJson(Map<String, dynamic> json) {
    return Atom4LoveActivationResponse(
      email: json['email'] as String? ?? '',
      loveNsec: json['love_nsec'] as String? ?? '',
      loveNpub: json['love_npub'] as String? ?? '',
      loveHex: json['love_hex'] as String? ?? '',
      kinNum: (json['kin_num'] as num?)?.toInt() ?? 0,
      personalPhase: (json['personal_phase'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final String email;
  final String loveNsec;
  final String loveNpub;
  final String loveHex;
  final int kinNum;
  final double personalPhase;
}

// ── MultipassService ──────────────────────────────────────────────────────────

/// Service to create or recover a MULTIPASS identity via UPassport API
class MultipassService {
  static const Duration _timeout = Duration(seconds: 180);

  /// Derives the ATOM4LOVE second-wallet alias email from the primary
  /// MULTIPASS email, by inserting `+a4l` before the `@`.
  /// e.g. `jean@dom.tld` → `jean+a4l@dom.tld`.
  ///
  /// The server has no knowledge of this convention — it is a totally
  /// independent email/MULTIPASS from its point of view. The link between
  /// the two wallets is tracked client-side only (see [StoredAccount]).
  static String deriveAtom4LoveEmail(String baseEmail) {
    final int at = baseEmail.indexOf('@');
    if (at < 0) {
      return baseEmail;
    }
    return '${baseEmail.substring(0, at)}+a4l${baseEmail.substring(at)}';
  }

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
        Map<String, dynamic>? body409;
        try { body409 = jsonDecode(response.body) as Map<String, dynamic>?; } catch (_) {}
        if ((body409?['error'] as String?) == 'IDENTITY_CONFLICT') {
          throw const MultipassIdentityConflictException();
        }
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

  /// Activate ATOM4LOVE for the existing MULTIPASS behind [email] (the base
  /// email — [deriveAtom4LoveEmail] is applied internally).
  ///
  /// The server detects the `+a4l` convention, verifies the base account
  /// already exists (otherwise throws [Atom4LovePrimaryAccountNotFoundException]),
  /// derives a dedicated NOSTR keypair from the birth data (deterministic —
  /// same inputs always yield the same key), stores the encrypted birth
  /// profile, and publishes the kind 30078 (d=atom4love) resonance event.
  /// No new MULTIPASS/wallet is created.
  static Future<Atom4LoveActivationResponse> activateAtom4Love({
    required String email,
    required String birthDatetime,
    required String birthLat,
    required String birthLon,
    required String birthWeight,
    required String polarity,
    String? birthPlace,
    String? conceptionDatetime,
    String? conceptionPlace,
    String? serverUrl,
  }) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/g1nostr');

    final Map<String, String> body = <String, String>{
      'email': deriveAtom4LoveEmail(email),
      'lang': 'fr',
      'lat': '0.00',
      'lon': '0.00',
      'format': 'json',
      'birth_datetime': birthDatetime,
      'birth_lat': birthLat,
      'birth_lon': birthLon,
      'birth_weight': birthWeight,
      'polarity': polarity,
      if (birthPlace != null && birthPlace.isNotEmpty) 'birth_place': birthPlace,
      if (conceptionDatetime != null && conceptionDatetime.isNotEmpty)
        'conception_datetime': conceptionDatetime,
      if (conceptionPlace != null && conceptionPlace.isNotEmpty)
        'conception_place': conceptionPlace,
    };

    final http.Response response = await http
        .post(uri, body: body)
        .timeout(_timeout);

    Map<String, dynamic>? data;
    try {
      data = jsonDecode(response.body) as Map<String, dynamic>?;
    } catch (_) {}

    switch (response.statusCode) {
      case 200:
        if (data == null) {
          throw const Atom4LoveActivationFailedException('Réponse invalide');
        }
        return Atom4LoveActivationResponse.fromJson(data);
      case 404:
        throw const Atom4LovePrimaryAccountNotFoundException();
      default:
        throw Atom4LoveActivationFailedException(
            data?['message'] as String? ?? 'HTTP ${response.statusCode}');
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
