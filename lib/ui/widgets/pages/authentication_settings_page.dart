import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/models/stored_account.dart';
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
      appBar: AppBar(title: Text(tr('auth_config_title'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!_hasUnlockMethod)
              ElevatedButton(
                onPressed: () => _showSetup(context),
                child: Text(tr('auth_config_setup_button')),
              ),
            if (_hasUnlockMethod)
              ElevatedButton(
                onPressed: () => _showChange(context),
                child: Text(tr('auth_change_pattern_button')),
              ),
            if (_hasUnlockMethod) const SizedBox(height: 10),
            // alarm emergency unicode
            if (_hasUnlockMethod)
              const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      "⚠️: Change of password is under development, it should work but don't change your password without an export/backup of your wallets!")),
            const SizedBox(height: 10),
            if (_hasUnlockMethod)
              ElevatedButton(
                onPressed: () => _showUnlock(context),
                child: Text(tr('auth_test_button')),
              ),
            const SizedBox(height: 20),
            if (_canCheckBiometrics)
              SwitchListTile(
                title: Text(tr('auth_enable_biometrics')),
                value: _biometricsEnabled,
                onChanged: (bool value) {
                  _updateBiometricPreference(value);
                },
              ),
            if (inDevelopment) ...<Widget>[
              const SizedBox(height: 20),
              _walletStatsWidget(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () => _storage.deleteAll(),
                  //icon: const Icon(Icons.delete),

                  label: const Text('⚠️ Reset local storage (Danger)')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _walletStatsWidget() {
    final SharedPreferencesHelper helper = SharedPreferencesHelper();
    final int total = helper.length;
    final int noPass = helper.accounts
        .where((StoredAccount w) =>
            SharedPreferencesHelper().isPasswordLessWallet(w))
        .length;
    final int withPass = total - noPass;
    final bool isPasswordSet = _hasUnlockMethod;

    return Column(
      children: <Widget>[
        Text(tr('auth_dev_stats_title'),
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 20),
        Text('auth_dev_stats_nopass'
            .tr(namedArgs: <String, String>{'count': noPass.toString()})),
        Text('auth_dev_stats_withpass'
            .tr(namedArgs: <String, String>{'count': withPass.toString()})),
        Text("Password or pattern setted: ${isPasswordSet ? 'yes' : 'no'}"),
        Text('Is locked in shared prefs: ${helper.isLocked}'),
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
              SnackBar(content: Text(tr('auth_success_message'))),
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
              SnackBar(content: Text(tr('auth_pattern_set_message'))),
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
              SnackBar(content: Text(tr('auth_pattern_changed_message'))),
            );
            _checkUnlockStatus();
          },
        ),
      ),
    );
  }
}
