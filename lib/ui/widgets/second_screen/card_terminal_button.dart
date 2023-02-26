import 'package:flutter/material.dart';

class CardTerminalButton extends StatelessWidget {
  CardTerminalButton({super.key, String? text, Color? bgColor})
      : text = text ?? '',
        bgColor = bgColor ?? Colors.grey.shade400;
  final String text;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // print('without use right now');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(width: 4, color: Colors.black54),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
