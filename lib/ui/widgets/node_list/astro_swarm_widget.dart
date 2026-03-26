import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../env.dart';
import '../../ui_helpers.dart';

/// Widget that lists UPlanet Astroport relay stations from the SWARM JSON.
///
/// Loads GET {Env.upassportUrl} which returns the constellation JSON including
/// a "SWARM" array of stations.  Reuses the same data source as the
/// MULTIPASS onboarding screen (wallet_creation_screen.dart).
///
/// Shown in NodeListPage when Expert mode is active.
class AstroSwarmWidget extends StatefulWidget {
  const AstroSwarmWidget({super.key});

  @override
  State<AstroSwarmWidget> createState() => _AstroSwarmWidgetState();
}

class _AstroSwarmWidgetState extends State<AstroSwarmWidget> {
  List<_AstroStation> _stations = <_AstroStation>[];
  bool _loading = true;
  String? _error;
  // null = not tested yet / in progress, true = reachable, false = unreachable
  final Map<String, bool?> _reachability = <String, bool?>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final http.Response r = await http
          .get(Uri.parse(Env.upassportUrl))
          .timeout(const Duration(seconds: 10));
      if (r.statusCode == 200) {
        final Map<String, dynamic> root =
            jsonDecode(r.body) as Map<String, dynamic>;
        final List<_AstroStation> stations = <_AstroStation>[];

        // Primary station
        final _AstroStation? primary = _AstroStation.fromJson(root);
        if (primary != null) {
          stations.add(primary.copyWithPrimary(isPrimary: true));
        }

        // SWARM stations
        for (final dynamic raw
            in root['SWARM'] as List<dynamic>? ?? <dynamic>[]) {
          if (raw is Map<String, dynamic>) {
            final _AstroStation? s = _AstroStation.fromJson(raw);
            if (s != null) stations.add(s);
          }
        }

        if (mounted) {
          setState(() {
            _stations = stations;
            _loading = false;
            // Mark all as pending
            for (final _AstroStation s in stations) {
              _reachability[s.uspot] = null;
            }
          });
        }

        // Fire parallel connectivity probes
        _probeAll(stations);
      } else {
        if (mounted) {
          setState(() {
            _loading = false;
            _error = 'HTTP ${r.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e.toString();
        });
      }
    }
  }

  /// Test reachability of each station's UPassport /health endpoint.
  /// Updates _reachability per station as each probe completes.
  void _probeAll(List<_AstroStation> stations) {
    for (final _AstroStation s in stations) {
      _probe(s);
    }
  }

  Future<void> _probe(_AstroStation s) async {
    // Use /health if known; fall back to the root URL.
    final String url =
        '${s.uspot.replaceAll(RegExp(r'/+$'), '')}/health';
    try {
      final http.Response r = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 6));
      if (mounted) {
        setState(() => _reachability[s.uspot] = r.statusCode < 500);
      }
    } catch (_) {
      if (mounted) setState(() => _reachability[s.uspot] = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ── Section header ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: <Widget>[
              const Icon(Icons.hub_outlined, size: 20),
              const SizedBox(width: 8),
              Text(
                tr('swarm_stations_title'),
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh, size: 18),
                onPressed: () {
                  setState(() {
                    _loading = true;
                    _error = null;
                  });
                  _load();
                },
              ),
            ],
          ),
        ),

        // ── Body ────────────────────────────────────────────────────────
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_error != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_error!, style: TextStyle(color: cs.error)),
          )
        else if (_stations.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(tr('swarm_stations_empty')),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stations.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (BuildContext ctx, int i) => _StationTile(
              station: _stations[i],
              reachable: _reachability[_stations[i].uspot],
            ),
          ),
      ],
    );
  }
}

// ── Station model ──────────────────────────────────────────────────────────

class _AstroStation {
  const _AstroStation({
    required this.hostname,
    required this.city,
    required this.uspot,
    required this.myIpfs,
    required this.relay,
    required this.nostrSlots,
    required this.zencardSlots,
    required this.availableGb,
    required this.paf,
    required this.ncard,
    required this.zcard,
    required this.bilan,
    required this.upassportActive,
    required this.isPrimary,
  });

  final String hostname;
  final String city;
  final String uspot;
  final String myIpfs;
  final String relay;
  final int nostrSlots;
  final int zencardSlots;
  final double availableGb;
  final int paf;
  final int ncard;
  final int zcard;
  final String bilan;
  final bool upassportActive;
  final bool isPrimary;

  _AstroStation copyWithPrimary({required bool isPrimary}) => _AstroStation(
        hostname: hostname, city: city, uspot: uspot,
        myIpfs: myIpfs, relay: relay,
        nostrSlots: nostrSlots, zencardSlots: zencardSlots,
        availableGb: availableGb, paf: paf,
        ncard: ncard, zcard: zcard, bilan: bilan,
        upassportActive: upassportActive, isPrimary: isPrimary,
      );

  static _AstroStation? fromJson(Map<String, dynamic> m) {
    final String? uspot = m['uSPOT'] as String?;
    if (uspot == null || uspot.isEmpty) return null;
    final Map<String, dynamic> cap =
        (m['capacities'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> svc =
        (m['services'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> up =
        (svc['upassport'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> rootStorage =
        ((cap['storage_details'] as Map<String, dynamic>?)?['root']
                as Map<String, dynamic>?) ??
            <String, dynamic>{};
    final Map<String, dynamic> eco =
        (m['economy'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    return _AstroStation(
      hostname: m['hostname'] as String? ?? '',
      city: m['IPCity'] as String? ?? '',
      uspot: uspot,
      myIpfs: m['myIPFS'] as String? ?? '',
      relay: m['myRELAY'] as String? ?? '',
      nostrSlots: (cap['nostr_slots'] as num?)?.toInt() ?? 0,
      zencardSlots: (cap['zencard_slots'] as num?)?.toInt() ?? 0,
      availableGb: (rootStorage['available_gb'] as num?)?.toDouble()
              ?? (cap['available_space_gb'] as num?)?.toDouble() ?? 0,
      paf: int.tryParse(m['PAF']?.toString() ?? '') ??
          (eco['captain_remuneration'] as num?)?.toInt() ?? 0,
      ncard: int.tryParse(m['NCARD']?.toString() ?? '') ??
          (eco['multipass_count'] as num?)?.toInt() ?? 0,
      zcard: int.tryParse(m['ZCARD']?.toString() ?? '') ??
          (eco['zencard_count'] as num?)?.toInt() ?? 0,
      bilan: m['BILAN']?.toString() ?? '',
      upassportActive: up['active'] as bool? ?? false,
      isPrimary: false,
    );
  }
}

// ── Tile widget ────────────────────────────────────────────────────────────

class _StationTile extends StatelessWidget {
  const _StationTile({required this.station, this.reachable});

  final _AstroStation station;
  /// null = connectivity probe in progress
  /// true  = UPassport /health responded OK
  /// false = unreachable (DNS/nginx/timeout error)
  final bool? reachable;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final int bilanInt = int.tryParse(station.bilan) ?? 0;
    final Color bilanColor = bilanInt >= 0 ? Colors.green : Colors.red;

    return ExpansionTile(
      leading: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Icon(
            station.isPrimary ? Icons.star : Icons.router_outlined,
            color: station.isPrimary ? Colors.amber : cs.primary,
          ),
          // Connectivity probe indicator (top-right corner of icon)
          if (reachable == null)
            const SizedBox(
              width: 10, height: 10,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            )
          else
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                // Green = reachable, Red = unreachable (bad DNS/nginx/cert)
                color: reachable! ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      title: Text(
        <String>[
          if (station.hostname.isNotEmpty) station.hostname,
          if (station.city.isNotEmpty) station.city,
        ].join(' – ').isNotEmpty
            ? <String>[
                if (station.hostname.isNotEmpty) station.hostname,
                if (station.city.isNotEmpty) station.city,
              ].join(' – ')
            : station.uspot,
        style: theme.textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${station.ncard}MP · ${station.zcard}ZC · PAF ${station.paf}Ẑ',
        style: theme.textTheme.bodySmall
            ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6)),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: station.nostrSlots > 0
              ? cs.primaryContainer
              : cs.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '${station.nostrSlots}MP libre',
          style: theme.textTheme.labelSmall?.copyWith(
            color: station.nostrSlots > 0
                ? cs.onPrimaryContainer
                : cs.onErrorContainer,
            fontWeight: FontWeight.w700,
            fontSize: 9,
          ),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _infoRow(theme, cs, 'UPassport', station.uspot,
                  onTap: () => openUrl(station.uspot)),
              _infoRow(theme, cs, 'IPFS', station.myIpfs),
              _infoRow(theme, cs, 'Relay', station.relay),
              _infoRow(theme, cs, 'ZenCard',
                  '${station.zencardSlots} libres'),
              _infoRow(theme, cs, 'Espace disque',
                  '${station.availableGb.toStringAsFixed(0)} Go'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Bilan hebdo',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.6))),
                  Text(
                    '${bilanInt > 0 ? '+' : ''}${station.bilan} Ẑ/sem',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: bilanColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(ThemeData t, ColorScheme cs, String label, String value,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(label,
                style: t.textTheme.bodySmall
                    ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
          ),
          Expanded(
            child: onTap != null
                ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: t.textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Text(
                    value,
                    style: t.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}
