import 'node.dart';

/// Hardcoded G1 network endpoint nodes (RPC WebSocket)
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsG1Endpoints = <Node>[
  const Node(url: 'wss://g1.p2p.legal/ws'),
  const Node(url: 'wss://g1.asycn.io/ws/'),
  const Node(url: 'wss://g1.axiom-team.fr/ws'),
  const Node(url: 'wss://g1.coinduf.eu'),
  const Node(url: 'wss://g1.gyroi.de'),
  const Node(url: 'wss://archive-rpc.g1.brussels.ovh'),
  const Node(url: 'wss://g1.rendall.fr/ws'),
  const Node(url: 'wss://g1.pini.fr/ws'),
  const Node(url: 'wss://g1v2archive.syoul.fr/'),
];

/// Hardcoded G1 network Duniter indexer (GraphQL) nodes
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsG1DuniterIndexer = <Node>[
  const Node(url: 'https://g1-squid.axiom-team.fr/v1/graphql'),
  const Node(url: 'https://g1-squid.asycn.io/v1/graphql'),
  const Node(url: 'https://squid.g1.coinduf.eu/v1/graphql'),
  const Node(url: 'https://squid.g1.gyroi.de/v1/graphql'),
  const Node(url: 'https://squid.g1.brussels.ovh/v1/graphql'),
  const Node(url: 'https://g1-squid.pini.fr/v1/graphql'),
  const Node(url: 'https://squidv2s.syoul.fr/v1/graphql'),
];
