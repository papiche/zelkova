import 'node.dart';

/// Hardcoded G1 TEST network endpoint nodes (RPC WebSocket)
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsGtestEndpoints = <Node>[
  const Node(url: 'wss://duniter-v2-vjrj-gtest.comunes.net/ws'),
];

/// Hardcoded G1 TEST network Duniter indexer (GraphQL) nodes
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsGtestDuniterIndexer = <Node>[
  const Node(url: 'https://g1-test-squid.comunes.net/v1/graphql'),
];
