import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart' show BuiltList;
import 'package:duniter_indexer/duniter_indexer_client.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.data.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.req.gql.dart';
import 'package:duniter_indexer/graphql/schema/__generated__/duniter-indexer-queries.var.gql.dart';
import 'package:ferry/ferry.dart' as ferry;
import 'package:ferry/ferry.dart' show FetchPolicy;
import 'package:http/http.dart';
import 'package:tuple/tuple.dart' as tp;

import '../data/models/cert.dart';
import '../data/models/contact.dart';
import '../data/models/identity_status.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../ui/contacts_cache.dart';
import '../ui/logger.dart';
import '../ui/ui_helpers.dart';
import 'api.dart';
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
          ? addressFromV1Pubkey(extractPublicKey(searchPatternRaw))
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
  final BuiltList<GIdentitiesByPkData_identities_nodes_certReceived_nodes>
      certs = identity.certReceived.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map((GIdentitiesByPkData_identities_nodes_certReceived_nodes cert) =>
          _buildCertFromIdentityQueryReceived(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Extract issued certificates from GIdentitiesByPkData
List<Cert> _extractCertsIssued(GIdentitiesByPkData_identities_nodes identity) {
  final BuiltList<GIdentitiesByPkData_identities_nodes_certIssued_nodes> certs =
      identity.certIssued.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map((GIdentitiesByPkData_identities_nodes_certIssued_nodes cert) =>
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

// Build Cert from certReceived
Cert? _buildCertFromIdentityQueryReceived(
    GIdentitiesByPkData_identities_nodes_certReceived_nodes cert) {
  final GIdentitiesByPkData_identities_nodes_certReceived_nodes_issuer? issuer =
      cert.issuer;
  final GIdentitiesByPkData_identities_nodes_certReceived_nodes_receiver?
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

// Build Cert from certIssued
Cert? _buildCertFromIdentityQueryIssued(
    GIdentitiesByPkData_identities_nodes_certIssued_nodes cert) {
  final GIdentitiesByPkData_identities_nodes_certIssued_nodes_issuer? issuer =
      cert.issuer;
  final GIdentitiesByPkData_identities_nodes_certIssued_nodes_receiver?
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
    GAccountsByPkData_accounts_nodes_identity identity) {
  final BuiltList<GAccountsByPkData_accounts_nodes_identity_certReceived_nodes>
      certs = identity.certReceived.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map(
          (GAccountsByPkData_accounts_nodes_identity_certReceived_nodes cert) =>
              _buildCertFromAccountQueryReceived(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Extract issued certs from Account query
List<Cert> _extractCertsIssuedFromAccount(
    GAccountsByPkData_accounts_nodes_identity identity) {
  final BuiltList<GAccountsByPkData_accounts_nodes_identity_certIssued_nodes>
      certs = identity.certIssued.nodes;
  if (certs.isEmpty) {
    return <Cert>[];
  }
  return certs
      .map((GAccountsByPkData_accounts_nodes_identity_certIssued_nodes cert) =>
          _buildCertFromAccountQueryIssued(cert))
      .where((Cert? cert) => cert != null)
      .cast<Cert>()
      .toList();
}

// Build Cert from Account query certReceived
Cert? _buildCertFromAccountQueryReceived(
    GAccountsByPkData_accounts_nodes_identity_certReceived_nodes cert) {
  final GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_issuer?
      issuer = cert.issuer;
  final GAccountsByPkData_accounts_nodes_identity_certReceived_nodes_receiver?
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

// Build Cert from Account query certIssued
Cert? _buildCertFromAccountQueryIssued(
    GAccountsByPkData_accounts_nodes_identity_certIssued_nodes cert) {
  final GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_issuer?
      issuer = cert.issuer;
  final GAccountsByPkData_accounts_nodes_identity_certIssued_nodes_receiver?
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
  final GAccountsByPkData_accounts_nodes_identity? identity = account.identity;

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
  final GAccountsBasicByPkData_accounts_nodes_identity? identity =
      account.identity;

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

Future<tp.Tuple2<Map<String, dynamic>?, Node>> getHistoryAndBalanceV2(
    String pubKeyRaw,
    {int? pageSize = 10,
    int? from,
    int? to,
    String? cursor,
    required bool isConnected}) async {
  final String address = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  if (nodes.isEmpty) {
    loggerDev('No suitable indexer nodes available for $pubKeyRaw/$address');
    return const tp.Tuple2<Map<String, dynamic>?, Node>(null, Node(url: ''));
  }

  // With cursor-based pagination, we use the full pageSize
  final int limit = pageSize ?? 10;

  // Split the combined cursor into issued and received cursors
  // Format: "issuedCursor|receivedCursor"
  String? issuedCursor;
  String? receivedCursor;
  if (cursor != null && cursor.contains('|')) {
    final List<String> parts = cursor.split('|');
    issuedCursor = parts[0].isEmpty ? null : parts[0];
    receivedCursor = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
  } else if (cursor != null && cursor.isNotEmpty) {
    // Single cursor value - use for both
    issuedCursor = cursor;
    receivedCursor = cursor;
  }

  for (final Node node in nodes) {
    // Skip nodes that have accumulated too many errors
    if (node.errors >= NodeManager.maxNodeErrors) {
      loggerDev(
          'Skipping node ${node.url} due to high error count: ${node.errors}');
      continue;
    }

    try {
      final ferry.Client client = await initDuniterIndexerClient(node.url);

      loggerDev(
          'Fetching history for $pubKeyRaw/$address in node ${node.url} with cursors: issued=$issuedCursor, received=$receivedCursor');

      // We need to make two separate requests or use a more complex query
      // For now, let's use the same cursor for both and let the API handle it
      final GAccountTransactionsReq request =
          GAccountTransactionsReq((GAccountTransactionsReqBuilder b) {
        b
          ..fetchPolicy =
              isConnected ? FetchPolicy.NetworkOnly : FetchPolicy.CacheFirst
          ..vars.accountId = address
          ..vars.limit = limit;

        // Set cursor only if we have one
        final String? cursorValue = issuedCursor ?? receivedCursor;
        if (cursorValue != null) {
          b.vars.cursor.value = cursorValue;
        }
      });

      final ferry
          .OperationResponse<GAccountTransactionsData, GAccountTransactionsVars>
          response = await client.request(request).first;

      if (response.hasErrors) {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'GraphQL errors in response');
        loggerDev('Node ${node.url} returned errors for $pubKeyRaw/$address');
        processFerryError(response);
        continue; // Try next node
      }

      final Map<String, dynamic>? data = response.data?.toJson();
      if (data != null) {
        loggerDev(
            'Successfully fetched history for $pubKeyRaw/$address from node ${node.url}');
        return tp.Tuple2<Map<String, dynamic>?, Node>(data, node);
      } else {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'Null data in response');
        loggerDev(
            'Node ${node.url} returned null data for $pubKeyRaw/$address');
        continue; // Try next node
      }
    } catch (e, stackTrace) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Error fetching history: $e');
      loggerDev(
          'Error fetching history for $pubKeyRaw/$address in node ${node.url}',
          error: e,
          stackTrace: stackTrace);
      // Continue with next node
      continue;
    }
  }

  // If all nodes failed, return empty result
  loggerDev('All nodes failed to fetch history for $pubKeyRaw/$address');
  return const tp.Tuple2<Map<String, dynamic>?, Node>(null, Node(url: ''));
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

/// Helper: Fetch Cesium+ profile data for an address
Future<Contact?> _fetchCesiumPlusProfile(String pubKey,
    {bool resize = true}) async {
  try {
    final Response cPlusResponse =
        (await requestCPlusWithRetry('/user/profile/$pubKey')).item2;

    if (cPlusResponse.statusCode == 200) {
      final Map<String, dynamic> result = const JsonDecoder()
          .convert(cPlusResponse.body) as Map<String, dynamic>;

      if (result['found'] != false) {
        return await contactFromResultSearch(result, resize: resize);
      }
    }
  } catch (e) {
    loggerDev('Error fetching Cesium+ profile for $pubKey: $e');
  }
  return null;
}

/// Fetch profile V2: combines Cesium+ profile with WOT V2 data from duniter_indexer
/// Uses addressFromV1Pubkey to convert V1 pubkey to V2 address
/// baseContact: optional Contact to use as base (preserves avatar and other existing data)
Future<Contact> getProfileV2(String pubKeyRaw,
    {bool onlyProfile = false,
    bool resize = true,
    bool complete = false,
    Contact? baseContact}) async {
  loggerDev('Fetching profile v2 for pubkey $pubKeyRaw');

  final String address = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  // Extract V1 pubkey for Cesium+ fetch: C+ doesn't know V2 addresses
  String cPlusPubKey = pubKeyRaw;
  if (pubKeyRaw.length != 43 &&
      pubKeyRaw.length != 44 &&
      pubKeyRaw.contains('1') == false) {
    // basic heuristic, or just try to convert if valid address
    try {
      if (isValidV2Address(pubKeyRaw)) {
        cPlusPubKey = v1pubkeyFromAddress(pubKeyRaw);
      }
    } catch (e) {
      // ignore, likely already a pubkey
    }
  }

  // Get Cesium+ profile data, or use baseContact if available
  Contact c = await _fetchCesiumPlusProfile(cPlusPubKey, resize: resize) ??
      (baseContact ?? Contact.withAddress(address: address));

  // Get WOT V2 data if not only profile
  if (!onlyProfile) {
    try {
      final Contact cWot = complete
          ? await getAccount(address: address)
          : await getAccountBasic(address: address);
      c = c.merge(cWot);
    } catch (e) {
      loggerDev('Error fetching WOT v2 data for $address: $e');
      // Continue with what we have
    }
  }

  logger('Contact retrieved in getProfileV2 $c (c+ only $onlyProfile)');
  ContactsCache().addContact(c);
  return c;
}

/// Fetch multiple profiles V2: combines Cesium+ profiles with WOT V2 data
Future<List<Contact>> getProfilesV2({required List<String> pubKeys}) async {
  loggerDev('Fetching profiles v2 for pubkeys $pubKeys');
  final List<Contact> contacts = <Contact>[];

  if (pubKeys.isEmpty) {
    return contacts;
  }

  // Convert V1 pubKeys to V2 addresses
  final List<String> addresses = <String>[];
  for (final String pubKey in pubKeys) {
    try {
      addresses.add(addressFromV1PubkeyFaiSafe(pubKey));
    } catch (e) {
      loggerDev('Error converting pubkey $pubKey to address: $e');
      // Try with original if conversion fails
      if (pubKey.length == 43) {
        addresses.add(pubKey); // Assume it's already an address
      }
    }
  }

  if (addresses.isEmpty) {
    return contacts;
  }

  // Fetch WOT V2 data for all addresses
  try {
    final List<Contact> wotContacts = await getIdentities(addresses: addresses);

    // For each pubkey, try to get Cesium+ profile and merge with WOT data
    for (int i = 0; i < pubKeys.length; i++) {
      final String pubkeyOrAddress = pubKeys[i];
      final String address = addresses[i];

      // Find WOT contact by address
      Contact contact = wotContacts.firstWhere(
        (Contact c) => c.address == address,
        orElse: () => Contact.withAddress(address: address),
      );

      // Extract V1 pubkey for Cesium+ fetch
      String cPlusPubKey = pubkeyOrAddress;
      try {
        if (isValidV2Address(pubkeyOrAddress)) {
          cPlusPubKey = v1pubkeyFromAddress(pubkeyOrAddress);
        }
      } catch (e) {
        // ignore
      }

      // Try to get Cesium+ profile data using V1 pubkey
      final Contact? cPlusContact = await _fetchCesiumPlusProfile(cPlusPubKey);
      if (cPlusContact != null) {
        contact = contact.merge(cPlusContact);
      }

      contacts.add(contact);
    }
  } catch (e) {
    loggerDev('Error fetching WOT v2 identities: $e');
    // Return empty list if WOT fetch fails
    return contacts;
  }

  loggerDev('Contacts retrieved in getProfilesV2 ${contacts.length}');
  ContactsCache().addContacts(contacts);
  return contacts;
}

/// Get the last owner key change block for an account
/// Returns the block number of the last change, or null if never changed or no identity
Future<int?> getLastOwnerKeyChangeBlock({required String accountId}) async {
  final List<Node> nodes = NodeManager().getBestNodes(NodeType.duniterIndexer);

  for (final Node node in nodes) {
    loggerDev(
        'Fetching last owner key change for account $accountId from ${node.url}');
    try {
      final Response response = await post(
        Uri.parse(node.url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'query': r'''
            query GetOwnerKeyChanges($accountId: String!) {
              identities(first: 1, filter: { accountId: { equalTo: $accountId } }) {
                nodes {
                  ownerKeyChange(first: 1, orderBy: [BLOCK_NUMBER_DESC]) {
                    nodes {
                      blockNumber
                    }
                  }
                }
              }
            }
          ''',
          'variables': <String, dynamic>{'accountId': accountId},
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        final Map<String, dynamic>? identities =
            data['data']?['identities'] as Map<String, dynamic>?;
        final List<dynamic>? identityNodes =
            identities?['nodes'] as List<dynamic>?;

        if (identityNodes != null && identityNodes.isNotEmpty) {
          final Map<String, dynamic>? ownerKeyChange =
              identityNodes.first['ownerKeyChange'] as Map<String, dynamic>?;
          final List<dynamic>? changeNodes =
              ownerKeyChange?['nodes'] as List<dynamic>?;

          if (changeNodes != null && changeNodes.isNotEmpty) {
            return changeNodes.first['blockNumber'] as int;
          }
        }
        return null; // No owner key changes found or no identity
      } else {
        NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
            cause: 'HTTP ${response.statusCode} getting owner key change');
        continue;
      }
    } catch (e, st) {
      NodeManager().increaseNodeErrors(NodeType.duniterIndexer, node,
          cause: 'Exception getting owner key change: $e');
      loggerDev('Error fetching owner key change from node ${node.url}',
          error: e, stackTrace: st);
      continue;
    }
  }
  return null;
}
