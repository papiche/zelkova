import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../env.dart';
import '../../g1/atomic_keys.dart';
import '../../g1/kin_calculator.dart';
import '../../g1/kin_sound.dart';
import '../../g1/multipass_service.dart';
import '../../g1/nostr/atomic_did_publisher.dart';
import '../../g1/zen_tag_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';
import '../widgets/location_picker_sheet.dart';

/// A station in the UPlanet SWARM that can host a MULTIPASS.
class _SwarmStation {
  const _SwarmStation({
    required this.label,
    required this.hostname,
    required this.city,
    required this.uspot,
    required this.myIpfs,
    required this.relay,
    required this.active,
    required this.lat,
    required this.lon,
    // Capacities
    required this.nostrSlots,
    required this.zencardSlots,
    required this.captainSlots,
    required this.availableSpaceGb,
    // Economy
    required this.ncardPrice,
    required this.zcardPrice,
    required this.multipassCount,
    required this.zencardCount,
    required this.paf,
    required this.machineValueZen,
    required this.bilan,
  });

  final String label;      // hostname – IPCity
  final String hostname;
  final String city;
  final String uspot;      // UPassport URL
  final String myIpfs;     // IPFS gateway
  final String relay;      // WSS NOSTR relay
  final bool active;       // upassport service running?
  final double lat;
  final double lon;
  // Capacities
  final int nostrSlots;    // Available MULTIPASS slots
  final int zencardSlots;
  final int captainSlots;
  final double availableSpaceGb;
  // Weekly economics
  final int ncardPrice;      // MULTIPASS weekly price (Ẑ/week)
  final int zcardPrice;      // ZenCard weekly price (Ẑ/week)
  final int multipassCount;  // active MULTIPASS users
  final int zencardCount;    // active ZenCard holders
  final int paf;             // weekly platform fee (Ẑ/week)
  final double machineValueZen; // machine purchase price (ZEN)
  final String bilan;       // weekly accounting balance

  static _SwarmStation? fromJson(Map<String, dynamic> m) {
    final String? uspot = m['uSPOT'] as String?;
    if (uspot == null || uspot.isEmpty) {
      return null;
    }
    final String host = m['hostname'] as String? ?? '';
    final String city = m['IPCity'] as String? ?? '';

    final Map<String, dynamic> cap =
        (m['capacities'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> storage =
        (cap['storage_details'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> root =
        (storage['root'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> svc =
        (m['services'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> up =
        (svc['upassport'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> eco =
        (m['economy'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final String label = <String>[
      if (host.isNotEmpty) host,
      if (city.isNotEmpty) city,
    ].join(' – ');

    return _SwarmStation(
      label: label.isNotEmpty ? label : uspot,
      hostname: host,
      city: city,
      uspot: uspot,
      myIpfs: m['myIPFS'] as String? ?? '',
      relay: m['myRELAY'] as String? ?? '',
      active: up['active'] as bool? ?? false,
      lat: double.tryParse(m['STATION_LAT'] as String? ?? '') ?? 0.0,
      lon: double.tryParse(m['STATION_LON'] as String? ?? '') ?? 0.0,
      // capacities
      nostrSlots: (cap['nostr_slots'] as num?)?.toInt() ?? 0,
      zencardSlots: (cap['zencard_slots'] as num?)?.toInt() ?? 0,
      captainSlots: (cap['reserved_captain_slots'] as num?)?.toInt() ?? 0,
      availableSpaceGb: (root['available_gb'] as num?)?.toDouble()
          ?? (cap['available_space_gb'] as num?)?.toDouble() ?? 0,
      // economics
      ncardPrice: int.tryParse(m['NCARD']?.toString() ?? '') ?? 0,
      zcardPrice: int.tryParse(m['ZCARD']?.toString() ?? '') ?? 0,
      multipassCount: (eco['multipass_count'] as num?)?.toInt() ?? 0,
      zencardCount: (eco['zencard_count'] as num?)?.toInt() ?? 0,
      paf: int.tryParse(m['PAF']?.toString() ?? '') ??
          (eco['captain_remuneration'] as num?)?.toInt() ?? 0,
      machineValueZen: double.tryParse(m['MACHINE_VALUE_ZEN']?.toString() ?? '')
          ?? 0.0,
      bilan: m['BILAN']?.toString() ?? '0',
    );
  }

  /// Haversine distance in km from [lat]/[lon].
  double distanceFrom(double fromLat, double fromLon) {
    const double r = 6371.0;
    final double dLat = (lat - fromLat) * math.pi / 180.0;
    final double dLon = (lon - fromLon) * math.pi / 180.0;
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(fromLat * math.pi / 180.0) *
            math.cos(lat * math.pi / 180.0) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    return r * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }
}

/// Résultat d'une recherche Nominatim (OpenStreetMap geocoding).
class _NominatimResult {
  const _NominatimResult({
    required this.name,
    required this.lat,
    required this.lon,
  });
  final String name;
  final double lat;
  final double lon;
}

/// Onboarding screen for first launch:
/// Page 0 — Accueil UPlanet (identité souveraine, monnaie libre)
/// Page 1 — Formulaire email + géolocalisation → création MULTIPASS
/// Page 2 — Profil ondulatoire ATOMIC (optionnel) : naissance, conception, KIN
/// Vue succès — Liens Open Collective personnalisés + bouton "C'est parti"
class WalletCreationScreen extends StatefulWidget {
  const WalletCreationScreen({super.key, this.initialEmail});

  /// Pré-remplit le champ email et passe directement à la page du formulaire.
  /// Utilisé quand on redirige depuis l'écran de récupération (email inconnu).
  final String? initialEmail;

  @override
  State<WalletCreationScreen> createState() => _WalletCreationScreenState();
}

class _WalletCreationScreenState extends State<WalletCreationScreen> {
  // PageController removed — contribution page skipped, form shown directly
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String _lat = '0.00';
  String _lon = '0.00';
  bool _geolocated = false;
  MultipassResponse? _result;

  // ── SWARM station selector ─────────────────────────────────────────────────
  List<_SwarmStation> _swarmStations = <_SwarmStation>[];
  bool _swarmLoading = false;
  String _selectedUspot = Env.upassportUrl; // URL used for MULTIPASS creation

  // ── ATOMIC birth profile (optional) ──────────────────────────────────────
  DateTime? _birthDate;
  TimeOfDay? _birthTime;
  double _birthWeight = 3.5;
  String _birthPlaceName = '';  // human-readable city label
  double _birthLat = 0.0;       // from Nominatim (0.01° precision)
  double _birthLon = 0.0;       // from Nominatim (0.01° precision)
  int _polarity = 0;            // 0 = homme, 1 = femme
  bool _pbkdf2Running = false;  // true pendant le calcul PBKDF2 (~10s)
  String _locationName = '';    // nom lisible de Ma Position (reverse geocode)

  // ── KIN + son personnel ───────────────────────────────────────────────────
  AudioPlayer? _audioPlayer;
  bool _soundPlaying = false;
  bool _nostrDidPublished = false;

  @override
  void initState() {
    super.initState();
    _loadSwarmStations();
    if (widget.initialEmail != null && widget.initialEmail!.isNotEmpty) {
      _emailController.text = widget.initialEmail!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  /// Load the SWARM station list from the main UPassport API endpoint.
  /// The JSON root contains the primary station fields + a SWARM array.
  Future<void> _loadSwarmStations() async {
    setState(() => _swarmLoading = true);
    try {
      final Uri uri = Uri.parse(Env.upassportUrl);
      final http.Response r =
          await http.get(uri).timeout(const Duration(seconds: 10));
      if (r.statusCode == 200) {
        final Map<String, dynamic> root =
            jsonDecode(r.body) as Map<String, dynamic>;

        final List<_SwarmStation> stations = <_SwarmStation>[];

        // Primary station — force active:true (we just reached it)
        final Map<String, dynamic> primaryMap =
            Map<String, dynamic>.from(root);
        primaryMap['services'] = <String, dynamic>{
          ...?(root['services'] as Map<String, dynamic>?),
          'upassport': <String, dynamic>{'active': true},
        };
        final _SwarmStation? primary = _SwarmStation.fromJson(primaryMap);
        if (primary != null) {
          stations.add(primary);
        }

        // SWARM stations — skip duplicates (same uSPOT already added as primary)
        final List<dynamic> swarm =
            root['SWARM'] as List<dynamic>? ?? <dynamic>[];
        for (final dynamic raw in swarm) {
          if (raw is Map<String, dynamic>) {
            final _SwarmStation? s = _SwarmStation.fromJson(raw);
            if (s != null &&
                !stations.any((_SwarmStation existing) =>
                    existing.uspot == s.uspot)) {
              stations.add(s);
            }
          }
        }

        // Exclure les stations localhost
        stations.removeWhere((_SwarmStation s) =>
            s.hostname.contains('127.0.0.1') ||
            s.uspot.contains('127.0.0.1'));

        // Tri initial : actives en premier avec shuffle aléatoire
        final math.Random initRng = math.Random();
        stations.sort((_SwarmStation a, _SwarmStation b) {
          if (a.active != b.active) {
            return a.active ? -1 : 1;
          }
          return initRng.nextBool() ? -1 : 1;
        });

        if (mounted) {
          setState(() {
            _swarmStations = stations;
            // Keep current selection if still in list, else pick primary
            if (stations.isNotEmpty &&
                !stations.any((_SwarmStation s) => s.uspot == _selectedUspot)) {
              _selectedUspot = stations.first.uspot;
            }
          });
        }
      }
    } catch (e) {
      loggerDev('SWARM load error: $e');
    } finally {
      if (mounted) {
        setState(() => _swarmLoading = false);
      }
    }
  }

  // ── Géolocalisation ────────────────────────────────────────────────────────

  Future<void> _requestGeolocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Pas de GPS → 0.00,0.00 acceptable (NIP-101/filter/1.sh gère)
        setState(() {
          _lat = '0.00';
          _lon = '0.00';
          _geolocated = true;
        });
        return;
      }
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.low),
      );
      setState(() {
        // Précision 0.01° (~1.1 km) pour la grille UMAP
        _lat = position.latitude.toStringAsFixed(2);
        _lon = position.longitude.toStringAsFixed(2);
        _geolocated = true;
      });
      // Re-sort SWARM by distance now that we have a real position
      _sortStationsByDistance(position.latitude, position.longitude);
      // Reverse geocode en arrière-plan pour le nom lisible
      _reverseGeocodePosition(position.latitude, position.longitude);
    } catch (e) {
      // Erreur GPS → fallback 0.00,0.00
      setState(() {
        _lat = '0.00';
        _lon = '0.00';
        _geolocated = true;
      });
    }
  }

  Future<void> _reverseGeocodePosition(double lat, double lon) async {
    try {
      final Uri uri = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse'
        '?lat=$lat&lon=$lon&format=json&accept-language=fr',
      );
      final http.Response r = await http.get(uri, headers: <String, String>{
        'User-Agent': 'Zelkova/1.0 UPlanet support@qo-op.com',
      }).timeout(const Duration(seconds: 5));
      if (r.statusCode == 200 && mounted) {
        final Map<String, dynamic> data =
            jsonDecode(r.body) as Map<String, dynamic>;
        final String raw = data['display_name'] as String? ?? '';
        final List<String> parts = raw.split(', ');
        if (mounted) {
          setState(() => _locationName = parts.take(3).join(', '));
        }
      }
    } catch (_) {}
  }

  /// Trie les stations : actives en premier, puis par distance haversine + jitter aléatoire.
  /// Les stations sans GPS sont poussées en fin de liste.
  void _sortStationsByDistance(double userLat, double userLon) {
    if (_swarmStations.isEmpty) {
      return;
    }
    // Jitter aléatoire stable pour ce tri (évite les comparateurs non-déterministes)
    final math.Random rng = math.Random();
    final Map<String, double> jitter = <String, double>{
      for (final _SwarmStation s in _swarmStations)
        s.uspot: rng.nextDouble() * 30.0, // jusqu'à 30 km de bruit
    };
    final List<_SwarmStation> sorted = List<_SwarmStation>.from(_swarmStations);
    sorted.sort((_SwarmStation a, _SwarmStation b) {
      // Stations actives (uptime) d'abord
      if (a.active != b.active) {
        return a.active ? -1 : 1;
      }
      final bool aNoGps = a.lat == 0 && a.lon == 0;
      final bool bNoGps = b.lat == 0 && b.lon == 0;
      if (aNoGps && bNoGps) {
        return ((jitter[a.uspot] ?? 0) - (jitter[b.uspot] ?? 0)).sign.toInt();
      }
      if (aNoGps) {
        return 1;
      }
      if (bNoGps) {
        return -1;
      }
      final double da = a.distanceFrom(userLat, userLon) + (jitter[a.uspot] ?? 0);
      final double db = b.distanceFrom(userLat, userLon) + (jitter[b.uspot] ?? 0);
      return da.compareTo(db);
    });
    setState(() {
      _swarmStations = sorted;
      _selectedUspot = sorted.firstWhere(
        (_SwarmStation s) => s.active,
        orElse: () => sorted.first,
      ).uspot;
    });
  }

  // ── Création du MULTIPASS ──────────────────────────────────────────────────

  Future<void> _createMultipass() async {
    // Form may be on a different page (ATOMIC flow) — fall back to direct check
    final FormState? form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Email requis.');
      return;
    }

    String computedSalt = '';
    String computedPepper = '';

    if (_birthDate != null) {
      setState(() {
        _isLoading = true;
        _pbkdf2Running = true;
        _errorMessage = null;
      });
      try {
        (computedSalt, computedPepper) = await _computeAtomicKeys();
      } catch (e) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isLoading = false;
          _pbkdf2Running = false;
          _errorMessage = 'Erreur cryptographique : $e';
        });
        return;
      }
      if (!mounted) {
        return;
      }
      setState(() => _pbkdf2Running = false);
    } else {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    await _doCreate(salt: computedSalt, pepper: computedPepper);
  }

  /// Dérive (salt, pepper) via PBKDF2-SHA256 dans un isolate séparé.
  Future<(String, String)> _computeAtomicKeys() async {
    final TimeOfDay t = _birthTime ?? const TimeOfDay(hour: 12, minute: 0);
    final DateTime localBirth = DateTime(
      _birthDate!.year, _birthDate!.month, _birthDate!.day, t.hour, t.minute,
    );
    final int utcOffset = _birthLon != 0.0 ? (_birthLon / 15).round() : 0;
    final String birthDtUtc = localToUtcStr(localBirth, utcOffset);
    final DateTime localCon = localBirth.subtract(const Duration(days: 280));
    final String conDtUtc = localToUtcStr(
      DateTime(localCon.year, localCon.month, localCon.day, 12),
      utcOffset,
    );
    final double lat = _birthLat != 0.0 ? _birthLat : (double.tryParse(_lat) ?? 0.0);
    final double lon = _birthLon != 0.0 ? _birthLon : (double.tryParse(_lon) ?? 0.0);
    return compute(
      computeAtomicKeyPair,
      (
        buildSaltRaw(birthDtUtc: birthDtUtc, birthLat: lat, birthLon: lon, polarity: _polarity, weight: _birthWeight),
        buildPepperRaw(conDtUtc: conDtUtc, conLat: lat, conLon: lon, weight: _birthWeight),
      ),
    );
  }

  static String _monthName(int month) {
    const List<String> names = <String>[
      '', 'jan.', 'fév.', 'mars', 'avr.', 'mai', 'juin',
      'juil.', 'août', 'sep.', 'oct.', 'nov.', 'déc.',
    ];
    return names[month];
  }

  /// Build the ISO-8601 birth datetime from state, or null if not set.
  String? _buildBirthDatetime() {
    if (_birthDate == null) {
      return null;
    }
    final TimeOfDay t = _birthTime ?? const TimeOfDay(hour: 12, minute: 0);
    return '${_birthDate!.year.toString().padLeft(4, '0')}'
        '-${_birthDate!.month.toString().padLeft(2, '0')}'
        '-${_birthDate!.day.toString().padLeft(2, '0')}'
        'T${t.hour.toString().padLeft(2, '0')}'
        ':${t.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _doCreate({String? passCode, String salt = '', String pepper = ''}) async {
    final String? birthPlace =
        _birthPlaceName.isNotEmpty ? _birthPlaceName : null;
    final String? birthWeight =
        _birthWeight != 3.5 ? _birthWeight.toStringAsFixed(1) : null;

    // Conception estimée : ~280 jours avant la naissance (harmonique).
    String? conceptionDatetime;
    String? conceptionPlace;
    if (_birthDate != null) {
      final DateTime conceived =
          _birthDate!.subtract(const Duration(days: 280));
      conceptionDatetime = '${conceived.year.toString().padLeft(4, '0')}'
          '-${conceived.month.toString().padLeft(2, '0')}'
          '-${conceived.day.toString().padLeft(2, '0')}'
          'T12:00';
      if (_birthLat != 0.0 || _birthLon != 0.0) {
        conceptionPlace =
            '${_birthLat.toStringAsFixed(2)}, ${_birthLon.toStringAsFixed(2)}';
      }
    }

    try {
      final MultipassResponse response = await MultipassService.createMultipass(
        email: _emailController.text.trim(),
        lang: context.locale.languageCode,
        lat: _lat,
        lon: _lon,
        serverUrl: _selectedUspot,
        passCode: passCode,
        salt: salt.isNotEmpty ? salt : null,
        pepper: pepper.isNotEmpty ? pepper : null,
        birthDatetime: _buildBirthDatetime(),
        birthPlace: birthPlace,
        birthWeight: birthWeight,
        conceptionDatetime: conceptionDatetime,
        conceptionPlace: conceptionPlace,
      );
      await _saveAndShowResult(response);
      _publishNostrDidAsync(response);
    } on MultipassExistsException {
      if (!mounted) {
        return;
      }
      setState(() => _isLoading = false);
      final String? code = await _showPassDialog();
      if (code == null || !mounted) {
        return;
      }
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      await _doCreate(passCode: code, salt: salt, pepper: pepper);
    } on MultipassInvalidPassException {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _errorMessage =
            "Code PASS incorrect. Vérifiez l'email reçu lors de la création de votre MULTIPASS.";
      });
    } on TimeoutException {
      logger('WalletCreationScreen: createMultipass timeout');
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Le serveur ne répond pas. Vérifiez votre connexion ou choisissez une autre station.';
      });
    } catch (e) {
      logger('WalletCreationScreen: createMultipass error: $e');
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _saveAndShowResult(MultipassResponse response) async {
    // Build matchUrl now (state still has birth data) so it can be persisted
    String? matchUrl;
    if (_birthDate != null) {
      final KinResult birthKin = calculateMayaKin(_birthDate!);
      final String url = _buildAtomicMatchUrl(birthKin);
      if (url.isNotEmpty) {
        matchUrl = url;
      }
    }

    await SharedPreferencesHelperV2().createMultipassAccount(
      salt: response.salt,
      pepper: response.pepper,
      nsec: response.nsec,
      npub: response.npub,
      nostrns: response.nostrns,
      ssssPlayer: response.ssssPlayer,
      email: response.email,
      isOrigin: response.isOrigin,
      uplanetHome: response.uplanetHome,
      ocUrls: <String, dynamic>{
        'satellite': response.ocUrls.satellite,
        'constellation': response.ocUrls.constellation,
        'cloud': response.ocUrls.cloud,
        'membre': response.ocUrls.membre,
      },
      uplanetnameG1: response.uplanetnameG1,
      matchUrl: matchUrl,
    );
    if (response.uplanetnameG1.isNotEmpty) {
      ZenTagService().setUplanetnameG1(response.uplanetnameG1);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _result = response;
      _isLoading = false;
    });
  }

  /// Show a dialog asking for the 4-digit PASS code.
  /// Returns the code string, or null if cancelled.
  Future<String?> _showPassDialog() async {
    final TextEditingController passCtrl = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('🔑 Code PASS'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Ce MULTIPASS existe déjà.\n'
                'Saisissez le code à 4 chiffres reçu par email lors de sa création.',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passCtrl,
                keyboardType: TextInputType.number,
                maxLength: 4,
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
                decoration: InputDecoration(
                  hintText: '••••',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(passCtrl.text.trim()),
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _openUrl(String url) async {
    if (url.isEmpty) {
      return;
    }
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _finishOnboarding() {
    // Mark intro as viewed so AppIntro is skipped for new MULTIPASS users
    try {
      context.read<AppCubit>().introViewed();
    } catch (_) {}
    // pushReplacementNamed('/') recreates AppStart which will now see isEmpty=false
    // and introViewed=true, so it goes directly to FeedbackAndSkeletonScreen
    Navigator.of(context).pushReplacementNamed('/');
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_result != null) {
      return _buildSuccessScreen();
    }
    return _buildFormPage();
  }

  // ── URLs Open Collective (défaut — personnalisées dans la vue succès) ──────

  static const String _ocCloudUrl =
      'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/cotisation-services-cloud-usage-98388';
  static const String _ocMembreUrl =
      'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/membre-resident-soutien-mensuel-98389';
  static const String _ocSatelliteUrl =
      'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/love-box-le-claude-53061';
  static const String _ocConstellationUrl =
      'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/love-box-deluxe-gpu-49182';

  // ── Formulaire email + géolocalisation ────────────────────────────────────

  Widget _buildFormPage() {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer mon MULTIPASS'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: <Widget>[
              Text(
                'Votre identité souveraine, vos clés cryptographiques et votre KIN Maya '
                'sont dérivés de vos données de naissance — récupérables sur tout appareil.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // ── Email ─────────────────────────────────────────────────────
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: tr('email'),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr('email_required');
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value.trim())) {
                    return tr('email_invalid');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ── Ma position (domicile) ────────────────────────────────────
              Text(
                'Ma position (domicile)',
                style: theme.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildLocationSection(),
              const SizedBox(height: 20),

              // ── Station Astroport ─────────────────────────────────────────
              if (_swarmLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else if (_swarmStations.isNotEmpty)
                _buildStationSelector(),
              const SizedBox(height: 24),

              // ── Séparateur Profil KIN ─────────────────────────────────────
              Row(
                children: <Widget>[
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '🌀 Profil KIN · Récupération & portabilité',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // ── Polarité ──────────────────────────────────────────────────
              Text('Polarité biologique',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              SegmentedButton<int>(
                segments: const <ButtonSegment<int>>[
                  ButtonSegment<int>(
                      value: 0,
                      label: Text('Homme'),
                      icon: Icon(Icons.male)),
                  ButtonSegment<int>(
                      value: 1,
                      label: Text('Femme'),
                      icon: Icon(Icons.female)),
                ],
                selected: <int>{_polarity},
                onSelectionChanged: (Set<int> s) =>
                    setState(() => _polarity = s.first),
                style: SegmentedButton.styleFrom(
                  minimumSize: const Size(0, 44),
                ),
              ),
              const SizedBox(height: 20),

              // ── Date de naissance * ───────────────────────────────────────
              Text('Date de naissance *',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final List<DateTime?>? result =
                      await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.single,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      selectedDayHighlightColor: theme.colorScheme.primary,
                      centerAlignModePicker: true,
                      animateToDisplayedMonthDate: true,
                    ),
                    dialogSize: const Size(340, 420),
                    value: <DateTime?>[_birthDate],
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  );
                  if (result != null && result.isNotEmpty && result.first != null) {
                    setState(() => _birthDate = result.first);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _birthDate != null
                          ? theme.colorScheme.primary.withValues(alpha: 0.6)
                          : theme.colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: _birthDate != null
                        ? theme.colorScheme.primary.withValues(alpha: 0.04)
                        : null,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: _birthDate != null
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _birthDate != null
                            ? Text(
                                '${_birthDate!.day.toString().padLeft(2, '0')} '
                                '${_monthName(_birthDate!.month)} '
                                '${_birthDate!.year}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              )
                            : Text(
                                'Choisir une date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                      ),
                      Icon(
                        Icons.edit_calendar_outlined,
                        size: 18,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Heure de naissance (optionnelle) ──────────────────────────
              Text('Heure de naissance (optionnelle)',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  DateTime tempTime = DateTime(
                    2000, 1, 1,
                    _birthTime?.hour ?? 12,
                    _birthTime?.minute ?? 0,
                  );
                  await showModalBottomSheet<void>(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (BuildContext ctx) => SizedBox(
                      height: 280,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: Text(tr('cancel')),
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Heure de naissance',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() => _birthTime = TimeOfDay(
                                            hour: tempTime.hour,
                                            minute: tempTime.minute,
                                          ));
                                    }
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('OK',
                                      style:
                                          TextStyle(fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              initialDateTime: tempTime,
                              onDateTimeChanged: (DateTime dt) =>
                                  tempTime = dt,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _birthTime != null
                          ? theme.colorScheme.secondary.withValues(alpha: 0.6)
                          : theme.colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: _birthTime != null
                        ? theme.colorScheme.secondary.withValues(alpha: 0.04)
                        : null,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                        size: 20,
                        color: _birthTime != null
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _birthTime != null
                            ? Text(
                                '${_birthTime!.hour.toString().padLeft(2, '0')}h'
                                '${_birthTime!.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.secondary,
                                ),
                              )
                            : Text(
                                'Heure inconnue (midi par défaut)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Lieu de naissance * ───────────────────────────────────────
              Text('Lieu de naissance *',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Autocomplete<_NominatimResult>(
                      optionsBuilder: (TextEditingValue tv) =>
                          _searchNominatim(tv.text),
                      displayStringForOption: (_NominatimResult r) => r.name,
                      onSelected: (_NominatimResult r) {
                        setState(() {
                          _birthPlaceName = r.name;
                          _birthLat = double.parse(r.lat.toStringAsFixed(2));
                          _birthLon = double.parse(r.lon.toStringAsFixed(2));
                        });
                      },
                      fieldViewBuilder: (
                        BuildContext ctx,
                        TextEditingController fieldCtrl,
                        FocusNode focusNode,
                        VoidCallback onSubmitted,
                      ) {
                        if (_birthPlaceName.isNotEmpty && fieldCtrl.text.isEmpty) {
                          fieldCtrl.text = _birthPlaceName;
                        }
                        return TextField(
                          controller: fieldCtrl,
                          focusNode: focusNode,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Ville de naissance…',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        );
                      },
                      optionsViewBuilder: (
                        BuildContext ctx,
                        AutocompleteOnSelected<_NominatimResult> onSelected,
                        Iterable<_NominatimResult> options,
                      ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(10),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children: options.map((_NominatimResult r) {
                                  return ListTile(
                                    dense: true,
                                    leading: const Icon(Icons.place, size: 16),
                                    title: Text(r.name,
                                        style: const TextStyle(fontSize: 13)),
                                    subtitle: Text(
                                      '${r.lat.toStringAsFixed(2)}°, '
                                      '${r.lon.toStringAsFixed(2)}°',
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                    onTap: () => onSelected(r),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () async {
                      final LocationPickerResult? result =
                          await showLocationPicker(
                        context: context,
                        initialLat: _birthLat,
                        initialLon: _birthLon,
                        title: 'Lieu de naissance',
                      );
                      if (result != null && mounted) {
                        setState(() {
                          _birthPlaceName = result.name;
                          _birthLat = result.lat;
                          _birthLon = result.lon;
                        });
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Icon(Icons.map_outlined, size: 22),
                  ),
                ],
              ),
              // Mini-carte lieu de naissance
              if (_birthPlaceName.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.green.withValues(alpha: 0.4)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(_birthLat, _birthLon),
                            initialZoom: 10.0,
                            interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.none,
                            ),
                          ),
                          children: <Widget>[
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.zelkova.app',
                            ),
                            PolygonLayer<Object>(
                              polygons: <Polygon<Object>>[
                                Polygon<Object>(
                                  points: <LatLng>[
                                    LatLng(_birthLat, _birthLon),
                                    LatLng(_birthLat + 0.01, _birthLon),
                                    LatLng(_birthLat + 0.01, _birthLon + 0.01),
                                    LatLng(_birthLat, _birthLon + 0.01),
                                  ],
                                  color: Colors.green.withValues(alpha: 0.2),
                                  borderStrokeWidth: 2,
                                  borderColor: Colors.green.shade700,
                                ),
                              ],
                            ),
                            MarkerLayer(
                              markers: <Marker>[
                                Marker(
                                  point: LatLng(_birthLat, _birthLon),
                                  width: 32,
                                  height: 32,
                                  child: const Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.green.shade700.withValues(alpha: 0.08),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.place,
                                color: Colors.green, size: 14),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _birthPlaceName,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade700
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '⬡ ${_birthLat.toStringAsFixed(2)}_${_birthLon.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green.shade800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // ── Poids de naissance ────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Poids de naissance',
                      style: theme.textTheme.labelLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    '${_birthWeight.toStringAsFixed(1)} kg',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Slider(
                value: _birthWeight,
                min: 0.5,
                max: 6.0,
                divisions: 55,
                label: '${_birthWeight.toStringAsFixed(1)} kg',
                onChanged: (double v) => setState(() => _birthWeight = v),
              ),
              const SizedBox(height: 8),

              // ── Aperçu KIN en temps réel (dès que la date est saisie) ─────
              if (_birthDate != null) ...<Widget>[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      const Text('🌀', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Votre signature KIN',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (_birthPlaceName.isEmpty)
                        Text(
                          '(lieu requis pour finaliser)',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.45),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
                _buildKinCard(
                  kin: calculateMayaKin(_birthDate!),
                  label: 'Naissance',
                ),
                const SizedBox(height: 8),
                _buildKinCard(
                  kin: calculateConceptionKin(_birthDate!, weight: _birthWeight),
                  label: 'Conception',
                  secondary: true,
                ),
                // Bouton partage MATCH dès que le lieu est connu
                if (_birthPlaceName.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 10),
                  _buildMatchShareSection(
                    _buildAtomicMatchUrl(calculateMayaKin(_birthDate!)),
                  ),
                ],
                const SizedBox(height: 8),
              ],

              // ── Hint si champs obligatoires manquants ─────────────────────
              if (_birthDate == null || _birthPlaceName.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '* ${_birthDate == null ? "Date de naissance requise." : ""}'
                    '${_birthDate == null && _birthPlaceName.isEmpty ? " " : ""}'
                    '${_birthPlaceName.isEmpty ? "Lieu de naissance requis." : ""}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error.withValues(alpha: 0.7),
                    ),
                  ),
                ),

              // ── Erreur ────────────────────────────────────────────────────
              if (_errorMessage != null) ...<Widget>[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                        color: theme.colorScheme.error, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // ── Bouton créer ──────────────────────────────────────────────
              if (_pbkdf2Running)
                const Center(child: _Pbkdf2Loader())
              else if (_isLoading)
                const Center(child: _MultipassCreationLoader())
              else
                ElevatedButton.icon(
                  onPressed: (_isLoading || _pbkdf2Running) ? null : _createMultipass,
                  icon: const Text('✨', style: TextStyle(fontSize: 18)),
                  label: const Text(
                    'Initialiser mon MULTIPASS',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Station selector ───────────────────────────────────────────────────────
  // Shows the SWARM list fetched from {Env.upassportUrl}.
  // Each item displays: label (hostname – IPCity), available MULTIPASS slots,
  // and an active/inactive badge for the UPassport service.
  // The selected station's uSPOT URL is used in _createMultipass().

  Widget _buildStationSelector() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('swarm_station_title'),
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _selectedUspot,
                isExpanded: true,
                borderRadius: BorderRadius.circular(14),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                items: _swarmStations
                    .map((_SwarmStation s) => DropdownMenuItem<String>(
                          value: s.uspot,
                          child: _buildStationItem(s, theme, cs),
                        ))
                    .toList(),
                onChanged: (String? v) {
                  if (v != null) {
                    setState(() => _selectedUspot = v);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStationItem(
      _SwarmStation s, ThemeData theme, ColorScheme cs) {
    final bool hasSlots = s.active;
    final int bilanInt = int.tryParse(s.bilan) ?? 0;
    final Color bilanColor = bilanInt >= 0 ? Colors.green : Colors.red;
    return Row(
      children: <Widget>[
        // Active / inactive dot
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: s.active ? Colors.green : Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // hostname – city
              Text(
                s.label,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              // PAF + BILAN + NCARD/ZCARD summary
              Text(
                'PAF ${s.paf}Ẑ/sem · ${s.multipassCount}MP · ${s.zencardCount}ZC · '
                'bilan ${bilanInt > 0 ? '+' : ''}${s.bilan}Ẑ',
                style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.55)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        // Slot badge + info button
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: hasSlots ? cs.primaryContainer : cs.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                s.availableSpaceGb > 0
                    ? '${s.availableSpaceGb.toStringAsFixed(0)}Go'
                    : '${s.multipassCount}MP',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: hasSlots ? cs.onPrimaryContainer : cs.onErrorContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                ),
              ),
            ),
            if (bilanInt != 0)
              Text(
                '${bilanInt > 0 ? '+' : ''}${s.bilan}Ẑ',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: bilanColor, fontSize: 9),
              ),
          ],
        ),
        // ℹ️ opens the Astroport detail sheet
        GestureDetector(
          onTap: () => _showStationDetail(s),
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Icon(Icons.info_outline, size: 16,
                color: cs.onSurface.withValues(alpha: 0.45)),
          ),
        ),
      ],
    );
  }

  // ── Astroport detail sheet ──────────────────────────────────────────────────

  void _showStationDetail(_SwarmStation s) {
    final int bilanInt = int.tryParse(s.bilan) ?? 0;
    final Color bilanColor = bilanInt >= 0 ? Colors.green : Colors.red;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        final ThemeData theme = Theme.of(ctx);
        final ColorScheme cs = theme.colorScheme;
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, ScrollController scroll) => Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ListView(
              controller: scroll,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: <Widget>[
                // Handle
                Center(
                  child: Container(
                    width: 40, height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: cs.onSurface.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Header
                Row(
                  children: <Widget>[
                    Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                          color: s.active ? Colors.green : Colors.orange,
                          shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        s.label,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                if (s.city.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(s.city,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
                ],
                const Divider(height: 24),

                // URLs
                _detailSection(theme, cs, '🌐 Accès', <Widget>[
                  _detailRow(theme, cs, 'UPassport', s.uspot),
                  _detailRow(theme, cs, 'IPFS',     s.myIpfs),
                  _detailRow(theme, cs, 'Relay',    s.relay),
                  if (s.lat != 0 || s.lon != 0)
                    _detailRow(theme, cs, 'GPS',
                        '${s.lat.toStringAsFixed(2)}°, ${s.lon.toStringAsFixed(2)}°'),
                ]),

                // Capacities
                _detailSection(theme, cs, '📦 Capacités', <Widget>[
                  _detailRow(theme, cs, 'MULTIPASS actifs',
                      '${s.multipassCount}'),
                  _detailRow(theme, cs, 'ZenCard actifs',
                      '${s.zencardCount}'),
                  _detailRow(theme, cs, 'Réservés capitaine',
                      '${s.captainSlots}'),
                  _detailRow(theme, cs, 'Espace disque',
                      '${s.availableSpaceGb.toStringAsFixed(0)} Go'),
                ]),

                // Economy
                _detailSection(theme, cs, '💰 Économie hebdomadaire', <Widget>[
                  _detailRow(theme, cs, 'MULTIPASS actifs', '${s.multipassCount}'),
                  _detailRow(theme, cs, 'ZenCards actifs',  '${s.zencardCount}'),
                  _detailRow(theme, cs, 'Tarif MULTIPASS', '${s.ncardPrice} Ẑ/sem'),
                  _detailRow(theme, cs, 'Tarif ZenCard', '${s.zcardPrice} Ẑ/sem'),
                  _detailRow(theme, cs, 'PAF (prélèvement)', '${s.paf} Ẑ/sem'),
                  _detailRow(theme, cs, 'Valeur machine',
                      '${s.machineValueZen.toStringAsFixed(0)} Ẑ'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Bilan comptable',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: cs.onSurface.withValues(alpha: 0.65))),
                      Text(
                        '${bilanInt > 0 ? '+' : ''}${s.bilan} Ẑ/sem',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: bilanColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ]),

                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _selectedUspot = s.uspot);
                    Navigator.pop(ctx);
                  },
                  child: Text(tr('swarm_station_select')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailSection(ThemeData t, ColorScheme cs, String title,
      List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: t.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface.withValues(alpha: 0.7))),
        const SizedBox(height: 6),
        ...rows,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _detailRow(ThemeData t, ColorScheme cs, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(label,
                style: t.textTheme.bodySmall
                    ?.copyWith(color: cs.onSurface.withValues(alpha: 0.65))),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: t.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Ma Position — boutons Détecter / Carte + chip résultat + mini-map A4L
  Widget _buildLocationSection() {
    final bool isDefault = _lat == '0.00' && _lon == '0.00';
    final double lat = double.tryParse(_lat) ?? 0.0;
    final double lon = double.tryParse(_lon) ?? 0.0;
    final double lat2d = ((lat * 100).round()) / 100.0;
    final double lon2d = ((lon * 100).round()) / 100.0;
    final String a4lCode =
        '${lat2d.toStringAsFixed(2)}_${lon2d.toStringAsFixed(2)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── Boutons ────────────────────────────────────────────────────────
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _requestGeolocation,
                icon: const Icon(Icons.my_location, size: 17),
                label: Text(tr('get_location'),
                    style: const TextStyle(fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 46),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final LocationPickerResult? result =
                      await showLocationPicker(
                    context: context,
                    initialLat: lat,
                    initialLon: lon,
                    title: 'Ma Position',
                  );
                  if (result != null && mounted) {
                    setState(() {
                      _lat = result.lat.toStringAsFixed(2);
                      _lon = result.lon.toStringAsFixed(2);
                      _locationName = result.name;
                      _geolocated = true;
                    });
                    _sortStationsByDistance(result.lat, result.lon);
                  }
                },
                icon: const Icon(Icons.map_outlined, size: 17),
                label: const Text('🗺️ Carte',
                    style: TextStyle(fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 46),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),

        // ── Résultat ───────────────────────────────────────────────────────
        if (_geolocated) ...<Widget>[
          const SizedBox(height: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDefault
                  ? Colors.orange.withValues(alpha: 0.08)
                  : Colors.green.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDefault
                    ? Colors.orange.withValues(alpha: 0.35)
                    : Colors.green.withValues(alpha: 0.35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      isDefault ? Icons.location_off : Icons.location_on,
                      color: isDefault ? Colors.orange : Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _locationName.isNotEmpty
                            ? _locationName
                            : isDefault
                                ? '0.00°, 0.00° (par défaut)'
                                : '$_lat°, $_lon°',
                        style: TextStyle(
                          color:
                              isDefault ? Colors.orange.shade700 : Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (!isDefault) ...<Widget>[
                  const SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade700.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color:
                                  Colors.green.shade700.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          '⬡ $a4lCode',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.green.shade800),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$_lat°, $_lon°',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.green.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                  // ── Mini-map A4L ─────────────────────────────────────────
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 130,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(lat2d, lon2d),
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                        ),
                        children: <Widget>[
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.zelkova.app',
                          ),
                          PolygonLayer<Object>(
                            polygons: <Polygon<Object>>[
                              Polygon<Object>(
                                points: <LatLng>[
                                  LatLng(lat2d, lon2d),
                                  LatLng(lat2d + 0.01, lon2d),
                                  LatLng(lat2d + 0.01, lon2d + 0.01),
                                  LatLng(lat2d, lon2d + 0.01),
                                ],
                                color: Colors.green.withValues(alpha: 0.2),
                                borderStrokeWidth: 2.5,
                                borderColor: Colors.green.shade700,
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: <Marker>[
                              Marker(
                                point: LatLng(lat2d, lon2d),
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Vue succès ─────────────────────────────────────────────────────────────

  Widget _buildSuccessScreen() {
    final OcUrls ocUrls = _result!.ocUrls;
    final bool hasBatisseur =
        ocUrls.satellite.isNotEmpty || ocUrls.constellation.isNotEmpty;
    final bool hasExplorateur =
        ocUrls.cloud.isNotEmpty || ocUrls.membre.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: <Widget>[
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    tr('multipass_created_title'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tr('multipass_created_description'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                  ),
                  // ── Rappel EMAIL + boutons OC prioritaires ──────────────────
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(Icons.email, color: Colors.green, size: 20),
                        const SizedBox(height: 6),
                        const Text(
                          'Rechargez avec cet email :',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          // Fallback: utilise l'email du formulaire si la
                          // réponse API ne le retourne pas
                          _emailController.text.trim().isNotEmpty
                              ? _emailController.text.trim()
                              : (_result!.email.isNotEmpty
                                  ? _result!.email
                                  : '—'),
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.green),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '⚠️ Utilisez exactement cet email sur OpenCollective\n'
                          'pour que votre recharge soit créditée automatiquement.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.65),
                              height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Recharge ponctuelle (priorité)
                  _buildOcTile(
                    icon: Icons.cloud,
                    title: tr('subscription_recharge_title'),
                    subtitle: 'Montant libre · Crédité immédiatement',
                    url: ocUrls.cloud.isNotEmpty
                        ? ocUrls.cloud
                        : _ocCloudUrl,
                  ),
                  _buildOcTile(
                    icon: Icons.autorenew,
                    title: tr('subscription_monthly_title'),
                    subtitle: '5 Ẑ/semaine · Accès continu',
                    url: ocUrls.membre.isNotEmpty
                        ? ocUrls.membre
                        : _ocMembreUrl,
                  ),
                  // ── Options de parrainage (optionnel) ───────────────────
                  const SizedBox(height: 20),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '🤝 Pour aller plus loin (optionnel)',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.7)),
                    ),
                  ),
                  Text(
                    'Financez une station physique et recevez 1/3 sur votre MULTIPASS,\n'
                    '1/3 pour le maintien du réseau, 1/3 pour le développement UPlanet ẐEN.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.55),
                          height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  _buildOcTile(
                    icon: Icons.satellite_alt,
                    title: '♥BOX · Parrain Station (50 € / an)',
                    subtitle: '128 Go · 33% MULTIPASS · 33% maintien · 33% R&D',
                    url: ocUrls.satellite.isNotEmpty
                        ? ocUrls.satellite
                        : _ocSatelliteUrl,
                  ),
                  _buildOcTile(
                    icon: Icons.memory,
                    title: '♥BOX Deluxe · Parrain IA (540 € / 3 ans)',
                    subtitle: 'GPU 24 Go · même répartition 33/33/33/1%',
                    url: ocUrls.constellation.isNotEmpty
                        ? ocUrls.constellation
                        : _ocConstellationUrl,
                  ),
                  // ─────────────────────────────────────────────────────────
                  if (_result!.isOrigin) ...<Widget>[
                    const SizedBox(height: 12),
                    Center(
                      child: Chip(
                        avatar: const Icon(Icons.science, size: 16),
                        label: Text(tr('origin_mode_label')),
                        backgroundColor: Colors.orange.shade100,
                      ),
                    ),
                  ],
                  if (hasBatisseur) ...<Widget>[
                    const SizedBox(height: 24),
                    Text(
                      tr('tier_batisseur_title'),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr('tier_batisseur_desc'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (ocUrls.satellite.isNotEmpty)
                      _buildOcTile(
                        icon: Icons.satellite_alt,
                        title: tr('subscription_satellite_title'),
                        subtitle: tr('subscription_satellite_desc'),
                        url: ocUrls.satellite,
                      ),
                    if (ocUrls.constellation.isNotEmpty)
                      _buildOcTile(
                        icon: Icons.memory,
                        title: tr('subscription_constellation_title'),
                        subtitle: tr('subscription_constellation_desc'),
                        url: ocUrls.constellation,
                      ),
                  ],
                  if (hasExplorateur) ...<Widget>[
                    const SizedBox(height: 16),
                    Text(
                      tr('tier_explorateur_title'),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr('tier_explorateur_desc'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (ocUrls.cloud.isNotEmpty)
                      _buildOcTile(
                        icon: Icons.bolt,
                        title: tr('subscription_recharge_title'),
                        subtitle: tr('subscription_recharge_desc'),
                        url: ocUrls.cloud,
                      ),
                    if (ocUrls.membre.isNotEmpty)
                      _buildOcTile(
                        icon: Icons.autorenew,
                        title: tr('subscription_monthly_title'),
                        subtitle: tr('subscription_monthly_desc'),
                        url: ocUrls.membre,
                      ),
                  ],
                  if (_birthDate != null) ...<Widget>[
                    const SizedBox(height: 16),
                    const Divider(),
                    _buildKinSection(),
                  ],
                  if (_result!.uplanetHome.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 16),
                    const Divider(),
                    _buildOcTile(
                      icon: Icons.public,
                      title: tr('uplanet_home_title'),
                      subtitle: tr('uplanet_home_desc'),
                      url: _result!.uplanetHome,
                    ),
                  ],
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _finishOnboarding,
        label: Text(tr('done')),
        icon: const Icon(Icons.rocket_launch),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ── KIN : affichage et son ────────────────────────────────────────────────

  Widget _buildKinSection() {
    final DateTime birth      = _birthDate!;
    final KinResult birthKin  = calculateMayaKin(birth);
    final KinResult concepKin = calculateConceptionKin(birth, weight: _birthWeight);
    final String matchUrl     = _buildAtomicMatchUrl(birthKin);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── En-tête ───────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              const Text('🌀', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'KIN Tzolkin · Signature vibratoire',
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              if (_nostrDidPublished)
                Chip(
                  label: const Text('NOSTR ✓',
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                  backgroundColor: Colors.purple.shade400,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ),

        // ── Cartes KIN ───────────────────────────────────────────────────
        _buildKinCard(kin: birthKin, label: 'Naissance'),
        const SizedBox(height: 8),
        _buildKinCard(kin: concepKin, label: 'Conception', secondary: true),
        const SizedBox(height: 12),

        // ── Son personnel ────────────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _soundPlaying ? null : () => _playKinSound(birthKin),
            icon: _soundPlaying
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.music_note, size: 18),
            label: Text(
              _soundPlaying ? 'Lecture en cours…' : 'Jouer ma signature sonore',
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: TextButton.icon(
            onPressed: () => _openUrl(
              '${_result!.uplanetHome.isNotEmpty ? _result!.uplanetHome : _selectedUspot}/atomic',
            ),
            icon: const Icon(Icons.open_in_new, size: 14),
            label: const Text('Voir mon profil complet en ligne',
                style: TextStyle(fontSize: 12)),
          ),
        ),

        // ── Lien MATCH ───────────────────────────────────────────────────
        if (matchUrl.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          _buildMatchShareSection(matchUrl),
        ],
      ],
    );
  }

  /// Construit l'URL de partage MATCH pour atomic_match.html.
  /// Paramètres attendus par la page JS :
  ///   d=YYYYMMDD · t=HHMM · lo=lonInt · k=kinNum · n=displayName
  /// Construit l'URL MATCH — utilisable dès la saisie (avant création) et dans l'écran succès.
  /// Priorité base URL : uplanetHome (post-création) > _selectedUspot (pré-création).
  String _buildAtomicMatchUrl(KinResult birthKin) {
    if (_birthDate == null) {
      return '';
    }

    final String d = '${_birthDate!.year.toString().padLeft(4, '0')}'
        '${_birthDate!.month.toString().padLeft(2, '0')}'
        '${_birthDate!.day.toString().padLeft(2, '0')}';

    final TimeOfDay t = _birthTime ?? const TimeOfDay(hour: 12, minute: 0);
    final String time =
        '${t.hour.toString().padLeft(2, '0')}${t.minute.toString().padLeft(2, '0')}';

    final double lonRaw =
        _birthLon != 0.0 ? _birthLon : (double.tryParse(_lon) ?? 0.0);
    final int lo = lonRaw.round();

    final String email = _emailController.text.trim();
    final String name = email.isNotEmpty
        ? (email.contains('@') ? email.split('@').first : email)
        : 'moi';

    String base = (_result?.uplanetHome.isNotEmpty ?? false)
        ? _result!.uplanetHome
        : _selectedUspot;
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }

    return '$base/earth/atomic_match.html'
        '?d=$d&t=$time&lo=$lo&k=${birthKin.kin}&n=${Uri.encodeComponent(name)}';
  }

  /// Widget de partage du lien MATCH.
  Widget _buildMatchShareSection(String url) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final String name = _emailController.text.trim().split('@').first;
    final String viralMsg =
        '💫 Calcule notre résonance cosmique !\n\n'
        'Saisis ta date de naissance sur ce lien — le calcul phi2x est fait '
        "localement sur ton appareil, aucune donnée n'est transmise.\n\n"
        '👇 Clique ici pour révéler notre cohérence :\n$url';
    final String waUrl =
        'https://wa.me/?text=${Uri.encodeComponent(viralMsg)}';
    final String tgText =
        "💫 $name t'invite à révéler votre résonance cosmique phi2x — 100% local & confidentiel";
    final String tgUrl =
        'https://t.me/share/url?url=${Uri.encodeComponent(url)}'
        '&text=${Uri.encodeComponent(tgText)}';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Titre ──────────────────────────────────────────────────────
          Row(
            children: <Widget>[
              const Text('💫', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Mon lien de résonance',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple.shade200,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Tes ami·es saisissent leur date de naissance — la résonance phi2x '
            'est calculée localement, sans serveur, sans données transmises.',
            style: TextStyle(
              fontSize: 11,
              height: 1.4,
              color: cs.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 10),

          // ── URL prévisualisée (tap = copier) ──────────────────────────
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: url));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lien copié'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                url,
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: cs.onSurface.withValues(alpha: 0.55),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // ── Boutons partage ────────────────────────────────────────────
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              // WhatsApp
              _shareButton(
                color: const Color(0xFF25D366),
                icon: Icons.chat,
                label: 'WhatsApp',
                onTap: () => _openUrl(waUrl),
              ),
              // Telegram
              _shareButton(
                color: const Color(0xFF2AABEE),
                icon: Icons.send,
                label: 'Telegram',
                onTap: () => _openUrl(tgUrl),
              ),
              // Copier URL brute
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lien copié'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.copy, size: 14),
                label: const Text('Copier', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              // Tester dans navigateur
              OutlinedButton.icon(
                onPressed: () => _openUrl(url),
                icon: const Icon(Icons.open_in_new, size: 14),
                label: const Text('Tester', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  foregroundColor: Colors.deepPurple.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shareButton({
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 11)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 34),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildKinCard({
    required KinResult kin,
    required String label,
    bool secondary = false,
  }) {
    final Color accent = _kinColor(kin.color);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: secondary ? 0.05 : 0.09),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: accent.withValues(alpha: secondary ? 0.25 : 0.4),
            width: secondary ? 1.0 : 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'KIN ${kin.kin} • ${kin.color}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                kin.glyph,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: accent),
              ),
              const SizedBox(width: 8),
              Text(
                'Tone ${kin.toneNumber} — ${kin.tone}',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7)),
              ),
            ],
          ),
          if (!secondary) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              '${kin.action} · ${kin.power} · ${kin.essence}',
              style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.55)),
            ),
          ],
        ],
      ),
    );
  }

  Color _kinColor(String color) {
    switch (color) {
      case 'Rouge':
        return Colors.red.shade600;
      case 'Blanc':
        return Colors.blueGrey.shade400;
      case 'Bleu':
        return Colors.blue.shade600;
      case 'Jaune':
        return Colors.amber.shade700;
      case 'Vert':
        return Colors.green.shade600;
      default:
        return Colors.indigo.shade400;
    }
  }

  Future<void> _playKinSound(KinResult birthKin) async {
    if (_soundPlaying) {
      return;
    }
    setState(() => _soundPlaying = true);
    try {
      await _audioPlayer?.dispose();
      _audioPlayer = await playKinSound(birthKin.toneNumber, _polarity, _birthWeight);
      _audioPlayer?.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() => _soundPlaying = false);
        }
      });
    } catch (e) {
      loggerDev('KIN sound error: $e');
      if (mounted) {
        setState(() => _soundPlaying = false);
      }
    }
  }

  void _publishNostrDidAsync(MultipassResponse response) {
    if (response.nsec.isEmpty) {
      return;
    }
    final String relayUrl = _swarmStations
            .where((_SwarmStation s) => s.relay.isNotEmpty)
            .map((_SwarmStation s) => s.relay)
            .firstOrNull ??
        '';
    if (relayUrl.isEmpty) {
      return;
    }

    final KinResult? birthKin =
        _birthDate != null ? calculateMayaKin(_birthDate!) : null;
    final KinResult? concepKin =
        _birthDate != null ? calculateConceptionKin(_birthDate!) : null;

    // Timestamp Unix UTC de naissance (pour calcul phase φ)
    int? birthUnix;
    if (_birthDate != null) {
      final TimeOfDay t = _birthTime ?? const TimeOfDay(hour: 12, minute: 0);
      final DateTime bDt = DateTime.utc(
          _birthDate!.year, _birthDate!.month, _birthDate!.day, t.hour, t.minute);
      birthUnix = bDt.millisecondsSinceEpoch ~/ 1000;
    }
    // Lieu de naissance : saisi dans le formulaire ou position GPS si absent
    final double bLat = _birthLat != 0.0 ? _birthLat : (double.tryParse(_lat) ?? 0.0);
    final double bLon = _birthLon != 0.0 ? _birthLon : (double.tryParse(_lon) ?? 0.0);
    // Résidence actuelle : GPS device (_lat/_lon), distinct du lieu de naissance
    final double gpsLat = double.tryParse(_lat) ?? 0.0;
    final double gpsLon = double.tryParse(_lon) ?? 0.0;

    publishAtomicDid(
      nsec: response.nsec,
      relayUrl: relayUrl,
      birthUnix: birthUnix,
      birthLat: bLat,
      birthLon: bLon,
      homeLat: gpsLat,
      homeLon: gpsLon,
      weightKg: _birthWeight,
      polarity: _polarity,
      birthKin: birthKin,
      conceptionKin: concepKin,
      email: response.email,
    ).then((bool ok) {
      if (ok && mounted) {
        setState(() => _nostrDidPublished = true);
      }
    });
  }

  // ── Nominatim geocoding ────────────────────────────────────────────────────

  Future<Iterable<_NominatimResult>> _searchNominatim(String query) async {
    if (query.trim().length < 3) {
      return const <_NominatimResult>[];
    }
    try {
      final Uri uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
        '?q=${Uri.encodeComponent(query.trim())}'
        '&format=json&limit=5&accept-language=fr',
      );
      final http.Response r = await http.get(uri, headers: <String, String>{
        'User-Agent': 'Zelkova/1.0 UPlanet support@qo-op.com',
        'Accept-Language': 'fr',
      }).timeout(const Duration(seconds: 6));
      if (r.statusCode != 200) {
        return const <_NominatimResult>[];
      }
      final List<dynamic> data = jsonDecode(r.body) as List<dynamic>;
      return data.map((dynamic e) {
        final Map<String, dynamic> m = e as Map<String, dynamic>;
        final List<String> parts =
            (m['display_name'] as String).split(', ');
        final String name = parts.take(3).join(', ');
        return _NominatimResult(
          name: name,
          lat: double.parse(m['lat'] as String),
          lon: double.parse(m['lon'] as String),
        );
      });
    } catch (_) {
      return const <_NominatimResult>[];
    }
  }


  Widget _buildOcTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.open_in_new, size: 16),
        onTap: () => _openUrl(url),
      ),
    );
  }
}

// ── Animation PBKDF2 : cadenas pulsant ────────────────────────────────────────

class _Pbkdf2Loader extends StatefulWidget {
  const _Pbkdf2Loader();

  @override
  State<_Pbkdf2Loader> createState() => _Pbkdf2LoaderState();
}

class _Pbkdf2LoaderState extends State<_Pbkdf2Loader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ScaleTransition(
            scale: _scale,
            child: const Text('🔐', style: TextStyle(fontSize: 48)),
          ),
          const SizedBox(height: 12),
          const Text(
            'Dérivation des clés ATOMIC…',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'PBKDF2-SHA256 · 600 000 itérations · ~10s',
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
          const SizedBox(height: 10),
          Text(
            'Les clés sont calculées sur votre appareil.\n'
            'Ce calcul garantit la récupérabilité de votre MULTIPASS.',
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Animation d'attente : tourbillon de personnes ─────────────────────────────

class _MultipassCreationLoader extends StatefulWidget {
  const _MultipassCreationLoader();

  @override
  State<_MultipassCreationLoader> createState() =>
      _MultipassCreationLoaderState();
}

class _MultipassCreationLoaderState extends State<_MultipassCreationLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _spin;
  int _step = 0;
  Timer? _timer;

  static const List<List<String>> _steps = <List<String>>[
    <String>['🌱', 'Génération de vos clés cryptographiques…', 'Ed25519 · Schnorr · NOSTR'],
    <String>['🌐', 'Connexion au réseau UPlanet…', 'Votre station Astroport locale'],
    <String>['⚡', 'Création de votre identité NOSTR…', 'Souveraine, décentralisée'],
    <String>['🤝', 'Inscription dans la toile de confiance…', "Amis et amis d'amis"],
    <String>['💚', 'Attribution de votre MULTIPASS…', 'Votre Carte de Dépôt numérique'],
    <String>['🎉', "Prêt·e à rejoindre l'écosystème ẐEN !", '100% Logiciels Libres'],
  ];

  static const List<String> _people = <String>[
    '🧑', '👩', '👨', '🧑‍💻', '👩‍🌾', '👨‍🏫',
  ];

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() => _step = (_step + 1) % _steps.length);
      }
    });
  }

  @override
  void dispose() {
    _spin.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> step = _steps[_step];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ── Tourbillon ──────────────────────────────────────────────────
          SizedBox(
            width: 200,
            height: 200,
            child: AnimatedBuilder(
              animation: _spin,
              builder: (BuildContext context, Widget? _) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // Cercle de connexion
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.purple.withValues(alpha: 0.15)),
                      ),
                    ),
                    // Emoji central pulsant
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        step[0],
                        key: ValueKey<int>(_step),
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                    // Personnes en orbite
                    ...<Widget>[
                      for (int i = 0; i < 6; i++)
                        Builder(builder: (_) {
                          final double angle = _spin.value * 2 * math.pi +
                              (i * math.pi / 3);
                          final double r = 72 +
                              8 * math.sin(_spin.value * math.pi * 2 + i);
                          return Transform.translate(
                            offset: Offset(
                                r * math.cos(angle), r * math.sin(angle)),
                            child: Transform.rotate(
                              angle: angle + math.pi / 2,
                              child: Text(
                                _people[i],
                                style: TextStyle(
                                  fontSize:
                                      16 + 4 * math.cos(angle + i).abs(),
                                ),
                              ),
                            ),
                          );
                        }),
                    ],
                    // Lignes de connexion (arcs pulsants)
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: _ConnectionPainter(
                          progress: _spin.value, step: _step),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // ── Message animé ────────────────────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> anim) =>
                FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: anim, curve: Curves.easeOut)),
                child: child,
              ),
            ),
            child: Column(
              key: ValueKey<int>(_step),
              children: <Widget>[
                Text(
                  step[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  step[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ── Indicateur de progression ─────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(_steps.length, (int i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _step ? 22 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _step
                      ? Colors.deepPurple
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Dessine de fines lignes de connexion entre les personnes en orbite
class _ConnectionPainter extends CustomPainter {
  const _ConnectionPainter({required this.progress, required this.step});

  final double progress;
  final int step;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.12)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    const double r = 72;

    for (int i = 0; i < 6; i++) {
      final double a1 = progress * 2 * math.pi + (i * math.pi / 3);
      final double a2 =
          progress * 2 * math.pi + ((i + 1) % 6 * math.pi / 3);
      canvas.drawLine(
        Offset(cx + r * math.cos(a1), cy + r * math.sin(a1)),
        Offset(cx + r * math.cos(a2), cy + r * math.sin(a2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ConnectionPainter old) =>
      old.progress != progress || old.step != step;
}
