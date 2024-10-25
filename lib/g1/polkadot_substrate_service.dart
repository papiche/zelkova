import 'dart:convert';

import 'package:http/http.dart';
import 'package:polkadot_dart/polkadot_dart.dart';

import 'polkadot_provider.dart';

class WsSubstrateService with SubstrateRPCService {
  WsSubstrateService(this.provider);

  final PolkaDotProvider provider;

  @override
  String get url => provider.url.toString();

  @override
  Future<Map<String, dynamic>> call(SubstrateRequestDetails params,
      [Duration? timeout]) async {
    return provider.send(params.method, params.params);
  }
}

class MySubstrateHttpService with SubstrateRPCService {
  MySubstrateHttpService(this.url,
      {Client? client, this.defaultTimeOut = const Duration(seconds: 30)})
      : client = client ?? Client();

  /// URL of the Substrate node.
  @override
  final String url;

  /// HTTP client for making requests.
  final Client client;

  /// Default timeout duration for requests.
  final Duration defaultTimeOut;

  /// Method to make a Substrate RPC call.
  @override
  Future<Map<String, dynamic>> call(SubstrateRequestDetails params,
      [Duration? timeout]) async {
    // Making a POST request to the Substrate node.
    final Response response = await client
        .post(Uri.parse(url),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: params.toRequestBody())
        .timeout(timeout ?? defaultTimeOut);

    // Parsing the response data.
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    return data;
  }
}
