import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../g1/duniter_node_manager.dart';

String get duniterNet {
  return DuniterNodeManager().fastestNode;
}

String get duniterLookupUrl {
  return '${duniterNet}/wot/lookup/';
}

String get duniterNetworkPeers {
  return '${duniterNet}/network/peers';
}

String duniterAccountAvatar(String publickey) {
  return '${duniterNet}/node/peers/$publickey/avatar';
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
