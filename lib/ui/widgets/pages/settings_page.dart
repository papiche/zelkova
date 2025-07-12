import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../in_dev_helper.dart';
import 'authentication_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('settings_title').tr()),
      body: ListView(
        children: <Widget>[
          if (inDevelopment) ...<Widget>[
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('auth_settings_title').tr(),
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
            // const Divider(),
          ],
        ],
      ),
    );
  }
}
