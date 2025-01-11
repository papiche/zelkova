import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatelessWidget {
  const LinkCard(
      {super.key,
      required this.title,
      required this.icon,
      this.url,
      this.onTap});

  final String title;
  final IconData icon;
  final Uri? url;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSmall =
        ResponsiveBreakpoints.of(context).smallerOrEqualTo('SMALL_MOBILE');
    final bool isLarger = ResponsiveBreakpoints.of(context).largerThan(MOBILE);
    final double calcWidth = isSmall
        ? double.infinity
        : isLarger
            ? MediaQuery.of(context).size.width / 4 - 20
            : MediaQuery.of(context).size.width / 2 - 20;
    return SizedBox(
        width: calcWidth < 160 ? 160 : calcWidth,
        child: Card(
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
            trailing: url != null
                ? Icon(Icons.open_in_new,
                    color: Theme.of(context).textTheme.titleMedium!.color)
                : null,
            leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
            minLeadingWidth: 10,
            title: Text(
              tr(title),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(fontWeightDelta: -1),
            ),
          ),
        ));
  }

  /// Example: Use the url_launcher package to open the browser
  Future<bool> _launchUrl() async => await canLaunchUrl(url!)
      ? await launchUrl(url!)
      : throw Exception('Could not launch $url');
}
