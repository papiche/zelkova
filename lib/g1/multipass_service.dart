import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../env.dart';
import '../ui/logger.dart';

/// OC contribution URLs returned by the server
class OcUrls {
  OcUrls({
    this.satellite = '',
    this.constellation = '',
    this.cloud = '',
    this.membre = '',
  });

  factory OcUrls.fromJson(Map<String, dynamic>? json) {
    if (json == null) return OcUrls();
    return OcUrls(
      satellite: json['satellite'] as String? ?? '',
      constellation: json['constellation'] as String? ?? '',
      cloud: json['cloud'] as String? ?? '',
      membre: json['membre'] as String? ?? '',
    );
  }

  final String satellite;
  final String constellation;
  final String cloud;
  final String membre;
}

/// Response from the UPassport /g1nostr MULTIPASS creation endpoint
class MultipassResponse {
  MultipassResponse({
    required this.email,
    required this.salt,
    required this.pepper,
    required this.nsec,
    required this.g1pub,
    required this.npub,
    required this.hex,
    required this.nostrns,
    required this.lat,
    required this.lon,
    required this.ssssPlayer,
    required this.isOrigin,
    required this.ocUrls,
    required this.uplanetHome,
    required this.uplanetnameG1,
  });

  factory MultipassResponse.fromJson(Map<String, dynamic> json) {
    return MultipassResponse(
      email: json['email'] as String? ?? '',
      salt: json['salt'] as String? ?? '',
      pepper: json['pepper'] as String? ?? '',
      nsec: json['nsec'] as String? ?? '',
      g1pub: json['g1pub'] as String? ?? '',
      npub: json['npub'] as String? ?? '',
      hex: json['hex'] as String? ?? '',
      nostrns: json['nostrns'] as String? ?? '',
      lat: json['lat'] as String? ?? '',
      lon: json['lon'] as String? ?? '',
      ssssPlayer: json['ssss_player'] as String? ?? '',
      isOrigin: json['is_origin'] as bool? ?? false,
      ocUrls: OcUrls.fromJson(json['oc_urls'] as Map<String, dynamic>?),
      uplanetHome: json['uplanet_home'] as String? ?? '',
      uplanetnameG1: json['uplanetname_g1'] as String? ?? '',
    );
  }

  final String email;
  final String salt;
  final String pepper;
  final String nsec;
  final String g1pub;
  final String npub;
  final String hex;
  final String nostrns;
  final String lat;
  final String lon;
  final String ssssPlayer;
  final bool isOrigin;
  final OcUrls ocUrls;
  final String uplanetHome;
  final String uplanetnameG1;
}

/// Service to create a MULTIPASS identity via UPassport API
class MultipassService {
  static const Duration _timeout = Duration(seconds: 60);

  /// Create a MULTIPASS by calling the UPassport /g1nostr endpoint
  ///
  /// Returns [MultipassResponse] with salt, pepper, nsec, g1pub, etc.
  /// The salt and pepper can be used with [CesiumWallet] to derive
  /// the same G1 keypair locally.
  static Future<MultipassResponse> createMultipass({
    required String email,
    required String lang,
    required String lat,
    required String lon,
    String? serverUrl,
  }) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/g1nostr');

    final http.Response response = await http.post(
      uri,
      body: <String, String>{
        'email': email,
        'lang': lang,
        'lat': lat,
        'lon': lon,
        'format': 'json',
      },
    ).timeout(_timeout);

    if (response.statusCode != 200) {
      final Map<String, dynamic> error =
          jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['error'] ?? 'MULTIPASS creation failed');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    return MultipassResponse.fromJson(data);
  }

  /// Upload a profile image (avatar/banner) to the UPassport API.
  ///
  /// Returns the IPFS URL (or local fallback URL) of the uploaded image,
  /// or null on failure.
  static Future<String?> uploadImage({
    required String npub,
    required Uint8List imageBytes,
    required String imageType, // 'avatar', 'banner', 'logo'
    String filename = 'image.jpg',
    String? serverUrl,
  }) async {
    final String baseUrl = serverUrl ?? Env.upassportUrl;
    final Uri uri = Uri.parse('$baseUrl/api/upload/image');

    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..fields['npub'] = npub
      ..fields['type'] = imageType
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: filename,
      ));

    try {
      final http.StreamedResponse streamedResponse =
          await request.send().timeout(_timeout);
      final http.Response response =
          await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        // Prefer IPFS URL, fallback to local URL
        final String? ipfsUrl = data['ipfs_url'] as String?;
        final String? localUrl = data['local_url'] as String?;
        if (ipfsUrl != null && ipfsUrl.isNotEmpty) return ipfsUrl;
        if (localUrl != null && localUrl.isNotEmpty) {
          return '$baseUrl$localUrl';
        }
        return data['url'] as String?;
      }
      loggerDev('Image upload failed: ${response.statusCode} ${response.body}');
    } catch (e) {
      loggerDev('Image upload error: $e');
    }
    return null;
  }
}
