class WalletAlreadyExistsException implements Exception {
  WalletAlreadyExistsException(this.pubKey);

  final String pubKey;

  @override
  String toString() => 'WalletAlreadyExistsException: $pubKey';
}
