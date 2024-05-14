// lib/g1/astroid_helper.dart
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';
import '../g1/g1_helper.dart';

Future<Tuple2<String, String>?> decryptAstroID(
    String disco, String password) async {
  try {
    // Décoder la valeur DISCO de l'URI
    final String decoded = Uri.decodeComponent(disco);

    // Remplacer les caractères d'échappement pour retrouver le contenu chiffré
    final String transformed =
        decoded.replaceAll('~', '-').replaceAll('-', '\n').replaceAll('_', '+');

    // Déchiffrer le contenu avec le package encrypt en utilisant le mot de passe
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(password.padRight(32))));
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final String decrypted = encrypter.decrypt64(transformed, iv: iv);

    // Parser l'URL obtenue pour extraire les secrets USALT et UPEPPER
    final Uri url = Uri.parse(decrypted);
    final String usalt = url.queryParameters['s']!;
    final String upepper = url.queryParameters['p']!;

    // Décoder USALT et UPEPPER de l'URI pour obtenir SECRET1 et SECRET2
    final String secret1 = Uri.decodeComponent(usalt);
    final String secret2 = Uri.decodeComponent(upepper);

    return Tuple2(secret1, secret2);
  } catch (e) {
    return null;
  }
}
