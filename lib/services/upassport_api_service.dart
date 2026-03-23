import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../ui/logger.dart';

/// Represents balance information from UPassport API
class BalanceInfo {
  final String g1pub;
  final String balance;
  final String? balanceZencard;
  final String? email;
  final DateTime? timestamp;

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
}

/// Represents ZEN Card information
class ZenCardInfo {
  final String email;
  final List<Map<String, dynamic>> transactions;
  final double totalShares;
  final DateTime? lastUpdated;

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
          [],
      totalShares: (json['total_shares'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'] as String)
          : null,
    );
  }
}

/// Represents a permit credential (Oracle NIP-101)
class PermitCredential {
  final String id;
  final String permitId;
  final String issuerPubKey;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final Map<String, dynamic> evidence;
  final String status; // 'VALID', 'EXPIRED', 'REVOKED'

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
      evidence: json['evidence'] as Map<String, dynamic>? ?? {},
      status: json['status'] as String? ?? 'VALID',
    );
  }
}

/// Represents UMAP geographic information
class UmapInfo {
  final String pubKey;
  final double latitude;
  final double longitude;
  final String name;
  final String? description;
  final int memberCount;
  final DateTime lastActivity;

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
}

/// Service to interact with UPassport API (FastAPI)
class UPassportApiService {
  final String baseUrl;
  final String? nostrPubKey; // For NIP-42 authentication

  UPassportApiService({String? customUrl, this.nostrPubKey})
      : baseUrl = customUrl ?? Env.upassportUrl;

  /// Get balance for a G1 public key or email
  Future<BalanceInfo> getBalance(String identifier) async {
    final Uri url = Uri.parse('$baseUrl/check_balance')
        .replace(queryParameters: {'g1pub': identifier, 'format': 'json'});

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
        .replace(queryParameters: {'email': email, 'format': 'json'});

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

  /// Send ZEN tokens (requires NIP-42 authentication)
  Future<bool> sendZen({
    required String amount,
    required String sourceG1pub,
    required String destG1pub,
    required String npub,
  }) async {
    final Uri url = Uri.parse('$baseUrl/zen_send');
    final Map<String, String> body = {
      'zen': amount,
      'g1source': sourceG1pub,
      'g1dest': destG1pub,
      'npub': npub,
    };

    final http.Response response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data['success'] as bool? ?? false;
    } else {
      logger('[UPassportApiService] Failed to send ZEN: ${response.statusCode}');
      return false;
    }
  }

  /// Get permit credentials for a user (by NOSTR public key)
  Future<List<PermitCredential>> getUserPermits(String npub) async {
    final Uri url = Uri.parse('$baseUrl/api/permit/user/credentials')
        .replace(queryParameters: {'npub': npub});

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> credentials = data['credentials'] as List<dynamic>? ?? [];
      return credentials
          .map((c) => PermitCredential.fromJson(c as Map<String, dynamic>))
          .toList();
    } else {
      logger('[UPassportApiService] Failed to get permits: ${response.statusCode}');
      return [];
    }
  }

  /// Get nearby UMAPs based on latitude/longitude
  Future<List<UmapInfo>> getNearbyUmaps(
    double lat,
    double lon, {
    double radiusKm = 10.0,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/umap/geolinks')
        .replace(queryParameters: {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'radius_km': radiusKm.toString(),
    });

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> umaps = data['umaps'] as List<dynamic>? ?? [];
      return umaps
          .map((u) => UmapInfo.fromJson(u as Map<String, dynamic>))
          .toList();
    } else {
      logger('[UPassportApiService] Failed to get nearby UMAPs: ${response.statusCode}');
      return [];
    }
  }

  /// Publish a DID document to NOSTR via UPassport
  Future<bool> publishDidDocument(Map<String, dynamic> doc) async {
    final Uri url = Uri.parse('$baseUrl/api/permit/define');
    final Map<String, String> headers = {
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
    final Map<String, String> headers = {
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
        .replace(queryParameters: {'npub': npub});

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