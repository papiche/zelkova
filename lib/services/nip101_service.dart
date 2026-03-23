import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';
import '../g1/nostr/nostr_relay_service.dart';
import '../g1/nostr/nostr_utils.dart';
import '../ui/logger.dart';

/// DID Document according to NIP-101 kind 30800
class DIDDocument {
  final String id; // did:nostr:<hex_pubkey>
  final Map<String, dynamic> document;
  final String pubKey;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DIDDocument({
    required this.id,
    required this.document,
    required this.pubKey,
    required this.createdAt,
    this.updatedAt,
  });

  factory DIDDocument.fromJson(Map<String, dynamic> json) {
    return DIDDocument(
      id: json['id'] as String? ?? '',
      document: json['document'] as Map<String, dynamic>? ?? {},
      pubKey: json['pubkey'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document': document,
      'pubkey': pubKey,
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}

/// Permit Definition (kind 30500)
class PermitDefinition {
  final String id;
  final String name;
  final String description;
  final List<String> requirements;
  final String issuerPubKey;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final Map<String, dynamic> metadata;

  PermitDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.requirements,
    required this.issuerPubKey,
    required this.createdAt,
    this.expiresAt,
    required this.metadata,
  });

  factory PermitDefinition.fromJson(Map<String, dynamic> json) {
    return PermitDefinition(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      requirements: (json['requirements'] as List<dynamic>?)
              ?.map((r) => r.toString())
              .toList() ??
          [],
      issuerPubKey: json['issuer_pub_key'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// Permit Request (kind 30501)
class PermitRequest {
  final String id;
  final String permitId;
  final String applicantPubKey;
  final Map<String, dynamic> evidence;
  final DateTime requestedAt;
  final String status; // 'PENDING', 'APPROVED', 'REJECTED'

  PermitRequest({
    required this.id,
    required this.permitId,
    required this.applicantPubKey,
    required this.evidence,
    required this.requestedAt,
    required this.status,
  });

  factory PermitRequest.fromJson(Map<String, dynamic> json) {
    return PermitRequest(
      id: json['id'] as String? ?? '',
      permitId: json['permit_id'] as String? ?? '',
      applicantPubKey: json['applicant_pub_key'] as String? ?? '',
      evidence: json['evidence'] as Map<String, dynamic>? ?? {},
      requestedAt: DateTime.parse(json['requested_at'] as String),
      status: json['status'] as String? ?? 'PENDING',
    );
  }
}

/// Geographic query for events
class GeoQuery {
  final double latitude;
  final double longitude;
  final double radiusKm;
  final List<int>? kinds;
  final int? since;
  final int? until;
  final int? limit;

  GeoQuery({
    required this.latitude,
    required this.longitude,
    required this.radiusKm,
    this.kinds,
    this.since,
    this.until,
    this.limit = 50,
  });
}

/// Service for NIP-101 functionality (DIDs, Oracle, ORE, GeoKeys)
class Nip101Service {
  final NostrRelayService _relayService;

  Nip101Service(this._relayService);

  /// Resolve a DID (did:nostr:<hex>) to a DID Document
  Future<DIDDocument?> resolveDid(String did) async {
    // Extract hex pubkey from DID
    final String? hexPubKey = _extractHexFromDid(did);
    if (hexPubKey == null) return null;

    // Query kind 30800 events from the author
    final List<Map<String, dynamic>> events = await _queryEvents(
      kinds: [30800],
      authors: [hexPubKey],
      limit: 1,
    );

    if (events.isEmpty) return null;

    final Map<String, dynamic> event = events.first;
    try {
      final Map<String, dynamic> content =
          jsonDecode(event['content'] as String) as Map<String, dynamic>;
      return DIDDocument(
        id: did,
        document: content,
        pubKey: hexPubKey,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (event['created_at'] as int) * 1000),
        updatedAt: null,
      );
    } catch (e) {
      logger('[Nip101Service] Failed to parse DID document: $e');
      return null;
    }
  }

  /// Publish a DID Document (kind 30800)
  Future<bool> publishDidDocument(DIDDocument doc, String hexPrivateKey) async {
    final String hexPubKey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final Map<String, dynamic> event = {
      'kind': 30800,
      'pubkey': hexPubKey,
      'created_at': createdAt,
      'tags': [
        ['d', doc.id],
        ['t', 'did'],
      ],
      'content': jsonEncode(doc.document),
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    return _relayService.publishEvent(event);
  }

  /// Get available permit definitions (kind 30500)
  Future<List<PermitDefinition>> getPermitDefinitions({
    String? issuerPubKey,
    int limit = 20,
  }) async {
    final List<Map<String, dynamic>> events = await _queryEvents(
      kinds: [30500],
      authors: issuerPubKey != null ? [issuerPubKey] : null,
      limit: limit,
    );

    return events.map((event) {
      try {
        final Map<String, dynamic> content =
            jsonDecode(event['content'] as String) as Map<String, dynamic>;
        return PermitDefinition(
          id: content['id'] as String? ?? '',
          name: content['name'] as String? ?? '',
          description: content['description'] as String? ?? '',
          requirements: (content['requirements'] as List<dynamic>?)
                  ?.map((r) => r.toString())
                  .toList() ??
              [],
          issuerPubKey: event['pubkey'] as String,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              (event['created_at'] as int) * 1000),
          expiresAt: content['expires_at'] != null
              ? DateTime.parse(content['expires_at'] as String)
              : null,
          metadata: content['metadata'] as Map<String, dynamic>? ?? {},
        );
      } catch (e) {
        logger('[Nip101Service] Failed to parse permit definition: $e');
        return PermitDefinition(
          id: '',
          name: 'Invalid',
          description: 'Failed to parse',
          requirements: [],
          issuerPubKey: event['pubkey'] as String,
          createdAt: DateTime.now(),
          metadata: {},
        );
      }
    }).where((def) => def.id.isNotEmpty).toList();
  }

  /// Apply for a permit (kind 30501)
  Future<bool> applyForPermit(
    String permitId,
    Map<String, dynamic> evidence, {
    required String hexPrivateKey,
  }) async {
    final String hexPubKey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final Map<String, dynamic> content = {
      'permit_id': permitId,
      'applicant_pub_key': hexPubKey,
      'evidence': evidence,
      'requested_at': createdAt,
      'status': 'PENDING',
    };

    final Map<String, dynamic> event = {
      'kind': 30501,
      'pubkey': hexPubKey,
      'created_at': createdAt,
      'tags': [
        ['p', hexPubKey], // Applicant
        ['t', 'permit_request'],
        ['permit', permitId],
      ],
      'content': jsonEncode(content),
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    return _relayService.publishEvent(event);
  }

  /// Attest a permit (kind 30502) - for issuers
  Future<bool> attestPermit(
    String applicantPubKey,
    String permitId, {
    required String issuerPrivateKey,
    Map<String, dynamic>? metadata,
  }) async {
    final String issuerPubKey = bip340.getPublicKey(issuerPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final Map<String, dynamic> content = {
      'permit_id': permitId,
      'applicant_pub_key': applicantPubKey,
      'issuer_pub_key': issuerPubKey,
      'attested_at': createdAt,
      'metadata': metadata ?? {},
    };

    final Map<String, dynamic> event = {
      'kind': 30502,
      'pubkey': issuerPubKey,
      'created_at': createdAt,
      'tags': [
        ['p', applicantPubKey],
        ['p', issuerPubKey],
        ['t', 'permit_attestation'],
        ['permit', permitId],
      ],
      'content': jsonEncode(content),
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, issuerPrivateKey);

    return _relayService.publishEvent(event);
  }

  /// Get local events with geographic filtering (using NIP-?? geohash)
  Future<List<Map<String, dynamic>>> getLocalEvents(GeoQuery query) async {
    // Note: This requires relay support for geographic filters
    // For now, we query all events and filter client-side
    final List<Map<String, dynamic>> events = await _queryEvents(
      kinds: query.kinds,
      since: query.since,
      until: query.until,
      limit: query.limit,
    );

    // Filter by distance (simplistic)
    return events.where((event) {
      final double? lat = _extractLatitude(event);
      final double? lon = _extractLongitude(event);
      if (lat == null || lon == null) return false;

      final double distance = _calculateDistance(
        query.latitude,
        query.longitude,
        lat,
        lon,
      );
      return distance <= query.radiusKm;
    }).toList();
  }

  /// Query events using the relay service
  Future<List<Map<String, dynamic>>> _queryEvents({
    List<int>? kinds,
    List<String>? authors,
    int? since,
    int? until,
    int? limit,
  }) async {
    return _relayService.queryEvents(
      kinds: kinds,
      authors: authors,
      since: since,
      until: until,
      limit: limit,
    );
  }

  /// Sign an event with private key
  String _signEvent(String eventId, String hexPrivateKey) {
    // Generate random auxRand as in NostrRelayService
    final Uint8List auxRandBytes = Uint8List.fromList(
      List<int>.generate(32, (_) => DateTime.now().microsecond % 256),
    );
    final String auxRandHex = HEX.encode(auxRandBytes);
    return bip340.sign(hexPrivateKey, eventId, auxRandHex);
  }

  /// Extract hex pubkey from DID string
  String? _extractHexFromDid(String did) {
    final RegExp regex = RegExp(r'^did:nostr:([a-fA-F0-9]+)$');
    final Match? match = regex.firstMatch(did);
    return match?.group(1);
  }

  /// Extract latitude from event tags
  double? _extractLatitude(Map<String, dynamic> event) {
    final List<dynamic> tags = event['tags'] as List<dynamic>? ?? [];
    for (final tag in tags) {
      if (tag is List<dynamic> && tag.length >= 2) {
        if (tag[0] == 'g') {
          final String geohash = tag[1] as String;
          // Parse geohash to lat/lon (simplistic)
          try {
            final List<String> parts = geohash.split(',');
            if (parts.length >= 2) {
              return double.parse(parts[0]);
            }
          } catch (_) {}
        }
      }
    }
    return null;
  }

  /// Extract longitude from event tags
  double? _extractLongitude(Map<String, dynamic> event) {
    final List<dynamic> tags = event['tags'] as List<dynamic>? ?? [];
    for (final tag in tags) {
      if (tag is List<dynamic> && tag.length >= 2) {
        if (tag[0] == 'g') {
          final String geohash = tag[1] as String;
          try {
            final List<String> parts = geohash.split(',');
            if (parts.length >= 2) {
              return double.parse(parts[1]);
            }
          } catch (_) {}
        }
      }
    }
    return null;
  }

  /// Calculate distance between two points using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // km
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180);
  }
}