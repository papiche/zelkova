import 'dart:async';

import 'package:built_collection/built_collection.dart' show BuiltList;
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

        ferry.OperationResponse<GIdentitiesByNameData, GIdentitiesByNameVars>?
            response;

        try {
          response = await client.request(req).timeout(
            const Duration(seconds: 20),
            onTimeout: (EventSink<
                    ferry.OperationResponse<GIdentitiesByNameData,
                        GIdentitiesByNameVars>>
                sink) {
              throw TimeoutException('Request timed out');
            },
          ).firstWhere(
            (ferry.OperationResponse<GIdentitiesByNameData,
                        GIdentitiesByNameVars>
                    response) =>
                true,
            orElse: () =>
                throw Exception('Stream completed without emitting a value'),
          );
        } catch (e) {
          // Handle deserialization errors and other stream errors
          if (e.toString().contains('Deserializing') ||
              e.toString().contains('Unknown type')) {
            NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
                cause:
                    'Deserialization error searching by name: ${e.toString().substring(0, 100)}');
            loggerDev(
                'Node ${node.url} returned data that could not be deserialized');
            continue; // Try next node
          }
          rethrow; // Re-throw other errors
        }

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

        ferry.OperationResponse<GIdentitiesByNameOrPkData,
            GIdentitiesByNameOrPkVars>? response;

        try {
          response = await client.request(req).timeout(
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
        } catch (e) {
          // Handle deserialization errors and other stream errors
          if (e.toString().contains('Deserializing') ||
              e.toString().contains('Unknown type')) {
            NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
                cause:
                    'Deserialization error searching by name or pk: ${e.toString().substring(0, 100)}');
            loggerDev(
                'Node ${node.url} returned data that could not be deserialized');
            continue; // Try next node
          }
          rethrow; // Re-throw other errors
        }

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
                loggerDev('ERROR: AccountId is null');
              } else {
                contacts.add(_contactFromIdentityBasic(identity));
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

      ferry.OperationResponse<GIdentitiesByPkData, GIdentitiesByPkVars>?
          response;

      try {
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
      } catch (e) {
        // Handle deserialization errors and other stream errors
        if (e.toString().contains('Deserializing') ||
            e.toString().contains('Unknown type')) {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause:
                  'Deserialization error getting identities: ${e.toString().substring(0, 100)}');
          loggerDev(
              'Node ${node.url} returned data that could not be deserialized');
          continue; // Try next node
        }
        rethrow; // Re-throw other errors
      }

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
              loggerDev('ERROR: AccountId is null');
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

// Extract received certificates from GIdentitiesByPkData
List<Cert> _extractCertsReceived(
    GIdentitiesByPkData_identities_nodes identity) {
  final BuiltList<GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes>
      certs = identity.certsByReceiverId.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map(
          (GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes cert) =>
              _buildCertFromIdentityQueryReceived(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Extract issued certificates from GIdentitiesByPkData
List<Cert> _extractCertsIssued(GIdentitiesByPkData_identities_nodes identity) {
  final BuiltList<GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes>
      certs = identity.certsByIssuerId.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map((GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes cert) =>
          _buildCertFromIdentityQueryIssued(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Build Contact from GIdentitiesByPkData_identities_nodes (with certs)
Contact _contactFromIdentity(GIdentitiesByPkData_identities_nodes identity) {
  return Contact.withAddress(
    nick: identity.name,
    address: identity.accountId!,
    certsReceived: _extractCertsReceived(identity),
    certsIssued: _extractCertsIssued(identity),
    status: parseIdentityStatus(identity.status),
    isMember: identity.isMember,
    index: identity.index,
    createdOn: identity.account?.createdOn,
    expireOn: identity.expireOn,
  );
}

// Build Contact from GIdentityBasicFields (without certs)
Contact _contactFromIdentityBasic(GIdentityBasicFields identity) {
  return Contact.withAddress(
    nick: identity.name,
    address: identity.accountId!,
    status: parseIdentityStatus(identity.status),
    isMember: identity.isMember,
    index: identity.index,
    createdOn: identity.account?.createdOn,
    expireOn: identity.expireOn,
  );
}

// Build Cert from certsByReceiverId
Cert? _buildCertFromIdentityQueryReceived(
    GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes cert) {
  final GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_issuer?
      issuer = cert.issuer;
  final GIdentitiesByPkData_identities_nodes_certsByReceiverId_nodes_receiver?
      receiver = cert.receiver;

  // Skip if issuer or receiver accountId is null (removed accounts)
  if (issuer?.accountId == null || receiver?.accountId == null) {
    return null;
  }

  return Cert(
    id: cert.id,
    issuerId: Contact.withAddress(
        name: issuer?.name,
        createdOn: issuer?.account?.createdOn,
        address: issuer!.accountId!,
        status: parseIdentityStatus(issuer.status),
        isMember: issuer.isMember,
        expireOn: issuer.expireOn,
        index: issuer.index),
    receiverId: Contact.withAddress(
        name: receiver?.name,
        createdOn: receiver?.account?.createdOn,
        address: receiver!.accountId!,
        status: parseIdentityStatus(receiver.status),
        isMember: receiver.isMember,
        expireOn: receiver.expireOn,
        index: receiver.index),
    createdOn: cert.createdOn,
    expireOn: cert.expireOn,
    isActive: cert.isActive,
    updatedOn: cert.updatedOn,
  );
}

// Build Cert from certsByIssuerId
Cert? _buildCertFromIdentityQueryIssued(
    GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes cert) {
  final GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_issuer?
      issuer = cert.issuer;
  final GIdentitiesByPkData_identities_nodes_certsByIssuerId_nodes_receiver?
      receiver = cert.receiver;

  // Skip if issuer or receiver accountId is null (removed accounts)
  if (issuer?.accountId == null || receiver?.accountId == null) {
    return null;
  }

  return Cert(
    id: cert.id,
    issuerId: Contact.withAddress(
        name: issuer?.name,
        createdOn: issuer?.account?.createdOn,
        address: issuer!.accountId!,
        status: parseIdentityStatus(issuer.status),
        isMember: issuer.isMember,
        expireOn: issuer.expireOn,
        index: issuer.index),
    receiverId: Contact.withAddress(
        name: receiver?.name,
        createdOn: receiver?.account?.createdOn,
        address: receiver!.accountId!,
        status: parseIdentityStatus(receiver.status),
        isMember: receiver.isMember,
        expireOn: receiver.expireOn,
        index: receiver.index),
    createdOn: cert.createdOn,
    expireOn: cert.expireOn,
    isActive: cert.isActive,
    updatedOn: cert.updatedOn,
  );
}

Future<Contact?> getIdentity({required String address}) async {
  final List<Contact> contacts =
      await getIdentities(addresses: <String>[address]);
  return contacts.isNotEmpty ? contacts.first : null;
}

// Extract received certs from Account query
List<Cert> _extractCertsReceivedFromAccount(
    GAccountsByPkData_accounts_nodes_linkedIdentity identity) {
  final BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes>
      certs = identity.certsByReceiverId.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map(
          (GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
                  cert) =>
              _buildCertFromAccountQueryReceived(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Extract issued certs from Account query
List<Cert> _extractCertsIssuedFromAccount(
    GAccountsByPkData_accounts_nodes_linkedIdentity identity) {
  final BuiltList<
          GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes>
      certs = identity.certsByIssuerId.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map(
          (GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
                  cert) =>
              _buildCertFromAccountQueryIssued(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Build Cert from Account query certsByReceiverId
Cert? _buildCertFromAccountQueryReceived(
    GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes
        cert) {
  final GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_issuer?
      issuer = cert.issuer;
  final GAccountsByPkData_accounts_nodes_linkedIdentity_certsByReceiverId_nodes_receiver?
      receiver = cert.receiver;

  // Skip if issuer or receiver is null (removed accounts)
  if (issuer?.accountId == null || receiver?.accountId == null) {
    return null;
  }

  return Cert(
    id: cert.id,
    issuerId: Contact.withAddress(
        name: issuer?.name,
        createdOn: issuer?.account?.createdOn,
        address: issuer!.accountId!,
        status: parseIdentityStatus(issuer.status),
        isMember: issuer.isMember,
        expireOn: issuer.expireOn,
        index: issuer.index),
    receiverId: Contact.withAddress(
        name: receiver?.name,
        createdOn: receiver?.account?.createdOn,
        address: receiver!.accountId!,
        status: parseIdentityStatus(receiver.status),
        isMember: receiver.isMember,
        expireOn: receiver.expireOn,
        index: receiver.index),
    createdOn: cert.createdOn,
    expireOn: cert.expireOn,
    isActive: cert.isActive,
    updatedOn: cert.updatedOn,
  );
}

// Build Cert from Account query certsByIssuerId
Cert? _buildCertFromAccountQueryIssued(
    GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes
        cert) {
  final GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_issuer?
      issuer = cert.issuer;
  final GAccountsByPkData_accounts_nodes_linkedIdentity_certsByIssuerId_nodes_receiver?
      receiver = cert.receiver;

  // Skip if issuer or receiver is null (removed accounts)
  if (issuer?.accountId == null || receiver?.accountId == null) {
    return null;
  }

  return Cert(
    id: cert.id,
    issuerId: Contact.withAddress(
        name: issuer?.name,
        createdOn: issuer?.account?.createdOn,
        address: issuer!.accountId!,
        status: parseIdentityStatus(issuer.status),
        isMember: issuer.isMember,
        expireOn: issuer.expireOn,
        index: issuer.index),
    receiverId: Contact.withAddress(
        name: receiver?.name,
        createdOn: receiver?.account?.createdOn,
        address: receiver!.accountId!,
        status: parseIdentityStatus(receiver.status),
        isMember: receiver.isMember,
        expireOn: receiver.expireOn,
        index: receiver.index),
    createdOn: cert.createdOn,
    expireOn: cert.expireOn,
    isActive: cert.isActive,
    updatedOn: cert.updatedOn,
  );
}

// Build Contact from GAccountsByPkData_accounts_nodes (with certs)
Contact _contactFromAccount(GAccountsByPkData_accounts_nodes account) {
  final GAccountsByPkData_accounts_nodes_linkedIdentity? identity =
      account.linkedIdentity;

  if (identity == null) {
    return Contact.withAddress(
      address: account.id,
      createdOn: account.createdOn,
    );
  }

  return Contact.withAddress(
    nick: identity.name,
    address: account.id,
    status: parseIdentityStatus(identity.status),
    isMember: identity.isMember,
    createdOn: account.createdOn,
    expireOn: identity.expireOn,
    index: identity.index,
    certsIssued: _extractCertsIssuedFromAccount(identity),
    certsReceived: _extractCertsReceivedFromAccount(identity),
  );
}

// Build Contact from GAccountsBasicByPkData_accounts_nodes (without certs)
Contact _contactFromAccountBasic(
    GAccountsBasicByPkData_accounts_nodes account) {
  final GAccountsBasicByPkData_accounts_nodes_linkedIdentity? identity =
      account.linkedIdentity;

  if (identity == null) {
    return Contact.withAddress(
      address: account.id,
      createdOn: account.createdOn,
    );
  }

  return Contact.withAddress(
    nick: identity.name,
    address: account.id,
    status: parseIdentityStatus(identity.status),
    isMember: identity.isMember,
    createdOn: account.createdOn,
    expireOn: identity.expireOn,
    index: identity.index,
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

      ferry.OperationResponse<GAccountsByPkData, GAccountsByPkVars>? response;

      try {
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
      } catch (e) {
        // Handle deserialization errors and other stream errors
        if (e.toString().contains('Deserializing') ||
            e.toString().contains('Unknown type')) {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause:
                  'Deserialization error fetching accounts: ${e.toString().substring(0, 100)}');
          loggerDev(
              'Node ${node.url} returned data that could not be deserialized');
          continue; // Try next node
        }
        rethrow; // Re-throw other errors
      }

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
          for (final GAccountsByPkData_accounts_nodes account
              in accountsData.accounts!.nodes) {
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
      } else if (response.linkException!.originalException
          .toString()
          .contains('Deserializing')) {
        error =
            'DeserializationError: The server response could not be deserialized. This node may have incompatible data.';
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

      ferry.OperationResponse<GAccountsBasicByPkData, GAccountsBasicByPkVars>?
          response;

      try {
        response = await client.request(req).timeout(
          const Duration(seconds: 20),
          onTimeout: (EventSink<
                  ferry.OperationResponse<GAccountsBasicByPkData,
                      GAccountsBasicByPkVars>>
              sink) {
            throw TimeoutException('Request timed out');
          },
        ).firstWhere(
          (ferry.OperationResponse<GAccountsBasicByPkData,
                      GAccountsBasicByPkVars>
                  response) =>
              true,
          orElse: () =>
              throw Exception('Stream completed without emitting a value'),
        );
      } catch (e) {
        // Handle deserialization errors and other stream errors
        if (e.toString().contains('Deserializing') ||
            e.toString().contains('Unknown type')) {
          NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
              cause:
                  'Deserialization error getting basic accounts: ${e.toString().substring(0, 100)}');
          loggerDev(
              'Node ${node.url} returned data that could not be deserialized');
          continue; // Try next node
        }
        rethrow; // Re-throw other errors
      }

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
          for (final GAccountsBasicByPkData_accounts_nodes account
              in accountsData.accounts!.nodes) {
            final Contact contact = _contactFromAccountBasic(account);
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
