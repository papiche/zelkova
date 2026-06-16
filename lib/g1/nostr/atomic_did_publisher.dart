import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';

import '../../ui/logger.dart';
import '../kin_calculator.dart';
import 'nostr_keys.dart';
import 'nostr_relay_service.dart';
import 'nostr_utils.dart';

/// Publie un événement NOSTR Kind 30078 (d=atom4love) avec le profil ATOMIC.
///
/// Déclenché après la création du MULTIPASS. Utilise le nsec retourné par
/// l'API UPassport pour signer l'event côté client.
///
/// Tags publiés :
///   ["d", "atom4love"]          — identificateur unique de l'event
///   ["kin", "42"]               — numéro KIN de naissance
///   ["glyph", "Ik"]
///   ["tone", "3"]
///   ["color", "Blanc"]
///   ["action", "Activer"]
///   ["kin_c", "97"]             — KIN conception (si présent)
Future<bool> publishAtomicDid({
  required String nsec,
  required String relayUrl,
  KinResult? birthKin,
  KinResult? conceptionKin,
  String? email,
}) async {
  if (nsec.isEmpty || relayUrl.isEmpty) {
    return false;
  }

  String hexPrivKey;
  try {
    hexPrivKey = NostrKeys.nsecToHex(nsec);
  } catch (e) {
    loggerDev('[AtomicDID] nsec decode error: $e');
    return false;
  }

  final String hexPubkey = bip340.getPublicKey(hexPrivKey);
  final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final List<List<String>> tags = <List<String>>[
    <String>['d', 'atom4love'],
    if (email != null && email.isNotEmpty) <String>['email', email],
  ];

  if (birthKin != null) {
    tags
      ..add(<String>['kin',     birthKin.kin.toString()])
      ..add(<String>['glyph',   birthKin.glyph])
      ..add(<String>['tone',    birthKin.toneNumber.toString()])
      ..add(<String>['color',   birthKin.color])
      ..add(<String>['action',  birthKin.action]);
  }

  if (conceptionKin != null) {
    tags
      ..add(<String>['kin_c',   conceptionKin.kin.toString()])
      ..add(<String>['glyph_c', conceptionKin.glyph])
      ..add(<String>['tone_c',  conceptionKin.toneNumber.toString()]);
  }

  final Map<String, dynamic> event = <String, dynamic>{
    'kind':       30078,
    'pubkey':     hexPubkey,
    'created_at': createdAt,
    'tags':       tags,
    'content':    '',
  };

  final String eventId = NostrUtils.calculateEventId(event);
  event['id']  = eventId;
  event['sig'] = _signEvent(eventId, hexPrivKey);

  final NostrRelayService relay = NostrRelayService();
  try {
    final bool connected = await relay.connect(relayUrl);
    if (!connected) {
      loggerDev('[AtomicDID] Cannot connect to $relayUrl');
      return false;
    }
    final bool ok = await relay.publishEvent(event);
    loggerDev('[AtomicDID] Kind 30078 published: $ok (relay=$relayUrl)');
    return ok;
  } catch (e) {
    loggerDev('[AtomicDID] Publish error: $e');
    return false;
  }
}

String _signEvent(String eventIdHex, String hexPrivateKey) {
  final Uint8List aux = Uint8List.fromList(
    List<int>.generate(32, (int i) => (DateTime.now().microsecond + i) % 256),
  );
  return bip340.sign(hexPrivateKey, eventIdHex, HEX.encode(aux));
}
