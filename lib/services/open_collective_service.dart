import 'dart:convert';

import 'package:http/http.dart' as http;

import '../g1/nostr/nostr_relay_service.dart';
import '../ui/logger.dart';

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

  /// Create an instance by fetching configuration from NOSTR economic health events.
  /// Requires NostrRelayService to be connected and a valid UPLANETNAME_G1 event.
  static Future<OpenCollectiveService> fromNostr(NostrRelayService relayService) async {
    // TODO: Query kind 30850 events with tag "config:open_collective" or similar.
    // For now, return empty.
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