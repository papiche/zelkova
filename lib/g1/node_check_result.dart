class NodeCheckResult {
  NodeCheckResult({
    required this.latency,
    required this.currentBlock,
    this.version = '',
    this.genesisHash,
  });

  final Duration latency;
  final int currentBlock;
  final String version;
  final String? genesisHash;
}
