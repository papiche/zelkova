import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../g1/nostr/nostr_relay_service.dart';
import '../../../g1/nostr/station_economy_event.dart';
import '../../logger.dart';

/// Widget that subscribes to NOSTR kind 30850 events
/// and displays the economic health of the station constellation.
class SwarmEconomyWidget extends StatefulWidget {
  const SwarmEconomyWidget({super.key});

  @override
  State<SwarmEconomyWidget> createState() => _SwarmEconomyWidgetState();
}

class _SwarmEconomyWidgetState extends State<SwarmEconomyWidget> {
  Map<String, StationEconomyData> _stations =
      <String, StationEconomyData>{};
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
            // Critical first
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

    // Aggregate stats
    final int totalStations = sortedStations.length;
    final int healthyCount =
        sortedStations.where((StationEconomyData s) => s.isHealthy).length;
    final int totalUsers = sortedStations.fold<int>(
        0, (int sum, StationEconomyData s) => sum + s.totalUsers);
    final double totalRevenue = sortedStations.fold<double>(
        0, (double sum, StationEconomyData s) => sum + s.revenueTotal);
    final int healthPercent =
        totalStations > 0 ? (healthyCount * 100 ~/ totalStations) : 0;

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
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.tertiaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.satellite_alt,
                    color: colors.onTertiaryContainer),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tr('swarm_title'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors.onTertiaryContainer,
                    ),
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
                _buildAggregateTile(
                  '$totalStations',
                  tr('swarm_stations'),
                  Colors.cyan,
                  colors,
                ),
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
                _buildAggregateTile(
                  '$totalUsers',
                  tr('swarm_users'),
                  Colors.deepPurple,
                  colors,
                ),
                _buildAggregateTile(
                  '${totalRevenue.toStringAsFixed(0)} Z',
                  tr('swarm_revenue'),
                  Colors.amber,
                  colors,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Station list
          ...sortedStations.map((StationEconomyData station) {
            final bool isSelected =
                _selectedStationId == station.stationId;
            return _buildStationRow(station, isSelected, colors);
          }),

          // Selected station details
          if (_selectedStationId != null &&
              _stations.containsKey(_selectedStationId))
            _buildStationDetails(
                _stations[_selectedStationId]!, colors),
        ],
      ),
    );
  }

  Widget _buildAggregateTile(
      String value, String label, Color valueColor, ColorScheme colors) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: valueColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationRow(
      StationEconomyData station, bool isSelected, ColorScheme colors) {
    final Color statusColor = station.isHealthy
        ? Colors.green
        : station.isWarning
            ? Colors.orange
            : Colors.red;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedStationId = isSelected ? null : station.stationId;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.surfaceContainerHighest
              : null,
          border: Border(
            left: BorderSide(
              color: isSelected ? colors.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            // Status dot
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            // Name
            Expanded(
              flex: 3,
              child: Text(
                station.stationName,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Bilan
            Expanded(
              flex: 2,
              child: Text(
                '${station.bilan.toStringAsFixed(1)} Z',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: station.bilan >= 0 ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            // Users
            Expanded(
              flex: 2,
              child: Text(
                'MP:${station.multipassUsed} ZC:${station.zencardRenters + station.zencardOwners}',
                style: TextStyle(
                    fontSize: 10, color: colors.onSurfaceVariant),
                textAlign: TextAlign.right,
              ),
            ),
            // Runway
            SizedBox(
              width: 36,
              child: Text(
                '${station.weeksRunway}w',
                style: TextStyle(
                    fontSize: 11, color: colors.onSurfaceVariant),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationDetails(
      StationEconomyData station, ColorScheme colors) {
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
          // Report date & solar
          Row(
            children: <Widget>[
              if (station.generatedAt != null)
                Text(
                  station.generatedAt!.substring(0, 16).replaceFirst('T', ' '),
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant),
                ),
              const Spacer(),
              if (station.solarOffset != null)
                Text(
                  'Solar: ${station.solarOffset}',
                  style: TextStyle(
                      fontSize: 11, color: colors.onSurfaceVariant),
                ),
            ],
          ),
          const SizedBox(height: 8),

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

          // Revenue & pricing row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'CA: ${station.revenueTotal.toStringAsFixed(1)} Z/sem',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.amber.shade300,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'PAF: ${station.costPaf.toStringAsFixed(0)} Z',
                style: TextStyle(
                    fontSize: 11, color: colors.onSurfaceVariant),
              ),
              Text(
                'MP:${station.priceMultipass.toStringAsFixed(0)}Z ZC:${station.priceZencard.toStringAsFixed(0)}Z',
                style: TextStyle(
                    fontSize: 11, color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceBar(
      String label, double value, Color barColor, ColorScheme colors) {
    // Normalize bar width relative to an arbitrary max for visual display
    final double maxVal = 1000;
    final double width = (value.abs() / maxVal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Text(
              label,
              style:
                  TextStyle(fontSize: 10, color: colors.onSurfaceVariant),
            ),
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
            child: Text(
              '${value.toStringAsFixed(1)} Z',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: colors.onSurface,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
