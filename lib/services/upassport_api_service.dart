import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../g1/nostr/nostr_relay_service.dart';
import '../ui/logger.dart';

/// Represents balance information from UPassport API
class BalanceInfo {

  BalanceInfo({
    required this.g1pub,
    required this.balance,
    this.balanceZencard,
    this.email,
    this.timestamp,
  });

  factory BalanceInfo.fromJson(Map<String, dynamic> json) {
    return BalanceInfo(
      g1pub: json['g1pub'] as String? ?? '',
      balance: json['balance'] as String? ?? '0 Ğ1',
      balanceZencard: json['balance_zencard'] as String?,
      email: json['email'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }
  final String g1pub;
  final String balance;
  final String? balanceZencard;
  final String? email;
  final DateTime? timestamp;
}

/// Represents ZEN Card information
class ZenCardInfo {

  ZenCardInfo({
    required this.email,
    required this.transactions,
    required this.totalShares,
    this.lastUpdated,
  });

  factory ZenCardInfo.fromJson(Map<String, dynamic> json) {
    return ZenCardInfo(
      email: json['email'] as String? ?? '',
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((t) => t as Map<String, dynamic>)
              .toList() ??
          <Map<String, dynamic>>[],
      totalShares: (json['total_shares'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'] as String)
          : null,
    );
  }
  final String email;
  final List<Map<String, dynamic>> transactions;
  final double totalShares;
  final DateTime? lastUpdated;
}

/// Represents a permit credential (Oracle NIP-101)
class PermitCredential {

  PermitCredential({
    required this.id,
    required this.permitId,
    required this.issuerPubKey,
    required this.issuedAt,
    this.expiresAt,
    required this.evidence,
    required this.status,
  });

  factory PermitCredential.fromJson(Map<String, dynamic> json) {
    return PermitCredential(
      id: json['id'] as String? ?? '',
      permitId: json['permit_id'] as String? ?? '',
      issuerPubKey: json['issuer_pub_key'] as String? ?? '',
      issuedAt: DateTime.parse(json['issued_at'] as String),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      evidence: json['evidence'] as Map<String, dynamic>? ?? <String, dynamic>{},
      status: json['status'] as String? ?? 'VALID',
    );
  }
  final String id;
  final String permitId;
  final String issuerPubKey;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final Map<String, dynamic> evidence;
  final String status; // 'VALID', 'EXPIRED', 'REVOKED'
}

/// Represents UMAP geographic information
class UmapInfo {

  UmapInfo({
    required this.pubKey,
    required this.latitude,
    required this.longitude,
    required this.name,
    this.description,
    required this.memberCount,
    required this.lastActivity,
  });

  factory UmapInfo.fromJson(Map<String, dynamic> json) {
    return UmapInfo(
      pubKey: json['pub_key'] as String? ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      name: json['name'] as String? ?? 'Unnamed UMAP',
      description: json['description'] as String?,
      memberCount: json['member_count'] as int? ?? 0,
      lastActivity: DateTime.parse(json['last_activity'] as String),
    );
  }
  final String pubKey;
  final double latitude;
  final double longitude;
  final String name;
  final String? description;
  final int memberCount;
  final DateTime lastActivity;
}

/// Thrown by [UPassportApiService.sendZen] when the station returns HTTP 401,
/// meaning the MULTIPASS is registered on a different station of the swarm.
/// The caller should trigger the SSSS relocation dialog.
class ZenSendRoamingRequiredException implements Exception {
  const ZenSendRoamingRequiredException(this.npub);
  final String npub;

  @override
  String toString() => 'ZenSendRoamingRequiredException: $npub is on a remote station';
}

/// Service to interact with UPassport API (FastAPI)
class UPassportApiService {

  UPassportApiService({String? customUrl, this.nostrPubKey})
      : baseUrl = customUrl ?? Env.upassportUrl;
  final String baseUrl;
  final String? nostrPubKey;

  /// Get balance for a G1 public key or email
  Future<BalanceInfo> getBalance(String identifier) async {
    final Uri url = Uri.parse('$baseUrl/check_balance')
        .replace(queryParameters: <String, dynamic>{'g1pub': identifier, 'format': 'json'});

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return BalanceInfo.fromJson(data);
    } else {
      logger('[UPassportApiService] Failed to get balance: ${response.statusCode}');
      throw Exception('Failed to fetch balance: ${response.statusCode}');
    }
  }

  /// Get ZEN Card information for an email
  Future<ZenCardInfo> getZenCard(String email) async {
    final Uri url = Uri.parse('$baseUrl/check_zencard')
        .replace(queryParameters: <String, dynamic>{'email': email, 'format': 'json'});

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return ZenCardInfo.fromJson(data);
    } else {
      logger('[UPassportApiService] Failed to get ZEN card: ${response.statusCode}');
      throw Exception('Failed to fetch ZEN card: ${response.statusCode}');
    }
  }

  /// Send ZEN tokens with NIP-42 authentication.
  ///
  /// Flow:
  ///   1. Fetch a challenge from UPassport GET /api/nip42/challenge
  ///   2. Publish kind-22242 AUTH event to the NOSTR relay
  ///   3. Wait 800 ms for the station to process the auth marker
  ///   4. POST /zen_send
  ///   5. HTTP 401 → throws [ZenSendRoamingRequiredException] (MULTIPASS on
  ///      another station — caller must show the SSSS relocation dialog)
  ///
  /// [hexPrivateKey] must be the hex-encoded nsec of the sender.
  Future<bool> sendZen({
    required String amount,
    required String sourceG1pub,
    required String destG1pub,
    required String npub,
    required String hexPrivateKey,
  }) async {
    // Step 1 — get NIP-42 challenge
    String challenge = '';
    try {
      challenge = await getNip42Challenge(npub);
    } catch (e) {
      logger('[UPassportApiService] NIP-42 challenge fetch failed: $e');
    }

    // Step 2 — publish kind-22242 to relay
    if (challenge.isNotEmpty) {
      final bool published = await NostrRelayService().publishNip42Auth(
        challenge,
        hexPrivateKey,
      );
      if (!published) {
        logger('[UPassportApiService] NIP-42 AUTH publish failed, continuing anyway');
      }
      // Step 3 — let the station process the auth marker
      await Future<void>.delayed(const Duration(milliseconds: 800));
    }

    // Step 4 — POST zen_send
    final Uri url = Uri.parse('$baseUrl/zen_send');
    final Map<String, String> body = <String, String>{
      'zen': amount,
      'g1source': sourceG1pub,
      'g1dest': destG1pub,
      'npub': npub,
    };

    final http.Response response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data['ok'] as bool? ?? false;
    } else if (response.statusCode == 401) {
      // Step 5 — MULTIPASS is on a remote station: trigger SSSS roaming
      throw ZenSendRoamingRequiredException(npub);
    } else {
      logger('[UPassportApiService] zen_send error ${response.statusCode}: ${response.body}');
      return false;
    }
  }

  /// Get permit credentials for a user (by NOSTR public key)
  Future<List<PermitCredential>> getUserPermits(String npub) async {
    final Uri url = Uri.parse('$baseUrl/api/permit/user/credentials')
        .replace(queryParameters: <String, dynamic>{'npub': npub});

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> credentials = data['credentials'] as List<dynamic>? ?? <dynamic>[];
      return credentials
          .map((c) => PermitCredential.fromJson(c as Map<String, dynamic>))
          .toList();
    } else {
      logger('[UPassportApiService] Failed to get permits: ${response.statusCode}');
      return <PermitCredential>[];
    }
  }

  /// Get nearby UMAPs based on latitude/longitude
  Future<List<UmapInfo>> getNearbyUmaps(
    double lat,
    double lon, {
    double radiusKm = 10.0,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/umap/geolinks')
        .replace(queryParameters: <String, dynamic>{
      'lat': lat.toString(),
      'lon': lon.toString(),
      'radius_km': radiusKm.toString(),
    });

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> umaps = data['umaps'] as List<dynamic>? ?? <dynamic>[];
      return umaps
          .map((u) => UmapInfo.fromJson(u as Map<String, dynamic>))
          .toList();
    } else {
      logger('[UPassportApiService] Failed to get nearby UMAPs: ${response.statusCode}');
      return <UmapInfo>[];
    }
  }

  /// Publish a DID document to NOSTR via UPassport
  Future<bool> publishDidDocument(Map<String, dynamic> doc) async {
    final Uri url = Uri.parse('$baseUrl/api/permit/define');
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(doc),
    );

    return response.statusCode == 200;
  }

  /// Process Open Collective webhook (simulate)
  Future<Map<String, dynamic>> processOcWebhook(Map<String, dynamic> payload) async {
    final Uri url = Uri.parse('$baseUrl/oc_webhook');
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Webhook processing failed: ${response.statusCode}');
    }
  }

  /// Get NIP-42 challenge for authentication
  Future<String> getNip42Challenge(String npub) async {
    final Uri url = Uri.parse('$baseUrl/api/nip42/challenge')
        .replace(queryParameters: <String, dynamic>{'npub': npub});

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data['challenge'] as String? ?? '';
    } else {
      throw Exception('Failed to get NIP-42 challenge');
    }
  }
}