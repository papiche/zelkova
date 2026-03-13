import 'dart:convert';

/// Model for NOSTR kind 30850 station economy events.
///
/// Emitted by each Astroport station via ZEN.ECONOMY.sh,
/// contains economic health metrics, balances, capacities.
/// See UPlanet/earth/economy.Swarm.html for reference.
class StationEconomyData {
  StationEconomyData({
    required this.stationId,
    required this.stationName,
    required this.swarmId,
    required this.healthStatus,
    required this.bilan,
    required this.createdAt,
    this.generatedAt,
    this.cashBalance = 0,
    this.rndBalance = 0,
    this.assetsBalance = 0,
    this.impotBalance = 0,
    this.capitalBalance = 0,
    this.provisionTva = 0,
    this.provisionIs = 0,
    this.costPaf = 0,
    this.priceMultipass = 1,
    this.priceZencard = 4,
    this.multipassUsed = 0,
    this.multipassTotal = 250,
    this.zencardRenters = 0,
    this.zencardOwners = 0,
    this.zencardCapacity = 24,
    this.weeksRunway = 0,
    this.revenueTotal = 0,
    this.revenueMultipass = 0,
    this.revenueZencard = 0,
    this.stationLat = 0,
    this.stationLon = 0,
    this.solarOffset,
  });

  /// Parse from NOSTR event tags (kind 30850)
  factory StationEconomyData.fromEvent(Map<String, dynamic> event) {
    final List<dynamic> tags = event['tags'] as List<dynamic>? ?? <dynamic>[];
    final int createdAt = event['created_at'] as int? ?? 0;

    // Parse content JSON for extra fields not in tags
    Map<String, dynamic> content = <String, dynamic>{};
    try {
      final String contentStr = event['content'] as String? ?? '{}';
      content = Map<String, dynamic>.from(
          const JsonDecoder().convert(contentStr) as Map<dynamic, dynamic>);
    } catch (_) {}

    String _tag(String name) {
      for (final dynamic t in tags) {
        final List<dynamic> tag = t as List<dynamic>;
        if (tag.isNotEmpty && tag[0].toString() == name && tag.length >= 2) {
          return tag[1].toString();
        }
      }
      return '';
    }

    double _tagDouble(String name) =>
        double.tryParse(_tag(name)) ?? 0;
    int _tagInt(String name) => int.tryParse(_tag(name)) ?? 0;

    final String stationId = _tag('station');

    return StationEconomyData(
      stationId: stationId,
      stationName: _tag('station:name').isNotEmpty
          ? _tag('station:name')
          : (stationId.length > 8
              ? '...${stationId.substring(stationId.length - 8)}'
              : stationId),
      swarmId: _tag('swarm_id').isNotEmpty ? _tag('swarm_id') : 'default',
      healthStatus: _tag('health:status').isNotEmpty
          ? _tag('health:status')
          : 'healthy',
      bilan: _tagDouble('health:bilan'),
      generatedAt: content['generated_at'] as String?,
      createdAt: createdAt,
      cashBalance: _tagDouble('balance:cash'),
      rndBalance: _tagDouble('balance:rnd'),
      assetsBalance: _tagDouble('balance:assets'),
      impotBalance: _tagDouble('balance:impot'),
      capitalBalance: _tagDouble('balance:capital'),
      provisionTva: _tagDouble('provision:tva'),
      provisionIs: _tagDouble('provision:is'),
      costPaf: _tagDouble('cost:paf'),
      priceMultipass: _tagDouble('price:multipass'),
      priceZencard: _tagDouble('price:zencard'),
      multipassUsed: _tagInt('capacity:multipass_used'),
      multipassTotal: _tagInt('capacity:multipass_total'),
      zencardRenters: _tagInt('capacity:zencard_renters'),
      zencardOwners: _tagInt('capacity:zencard_owners'),
      zencardCapacity: _tagInt('capacity:zencard_capacity'),
      weeksRunway: _tagInt('health:weeks_runway'),
      revenueTotal: _tagDouble('revenue:total'),
      revenueMultipass: _tagDouble('revenue:multipass'),
      revenueZencard: _tagDouble('revenue:zencard'),
      stationLat: _tagDouble('geo:lat'),
      stationLon: _tagDouble('geo:lon'),
      solarOffset: _tag('sync:solar_offset').isNotEmpty
          ? _tag('sync:solar_offset')
          : null,
    );
  }

  final String stationId;
  final String stationName;
  final String swarmId;
  final String healthStatus;
  final double bilan;
  final int createdAt;
  final String? generatedAt;

  // Shared wallets (same for all stations in swarm)
  final double cashBalance;
  final double rndBalance;
  final double assetsBalance;
  final double impotBalance;
  final double capitalBalance;
  final double provisionTva;
  final double provisionIs;

  // Cost and pricing
  final double costPaf;
  final double priceMultipass;
  final double priceZencard;

  // Local station capacities
  final int multipassUsed;
  final int multipassTotal;
  final int zencardRenters;
  final int zencardOwners;
  final int zencardCapacity;
  final int weeksRunway;

  // Revenue
  final double revenueTotal;
  final double revenueMultipass;
  final double revenueZencard;

  // Geo
  final double stationLat;
  final double stationLon;
  final String? solarOffset;

  int get totalUsers => multipassUsed + zencardRenters + zencardOwners;

  bool get isHealthy => healthStatus == 'healthy';
  bool get isWarning =>
      healthStatus == 'warning' || healthStatus == 'growth_slowdown';
  bool get isCritical =>
      healthStatus == 'critical' || healthStatus == 'innovation_slowdown';
  bool get isBankrupt => healthStatus == 'bankrupt';
}
