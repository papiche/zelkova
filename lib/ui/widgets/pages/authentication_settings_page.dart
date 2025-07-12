import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/models/legacy_wallet.dart';
import '../../../shared_prefs_helper.dart';
import '../../../storage_keys.dart';
import '../../biometrics/biometric_auth_service.dart';
import '../../in_dev_helper.dart';
import '../../secure_unlock_widget.dart';

class AuthenticationSettingsPage extends StatefulWidget {
  const AuthenticationSettingsPage({super.key});

  @override
  State<AuthenticationSettingsPage> createState() =>
      _AuthenticationSettingsPageState();
}

class _AuthenticationSettingsPageState
    extends State<AuthenticationSettingsPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final BiometricAuthService _biometricAuth = BiometricAuthService();

  bool _biometricsEnabled = false;
  bool _canCheckBiometrics = false;
  bool _hasUnlockMethod = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricPreference();
    _checkBiometricsAvailability();
    _checkUnlockStatus();
  }

  Future<void> _loadBiometricPreference() async {
    final bool isEnabled = await _biometricAuth.isBiometricEnabled();
    setState(() => _biometricsEnabled = isEnabled);
  }

  Future<void> _updateBiometricPreference(bool enabled) async {
    await _biometricAuth.setBiometricEnabled(enabled);
    setState(() => _biometricsEnabled = enabled);
  }

  Future<void> _checkBiometricsAvailability() async {
    final bool canCheck = await _biometricAuth.isBiometricSupported();
    setState(() => _canCheckBiometrics = canCheck);
  }

  Future<void> _checkUnlockStatus() async {
    final String? storedKey =
        await _storage.read(key: StorageKeys.securePatternOrPass);
    setState(() {
      _hasUnlockMethod = storedKey != null && storedKey.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('auth_config_title').tr()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (inDevelopment) ...<Widget>[
              if (!_hasUnlockMethod)
                ElevatedButton(
                  onPressed: () => _showSetup(context),
                  child: const Text('auth_config_setup_button').tr(),
                ),
              const SizedBox(height: 10),
              _walletStatsWidget(),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () => _showChange(context),
              child: const Text('auth_change_pattern_button').tr(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showUnlock(context),
              child: const Text('auth_test_button').tr(),
            ),
            const SizedBox(height: 20),
            if (_canCheckBiometrics)
              SwitchListTile(
                title: const Text('auth_enable_biometrics').tr(),
                value: _biometricsEnabled,
                onChanged: (bool value) {
                  _updateBiometricPreference(value);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _walletStatsWidget() {
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    final int total = helper.cards.length;
    final int noPass =
        helper.cards.where((LegacyWallet w) => w.seed.isNotEmpty).length;
    final int withPass = total - noPass;

    return Column(
      children: <Widget>[
        const Text('auth_dev_stats_title').tr(),
        Text('auth_dev_stats_nopass'
            .tr(namedArgs: <String, String>{'count': noPass.toString()})),
        Text('auth_dev_stats_withpass'
            .tr(namedArgs: <String, String>{'count': withPass.toString()})),
      ],
    );
  }

  void _showUnlock(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (_) => SecureUnlockWidget(
          onUnlocked: (Uint8List key) {
            Navigator.of(context).pop();
            final String base64Key = base64Encode(key);
            debugPrint('🔓 Derived key: $base64Key');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('auth_success_message').tr()),
            );
          },
        ),
      ),
    );
  }

  void _showSetup(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (_) => SecureUnlockWidget(
          isSetup: true,
          onUnlocked: (Uint8List derivedKey) {
            Navigator.of(context).pop();
            final String base64Key = base64Encode(derivedKey);
            debugPrint('🧷 Derived key during setup: $base64Key');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('auth_pattern_set_message').tr()),
            );
            _checkUnlockStatus();
          },
        ),
      ),
    );
  }

  void _showChange(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (_) => SecureUnlockWidget(
          isChange: true,
          onUnlocked: (Uint8List derivedKey) {
            Navigator.of(context).pop();
            final String base64Key = base64Encode(derivedKey);
            debugPrint('🧷 Derived key during change: $base64Key');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: const Text('auth_pattern_changed_message').tr()),
            );
            _checkUnlockStatus();
          },
        ),
      ),
    );
  }
}
