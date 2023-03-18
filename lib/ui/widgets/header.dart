import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text, this.topPadding = 38});

  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2, right: 2, top: topPadding, bottom: 14),
      child: Text(
        tr(text),
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(fontWeightDelta: 2),
      ),
    );
  }
}
