import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../env.dart';
import '../../g1/multipass_service.dart';
import '../../g1/zen_tag_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';

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
    required this.ncard,
    required this.zcard,
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
  final int ncard;          // active MULTIPASS count
  final int zcard;          // active ZenCard count
  final int paf;            // weekly levy (ZEN) per MULTIPASS
  final double machineValueZen; // machine purchase price (ZEN)
  final String bilan;       // weekly accounting balance

  static _SwarmStation? fromJson(Map<String, dynamic> m) {
    final String? uspot = m['uSPOT'] as String?;
    if (uspot == null || uspot.isEmpty) return null;
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
      ncard: int.tryParse(m['NCARD']?.toString() ?? '') ??
          (eco['multipass_count'] as num?)?.toInt() ?? 0,
      zcard: int.tryParse(m['ZCARD']?.toString() ?? '') ??
          (eco['zencard_count'] as num?)?.toInt() ?? 0,
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

/// Onboarding screen for first launch:
/// Page 0 — Présentation des 4 options de contribution OC (carousel)
/// Page 1 — Formulaire email + géolocalisation → création MULTIPASS
/// Vue succès — Liens Open Collective personnalisés + bouton "C'est parti"
class WalletCreationScreen extends StatefulWidget {
  const WalletCreationScreen({super.key});

  @override
  State<WalletCreationScreen> createState() => _WalletCreationScreenState();
}

class _WalletCreationScreenState extends State<WalletCreationScreen> {
  final PageController _pageController = PageController();
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

  @override
  void initState() {
    super.initState();
    _loadSwarmStations();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
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
        if (primary != null) stations.add(primary);

        // SWARM stations
        final List<dynamic> swarm =
            root['SWARM'] as List<dynamic>? ?? <dynamic>[];
        for (final dynamic raw in swarm) {
          if (raw is Map<String, dynamic>) {
            final _SwarmStation? s = _SwarmStation.fromJson(raw);
            if (s != null) stations.add(s);
          }
        }

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
      if (mounted) setState(() => _swarmLoading = false);
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
    } catch (e) {
      // Erreur GPS → fallback 0.00,0.00
      setState(() {
        _lat = '0.00';
        _lon = '0.00';
        _geolocated = true;
      });
    }
  }

  /// Sort _swarmStations by Haversine distance from user's position.
  /// Stations at (0, 0) (no GPS data) are pushed to the end.
  void _sortStationsByDistance(double userLat, double userLon) {
    if (_swarmStations.isEmpty) return;
    final List<_SwarmStation> sorted = List<_SwarmStation>.from(_swarmStations);
    sorted.sort((_SwarmStation a, _SwarmStation b) {
      final bool aNoGps = a.lat == 0 && a.lon == 0;
      final bool bNoGps = b.lat == 0 && b.lon == 0;
      if (aNoGps && bNoGps) return 0;
      if (aNoGps) return 1;
      if (bNoGps) return -1;
      final double da = a.distanceFrom(userLat, userLon);
      final double db = b.distanceFrom(userLat, userLon);
      return da.compareTo(db);
    });
    setState(() {
      _swarmStations = sorted;
      // Update selection to nearest station that has slots + is active
      final _SwarmStation nearest = sorted.firstWhere(
        (_SwarmStation s) => s.active && s.nostrSlots > 0,
        orElse: () => sorted.first,
      );
      if (nearest != null) _selectedUspot = nearest.uspot;
    });
  }

  // ── Création du MULTIPASS ──────────────────────────────────────────────────

  Future<void> _createMultipass() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final MultipassResponse response = await MultipassService.createMultipass(
        email: _emailController.text.trim(),
        lang: context.locale.languageCode,
        lat: _lat,
        lon: _lon,
        serverUrl: _selectedUspot, // use swarm-selected station
      );

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

      if (!mounted) return;
      setState(() {
        _result = response;
        _isLoading = false;
      });
    } catch (e) {
      logger('WalletCreationScreen: createMultipass error: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _goToFormPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _goBackToContributions() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
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
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildContributionPage(),
        _buildFormPage(),
      ],
    );
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

  // ── Page 0 : Présentation MULTIPASS + 2 options de recharge ───────────────

  Widget _buildContributionPage() {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 36, 20, 120),
          children: <Widget>[
            // ── Hero ────────────────────────────────────────────────────────
            const Text('🌌', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            Text(
              'Le MULTIPASS UPlanet',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Votre Carte de Dépôt numérique,\n'
              'raccordée à votre réseau social\n'
              "(amis et amis d'amis)",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withOpacity(0.65), height: 1.6),
            ),
            const SizedBox(height: 28),

            // ── 3 avantages ──────────────────────────────────────────────────
            _buildAdvantageRow('🔓', '100% Logiciels Libres',
                'Aucun frais de transaction\nCode ouvert sous licence AGPL'),
            const SizedBox(height: 12),
            _buildAdvantageRow('⚡', 'Identité souveraine',
                'Votre clé NOSTR, vos données\nPas de GAFAM, pas de serveur central'),
            const SizedBox(height: 12),
            _buildAdvantageRow('💱', 'Ẑ convertibles en €',
                "Défraiement possible par dépôt de facture NOSTR.\nVotre argent ne dort pas : il finance\nl'acquisition et le partage du Bien Commun."),
            const SizedBox(height: 32),

            // ── Comment recharger ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Comment recharger votre MULTIPASS ?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.primary),
              ),
            ),
            const SizedBox(height: 16),

            // ── Card A : Recharge ponctuelle ─────────────────────────────────
            _buildRechargeInfo(
              emoji: '☁️',
              title: tr('subscription_recharge_title'),
              subtitle: 'Montant libre · Crédité immédiatement',
              desc: 'Idéal pour commencer. Stockage IPFS, réseau NOSTR, IA locale.',
              badge: 'MONTANT LIBRE',
              badgeColor: const Color(0xFF00BB77),
            ),
            const SizedBox(height: 12),

            // ── Card B : Adhésion mensuelle ───────────────────────────────────
            _buildRechargeInfo(
              emoji: '🏠',
              title: tr('subscription_monthly_title'),
              subtitle: '5 Ẑ/semaine · Accès continu à tous les services',
              desc: 'Comme une adhésion à votre asso favorite : vous cotisez, vous bénéficiez, vous décidez.',
              badge: 'RÉCURRENT',
              badgeColor: const Color(0xFFDD6633),
            ),
            const SizedBox(height: 8),
            // Note : l'email sera nécessaire pour OC après création
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.info_outline, size: 16, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Créez votre MULTIPASS d'abord,\n"
                      'puis rechargez avec la même adresse email.',
                      style: TextStyle(fontSize: 11, color: Colors.blue, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Note économique ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    '💰 Où va votre cotisation ?',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  _buildDistribRow('33 %', "Crédit d'usage sur votre MULTIPASS", const Color(0xFF00E5FF)),
                  _buildDistribRow('33 %', 'R&D (Astroport.ONE · G1FabLab)', const Color(0xFFBF5AFF)),
                  _buildDistribRow('33 %', 'Actifs durables (forêts-jardins)', const Color(0xFF00FF9D)),
                  _buildDistribRow(' 1 %', 'Capitaine (gestion de la station)', const Color(0xFFFF7C42)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToFormPage,
        label: Text(tr('create_multipass')),
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAdvantageRow(String emoji, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRechargeInfo({
    required String emoji,
    required String title,
    required String subtitle,
    required String desc,
    required String badge,
    required Color badgeColor,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: badgeColor.withOpacity(0.4), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: badgeColor)),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6))),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: badgeColor.withOpacity(0.4)),
                  ),
                  child: Text(badge,
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: badgeColor)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(desc,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65),
                    height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildDistribRow(String pct, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Container(
              width: 8, height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(pct,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 11, color: color)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.65))),
          ),
        ],
      ),
    );
  }

  // ── Page 1 : Formulaire email + géolocalisation ────────────────────────────

  Widget _buildFormPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBackToContributions,
        ),
        title: Text(tr('multipass_onboarding_title')),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tr('multipass_onboarding_description'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.65),
                      ),
                ),
                const SizedBox(height: 24),
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
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                        .hasMatch(value.trim())) {
                      return tr('email_invalid');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Station selector — loaded from SWARM
                if (_swarmLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(child: SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )),
                  )
                else if (_swarmStations.isNotEmpty)
                  _buildStationSelector(),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _geolocated
                      ? _buildGeoChip()
                      : OutlinedButton.icon(
                          key: const ValueKey<String>('geo-btn'),
                          onPressed: _requestGeolocation,
                          icon: const Icon(Icons.my_location),
                          label: Text(tr('get_location')),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                ),
                if (_errorMessage != null) ...<Widget>[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .error
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (_isLoading)
                  const Center(child: _MultipassCreationLoader())
                else
                  ElevatedButton(
                    onPressed: _createMultipass,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      tr('create_multipass'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
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
                  if (v != null) setState(() => _selectedUspot = v);
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
    final bool hasSlots = s.nostrSlots > 0;
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
                'PAF ${s.paf}Ẑ/sem · ${s.ncard}MP · ${s.zcard}ZC · '
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
                '${s.nostrSlots}MP',
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
                  _detailRow(theme, cs, 'MULTIPASS disponibles',
                      '${s.nostrSlots}'),
                  _detailRow(theme, cs, 'ZenCard disponibles',
                      '${s.zencardSlots}'),
                  _detailRow(theme, cs, 'Réservés capitaine',
                      '${s.captainSlots}'),
                  _detailRow(theme, cs, 'Espace disque',
                      '${s.availableSpaceGb.toStringAsFixed(0)} Go'),
                ]),

                // Economy
                _detailSection(theme, cs, '💰 Économie hebdomadaire', <Widget>[
                  _detailRow(theme, cs, 'MULTIPASS actifs', '${s.ncard}'),
                  _detailRow(theme, cs, 'ZenCards actifs',  '${s.zcard}'),
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

  Widget _buildGeoChip() {
    final bool isDefault = _lat == '0.00' && _lon == '0.00';
    return Container(
      key: const ValueKey<String>('geo-chip'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: isDefault
            ? Colors.orange.withOpacity(0.1)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDefault
              ? Colors.orange.withOpacity(0.4)
              : Colors.green.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            isDefault ? Icons.location_off : Icons.location_on,
            color: isDefault ? Colors.orange : Colors.green,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isDefault
                  ? 'Position par défaut (0.00, 0.00) — modifiable via un kind 1 plus tard'
                  : '$_lat°, $_lon°',
              style: TextStyle(
                color: isDefault ? Colors.orange.shade700 : Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          if (!isDefault)
            GestureDetector(
              onTap: _requestGeolocation,
              child: const Icon(Icons.refresh, size: 16),
            ),
        ],
      ),
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
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green.withOpacity(0.4),
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
                              .withOpacity(0.6),
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
                                .withOpacity(0.6),
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
                                .withOpacity(0.6),
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
    <String>['🤝', 'Inscription dans la toile de confiance Ğ1…', "Amis et amis d'amis"],
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
