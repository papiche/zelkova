import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ListTile.divideTiles(
        context: context,
        tiles: <Widget>[
          ListTile(
            title: Text(
              tr(text),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          const SizedBox(height: 2),
        ],
      ).toList(),
    );
  }
}
