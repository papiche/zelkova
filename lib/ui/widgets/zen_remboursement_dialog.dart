import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../env.dart';
import '../../g1/currency.dart';
import '../../shared_prefs_helper_v2.dart';
import '../currency_helper.dart';
import '../logger.dart';
import '../pay_helper.dart';

/// Shows the ZEN expense claim dialog (credit return → OC expense submission).
void showZenRemboursementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const ZenRemboursementDialog(),
  );
}

class ZenRemboursementDialog extends StatefulWidget {
  const ZenRemboursementDialog({super.key});

  @override
  State<ZenRemboursementDialog> createState() =>
      _ZenRemboursementDialogState();
}

class _ZenRemboursementDialogState extends State<ZenRemboursementDialog> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? _multipassData;
  bool _loading = true;
  bool _submitting = false;
  bool _creditReturned = false;

  double _balanceZen = 0;
  double _maxReturn = 0;
  String _ocSlug = '';
  String _uplanetnameG1 = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final Map<String, dynamic>? data =
        await SharedPreferencesHelperV2().getMultipassData();

    if (!mounted) return;

    final AppCubit appCubit = context.read<AppCubit>();
    final double balanceCentimes =
        context.read<MultiWalletTransactionCubit>().balance();
    // ZEN balance = (centimes/100 - 1) * 10
    final double balanceZen = convertAmountByCurrency(
        Currency.ZEN, balanceCentimes, appCubit.currentUd,
        isBalance: true);

    // Extract OC slug from multipass data
    String slug = '';
    if (data != null) {
      final Map<String, dynamic> ocUrlsRaw =
          (data['oc_urls'] as Map<String, dynamic>?) ?? <String, dynamic>{};
      final String membre = ocUrlsRaw['membre'] as String? ?? '';
      final String cloud = ocUrlsRaw['cloud'] as String? ?? '';
      final String anyUrl =
          membre.isNotEmpty ? membre : (cloud.isNotEmpty ? cloud : '');
      if (anyUrl.contains('opencollective.com/')) {
        final Uri uri = Uri.tryParse(anyUrl) ?? Uri();
        if (uri.pathSegments.isNotEmpty) {
          slug = uri.pathSegments.first;
        }
      }
    }

    // Resolve UPLANETNAME_G1 (cooperative central wallet = uplanet.G1.dunikey):
    // NOT to be confused with UPLANETG1PUB (uplanet.dunikey = swarm identity)
    // 1. From multipass data (if UPassport /g1nostr returns it)
    // 2. Fallback: fetch 12345.json from station IPFS gateway
    String uplanetnameG1 = data?['uplanetname_g1'] as String? ?? '';
    if (uplanetnameG1.isEmpty) {
      uplanetnameG1 = await _fetchUplanetnameG1FromStation();
    }

    setState(() {
      _multipassData = data;
      _balanceZen = balanceZen;
      _maxReturn = (balanceZen / 3).floorToDouble();
      _ocSlug = slug;
      _uplanetnameG1 = uplanetnameG1;
      _loading = false;
    });
  }

  /// Fetch UPLANETNAME_G1 (cooperative bank pubkey = uplanet.G1.dunikey)
  /// from the station's 12345.json.
  /// NOT UPLANETG1PUB which is the swarm identity (uplanet.dunikey).
  /// Convention: UPASSPORT_URL = https://u.{domain}
  ///           → IPFS gateway  = https://ipfs.{domain}
  ///           → 12345.json    = https://ipfs.{domain}/12345/
  Future<String> _fetchUplanetnameG1FromStation() async {
    try {
      final Uri upassportUri = Uri.parse(Env.upassportUrl);
      final String host = upassportUri.host;
      // Derive IPFS gateway: u.domain → ipfs.domain
      String ipfsHost;
      if (host.startsWith('u.')) {
        ipfsHost = 'ipfs.${host.substring(2)}';
      } else {
        // Fallback: try replacing first subdomain
        final List<String> parts = host.split('.');
        if (parts.length >= 2) {
          parts[0] = 'ipfs';
          ipfsHost = parts.join('.');
        } else {
          return '';
        }
      }

      final Uri stationUrl = Uri.https(ipfsHost, '/12345/');
      loggerDev('Fetching station data from $stationUrl');

      final http.Response response = await http
          .get(stationUrl)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> stationData =
            jsonDecode(response.body) as Map<String, dynamic>;
        final String pubKey =
            stationData['UPLANETNAME_G1'] as String? ?? '';
        if (pubKey.isNotEmpty) {
          loggerDev('Resolved UPLANETNAME_G1 from 12345.json: ${pubKey.substring(0, 8)}...');
        }
        return pubKey;
      }
    } catch (e) {
      loggerDev('Failed to fetch UPLANETNAME_G1 from station: $e');
    }
    return '';
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return tr('enter_a_valid_number');
    }
    final double? amount = double.tryParse(value.replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      return tr('enter_a_positive_number');
    }
    if (amount > _maxReturn) {
      return tr('remboursement_max_exceeded',
          namedArgs: <String, String>{'max': _maxReturn.toStringAsFixed(0)});
    }
    return null;
  }

  Future<void> _executeReturn() async {
    if (!_formKey.currentState!.validate()) return;

    final double amountZen =
        double.parse(_amountController.text.replaceAll(',', '.'));

    setState(() => _submitting = true);

    if (_uplanetnameG1.isEmpty) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('remboursement_no_central_wallet'))),
        );
      }
      return;
    }

    if (!mounted) return;

    final AppCubit appCubit = context.read<AppCubit>();
    final Contact collectiveWallet = Contact(pubKey: _uplanetnameG1);

    final bool success = await payWithRetry(
      context: context,
      recipients: <Contact>[collectiveWallet],
      amount: amountZen,
      comment: 'RESTITUTION:INDEMNISATION',
      isG1: false,
      currentUd: appCubit.currentUd,
      currency: Currency.ZEN,
    );

    if (!mounted) return;

    setState(() {
      _submitting = false;
      _creditReturned = success;
    });
  }

  Future<void> _openOcExpenses() async {
    final String slug = _ocSlug.isNotEmpty ? _ocSlug : 'monnaie-libre';
    final Uri uri =
        Uri.parse('https://opencollective.com/$slug/expenses/new');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const AlertDialog(
        content: Center(child: CircularProgressIndicator()),
      );
    }

    // No MULTIPASS
    if (_multipassData == null) {
      return AlertDialog(
        title: Text(tr('remboursement_title')),
        content: Text(tr('recharge_no_multipass')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('close')),
          ),
        ],
      );
    }

    // Balance too low
    if (_balanceZen <= 0 || _maxReturn <= 0) {
      return AlertDialog(
        title: Text(tr('remboursement_title')),
        content: Text(tr('remboursement_insufficient_balance')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('close')),
          ),
        ],
      );
    }

    // After successful credit return → show OC redirect
    if (_creditReturned) {
      return _buildSuccessView();
    }

    // Main form
    return _buildFormView();
  }

  Widget _buildFormView() {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(tr('remboursement_title')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Explanation card
              Card(
                color: colors.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.info_outline,
                              size: 20, color: colors.onPrimaryContainer),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              tr('remboursement_info_title'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('remboursement_info_desc'),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Balance info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(tr('balance'),
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    '${_balanceZen.toStringAsFixed(1)} Ẑ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(tr('remboursement_max_label'),
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(
                    '${_maxReturn.toStringAsFixed(0)} Ẑ (1/3)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Amount input
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: _validateAmount,
                decoration: InputDecoration(
                  labelText: tr('remboursement_amount_label'),
                  suffixText: 'Ẑ = EUR',
                  border: const OutlineInputBorder(),
                  helperText: tr('remboursement_amount_helper'),
                  helperMaxLines: 2,
                ),
              ),
              const SizedBox(height: 12),

              // Quick amount buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _quickAmountButton((_maxReturn / 3).floor()),
                  _quickAmountButton((_maxReturn / 2).floor()),
                  _quickAmountButton(_maxReturn.floor()),
                ],
              ),
              const SizedBox(height: 16),

              // Steps reminder
              Card(
                color: colors.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tr('remboursement_steps_title'),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _stepRow(1, tr('remboursement_step1')),
                      _stepRow(2, tr('remboursement_step2')),
                      _stepRow(3, tr('remboursement_step3')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('cancel')),
        ),
        FilledButton.icon(
          onPressed: _submitting ? null : _executeReturn,
          icon: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send),
          label: Text(tr('remboursement_burn_button')),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String amountStr = _amountController.text;

    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.check_circle, color: colors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(tr('remboursement_success_title'))),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tr('remboursement_success_desc',
                  namedArgs: <String, String>{'amount': amountStr}),
            ),
            const SizedBox(height: 16),
            Card(
              color: colors.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr('remboursement_oc_instructions_title'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.onTertiaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr('remboursement_oc_instructions_desc'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onTertiaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Invoice label suggestions
            Card(
              color: colors.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr('remboursement_label_title'),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr('remboursement_label_armateur'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      tr('remboursement_label_capitaine'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('close')),
        ),
        FilledButton.icon(
          onPressed: _openOcExpenses,
          icon: const Icon(Icons.open_in_new),
          label: Text(tr('remboursement_go_oc')),
        ),
      ],
    );
  }

  Widget _quickAmountButton(int amount) {
    if (amount <= 0) return const SizedBox.shrink();
    return OutlinedButton(
      onPressed: () {
        _amountController.text = amount.toString();
      },
      child: Text('$amount Ẑ'),
    );
  }

  Widget _stepRow(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 10,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
