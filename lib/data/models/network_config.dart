/// Identificadores de redes Duniter soportadas
enum NetworkId {
  g1, // Red de producción Ğ1
  g1Test, // Red de pruebas gtest
}

/// Configuración de una red Duniter
///
/// Define cómo se comporta la aplicación para una red específica:
/// - Nodos a conectar
/// - Genesis hash para validación
/// - URLs remotas para fetch de nodos
/// - Comportamiento en diferentes plataformas (web, mobile, desktop)
class NetworkConfig {
  final NetworkId id;
  final String displayName; // "Ğ1 (Producción)" o "Ğ1-Test (gtest)"
  final String currency; // 'g1', 'g1-test', etc.
  final String genesisHash; // Hash único de la red (ej: 0xfeb770bb...)
  final bool fetchRemoteInWeb; // Si intentar fetch en web (CORS)
  final String? remoteNodesUrl; // URL JSON con lista de nodos (opcional)

  // Para futuro selector UI
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

  /// Crea configuración desde variables de entorno (.env)
  ///
  /// Detecta automáticamente la red basándose en la variable CURRENCY del .env
  factory NetworkConfig.fromEnv({
    required String currency,
    required String genesisHash,
  }) {
    // Detectar red basándose en currency
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
        description: 'Red de pruebas para desarrollo',
        isProduction: false,
      );
    }

    // Default: G1 producción
    return NetworkConfig(
      id: NetworkId.g1,
      displayName: 'Ğ1 (Producción)',
      currency: currency,
      genesisHash: genesisHash,
      remoteNodesUrl:
          'https://git.duniter.org/nodes/networks/-/raw/master/g1.json',
      fetchRemoteInWeb: false,
      description: 'Red de producción de la moneda libre Ğ1',
      isProduction: true,
    );
  }

  @override
  String toString() => 'NetworkConfig($displayName, currency=$currency)';
}
