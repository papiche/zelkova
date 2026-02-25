import 'package:flutter/material.dart';

import '../../data/models/contact.dart';
import '../logger.dart';

/// Compact circular avatar badge for use in lists and inline contexts.
/// Shows the actual avatar if available, otherwise shows nothing.
/// Supports optional onTap callback to show avatar in large dialog.
class AvatarBadge extends StatelessWidget {
  const AvatarBadge({
    super.key,
    required this.contact,
    this.radius = 10.0,
    this.onTap,
  });

  final Contact contact;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (contact.avatar == null || contact.avatar!.isEmpty) {
      // No avatar, return empty container
      return const SizedBox.shrink();
    }

    final Widget badge = CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: Image.memory(
          contact.avatar!,
          fit: BoxFit.cover,
        ),
      ),
    );

    if (onTap != null) {
      logger('[AvatarBadge] Avatar has onTap callback');
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          logger('[AvatarBadge] Avatar tapped!');
          onTap!();
        },
        child: badge,
      );
    }

    logger('[AvatarBadge] Avatar has NO onTap callback');
    return badge;
  }
}
