// ignore_for_file: unused_local_variable

import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:ed25519_edwards/ed25519_edwards.dart';

void generate() {
// Generar un nuevo par de claves Ed25519
  final KeyPair keyPair = ed.generateKey();

// Obtener la clave pública y privada como cadenas de bytes
  final PublicKey publicKeyBytes = keyPair.publicKey;
  final PrivateKey privateKeyBytes = keyPair.privateKey;

  final String publicKeyHex = publicKeyBytes.bytes
      .map((int b) => b.toRadixString(16).padLeft(2, '0'))
      .join();
  final String privateKeyHex = privateKeyBytes.bytes
      .map((int b) => b.toRadixString(16).padLeft(2, '0'))
      .join();

  /* print("Clave pública: $publicKeyHex");
  print("Clave privada: $privateKeyHex"); */
}
