enum NodeType {
  gva,
  duniter,
  endpoint,
  duniterIndexer,
  cesiumPlus,
  datapodEndpoint,
  ipfsGateway
}

// Extension to know if node is v2 type
extension NodeTypeExtension on NodeType {
  bool get isV1 {
    switch (this) {
      case NodeType.duniter:
      case NodeType.cesiumPlus:
      case NodeType.gva:
        return true;
      case NodeType.endpoint:
      case NodeType.duniterIndexer:
      case NodeType.datapodEndpoint:
      case NodeType.ipfsGateway:
        return false;
    }
  }

  bool get isV2 {
    switch (this) {
      case NodeType.duniter:
      case NodeType.gva:
        return false;
      case NodeType.cesiumPlus:
      case NodeType.endpoint:
      case NodeType.duniterIndexer:
      case NodeType.datapodEndpoint:
      case NodeType.ipfsGateway:
        return true;
    }
  }
}
