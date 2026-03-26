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
///       – publishes the backup CID in the "deactivated" NOSTR profile (kind-0)
///         NOSTR is the single source of truth for the restoration CID.
///  4. Ginkgo displays npub + link to the deactivated NOSTR profile on Coracle.
///     The user simply types their email on the new relay → auto-restore.
///
/// Bugs fixed vs previous version:
///  • DraggableScrollableSheet avoids getMaxIntrinsicWidth Flutter crash
///  • URL Coracle built from _upassportHome (the UPlanet relay IPFS gateway),
///    not from Env.ipfsGateways which may point to duniter/squid nodes
///  • If ssss_player is empty (old account), fall back to opening /scan manually
void showMultipassRelocationDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.60,
        minChildSize: 0.40,
        maxChildSize: 0.95,
        expand: false,
        builder: (BuildContext _, ScrollController scrollController) {
          return const _MultipassRelocationSheet();
        },
      );
    },
  );
}

enum _RelocationState { idle, confirm, loading, success, noSsss, error }

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
  // Base URL of the UPlanet relay (e.g. https://u.copylaradio.com).
  // Used to POST /upassport and build Coracle profile URL.
  String? _upassportHome;
  String? _npub;
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
        _npub = data != null ? data['npub'] as String? : null;
        _dataLoading = false;
        // If no SSSS is stored (account created before SSSS was persisted),
        // skip the automatic flow and go directly to the manual fallback.
        if (_ssssPlayer == null || _ssssPlayer!.isEmpty) {
          _phase = _RelocationState.noSsss;
        }
      });
    }
  }

  /// POST SSSS player key + PIN 0000 to /upassport.
  /// Triggers nostr_DESTROY_TW.sh on the relay.
  Future<void> _triggerRelocation() async {
    final String home = _upassportHome ?? Env.upassportUrl;
    setState(() => _phase = _RelocationState.loading);

    try {
      final Uri url = Uri.parse('$home/upassport');
      final http.Response response = await http
          .post(
            url,
            body: <String, String>{
              'parametre': _ssssPlayer!,
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
            _errorMessage = tr('multipass_relocation_http_error',
                namedArgs: <String, String>{
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

  // ── Coracle profile URL ────────────────────────────────────────────────────
  // Built on the relay domain (_upassportHome) which exposes an IPFS gateway.

  String get _ipfsGateway =>
      (_upassportHome ?? Env.upassportUrl).replaceAll(RegExp(r'/+$'), '');

  String? _coracleProfileUrl() {
    if (_npub == null || _npub!.isEmpty) return null;
    return '$_ipfsGateway/ipns/coracle.copylaradio.com/#/profile/$_npub';
  }

  // ── build ──────────────────────────────────────────────────────────────────

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
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

              if (_dataLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                _buildPhase(theme, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhase(ThemeData theme, ColorScheme colorScheme) {
    switch (_phase) {
      case _RelocationState.idle:
        return _buildIdle(theme, colorScheme);
      case _RelocationState.confirm:
        return _buildConfirm(theme, colorScheme);
      case _RelocationState.loading:
        return _buildLoading(theme);
      case _RelocationState.success:
        return _buildSuccess(theme, colorScheme);
      case _RelocationState.noSsss:
        return _buildNoSsss(theme, colorScheme);
      case _RelocationState.error:
        return _buildError(theme, colorScheme);
    }
  }

  // ── Idle ───────────────────────────────────────────────────────────────────

  Widget _buildIdle(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(tr('multipass_relocation_description'),
            style: theme.textTheme.bodyMedium),
        const SizedBox(height: 14),
        _step(theme, colorScheme, '1', tr('multipass_relocation_step1')),
        _step(theme, colorScheme, '2', tr('multipass_relocation_step2')),
        _step(theme, colorScheme, '3', tr('multipass_relocation_step3')),
        const SizedBox(height: 10),
        _warningBox(theme, colorScheme, tr('multipass_relocation_warning')),
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

  // ── Confirm ────────────────────────────────────────────────────────────────

  Widget _buildConfirm(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        Icon(Icons.help_outline_rounded, size: 48, color: colorScheme.primary),
        const SizedBox(height: 12),
        Text(tr('multipass_relocation_confirm_title'),
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(tr('multipass_relocation_confirm_body'),
            style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
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

  // ── Loading ────────────────────────────────────────────────────────────────

  Widget _buildLoading(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(tr('multipass_relocation_loading'),
              style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ── Success ────────────────────────────────────────────────────────────────
  //
  // After nostr_DESTROY_TW.sh completes, the deactivated kind-0 NOSTR profile
  // IS the single source of truth: its `about` / `website` fields contain the
  // CID of the encrypted backup ZIP.
  //
  // URL built on the relay domain — NOT on Env.ipfsGateways which may resolve
  // to duniter/squid nodes instead of an IPFS gateway.

  Widget _buildSuccess(ThemeData theme, ColorScheme colorScheme) {
    final String? npub = _npub;
    final String? profileUrl = _coracleProfileUrl();

    return Column(
      children: <Widget>[
        Icon(Icons.check_circle_outline, size: 56, color: colorScheme.primary),
        const SizedBox(height: 12),
        Text(tr('multipass_relocation_success_title'),
            style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: colorScheme.primary),
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(tr('multipass_relocation_success_body'),
            style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(tr('multipass_relocation_success_hint'),
            style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center),
        // npub display + copy button
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
                  child: Text(npub,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontFamily: 'monospace', fontSize: 11),
                      overflow: TextOverflow.ellipsis),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: tr('multipass_relocation_copy_npub'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: npub));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(tr('multipass_relocation_npub_copied'))));
                  },
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            if (profileUrl != null) ...<Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.person_outline),
                  label: Text(tr('multipass_relocation_see_nostr_profile')),
                  onPressed: () {
                    Navigator.pop(context);
                    openUrl(profileUrl);
                  },
                ),
              ),
              const SizedBox(width: 10),
            ],
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

  // ── No SSSS stored (old account) ───────────────────────────────────────────
  //
  // For accounts created before ssss_player was persisted, the automatic flow
  // cannot work. Offer the manual alternative: open /scan on the relay.

  Widget _buildNoSsss(ThemeData theme, ColorScheme colorScheme) {
    final String scanUrl =
        '${(_upassportHome ?? Env.upassportUrl).replaceAll(RegExp(r'/+$'), '')}/scan';
    return Column(
      children: <Widget>[
        Icon(Icons.qr_code_scanner, size: 48, color: colorScheme.primary),
        const SizedBox(height: 12),
        Text(tr('multipass_relocation_no_ssss_title'),
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(tr('multipass_relocation_no_ssss_body'),
            style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: 10),
        _warningBox(
            theme, colorScheme, tr('multipass_relocation_no_ssss_warning')),
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
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(tr('multipass_relocation_go_scan')),
                onPressed: () {
                  Navigator.pop(context);
                  openUrl(scanUrl);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Error ──────────────────────────────────────────────────────────────────

  Widget _buildError(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        Icon(Icons.error_outline, size: 48, color: colorScheme.error),
        const SizedBox(height: 12),
        Text(tr('multipass_relocation_error_title'),
            style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: colorScheme.error),
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(_errorMessage ?? tr('multipass_relocation_error_generic'),
            style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
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

  // ── Shared helpers ─────────────────────────────────────────────────────────

  Widget _step(
      ThemeData theme, ColorScheme colorScheme, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
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

  Widget _warningBox(ThemeData theme, ColorScheme colorScheme, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: colorScheme.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}
