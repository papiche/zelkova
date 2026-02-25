import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../logger.dart';

/// Dialog to display an avatar image in full screen
class AvatarDialog extends StatelessWidget {
  const AvatarDialog({
    super.key,
    required this.avatar,
  });

  final Uint8List avatar;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: ClipOval(
                child: Image.memory(
                  avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Show avatar dialog
void showAvatarDialog(BuildContext context, Uint8List avatar) {
  logger('[AvatarDialog] showAvatarDialog called');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      logger('[AvatarDialog] Building AvatarDialog');
      return AvatarDialog(avatar: avatar);
    },
  );
}
