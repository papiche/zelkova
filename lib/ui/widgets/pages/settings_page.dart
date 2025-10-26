import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/app_state.dart';
import '../../../data/models/theme_cubit.dart';
import '../../../g1/api.dart';
import '../../../g1/currency.dart';
import '../../../g1/service_manager.dart';
import '../../../shared_prefs_helper.dart';
import '../../contacts_cache.dart';
import '../fifth_screen/export_dialog.dart';
import '../fifth_screen/import_dialog.dart';
import 'authentication_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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

              // NETWORK SECTION (only in expert mode)
              if (state.expertMode) ...<Widget>[
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
}
