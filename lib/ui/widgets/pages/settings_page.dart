import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/app_state.dart';
import '../../../data/models/theme_cubit.dart';
import '../../../g1/api.dart';
import '../../../g1/currency.dart';
import '../../../g1/service_manager.dart';
import '../../../shared_prefs_helper.dart';
import '../../../ui/notification_controller.dart';
import '../../contacts_cache.dart';
import '../fifth_screen/export_dialog.dart';
import '../fifth_screen/import_dialog.dart';
import 'authentication_settings_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('settings_title').tr()),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return ListView(
            children: <Widget>[
              const SizedBox(height: 10),

              // LANGUAGE SECTION
              _buildSectionHeader(
                  context, 'settings_language_category', Icons.language),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<Locale>(
                  initialValue: context.locale,
                  decoration: InputDecoration(
                    labelText: tr('language_switch_title'),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (Locale? newLocale) {
                    context.setLocale(newLocale!);
                  },
                  items: const <DropdownMenuItem<Locale>>[
                    DropdownMenuItem<Locale>(
                      value: Locale('es', 'AST'),
                      child: Text('Asturianu'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('ca'),
                      child: Text('Català'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('da'),
                      child: Text('Dansk'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('de'),
                      child: Text('Deutsch'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('eo'),
                      child: Text('Esperanto'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('es'),
                      child: Text('Español'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('eu'),
                      child: Text('Euskara'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('fr'),
                      child: Text('Français'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('gl'),
                      child: Text('Galego'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('nl'),
                      child: Text('Nederlands'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('it'),
                      child: Text('Italiano'),
                    ),
                    DropdownMenuItem<Locale>(
                      value: Locale('pt'),
                      child: Text('Português'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // DISPLAY SECTION
              _buildSectionHeader(
                  context, 'settings_display_category', Icons.visibility),
              SwitchListTile(
                title: Text(tr('dark_mode')),
                subtitle: Text(tr('dark_mode_desc')),
                secondary: Icon(context.watch<ThemeCubit>().isDark()
                    ? Icons.dark_mode
                    : Icons.light_mode),
                value: context.watch<ThemeCubit>().isDark(),
                onChanged: (bool isDark) {
                  BlocProvider.of<ThemeCubit>(context).getTheme(
                    ThemeModeState(
                      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                    ),
                  );
                },
              ),
              SwitchListTile(
                title: Text(tr('expert_mode')),
                subtitle: Text(tr('expert_mode_desc')),
                value: state.expertMode,
                onChanged: (bool expert) {
                  context.read<AppCubit>().setExpertMode(expert);
                },
              ),
              if (state.expertMode)
                SwitchListTile(
                  title: Text(tr('display_amounts_du')),
                  value: state.currency == Currency.DU,
                  onChanged: (bool useDU) {
                    if (!useDU) {
                      context.read<AppCubit>().setG1Currency();
                    } else {
                      context.read<AppCubit>().setDUCurrency();
                    }
                  },
                ),

              // NETWORK SECTION (only in expert mode, and not if v2 was auto-activated)
              if (state.expertMode && !state.v2AutoActivated) ...<Widget>[
                const SizedBox(height: 10),
                _buildSectionHeader(
                    context, 'settings_network_category', Icons.network_check),
                SwitchListTile(
                  title: const Text('Test v2 (ĞTest)'),
                  subtitle: Text(tr('test_network_subtitle')),
                  value: state.v2mode,
                  onChanged: (bool v2mode) {
                    context.read<AppCubit>().setV2Mode(v2mode);
                    SharedPreferencesHelper.configure(useV2: v2mode);
                    if (v2mode) {
                      SharedPreferencesHelper().init(onlyV2: state.v2mode);
                      ContactsCache().clear();
                    }
                    GetIt.instance<ServiceManager>().updateService(v2mode);
                    if (v2mode) {
                      _showTestNetworkDialog(context);
                    }
                    fetchNodesIfNotReady(v2Only: v2mode);
                  },
                ),
              ],

              // BACKUP & RESTORE SECTION
              const SizedBox(height: 10),
              _buildSectionHeader(
                  context, 'settings_backup_category', Icons.backup),
              ListTile(
                leading: const Icon(Icons.download),
                title: Text(tr(SharedPreferencesHelper().hasMultipleWallets
                    ? 'export_keys'
                    : 'export_key')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  openExportWalletsSelector(context, state.expertMode);
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload),
                title: Text(tr(SharedPreferencesHelper().hasMultipleWallets
                    ? 'import_keys'
                    : 'import_key')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showSelectImportMethodDialog(context, 0);
                },
              ),

              // SECURITY SECTION (v2 only)
              if (context.read<AppCubit>().isV2) ...<Widget>[
                const SizedBox(height: 10),
                _buildSectionHeader(
                    context, 'settings_security_category', Icons.security),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('auth_settings_title').tr(),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const AuthenticationSettingsPage(),
                      ),
                    );
                  },
                ),
              ],

              // NOTIFICATIONS SECTION
              const SizedBox(height: 10),
              _buildSectionHeader(context, 'settings_notifications_category',
                  Icons.notifications),
              FutureBuilder<bool>(
                future: _isNotificationAllowed(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  final bool isAllowed = snapshot.data ?? false;
                  return ListTile(
                    leading: Icon(
                      isAllowed
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      color: isAllowed ? Colors.green : Colors.orange,
                    ),
                    title: Text(tr(
                        'settings_notifications_status_${isAllowed ? 'enabled' : 'disabled'}')),
                    subtitle: Text(tr(isAllowed
                        ? 'settings_notifications_enabled_desc'
                        : 'settings_notifications_disabled_desc')),
                    trailing:
                        !isAllowed ? const Icon(Icons.chevron_right) : null,
                    onTap: !isAllowed
                        ? () async {
                            final bool? authorized =
                                await _requestNotificationPermission(context);
                            if (authorized ?? false) {
                              // Force UI rebuild by triggering a state change
                              if (context.mounted) {
                                setState(() {});
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(tr(
                                        'settings_notifications_enabled_snack')),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(tr('settings_battery_optimizations_title')),
                subtitle: Text(tr('settings_battery_optimizations_desc')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showBatteryOptimizationDialog(context);
                },
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String titleKey, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            tr(titleKey),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _showTestNetworkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('test_network_dialog_title')),
          content: Text(tr('test_network_dialog_message')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(tr('ok')),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _isNotificationAllowed() async {
    // Import awesome_notifications in notification_controller
    // This is a simple check for notification permission status
    try {
      return await NotificationController.isNotificationAllowed();
    } catch (e) {
      return false;
    }
  }

  Future<bool?> _requestNotificationPermission(BuildContext context) async {
    try {
      return await NotificationController.displayNotificationRationale();
    } catch (e) {
      return null;
    }
  }

  void _showBatteryOptimizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('settings_background_limitations_title')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(tr('settings_background_limitations_body')),
              const SizedBox(height: 12),
              Text(
                tr('settings_battery_optimization_info'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(tr('close')),
            ),
            if (!kIsWeb && Platform.isAndroid)
              FilledButton.icon(
                icon: const Icon(Icons.battery_saver),
                label: Text(tr('settings_battery_open_settings')),
                onPressed: () {
                  Navigator.of(context).pop();
                  Permission.ignoreBatteryOptimizations.request();
                },
              ),
          ],
        );
      },
    );
  }
}
