import 'dart:convert';

import 'package:http/http.dart' as http;

import '../g1/nostr/nostr_relay_service.dart';
import '../ui/logger.dart';
import 'astroport_station_service.dart';

/// Represents an Open Collective transaction (contribution or expense)
class OCTransaction {

  OCTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.currency,
    required this.createdAt,
    required this.status,
    this.fromAccountSlug,
    this.toAccountSlug,
    this.expenseId,
  });

  factory OCTransaction.fromJson(Map<String, dynamic> json) {
    return OCTransaction(
      id: json['id'] as String,
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'EUR',
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'PENDING',
      fromAccountSlug: json['fromAccount']?['slug'] as String?,
      toAccountSlug: json['toAccount']?['slug'] as String?,
      expenseId: json['expense']?['id'] as String?,
    );
  }
  final String id;
  final String description;
  final double amount;
  final String currency;
  final DateTime createdAt;
  final String status;
  final String? fromAccountSlug;
  final String? toAccountSlug;
  final String? expenseId;
}

/// Represents an Open Collective member (collective or individual)
class OCMember { // 'COLLECTIVE', 'INDIVIDUAL', 'ORGANIZATION'

  OCMember({
    required this.slug,
    required this.name,
    this.imageUrl,
    this.email,
    required this.type,
  });

  factory OCMember.fromJson(Map<String, dynamic> json) {
    return OCMember(
      slug: json['slug'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String? ?? 'INDIVIDUAL',
    );
  }
  final String slug;
  final String name;
  final String? imageUrl;
  final String? email;
  final String type;
}

/// Service to interact with Open Collective GraphQL API
class OpenCollectiveService {

  OpenCollectiveService({
    required this.apiUrl,
    required this.apiKey,
    required this.collectiveSlug,
  });

  /// Create an instance with empty configuration (for testing).
  /// In production, configuration should be fetched from NOSTR kind 30850.
  factory OpenCollectiveService.empty() {
    return OpenCollectiveService(
      apiUrl: '',
      apiKey: '',
      collectiveSlug: '',
    );
  }
  final String apiUrl;
  final String apiKey;
  final String collectiveSlug;

  /// Fetch Open Collective contribution URLs from the station's NOSTR kind 30800
  /// cooperative-config event.
  ///
  /// Flow:
  ///   1. Fetch /UPLANET/G1HEX from the station (secp256k1 hex of the key that
  ///      published kind 30800 d="cooperative-config").
  ///   2. Query the relay for that event.
  ///   3. Parse OC_URL_* fields from the cleartext JSON content.
  ///
  /// Returns an empty map on any error (network, relay, missing fields).
  static Future<Map<String, String>> fetchOcUrls(
      NostrRelayService relayService) async {
    try {
      final String? g1Hex =
          await AstroportStationService().fetchUplanetG1Hex();
      if (g1Hex == null || g1Hex.isEmpty) {
        logger('[OpenCollectiveService] UPLANET/G1HEX not available');
        return <String, String>{};
      }

      final List<Map<String, dynamic>> events =
          await relayService.queryEvents(
        kinds: <int>[30800],
        authors: <String>[g1Hex],
        tags: <List<String>>[
          <String>['d', 'cooperative-config'],
        ],
        limit: 1,
      );

      if (events.isEmpty) {
        logger('[OpenCollectiveService] No kind 30800 cooperative-config found');
        return <String, String>{};
      }

      final Map<String, dynamic> content =
          jsonDecode(events.first['content'] as String) as Map<String, dynamic>;

      final Map<String, String> urls = <String, String>{};
      for (final String key in <String>[
        'OC_URL_CLOUD',
        'OC_URL_MEMBRE',
        'OC_URL_SATELLITE',
        'OC_URL_CONSTELLATION',
      ]) {
        final String? val = content[key] as String?;
        if (val != null && val.isNotEmpty) {
          // Map server-side key to the canonical lowercase key used in SharedPrefs
          urls[key.replaceFirst('OC_URL_', '').toLowerCase()] = val;
        }
      }
      return urls;
    } catch (e) {
      logger('[OpenCollectiveService] fetchOcUrls error: $e');
      return <String, String>{};
    }
  }

  /// Create an instance by fetching configuration from the station's kind 30800
  /// cooperative-config NOSTR event.
  static Future<OpenCollectiveService> fromNostr(NostrRelayService relayService) async {
    // OC URLs live in kind 30800 d="cooperative-config" published by the
    // station's G1.nostr key (keygen UPLANETNAME.G1 / UPLANETNAME.G1).
    // The full OC service config (apiKey, collectiveSlug) would require
    // decryption with UPLANETNAME — not available client-side.
    return OpenCollectiveService.empty();
  }

  bool get isConfigured => apiUrl.isNotEmpty && apiKey.isNotEmpty && collectiveSlug.isNotEmpty;

  Future<List<OCTransaction>> fetchTransactions({
    int limit = 50,
    String? offset,
  }) async {
    const String query = r'''
      query Transactions($collectiveSlug: String!, $limit: Int, $offset: Int) {
        collective(slug: $collectiveSlug) {
          transactions(limit: $limit, offset: $offset) {
            totalCount
            nodes {
              id
              description
              amount {
                value
                currency
              }
              createdAt
              type
              fromAccount {
                slug
                name
              }
              toAccount {
                slug
                name
              }
              expense {
                id
                status
              }
            }
          }
        }
      }
    ''';

    final Map<String, dynamic> variables = <String, dynamic>{
      'collectiveSlug': collectiveSlug,
      'limit': limit,
      'offset': offset != null ? int.tryParse(offset) : null,
    };

    final Map<String, dynamic>? data = await _graphqlRequest(query, variables);
    if (data == null) return <OCTransaction>[];

    final List<dynamic> nodes = data['collective']?['transactions']?['nodes'] as List<dynamic>? ?? <dynamic>[];
    return nodes.map((node) {
      final Map<String, dynamic> amount = node['amount'] as Map<String, dynamic>? ?? <String, dynamic>{};
      return OCTransaction(
        id: node['id'] as String,
        description: node['description'] as String? ?? '',
        amount: (amount['value'] as num).toDouble(),
        currency: amount['currency'] as String? ?? 'EUR',
        createdAt: DateTime.parse(node['createdAt'] as String),
        status: node['type'] as String? ?? 'UNKNOWN',
        fromAccountSlug: node['fromAccount']?['slug'] as String?,
        toAccountSlug: node['toAccount']?['slug'] as String?,
        expenseId: node['expense']?['id'] as String?,
      );
    }).toList();
  }

  Future<OCMember?> getMemberBySlug(String slug) async {
    const String query = r'''
      query Member($slug: String!) {
        account(slug: $slug) {
          slug
          name
          imageUrl
          email
          type
        }
      }
    ''';

    final Map<String, dynamic> variables = <String, dynamic>{'slug': slug};
    final Map<String, dynamic>? data = await _graphqlRequest(query, variables);
    if (data == null || data['account'] == null) return null;

    return OCMember.fromJson(data['account'] as Map<String, dynamic>);
  }

  Future<bool> emitZen(String email, double amount, String tier) async {
    // This would call UPassport API to emit ZEN tokens
    // For now, just log and return success
    logger('[OpenCollectiveService] Emitting $amount ẐEN to $email for tier $tier');
    return true;
  }

  Future<String?> submitExpense(Map<String, dynamic> expenseData) async {
    // Submit an expense to Open Collective
    // Requires authentication with API key
    const String mutation = r'''
      mutation CreateExpense($expense: ExpenseCreateInput!) {
        createExpense(expense: $expense) {
          id
          status
        }
      }
    ''';

    final Map<String, dynamic> variables = <String, dynamic>{'expense': expenseData};
    final Map<String, dynamic>? data = await _graphqlRequest(mutation, variables);
    return data?['createExpense']?['id'] as String?;
  }

  Future<Map<String, dynamic>?> getExpenseStatus(String expenseId) async {
    const String query = r'''
      query Expense($id: String!) {
        expense(id: $id) {
          id
          status
          amount
          currency
          description
          createdAt
          updatedAt
        }
      }
    ''';

    final Map<String, dynamic> variables = <String, dynamic>{'id': expenseId};
    return _graphqlRequest(query, variables);
  }

  Future<Map<String, dynamic>?> _graphqlRequest(String query, Map<String, dynamic> variables) async {
    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final Map<String, dynamic> body = <String, dynamic>{
      'query': query,
      'variables': variables,
    };

    try {
      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body) as Map<String, dynamic>;
        if (result.containsKey('errors')) {
          final List<dynamic> errors = result['errors'] as List<dynamic>;
          logger('[OpenCollectiveService] GraphQL errors: $errors');
          return null;
        }
        return result['data'] as Map<String, dynamic>?;
      } else {
        logger('[OpenCollectiveService] HTTP error ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e) {
      logger('[OpenCollectiveService] Request failed: $e');
      return null;
    }
  }
}
