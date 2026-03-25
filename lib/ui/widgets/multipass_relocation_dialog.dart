import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../env.dart';
import '../../shared_prefs_helper_v2.dart';
import '../ui_helpers.dart';

/// Shows the MULTIPASS relocation dialog.
///
/// For MULTIPASS users, replaces the export-backup reminder with a
/// "Do you want to move?" flow that:
///
///  1. Loads the locally-stored SSSS player key (ssss_player) + upassport home.
///  2. On confirmation, POSTs to `{upassportHome}/upassport` with
///     parametre=<ssssPlayer> and imageData=0000.
///  3. This triggers nostr_DESTROY_TW.sh on the server which:
///       – exports all NOSTR events to IPFS (encrypted backup)
///       – transfers the Ğ1 balance to the primordial account (cash-back)
///       – pre-generates a .next.disco for restoration on the new relay
///       – publishes the backup CID in the "deactivated" NOSTR profile
///  4. Ginkgo displays the outcome; the user simply types their email on
///     the new relay to trigger nostr_RESTORE_TW.sh automatically.
void showMultipassRelocationDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) => const _MultipassRelocationSheet(),
  );
}

enum _RelocationState { idle, confirm, loading, success, error }

class _MultipassRelocationSheet extends StatefulWidget {
  const _MultipassRelocationSheet();

  @override
  State<_MultipassRelocationSheet> createState() =>
      _MultipassRelocationSheetState();
}

class _MultipassRelocationSheetState
    extends State<_MultipassRelocationSheet> {
  _RelocationState _phase = _RelocationState.idle;
  String? _ssssPlayer;
  String? _upassportHome;
  String? _npub; // npub of the user, used to link to the deactivated NOSTR profile
  String? _errorMessage;
  bool _dataLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMultipassData();
  }

  Future<void> _loadMultipassData() async {
    final Map<String, dynamic>? data =
        await SharedPreferencesHelperV2().getMultipassData();
    if (mounted) {
      setState(() {
        _ssssPlayer = data != null ? data['ssss_player'] as String? : null;
        _upassportHome = data != null
            ? (data['uplanet_home'] as String?) ?? Env.upassportUrl
            : Env.upassportUrl;
        // npub is stored in multipass data — used to open the NOSTR profile
        // where nostr_DESTROY_TW.sh publishes the encrypted backup CID.
        _npub = data != null ? data['npub'] as String? : null;
        _dataLoading = false;
      });
    }
  }

  /// Send SSSS player key + PIN 0000 to /upassport — triggers
  /// nostr_DESTROY_TW.sh on the relay (full migration).
  Future<void> _triggerRelocation() async {
    final String ssss = _ssssPlayer ?? '';
    final String home = _upassportHome ?? Env.upassportUrl;

    if (ssss.isEmpty) {
      setState(() {
        _phase = _RelocationState.error;
        _errorMessage = tr('multipass_relocation_no_ssss');
      });
      return;
    }

    setState(() => _phase = _RelocationState.loading);

    try {
      final Uri url = Uri.parse('$home/upassport');
      final http.Response response = await http
          .post(
            url,
            body: <String, String>{
              'parametre': ssss,
              'imageData': '0000', // relocation PIN
              'zlat': '0.00',
              'zlon': '0.00',
            },
          )
          .timeout(const Duration(seconds: 120));

      if (mounted) {
        if (response.statusCode == 200) {
          setState(() => _phase = _RelocationState.success);
        } else {
          setState(() {
            _phase = _RelocationState.error;
            _errorMessage =
                tr('multipass_relocation_http_error', namedArgs: <String, String>{
              'code': response.statusCode.toString(),
            });
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _phase = _RelocationState.error;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // --- Title row ---
            Row(
              children: <Widget>[
                Icon(Icons.moving, color: colorScheme.primary, size: 26),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tr('multipass_relocation_title'),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Phase-specific body ---
            if (_dataLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(),
              )
            else
              _buildBody(theme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme, ColorScheme colorScheme) {
    switch (_phase) {
      case _RelocationState.idle:
        return _buildIdleBody(theme, colorScheme);
      case _RelocationState.confirm:
        return _buildConfirmBody(theme, colorScheme);
      case _RelocationState.loading:
        return _buildLoadingBody(theme);
      case _RelocationState.success:
        return _buildSuccessBody(theme, colorScheme);
      case _RelocationState.error:
        return _buildErrorBody(theme, colorScheme);
    }
  }

  // ── Idle: explain what will happen ─────────────────────────────────────────

  Widget _buildIdleBody(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('multipass_relocation_description'),
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 14),
        _step(theme, colorScheme, '1', tr('multipass_relocation_step1')),
        _step(theme, colorScheme, '2', tr('multipass_relocation_step2')),
        _step(theme, colorScheme, '3', tr('multipass_relocation_step3')),
        const SizedBox(height: 10),
        // Warning
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.warning_amber_rounded,
                  color: colorScheme.error, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tr('multipass_relocation_warning'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(tr('multipass_relocation_cancel')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send_outlined),
                label: Text(tr('multipass_relocation_initiate')),
                onPressed: () =>
                    setState(() => _phase = _RelocationState.confirm),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Confirm: explicit confirmation before sending ───────────────────────────

  Widget _buildConfirmBody(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        Icon(Icons.help_outline_rounded,
            size: 48, color: colorScheme.primary),
        const SizedBox(height: 12),
        Text(
          tr('multipass_relocation_confirm_title'),
          style: theme.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          tr('multipass_relocation_confirm_body'),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    setState(() => _phase = _RelocationState.idle),
                child: Text(tr('multipass_relocation_go_back')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError),
                icon: const Icon(Icons.move_up_outlined),
                label: Text(tr('multipass_relocation_confirm_button')),
                onPressed: _triggerRelocation,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Loading: waiting for the server ────────────────────────────────────────

  Widget _buildLoadingBody(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            tr('multipass_relocation_loading'),
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Success ─────────────────────────────────────────────────────────────────
  //
  // After nostr_DESTROY_TW.sh completes, the deactivated NOSTR kind-0 profile
  // is the single source of truth:
  //   • about   → "Account deactivated - Backup: {ipfs_url} | Next HEX: …"
  //   • website → direct IPFS link to the encrypted backup ZIP
  //
  // We open the user's own profile on Coracle using their npub so they can
  // copy the CID and hand it to the new relay's captain.

  Widget _buildSuccessBody(ThemeData theme, ColorScheme colorScheme) {
    final String? npub = _npub;
    final String ipfsGw = Env.ipfsGateways.isNotEmpty
        ? Env.ipfsGateways.split(' ').first.trimRight()
        : 'https://gyroi.de';

    // Deep-link into the deactivated NOSTR profile which contains the backup CID.
    final String? profileUrl = npub != null && npub.isNotEmpty
        ? '$ipfsGw/ipns/coracle.copylaradio.com/#/profile/$npub'
        : null;

    return Column(
      children: <Widget>[
        Icon(Icons.check_circle_outline,
            size: 56, color: colorScheme.primary),
        const SizedBox(height: 12),
        Text(
          tr('multipass_relocation_success_title'),
          style: theme.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          tr('multipass_relocation_success_body'),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          tr('multipass_relocation_success_hint'),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        // Display npub for lookup on the new relay + copy button
        if (npub != null && npub.isNotEmpty) ...<Widget>[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    npub,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontFamily: 'monospace', fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: tr('multipass_relocation_copy_npub'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: npub));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(tr('multipass_relocation_npub_copied')),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            if (profileUrl != null)
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.person_outline),
                  label: Text(tr('multipass_relocation_see_nostr_profile')),
                  onPressed: () {
                    Navigator.pop(context);
                    // The deactivated NOSTR profile (kind-0) is the relay for
                    // the encrypted backup CID published by nostr_DESTROY_TW.sh.
                    openUrl(profileUrl);
                  },
                ),
              ),
            if (profileUrl != null) const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: Text(tr('close')),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Error ───────────────────────────────────────────────────────────────────

  Widget _buildErrorBody(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        Icon(Icons.error_outline, size: 48, color: colorScheme.error),
        const SizedBox(height: 12),
        Text(
          tr('multipass_relocation_error_title'),
          style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme.error),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          _errorMessage ?? tr('multipass_relocation_error_generic'),
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                onPressed: () =>
                    setState(() => _phase = _RelocationState.idle),
                child: Text(tr('multipass_relocation_retry')),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(tr('close')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── helpers ───────────────────────────────────────────────────────────────

  Widget _step(ThemeData theme, ColorScheme colorScheme, String number,
      String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colorScheme.primary, shape: BoxShape.circle),
            child: Text(number,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
