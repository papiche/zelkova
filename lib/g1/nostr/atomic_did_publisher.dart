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
  // Position de résidence actuelle (GPS device, confirmée par l'utilisateur).
  // Si null ou 0.0/0.0, d=atom4love-home n'est pas publié.
  double? homeLat,
  double? homeLon,
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

  // ── Adresse géographique + a5l (requis par atomic_map.html) ───────────────
  Phi2xGeoTag? geoTag;
  double? a5lAmplitude;
  if (birthUnix != null && (birthLat != 0.0 || birthLon != 0.0)) {
    geoTag       = phi2xGeoTagA4L(birthLat, birthLon, birthUnix);
    a5lAmplitude = phi2xComputeResonanceField(birthLat, birthLon, birthUnix);
  }

  // ── Content JSON (conforme parse_kind30078 de phi2x.py) ───────────────────
  final Map<String, dynamic> content = <String, dynamic>{
    'personal_phase': personalPhase,
    'omega_bio':      omegaBio,
    'biological_sex': polarity,
    'kin_num':        birthKin?.kin ?? 0,
    'version':        1,
    if (a5lAmplitude != null) 'a5l_amplitude': a5lAmplitude,
    if (email != null && email.isNotEmpty) 'email': email,
  };

  // ── Tags ───────────────────────────────────────────────────────────────────
  final List<List<String>> tags = <List<String>>[
    <String>['d',         'atom4love'],
    <String>['a4l_proof', a4lProof],
    if (email != null && email.isNotEmpty) <String>['email', email],
  ];

  // Tags géographiques (adresse hexagonale + cymatique) — obligatoires pour
  // que atomic_map.html puisse décoder la position et afficher le marqueur.
  if (geoTag != null) {
    tags
      ..add(<String>['g', geoTag.penta])
      ..add(<String>['g', geoTag.hex]);
  }
  if (a5lAmplitude != null) {
    tags.add(<String>['a5l', phi2xEncodeA5lTag(a5lAmplitude)]);
  }

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
    loggerDev('[AtomicDID] d=atom4love published: $ok'
        ' φ=${personalPhase.toStringAsFixed(4)}'
        ' ω=${omegaBio.toStringAsFixed(2)}Hz'
        '${a5lAmplitude != null ? " Ψ=${a5lAmplitude.toStringAsFixed(4)}" : ""}');

    // ── d=atom4love-home (couche home de atomic_map.html) ─────────────────
    // Publié uniquement si une position explicite est fournie (pas de fallback naissance).
    final double hLat = homeLat ?? 0.0;
    final double hLon = homeLon ?? 0.0;
    if (hLat != 0.0 || hLon != 0.0) {
      await _publishAtomicHome(
        relay:       relay,
        hexPubkey:   hexPubkey,
        hexPrivKey:  hexPrivKey,
        geoTag:      phi2xGeoTagA4L(hLat, hLon, createdAt),
        birthLat:    hLat,
        birthLon:    hLon,
        a4lProof:    a4lProof,
        createdAt:   createdAt,
      );
    }

    return ok;
  } catch (e) {
    loggerDev('[AtomicDID] Publish error: $e');
    return false;
  }
}

Future<void> _publishAtomicHome({
  required NostrRelayService relay,
  required String hexPubkey,
  required String hexPrivKey,
  required Phi2xGeoTag geoTag,
  required double birthLat,
  required double birthLon,
  required String a4lProof,
  required int createdAt,
}) async {
  final List<List<String>> homeTags = <List<String>>[
    <String>['d',         'atom4love-home'],
    <String>['app',       'atom4love'],
    <String>['a4l_proof', a4lProof],
    <String>['g',         geoTag.penta],
    <String>['lat',       birthLat.toStringAsFixed(2)],
    <String>['lon',       birthLon.toStringAsFixed(2)],
  ];
  final Map<String, dynamic> homeEvent = <String, dynamic>{
    'kind':       30078,
    'pubkey':     hexPubkey,
    'created_at': createdAt,
    'tags':       homeTags,
    'content':    '',
  };
  final String homeId = NostrUtils.calculateEventId(homeEvent);
  homeEvent['id']  = homeId;
  homeEvent['sig'] = _signEvent(homeId, hexPrivKey);
  try {
    final bool homeOk = await relay.publishEvent(homeEvent);
    loggerDev('[AtomicDID] d=atom4love-home published: $homeOk'
        ' (${birthLat.toStringAsFixed(2)},${birthLon.toStringAsFixed(2)})');
  } catch (e) {
    loggerDev('[AtomicDID] d=atom4love-home error: $e');
  }
}

String _signEvent(String eventIdHex, String hexPrivateKey) {
  final Random rng = Random.secure();
  final Uint8List aux = Uint8List.fromList(
    List<int>.generate(32, (int _) => rng.nextInt(256)),
  );
  return bip340.sign(hexPrivateKey, eventIdHex, HEX.encode(aux));
}
