import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/models/nostr_message.dart';
import '../../ui/logger.dart';
import 'nip44.dart';
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
    if (_isConnected && _currentRelayUrl == relayUrl) {
      return true;
    }

    await _disconnectInternal();

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

  /// Déconnexion interne sans reset du compteur de tentatives (préserve le backoff).
  Future<void> _disconnectInternal() async {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

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

  /// Force disconnect (réinitialise aussi le compteur de reconnexion).
  Future<void> forceDisconnect() async {
    _reconnectAttempts = 0;
    await _disconnectInternal();
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }
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
      if (parsed.isEmpty) {
        return;
      }

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
            if (success) {
              loggerDev('[NOSTR] ✓ OK id=${eventId.substring(0, 8)}');
            } else {
              loggerDev('[NOSTR] ✗ OK false id=${eventId.substring(0, 8)}: ${parsed.length >= 4 ? parsed[3] : ''}');
            }
            _publishCompleters[eventId]?.complete(success);
            _publishCompleters.remove(eventId);
          }
          break;
        case 'NOTICE':
          if (parsed.length >= 2) {
            loggerDev('[NostrRelay] NOTICE: ${parsed[1]}');
          }
          break;
      }
    } catch (e) {
      loggerDev('[NostrRelay] Parse error: $e');
    }
  }

  void _sendRaw(String message) {
    if (!_isConnected || _channel == null) {
      return;
    }
    _channel!.sink.add(message);
  }

  // ─── Profile (Kind 0) ────────────────────────────────────────────

  /// Fetch a profile (kind 0) by hex pubkey
  Future<NostrProfile?> fetchProfile(String hexPubkey) async {
    if (!_isConnected) {
      return null;
    }

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
          if (!completer.isCompleted) {
            completer.complete(profile);
          }
        } catch (e) {
          loggerDev('[NostrRelay] Profile parse error: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) {
          completer.complete(null);
        }
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
    if (!_isConnected) {
      return false;
    }

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

  /// Find the NOSTR hex pubkey of a Duniter contact by querying kind 0 events
  /// that contain the NIP-39 identity tag ["i", "g1pub:{duniterPubKey}"].
  ///
  /// Returns the hex NOSTR pubkey if found, or null.
  /// This is the correct way to link a Duniter G1 pubkey to its NOSTR identity.
  Future<String?> findNostrHexByG1Pub(String duniterBase58PubKey) async {
    if (!_isConnected) {
      return null;
    }

    // Strip any :ZEN:XXXX tag appended by ZenTagService before using as lookup key
    final String cleanKey = duniterBase58PubKey.split(':').first;

    final List<Map<String, dynamic>> events = await queryEvents(
      kinds: <int>[0],
      tags: <List<String>>[<String>['i', 'g1pub:$cleanKey']],
      limit: 1,
    );

    if (events.isEmpty) {
      return null;
    }
    return events.first['pubkey'] as String?;
  }

  /// Search profiles (kind 0) by name using NIP-50 text search
  Future<List<NostrProfile>> searchProfiles(String searchTerm) async {
    if (!_isConnected) {
      return <NostrProfile>[];
    }

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
        if (!completer.isCompleted) {
          completer.complete(results);
        }
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

  // ─── MULTIPASS discovery ──────────────────────────────────────────

  /// Fetch all MULTIPASS profiles registered on the local relay.
  ///
  /// Retrieves kind-0 events (NIP-01 profiles) limited to [limit] entries,
  /// then filters to keep only genuine UPlanet MULTIPASS profiles — those
  /// that carry a NIP-39 identity tag `["i", "g1pub:<duniterPubKey>"]`.
  ///
  /// Notes on Cesium+ incompatibility:
  ///   • Cesium+ profiles are indexed by Duniter base-58 pubkey only.
  ///   • MULTIPASS profiles live on a NOSTR relay and are keyed by hex/npub.
  ///   • Their G1 wallet is referenced via the NIP-39 `g1pub` tag.
  ///   • The two systems cannot be mixed in a single search flow.
  Future<List<NostrProfile>> fetchAllMultipassProfiles(
      {int limit = 200}) async {
    if (!_isConnected) {
      return <NostrProfile>[];
    }

    final String subId =
        NostrUtils.generateSubscriptionId('multipass-all');
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
          // Only include genuine MULTIPASS profiles (NIP-39 g1pub tag)
          final bool hasG1pub = tags.any((List<String> t) =>
              t.length >= 2 &&
              t[0] == 'i' &&
              t[1].startsWith('g1pub:'));
          if (!hasG1pub) {
            return;
          }
          results.add(NostrProfile.fromEventContent(
            event['content'] as String,
            pubkey,
            tags,
          ));
        } catch (e) {
          loggerDev('[NostrRelay] fetchAllMultipassProfiles parse: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) {
          completer.complete(results);
        }
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    _sendRaw(jsonEncode(<dynamic>[
      'REQ',
      subId,
      <String, dynamic>{'kinds': <int>[0], 'limit': limit},
    ]));

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
    if (!_isConnected) {
      return <String, StationEconomyData>{};
    }

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
        if (!completer.isCompleted) {
          completer.complete(stations);
        }
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

  // ─── Reactions / Kind 7 (NIP-25 + NIP-101 ZEN payment extension) ──────────

  /// Publish a kind 7 reaction.
  /// Used as payment fallback when Duniter nodes are unavailable:
  ///   content = "+{zen}" (ex: "+10" = pay +10Ẑ to [reactedAuthorHexPubkey])
  ///   The NIP-101 relay filter/7.sh intercepts this and calls PAYforSURE.sh
  ///   on the Astroport station to execute the Duniter transaction locally.
  ///
  /// For a standard like: content = "+"
  /// For a ZEN payment:   content = "+10" (pays 10Ẑ = 1 G1)
  /// For crowdfunding:    add tag ["t", "crowdfunding"], ["project-id", "CF-XXX"]
  ///
  /// [reactedEventId] is optional (empty string if no reference event).
  Future<bool> publishReaction({
    required String hexPrivateKey,
    required String reactedAuthorHexPubkey,
    String reactedEventId = '',
    String content = '+',
  }) async {
    if (!_isConnected) {
      return false;
    }

    final String hexPubkey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final List<List<String>> tags = <List<String>>[
      <String>['p', reactedAuthorHexPubkey],
    ];
    if (reactedEventId.isNotEmpty) {
      tags.add(<String>['e', reactedEventId]);
    }

    final Map<String, dynamic> event = <String, dynamic>{
      'kind': 7,
      'pubkey': hexPubkey,
      'created_at': createdAt,
      'tags': tags,
      'content': content,
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    loggerDev('[NostrRelay] Publishing kind 7 reaction: $content → ${reactedAuthorHexPubkey.substring(0, 8)}...');
    return _publishEvent(event);
  }

  // ─── Contact List (Kind 3) ───────────────────────────────────────

  /// Publish contacts list (kind 3) — adds/updates the follow list.
  /// Should be called after discovering a NOSTR profile (kind 0) to ensure
  /// the relay recognises the contact in amisOfAmis for kind 7 payments.
  ///
  /// [hexPubkeys] is the COMPLETE list of followed hex pubkeys (replaces prev).
  Future<bool> publishContacts({
    required String hexPrivateKey,
    required List<String> hexPubkeys,
  }) async {
    if (!_isConnected) {
      return false;
    }

    final String hexPubkey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final List<List<String>> tags = hexPubkeys
        .map((String p) => <String>['p', p])
        .toList();

    final Map<String, dynamic> event = <String, dynamic>{
      'kind': 3,
      'pubkey': hexPubkey,
      'created_at': createdAt,
      'tags': tags,
      'content': '',
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    loggerDev('[NostrRelay] Publishing kind 3 contacts (${hexPubkeys.length} follows)');
    return _publishEvent(event);
  }

  /// Fetch contacts (kind 3) for a hex pubkey
  Future<List<String>> fetchContacts(String hexPubkey) async {
    if (!_isConnected) {
      return <String>[];
    }

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
        if (!completer.isCompleted) {
          completer.complete(contacts);
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) {
          completer.complete(<String>[]);
        }
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

  /// Fetch all pubkeys whose Kind 3 contact list includes [hexPubkey].
  /// Returns the list of follower hex pubkeys (authors of those Kind 3 events).
  Future<List<String>> fetchFollowers(String hexPubkey) async {
    if (!_isConnected) {
      return <String>[];
    }

    final String subId = NostrUtils.generateSubscriptionId('followers');
    final Completer<List<String>> completer = Completer<List<String>>();
    final List<String> followers = <String>[];

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        final Map<String, dynamic> event =
            msg[2] as Map<String, dynamic>;
        final String author = event['pubkey'] as String;
        if (!followers.contains(author)) {
          followers.add(author);
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) {
          completer.complete(followers);
        }
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    final Map<String, dynamic> filter = <String, dynamic>{
      'kinds': <int>[3],
      '#p': <String>[hexPubkey],
      'limit': 500,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return followers;
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
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    );
    final String auxRandHex = HEX.encode(auxRandBytes);
    return bip340.sign(hexPrivateKey, eventIdHex, auxRandHex);
  }

  Future<bool> _publishEvent(Map<String, dynamic> event) async {
    final String eventId = event['id'] as String;
    final int kind = event['kind'] as int? ?? -1;
    loggerDev('[NOSTR] → publish kind=$kind id=${eventId.substring(0, 8)}');
    final Completer<bool> completer = Completer<bool>();
    _publishCompleters[eventId] = completer;

    _sendRaw(jsonEncode(<dynamic>['EVENT', event]));

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        loggerDev('[NOSTR] Publish timeout kind=$kind id=${eventId.substring(0, 8)}');
        _publishCompleters.remove(eventId);
        return false;
      },
    );
  }

  /// Public method to publish a NOSTR event (any kind)
  Future<bool> publishEvent(Map<String, dynamic> event) async {
    return _publishEvent(event);
  }

  /// Publish a text note (kind 1 — NIP-01) optionally mentioning a contact.
  ///
  /// Used for "Invite to ẐEN" messages sent to Cesium+ contacts who have a
  /// NOSTR identity on the relay: the note mentions their hex pubkey via a
  /// `["p", hexPubkey]` tag so the message appears in their notifications.
  ///
  /// [hexPrivateKey] — signer's hex private key (derived from nsec)
  /// [content]       — note content
  /// [mentionHex]    — (optional) hex pubkey of the mentioned user
  Future<bool> publishNote({
    required String hexPrivateKey,
    required String content,
    String? mentionHex,
  }) async {
    if (!_isConnected) {
      return false;
    }

    final String hexPubkey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final List<List<String>> tags = <List<String>>[
      if (mentionHex != null && mentionHex.isNotEmpty)
        <String>['p', mentionHex],
    ];

    final Map<String, dynamic> event = <String, dynamic>{
      'pubkey': hexPubkey,
      'created_at': createdAt,
      'kind': 1,
      'tags': tags,
      'content': content,
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    return _publishEvent(event);
  }

  /// Query events with arbitrary filters (NIP-01)
  /// Returns a list of event maps.
  Future<List<Map<String, dynamic>>> queryEvents({
    List<int>? kinds,
    List<String>? authors,
    int? since,
    int? until,
    int? limit,
    List<List<String>>? tags,
    String? search,
  }) async {
    if (!_isConnected) {
      return <Map<String, dynamic>>[];
    }

    final String subId = NostrUtils.generateSubscriptionId('query');
    final Completer<List<Map<String, dynamic>>> completer =
        Completer<List<Map<String, dynamic>>>();
    final List<Map<String, dynamic>> events = <Map<String, dynamic>>[];

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type == 'EVENT' && msg.length >= 3) {
        try {
          final Map<String, dynamic> event =
              msg[2] as Map<String, dynamic>;
          events.add(event);
        } catch (e) {
          loggerDev('[NostrRelay] Query event parse error: $e');
        }
      } else if (type == 'EOSE') {
        if (!completer.isCompleted) {
          completer.complete(events);
        }
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
      }
    };

    final Map<String, dynamic> filter = <String, dynamic>{};
    if (kinds != null && kinds.isNotEmpty) {
      filter['kinds'] = kinds;
    }
    if (authors != null && authors.isNotEmpty) {
      filter['authors'] = authors;
    }
    if (since != null) {
      filter['since'] = since;
    }
    if (until != null) {
      filter['until'] = until;
    }
    if (limit != null) {
      filter['limit'] = limit;
    }
    if (tags != null && tags.isNotEmpty) {
      // NIP-12: generic tag queries
      for (int i = 0; i < tags.length; i++) {
        final List<String> tag = tags[i];
        if (tag.isNotEmpty) {
          final String tagName = tag[0];
          final List<String> tagValues = tag.sublist(1);
          filter['#$tagName'] = tagValues;
        }
      }
    }
    if (search != null && search.isNotEmpty) {
      filter['search'] = search; // NIP-50
    }

    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));

    return completer.future.timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        loggerDev('[NostrRelay] Query timeout for sub $subId');
        _handlers.remove(subId);
        _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
        return events;
      },
    );
  }

  /// Publish a NIP-42 AUTH event (kind 22242).
  /// Called after receiving an AUTH challenge from the relay, or proactively
  /// before zen_send to prove MULTIPASS ownership on this station.
  ///
  /// [challenge] — the nonce string from the relay AUTH message or
  ///               from UPassport's GET /api/nip42 challenge endpoint.
  /// [hexPrivateKey] — signer's hex private key.
  /// Returns true if the relay acknowledged the event.
  Future<bool> publishNip42Auth(String challenge, String hexPrivateKey) async {
    if (!_isConnected) {
      return false;
    }

    final String hexPubkey = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final Map<String, dynamic> event = <String, dynamic>{
      'kind': 22242,
      'pubkey': hexPubkey,
      'created_at': createdAt,
      'tags': <List<String>>[
        <String>['challenge', challenge],
        if (_currentRelayUrl != null)
          <String>['relay', _currentRelayUrl!],
      ],
      'content': '',
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    loggerDev('[NostrRelay] Publishing NIP-42 AUTH (kind 22242) challenge=${challenge.substring(0, challenge.length > 8 ? 8 : challenge.length)}...');
    return _publishEvent(event);
  }

  // ─── NIP-44 Encrypted DMs (kind 4) ───────────────────────────────────────

  /// Extra relay URLs to broadcast DMs to (constellation nodes from 12345.json).
  final Set<String> _constellationRelays = <String>{};

  void setConstellationRelays(Iterable<String> relayUrls) {
    _constellationRelays
      ..clear()
      ..addAll(relayUrls);
    loggerDev('[NostrRelay] Constellation relays set: ${_constellationRelays.length}');
  }

  /// Fire-and-forget: publish an already-signed event to a secondary relay.
  Future<void> _publishToRelay(String relayUrl, Map<String, dynamic> event) async {
    try {
      final WebSocketChannel ws =
          WebSocketChannel.connect(Uri.parse(relayUrl));
      await ws.ready.timeout(const Duration(seconds: 5));
      ws.sink.add(jsonEncode(<dynamic>['EVENT', event]));
      await Future<void>.delayed(const Duration(seconds: 2));
      await ws.sink.close();
    } catch (e) {
      loggerDev('[NostrRelay] Failed to publish to $relayUrl: $e');
    }
  }

  /// Send a NIP-44 v2 encrypted DM (kind 4) to [recipientHexPubkey].
  /// Also broadcasts to all constellation relay URLs.
  Future<bool> sendNip44Message({
    required String hexPrivateKey,
    required String recipientHexPubkey,
    required String plaintext,
  }) async {
    if (!_isConnected) {
      return false;
    }

    final String senderHex = bip340.getPublicKey(hexPrivateKey);
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final String encryptedContent =
        Nip44.encrypt(plaintext, hexPrivateKey, recipientHexPubkey);

    final Map<String, dynamic> event = <String, dynamic>{
      'kind': 4,
      'pubkey': senderHex,
      'created_at': createdAt,
      'tags': <List<String>>[
        <String>['p', recipientHexPubkey],
      ],
      'content': encryptedContent,
    };

    final String eventId = NostrUtils.calculateEventId(event);
    event['id'] = eventId;
    event['sig'] = _signEvent(eventId, hexPrivateKey);

    loggerDev('[NostrRelay] Sending NIP-44 DM → ${recipientHexPubkey.substring(0, 8)}...');

    // Publish to primary relay
    final bool ok = await _publishEvent(event);

    // Broadcast to constellation relays (fire-and-forget)
    if (_constellationRelays.isNotEmpty) {
      for (final String url in _constellationRelays) {
        if (url != _currentRelayUrl) {
          _publishToRelay(url, event);
        }
      }
    }

    return ok;
  }

  /// Fetch all NIP-44 DMs exchanged between [myHexPubkey] and [peerHexPubkey].
  /// Decrypts each message using [myHexPrivkey].
  Future<List<NostrMessage>> fetchNip44Messages({
    required String myHexPubkey,
    required String myHexPrivkey,
    required String peerHexPubkey,
    int limit = 200,
  }) async {
    if (!_isConnected) {
      return <NostrMessage>[];
    }

    // Fetch: messages I sent to them + messages they sent to me (parallel)
    final List<List<Map<String, dynamic>>> raw = await Future.wait(
      <Future<List<Map<String, dynamic>>>>[
        queryEvents(
          kinds: <int>[4],
          authors: <String>[myHexPubkey],
          tags: <List<String>>[<String>['p', peerHexPubkey]],
          limit: limit ~/ 2,
        ),
        queryEvents(
          kinds: <int>[4],
          authors: <String>[peerHexPubkey],
          tags: <List<String>>[<String>['p', myHexPubkey]],
          limit: limit ~/ 2,
        ),
      ],
    );

    final List<NostrMessage> messages = <NostrMessage>[];

    for (final List<Map<String, dynamic>> batch in raw) {
      for (final Map<String, dynamic> ev in batch) {
        try {
          final String sender = ev['pubkey'] as String;
          final String recipient = (ev['tags'] as List<dynamic>)
              .cast<List<dynamic>>()
              .firstWhere(
                (List<dynamic> t) => t.isNotEmpty && t[0] == 'p',
                orElse: () => <String>['p', ''],
              )[1]
              .toString();

          // Decrypt: ECDH(myPriv, otherPartyPub)
          final String otherPartyHex =
              sender == myHexPubkey ? recipient : sender;
          if (otherPartyHex.isEmpty) {
            continue;
          }

          final String plaintext = Nip44.decrypt(
            ev['content'] as String,
            myHexPrivkey,
            otherPartyHex,
          );

          messages.add(NostrMessage(
            id: ev['id'] as String,
            senderHex: sender,
            recipientHex: recipient,
            content: plaintext,
            createdAt: ev['created_at'] as int,
          ));
        } catch (e) {
          loggerDev('[NostrRelay] Failed to decrypt DM: $e');
        }
      }
    }

    messages.sort((NostrMessage a, NostrMessage b) =>
        a.createdAt.compareTo(b.createdAt));
    return messages;
  }

  /// Subscribe to new incoming kind-4 DMs addressed to [myHexPubkey].
  /// Calls [onMessage] for each new decrypted message.
  /// Returns the subscription ID (use it to call [cancelDmSubscription]).
  String subscribeToDms({
    required String myHexPubkey,
    required String myHexPrivkey,
    required void Function(NostrMessage) onMessage,
  }) {
    final String subId = NostrUtils.generateSubscriptionId('dm');
    final int since = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    _handlers[subId] = (List<dynamic> msg) {
      final String type = msg[0] as String;
      if (type != 'EVENT' || msg.length < 3) {
        return;
      }
      try {
        final Map<String, dynamic> ev = msg[2] as Map<String, dynamic>;
        final int kind = ev['kind'] as int;
        if (kind != 4) {
          return;
        }
        final String sender = ev['pubkey'] as String;
        if (sender == myHexPubkey) {
          return; // ignore own echoes
        }
        final String plaintext = Nip44.decrypt(
          ev['content'] as String,
          myHexPrivkey,
          sender,
        );
        onMessage(NostrMessage(
          id: ev['id'] as String,
          senderHex: sender,
          recipientHex: myHexPubkey,
          content: plaintext,
          createdAt: ev['created_at'] as int,
        ));
      } catch (e) {
        loggerDev('[NostrRelay] DM subscription decrypt error: $e');
      }
    };

    final Map<String, dynamic> filter = <String, dynamic>{
      'kinds': <int>[4],
      '#p': <String>[myHexPubkey],
      'since': since,
    };
    _sendRaw(jsonEncode(<dynamic>['REQ', subId, filter]));
    loggerDev('[NostrRelay] Subscribed to DMs for ${myHexPubkey.substring(0, 8)}...');
    return subId;
  }

  void cancelDmSubscription(String subId) {
    _handlers.remove(subId);
    _sendRaw(jsonEncode(<dynamic>['CLOSE', subId]));
  }

  /// Fetch all unique peers I've exchanged DMs with (for conversation list).
  Future<List<String>> fetchDmPeers({
    required String myHexPubkey,
    int limit = 100,
  }) async {
    if (!_isConnected) {
      return <String>[];
    }

    // Events I sent + events addressed to me
    final List<List<Map<String, dynamic>>> raw = await Future.wait(
      <Future<List<Map<String, dynamic>>>>[
        queryEvents(
          kinds: <int>[4],
          authors: <String>[myHexPubkey],
          limit: limit,
        ),
        queryEvents(
          kinds: <int>[4],
          tags: <List<String>>[<String>['p', myHexPubkey]],
          limit: limit,
        ),
      ],
    );

    final Set<String> peers = <String>{};
    for (final List<Map<String, dynamic>> batch in raw) {
      for (final Map<String, dynamic> ev in batch) {
        final String sender = ev['pubkey'] as String;
        final List<dynamic> tags = ev['tags'] as List<dynamic>;
        String recipient = '';
        for (final dynamic t in tags) {
          final List<dynamic> tag = t as List<dynamic>;
          if (tag.isNotEmpty && tag[0] == 'p' && tag.length >= 2) {
            recipient = tag[1].toString();
            break;
          }
        }
        if (sender == myHexPubkey && recipient.isNotEmpty) {
          peers.add(recipient);
        } else if (recipient == myHexPubkey && sender.isNotEmpty) {
          peers.add(sender);
        }
      }
    }
    peers.remove(myHexPubkey);
    return peers.toList();
  }

  /// Dispose resources
  Future<void> dispose() async {
    _connectionController.close();
    await forceDisconnect();
  }
}
