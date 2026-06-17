enum NodeType {
  endpoint,
  duniterIndexer,
  datapodEndpoint,
  ipfsGateway
}

// Extension to know if node is v2 type
extension NodeTypeExtension on NodeType {
  bool get isV2 {
    switch (this) {
      case NodeType.datapodEndpoint:
      case NodeType.ipfsGateway:
        return false;
      case NodeType.endpoint:
      case NodeType.duniterIndexer:
        return true;
    }
  }
}
