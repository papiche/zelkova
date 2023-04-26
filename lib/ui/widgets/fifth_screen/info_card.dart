import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.title,
      this.subtitle = '',
      this.trailing = '',
      required this.icon,
      this.translate = true});

  final String title;
  final String subtitle;
  final String trailing;
  final IconData icon;
  final bool translate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: trailing.isNotEmpty ? Text(trailing) : null,
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        minLeadingWidth: 10,
        dense: true,
        title: Text(
          translate ? tr(title) : title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontWeightDelta: 2),
        ),
      ),
    );
  }
}
