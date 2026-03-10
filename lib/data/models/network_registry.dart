import 'package:flutter/foundation.dart' show kIsWeb;

import '../../env.dart';
import 'network_config.dart';

/// Registry centralizado de configuración de red
///
/// Obtiene la configuración de la red actual desde las variables de entorno (.env)
/// y proporciona métodos para acceder a ella de forma segura.
///
/// Ejemplo:
/// ```dart
/// final config = NetworkRegistry.getConfig();
/// print(config.displayName); // "Ğ1 (Producción)"
/// print(config.genesisHash); // "0xfeb770bb..."
/// ```
class NetworkRegistry {
  // Singleton
  static final NetworkRegistry _instance = NetworkRegistry._internal();

  factory NetworkRegistry() => _instance;

  NetworkRegistry._internal();

  // Configuración actual (cacheada después del primer acceso)
  static NetworkConfig? _currentConfig;

  /// Obtiene la configuración de red actual (desde .env)
  ///
  /// Detecta automáticamente la red basándose en:
  /// - CURRENCY del .env
  /// - GENESIS_HASH del .env
  static NetworkConfig getConfig() {
    _currentConfig ??= NetworkConfig.fromEnv(
      currency: Env.currency,
      genesisHash: Env.genesisHash,
    );
    return _currentConfig!;
  }

  /// Resetea la configuración en caché (útil para testing o cambio dinámico)
  static void reset() {
    _currentConfig = null;
  }

  /// Verifica si debe intentarse fetch remoto de nodos en la plataforma actual
  ///
  /// Retorna true en web (usando WebSocket via polkadart Provider.send())
  /// Retorna true en mobile/desktop si la red tiene remoteNodesUrl configurado
  static bool shouldFetchRemote() {
    final NetworkConfig config = getConfig();
    return config.remoteNodesUrl != null;
  }

  /// Obtiene URL para fetch remoto de nodos (si disponible para esta plataforma)
  ///
  /// Retorna null si la red no tiene URL remota configurada
  static String? getRemoteNodesUrl() {
    if (!shouldFetchRemote()) {
      return null;
    }
    return getConfig().remoteNodesUrl;
  }

  /// Verifica si la red actual es producción (G1)
  static bool isProduction() => getConfig().isProduction;

  /// Verifica si la red actual es de pruebas (gtest)
  static bool isTestNetwork() => !isProduction();

  /// Obtiene el genesis hash de la red actual
  static String getGenesisHash() => getConfig().genesisHash;

  /// Obtiene el nombre de la red actual
  static String getNetworkName() => getConfig().displayName;

  /// Obtiene el identificador de la red actual
  static NetworkId getNetworkId() => getConfig().id;
}
