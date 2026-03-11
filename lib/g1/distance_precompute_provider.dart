import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'distance_precompute.dart';

// From duniter-vue
// https://git.duniter.org/HugoTrentesaux/duniter-vue/-/blob/master/src/distance.ts?ref_type=heads
class DistancePrecomputeProvider {
  Future<DistancePrecompute?> fetchDistancePrecompute() async {
    const String url =
        'https://files.coinduf.eu/distance_precompute/latest_distance.json';
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            json.decode(response.body) as Map<String, dynamic>;
        return parse(jsonData);
      } else {
        debugPrint(
            'Failed to fetch distance precompute: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching distance precompute: $e');
    }
    return null;
  }

  DistancePrecompute parse(Map<String, dynamic> json) {
    final Map<int, int> results = <int, int>{};
    for (final MapEntry<String, dynamic> entry
        in (json['results'] as Map<String, dynamic>).entries) {
      results[int.parse(entry.key)] = int.parse(entry.value.toString());
    }
    return DistancePrecompute(
      height: json['height'] as int,
      block: json['block'] as String,
      refereesCount: json['referees_count'] as int,
      memberCount: json['member_count'] as int,
      minCertsForReferee: json['min_certs_for_referee'] as int,
      results: results,
    );
  }
}
