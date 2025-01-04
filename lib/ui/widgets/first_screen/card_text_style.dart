import 'package:flutter/material.dart';

import '../../ui_helpers.dart';

TextStyle cardTextStyle(BuildContext context,
    {double? fontSize, Color? color = Colors.white}) {
  final double width = calcWidthWithResponsive(context);
  return TextStyle(
    fontFamily: 'SourceCodePro',
    // decoration: TextDecoration.underline,
    color: color,
    fontSize: fontSize ?? width * 0.06,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 1,
        color: Colors.black.withValues(alpha: 0.7),
        offset: const Offset(0, 2),
      ),
      Shadow(
        blurRadius: 1,
        color: Colors.white.withValues(alpha: 0.5),
        offset: const Offset(0, -1),
      ),
    ],
  );
}
