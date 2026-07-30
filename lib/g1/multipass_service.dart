import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../ui/logger.dart';
import 'nostr/nostr_keys.dart';
import 'nostr/nostr_utils.dart';

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
    required this.pass,
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
      pass: json['pass'] as String? ?? '',
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

  /// Code PASS (PIN court) reçu dès la création du MULTIPASS — sert à
  /// récupérer le compte (voir [MultipassService.createMultipass] `passCode`)
  /// sur n'importe quel terminal UPlanet, même une fois la ZEN Card créée.
  final String pass;
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

/// Response from UPassport `POST /atom4love/activate`. No new MULTIPASS is
/// created — [loveNsec]/[loveNpub]/[loveHex]
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

  /// Create a new MULTIPASS or recover an existing one via UPassport /g1nostr.
  ///
  /// **New MULTIPASS** (email unknown to server): creates all keys and returns JSON.
  ///
  /// **Existing MULTIPASS** (email known to server):
  /// - Without [passCode] → throws [MultipassExistsException] (HTTP 409)
  /// - With correct [passCode] → returns existing MULTIPASS JSON (HTTP 200)
  /// - With wrong [passCode]   → throws [MultipassInvalidPassException] (HTTP 401)
  ///
  /// Zelkova never sends birth/salt/pepper data here: the server always
  /// generates a random identity for a new MULTIPASS. The birth profile
  /// (ATOM4LOVE) is requested separately, after MULTIPASS creation, via
  /// [activateAtom4Love].
  static Future<MultipassResponse> createMultipass({
    required String email,
    required String lang,
    required String lat,
    required String lon,
    String? passCode,
    String? serverUrl,
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

  /// Activate ATOM4LOVE for the existing MULTIPASS behind [email].
  ///
  /// Authenticates via NIP-42: fetches a single-use challenge scoped to the
  /// account's main NOSTR pubkey (`GET /atom4love/challenge`), signs a kind
  /// 22242 event with [primaryNsec] (the account's own key, never sent to
  /// the server), then submits it as proof of ownership to
  /// `POST /atom4love/activate`. Replaces the removed `+a4l@` email
  /// convention, which had no ownership check at all.
  ///
  /// The server derives a dedicated NOSTR keypair from the birth data
  /// (deterministic — same inputs always yield the same key), stores the
  /// encrypted birth profile, and publishes the kind 30078 (d=atom4love)
  /// resonance event. No new MULTIPASS/wallet is created.
  static Future<Atom4LoveActivationResponse> activateAtom4Love({
    required String email,
    required String primaryNsec,
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

    // Étape 1 — challenge NIP-42 scopé à la clé principale du compte.
    final Uri challengeUri = Uri.parse('$baseUrl/atom4love/challenge')
        .replace(queryParameters: <String, String>{'email': email});
    final http.Response challengeResponse =
        await http.get(challengeUri).timeout(_timeout);
    if (challengeResponse.statusCode == 404) {
      throw const Atom4LovePrimaryAccountNotFoundException();
    }
    if (challengeResponse.statusCode != 200) {
      throw Atom4LoveActivationFailedException(
          'Challenge indisponible (${challengeResponse.statusCode})');
    }
    final String challenge = (jsonDecode(challengeResponse.body)
        as Map<String, dynamic>)['challenge'] as String;

    // Étape 2 — signer un event kind 22242 (NIP-42) avec le nsec principal.
    final String hexPrivKey = NostrKeys.nsecToHex(primaryNsec);
    final String hexPubKey = bip340.getPublicKey(hexPrivKey);
    final Map<String, dynamic> authEvent = <String, dynamic>{
      'kind': 22242,
      'pubkey': hexPubKey,
      'created_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'tags': <List<String>>[
        <String>['challenge', challenge],
      ],
      'content': '',
    };
    final String eventId = NostrUtils.calculateEventId(authEvent);
    authEvent['id'] = eventId;
    authEvent['sig'] = _signNip42Event(eventId, hexPrivKey);

    // Étape 3 — activation, preuve de possession via l'event signé.
    final Uri activateUri = Uri.parse('$baseUrl/atom4love/activate');
    final Map<String, String> body = <String, String>{
      'email': email,
      'birth_datetime': birthDatetime,
      'birth_lat': birthLat,
      'birth_lon': birthLon,
      'birth_weight': birthWeight,
      'polarity': polarity,
      'auth_event': jsonEncode(authEvent),
      if (birthPlace != null && birthPlace.isNotEmpty) 'birth_place': birthPlace,
      if (conceptionDatetime != null && conceptionDatetime.isNotEmpty)
        'conception_datetime': conceptionDatetime,
      if (conceptionPlace != null && conceptionPlace.isNotEmpty)
        'conception_place': conceptionPlace,
    };

    final http.Response response = await http
        .post(activateUri, body: body)
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

  static String _signNip42Event(String eventIdHex, String hexPrivateKey) {
    final Random rng = Random.secure();
    final Uint8List aux = Uint8List.fromList(
        List<int>.generate(32, (int _) => rng.nextInt(256)));
    return bip340.sign(hexPrivateKey, eventIdHex, HEX.encode(aux));
  }

  /// Fetch the dedicated ATOM4LOVE hex pubkey (HEX_LOVE) for [email].
  ///
  /// `GET /atom4love/dream` returns `love_hex` at the top level or nested
  /// under `dream_vector`, depending on whether a resonance profile was
  /// already published — see UPassport routers/identity.py::get_atom4love_dream.
  /// Same endpoint used by UPlanet/earth's atomic_chat.html to address the
  /// LOVE channel, so both clients target the exact same recipient.
  ///
  /// Returns null if ATOM4LOVE isn't activated yet (HTTP 404) or on error —
  /// callers should fall back to [activateAtom4Love] via [WalletCreationScreen].
  static Future<String?> fetchLoveHex(String email, {String? serverUrl}) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/atom4love/dream')
        .replace(queryParameters: <String, String>{'email': email});
    try {
      final http.Response response = await http.get(uri).timeout(_timeout);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final String? loveHex = data['love_hex'] as String? ??
          (data['dream_vector']
              as Map<String, dynamic>?)?['love_hex'] as String?;
      return (loveHex != null && loveHex.length == 64) ? loveHex : null;
    } catch (e) {
      loggerDev('[MultipassService] fetchLoveHex error: $e');
      return null;
    }
  }

  /// Fetch the Ğ1-N² (Ẑen display) balance for a given hex pubkey — typically
  /// a LOVE identity (`HEX_LOVE`). Public, no-auth endpoint (see UPassport
  /// routers/finance.py::g1n2_balance). Returns null on error or if the
  /// server response is malformed; a hex with no history returns 0.0, not null.
  static Future<double?> fetchG1n2Balance(String hex, {String? serverUrl}) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/api/g1n2/balance')
        .replace(queryParameters: <String, String>{'hex': hex});
    try {
      final http.Response response = await http.get(uri).timeout(_timeout);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final num? zen = data['zen'] as num?;
      return zen?.toDouble();
    } catch (e) {
      loggerDev('[MultipassService] fetchG1n2Balance error: $e');
      return null;
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
