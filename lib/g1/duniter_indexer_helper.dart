import 'package:built_collection/built_collection.dart';
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry_hive_ce_store/ferry_hive_ce_store.dart';

import 'package:get_it/get_it.dart';

import '../data/models/cert.dart';
import '../data/models/contact.dart';
import '../data/models/identity_status.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import 'g1_helper.dart';
import 'g1_v2_helper.dart';

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
      // If works without errors, break
      break;
    } catch (e) {
      log.e('Error searching wot', error: e);
    }
    loggerDev('Contacts found in wot search ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in wot search');
  ContactsCache().addContacts(contacts);
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
      // If works without errors, break
      break;
    } catch (e) {
      log.e('Error searching wot', error: e);
    }
    loggerDev('Contacts found in wot search ${contacts.length}');
    return contacts;
  }
  loggerDev('Contacts not found in wot search');
  ContactsCache().addContacts(contacts);
  return contacts;
}

Contact _contactFromIdentity(dynamic identity) {
  if (identity == null) {
    throw ArgumentError('Identity cannot be null');
  }
  List<Cert> certReceived = <Cert>[];
  try {
    certReceived = ((identity as dynamic).certReceived as BuiltList<dynamic>)
        .map((dynamic cert) => _buildCert(cert))
        .where((Cert? cert) => cert != null)
        .cast<Cert>()
        .toList();
  } catch (e) {
    // Do nothing
  }
  List<Cert> certIssued = <Cert>[];
  try {
    certIssued = ((identity as dynamic).certIssued as BuiltList<dynamic>)
        .map((dynamic cert) => _buildCert(cert))
        .where((Cert? cert) => cert != null)
        .cast<Cert>()
        .toList();
  } catch (e) {
    // Do nothing
  }
  return Contact.withAddress(
    nick: (identity as dynamic).name as String?,
    address: (identity as dynamic).accountId as String,
    certsReceived: certReceived,
    certsIssued: certIssued,
    status: parseIdentityStatus(
        ((identity as dynamic).status as dynamic)?.name as String?),
    isMember: (identity as dynamic).isMember as bool?,
    index: (identity as dynamic).index as int?,
    createdOn: ((identity as dynamic).account as dynamic).createdOn as int?,
    expireOn: (identity as dynamic).expireOn as int?,
  );
}

Cert? _buildCert(dynamic cert) {
  final dynamic issuer = (cert as dynamic).issuer;
  final dynamic receiver = (cert as dynamic).receiver;

  // If the issuer or receiver is null (if the account is REMOVED), return null
  if ((issuer as dynamic).accountId == null ||
      (receiver as dynamic).accountId == null) {
    return null;
  }
  return Cert(
    id: (cert as dynamic).id as String,
    issuerId: Contact.withAddress(
        name: (issuer as dynamic).name as String,
        createdOn: ((issuer as dynamic).account as dynamic).createdOn as int,
        address: (issuer as dynamic).accountId as String,
        status: parseIdentityStatus(
            ((issuer as dynamic)?.status as dynamic)?.name as String?),
        isMember: (issuer as dynamic)?.isMember as bool?,
        expireOn: (issuer as dynamic).expireOn as int?,
        index: (issuer as dynamic).index as int?),
    receiverId: Contact.withAddress(
        name: (receiver as dynamic).name as String,
        createdOn: ((receiver as dynamic).account as dynamic).createdOn as int,
        address: (receiver as dynamic).accountId as String,
        status: parseIdentityStatus(
            ((receiver as dynamic)?.status as dynamic)?.name as String?),
        isMember: (receiver as dynamic)?.isMember as bool?,
        expireOn: (receiver as dynamic).expireOn as int?,
        index: (receiver as dynamic).index as int?),
    createdOn: (cert as dynamic).createdOn as int,
    expireOn: (cert as dynamic).expireOn as int,
    isActive: (cert as dynamic).isActive as bool,
    updatedOn: (cert as dynamic).updatedOn as int,
  );
}

Future<Contact?> getIdentity({required String address}) async {
  final List<Contact> contacts =
      await getIdentities(addresses: <String>[address]);
  return contacts.isNotEmpty ? contacts.first : null;
}

Contact _contactFromAccount(dynamic account) {
  if (account == null) {
    throw ArgumentError('Account cannot be null');
  }
  final dynamic identity = (account as dynamic).identity;
  List<Cert> certReceived = <Cert>[];
  List<Cert> certIssued = <Cert>[];
  try {
    certReceived = ((identity as dynamic).certReceived as BuiltList<dynamic>)
        .map((dynamic cert) => _buildCert(cert))
        .where((Cert? cert) => cert != null)
        .cast<Cert>()
        .toList();
  } catch (e) {
    // Do nothing
  }
  try {
    certIssued = ((identity as dynamic).certIssued as BuiltList<dynamic>)
        .map((dynamic cert) => _buildCert(cert))
        .where((Cert? cert) => cert != null)
        .cast<Cert>()
        .toList();
  } catch (e) {
    // Do nothing
  }

  return identity != null
      ? Contact.withAddress(
          nick: (identity as dynamic)?.name as String?,
          address: (account as dynamic).id as String,
          status: parseIdentityStatus(
              ((identity as dynamic)?.status as dynamic)?.name as String?),
          isMember: (identity as dynamic)?.isMember as bool?,
          createdOn: (account as dynamic).createdOn as int?,
          expireOn: (identity as dynamic).expireOn as int?,
          index: (identity as dynamic).index as int?,
          certsIssued: certIssued,
          certsReceived: certReceived,
        )
      : Contact.withAddress(
          address: (account as dynamic).id as String,
          createdOn: (account as dynamic).createdOn as int?,
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
      break;
    } catch (e) {
      log.e('Error fetching accounts', error: e);
      // retry
    }
  }
  loggerDev('Accounts found in wot search ${contacts.length}');
  ContactsCache().addContacts(contacts);
  return contacts;
}

Future<Contact> getAccount({required String address}) async {
  final List<Contact> contacts =
      await getAccounts(accountIds: <String>[address]);
  return contacts.isNotEmpty
      ? contacts.first
      : Contact.withAddress(address: address);
}

Future<List<Contact>> getAccountsBasic(
    {required List<String> accountIds}) async {
  final List<Contact> contacts = <Contact>[];
  for (final Node node in NodeManager().getBestNodes(NodeType.duniterIndexer)) {
    loggerDev('Fetching accounts with IDs: $accountIds');
    try {
      final GAccountsBasicByPkReq req = GAccountsBasicByPkReq(
        (GAccountsBasicByPkReqBuilder b) => b
          ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
          ..vars.accountIds.replace(accountIds),
      );

      final ferry.Client client =
          await initDuniterIndexerClient(node.url, GetIt.instance<HiveStore>());

      final ferry
          .OperationResponse<GAccountsBasicByPkData, GAccountsBasicByPkVars>
          response = await client.request(req).first;

      if (response.hasErrors) {
        loggerDev('Error: ${response.linkException?.originalException}',
            error: response.linkException?.originalException);
      } else {
        final GAccountsBasicByPkData? accountsData = response.data;
        if (accountsData != null) {
          for (final dynamic account in accountsData.account) {
            final Contact contact = _contactFromAccount(account);
            contacts.add(contact);
          }
        }
      }
      break;
    } catch (e, st) {
      log.e('Error fetching accounts', error: e, stackTrace: st);
      // retry
    }
  }
  loggerDev('Contacts found in wot search ${contacts.length}');
  loggerDev('Fetched ${contacts.length} accounts');
  ContactsCache().addContacts(contacts);
  return contacts;
}

Future<Contact> getAccountBasic({required String address}) async {
  final List<Contact> contacts =
      await getAccountsBasic(accountIds: <String>[address]);
  return contacts.isNotEmpty
      ? contacts.first
      : Contact.withAddress(address: address);
}
