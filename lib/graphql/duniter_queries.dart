import '__generated__/duniter-indexer.schema.gql.dart';

final Gidentity_bool_expBuilder identityBoolExp = Gidentity_bool_exp(
    (Gidentity_bool_expBuilder b) => b.name..G_similar = '%Ana%').toBuilder();

final Gaccount_bool_exp accountBoolExp = Gaccount_bool_exp(
    (Gaccount_bool_expBuilder b) => b..identity = identityBoolExp);

// final accountsQuery = GAccountsQueryReq((b) => b..vars.where = accountBoolExp);

/* final queryReq = GAccountByNameReq((b) => b
  ..vars.where = accountBoolExp
  ..vars.orderBy = Gaccount_order_by((b) => b..identity_name_ASC = true)); */
