import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../services/feedback_service.dart';
import '../../env.dart';
import '../logger.dart';

/// Écran d'envoi de feedback / rapport de bug vers l'API UPassport.
///
/// Remplace les liens GitLab/GitHub par un formulaire natif qui appelle
/// `POST {UPASSPORT_URL}/api/feedback` — le même endpoint que TrocZen.
///
/// Types supportés : bug 🐛, idée ✨, question ❓, compliment 👍
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key, this.initialType = 'bug'});

  /// Type de feedback pré-sélectionné à l'ouverture.
  final String initialType;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late String _selectedType;
  bool _isSending = false;
  bool _includeTechInfo = true; // Activé par défaut pour aider les devs

  final FeedbackService _feedbackService = FeedbackService();

  static const Map<String, Map<String, dynamic>> _types =
      <String, Map<String, dynamic>>{
    'bug': <String, dynamic>{'label': '🐛 Bug', 'color': Colors.red},
    'feature': <String, dynamic>{'label': '✨ Idée', 'color': Colors.blue},
    'question': <String, dynamic>{'label': '❓ Question', 'color': Colors.orange},
    'praise': <String, dynamic>{'label': '👍 Compliment', 'color': Colors.green},
  };

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ── Plateforme ────────────────────────────────────────────────────────────

  String get _platform {
    if (kIsWeb) return 'web';
    try {
      // ignore: missing_enum_constant_in_switch
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 'Android';
        case TargetPlatform.iOS:
          return 'iOS';
        case TargetPlatform.linux:
          return 'Linux';
        case TargetPlatform.macOS:
          return 'macOS';
        case TargetPlatform.windows:
          return 'Windows';
        default:
          return 'unknown';
      }
    } catch (_) {
      return 'unknown';
    }
  }

  String? get _technicalInfo {
    if (!_includeTechInfo) return null;
    final StringBuffer sb = StringBuffer();
    sb.writeln('Platform: $_platform');
    sb.writeln('API Target: ${Env.upassportUrl}');
    sb.writeln('Log buffer: ${AppLogBuffer.count} entries');
    if (AppLogBuffer.count > 0) {
      sb.writeln();
      sb.write(AppLogBuffer.export());
    }
    return sb.toString();
  }

  // ── Envoi ─────────────────────────────────────────────────────────────────

  Future<void> _sendFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final FeedbackResult result = await _feedbackService.sendFeedback(
        type: _selectedType,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        platform: _platform,
        appVersion: 'zelkova',
        technicalInfo: _technicalInfo,
      );

      if (!mounted) return;

      if (result.success) {
        final String issueRef =
            result.issueNumber != null ? ' #${result.issueNumber}' : '';
        _showSuccessDialog(
            '${tr('feedback_sent_success')}$issueRef',
            result.issueUrl);
      } else {
        _showErrorSnackBar(result.error ?? tr('feedback_send_error'));
      }
    } catch (e) {
      loggerDev('[FeedbackScreen] Error: $e');
      if (mounted) {
        _showErrorSnackBar(tr('feedback_send_error'));
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _showSuccessDialog(String message, String? issueUrl) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Row(
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 12),
            Text(tr('feedback_thanks')),
          ],
        ),
        content: Text(message),
        actions: <Widget>[
          if (issueUrl != null)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                // Optionnel : ouvrir l'URL de l'issue
              },
              child: Text(tr('see_issue')),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (mounted) Navigator.of(context).pop();
            },
            child: Text(tr('close')),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: tr('retry'),
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: _sendFeedback,
        ),
      ),
    );
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('feedback_title')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ── Info banner ───────────────────────────────────────────
              Card(
                color: cs.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.info_outline, color: cs.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tr('feedback_info_banner'),
                          style: TextStyle(
                              color: cs.onPrimaryContainer, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Type de feedback ──────────────────────────────────────
              Text(tr('feedback_type'),
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: _types.entries.map((MapEntry<String, Map<String, dynamic>> entry) {
                  final bool isSelected = _selectedType == entry.key;
                  return ChoiceChip(
                    label: Text(entry.value['label'] as String),
                    selected: isSelected,
                    selectedColor:
                        (entry.value['color'] as Color).withValues(alpha: 0.2),
                    checkmarkColor: entry.value['color'] as Color,
                    onSelected: (_) => setState(() => _selectedType = entry.key),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // ── Titre ──────────────────────────────────────────────────
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: tr('feedback_title_field'),
                  hintText: tr('feedback_title_hint'),
                  border: const OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr('feedback_title_required');
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Description ────────────────────────────────────────────
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: tr('feedback_description'),
                  hintText: tr('feedback_description_hint'),
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return tr('feedback_description_required');
                  }
                  if (value.trim().length < 10) {
                    return tr('feedback_description_too_short');
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Option informations techniques ─────────────────────────
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(tr('feedback_include_tech_info'),
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(tr('feedback_include_tech_info_hint'),
                    style:
                        TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
                value: _includeTechInfo,
                onChanged: (bool v) => setState(() => _includeTechInfo = v),
              ),

              const SizedBox(height: 24),

              // ── Bouton envoyer ─────────────────────────────────────────
              FilledButton.icon(
                onPressed: _isSending ? null : _sendFeedback,
                icon: _isSending
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                    _isSending ? tr('feedback_sending') : tr('feedback_send')),
              ),

              const SizedBox(height: 8),

              // ── Note de confidentialité ─────────────────────────────────
              Center(
                child: Text(
                  tr('feedback_privacy_note'),
                  style: TextStyle(
                      color: cs.onSurfaceVariant, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
