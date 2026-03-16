import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../ui/logger.dart';
import 'nostr_profile.dart';
import 'nostr_utils.dart';
import 'station_economy_event.dart';

/// NOSTR relay service for Ginkgo.
///
/// Handles WebSocket connection to strfry relay (port 7777),
/// profile fetch/publish (kind 0), and contact list (kind 3).
/// Adapted from TrocZen's NostrConnectionService + NostrService.
class NostrRelayService {

  factory NostrRelayService() => _instance;

  NostrRelayService._internal();
  static final NostrRelayService _instance = NostrRelayService._internal();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  bool _isConnected = false;
  String? _currentRelayUrl;

  // Subscription handlers for REQ/EVENT routing
  final Map<String, void Function(List<dynamic>)> _handlers = <String, void Function(List<dynamic>)>{};
  final Map<String, Completer<bool>> _publishCompleters = <String, Completer<bool>>{};

  // Reconnection
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;

  // Public state
  bool get isConnected => _isConnected;
  String? get currentRelay => _currentRelayUrl;

  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();
  Stream<bool> get onConnectionChange => _connectionController.stream;

  /// Connect to a NOSTR relay via WebSocket
  Future<bool> connect(String relayUrl) async {
    if (_isConnected && _currentRelayUrl == relayUrl) return true;

    await forceDisconnect();

    try {
      final Uri uri = Uri.parse(relayUrl);
      // Use WebSocketChannel.connect() — works on both web and native
      _channel = WebSocketChannel.connect(uri);
      // Wait for the connection to be ready (throws on failure)
      await _channel!.ready.timeout(const Duration(seconds: 10));
      _currentRelayUrl = relayUrl;

      _subscription = _channel!.stream.listen(
        _handleMessage,
        onError: (dynamic error) {
          loggerDev('[NostrRelay] WebSocket error: $error');
          _isConnected = false;
          _connectionController.add(false);
          _scheduleReconnect();
        },
        onDone: () {
          _isConnected = false;
          _connectionController.add(false);
          _scheduleReconnect();
        },
      );

      _isConnected = true;
      _reconnectAttempts = 0;
      _connectionController.add(true);
      loggerDev('[NostrRelay] Connected to $relayUrl');
      return true;
    } catch (e) {
      loggerDev('[NostrRelay] Connection failed: $e');
      _isConnected = false;
      _connectionController.add(false);
      _scheduleReconnect();
      return false;
    }
  }

  /// Force disconnect
  Future<void> forceDisconnect() async {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;

    await _subscription?.cancel();
    _subscription = null;

    try {
      await _channel?.sink.close();
    } catch (_) {}
    _channel = null;

    _isConnected = false;
    _handlers.clear();
    _publishCompleters.clear();
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) return;
    _reconnectTimer?.cancel();

    final int delaySec = 2 * (1 << _reconnectAttempts); // 2, 4, 8, 16, 32
    final Duration delay =
        Duration(seconds: delaySec > 30 ? 30 : delaySec);

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      if (_currentRelayUrl != null) {
        connect(_currentRelayUrl!);
      }
    });
  }

  void _handleMessage(dynamic message) {
    try {
      final List<dynamic> parsed =
          jsonDecode(message as String) as List<dynamic>;
      if (parsed.isEmpty) return;

      final String type = parsed[0] as String;

      switch (type) {
        case 'EVENT':
          if (parsed.length >= 3) {
            final String subId = parsed[1] as String;
            _handlers[subId]?.call(parsed);
          }
          break;
        case 'EOSE':
          if (parsed.length >= 2) {
            final String subId = parsed[1] as String;
            _handlers[subId]?.call(parsed);
          }
          break;
        case 'OK':
          if (parsed.length >= 3) {
            final String eventId = parsed[1] as String;
            final bool success = parsed[2] as bool;
            _publishCompleters[eventId]?.complete(success);
            _publishCompleters.remove(eventId);
          }
          break;
      }
    } catch (e) {
      loggerDev('[NostrRelay] Parse error: $e');
    }
  }

  void _sendRaw(String message) {
    if (!_isConnected || _channel == null) return;
    _channel!.sink.add(message);
  }

  // ─── Profile (Kind 0) ────────────────────────────────────────────

  /// Fetch a profile (kind 0) by hex pubkey
  Future<NostrProfile?> fetchProfile(String hexPubkey) async {
    if (!_isConnected) return null;

    final String subId = NostrUtils.generateSubscriptionId('profile');
    final Completer<NostrProfile?> completer = Completer<NostrProfile?>();

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        final Map<String, dynamic> event =
            msg[2] as Map<String, dynamic>;
        try {
          final List<List<String>> tags = (event['tags'] as List<dynamic>)
              .map((dynamic t) =>
                  (t as List<dynamic>).map((dynamic e) => e.toString()).toList())
              .toList();
          final NostrProfile profile = NostrProfile.fromEventContent(
            event['content'] as String,
            hexPubkey,
            tags,
          );
          if (!completer.isCompleted) completer.complete(profile);
        } catch (e) {
          loggerDev('[NostrRelay] Profile parse error: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) completer.complete(null);
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    final Map<String, dynamic> filter = <String, dynamic>{
      'authors': <String>[hexPubkey],
      'kinds': <int>[0],
      'limit': 1,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    // Timeout after 10s
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return null;
      },
    );
  }

  /// Publish a profile (kind 0) signed with nsec hex private key
  Future<bool> publishProfile(
      NostrProfile profile, String hexPrivateKey) async {
    if (!_isConnected) return false;

    final String hexPubkey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final List<List<String>> tags = profile.toIdentityTags();
    final String content = jsonEncode(profile.toContentJson());

    final Map<String, dynamic> event = <String, dynamic>{
      'kind': 0,
      'pubkey': hexPubkey,
      'created_at': createdAt,
      'tags': tags,
      'content': content,
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    return _publishEvent(event);
  }

  /// Search profiles (kind 0) by name using NIP-50 text search
  Future<List<NostrProfile>> searchProfiles(String searchTerm) async {
    if (!_isConnected) return <NostrProfile>[];

    final String subId = NostrUtils.generateSubscriptionId('search');
    final Completer<List<NostrProfile>> completer =
        Completer<List<NostrProfile>>();
    final List<NostrProfile> results = <NostrProfile>[];

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        final Map<String, dynamic> event =
            msg[2] as Map<String, dynamic>;
        try {
          final String pubkey = event['pubkey'] as String;
          final List<List<String>> tags = (event['tags'] as List<dynamic>)
              .map((dynamic t) => (t as List<dynamic>)
                  .map((dynamic e) => e.toString())
                  .toList())
              .toList();
          final NostrProfile profile = NostrProfile.fromEventContent(
            event['content'] as String,
            pubkey,
            tags,
          );
          results.add(profile);
        } catch (e) {
          loggerDev('[NostrRelay] Search profile parse error: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) completer.complete(results);
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    // NIP-50: text search filter
    final Map<String, dynamic> filter = <String, dynamic>{
      'kinds': <int>[0],
      'search': searchTerm,
      'limit': 20,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return results;
      },
    );
  }

  // ─── Station Economy (Kind 30850) ─────────────────────────────────

  /// Event kind for station economy reports (NIP-78 application-specific)
  static const int kindStationEconomy = 30850;

  /// Fetch station economy events from the last 30 days.
  /// Returns a map of stationId → most recent StationEconomyData.
  Future<Map<String, StationEconomyData>> fetchStationEvents() async {
    if (!_isConnected) return <String, StationEconomyData>{};

    final String subId = NostrUtils.generateSubscriptionId('stations');
    final Completer<Map<String, StationEconomyData>> completer =
        Completer<Map<String, StationEconomyData>>();
    final Map<String, StationEconomyData> stations =
        <String, StationEconomyData>{};

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        try {
          final Map<String, dynamic> event =
              msg[2] as Map<String, dynamic>;
          final StationEconomyData data =
              StationEconomyData.fromEvent(event);
          // Keep only the most recent event per station
          final StationEconomyData? existing = stations[data.stationId];
          if (existing == null || data.createdAt > existing.createdAt) {
            stations[data.stationId] = data;
          }
        } catch (e) {
          loggerDev('[NostrRelay] Station event parse error: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) completer.complete(stations);
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    final int since =
        DateTime.now().millisecondsSinceEpoch ~/ 1000 - (30 * 24 * 3600);
    final Map<String, dynamic> filter = <String, dynamic>{
      'kinds': <int>[kindStationEconomy],
      'since': since,
      'limit': 500,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    return completer.future.timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return stations;
      },
    );
  }

  // ─── Contact List (Kind 3) ───────────────────────────────────────

  /// Fetch contacts (kind 3) for a hex pubkey
  Future<List<String>> fetchContacts(String hexPubkey) async {
    if (!_isConnected) return <String>[];

    final String subId = NostrUtils.generateSubscriptionId('contacts');
    final Completer<List<String>> completer = Completer<List<String>>();

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        final Map<String, dynamic> event =
            msg[2] as Map<String, dynamic>;
        final List<String> contacts = <String>[];
        for (final dynamic tag in event['tags'] as List<dynamic>) {
          final List<dynamic> t = tag as List<dynamic>;
          if (t.isNotEmpty && t[0] == 'p' && t.length >= 2) {
            contacts.add(t[1] as String);
          }
        }
        if (!completer.isCompleted) completer.complete(contacts);
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) completer.complete(<String>[]);
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    final Map<String, dynamic> filter = <String, dynamic>{
      'authors': <String>[hexPubkey],
      'kinds': <int>[3],
      'limit': 1,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return <String>[];
      },
    );
  }

  // ─── Key derivation ────────────────────────────────────────────

  /// Derive hex public key from hex private key (BIP-340)
  static String derivePublicKey(String hexPrivateKey) {
    return bip340.getPublicKey(hexPrivateKey);
  }

  // ─── Signing ─────────────────────────────────────────────────────

  String _signEvent(String eventIdHex, String hexPrivateKey) {
    // BIP-340 Schnorr signature
    final Uint8List auxRandBytes = Uint8List.fromList(
      List<int>.generate(32, (_) => DateTime.now().microsecond % 256),
    );
    final String auxRandHex = HEX.encode(auxRandBytes);
    return bip340.sign(hexPrivateKey, eventIdHex, auxRandHex);
  }

  Future<bool> _publishEvent(Map<String, dynamic> event) async {
    final String eventId = event['id'] as String;
    final Completer<bool> completer = Completer<bool>();
    _publishCompleters[eventId] = completer;

    _sendRaw(jsonEncode(<dynamic>['EVENT', event]));

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _publishCompleters.remove(eventId);
        return false;
      },
    );
  }

  /// Dispose resources
  Future<void> dispose() async {
    _connectionController.close();
    await forceDisconnect();
  }
}
