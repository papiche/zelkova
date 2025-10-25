import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:ferry/ferry.dart' as ferry;

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
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  for (final Node node in nodes) {
    loggerDev(
        'Searching indexer v2 with pattern $searchPatternRaw in node ${node.url}');
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
        // Note: Using MemoryStore in isolate (Hive stores cannot be passed between isolates)
        final ferry.Client client = await initDuniterIndexerClient(node.url);

        final ferry
            .OperationResponse<GIdentitiesByNameData, GIdentitiesByNameVars>
            response = await client.request(req).timeout(
          const Duration(seconds: 20),
          onTimeout: (EventSink<
                  ferry.OperationResponse<GIdentitiesByNameData,
                      GIdentitiesByNameVars>>
              sink) {
            throw TimeoutException('Request timed out');
          },
        ).firstWhere(
          (ferry.OperationResponse<GIdentitiesByNameData, GIdentitiesByNameVars>
                  response) =>
              true,
          orElse: () =>
              throw Exception('Stream completed without emitting a value'),
        );
        if (response.hasErrors) {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause: 'GraphQL errors searching by name');
          loggerDev('Node ${node.url} returned errors searching by name');
          processFerryError(
              response as ferry.OperationResponse<dynamic, dynamic>);
          continue; // Try next node
        } else {
          final GIdentitiesByNameData? data = response.data;
          if (data != null && data.identities != null) {
            for (final GIdentitiesByNameData_identities_nodes? identity
                in data.identities?.nodes ??
                    <GIdentitiesByNameData_identities_nodes>[]) {
              if (identity == null) {
                continue;
              }
              final String? address = identity.accountId;
              if (address == null) {
                loggerDev('ERROR: Pubkey is null');
              } else {
                contacts.add(
                    Contact.withAddress(nick: identity.name, address: address));
              }
            }
          }
          break; // Success
        }
      } else {
        loggerDev('Searching wot by name or pk');
        final GIdentitiesByNameOrPkReq req =
            GIdentitiesByNameOrPkReq((GIdentitiesByNameOrPkReqBuilder b) => b
              // Improve this
              ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
              ..vars.pattern = searchPattern);
        final ferry.Client client = await initDuniterIndexerClient(node.url);

        final ferry.OperationResponse<GIdentitiesByNameOrPkData,
                GIdentitiesByNameOrPkVars> response =
            await client.request(req).timeout(
          const Duration(seconds: 20),
          onTimeout: (EventSink<
                  ferry.OperationResponse<GIdentitiesByNameOrPkData,
                      GIdentitiesByNameOrPkVars>>
              sink) {
            throw TimeoutException('Request timed out');
          },
        ).firstWhere(
          (ferry.OperationResponse<GIdentitiesByNameOrPkData,
                      GIdentitiesByNameOrPkVars>
                  response) =>
              true,
          orElse: () =>
              throw Exception('Stream completed without emitting a value'),
        );

        if (response.hasErrors) {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause: 'GraphQL errors searching by name or pk');
          loggerDev('Node ${node.url} returned errors searching by name or pk');
          processFerryError(
              response as ferry.OperationResponse<dynamic, dynamic>);
          continue; // Try next node
        } else {
          final GIdentitiesByNameOrPkData? data = response.data;
          if (data != null && data.identities != null) {
            for (final GIdentitiesByNameOrPkData_identities_nodes identity
                in data.identities!.nodes) {
              final String? address = identity.accountId;
              if (address == null) {
                loggerDev('ERROR: Pubkey is null');
              } else {
                contacts.add(_contactFromIdentity(identity));
              }
            }
          }
          break; // Success
        }
      }
    } catch (e, st) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Error searching wot: $e');
      log.e('Error searching wot in node ${node.url}',
          error: e, stackTrace: st);
      continue; // Try next node
    }
  }
  loggerDev('Contacts found in wot search ${contacts.length}');
  ContactsCache().addContacts(contacts);
  return contacts;
}

Future<List<Contact>> getIdentities({required List<String> addresses}) async {
  final List<Contact> contacts = <Contact>[];
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  for (final Node node in nodes) {
    loggerDev(
        'Searching indexer v2 with pubKeys $addresses in node ${node.url}');
    try {
      final GIdentitiesByPkReq req =
          GIdentitiesByPkReq((GIdentitiesByPkReqBuilder b) => b
            // Improve this
            ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
            ..vars.pubKeys.replace(addresses));
      final ferry.Client client = await initDuniterIndexerClient(node.url);

      final ferry.OperationResponse<GIdentitiesByPkData, GIdentitiesByPkVars>
          response = await client.request(req).timeout(
        const Duration(seconds: 20),
        onTimeout: (EventSink<
                ferry
                .OperationResponse<GIdentitiesByPkData, GIdentitiesByPkVars>>
            sink) {
          throw TimeoutException('Request timed out');
        },
      ).firstWhere(
        (ferry.OperationResponse<GIdentitiesByPkData, GIdentitiesByPkVars>
                response) =>
            true,
        orElse: () =>
            throw Exception('Stream completed without emitting a value'),
      );

      if (response.hasErrors) {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'GraphQL errors getting identities');
        loggerDev('Node ${node.url} returned errors getting identities');
        processFerryError(response);
        continue; // Try next node
      } else {
        final GIdentitiesByPkData? data = response.data;
        if (data != null && data.identities != null) {
          loggerDev(
              'Successfully fetched ${data.identities!.nodes.length} identities from node ${node.url}');
          for (final GIdentitiesByPkData_identities_nodes identity
              in data.identities!.nodes) {
            final String? address = identity.accountId;
            if (address == null) {
              loggerDev('ERROR: Pubkey is null');
            } else {
              contacts.add(_contactFromIdentity(identity));
            }
          }
          break; // Success
        } else {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause: 'Null data getting identities');
          loggerDev('Node ${node.url} returned null data');
          continue; // Try next node
        }
      }
    } catch (e, st) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Exception getting identities: $e');
      loggerDev('Error getting identities from node ${node.url}',
          error: e, stackTrace: st);
      continue; // Try next node
    }
  }
  loggerDev('Contacts found: ${contacts.length}');
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
  final dynamic identity = (account as dynamic).linkedIdentity;
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
              ((identity as dynamic)?.status as dynamic) as String?),
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
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  for (final Node node in nodes) {
    loggerDev('Fetching accounts with IDs: $accountIds from node ${node.url}');
    try {
      final GAccountsByPkReq req = GAccountsByPkReq(
        (GAccountsByPkReqBuilder b) => b
          ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
          ..vars.accountIds.replace(accountIds),
      );

      final ferry.Client client = await initDuniterIndexerClient(node.url);

      final ferry.OperationResponse<GAccountsByPkData, GAccountsByPkVars>
          response = await client.request(req).timeout(
        const Duration(seconds: 20),
        onTimeout: (EventSink<
                ferry.OperationResponse<GAccountsByPkData, GAccountsByPkVars>>
            sink) {
          throw TimeoutException('Request timed out');
        },
      ).firstWhere(
        (ferry.OperationResponse<GAccountsByPkData, GAccountsByPkVars>
                response) =>
            true,
        orElse: () =>
            throw Exception('Stream completed without emitting a value'),
      );

      if (response.hasErrors) {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'GraphQL errors in accounts response');
        loggerDev('Node ${node.url} returned GraphQL errors');
        processFerryError(response);
        continue; // Try next node
      } else {
        final GAccountsByPkData? accountsData = response.data;
        if (accountsData != null && accountsData.accounts != null) {
          loggerDev(
              'Successfully fetched ${accountsData.accounts!.nodes.length} accounts from node ${node.url}');
          for (final dynamic account in accountsData.accounts!.nodes) {
            final Contact contact = _contactFromAccount(account);
            contacts.add(contact);
          }
          break; // Success, exit loop
        } else {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause: 'Null accounts data in response');
          loggerDev('Node ${node.url} returned null data');
          continue; // Try next node
        }
      }
    } catch (e, st) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Error fetching accounts: $e');
      log.e('Error fetching accounts from node ${node.url}',
          error: e, stackTrace: st);
      // Continue with next node
      continue;
    }
  }
  loggerDev('Accounts found in wot search ${contacts.length}');
  ContactsCache().addContacts(contacts);
  return contacts;
}

void processFerryError(ferry.OperationResponse<dynamic, dynamic> response) {
  String error = 'Unknown error';

  if (response.graphqlErrors != null && response.graphqlErrors!.isNotEmpty) {
    error = response.graphqlErrors!.first.message;
  } else if (response.linkException != null) {
    error = response.linkException.toString();
    if (response.linkException!.originalException != null) {
      loggerDev(
          'Ferry error details: ${response.linkException!.originalException}');
      if (response.linkException!.originalException is FormatException) {
        error =
            'FormatException: The server response is not valid JSON. The server might be returning HTML or plain text instead of JSON.';
      }
    }
  } else if (response.data == null) {
    error = 'Response data is null';
  }

  loggerDev('Ferry error: $error');
  throw Exception('Ferry error: $error');
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
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  for (final Node node in nodes) {
    loggerDev(
        'Fetching basic accounts with IDs: $accountIds from node ${node.url}');
    try {
      final GAccountsBasicByPkReq req = GAccountsBasicByPkReq(
        (GAccountsBasicByPkReqBuilder b) => b
          ..fetchPolicy = ferry.FetchPolicy.NetworkOnly
          ..vars.accountIds.replace(accountIds),
      );

      final ferry.Client client = await initDuniterIndexerClient(node.url);

      final ferry
          .OperationResponse<GAccountsBasicByPkData, GAccountsBasicByPkVars>
          response = await client.request(req).timeout(
        const Duration(seconds: 20),
        onTimeout: (EventSink<
                ferry.OperationResponse<GAccountsBasicByPkData,
                    GAccountsBasicByPkVars>>
            sink) {
          throw TimeoutException('Request timed out');
        },
      ).firstWhere(
        (ferry.OperationResponse<GAccountsBasicByPkData, GAccountsBasicByPkVars>
                response) =>
            true,
        orElse: () =>
            throw Exception('Stream completed without emitting a value'),
      );

      if (response.hasErrors) {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'GraphQL errors getting basic accounts');
        loggerDev('Node ${node.url} returned errors getting basic accounts');
        processFerryError(response);
        continue; // Try next node
      } else {
        final GAccountsBasicByPkData? accountsData = response.data;
        if (accountsData != null && accountsData.accounts != null) {
          loggerDev(
              'Successfully fetched ${accountsData.accounts!.nodes.length} basic accounts from node ${node.url}');
          for (final dynamic account in accountsData.accounts!.nodes) {
            final Contact contact = _contactFromAccount(account);
            contacts.add(contact);
          }
          break; // Success
        } else {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause: 'Null data getting basic accounts');
          loggerDev('Node ${node.url} returned null data');
          continue; // Try next node
        }
      }
    } catch (e, st) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Exception getting basic accounts: $e');
      loggerDev('Error fetching basic accounts from node ${node.url}',
          error: e, stackTrace: st);
      continue; // Try next node
    }
  }
  loggerDev('Fetched ${contacts.length} basic accounts');
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
