class StorageKeys {
  static const String seedKey = 'seed';
  static const String pubKey = 'pub';
  static const String cardsKey = 'cesiumCards';
  static const String currentCardIndexKey = 'current_wallet_index';
  static const String securePatternOrPass =
      'secure_storage_pattern_or_pass_key'; // V2
  static const String secureSalt = 'secure_storage_salt'; // V2
  static const String usesPassword = 'storage_uses_password'; // V2

  static const String accountsKey = 'secure_storage_accounts'; // V2
  static const String biometricEnabledKey = 'auth_enable_biometrics'; // V2

  // MULTIPASS / NOSTR
  static const String nostrNsecPrefix = 'nostr_nsec_'; // + pubKey
  static const String multipassDataPrefix = 'multipass_'; // + pubKey
}
