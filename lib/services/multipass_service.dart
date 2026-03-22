import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../shared_prefs_helper.dart';
import '../shared_prefs_helper_v2.dart';
import '../data/models/stored_account.dart';
import '../ui/logger.dart';

class MultipassService {
  static String _generateRandomString(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random rnd = Random.secure();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static Future<StoredAccount> createWallet({
    required String email,
    required double lat,
    required double lon,
    String lang = 'fr',
  }) async {
    final String baseUrl = Env.upassportUrl;
    
    // Generate Salt and Pepper locally
    final String salt = _generateRandomString(24);
    final String pepper = _generateRandomString(24);
    
    // Construct the URL. Assuming the API endpoint is /g1nostr
    // and it accepts query parameters.
    final Uri url = Uri.parse('$baseUrl/g1nostr').replace(queryParameters: {
      'email': email,
      'lang': lang,
      'lat': lat.toString(),
      'lon': lon.toString(),
      'salt': salt,
      'pepper': pepper,
      'format': 'json',
    });

    logger('Calling MULTIPASS API: $url');

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
        
        final String? nsec = data['nsec'] as String?;
        final String? npub = data['npub'] as String?;
        final String? nostrns = data['nostrns'] as String?;
        final String? ssss = data['ssss'] as String?;
        
        if (nsec != null && npub != null && nostrns != null) {
             return await SharedPreferencesHelperV2().createMultipassAccount(
              salt: salt,
              pepper: pepper,
              nsec: nsec,
              npub: npub,
              nostrns: nostrns,
              ssssPlayer: ssss ?? '',
              email: email,
              uplanetHome: baseUrl, // Assuming upassportUrl is the home
            );
        } else {
           throw Exception('Failed to extract keys from MULTIPASS JSON response');
        }
      } catch (e) {
        logger('Error parsing JSON response: $e');
        throw Exception('Invalid JSON response from MULTIPASS API');
      }
    } else {
      throw Exception('Failed to call MULTIPASS API: ${response.statusCode}');
    }
  }
}
