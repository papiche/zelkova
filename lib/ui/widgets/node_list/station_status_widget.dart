import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../env.dart';
import '../../logger.dart';

/// Widget that displays the UPlanet station status from 12345.json
/// (heartbox_analysis.sh data: services, capacities, system info).
class StationStatusWidget extends StatefulWidget {
  const StationStatusWidget({super.key});

  @override
  State<StationStatusWidget> createState() => _StationStatusWidgetState();
}

class _StationStatusWidgetState extends State<StationStatusWidget> {
  Map<String, dynamic>? _stationData;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchStationData();
  }

  /// Derive IPFS gateway URL from UPASSPORT_URL and fetch 12345.json
  Future<void> _fetchStationData() async {
    try {
      final Uri upassportUri = Uri.parse(Env.upassportUrl);
      final String host = upassportUri.host;
      String ipfsHost;
      if (host.startsWith('u.')) {
        ipfsHost = 'ipfs.${host.substring(2)}';
      } else {
        final List<String> parts = host.split('.');
        if (parts.length >= 2) {
          parts[0] = 'ipfs';
          ipfsHost = parts.join('.');
        } else {
          setState(() {
            _loading = false;
            _error = 'invalid_host';
          });
          return;
        }
      }

      final Uri stationUrl = Uri.https(ipfsHost, '/12345/');
      loggerDev('StationStatus: fetching $stationUrl');

      final http.Response response = await http
          .get(stationUrl)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          _stationData = data;
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
          _error = 'HTTP ${response.statusCode}';
        });
      }
    } catch (e) {
      loggerDev('StationStatus: fetch error: $e');
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (_loading) {
      return Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(tr('station_loading')),
            ],
          ),
        ),
      );
    }

    if (_error != null || _stationData == null) {
      return Card(
        margin: const EdgeInsets.all(12),
        child: ListTile(
          leading: Icon(Icons.cloud_off, color: colors.error),
          title: Text(tr('station_unavailable')),
          subtitle: Text(_error ?? 'No data'),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loading = true;
                _error = null;
              });
              _fetchStationData();
            },
          ),
        ),
      );
    }

    final Map<String, dynamic> data = _stationData!;
    final String hostname =
        data['hostname'] as String? ?? data['myHostname'] as String? ?? '?';
    final String captain =
        data['captain'] as String? ?? '?';
    final String ipfsnodeid =
        data['ipfsnodeid'] as String? ?? '';

    // Services from heartbox_analysis
    final Map<String, dynamic> services =
        data['services'] as Map<String, dynamic>? ?? <String, dynamic>{};

    // Capacities from heartbox_analysis
    final Map<String, dynamic> capacities =
        data['capacities'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.dns, color: colors.onPrimaryContainer),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tr('station_title'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        hostname,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.onPrimaryContainer.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh,
                      color: colors.onPrimaryContainer, size: 20),
                  onPressed: () {
                    setState(() {
                      _loading = true;
                      _error = null;
                    });
                    _fetchStationData();
                  },
                ),
              ],
            ),
          ),

          // Captain & IPFS ID
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: <Widget>[
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 6),
                Text(captain, style: const TextStyle(fontSize: 13)),
                if (ipfsnodeid.isNotEmpty) ...<Widget>[
                  const Spacer(),
                  const Icon(Icons.fingerprint, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${ipfsnodeid.substring(0, 8)}...',
                    style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                  ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),

          // Services grid
          if (services.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 6),
                    child: Text(
                      tr('station_services'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: _buildServiceChips(services, colors),
                  ),
                ],
              ),
            ),

          // Capacities
          if (capacities.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 6),
                    child: Text(
                      tr('station_capacities'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  _buildCapacitiesRow(capacities, colors),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildServiceChips(
      Map<String, dynamic> services, ColorScheme colors) {
    final List<Widget> chips = <Widget>[];

    // Service definitions: key in JSON → (label, icon)
    final Map<String, _ServiceDef> serviceDefs = <String, _ServiceDef>{
      'ipfs': _ServiceDef('IPFS', Icons.cloud_queue),
      'astroport': _ServiceDef('Astroport', Icons.rocket_launch),
      'uspot': _ServiceDef('UPassport', Icons.badge),
      'nostr_relay': _ServiceDef('NOSTR', Icons.forum),
      'nextcloud': _ServiceDef('NextCloud', Icons.cloud),
      'g1billet': _ServiceDef('G1Billet', Icons.receipt_long),
      'npm': _ServiceDef('Proxy', Icons.security),
    };

    for (final MapEntry<String, _ServiceDef> entry in serviceDefs.entries) {
      final dynamic serviceData = services[entry.key];
      if (serviceData == null) continue;

      bool active = false;
      String? detail;

      if (serviceData is Map<String, dynamic>) {
        active = serviceData['active'] as bool? ?? false;
        // Extra info for IPFS
        if (entry.key == 'ipfs' && active) {
          final int peers =
              serviceData['peers_connected'] as int? ?? 0;
          if (peers > 0) detail = '$peers peers';
        }
        // SSL info for npm
        if (entry.key == 'npm' && active) {
          final bool ssl = serviceData['ssl'] as bool? ?? false;
          if (ssl) detail = 'SSL';
        }
      } else if (serviceData is bool) {
        active = serviceData;
      }

      chips.add(
        Chip(
          avatar: Icon(
            entry.value.icon,
            size: 16,
            color: active ? colors.primary : colors.outline,
          ),
          label: Text(
            detail != null
                ? '${entry.value.label} ($detail)'
                : entry.value.label,
            style: TextStyle(
              fontSize: 11,
              color: active ? colors.onSurface : colors.outline,
            ),
          ),
          backgroundColor: active
              ? colors.primaryContainer.withValues(alpha: 0.4)
              : colors.surfaceContainerHighest.withValues(alpha: 0.5),
          side: BorderSide(
            color: active ? colors.primary.withValues(alpha: 0.3) : colors.outlineVariant,
          ),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        ),
      );
    }
    return chips;
  }

  Widget _buildCapacitiesRow(
      Map<String, dynamic> capacities, ColorScheme colors) {
    final int zencardSlots = capacities['zencard_slots'] as int? ?? 0;
    final int nostrSlots = capacities['nostr_slots'] as int? ?? 0;
    final num availableGb =
        capacities['available_space_gb'] as num? ?? 0;

    return Row(
      children: <Widget>[
        _buildCapacityTile(
          Icons.credit_card,
          tr('station_zencard_slots'),
          '$zencardSlots',
          colors,
        ),
        const SizedBox(width: 12),
        _buildCapacityTile(
          Icons.people,
          tr('station_nostr_slots'),
          '$nostrSlots',
          colors,
        ),
        const SizedBox(width: 12),
        _buildCapacityTile(
          Icons.storage,
          tr('station_storage'),
          '${availableGb.toStringAsFixed(0)} Go',
          colors,
        ),
      ],
    );
  }

  Widget _buildCapacityTile(
      IconData icon, String label, String value, ColorScheme colors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 20, color: colors.primary),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: colors.onSurface,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceDef {
  _ServiceDef(this.label, this.icon);
  final String label;
  final IconData icon;
}
