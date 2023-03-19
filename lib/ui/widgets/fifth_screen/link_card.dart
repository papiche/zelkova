import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  const LinkCard(
      {super.key, required this.title, required this.icon, required this.url});

  final String title;
  final IconData icon;
  final Uri url;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        onTap: _launchUrl,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        trailing: Icon(Icons.open_in_new,
            color: Theme.of(context).textTheme.titleMedium!.color),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        minLeadingWidth: 10,
        title: Text(
          tr(title),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontWeightDelta: 2),
        ),
      ),
    );
  }

  /// Example: Use the url_launcher package to open the browser
  Future<bool> _launchUrl() async => await canLaunchUrl(url)
      ? await launchUrl(url)
      : throw Exception('Could not launch $url');
}
