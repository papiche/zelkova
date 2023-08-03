import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GridItem extends StatelessWidget {
  /// Named parameters are preferred, they make the code easier to understand.
  const GridItem(
      {super.key,
      required this.title,
      required this.icon,
      this.url,
      this.onTap,
      this.subtitle});

  final String title;
  final IconData icon;
  final Uri? url;
  final Function()? onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else if (url != null) {
            _launchUrl();
          }
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            Text(
              tr(title),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(fontWeightDelta: 2, fontSizeDelta: -2),
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  /// Example: Use the url_launcher package to open the browser
  Future<bool> _launchUrl() async => await canLaunchUrl(url!)
      ? await launchUrl(url!)
      : throw Exception('Could not launch $url');
}
