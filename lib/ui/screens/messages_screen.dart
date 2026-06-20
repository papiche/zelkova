import 'dart:async';
import 'dart:convert';

import 'package:bip340/bip340.dart' as bip340;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/nostr_message.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_profile.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../shared_prefs_helper_v2.dart';
import 'bro_screen.dart';
import 'chat_screen.dart';
import 'love_screen.dart';

/// Telegram-style conversation list — one tile per DM peer.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool _loading = false;
  String? _myHexPubkey;
  String? _myHexPrivkey;

  // peerHex → last message + profile
  final Map<String, _ConvData> _conversations = <String, _ConvData>{};

  // Live DM subscription
  String? _dmSubId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    if (_dmSubId != null) {
      NostrRelayService().cancelDmSubscription(_dmSubId!);
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (_loading) {
      return;
    }
    setState(() => _loading = true);

    try {
      final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) {
        if (mounted) {
          setState(() => _loading = false);
        }
        return;
      }
      final String hexPriv = NostrKeys.nsecToHex(nsec);
      final String hexPub = bip340.getPublicKey(hexPriv);

      final NostrRelayService relay = NostrRelayService();
      if (!relay.isConnected) {
        if (mounted) {
          setState(() => _loading = false);
        }
        return;
      }

      // Load constellation relays from 12345 station map
      await _loadConstellationRelays(relay);

      final List<String> peers = await relay.fetchDmPeers(
        myHexPubkey: hexPub,
      );

      final List<_ConvData?> results = await Future.wait<_ConvData?>(
        peers.map((String peer) async {
          final List<NostrMessage> msgs = await relay.fetchNip44Messages(
            myHexPubkey: hexPub,
            myHexPrivkey: hexPriv,
            peerHexPubkey: peer,
            limit: 2,
          );
          if (msgs.isEmpty) return null;
          final NostrProfile? profile = await relay.fetchProfile(peer);
          return _ConvData(
            peerHex: peer,
            lastMessage: msgs.last,
            profile: profile,
          );
        }),
      );
      final Map<String, _ConvData> convs = <String, _ConvData>{};
      for (final _ConvData? data in results) {
        if (data != null) convs[data.peerHex] = data;
      }

      if (mounted) {
        setState(() {
          _myHexPubkey = hexPub;
          _myHexPrivkey = hexPriv;
          _conversations
            ..clear()
            ..addAll(convs);
          _loading = false;
        });
        _subscribeLive(hexPub, hexPriv);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _loadConstellationRelays(NostrRelayService relay) async {
    try {
      // Fetches 12345.json from the local Astroport station to get swarm relay URLs
      final List<Map<String, dynamic>> stationEvents = await relay.queryEvents(
        kinds: <int>[30850],
        limit: 50,
      );
      final Set<String> wsUrls = <String>{};
      for (final Map<String, dynamic> ev in stationEvents) {
        try {
          final dynamic content = ev['content'];
          if (content is String && content.isNotEmpty) {
            // Station data has relay_url field
          }
          // Extract relay URL from tags
          final List<dynamic> tags = ev['tags'] as List<dynamic>;
          for (final dynamic tag in tags) {
            final List<dynamic> t = tag as List<dynamic>;
            if (t.length >= 2 && t[0] == 'relay') {
              wsUrls.add(t[1].toString());
            }
          }
        } catch (_) {}
      }
      if (wsUrls.isNotEmpty) {
        relay.setConstellationRelays(wsUrls);
      }
    } catch (_) {}
  }

  void _subscribeLive(String myHex, String myPriv) {
    _dmSubId = NostrRelayService().subscribeToDms(
      myHexPubkey: myHex,
      myHexPrivkey: myPriv,
      onMessage: (NostrMessage msg) {
        if (!mounted) {
          return;
        }
        setState(() {
          final String peer = msg.peerHex(myHex);
          final _ConvData? existing = _conversations[peer];
          _conversations[peer] = _ConvData(
            peerHex: peer,
            lastMessage: msg,
            profile: existing?.profile,
          );
        });
      },
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static const String _imgTag = '_uenc_img';

  String _previewContent(String content) {
    try {
      final dynamic decoded = jsonDecode(content);
      if (decoded is Map && decoded.containsKey(_imgTag)) {
        return '📷 Image';
      }
    } catch (_) {}
    return content.length > 60 ? '${content.substring(0, 60)}…' : content;
  }

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _buildConvTile(_ConvData conv) {
    final NostrProfile? p = conv.profile;
    final String name = p?.name ?? conv.peerHex.substring(0, 12);
    final String? picture = p?.picture;
    final String preview = _previewContent(conv.lastMessage.content);
    final bool isMe = conv.lastMessage.isFromMe(_myHexPubkey ?? '');

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: picture != null && picture.isNotEmpty
            ? NetworkImage(picture)
            : null,
        onBackgroundImageError: (_, __) {},
        child: (picture == null || picture.isEmpty)
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            : null,
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: <Widget>[
          if (isMe)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.done, size: 14, color: Colors.grey),
            ),
          Expanded(
            child: Text(
              preview,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
      trailing: Text(
        _formatTime(conv.lastMessage.dateTime),
        style: Theme.of(context).textTheme.labelSmall,
      ),
      onTap: () => _openChat(conv),
    );
  }

  String _formatTime(DateTime dt) {
    final DateTime now = DateTime.now();
    if (dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}';
  }

  void _openChat(_ConvData conv) {
    if (_myHexPubkey == null || _myHexPrivkey == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ChatScreen(
          myHexPubkey: _myHexPubkey!,
          myHexPrivkey: _myHexPrivkey!,
          peerHexPubkey: conv.peerHex,
          peerProfile: conv.profile,
        ),
      ),
    ).then((_) => _load()); // refresh on return
  }

  @override
  Widget build(BuildContext context) {
    final List<_ConvData> sorted = _conversations.values.toList()
      ..sort((_ConvData a, _ConvData b) =>
          b.lastMessage.createdAt.compareTo(a.lastMessage.createdAt));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(tr('messages_title')),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _load,
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: 'love_open_fab',
            backgroundColor: const Color(0xFFE91E8C),
            foregroundColor: Colors.white,
            icon: const Icon(Icons.favorite),
            label: const Text('LOVE',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const LoveScreen()),
            ),
            tooltip: 'Mode LOVE — Assistance aux rencontres',
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'bro_open_fab',
            icon: const Icon(Icons.smart_toy_outlined),
            label: const Text('BRO'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const BroScreen()),
            ),
            tooltip: 'Ouvrir le chat BRO (IA station)',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _myHexPubkey == null
              ? Center(child: Text(tr('contacts_no_identity')))
              : sorted.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.chat_bubble_outline,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(tr('messages_empty'),
                              style:
                                  const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: sorted.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, indent: 72),
                      itemBuilder: (BuildContext ctx, int i) =>
                          _buildConvTile(sorted[i]),
                    ),
    );
  }
}

class _ConvData {
  _ConvData({
    required this.peerHex,
    required this.lastMessage,
    this.profile,
  });

  final String peerHex;
  final NostrMessage lastMessage;
  final NostrProfile? profile;
}
