import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pattern_lock/pattern_lock.dart';

import '../main.dart';
import '../secure_crypto_helper.dart';
import '../storage_keys.dart';
import 'widgets/password_field.dart';

class SecureUnlockWidget extends StatefulWidget {
  const SecureUnlockWidget({
    super.key,
    required this.onUnlocked,
    this.isSetup = false,
    this.isChange = false,
  });

  final void Function(Uint8List key) onUnlocked;
  final bool isSetup;
  final bool isChange;

  @override
  State<SecureUnlockWidget> createState() => _SecureUnlockWidgetState();
}

class _SecureUnlockWidgetState extends State<SecureUnlockWidget> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _saltReady = false;
  bool _changing = false;
  bool _usePassword = false;
  late List<int> _salt;
  List<int>? _firstPattern;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _loadOrGenerateSalt();
    await _loadMethodPreference();
  }

  Future<void> _loadOrGenerateSalt() async {
    final String? storedSalt = await _storage.read(key: StorageKeys.secureSalt);
    _salt = storedSalt != null
        ? base64Decode(storedSalt)
        : SecureCryptoHelper.generateSalt();
    if (storedSalt == null) {
      await _storage.write(
        key: StorageKeys.secureSalt,
        value: base64Encode(_salt),
      );
    }
    setState(() => _saltReady = true);
  }

  Future<void> _loadMethodPreference() async {
    final String? mode = await _storage.read(key: StorageKeys.usesPassword);
    setState(() {
      _usePassword = mode == 'true';
    });
  }

  void _showError(String msg) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: const TextStyle(color: Colors.red))),
    );
  }

  Future<void> _onPasswordEntered() async {
    final String pwd = _passwordController.text.trim();
    final String confirm = _confirmController.text.trim();
    final bool isConfirm = widget.isSetup || _changing;

    if (pwd.length < 6) {
      _showError(tr('password_too_short'));
      return;
    }

    if (isConfirm) {
      if (pwd != confirm) {
        _showError(tr('passwords_do_not_match'));
        return;
      }

      final Uint8List key =
          await SecureCryptoHelper.deriveKeyFromPassword(pwd, _salt);
      await _storage.write(
          key: StorageKeys.securePatternOrPass, value: base64Encode(key));
      await _storage.write(key: StorageKeys.usesPassword, value: 'true');

      widget.onUnlocked(key);
    } else {
      final Uint8List key =
          await SecureCryptoHelper.deriveKeyFromPassword(pwd, _salt);
      final String? stored =
          await _storage.read(key: StorageKeys.securePatternOrPass);
      if (stored != null && base64Encode(key) == stored) {
        if (widget.isChange) {
          setState(() {
            _changing = true;
            _passwordController.clear();
            _confirmController.clear();
          });
        } else {
          widget.onUnlocked(key);
        }
      } else {
        _showError(tr('wrong_password'));
      }
    }
  }

  Widget _buildPasswordUI() {
    final bool isConfirm = widget.isSetup || _changing;

    final bool showSwitchButton =
        widget.isSetup || (widget.isChange && _changing && _usePassword);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          isConfirm ? tr('set_password_title') : tr('enter_password'),
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        PasswordField(
          controller: _passwordController,
          label: tr('enter_password'),
          validator: RegExp(r'^.{6,}$'),
          errorText: tr('password_too_short'),
          onChanged: (_) {},
        ),
        if (isConfirm)
          PasswordField(
            controller: _confirmController,
            label: tr('confirm_password'),
            validator: RegExp(r'^.{6,}$'),
            errorText: tr('password_too_short'),
            onChanged: (_) {},
          ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onPasswordEntered,
          child: Text(tr('continue')),
        ),
        const SizedBox(height: 16),
        if (showSwitchButton)
          TextButton(
            onPressed: () => setState(() => _usePassword = false),
            child: Text(tr('use_pattern_instead')),
          ),
        if (isConfirm) _buildWarningCard(),
      ],
    );
  }

  Future<void> _onPatternEntered(List<int> pattern) async {
    if (pattern.length < 3) {
      _showError(tr('at_least_3'));
      return;
    }

    if (widget.isSetup || _changing) {
      if (_firstPattern == null) {
        setState(() => _firstPattern = pattern);
      } else if (_firstPattern!.join() == pattern.join()) {
        final Uint8List key =
            await SecureCryptoHelper.deriveKeyFromPattern(pattern, _salt);
        await _storage.write(
          key: StorageKeys.securePatternOrPass,
          value: base64Encode(key),
        );
        await _storage.write(
          key: StorageKeys.usesPassword,
          value: 'false',
        );
        widget.onUnlocked(key);
      } else {
        _showError(tr('pattern_do_not_match'));
        setState(() => _firstPattern = null);
      }
    } else {
      final Uint8List key =
          await SecureCryptoHelper.deriveKeyFromPattern(pattern, _salt);
      final String? stored =
          await _storage.read(key: StorageKeys.securePatternOrPass);
      if (stored != null && base64Encode(key) == stored) {
        if (widget.isChange) {
          setState(() {
            _changing = true;
            _firstPattern = null;
          });
        } else {
          widget.onUnlocked(key);
        }
      } else {
        _showError(tr('wrong_pattern'));
      }
    }
  }

  Widget _buildPatternUI() {
    final String title = (widget.isSetup || _changing)
        ? (_firstPattern == null
            ? (widget.isChange
                ? tr('draw_your_new_pattern')
                : tr('draw_your_pattern'))
            : tr('confirm_pattern'))
        : tr('draw_your_pattern');

    final bool showSwitchButton =
        widget.isSetup || (widget.isChange && _changing && !_usePassword);

    return Column(
      children: <Widget>[
        Text(title, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: PatternLock(
                selectedColor: Colors.blueAccent,
                notSelectedColor: Colors.grey,
                pointRadius: 12,
                onInputComplete: _onPatternEntered,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (showSwitchButton)
          TextButton(
            onPressed: () => setState(() => _usePassword = true),
            child: Text(tr('use_password_instead')),
          ),
        if (widget.isSetup || _changing) _buildWarningCard(),
      ],
    );
  }

  Widget _buildWarningCard() {
    return Card(
      color: Colors.orange[100],
      margin: const EdgeInsets.fromLTRB(12, 24, 12, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tr(_usePassword ? 'password_warning' : 'pattern_warning'),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.isSetup
        ? tr(_usePassword ? 'set_password_title' : 'set_pattern_title')
        : widget.isChange
            ? tr(
                _usePassword ? 'change_password_title' : 'change_pattern_title')
            : tr('unlock_wallet');

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: !_saltReady
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _usePassword ? _buildPasswordUI() : _buildPatternUI(),
              ),
            ),
    );
  }
}

Future<Uint8List?> requestSecureUnlock() async {
  final NavigatorState? navigator = GinkgoApp.navigatorKey.currentState;
  if (navigator == null) {
    return null;
  }
  return navigator.push<Uint8List>(
    MaterialPageRoute<Uint8List>(
      fullscreenDialog: true,
      builder: (_) => SecureUnlockWidget(
        onUnlocked: (Uint8List key) {
          navigator.pop(key);
        },
      ),
    ),
  );
}
