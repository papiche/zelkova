import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../g1/nostr/nostr_keys.dart';
import '../g1/nostr/nostr_relay_service.dart';
import '../shared_prefs_helper.dart';
import '../shared_prefs_helper_v2.dart';
import '../ui/logger.dart';

/// Service d'envoi de feedback / rapport de bug.
///
/// Appelle `POST {UPASSPORT_URL}/api/feedback` — même endpoint que TrocZen.
/// Le backend UPassport gère la création d'issue (GitLab) de manière sécurisée.
///
/// Les identifiants utilisateur (G1 pubKey + npub NOSTR) sont automatiquement
/// récupérés depuis les helpers de stockage locaux.
class FeedbackService {
  FeedbackService._();
  static final FeedbackService _instance = FeedbackService._();
  factory FeedbackService() => _instance;

  /// URL de l'endpoint feedback.
  String get _feedbackUrl => '${Env.upassportUrl}/api/feedback';

  // ── Identifiants utilisateur ─────────────────────────────────────────────

  Future<Map<String, String>> _getUserIdentifiers() async {
    final String g1pub = SharedPreferencesHelper().getPubKey();
    String npubHex = '';
    String npubBech32 = '';

    try {
      final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec != null && nsec.isNotEmpty) {
        npubHex = NostrRelayService.derivePublicKey(NostrKeys.nsecToHex(nsec));
        npubBech32 = NostrKeys.hexToNpub(npubHex);
      }
    } catch (e) {
      loggerDev('[FeedbackService] Could not resolve NOSTR identifiers: $e');
    }

    return <String, String>{
      'g1pub': g1pub.isNotEmpty ? g1pub : 'non défini',
      'npub_hex': npubHex.isNotEmpty ? npubHex : 'non défini',
      'npub_bech32': npubBech32.isNotEmpty ? npubBech32 : 'non défini',
    };
  }

  /// Construit la description enrichie avec les identifiants et les infos techniques.
  Future<String> _buildFullDescription(
    String description, {
    String? technicalInfo,
  }) async {
    final Map<String, String> ids = await _getUserIdentifiers();
    final StringBuffer sb = StringBuffer();

    sb.writeln('---');
    sb.writeln('### Identifiants utilisateur');
    sb.writeln('- **G1PUB**: `${ids['g1pub']}`');
    sb.writeln('- **NOSTR npub (hex)**: `${ids['npub_hex']}`');
    sb.writeln('- **NOSTR npub (bech32)**: `${ids['npub_bech32']}`');
    sb.writeln('---');
    sb.writeln();
    sb.writeln(description);

    if (technicalInfo != null && technicalInfo.isNotEmpty) {
      sb.writeln();
      sb.writeln('---');
      sb.writeln('### Informations techniques');
      sb.writeln('```');
      sb.writeln(technicalInfo);
      sb.writeln('```');
    }

    return sb.toString();
  }

  // ── Méthode principale ───────────────────────────────────────────────────

  /// Envoie un feedback vers l'API UPassport.
  ///
  /// [type]        : 'bug', 'feature', 'feedback', 'question'
  /// [title]       : Titre court
  /// [description] : Description détaillée
  /// [platform]    : Plateforme (ex: 'web', 'Android', 'iOS')
  /// [appVersion]  : Version de l'app
  /// [technicalInfo] : Informations de diagnostic optionnelles
  Future<FeedbackResult> sendFeedback({
    required String type,
    required String title,
    required String description,
    String platform = 'unknown',
    String appVersion = 'unknown',
    String? technicalInfo,
  }) async {
    try {
      final String fullDescription = await _buildFullDescription(
        description,
        technicalInfo: technicalInfo,
      );
      final Map<String, String> ids = await _getUserIdentifiers();

      final http.Response response = await http
          .post(
            Uri.parse(_feedbackUrl),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              'type': type,
              'title': title,
              'description': fullDescription,
              'email': 'anonymous',
              'app_version': appVersion,
              'platform': platform,
              'user_g1pub': ids['g1pub'],
              'user_npub': ids['npub_hex'],
              'user_npub_bech32': ids['npub_bech32'],
              'user_display_name': 'Ẑelkova User',
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        return FeedbackResult(
          success: true,
          issueNumber: data['issue_number'] as int?,
          issueUrl: data['issue_url'] as String?,
          message: data['message'] as String?,
        );
      } else {
        final Map<String, dynamic> error =
            jsonDecode(response.body) as Map<String, dynamic>;
        return FeedbackResult(
          success: false,
          error: error['error'] as String? ?? 'Erreur inconnue (${response.statusCode})',
        );
      }
    } catch (e) {
      loggerDev('[FeedbackService] sendFeedback error: $e');
      return FeedbackResult(
        success: false,
        error: 'Impossible de joindre le serveur UPassport',
      );
    }
  }

  /// Raccourci pour un rapport de bug.
  Future<FeedbackResult> reportBug({
    required String title,
    required String description,
    String platform = 'unknown',
    String appVersion = 'unknown',
    String? technicalInfo,
  }) =>
      sendFeedback(
        type: 'bug',
        title: title,
        description: description,
        platform: platform,
        appVersion: appVersion,
        technicalInfo: technicalInfo,
      );
}

/// Résultat d'envoi de feedback.
class FeedbackResult {
  const FeedbackResult({
    required this.success,
    this.issueNumber,
    this.issueUrl,
    this.message,
    this.error,
  });

  final bool success;
  final int? issueNumber;
  final String? issueUrl;
  final String? message;
  final String? error;
}

// ── Buffer de logs en mémoire ─────────────────────────────────────────────

/// Buffer circulaire léger pour stocker les 200 derniers messages de log.
///
/// Usage: `AppLogBuffer.add('message')` depuis n'importe où.
/// Le contenu est exporté en texte dans [AppLogBuffer.export()].
class AppLogBuffer {
  AppLogBuffer._();
  static final List<_LogEntry> _buffer = <_LogEntry>[];
  static const int _maxSize = 200;

  /// Ajoute un message au buffer.
  static void add(String message, {String level = 'log'}) {
    if (_buffer.length >= _maxSize) {
      _buffer.removeAt(0);
    }
    _buffer.add(_LogEntry(
      timestamp: DateTime.now(),
      message: message,
      level: level,
    ));
  }

  /// Exporte les logs en texte lisible.
  static String export() {
    final StringBuffer sb = StringBuffer();
    sb.writeln('=== GINKGO LOG BUFFER ===');
    sb.writeln('Export: ${DateTime.now().toIso8601String()}');
    sb.writeln('Entries: ${_buffer.length}');
    sb.writeln('=========================');
    sb.writeln();
    for (final _LogEntry e in _buffer) {
      sb.writeln(e);
    }
    return sb.toString();
  }

  /// Vide le buffer.
  static void clear() => _buffer.clear();

  static int get count => _buffer.length;
}

class _LogEntry {
  const _LogEntry({
    required this.timestamp,
    required this.message,
    required this.level,
  });

  final DateTime timestamp;
  final String message;
  final String level;

  @override
  String toString() {
    final String icon = <String, String>{
          'error': '❌',
          'warn': '⚠️',
          'success': '✅',
          'info': 'ℹ️',
        }[level] ??
        '📝';
    final String time = timestamp.toIso8601String().split('T').last;
    return '$icon [$time] $message';
  }
}
