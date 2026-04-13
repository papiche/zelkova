import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../shared_prefs_helper_v2.dart';

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

  /// Re-fetches OC URLs from the UPassport server and updates stored data.
  ///
  /// This fixes the case where the account was created before OC integration
  /// was available on the station, leaving oc_urls empty.
  Future<void> _refreshOcUrls() async {
    final Map<String, dynamic>? data = _multipassData;
    if (data == null) return;

    final String email = data['email'] as String? ?? '';
    final String uplanetHome = data['uplanet_home'] as String? ?? '';
    if (email.isEmpty || uplanetHome.isEmpty) return;

    setState(() => _refreshing = true);

    try {
      final http.Response response = await http
          .post(
            Uri.parse('$uplanetHome/g1nostr'),
            body: <String, String>{'email': email, 'format': 'json'},
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final Map<String, dynamic> serverData =
            jsonDecode(response.body) as Map<String, dynamic>;
        final Map<String, dynamic>? newOcUrls =
            serverData['oc_urls'] as Map<String, dynamic>?;
        if (newOcUrls != null) {
          await SharedPreferencesHelperV2().updateMultipassOcUrls(newOcUrls);
          final Map<String, dynamic>? updated =
              await SharedPreferencesHelperV2().getMultipassData();
          if (mounted) {
            setState(() {
              _multipassData = updated;
              _refreshing = false;
            });
            return;
          }
        }
      }
    } catch (_) {
      // Network error — fall through to reset refreshing flag
    }

    if (mounted) setState(() => _refreshing = false);
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
