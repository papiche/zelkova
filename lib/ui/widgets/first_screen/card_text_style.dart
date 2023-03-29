import 'package:flutter/material.dart';

TextStyle cardTextStyle(BuildContext context) {
  return TextStyle(
    fontFamily: 'SourceCodePro',
    // decoration: TextDecoration.underline,
    color: Colors.white,
    fontSize: MediaQuery.of(context).size.width * 0.06,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 1,
        color: Colors.black.withOpacity(0.7),
        offset: const Offset(0, 2),
      ),
      Shadow(
        blurRadius: 1,
        color: Colors.white.withOpacity(0.5),
        offset: const Offset(0, -1),
      ),
    ],
  );
}
