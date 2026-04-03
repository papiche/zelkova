import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../services/apk_share_service.dart';
import '../logger.dart';

/// Écran de partage APK pair-à-pair pour Ẑelkova.
///
/// Inspiré de TrocZen/troczen/lib/screens/apk_share_screen.dart (GPL-3.0).
///
/// Affiche un QR Code pointant vers le serveur HTTP local de l'appareil.
/// L'autre utilisateur scanne → ouvre le navigateur → télécharge l'APK.
///
/// Usage :
///   Navigator.push(context, MaterialPageRoute(builder: (_) => const ApkShareScreen()));
///
/// Nécessite que l'APK soit disponible (installé ou dans assets/apk/zelkova.apk).
class ApkShareScreen extends StatefulWidget {
  const ApkShareScreen({super.key});

  @override
  State<ApkShareScreen> createState() => _ApkShareScreenState();
}

class _ApkShareScreenState extends State<ApkShareScreen> {
  final ApkShareService _shareService = ApkShareService();

  bool _isStarting = false;
  bool _isRunning = false;
  String? _downloadUrl;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startServer();
  }

  @override
  void dispose() {
    _shareService.dispose();
    super.dispose();
  }

  Future<void> _startServer() async {
    setState(() {
      _isStarting = true;
      _errorMessage = null;
    });

    try {
      final bool started = await _shareService.startServer();
      if (!mounted) return;

      if (started) {
        setState(() {
          _isRunning = true;
          _downloadUrl = _shareService.downloadUrl;
          _isStarting = false;
        });
        loggerDev('[ApkShare] Serveur prêt: $_downloadUrl');
      } else {
        setState(() {
          _isStarting = false;
          _errorMessage = tr('apk_share_server_error');
        });
      }
    } catch (e) {
      loggerDev('[ApkShare] Erreur démarrage: $e');
      if (!mounted) return;
      setState(() {
        _isStarting = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _stopServer() async {
    await _shareService.stopServer();
    if (!mounted) return;
    setState(() {
      _isRunning = false;
      _downloadUrl = null;
    });
  }

  void _copyUrl() {
    if (_downloadUrl == null) return;
    Clipboard.setData(ClipboardData(text: _downloadUrl!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('apk_share_url_copied'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('apk_share_title')),
        actions: <Widget>[
          if (_isRunning)
            IconButton(
              icon: const Icon(Icons.stop_circle_outlined),
              tooltip: tr('apk_share_stop'),
              onPressed: _stopServer,
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ── En-tête ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.share, color: cs.primary, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(tr('apk_share_subtitle'),
                              style: TextStyle(
                                  color: cs.onPrimaryContainer,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                          Text(tr('apk_share_info'),
                              style: TextStyle(
                                  color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── QR Code / État ─────────────────────────────────
              if (_isStarting)
                Column(
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(tr('apk_share_starting'),
                        style: TextStyle(color: cs.onSurfaceVariant)),
                  ],
                )
              else if (_errorMessage != null)
                Column(
                  children: <Widget>[
                    Icon(Icons.error_outline,
                        size: 64, color: cs.error),
                    const SizedBox(height: 12),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: cs.error),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _startServer,
                      icon: const Icon(Icons.refresh),
                      label: Text(tr('retry')),
                    ),
                  ],
                )
              else if (_isRunning && _downloadUrl != null)
                Column(
                  children: <Widget>[
                    // QR Code
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: cs.shadow.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: QrImageView(
                        data: _downloadUrl!,
                        version: QrVersions.auto,
                        size: 240.0,
                        backgroundColor: Colors.white,
                        errorCorrectionLevel: QrErrorCorrectLevel.M,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // URL cliquable
                    GestureDetector(
                      onTap: _copyUrl,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: cs.outlineVariant),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.link, size: 16,
                                color: cs.primary),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                _downloadUrl!,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    color: cs.primary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.copy, size: 14,
                                color: cs.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Statistiques
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _StatChip(
                          icon: Icons.download,
                          label: tr('apk_share_downloads'),
                          value: '${_shareService.downloadsCount}',
                          color: cs.primary,
                        ),
                        const SizedBox(width: 12),
                        _StatChip(
                          icon: Icons.wifi,
                          label: tr('apk_share_ip'),
                          value:
                              '${_shareService.localIpAddress}:${_shareService.port}',
                          color: cs.tertiary,
                        ),
                      ],
                    ),
                  ],
                ),

              const SizedBox(height: 32),

              // ── Instructions ──────────────────────────────────
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tr('apk_share_instructions_title'),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      _Step(
                          num: '1',
                          text: tr('apk_share_step1')),
                      _Step(
                          num: '2',
                          text: tr('apk_share_step2')),
                      _Step(
                          num: '3',
                          text: tr('apk_share_step3')),
                      _Step(
                          num: '4',
                          text: tr('apk_share_step4')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(value,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: color)),
              Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      color: color.withValues(alpha: 0.8))),
            ],
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.num, required this.text});

  final String num;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color =
        Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: Text(num,
                style: const TextStyle(
                    color: Colors.white, fontSize: 10)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
