import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String get duniterNet {
  return dotenv.get('NET');
}

String get duniterLookupUrl {
  return '${duniterNet}wot/lookup/';
}

String get duniterNetworkPeers {
  return '${duniterNet}network/peers';
}

String duniterAccountAvatar(String publickey) {
  return '${duniterNet}node/peers/$publickey/avatar';
}

Future<String> getAvatar(String publicKey) async {
  final String url = duniterAccountAvatar(publicKey);
  final Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load avatar');
  }
}
