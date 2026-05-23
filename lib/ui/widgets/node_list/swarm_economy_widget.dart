import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/selected_station_cubit.dart';
import '../../../g1/nostr/nostr_relay_service.dart';
import '../../../g1/nostr/station_economy_event.dart';
import '../../../services/upassport_api_service.dart';
import '../../logger.dart';

/// Widget that subscribes to NOSTR kind 30850 events,
/// displays the economic health of the station constellation,
/// and lets the user choose which station to connect to.
class SwarmEconomyWidget extends StatefulWidget {
  const SwarmEconomyWidget({super.key});

  @override
  State<SwarmEconomyWidget> createState() => _SwarmEconomyWidgetState();
}

class _SwarmEconomyWidgetState extends State<SwarmEconomyWidget> {
  Map<String, StationEconomyData> _stations = <String, StationEconomyData>{};
  bool _loading = true;
  String? _error;
  String? _selectedStationId;

  @override
  void initState() {
    super.initState();
    _fetchStationEvents();
  }

  Future<void> _fetchStationEvents() async {
    final NostrRelayService relay = NostrRelayService();

    if (!relay.isConnected) {
      setState(() {
        _loading = false;
        _error = tr('swarm_relay_disconnected');
      });
      return;
    }

    try {
      loggerDev('SwarmEconomy: subscribing to kind 30850...');
      final Map<String, StationEconomyData> stations =
          await relay.fetchStationEvents();
      loggerDev('SwarmEconomy: received ${stations.length} stations');
      setState(() {
        _stations = stations;
        _loading = false;
      });
    } catch (e) {
      loggerDev('SwarmEconomy: error: $e');
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  void _selectStation(StationEconomyData station) {
    final String? url = station.stationUrl;
    if (url == null || url.isEmpty) {
      return;
    }
    GetIt.instance<SelectedStationCubit>().select(url, station.stationName);
    GetIt.instance<UPassportApiService>().baseUrl = url;
    loggerDev('SwarmEconomy: station selected → $url (${station.stationName})');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Station : ${station.stationName}'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade700,
      ),
    );
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
              Text(tr('swarm_loading')),
            ],
          ),
        ),
      );
    }

    if (_error != null || _stations.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(12),
        child: ListTile(
          leading: Icon(Icons.satellite_alt, color: colors.outline),
          title: Text(tr('swarm_title')),
          subtitle: Text(_error ?? tr('swarm_no_stations')),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loading = true;
                _error = null;
              });
              _fetchStationEvents();
            },
          ),
        ),
      );
    }

    final List<StationEconomyData> sortedStations =
        _stations.values.toList()
          ..sort((StationEconomyData a, StationEconomyData b) {
            const Map<String, int> order = <String, int>{
              'bankrupt': 0,
              'critical': 1,
              'innovation_slowdown': 1,
              'warning': 2,
              'growth_slowdown': 2,
              'healthy': 3,
            };
            return (order[a.healthStatus] ?? 3)
                .compareTo(order[b.healthStatus] ?? 3);
          });

    final int totalStations = sortedStations.length;
    final int healthyCount =
        sortedStations.where((StationEconomyData s) => s.isHealthy).length;
    final int totalUsers = sortedStations.fold<int>(
        0, (int sum, StationEconomyData s) => sum + s.totalUsers);
    final double totalRevenue = sortedStations.fold<double>(
        0, (double sum, StationEconomyData s) => sum + s.revenueTotal);
    final int healthPercent =
        totalStations > 0 ? (healthyCount * 100 ~/ totalStations) : 0;

    return BlocBuilder<SelectedStationCubit, SelectedStationState>(
      bloc: GetIt.instance<SelectedStationCubit>(),
      builder: (BuildContext ctx, SelectedStationState selState) {
        return Card(
          margin: const EdgeInsets.all(12),
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.tertiaryContainer,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.satellite_alt,
                        color: colors.onTertiaryContainer),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tr('swarm_title'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colors.onTertiaryContainer,
                            ),
                          ),
                          if (selState.hasSelection)
                            Text(
                              '✓ ${selState.name}',
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.onTertiaryContainer
                                    .withValues(alpha: 0.8),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh,
                          color: colors.onTertiaryContainer, size: 20),
                      onPressed: () {
                        setState(() {
                          _loading = true;
                          _error = null;
                        });
                        _fetchStationEvents();
                      },
                    ),
                  ],
                ),
              ),

              // Aggregate overview
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Row(
                  children: <Widget>[
                    _buildAggregateTile('$totalStations',
                        tr('swarm_stations'), Colors.cyan, colors),
                    _buildAggregateTile(
                      '$healthPercent%',
                      tr('swarm_health'),
                      healthPercent >= 80
                          ? Colors.green
                          : healthPercent >= 50
                              ? Colors.orange
                              : Colors.red,
                      colors,
                    ),
                    _buildAggregateTile('$totalUsers', tr('swarm_users'),
                        Colors.deepPurple, colors),
                    _buildAggregateTile(
                        '${totalRevenue.toStringAsFixed(0)} Z',
                        tr('swarm_revenue'),
                        Colors.amber,
                        colors),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Station list
              ...sortedStations.map((StationEconomyData station) {
                final bool isSelected =
                    _selectedStationId == station.stationId;
                final bool isActive = selState.hasSelection &&
                    selState.url == station.stationUrl;
                return _buildStationRow(
                    station, isSelected, isActive, colors);
              }),

              // Selected station details
              if (_selectedStationId != null &&
                  _stations.containsKey(_selectedStationId))
                _buildStationDetails(
                    _stations[_selectedStationId]!, selState, colors),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAggregateTile(
      String value, String label, Color valueColor, ColorScheme colors) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: valueColor)),
            Text(label,
                style: TextStyle(
                    fontSize: 9, color: colors.onSurfaceVariant),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildStationRow(StationEconomyData station, bool isSelected,
      bool isActive, ColorScheme colors) {
    final Color statusColor = station.isHealthy
        ? Colors.green
        : station.isWarning
            ? Colors.orange
            : Colors.red;

    final int? mpPct = station.mpSaturationPct;
    final int? zcPct = station.zcSaturationPct;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedStationId =
              isSelected ? null : station.stationId;
        });
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.surfaceContainerHighest
              : null,
          border: Border(
            left: BorderSide(
              color: isActive
                  ? Colors.green
                  : isSelected
                      ? colors.primary
                      : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: statusColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(station.stationName,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis),
                      ),
                      if (isActive)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(Icons.check_circle,
                              size: 14, color: Colors.green),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${station.bilan.toStringAsFixed(1)} Z',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: station.bilan >= 0
                            ? Colors.green
                            : Colors.red),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${station.tierEmoji} N:${station.priceMultipass.toStringAsFixed(0)}Z',
                    style: TextStyle(
                        fontSize: 10,
                        color: colors.onSurfaceVariant),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 36,
                  child: Text('${station.weeksRunway}w',
                      style: TextStyle(
                          fontSize: 11,
                          color: colors.onSurfaceVariant),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            if (mpPct != null) ...<Widget>[
              const SizedBox(height: 4),
              _buildMiniCapBar(
                  '🪪 ${station.multipassUsed}/${station.multipassTotal}',
                  mpPct,
                  colors),
            ],
            if (zcPct != null) ...<Widget>[
              const SizedBox(height: 2),
              _buildMiniCapBar(
                  '☁ ${station.zcUsed}/${station.zencardCapacity}',
                  zcPct,
                  colors),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMiniCapBar(
      String label, int pct, ColorScheme colors) {
    final Color barColor = pct >= 90
        ? Colors.red
        : pct >= 70
            ? Colors.orange
            : Colors.green;
    return Row(
      children: <Widget>[
        SizedBox(
          width: 72,
          child: Text(label,
              style: TextStyle(
                  fontSize: 9, color: colors.onSurfaceVariant)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: pct / 100,
              minHeight: 4,
              backgroundColor: colors.surfaceContainerHighest,
              valueColor:
                  AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 28,
          child: Text('$pct%',
              style: TextStyle(fontSize: 9, color: barColor),
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _buildStationDetails(StationEconomyData station,
      SelectedStationState selState, ColorScheme colors) {
    final bool isActive =
        selState.hasSelection && selState.url == station.stationUrl;
    final bool canSelect =
        station.stationUrl != null && station.stationUrl!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Date & solar
          Row(
            children: <Widget>[
              if (station.generatedAt != null)
                Text(
                  station.generatedAt!
                      .substring(0, 16)
                      .replaceFirst('T', ' '),
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant),
                ),
              const Spacer(),
              if (station.solarOffset != null)
                Text('Solar: ${station.solarOffset}',
                    style: TextStyle(
                        fontSize: 11, color: colors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),

          // Capacity bars
          if (station.multipassTotal > 0) ...<Widget>[
            _buildCapacityBar(
              label: '🪪 MULTIPASS × 10 Go',
              used: station.multipassUsed,
              total: station.multipassTotal,
              pct: station.mpSaturationPct ?? 0,
              colors: colors,
            ),
            const SizedBox(height: 4),
          ],
          if (station.zencardCapacity > 0) ...<Widget>[
            _buildCapacityBar(
              label: '☁ ZenCard × 128 Go',
              used: station.zcUsed,
              total: station.zencardCapacity,
              pct: station.zcSaturationPct ?? 0,
              colors: colors,
            ),
            const SizedBox(height: 4),
          ],

          if (station.isSaturated) ...<Widget>[
            const SizedBox(height: 4),
            _buildSaturationCta(),
            const SizedBox(height: 4),
          ],

          const SizedBox(height: 6),

          // Resource bars
          _buildResourceBar(
              'CASH', station.cashBalance, Colors.cyan, colors),
          _buildResourceBar(
              'R&D', station.rndBalance, Colors.orange, colors),
          _buildResourceBar(
              'ASSETS', station.assetsBalance, Colors.green, colors),
          _buildResourceBar(
              'IMPOT', station.impotBalance, Colors.pink, colors),

          const SizedBox(height: 6),

          // Hardware
          if (station.hwPowerScore > 0) ...<Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${station.tierEmoji} ${station.isGpuBrain ? 'BRAIN GPU' : station.hwTier == 'brain' ? 'BRAIN CPU' : station.hwTier.toUpperCase()}',
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Text(
                  '${station.hwCpuCores}c ${station.hwRamGb.toStringAsFixed(0)}Go score:${station.hwPowerScore}',
                  style: TextStyle(
                      fontSize: 10, color: colors.onSurfaceVariant),
                ),
                if (station.hwGpuVramGb > 0) ...<Widget>[
                  const SizedBox(width: 6),
                  Text('GPU ${station.hwGpuVramGb.toStringAsFixed(0)}Go',
                      style: const TextStyle(
                          fontSize: 10, color: Colors.orange)),
                ],
              ],
            ),
            const SizedBox(height: 6),
          ],

          // Revenue & pricing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('CA: ${station.revenueTotal.toStringAsFixed(1)} Z/sem',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber.shade300,
                      fontWeight: FontWeight.w600)),
              Text('PAF: ${station.costPaf.toStringAsFixed(0)} Z',
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant)),
              Text(
                  'N:${station.priceMultipass.toStringAsFixed(0)}Z Z:${station.priceZencard.toStringAsFixed(0)}Z',
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant)),
            ],
          ),

          // Select / deselect button
          if (canSelect) ...<Widget>[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: isActive
                  ? OutlinedButton.icon(
                      onPressed: () => GetIt.instance<SelectedStationCubit>()
                          .clearSelection(),
                      icon: const Icon(Icons.check_circle, size: 16),
                      label: const Text('Station active — retirer'),
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green),
                    )
                  : ElevatedButton.icon(
                      onPressed: () => _selectStation(station),
                      icon: const Icon(Icons.satellite_alt, size: 16),
                      label: Text('Choisir ${station.stationName}'),
                    ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCapacityBar({
    required String label,
    required int used,
    required int total,
    required int pct,
    required ColorScheme colors,
  }) {
    final Color barColor = pct >= 90
        ? Colors.red
        : pct >= 70
            ? Colors.orange
            : Colors.green;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label,
                style: TextStyle(
                    fontSize: 10, color: colors.onSurfaceVariant)),
            Text('$used/$total — $pct%',
                style: TextStyle(fontSize: 10, color: barColor)),
          ],
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: pct / 100,
            minHeight: 6,
            backgroundColor: colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }

  Widget _buildSaturationCta() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '⚠ Capacité maximale — nouvel armateur nécessaire',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.red),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => launchUrl(
              Uri.parse(
                  'https://opencollective.com/monnaie-libre'),
              mode: LaunchMode.externalApplication,
            ),
            child: const Text(
              '❤  opencollective.com/monnaie-libre',
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.amber,
                  decoration: TextDecoration.underline),
            ),
          ),
          const SizedBox(height: 4),
          const SelectableText(
            'bash <(curl -sL https://install.astroport.com)',
            style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceBar(
      String label, double value, Color barColor, ColorScheme colors) {
    const double maxVal = 1000;
    final double width = (value.abs() / maxVal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Text(label,
                style: TextStyle(
                    fontSize: 10, color: colors.onSurfaceVariant)),
          ),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: width,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 55,
            child: Text('${value.toStringAsFixed(1)} Z',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: colors.onSurface),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
