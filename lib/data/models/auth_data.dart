import 'package:durt/durt.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

class AuthDataV1 {
  AuthDataV1(this.password, this.salt);

  String password;
  String salt;
}

class AuthDataV2 {
  AuthDataV2(this.mnemonic, this.meta);

  String mnemonic;
  String meta;
}

class AuthData {
  AuthData({this.v1, this.v2});

  AuthDataV1? v1;
  AuthDataV2? v2;
}

Future<KeyPair> createPair(AuthData data, Keyring keyring) async {
  if (data.v1 != null) {
    final CesiumWallet wallet = CesiumWallet(data.v1!.salt, data.v1!.password);
    final KeyPair keyPair = KeyPair.ed25519.fromSeed(wallet.seed);
    return keyPair;
  } else if (data.v2 != null) {
    final KeyPair keyPair = await keyring.fromUri(data.v2!.mnemonic,
        password: data.v2!.meta, keyPairType: KeyPairType.sr25519);
    return keyPair;
  } else {
    throw Exception('Data format not recognized');
  }
}
