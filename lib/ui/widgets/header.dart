import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../ui_helpers.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final double topPadding =
        MediaQuery.of(context).size.width > smallScreenWidth ? 34 : 14;
    final double bottomPadding =
        MediaQuery.of(context).size.width > smallScreenWidth ? 12 : 10;
    return Padding(
      padding: EdgeInsets.only(
          left: 2, right: 2, top: topPadding, bottom: bottomPadding),
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
