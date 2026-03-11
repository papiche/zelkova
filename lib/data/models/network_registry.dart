import '../../env.dart';
import 'network_config.dart';

class NetworkRegistry {
  factory NetworkRegistry() => _instance;

  NetworkRegistry._internal();

  // Singleton
  static final NetworkRegistry _instance = NetworkRegistry._internal();

  static NetworkConfig? _currentConfig;

  static NetworkConfig getConfig() {
    _currentConfig ??= NetworkConfig.fromEnv(
      currency: Env.currency,
      genesisHash: Env.genesisHash,
    );
    return _currentConfig!;
  }

  static void reset() {
    _currentConfig = null;
  }

  static bool shouldFetchRemote() {
    final NetworkConfig config = getConfig();
    return config.remoteNodesUrl != null;
  }

  static String? getRemoteNodesUrl() {
    if (!shouldFetchRemote()) {
      return null;
    }
    return getConfig().remoteNodesUrl;
  }

  static bool isProduction() => getConfig().isProduction;

  static bool isTestNetwork() => !isProduction();

  static String getGenesisHash() => getConfig().genesisHash;

  static String getNetworkName() => getConfig().displayName;

  static NetworkId getNetworkId() => getConfig().id;
}
