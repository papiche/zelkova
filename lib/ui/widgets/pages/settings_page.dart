import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/app_state.dart';
import '../../../data/models/theme_cubit.dart';
import '../../../ui/notification_controller.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<ThemeMode>(
                  initialValue: context.watch<ThemeCubit>().state.themeMode ??
                      ThemeMode.system,
                  decoration: InputDecoration(
                    labelText: tr('theme_mode'),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(_getThemeIcon(
                        context.watch<ThemeCubit>().state.themeMode)),
                  ),
                  items: <DropdownMenuItem<ThemeMode>>[
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.system,
                      child: Text(tr('theme_mode_system')),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.light,
                      child: Text(tr('theme_mode_light')),
                    ),
                    DropdownMenuItem<ThemeMode>(
                      value: ThemeMode.dark,
                      child: Text(tr('theme_mode_dark')),
                    ),
                  ],
                  onChanged: (ThemeMode? newMode) {
                    if (newMode == null) {
                      return;
                    }
                    BlocProvider.of<ThemeCubit>(context).getTheme(
                      ThemeModeState(themeMode: newMode),
                    );
                  },
                ),
              ),
              SwitchListTile(
                title: Text(tr('expert_mode')),
                subtitle: Text(tr('expert_mode_desc')),
                value: state.expertMode,
                onChanged: (bool expert) {
                  context.read<AppCubit>().setExpertMode(expert);
                },
              ),
              // ZEN branch: currency is always ẐEN, no toggle needed

              // NETWORK SECTION - HIDDEN (V2 mode is now forced)
              // In the future, this will be replaced by network selection
              /*
              if (state.expertMode && !state.v2AutoActivated) ...<Widget>[
                const SizedBox(height: 10),
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
              */

              // SECURITY SECTION (v2 only)
              if (context.read<AppCubit>().isV2) ...<Widget>[
                const SizedBox(height: 10),
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
          ],
        );
      },
    );
  }

  IconData _getThemeIcon(ThemeMode? mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
      case null:
        return Icons.brightness_auto;
    }
  }
}
