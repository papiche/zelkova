import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/models/app_cubit.dart';
import '../../env.dart';
import '../../g1/multipass_service.dart';
import '../../g1/zen_tag_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';
import 'wallet_creation_screen.dart';

// ── État de détection NOSTR ───────────────────────────────────────────────────

enum _DetectionState {
  idle,       // email vide / invalide
  detecting,  // requête relay en cours
  found,      // profil trouvé, home station identifiée
  notFound,   // profil absent du relay
  failed,     // relay inaccessible
}

// ── Modèle station SWARM ──────────────────────────────────────────────────────

class _Station {
  const _Station({
    required this.uspot,
    required this.label,
    required this.hostname,
    required this.relay,
    required this.ipfsnodeid,
    required this.active,
    required this.lat,
    required this.lon,
    required this.multipassCount,
    required this.nostrSlots,
  });

  final String uspot;
  final String label;
  final String hostname;
  final String relay;
  final String ipfsnodeid;
  final bool active;
  final double lat;
  final double lon;
  final int multipassCount;
  final int nostrSlots;

  static _Station? fromJson(Map<String, dynamic> m) {
    final String? uspot = m['uSPOT'] as String?;
    if (uspot == null || uspot.isEmpty) {
      return null;
    }
    final String host = m['hostname'] as String? ?? '';
    final String city = m['IPCity'] as String? ?? '';
    final Map<String, dynamic> svc =
        (m['services'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> up =
        (svc['upassport'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> cap =
        (m['capacities'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> eco =
        (m['economy'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final String lbl = <String>[
      if (host.isNotEmpty) host,
      if (city.isNotEmpty) city,
    ].join(' – ');

    return _Station(
      uspot: uspot,
      label: lbl.isNotEmpty ? lbl : uspot,
      hostname: host.isNotEmpty ? host : uspot,
      relay: m['myRELAY'] as String? ?? '',
      ipfsnodeid: m['ipfsnodeid'] as String? ?? '',
      active: up['active'] as bool? ?? false,
      lat: double.tryParse(m['STATION_LAT'] as String? ?? '') ?? 0.0,
      lon: double.tryParse(m['STATION_LON'] as String? ?? '') ?? 0.0,
      multipassCount: (eco['multipass_count'] as num?)?.toInt()
          ?? (cap['multipass_count'] as num?)?.toInt() ?? 0,
      nostrSlots: (cap['nostr_slots'] as num?)?.toInt() ?? 0,
    );
  }

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

// ── Requête NOSTR home station ─────────────────────────────────────────────────

/// Interroge le relay pour un kind 0 avec tag `["i","email:<email>",""]`.
/// Retourne `content.home_station` ("IPFSNODEID:NODE_HEX") ou null.
Future<String?> _queryHomeStation(String email, String relayUrl) async {
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
    loggerDev('[Recovery] home_station lookup error: $e');
    rethrow; // distinguer "not found" de "relay error"
  } finally {
    ws?.sink.close();
  }
}

// ── Écran de récupération ─────────────────────────────────────────────────────

/// Flux :
///   1. Email saisi → debounce 800 ms → requête relay NOSTR (#i email:xxx)
///   2. Trouvé → station pré-sélectionnée → "Récupérer" en un tap
///   3. Non trouvé → proposition de créer un MULTIPASS avec cet email
///   4. Relay KO → mode manuel avec sélecteur de station
///   5. PIN uniquement en dialog de fallback (HTTP 409)
class MultipassRecoveryScreen extends StatefulWidget {
  const MultipassRecoveryScreen({super.key});

  @override
  State<MultipassRecoveryScreen> createState() =>
      _MultipassRecoveryScreenState();
}

class _MultipassRecoveryScreenState extends State<MultipassRecoveryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();

  bool _recovering = false;
  String? _error;
  MultipassResponse? _result;

  // ── Stations SWARM ──────────────────────────────────────────────────────────
  List<_Station> _stations = <_Station>[];
  bool _stationsLoading = false;
  String _selectedUspot = Env.upassportUrl;
  bool _homeStationFound = false;

  // Géolocalisation pour le tri
  double? _userLat;
  double? _userLon;

  // ── Détection NOSTR ─────────────────────────────────────────────────────────
  _DetectionState _detection = _DetectionState.idle;
  Timer? _debounce;
  String _detectedStationLabel = '';

  @override
  void initState() {
    super.initState();
    _loadStationsAndGeo();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ── Chargement SWARM + géolocalisation ─────────────────────────────────────

  Future<void> _loadStationsAndGeo() async {
    // Lancer la géolocalisation en parallèle du chargement SWARM
    unawaited(_requestGeolocation());
    await _loadStations();
  }

  Future<void> _requestGeolocation() async {
    try {
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return;
      }
      final Position pos = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.low),
      );
      _userLat = pos.latitude;
      _userLon = pos.longitude;
      // Re-trier une fois la position connue
      if (_stations.isNotEmpty) {
        _sortStations();
      }
    } catch (_) {}
  }

  Future<void> _loadStations() async {
    setState(() => _stationsLoading = true);
    try {
      final http.Response r = await http
          .get(Uri.parse(Env.upassportUrl))
          .timeout(const Duration(seconds: 10));
      if (r.statusCode == 200) {
        final Map<String, dynamic> root =
            jsonDecode(r.body) as Map<String, dynamic>;

        final List<_Station> list = <_Station>[];

        final Map<String, dynamic> primaryMap =
            Map<String, dynamic>.from(root);
        primaryMap['services'] = <String, dynamic>{
          ...?(root['services'] as Map<String, dynamic>?),
          'upassport': <String, dynamic>{'active': true},
        };
        final _Station? primary = _Station.fromJson(primaryMap);
        if (primary != null) {
          list.add(primary);
        }

        for (final dynamic raw
            in root['SWARM'] as List<dynamic>? ?? <dynamic>[]) {
          if (raw is Map<String, dynamic>) {
            final _Station? s = _Station.fromJson(raw);
            if (s != null &&
                !list.any((_Station e) => e.uspot == s.uspot) &&
                !s.hostname.contains('127.0.0.1') &&
                !s.uspot.contains('127.0.0.1')) {
              list.add(s);
            }
          }
        }

        if (mounted) {
          setState(() {
            _stations = list;
            _sortStations();
          });
        }
      }
    } catch (e) {
      loggerDev('SWARM load error (recovery): $e');
    } finally {
      if (mounted) {
        setState(() => _stationsLoading = false);
      }
    }
  }

  /// Tri : actives d'abord → plus proche géographiquement → plus ancienne
  /// (proxy : multipassCount desc — plus d'utilisateurs = station plus établie).
  void _sortStations() {
    if (_stations.isEmpty) {
      return;
    }
    final double? lat = _userLat;
    final double? lon = _userLon;

    _stations.sort((_Station a, _Station b) {
      // 1. Stations actives en tête
      if (a.active != b.active) {
        return a.active ? -1 : 1;
      }
      // 2. Distance géographique (si géolocalisation disponible)
      if (lat != null && lon != null) {
        final bool aHasGps = a.lat != 0 || a.lon != 0;
        final bool bHasGps = b.lat != 0 || b.lon != 0;
        if (aHasGps && bHasGps) {
          final double da = a.distanceFrom(lat, lon);
          final double db = b.distanceFrom(lat, lon);
          final int cmp = da.compareTo(db);
          if (cmp != 0) {
            return cmp;
          }
        } else if (aHasGps) {
          return -1;
        } else if (bHasGps) {
          return 1;
        }
      }
      // 3. Plus ancienne / établie : multipassCount desc
      return b.multipassCount.compareTo(a.multipassCount);
    });

    // Sélectionner la première station sauf si déjà sur la home station
    if (!_homeStationFound) {
      _selectedUspot = _stations
          .firstWhere((_Station s) => s.active, orElse: () => _stations.first)
          .uspot;
    }
  }

  // ── Détection NOSTR debounce ───────────────────────────────────────────────

  void _onEmailChanged(String value) {
    _debounce?.cancel();
    final String email = value.trim();
    if (!_isValidEmail(email)) {
      setState(() {
        _detection = _DetectionState.idle;
        _homeStationFound = false;
        _error = null;
      });
      return;
    }
    setState(() => _detection = _DetectionState.detecting);
    _debounce = Timer(const Duration(milliseconds: 800), () {
      _detectHomeStation(email);
    });
  }

  bool _isValidEmail(String s) {
    return RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$')
        .hasMatch(s);
  }

  Future<void> _detectHomeStation(String email) async {
    final String relayUrl = _stations
        .where((_Station s) => s.relay.isNotEmpty)
        .map((_Station s) => s.relay)
        .firstOrNull ?? '';

    try {
      final String? homeStation =
          await _queryHomeStation(email, relayUrl);
      if (!mounted) {
        return;
      }

      if (homeStation != null && homeStation.isNotEmpty) {
        final String ipfsId = homeStation.split(':').first;
        final _Station? found =
            _stations.where((_Station s) => s.ipfsnodeid == ipfsId).firstOrNull;
        if (found != null) {
          setState(() {
            _selectedUspot = found.uspot;
            _homeStationFound = true;
            _detectedStationLabel = found.label;
            _detection = _DetectionState.found;
          });
          return;
        }
      }
      // Profil absent du relay
      setState(() {
        _homeStationFound = false;
        _detection = _DetectionState.notFound;
      });
    } catch (_) {
      // Relay inaccessible — mode manuel
      if (mounted) {
        setState(() {
          _homeStationFound = false;
          _detection = _DetectionState.failed;
        });
      }
    }
  }

  // ── Récupération MULTIPASS ─────────────────────────────────────────────────

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() {
      _recovering = true;
      _error = null;
    });
    await _doRecover();
  }

  Future<void> _doRecover({String? passCode}) async {
    try {
      final MultipassResponse response = await MultipassService.createMultipass(
        email: _emailCtrl.text.trim(),
        lang: context.locale.languageCode,
        lat: '0.00',
        lon: '0.00',
        serverUrl: _selectedUspot,
        passCode: passCode,
      );
      await _saveAndShow(response);
    } on MultipassExistsException {
      if (!mounted) {
        return;
      }
      setState(() => _recovering = false);
      final String? code = await _showPinDialog();
      if (code == null || !mounted) {
        return;
      }
      setState(() {
        _recovering = true;
        _error = null;
      });
      await _doRecover(passCode: code);
    } on MultipassInvalidPassException {
      if (mounted) {
        setState(() {
          _recovering = false;
          _error = "Code PIN incorrect. Vérifiez l'email reçu lors de la "
              'création de votre MULTIPASS.';
        });
      }
    } on MultipassPassUnavailableException {
      if (mounted) {
        setState(() {
          _recovering = false;
          _error = 'Fichier PASS absent sur ce nœud. Essayez une autre station.';
        });
      }
    } on MultipassIdentityConflictException {
      if (mounted) {
        setState(() {
          _recovering = false;
          _error = "Conflit d'identité : cette clé appartient à un autre compte.";
        });
      }
    } on TimeoutException {
      if (mounted) {
        setState(() {
          _recovering = false;
          _error = 'La station ne répond pas. Vérifiez votre connexion '
              'ou choisissez une autre station.';
        });
      }
    } catch (e) {
      loggerDev('MultipassRecovery error: $e');
      if (mounted) {
        setState(() {
          _recovering = false;
          _error = e.toString();
        });
      }
    }
  }

  Future<void> _saveAndShow(MultipassResponse response) async {
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
    );
    if (response.uplanetnameG1.isNotEmpty) {
      ZenTagService().setUplanetnameG1(response.uplanetnameG1);
    }
    if (mounted) {
      setState(() {
        _result = response;
        _recovering = false;
      });
    }
  }

  // ── Dialog PIN (fallback 409) ───────────────────────────────────────────────

  Future<String?> _showPinDialog() async {
    final TextEditingController ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('🔑 Code PIN requis'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Ce MULTIPASS est protégé.\n'
              'Saisissez le code à 4 chiffres reçu par email.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              maxLength: 4,
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(
                hintText: '••••',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              if (ctrl.text.trim().length == 4) {
                Navigator.pop(ctx, ctrl.text.trim());
              }
            },
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  // ── Post-succès ────────────────────────────────────────────────────────────

  void _finish() {
    try {
      context.read<AppCubit>().introViewed();
    } catch (_) {}
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _goToCreate() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => WalletCreationScreen(
          initialEmail: _emailCtrl.text.trim(),
        ),
      ),
    );
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_result != null) {
      return _buildSuccess();
    }
    return _buildForm();
  }

  // ── Formulaire principal ──────────────────────────────────────────────────

  Widget _buildForm() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Récupérer mon MULTIPASS'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
            children: <Widget>[

              // ── Champ email ──────────────────────────────────────────────
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                onChanged: _onEmailChanged,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'votre@email.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: const OutlineInputBorder(),
                  suffixIcon: _buildEmailSuffix(),
                ),
                validator: (String? v) {
                  final String s = v?.trim() ?? '';
                  if (s.isEmpty) {
                    return 'Email requis';
                  }
                  if (!_isValidEmail(s)) {
                    return 'Email invalide';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Résultat de détection ────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildDetectionResult(theme, cs),
              ),

              // ── Erreur API ───────────────────────────────────────────────
              if (_error != null) ...<Widget>[
                const SizedBox(height: 16),
                _ErrorCard(message: _error!),
              ],
            ],
          ),
        ),
      ),

      // ── FAB — visible uniquement en mode manuel ou "found" ─────────────
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ── Indicateur dans le champ email ────────────────────────────────────────

  Widget? _buildEmailSuffix() {
    switch (_detection) {
      case _DetectionState.detecting:
        return const Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      case _DetectionState.found:
        return const Icon(Icons.check_circle, color: Colors.green, size: 22);
      case _DetectionState.notFound:
        return const Icon(Icons.help_outline, color: Colors.amber, size: 22);
      case _DetectionState.failed:
        return const Icon(Icons.wifi_off_outlined, color: Colors.orange, size: 22);
      case _DetectionState.idle:
        return null;
    }
  }

  // ── Feedback dynamique sous le champ email ────────────────────────────────

  Widget _buildDetectionResult(ThemeData theme, ColorScheme cs) {
    switch (_detection) {
      case _DetectionState.idle:
        return const SizedBox.shrink();

      case _DetectionState.detecting:
        return _InfoChip(
          icon: Icons.search,
          label: 'Recherche votre profil NOSTR…',
          color: cs.surfaceContainerHighest,
          labelColor: cs.onSurface.withValues(alpha: 0.7),
        );

      case _DetectionState.found:
        return _FoundCard(
          stationLabel: _detectedStationLabel,
          theme: theme,
          cs: cs,
        );

      case _DetectionState.notFound:
        return _NotFoundCard(
          email: _emailCtrl.text.trim(),
          theme: theme,
          cs: cs,
          onCreateTap: _goToCreate,
        );

      case _DetectionState.failed:
        return _FailedCard(
          theme: theme,
          cs: cs,
          stations: _stations,
          selectedUspot: _selectedUspot,
          stationsLoading: _stationsLoading,
          onStationTap: () => _showStationPicker(theme, cs),
        );
    }
  }

  // ── FAB contextuel ─────────────────────────────────────────────────────────

  Widget? _buildFab() {
    if (_detection == _DetectionState.notFound) {
      return null; // le bouton est dans la carte
    }
    if (_detection == _DetectionState.detecting) {
      return null;
    }
    return FloatingActionButton.extended(
      onPressed: _recovering ? null : _submit,
      label: _recovering
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(_detection == _DetectionState.found
              ? 'Récupérer'
              : 'Essayer quand même'),
      icon: _recovering
          ? null
          : Icon(_detection == _DetectionState.found
              ? Icons.download_done_outlined
              : Icons.warning_amber_outlined),
    );
  }

  // ── Sélecteur de station (mode manuel) ────────────────────────────────────

  void _showStationPicker(ThemeData theme, ColorScheme cs) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) => DraggableScrollableSheet(
        maxChildSize: 0.85,
        builder: (_, ScrollController scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: <Widget>[
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
            Text(
              'Choisir une station',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Sélectionnez votre station d'origine.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(height: 12),
            for (final _Station s in _stations)
              ListTile(
                leading: CircleAvatar(
                  radius: 6,
                  backgroundColor: s.active ? Colors.green : Colors.orange,
                ),
                title: Text(s.label, style: const TextStyle(fontSize: 14)),
                subtitle: s.multipassCount > 0
                    ? Text('${s.multipassCount} membres',
                        style: const TextStyle(fontSize: 11))
                    : null,
                trailing: s.uspot == _selectedUspot
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() => _selectedUspot = s.uspot);
                  Navigator.pop(ctx);
                },
              ),
          ],
        ),
      ),
    );
  }

  // ── Écran de succès ────────────────────────────────────────────────────────

  Widget _buildSuccess() {
    final MultipassResponse r = _result!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final _Station? confirming =
        _stations.where((_Station s) => s.uspot == _selectedUspot).firstOrNull;
    final String stationName = confirming?.label
        ?? Uri.tryParse(_selectedUspot)?.host
        ?? _selectedUspot;
    final String npubShort = r.npub.length > 20
        ? '${r.npub.substring(0, 12)}…${r.npub.substring(r.npub.length - 6)}'
        : r.npub;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Container(
                width: 88, height: 88,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.4), width: 2),
                ),
                child: const Icon(Icons.verified_user_outlined,
                    color: Colors.green, size: 44),
              ),
              const SizedBox(height: 22),
              Text('Identité retrouvée !',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text('Votre MULTIPASS est de nouveau actif.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text('Confirmé par la station Astroport',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: (confirming?.active ?? false)
                              ? Colors.green
                              : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    _infoRow(theme, cs, '🏛️ Station', stationName),
                    const SizedBox(height: 6),
                    _infoRow(theme, cs, '📧 Email',
                        r.email.isNotEmpty ? r.email : _emailCtrl.text.trim()),
                    const SizedBox(height: 6),
                    _infoRow(theme, cs, '🔐 Identité', npubShort),
                    if (r.uplanetnameG1.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 6),
                      _infoRow(theme, cs, '🌍 UPlanet',
                          r.uplanetnameG1.substring(
                              0, math.min(12, r.uplanetnameG1.length))),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _finish,
                  icon: const Icon(Icons.rocket_launch_outlined),
                  label: const Text("C'est parti !"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData t, ColorScheme cs, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(label,
              style: t.textTheme.bodySmall
                  ?.copyWith(color: cs.onSurface.withValues(alpha: 0.55))),
        ),
        Expanded(
          child: Text(value,
              style: t.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

// ── Widgets atomiques de feedback ─────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.labelColor,
  });
  final IconData icon;
  final String label;
  final Color color;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: <Widget>[
        Icon(icon, size: 16, color: labelColor),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 13, color: labelColor)),
      ]),
    );
  }
}

class _FoundCard extends StatelessWidget {
  const _FoundCard({
    required this.stationLabel,
    required this.theme,
    required this.cs,
  });
  final String stationLabel;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.withValues(alpha: 0.35)),
      ),
      child: Row(children: <Widget>[
        const Icon(Icons.location_on, color: Colors.green, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Station détectée',
                  style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w700)),
              Text(stationLabel,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ]),
    );
  }
}

class _NotFoundCard extends StatelessWidget {
  const _NotFoundCard({
    required this.email,
    required this.theme,
    required this.cs,
    required this.onCreateTap,
  });
  final String email;
  final ThemeData theme;
  final ColorScheme cs;
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            const Icon(Icons.search_off, color: Colors.amber, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Aucun MULTIPASS trouvé pour cet email.',
                style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface.withValues(alpha: 0.8)),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: onCreateTap,
              icon: const Icon(Icons.add_circle_outline, size: 18),
              label: Text('Créer un MULTIPASS avec $email'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.error_outline, color: cs.onErrorContainer, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: cs.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _FailedCard extends StatelessWidget {
  const _FailedCard({
    required this.theme,
    required this.cs,
    required this.stations,
    required this.selectedUspot,
    required this.stationsLoading,
    required this.onStationTap,
  });
  final ThemeData theme;
  final ColorScheme cs;
  final List<_Station> stations;
  final String selectedUspot;
  final bool stationsLoading;
  final VoidCallback onStationTap;

  @override
  Widget build(BuildContext context) {
    final _Station? selected =
        stations.where((_Station s) => s.uspot == selectedUspot).firstOrNull;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            const Icon(Icons.wifi_off_outlined, color: Colors.orange, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Profil non détecté (relay inaccessible).\n'
                'Sélectionnez votre station manuellement.',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.75)),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          if (stationsLoading)
            const Center(
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2)))
          else if (stations.isNotEmpty)
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onStationTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: cs.outline.withValues(alpha: 0.4)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: <Widget>[
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: (selected?.active ?? false)
                          ? Colors.green
                          : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selected?.label ?? selectedUspot,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.expand_more,
                      color: cs.onSurface.withValues(alpha: 0.45)),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}
