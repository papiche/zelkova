enum NodeType {
  duniter,
  cesiumPlus,
  gva,
  endpoint,
  duniterIndexer,
  datapodEndpoint,
  ipfsGateway
}

// Extension to know if node is v2 type
extension NodeTypeExtension on NodeType {
  bool get isV2 {
    switch (this) {
      case NodeType.duniter:
      case NodeType.cesiumPlus:
      case NodeType.gva:
        return false;
      case NodeType.endpoint:
      case NodeType.duniterIndexer:
      case NodeType.datapodEndpoint:
      case NodeType.ipfsGateway:
        return true;
    }
  }
}
