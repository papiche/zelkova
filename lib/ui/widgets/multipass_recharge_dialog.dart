import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../g1/nostr/nostr_relay_service.dart';
import '../../services/open_collective_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../../ui/logger.dart';

/// Shows the UPlanet subscription/recharge dialog.
/// Reads OC URLs from persisted MULTIPASS data.
void showMultipassRechargeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const MultipassRechargeDialog(),
  );
}

class MultipassRechargeDialog extends StatefulWidget {
  const MultipassRechargeDialog({super.key});

  @override
  State<MultipassRechargeDialog> createState() =>
      _MultipassRechargeDialogState();
}

class _MultipassRechargeDialogState extends State<MultipassRechargeDialog> {
  Map<String, dynamic>? _multipassData;
  bool _loading = true;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final Map<String, dynamic>? data =
        await SharedPreferencesHelperV2().getMultipassData();
    setState(() {
      _multipassData = data;
      _loading = false;
    });
  }

  /// Re-fetches OC URLs from the station's kind 30800 cooperative-config
  /// NOSTR event and updates stored data.
  ///
  /// Flow:
  ///   1. AstroportStationService fetches /UPLANET/G1HEX (secp256k1 pubkey of
  ///      the cooperative-config publisher, distinct from UPLANETNAME_G1 which
  ///      is Ed25519 — different elliptic curves, not interconvertible).
  ///   2. Query the relay for kind 30800 d="cooperative-config" from that pubkey.
  ///   3. Persist the OC_URL_* fields to SharedPreferences.
  Future<void> _refreshOcUrls() async {
    setState(() => _refreshing = true);
    try {
      final Map<String, String> urls =
          await OpenCollectiveService.fetchOcUrls(NostrRelayService());
      if (urls.isNotEmpty) {
        await SharedPreferencesHelperV2()
            .updateMultipassOcUrls(urls.cast<String, dynamic>());
        final Map<String, dynamic>? updated =
            await SharedPreferencesHelperV2().getMultipassData();
        if (mounted) setState(() => _multipassData = updated);
      } else {
        loggerDev('MultipassRechargeDialog: no OC URLs found in kind 30800');
      }
    } catch (e) {
      loggerDev('MultipassRechargeDialog: _refreshOcUrls error: $e');
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const AlertDialog(
        content: Center(child: CircularProgressIndicator()),
      );
    }

    if (_multipassData == null) {
      return AlertDialog(
        title: Text(tr('recharge_title')),
        content: Text(tr('recharge_no_multipass')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('close')),
          ),
        ],
      );
    }

    final bool isOrigin = _multipassData!['is_origin'] as bool? ?? false;
    final String uplanetHome =
        _multipassData!['uplanet_home'] as String? ?? '';
    final Map<String, dynamic> ocUrlsRaw =
        (_multipassData!['oc_urls'] as Map<String, dynamic>?) ??
            <String, dynamic>{};
    final String satellite = ocUrlsRaw['satellite'] as String? ?? '';
    final String constellation = ocUrlsRaw['constellation'] as String? ?? '';
    final String cloud = ocUrlsRaw['cloud'] as String? ?? '';
    final String membre = ocUrlsRaw['membre'] as String? ?? '';

    final bool hasBatisseur =
        satellite.isNotEmpty || constellation.isNotEmpty;
    final bool hasExplorateur = cloud.isNotEmpty || membre.isNotEmpty;

    if (!hasBatisseur && !hasExplorateur) {
      return AlertDialog(
        title: Text(tr('recharge_title')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tr('recharge_not_configured')),
            if (_refreshing) ...<Widget>[
              const SizedBox(height: 12),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
        actions: <Widget>[
          if (!_refreshing)
            TextButton(
              onPressed: _refreshOcUrls,
              child: Text(tr('retry')),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('close')),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text(tr('recharge_title')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isOrigin) ...<Widget>[
              Chip(
                avatar: const Icon(Icons.science, size: 18),
                label: Text(tr('origin_mode_label')),
                backgroundColor: Colors.orange.shade100,
              ),
              const SizedBox(height: 8),
            ],
            // Explorateur — recharge MULTIPASS
            if (hasExplorateur) ...<Widget>[
              Text(
                tr('tier_explorateur_title'),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                tr('tier_explorateur_desc'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              if (cloud.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.bolt),
                  title: Text(tr('subscription_recharge_title')),
                  subtitle: Text(tr('subscription_recharge_desc')),
                  onTap: () => _openUrl(cloud),
                  trailing: const Icon(Icons.open_in_new),
                ),
              if (membre.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.autorenew),
                  title: Text(tr('subscription_monthly_title')),
                  subtitle: Text(tr('subscription_monthly_desc')),
                  onTap: () => _openUrl(membre),
                  trailing: const Icon(Icons.open_in_new),
                ),
            ],
            // Bâtisseur — parcelle numérique
            if (hasBatisseur) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                tr('tier_batisseur_title'),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                tr('tier_batisseur_desc'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              if (satellite.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.satellite_alt),
                  title: Text(tr('subscription_satellite_title')),
                  subtitle: Text(tr('subscription_satellite_desc')),
                  onTap: () => _openUrl(satellite),
                  trailing: const Icon(Icons.open_in_new),
                ),
              if (constellation.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.memory),
                  title: Text(tr('subscription_constellation_title')),
                  subtitle: Text(tr('subscription_constellation_desc')),
                  onTap: () => _openUrl(constellation),
                  trailing: const Icon(Icons.open_in_new),
                ),
            ],
            // UPlanet home link
            if (uplanetHome.isNotEmpty) ...<Widget>[
              const SizedBox(height: 16),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.public),
                title: Text(tr('uplanet_home_title')),
                subtitle: Text(tr('uplanet_home_desc')),
                onTap: () => _openUrl(uplanetHome),
                trailing: const Icon(Icons.open_in_new),
              ),
            ],
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('close')),
        ),
      ],
    );
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
