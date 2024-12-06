import 'package:built_collection/built_collection.dart';
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:get_it/get_it.dart';

import '../data/models/cert.dart';
import '../data/models/contact.dart';
import '../data/models/identity_status.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../ui/logger.dart';
import 'g1_helper.dart';
import 'g1_v2_helper_others.dart';

Future<List<Contact>> searchWotV2(String searchPatternRaw) async {
  final List<Contact> contacts = <Contact>[];
  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    loggerDev('Searching indexer v2 with pattern $searchPatternRaw');
    try {
      // if is a v1Key, search pubkey
      final String searchPattern = validateKey(searchPatternRaw)
          ? addressFromV1Pubkey(searchPatternRaw)
          : searchPatternRaw;
      loggerDev("Searching indexer v2 with '$searchPattern'");

      if (searchPattern.length < 8) {
        loggerDev('Searching wot by name');
        final GIdentitiesByNameReq req = GIdentitiesByNameReq(
            (GIdentitiesByNameReqBuilder b) => b..vars.pattern = searchPattern);
        // Warn: We are caching results in the hive store
        final ferry.Client client = await initDuniterIndexerClient(
            node.url, GetIt.instance<HiveStore>());

        final ferry
            .OperationResponse<GIdentitiesByNameData, GIdentitiesByNameVars>
            response = await client.request(req).first;
        if (response.hasErrors) {
          loggerDev('Error: ${response.linkException?.originalException}');
        } else {
          final GIdentitiesByNameData? identity = response.data;
          for (final GIdentitiesByNameData_identity identity
              in identity!.identity) {
            final String? address = identity.accountId;
            if (address == null) {
              loggerDev('ERROR: Pubkey is null');
            } else {
              contacts.add(
                  Contact.withAddress(nick: identity.name, address: address));
            }
          }
        }
      } else {
        loggerDev('Searching wot by name or pk');
        final GIdentitiesByNameOrPkReq req =
            GIdentitiesByNameOrPkReq((GIdentitiesByNameOrPkReqBuilder b) => b
              // Improve this
              ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
              ..vars.pattern = searchPattern);
        final ferry.Client client = await initDuniterIndexerClient(
            node.url, GetIt.instance<HiveStore>());

        final ferry.OperationResponse<GIdentitiesByNameOrPkData,
                GIdentitiesByNameOrPkVars> response =
            await client.request(req).first;

        if (response.hasErrors) {
          loggerDev('Error: ${response.linkException?.originalException}');
        } else {
          final GIdentitiesByNameOrPkData? identities = response.data;
          for (final GIdentitiesByNameOrPkData_identity identity
              in identities!.identity) {
            final String? address = identity.accountId;
            if (address == null) {
              loggerDev('ERROR: Pubkey is null');
            } else {
              contacts.add(_contactFromIdentity(identity));
            }
          }
        }
      }
    } catch (e) {
      loggerDev('Error searching wot: $e');
    }
    loggerDev('Contacts found in wot search ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in wot search');
  return contacts;
}

Future<List<Contact>> getIdentities({required List<String> addresses}) async {
  final List<Contact> contacts = <Contact>[];
  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    loggerDev('Searching indexer v2 with pubKeys $addresses');
    try {
      final GIdentitiesByPkReq req =
          GIdentitiesByPkReq((GIdentitiesByPkReqBuilder b) => b
            // Improve this
            ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
            ..vars.pubKeys.replace(addresses));
      final ferry.Client client =
          await initDuniterIndexerClient(node.url, GetIt.instance<HiveStore>());

      final ferry.OperationResponse<GIdentitiesByPkData, GIdentitiesByPkVars>
          response = await client.request(req).first;

      if (response.hasErrors) {
        loggerDev('Error: ${response.linkException?.originalException}',
            error: response.linkException?.originalException);
      } else {
        final GIdentitiesByPkData? identities = response.data;
        for (final GIdentitiesByPkData_identity identity
            in identities!.identity) {
          final String? address = identity.accountId;
          if (address == null) {
            loggerDev('ERROR: Pubkey is null');
          } else {
            contacts.add(_contactFromIdentity(identity));
          }
        }
      }
    } catch (e) {
      loggerDev('Error searching wot: $e');
    }
    loggerDev('Contacts found in wot search ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in wot search');
  return contacts;
}

Contact _contactFromIdentity(dynamic identity) {
  if (identity == null) {
    throw ArgumentError('Identity cannot be null');
  }
  return Contact.withAddress(
    nick: (identity as dynamic).name as String?,
    address: (identity as dynamic).accountId as String,
    certsReceived: (identity as dynamic).certReceived == null
        ? <Cert>[]
        : ((identity as dynamic).certReceived as BuiltList<dynamic>)
            // ignore: always_specify_types
            .map((cert) => _buildCert(cert))
            .toList(),
    certsIssued: (identity as dynamic).certIssued == null
        ? <Cert>[]
        : ((identity as dynamic).certIssued as BuiltList<dynamic>)
            // ignore: always_specify_types
            .map((cert) => _buildCert(cert))
            .toList(),
    status: parseIdentityStatus(
        ((identity as dynamic).status as dynamic)?.name as String?),
    isMember: (identity as dynamic).isMember as bool?,
    createdOn: ((identity as dynamic).account as dynamic).createdOn as int?,
    expireOn: (identity as dynamic).expireOn as int?,
  );
}

Cert _buildCert(dynamic cert) {
  return Cert(
    id: (cert as dynamic).id as String,
    issuerId: Contact.withAddress(
        name: ((cert as dynamic).issuer as dynamic).name as String,
        address: ((cert as dynamic).issuer as dynamic).accountId as String),
    receiverId: Contact.withAddress(
        name: ((cert as dynamic).receiver as dynamic).name as String,
        address: ((cert as dynamic).receiver as dynamic).accountId as String),
    createdOn: (cert as dynamic).createdOn as int,
    expireOn: (cert as dynamic).expireOn as int,
    isActive: (cert as dynamic).isActive as bool,
    updatedOn: (cert as dynamic).updatedOn as int,
  );
}

Future<Contact> getIdentity({required String address}) async {
  final List<Contact> contacts =
      await getIdentities(addresses: <String>[address]);
  return contacts.isNotEmpty
      ? contacts.first
      : Contact.withAddress(address: address);
}

Contact _contactFromAccount(dynamic account) {
  if (account == null) {
    throw ArgumentError('Account cannot be null');
  }
  final dynamic identity = (account as dynamic).identity;

  return Contact.withAddress(
    nick: (identity as dynamic)?.name as String?,
    address: (account as dynamic).id as String,
    status: parseIdentityStatus(
        ((identity as dynamic)?.status as dynamic)?.name as String?),
    isMember: (identity as dynamic)?.isMember as bool?,
    createdOn: (account as dynamic).createdOn as int?,
    expireOn: (identity as dynamic).expireOn as int?,
    certsIssued: (identity as dynamic)?.certIssued == null
        ? <Cert>[]
        : ((identity as dynamic).certIssued as BuiltList<dynamic>)
            .map((dynamic cert) => _buildCert(cert))
            .toList(),
    certsReceived: (identity as dynamic)?.certReceived == null
        ? <Cert>[]
        : ((identity as dynamic).certReceived as BuiltList<dynamic>)
            .map((dynamic cert) => _buildCert(cert))
            .toList(),
  );
}

Future<List<Contact>> getAccounts({required List<String> accountIds}) async {
  final List<Contact> contacts = <Contact>[];
  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    loggerDev('Fetching accounts with IDs: $accountIds');
    try {
      final GAccountsByPkReq req = GAccountsByPkReq(
        (GAccountsByPkReqBuilder b) => b
          ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
          ..vars.accountIds.replace(accountIds),
      );

      final ferry.Client client =
          await initDuniterIndexerClient(node.url, GetIt.instance<HiveStore>());

      final ferry.OperationResponse<GAccountsByPkData, GAccountsByPkVars>
          response = await client.request(req).first;

      if (response.hasErrors) {
        loggerDev('Error: ${response.linkException?.originalException}',
            error: response.linkException?.originalException);
      } else {
        final GAccountsByPkData? accountsData = response.data;
        if (accountsData != null) {
          for (final dynamic account in accountsData.account) {
            final Contact contact = _contactFromAccount(account);
            contacts.add(contact);
          }
        }
      }
    } catch (e) {
      loggerDev('Error fetching accounts: $e');
      // retry??
    }
    loggerDev('Contacts found in wot search ${contacts.length}');
    return contacts;
  }
  loggerDev('Fetched ${contacts.length} accounts');
  return contacts;
}

Future<Contact> getAccount({required String address}) async {
  final List<Contact> contacts =
      await getAccounts(accountIds: <String>[address]);
  return contacts.isNotEmpty
      ? contacts.first
      : Contact.withAddress(address: address);
}
