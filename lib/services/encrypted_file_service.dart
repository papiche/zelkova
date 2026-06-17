import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';

import '../env.dart';
import '../ui/logger.dart';

/// Format de fichier chiffré UENC v1
/// Layout : MAGIC(4) + VERSION(1) + ENC_TYPE(1) + IV(12) + CIPHERTEXT+TAG(n+16)
class UencFormat {
  static const _magic = [0x55, 0x45, 0x4E, 0x43]; // "UENC"
  static const _version = 0x01;
  static const _typeAes256Gcm = 0x01;
  static const _headerSize = 18; // 4+1+1+12

  static bool isUenc(Uint8List data) {
    if (data.length < _headerSize + 16) return false;
    return data[0] == 0x55 &&
        data[1] == 0x45 &&
        data[2] == 0x4E &&
        data[3] == 0x43;
  }

  static Uint8List encrypt(Uint8List plaintext, Uint8List key32, Uint8List iv12) {
    if (key32.length != 32) throw ArgumentError('Clef AES-256 requise (32 bytes)');
    if (iv12.length != 12) throw ArgumentError('IV GCM requis (12 bytes)');

    final gcm = GCMBlockCipher(AESEngine())
      ..init(
        true,
        AEADParameters(KeyParameter(key32), 128, iv12, Uint8List(0)),
      );
    final ciphertextWithTag = gcm.process(plaintext);

    final result = Uint8List(_headerSize + ciphertextWithTag.length);
    result.setAll(0, _magic);
    result[4] = _version;
    result[5] = _typeAes256Gcm;
    result.setRange(6, 18, iv12);
    result.setRange(18, result.length, ciphertextWithTag);
    return result;
  }

  static Uint8List decrypt(Uint8List data, Uint8List key32) {
    if (!isUenc(data)) throw FormatException('En-tête UENC invalide');
    if (data[4] != _version) throw FormatException('Version UENC inconnue: ${data[4]}');
    if (data[5] != _typeAes256Gcm) {
      throw FormatException('Type de chiffrement UENC inconnu: ${data[5]}');
    }
    if (key32.length != 32) throw ArgumentError('Clef AES-256 requise (32 bytes)');

    final iv = data.sublist(6, 18);
    final ciphertextWithTag = data.sublist(18);

    final gcm = GCMBlockCipher(AESEngine())
      ..init(
        false,
        AEADParameters(KeyParameter(key32), 128, iv, Uint8List(0)),
      );
    return gcm.process(ciphertextWithTag);
  }
}

/// Résultat d'un upload chiffré
class EncryptedUploadResult {
  const EncryptedUploadResult({
    required this.cid,
    required this.encKeyHex,
    required this.encType,
    required this.ivHex,
    required this.originalFilename,
    this.title,
    this.caption,
  });

  final String cid;
  final String encKeyHex;
  final String encType;
  final String ivHex;
  final String originalFilename;
  final String? title;
  final String? caption;

  EncryptedUploadResult withMeta({String? title, String? caption}) =>
      EncryptedUploadResult(
        cid: cid,
        encKeyHex: encKeyHex,
        encType: encType,
        ivHex: ivHex,
        originalFilename: originalFilename,
        title: title ?? this.title,
        caption: caption ?? this.caption,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cid': cid,
        'enc_key': encKeyHex,
        'enc_type': encType,
        'iv': ivHex,
        'filename': originalFilename,
        if (title != null && title!.isNotEmpty) 'title': title,
        if (caption != null && caption!.isNotEmpty) 'caption': caption,
      };
}

/// Service pour upload et déchiffrement de fichiers UENC via UPassport
class EncryptedFileService {
  static Uint8List generateKey() {
    final rng = Random.secure();
    return Uint8List.fromList(List.generate(32, (_) => rng.nextInt(256)));
  }

  static String toHex(Uint8List bytes) => bytes
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();

  static Uint8List fromHex(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < result.length; i++) {
      result[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return result;
  }

  /// URL de base UPassport (depuis Env)
  static String get _upassportBase => Env.upassportUrl.endsWith('/')
      ? Env.upassportUrl.substring(0, Env.upassportUrl.length - 1)
      : Env.upassportUrl;

  /// Première gateway IPFS disponible
  static String get _ipfsGateway {
    final gws = Env.ipfsGateways.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    return gws.isNotEmpty ? gws.first : 'https://ipfs.io';
  }

  /// Upload un fichier chiffré vers UPassport /api/fileupload/encrypted
  static Future<EncryptedUploadResult> upload({
    required Uint8List fileBytes,
    required String filename,
    String? encKeyHex,
  }) async {
    final key = encKeyHex != null ? fromHex(encKeyHex) : generateKey();
    final keyHex = toHex(key);

    final uri = Uri.parse('$_upassportBase/api/fileupload/encrypted');
    final request = http.MultipartRequest('POST', uri)
      ..fields['encryption_key'] = keyHex
      ..fields['encryption_type'] = 'aes256gcm'
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: filename,
      ));

    http.StreamedResponse response;
    try {
      response = await request.send().timeout(const Duration(seconds: 30));
    } catch (e) {
      throw Exception('Upload chiffré échoué : $e');
    }

    final body = await response.stream.bytesToString();
    if (response.statusCode != 200) {
      loggerDev('encrypted-upload: HTTP ${response.statusCode} $body');
      throw Exception('Upload chiffré échoué (${response.statusCode}): $body');
    }

    final json = jsonDecode(body) as Map<String, dynamic>;
    final cid = json['cid'] as String? ?? '';
    final ivHex = json['iv_hex'] as String? ?? '';
    if (cid.isEmpty) throw Exception('CID manquant dans la réponse du serveur');

    loggerDev('encrypted-upload OK: cid=${cid.substring(0, 12)}… iv=${ivHex.substring(0, 8)}…');
    return EncryptedUploadResult(
      cid: cid,
      encKeyHex: keyHex,
      encType: 'aes256gcm',
      ivHex: ivHex,
      originalFilename: filename,
    );
  }

  /// Télécharge et déchiffre un fichier UENC depuis IPFS
  static Future<Uint8List> downloadAndDecrypt({
    required String cid,
    required String encKeyHex,
    String? ipfsGatewayOverride,
  }) async {
    final gateway = ipfsGatewayOverride ?? _ipfsGateway;
    final url = Uri.parse('$gateway/ipfs/$cid');
    final resp = await http.get(url).timeout(const Duration(seconds: 60));
    if (resp.statusCode != 200) {
      throw Exception('Téléchargement IPFS échoué (${resp.statusCode})');
    }
    final key = fromHex(encKeyHex);
    return UencFormat.decrypt(resp.bodyBytes, key);
  }
}
