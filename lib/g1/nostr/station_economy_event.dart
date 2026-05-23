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
    this.multipassTotal = 0,
    this.zencardRenters = 0,
    this.zencardOwners = 0,
    this.zencardCapacity = 0,
    this.weeksRunway = 0,
    this.revenueTotal = 0,
    this.revenueMultipass = 0,
    this.revenueZencard = 0,
    this.stationLat = 0,
    this.stationLon = 0,
    this.solarOffset,
    this.hwPowerScore = 0,
    this.hwTier = 'light',
    this.hwGpuVramGb = 0,
    this.hwCpuCores = 1,
    this.hwRamGb = 0,
    this.hwBoots = const <Map<String, dynamic>>[],
    this.stationUrl,
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
        final List<dynamic> entry = t as List<dynamic>;
        if (entry.isNotEmpty &&
            entry[0].toString() == name &&
            entry.length >= 2) {
          return entry[1].toString();
        }
      }
      return '';
    }

    double tagDouble(String name) => double.tryParse(tag(name)) ?? 0;
    int tagInt(String name) => int.tryParse(tag(name)) ?? 0;

    final String stationId = tag('station');
    final Map<String, dynamic>? hw =
        content['hardware'] as Map<String, dynamic>?;

    return StationEconomyData(
      stationId: stationId,
      stationName: tag('station:name').isNotEmpty
          ? tag('station:name')
          : (stationId.length > 8
              ? '...${stationId.substring(stationId.length - 8)}'
              : stationId),
      swarmId: tag('swarm_id').isNotEmpty ? tag('swarm_id') : 'default',
      healthStatus:
          tag('health:status').isNotEmpty ? tag('health:status') : 'healthy',
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
      solarOffset:
          tag('sync:solar_offset').isNotEmpty ? tag('sync:solar_offset') : null,
      hwPowerScore: tagInt('hw:power_score'),
      hwTier: tag('hw:tier').isNotEmpty ? tag('hw:tier') : 'light',
      hwGpuVramGb: tagDouble('hw:gpu_vram_gb'),
      hwCpuCores:
          hw != null ? (hw['cpu_cores'] as int? ?? tagInt('hw:cpu_cores')) : tagInt('hw:cpu_cores'),
      hwRamGb: hw != null
          ? ((hw['ram_gb'] as num?)?.toDouble() ?? tagDouble('hw:ram_gb'))
          : tagDouble('hw:ram_gb'),
      hwBoots: _parseBoots(hw, content, tag('hw:boots')),
      stationUrl: tag('station:url').isNotEmpty ? tag('station:url') : null,
    );
  }

  static List<Map<String, dynamic>> _parseBoots(
    Map<String, dynamic>? hw,
    Map<String, dynamic> content,
    String bootsTag,
  ) {
    final dynamic raw = hw?['boots'] ?? content['boots'];
    if (raw is List<dynamic>) {
      return raw
          .map((dynamic e) =>
              Map<String, dynamic>.from(e as Map<String, dynamic>))
          .toList();
    }
    if (bootsTag.isNotEmpty) {
      try {
        final dynamic parsed = const JsonDecoder().convert(bootsTag);
        if (parsed is List<dynamic>) {
          return parsed
              .map((dynamic e) =>
                  Map<String, dynamic>.from(e as Map<String, dynamic>))
              .toList();
        }
      } catch (_) {}
    }
    return const <Map<String, dynamic>>[];
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

  // Local station capacities (0 = unknown/not published)
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

  // Hardware
  final int hwPowerScore;
  final String hwTier;
  final double hwGpuVramGb;
  final int hwCpuCores;
  final double hwRamGb;
  final List<Map<String, dynamic>> hwBoots;

  // UPassport endpoint for this station (tag station:url)
  final String? stationUrl;

  bool get isGpuBrain => hwTier == 'brain' && hwGpuVramGb > 0;
  String get tierEmoji =>
      isGpuBrain ? '🔥🎮' : hwTier == 'brain' ? '🔥' : hwTier == 'standard' ? '⚡' : '🌿';

  int get totalUsers => multipassUsed + zencardRenters + zencardOwners;

  // Capacity helpers — returns null when total is unknown
  int? get mpSaturationPct =>
      multipassTotal > 0 ? (multipassUsed * 100 ~/ multipassTotal).clamp(0, 100) : null;
  int get zcUsed => zencardRenters + zencardOwners;
  int? get zcSaturationPct =>
      zencardCapacity > 0 ? (zcUsed * 100 ~/ zencardCapacity).clamp(0, 100) : null;
  bool get isSaturated =>
      (mpSaturationPct != null && mpSaturationPct! >= 90) ||
      (zcSaturationPct != null && zcSaturationPct! >= 90);

  bool get isHealthy => healthStatus == 'healthy';
  bool get isWarning =>
      healthStatus == 'warning' || healthStatus == 'growth_slowdown';
  bool get isCritical =>
      healthStatus == 'critical' || healthStatus == 'innovation_slowdown';
  bool get isBankrupt => healthStatus == 'bankrupt';
}
