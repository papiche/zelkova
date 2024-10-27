import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

Future<Client> initDuniterIndexerClient(String endpoint, [Store? store]) async {
  final Cache cache =
      Cache(store: store); // , possibleTypes: possibleTypesMap);

  final HttpLink link = HttpLink(endpoint);

  final Client client = Client(
    link: link,
    cache: cache,
  );

  return client;
}
