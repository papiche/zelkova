import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

import 'graphql/schema/__generated__/duniter-datapod.schema.schema.gql.dart';

Future<Client> initDuniterDatapodClient(String endpoint) async {
  final cache = Cache(possibleTypes: possibleTypesMap);
  final link = HttpLink(endpoint);

  return Client(
    link: link,
    cache: cache,
  );
}
