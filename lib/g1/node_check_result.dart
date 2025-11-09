class NodeCheckResult {
  NodeCheckResult(
      {required this.latency, required this.currentBlock, this.version = ''});

  final Duration latency;
  final int currentBlock;
  final String version;
}
