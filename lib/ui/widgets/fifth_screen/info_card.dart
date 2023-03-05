import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.title,
      required this.icon,
      this.translate = true});

  final String title;
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
      child: ConnectivityWidgetWrapper(
          stacked: false,
          offlineWidget: const Text(
            'Connecting',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          child: ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: Row(
              children: <Widget>[
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Text(
                  translate ? tr(title) : title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontWeightDelta: 2),
                ),
              ],
            ),
          )),
    );
  }
}
