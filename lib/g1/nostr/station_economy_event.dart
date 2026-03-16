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

    String tag(String name) {
      for (final dynamic t in tags) {
        final List<dynamic> tag = t as List<dynamic>;
        if (tag.isNotEmpty && tag[0].toString() == name && tag.length >= 2) {
          return tag[1].toString();
        }
      }
      return '';
    }

    double tagDouble(String name) =>
        double.tryParse(tag(name)) ?? 0;
    int tagInt(String name) => int.tryParse(tag(name)) ?? 0;

    final String stationId = tag('station');

    return StationEconomyData(
      stationId: stationId,
      stationName: tag('station:name').isNotEmpty
          ? tag('station:name')
          : (stationId.length > 8
              ? '...${stationId.substring(stationId.length - 8)}'
              : stationId),
      swarmId: tag('swarm_id').isNotEmpty ? tag('swarm_id') : 'default',
      healthStatus: tag('health:status').isNotEmpty
          ? tag('health:status')
          : 'healthy',
      bilan: tagDouble('health:bilan'),
      generatedAt: content['generated_at'] as String?,
      createdAt: createdAt,
      cashBalance: tagDouble('balance:cash'),
      rndBalance: tagDouble('balance:rnd'),
      assetsBalance: tagDouble('balance:assets'),
      impotBalance: tagDouble('balance:impot'),
      capitalBalance: tagDouble('balance:capital'),
      provisionTva: tagDouble('provision:tva'),
      provisionIs: tagDouble('provision:is'),
      costPaf: tagDouble('cost:paf'),
      priceMultipass: tagDouble('price:multipass'),
      priceZencard: tagDouble('price:zencard'),
      multipassUsed: tagInt('capacity:multipass_used'),
      multipassTotal: tagInt('capacity:multipass_total'),
      zencardRenters: tagInt('capacity:zencard_renters'),
      zencardOwners: tagInt('capacity:zencard_owners'),
      zencardCapacity: tagInt('capacity:zencard_capacity'),
      weeksRunway: tagInt('health:weeks_runway'),
      revenueTotal: tagDouble('revenue:total'),
      revenueMultipass: tagDouble('revenue:multipass'),
      revenueZencard: tagDouble('revenue:zencard'),
      stationLat: tagDouble('geo:lat'),
      stationLon: tagDouble('geo:lon'),
      solarOffset: tag('sync:solar_offset').isNotEmpty
          ? tag('sync:solar_offset')
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
