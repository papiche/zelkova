/// Identifiers for supported Duniter networks
enum NetworkId {
  g1, // G1 production network
  g1Test, // G1 test network (gtest)
}

/// Duniter network configuration
///
/// Defines how the application behaves for a specific network:
/// - Nodes to connect to
/// - Genesis hash for validation
/// - Remote URLs for node fetching
/// - Behavior on different platforms (web, mobile, desktop)
class NetworkConfig {
  final NetworkId id;
  final String displayName; // "Ğ1 (Production)" or "Ğ1-Test (gtest)"
  final String currency; // 'g1', 'g1-test', etc.
  final String genesisHash; // Unique network hash (e.g.: 0xfeb770bb...)
  final bool fetchRemoteInWeb; // Whether to attempt fetch on web (CORS)
  final String? remoteNodesUrl; // JSON URL with node list (optional)

  // For future UI selector
  final String description;
  final bool isProduction;

  const NetworkConfig({
    required this.id,
    required this.displayName,
    required this.currency,
    required this.genesisHash,
    this.fetchRemoteInWeb = false,
    this.remoteNodesUrl,
    this.description = '',
    this.isProduction = false,
  });

  /// Creates configuration from environment variables (.env)
  ///
  /// Automatically detects the network based on the CURRENCY variable from .env
  factory NetworkConfig.fromEnv({
    required String currency,
    required String genesisHash,
  }) {
    // Detect network based on currency
    final String currencyLower = currency.toLowerCase();

    if (currencyLower == 'g1-test' || currencyLower == 'gtest') {
      return NetworkConfig(
        id: NetworkId.g1Test,
        displayName: 'Ğ1-Test (gtest)',
        currency: currency,
        genesisHash: genesisHash,
        remoteNodesUrl:
            'https://git.duniter.org/nodes/networks/-/raw/master/gtest.json',
        fetchRemoteInWeb: false,
        description: 'Test network for development',
        isProduction: false,
      );
    }

    // Default: G1 production
    return NetworkConfig(
      id: NetworkId.g1,
      displayName: 'Ğ1 (Production)',
      currency: currency,
      genesisHash: genesisHash,
      remoteNodesUrl:
          'https://git.duniter.org/nodes/networks/-/raw/master/g1.json',
      fetchRemoteInWeb: false,
      description: 'G1 free currency production network',
      isProduction: true,
    );
  }

  @override
  String toString() => 'NetworkConfig($displayName, currency=$currency)';
}
