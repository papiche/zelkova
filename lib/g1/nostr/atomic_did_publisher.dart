import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:hex/hex.dart';

import '../../ui/logger.dart';
import '../kin_calculator.dart';
import '../phi2x.dart';
import 'nostr_keys.dart';
import 'nostr_relay_service.dart';
import 'nostr_utils.dart';

/// Publie un événement NOSTR Kind 30078 (d=atom4love) avec le profil ATOMIC.
///
/// Déclenché après la création du MULTIPASS. Utilise le nsec retourné par
/// l'API UPassport pour signer l'event côté client.
///
/// Structure conforme à parse_kind30078() de phi2x.py (NIP-101/filter/30078.sh) :
///   Content JSON : { personal_phase, omega_bio, biological_sex, kin_num, version }
///   Tags : ["d","atom4love"], ["a4l_proof", sha256(pubkey:ATOM4LOVE_ALPHA)]
///          + tags KIN naissance et conception
Future<bool> publishAtomicDid({
  required String nsec,
  required String relayUrl,
  // Données de naissance pour calcul phi
  int? birthUnix,
  double birthLat = 0.0,
  double birthLon = 0.0,
  double weightKg = 3.5,
  int polarity = 0,
  // KIN pré-calculés
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

  // ── Phase personnelle φ_i (phi2x canonique) ────────────────────────────────
  double personalPhase = 0.0;
  final double omegaBio = phi2xComputeOmegaBio(weightKg, polarity);

  if (birthUnix != null && (birthLat != 0.0 || birthLon != 0.0)) {
    // Phase pondérée avec la compression Shapiro (poids de naissance)
    personalPhase = phi2xComputePersonalPhaseWeighted(
      birthUnix, birthLat, birthLon,
      weightKg: weightKg,
    );
  }

  // ── a4l_proof (NIP-101) ────────────────────────────────────────────────────
  final String a4lProof = phi2xComputeA4lProof(hexPubkey);

  // ── Content JSON (conforme parse_kind30078 de phi2x.py) ───────────────────
  final Map<String, dynamic> content = <String, dynamic>{
    'personal_phase': personalPhase,
    'omega_bio':      omegaBio,
    'biological_sex': polarity,
    'kin_num':        birthKin?.kin ?? 0,
    'version':        1,
    if (email != null && email.isNotEmpty) 'email': email,
  };

  // ── Tags ───────────────────────────────────────────────────────────────────
  final List<List<String>> tags = <List<String>>[
    <String>['d',         'atom4love'],
    <String>['a4l_proof', a4lProof],
    if (email != null && email.isNotEmpty) <String>['email', email],
  ];

  if (birthKin != null) {
    tags
      ..add(<String>['kin',    birthKin.kin.toString()])
      ..add(<String>['glyph',  birthKin.glyph])
      ..add(<String>['tone',   birthKin.toneNumber.toString()])
      ..add(<String>['color',  birthKin.color])
      ..add(<String>['action', birthKin.action]);
  }

  if (conceptionKin != null) {
    tags
      ..add(<String>['kin_c',   conceptionKin.kin.toString()])
      ..add(<String>['glyph_c', conceptionKin.glyph])
      ..add(<String>['tone_c',  conceptionKin.toneNumber.toString()]);
  }

  final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  final Map<String, dynamic> event = <String, dynamic>{
    'kind':       30078,
    'pubkey':     hexPubkey,
    'created_at': createdAt,
    'tags':       tags,
    'content':    jsonEncode(content),
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
    loggerDev('[AtomicDID] Kind 30078 published: $ok — φ=${personalPhase.toStringAsFixed(4)} ω=${omegaBio.toStringAsFixed(2)}Hz');
    return ok;
  } catch (e) {
    loggerDev('[AtomicDID] Publish error: $e');
    return false;
  }
}

String _signEvent(String eventIdHex, String hexPrivateKey) {
  final Random rng = Random.secure();
  final Uint8List aux = Uint8List.fromList(
    List<int>.generate(32, (int _) => rng.nextInt(256)),
  );
  return bip340.sign(hexPrivateKey, eventIdHex, HEX.encode(aux));
}
