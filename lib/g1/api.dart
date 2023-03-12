import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'node_bloc.dart';

// Tx history
// https://g1.duniter.org/tx/history/FadJvhddHL7qbRd3WcRPrWEJJwABQa3oZvmCBhotc7Kg
// https://g1.duniter.org/tx/history/6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH

Future<String> getTxHistory(String publicKey) async {
  final Response response =
      await NodeBloc().requestWithRetry('/tx/history/$publicKey');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load tx history');
  }
}

Future<Response> getPeers() async {
  final Response response = await NodeBloc().requestWithRetry('/network/peers');
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load duniter node peers');
  }
}

Future<Response> searchUser(String searchTerm) async {
  final Response response =
      await NodeBloc().requestWithRetry('/wot/lookup/$searchTerm');
  return response;
}

/*

http://doc.e-is.pro/cesium-plus-pod/REST_API.html#userprofile

Not found sample:
{
"_index": "user",
"_type": "profile",
"_id": "H97or89hW4kzKcvpmFPAAvc1znJrbJWJSYS9XnW37JrM",
"found": false
}
 */

Future<String> getDataImageFromKey(String publicKey) async {
  // FIXME (vjrj) use node manager and retry...
  final String url = 'https://g1.data.le-sou.org/user/profile/$publicKey';
  final Response response = await http.get(Uri.parse(url));
  if (response.statusCode == HttpStatus.ok) {
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> source = data['_source'] as Map<String, dynamic>;
    if (source.containsKey('avatar')) {
      final Map<String, dynamic> avatarData =
          source['avatar'] as Map<String, dynamic>;
      if (avatarData.containsKey('_content')) {
        final String content = avatarData['_content'] as String;
        return 'data:image/png;base64,$content';
      }
    }
  }
  throw Exception('Failed to load avatar');
}

Uint8List imageFromBase64String(String base64String) {
  return Uint8List.fromList(
      base64Decode(base64String.substring(base64String.indexOf(',') + 1)));
}

Future<Uint8List> getAvatar(String pubKey) async {
  final String dataImage = await getDataImageFromKey(pubKey);
  return imageFromBase64String(dataImage);
}
