import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/logger.dart';

/// Service de partage pair-à-pair de l'APK Ẑelkova via un serveur HTTP local.
///
/// Inspiré de TrocZen/troczen/lib/services/apk_share_service.dart (GPL-3.0).
/// Adapté pour Ẑelkova (one.astroport.zelkova).
///
/// Permet à un utilisateur de partager Ẑelkova directement sur le réseau
/// local sans passer par un store. L'autre utilisateur scanne le QR → télécharge.
///
/// Flow :
///   1. startServer() → lance un serveur HTTP sur :8303
///   2. L'APK est servi depuis l'installation ou les assets
///   3. downloadUrl → QR code à afficher (voir ApkShareScreen)
///   4. stopServer() quand l'écran est fermé
class ApkShareService {
  static const int _defaultPort = 8303;
  static const String _apkFileName = 'zelkova.apk';
  static const MethodChannel _platform =
      MethodChannel('one.astroport.zelkova/apk_path');

  HttpServer? _server;
  String? _apkPath;
  String? _localIpAddress;
  int _port = _defaultPort;
  int _bytesServed = 0;
  int _downloadsCount = 0;

  /// Le serveur est-il actif ?
  bool get isRunning => _server != null;

  /// Adresse IP locale de l'appareil.
  String? get localIpAddress => _localIpAddress;

  /// Port du serveur local.
  int get port => _port;

  /// URL de téléchargement de l'APK (à transformer en QR code).
  String? get downloadUrl => _localIpAddress != null
      ? 'http://$_localIpAddress:$_port/$_apkFileName'
      : null;

  int get bytesServed => _bytesServed;
  int get downloadsCount => _downloadsCount;

  // ── Réseau ─────────────────────────────────────────────────

  Future<String?> _getLocalIpAddress() async {
    try {
      for (final NetworkInterface iface in await NetworkInterface.list()) {
        for (final InternetAddress addr in iface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      loggerDev('[ApkShare] Erreur IP locale: $e');
    }
    return null;
  }

  // ── Préparation APK ────────────────────────────────────────

  /// Récupère le chemin de l'APK installé via MethodChannel (Android).
  Future<String?> _getInstalledApkPath() async {
    try {
      if (!Platform.isAndroid) return null;
      final String? path = await _platform.invokeMethod('getApkPath');
      if (path != null && File(path).existsSync()) {
        loggerDev('[ApkShare] APK installé: $path');
        return path;
      }
    } catch (e) {
      loggerDev('[ApkShare] MethodChannel APK path: $e');
    }
    return null;
  }

  /// Extrait l'APK depuis les assets Flutter (fallback si pas d'APK installé).
  Future<String?> _extractApkFromAssets() async {
    try {
      const String assetPath = 'assets/apk/$_apkFileName';
      final ByteData byteData = await rootBundle.load(assetPath);
      final Directory appDir = await getApplicationDocumentsDirectory();
      final Directory apkDir =
          Directory('${appDir.path}/apk_share')..createSync(recursive: true);
      final String destPath = '${apkDir.path}/$_apkFileName';
      await File(destPath).writeAsBytes(
        byteData.buffer.asUint8List(
            byteData.offsetInBytes, byteData.lengthInBytes),
      );
      loggerDev('[ApkShare] APK extrait des assets: $destPath');
      return destPath;
    } catch (e) {
      loggerDev('[ApkShare] APK non trouvé dans les assets: $e');
      return null;
    }
  }

  /// Prépare l'APK (essaie d'abord l'APK installé, puis les assets).
  Future<bool> prepareApk() async {
    _apkPath = await _getInstalledApkPath() ?? await _extractApkFromAssets();
    if (_apkPath != null) {
      loggerDev('[ApkShare] APK prêt: $_apkPath');
      return true;
    }
    loggerDev('[ApkShare] APK indisponible');
    return false;
  }

  // ── Serveur HTTP ───────────────────────────────────────────

  /// Démarre le serveur de partage.
  Future<bool> startServer({int port = _defaultPort}) async {
    if (_server != null) return true;

    _localIpAddress = await _getLocalIpAddress();
    if (_localIpAddress == null) {
      loggerDev('[ApkShare] IP locale introuvable');
      return false;
    }

    if (!await prepareApk()) return false;

    try {
      _port = port;
      _server = await HttpServer.bind(InternetAddress.anyIPv4, _port);
      loggerDev('[ApkShare] Serveur démarré: http://$_localIpAddress:$_port');
      _server!.listen(_handleRequest);
      return true;
    } catch (e) {
      loggerDev('[ApkShare] Erreur démarrage serveur: $e');
      _server = null;
      return false;
    }
  }

  Future<void> _handleRequest(HttpRequest req) async {
    req.response.headers
      ..set('Access-Control-Allow-Origin', '*')
      ..set('Access-Control-Allow-Methods', 'GET, OPTIONS');

    if (req.method == 'OPTIONS') {
      req.response.statusCode = HttpStatus.ok;
      await req.response.close();
      return;
    }
    if (req.method != 'GET') {
      req.response.statusCode = HttpStatus.methodNotAllowed;
      await req.response.close();
      return;
    }

    if (req.uri.path == '/$_apkFileName') {
      await _serveApk(req);
    } else {
      await _serveWelcomePage(req);
    }
  }

  Future<void> _serveApk(HttpRequest req) async {
    try {
      final File apkFile = File(_apkPath!);
      if (!apkFile.existsSync()) {
        req.response.statusCode = HttpStatus.notFound;
        req.response.write('APK introuvable');
        await req.response.close();
        return;
      }
      final int len = apkFile.lengthSync();
      req.response.headers
        ..set('Content-Type', 'application/vnd.android.package-archive')
        ..set('Content-Length', len)
        ..set('Content-Disposition',
            'attachment; filename="$_apkFileName"');
      int sent = 0;
      await for (final List<int> chunk in apkFile.openRead()) {
        req.response.add(chunk);
        sent += chunk.length;
      }
      await req.response.close();
      _bytesServed += sent;
      _downloadsCount++;
      loggerDev('[ApkShare] APK envoyé: $sent bytes → '
          '${req.connectionInfo?.remoteAddress.address}');
    } catch (e) {
      loggerDev('[ApkShare] Erreur envoi APK: $e');
      try {
        req.response.statusCode = HttpStatus.internalServerError;
        await req.response.close();
      } catch (_) {}
    }
  }

  Future<void> _serveWelcomePage(HttpRequest req) async {
    final String html = '''
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Ẑelkova — Télécharger l'APK</title>
  <style>
    body {
      font-family: Arial, sans-serif; max-width: 480px;
      margin: 40px auto; padding: 20px; text-align: center;
      background: linear-gradient(135deg, #7B5EA7, #2E8B57); min-height: 100vh;
    }
    .card {
      background: #fff; border-radius: 20px; padding: 2rem;
      box-shadow: 0 8px 32px rgba(0,0,0,0.25);
    }
    h1 { color: #7B5EA7; font-size: 2.2rem; margin-bottom: 0.3rem; }
    p { color: #555; margin: 0.5rem 0 1.5rem; }
    .btn {
      display: block; background: linear-gradient(135deg, #7B5EA7, #2E8B57);
      color: #fff; padding: 1rem 2rem; border-radius: 30px; font-size: 1.1rem;
      font-weight: bold; text-decoration: none; margin: 1rem auto;
      box-shadow: 0 4px 16px rgba(123,94,167,0.4);
    }
    .note { background: #F8F4FF; border-radius: 10px; padding: 1rem;
      font-size: 0.85rem; color: #666; margin-top: 1.5rem; text-align: left; }
    ol { margin: 0.5rem 0 0 1.2rem; }
    li { margin: 0.3rem 0; }
  </style>
</head>
<body>
  <div class="card">
    <h1>Ẑ</h1>
    <h2 style="color:#2E8B57">Ẑelkova</h2>
    <p>Portefeuille ẐEN MULTIPASS · astroport.one</p>
    <a href="/$_apkFileName" class="btn">⬇️ Télécharger l'APK Android</a>
    <div class="note">
      <strong>Instructions :</strong>
      <ol>
        <li>Téléchargez l'APK ci-dessus</li>
        <li>Ouvrez le fichier téléchargé</li>
        <li>Autorisez les sources inconnues si demandé</li>
        <li>Installez et créez votre MULTIPASS !</li>
      </ol>
    </div>
  </div>
</body>
</html>''';
    req.response.headers.set('Content-Type', 'text/html; charset=utf-8');
    req.response.write(html);
    await req.response.close();
  }

  /// Arrête le serveur.
  Future<void> stopServer() async {
    await _server?.close(force: true);
    _server = null;
    loggerDev('[ApkShare] Serveur arrêté');
  }

  Future<void> dispose() async {
    await stopServer();
    _apkPath = null;
    _localIpAddress = null;
    _bytesServed = 0;
    _downloadsCount = 0;
  }
}
