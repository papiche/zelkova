import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Drop-in replacement for AboutListTile that fetches PackageInfo on tap.
/// It mirrors the most common AboutListTile props.
/// Keep changes minimal in callers.
class LazyAboutListTile extends StatelessWidget {
  const LazyAboutListTile({
    super.key,
    this.icon,
    this.child,
    this.applicationName,
    this.applicationIcon,
    this.applicationLegalese,
    this.aboutBoxChildren = const <Widget>[],
    this.versionLabelPrefix = 'Version: ',
    this.fallbackVersion = 'dev',
  });

  // Matches AboutListTile API surface
  final Widget? icon;
  final Widget? child;
  final String? applicationName;
  final Widget? applicationIcon;
  final String? applicationLegalese;
  final List<Widget> aboutBoxChildren;

  // Extra options
  final String versionLabelPrefix; // e.g. 'Version: '
  final String fallbackVersion; // used if PackageInfo fails

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations l10n = MaterialLocalizations.of(context);
    final Widget title =
        child ?? Text(l10n.aboutListTileTitle(applicationName ?? ''));

    return ListTile(
      leading: icon ?? const Icon(Icons.info_outline),
      title: title,
      onTap: () async {
        // Lazily resolve version only when tapped.
        String version = fallbackVersion;
        try {
          final PackageInfo info = await PackageInfo.fromPlatform();
          version = info.version;
        } catch (_) {
          // Swallow errors; show fallback version instead.
        }
        if (!context.mounted) {
          return;
        }
        showAboutDialog(
          context: context,
          applicationName: applicationName,
          applicationIcon: applicationIcon,
          applicationVersion: '$versionLabelPrefix$version',
          applicationLegalese: applicationLegalese,
          children: aboutBoxChildren,
        );
      },
    );
  }
}
