import 'node.dart';

/// Hardcoded G1 network endpoint nodes (RPC WebSocket)
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsG1Endpoints = <Node>[
  const Node(url: 'wss://rpc.duniter.org'),
  const Node(url: 'wss://g1.coinduf.eu'),
  const Node(url: 'wss://g1.1000i100.fr'),
  const Node(url: 'wss://archive.g1.bulma.sleoconnect.fr/ws'),
  const Node(url: 'wss://ws.g1v2.bulma.sleoconnect.fr/ws'),
  const Node(url: 'wss://duniter-g1-archive-rpc.josephin.brussels.ovh/ws'),
  const Node(url: 'wss://duniter-g1-mirror-rpc.josephin.brussels.ovh/ws'),
  const Node(url: 'wss://g1.pini.fr/ws'),
  const Node(url: 'wss://g1v2archive.syoul.fr/'),
];

/// Hardcoded G1 network Duniter indexer (GraphQL) nodes
/// Used as fallback when remote fetch fails or in offline mode
final List<Node> nodeListsG1DuniterIndexer = <Node>[
  const Node(url: 'https://indexer.duniter.org/v1/graphql'),
  const Node(url: 'https://g1-squid.cgeek.fr/v1/graphql'),
  const Node(url: 'https://squid.g1.bulma.sleoconnect.fr/v1/graphql'),
  const Node(url: 'https://squid.g1.coinduf.eu/v1/graphql'),
  const Node(url: 'https://g1-squid.pini.fr/v1/graphql'),
  const Node(url: 'https://squidv2s.syoul.fr/v1/graphql'),
  const Node(url: 'https://g1.1000i100.fr/v1/graphql'),
];
