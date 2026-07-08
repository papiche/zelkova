import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../ui/logger.dart';

/// Interroge un relay NOSTR pour un kind 0 portant le tag `["i","email:<email>",""]`
/// (voir Astroport.ONE/tools/nostr_setup_profile.py). Retourne `content.home_station`
/// ("IPFSNODEID:NODE_HEX") si un profil MULTIPASS existe déjà pour cet email
/// quelque part sur la constellation, ou `null` si absent de ce relay.
///
/// Grâce à `backfill_constellation.sh` (sync quotidienne du swarm), interroger
/// un seul relay de la constellation suffit à voir les comptes de toutes les
/// stations Astroport, avec une latence de synchronisation ≤24h.
Future<String?> queryHomeStationForEmail(String email, String relayUrl) async {
  if (relayUrl.isEmpty) {
    return null;
  }
  WebSocketChannel? ws;
  try {
    ws = WebSocketChannel.connect(Uri.parse(relayUrl));
    final String subId = 'hs_${email.hashCode.abs()}';
    ws.sink.add(jsonEncode(<dynamic>[
      'REQ',
      subId,
      <String, dynamic>{
        'kinds': <int>[0],
        '#i': <String>['email:$email'],
        'limit': 1,
      },
    ]));

    String? homeStation;
    await for (final dynamic raw
        in ws.stream.timeout(const Duration(seconds: 6))) {
      final List<dynamic> msg = jsonDecode(raw as String) as List<dynamic>;
      if (msg.isEmpty) {
        continue;
      }
      if (msg[0] == 'EOSE') {
        break;
      }
      if (msg[0] == 'EVENT' && msg.length >= 3) {
        final Map<String, dynamic> event = msg[2] as Map<String, dynamic>;
        if ((event['kind'] as int?) == 0) {
          final Map<String, dynamic> content =
              jsonDecode(event['content'] as String) as Map<String, dynamic>;
          homeStation = content['home_station'] as String?;
          break;
        }
      }
    }
    return homeStation;
  } catch (e) {
    loggerDev('[HomeStationLookup] $email lookup error: $e');
    rethrow; // distinguer "not found" de "relay error"
  } finally {
    ws?.sink.close();
  }
}
