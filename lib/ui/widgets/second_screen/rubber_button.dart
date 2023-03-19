import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../ui_helpers.dart';

class RubberButton extends StatelessWidget {
  RubberButton({super.key,
    this.label,
    this.icon,
    required this.onPressed,
    Color? bgColor})
      : bgColor = bgColor ?? Colors.grey[350]!;

  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        border: NeumorphicBorder(color: Colors.grey[750], width: 4),
        color: bgColor,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10),
        ),
        shape: NeumorphicShape.concave,
        depth: 5,
        intensity: 0.5,
        surfaceIntensity: 0.5,
      ),
      child: Center(
          child: label != null
              ? Text(label!.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto Mono',
                fontSize:
                MediaQuery
                    .of(context)
                    .size
                    .width > smallScreenWidth
                    ? 30
                    : MediaQuery
                    .of(context)
                    .size
                    .width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))
              : Icon(icon)),
    );
  }
}
