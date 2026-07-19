import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../env.dart';
import '../../g1/multipass_service.dart';
import '../../g1/nostr/home_station_lookup.dart';
import '../../g1/zen_tag_service.dart';
import '../../services/upassport_api_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';
import '../widgets/location_picker_sheet.dart';
import 'multipass_recovery_screen.dart';

/// Écran de création MULTIPASS simplifié au maximum : email + position (UMAP),
/// sur le modèle du formulaire https://u.copylaradio.com/g1.
///
/// Avant de créer, vérifie si l'email est déjà présent dans les DID NOSTR de
/// la constellation (kind 0, tag `i=email:<email>`, agrégés sur tous les
/// Astroport via `backfill_constellation.sh`) — si trouvé, bascule vers
/// [MultipassRecoveryScreen] au lieu de créer un doublon. Le 409
/// `MULTIPASS_EXISTS` du serveur reste un filet de sécurité (latence de sync).
///
/// Les données de naissance (ATOM4LOVE) ne sont plus demandées ici : elles
/// sont désormais réservées à l'activation ultérieure du second portefeuille
/// ATOM4LOVE (voir `wallet_creation_screen.dart`).
class MultipassCreationScreen extends StatefulWidget {
  const MultipassCreationScreen({super.key, this.initialEmail});

  /// Pré-remplit le champ email (ex: redirigé depuis l'écran de récupération).
  final String? initialEmail;

  @override
  State<MultipassCreationScreen> createState() =>
      _MultipassCreationScreenState();
}

class _MultipassCreationScreenState extends State<MultipassCreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController =
      TextEditingController(text: widget.initialEmail ?? '');

  bool _isLoading = false;
  bool _checkingExisting = false;
  String? _errorMessage;

  double? _lat;
  double? _lon;
  String _locationName = '';
  bool _locating = false;

  OcMemberInfo? _ocInfo;
  MultipassResponse? _result;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ── Position (UMAP) ──────────────────────────────────────────────────────

  Future<void> _useMyLocation() async {
    setState(() => _locating = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _lat = 0.0;
          _lon = 0.0;
          _locationName = '';
        });
        return;
      }
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.low),
      );
      setState(() {
        _lat = position.latitude;
        _lon = position.longitude;
        _locationName = '';
      });
    } catch (_) {
      setState(() {
        _lat = 0.0;
        _lon = 0.0;
      });
    } finally {
      if (mounted) {
        setState(() => _locating = false);
      }
    }
  }

  Future<void> _pickOnMap() async {
    final LocationPickerResult? result = await showLocationPicker(
      context: context,
      initialLat: _lat ?? 46.5,
      initialLon: _lon ?? 2.0,
      title: 'Ma position (UMAP)',
    );
    if (result != null && mounted) {
      setState(() {
        _lat = result.lat;
        _lon = result.lon;
        _locationName = result.name;
      });
    }
  }

  // ── Création ─────────────────────────────────────────────────────────────

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final String email = _emailController.text.trim();

    // Précision 0.01° (~1.1 km) — c'est la grille UMAP.
    final String lat = (_lat ?? 0.0).toStringAsFixed(2);
    final String lon = (_lon ?? 0.0).toStringAsFixed(2);

    setState(() {
      _isLoading = true;
      _checkingExisting = true;
      _errorMessage = null;
    });

    // Vérification informative OpenCollective — jamais bloquante.
    unawaited(UPassportApiService().checkOcMember(email).then((OcMemberInfo info) {
      if (mounted) {
        setState(() => _ocInfo = info);
      }
    }));

    // Vérification proactive : cet email a-t-il déjà un MULTIPASS quelque
    // part sur la constellation (tous les Astroport) ? Si oui → restaurer.
    try {
      final String? homeStation = await queryHomeStationForEmail(
        email,
        Env.resolvedNostrRelay,
      );
      if (homeStation != null && homeStation.isNotEmpty) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isLoading = false;
          _checkingExisting = false;
        });
        _goToRecovery(email);
        return;
      }
    } catch (e) {
      loggerDev('[MultipassCreation] existence check failed: $e');
      // Relay inaccessible : on continue, le 409 serveur reste le filet de sécurité.
    }

    if (!mounted) {
      return;
    }
    setState(() => _checkingExisting = false);

    try {
      final MultipassResponse response = await MultipassService.createMultipass(
        email: email,
        lang: 'fr',
        lat: lat,
        lon: lon,
      );
      await _saveAndShowResult(response);
    } on MultipassExistsException {
      // Filet de sécurité : la vérification proactive n'a rien trouvé (relay
      // en retard de sync ou inaccessible) mais le serveur, lui, sait déjà.
      if (!mounted) {
        return;
      }
      setState(() => _isLoading = false);
      _goToRecovery(email);
    } on MultipassIdentityConflictException {
      setState(() {
        _isLoading = false;
        _errorMessage =
            "Conflit d'identité : ces informations correspondent déjà à un autre compte.";
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _goToRecovery(String email) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => MultipassRecoveryScreen(initialEmail: email),
      ),
    );
  }

  Future<void> _saveAndShowResult(MultipassResponse response) async {
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
      ocUrls: <String, String>{
        'satellite': response.ocUrls.satellite,
        'constellation': response.ocUrls.constellation,
        'cloud': response.ocUrls.cloud,
        'membre': response.ocUrls.membre,
      },
      uplanetnameG1: response.uplanetnameG1,
      pass: response.pass,
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

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _finish() {
    if (_result == null) {
      return;
    }
    try {
      context.read<AppCubit>().setHasRecentExport(false);
    } catch (_) {}
    Navigator.of(context).pushReplacementNamed('/');
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer mon MULTIPASS')),
      body: SafeArea(
        child: _result != null ? _buildSuccess(context) : _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final bool hasLocation = _lat != null && _lon != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Votre MULTIPASS, c'est votre identité NOSTR + portefeuille "
              'ẐEN sur UPlanet. Juste un email et une position — le reste '
              'est généré automatiquement par votre station Astroport.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.75),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                final String v = value?.trim() ?? '';
                if (v.isEmpty) {
                  return "L'email est requis";
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v)) {
                  return 'Email invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Votre position (UMAP)',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            if (hasLocation)
              InputChip(
                avatar: const Icon(Icons.location_on, size: 18),
                label: Text(
                  _locationName.isNotEmpty
                      ? _locationName
                      : '${_lat!.toStringAsFixed(2)}°, ${_lon!.toStringAsFixed(2)}°',
                ),
                onPressed: _pickOnMap,
                onDeleted: () => setState(() {
                  _lat = null;
                  _lon = null;
                  _locationName = '';
                }),
              )
            else
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _locating ? null : _useMyLocation,
                      icon: _locating
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location),
                      label: const Text('Ma position'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickOnMap,
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Sur la carte'),
                    ),
                  ),
                ],
              ),
            if (_errorMessage != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: cs.error),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isLoading ? null : _create,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? Text(
                      _checkingExisting
                          ? 'Vérification sur la constellation…'
                          : 'Création en cours…',
                    )
                  : const Text('Créer mon MULTIPASS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    final MultipassResponse result = _result!;
    final OcUrls ocUrls = result.ocUrls;
    final bool hasBatisseur =
        ocUrls.satellite.isNotEmpty || ocUrls.constellation.isNotEmpty;
    final bool hasExplorateur =
        ocUrls.cloud.isNotEmpty || ocUrls.membre.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
              const SizedBox(width: 10),
              Text(
                'MULTIPASS créé !',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Votre identité NOSTR et votre portefeuille ẐEN sont prêts.'),
          if (result.pass.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(Icons.security,
                    size: 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Votre code PASS et votre clé technique sont disponibles dans l'onglet Info → Mode Expert.",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6)),
                  ),
                ),
              ],
            ),
          ],
          if (result.isOrigin) ...<Widget>[
            const SizedBox(height: 10),
            Chip(
              avatar: const Icon(Icons.science, size: 18),
              label: const Text('Mode ORIGIN'),
              backgroundColor: Colors.orange.shade100,
            ),
          ],
          if (_ocInfo?.isMember ?? false) ...<Widget>[
            const SizedBox(height: 10),
            const Chip(
              avatar: Icon(Icons.volunteer_activism, size: 18),
              label: Text('Compte OpenCollective détecté — sera relié automatiquement'),
            ),
          ],
          if (hasBatisseur) ...<Widget>[
            const SizedBox(height: 20),
            Text('Bâtisseur — parcelle numérique',
                style: Theme.of(context).textTheme.titleSmall),
            if (ocUrls.satellite.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.satellite_alt),
                title: const Text('Satellite'),
                onTap: () => _openUrl(ocUrls.satellite),
                trailing: const Icon(Icons.open_in_new),
              ),
            if (ocUrls.constellation.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.memory),
                title: const Text('Constellation'),
                onTap: () => _openUrl(ocUrls.constellation),
                trailing: const Icon(Icons.open_in_new),
              ),
          ],
          if (hasExplorateur) ...<Widget>[
            const SizedBox(height: 20),
            Text('Explorateur — recharge MULTIPASS',
                style: Theme.of(context).textTheme.titleSmall),
            if (ocUrls.cloud.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.bolt),
                title: const Text('Recharge'),
                onTap: () => _openUrl(ocUrls.cloud),
                trailing: const Icon(Icons.open_in_new),
              ),
            if (ocUrls.membre.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.autorenew),
                title: const Text('Abonnement mensuel'),
                onTap: () => _openUrl(ocUrls.membre),
                trailing: const Icon(Icons.open_in_new),
              ),
          ],
          if (result.uplanetHome.isNotEmpty) ...<Widget>[
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Ma page UPlanet'),
              onTap: () => _openUrl(result.uplanetHome),
              trailing: const Icon(Icons.open_in_new),
            ),
          ],
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _finish,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("C'est parti"),
            ),
          ),
        ],
      ),
    );
  }
}
