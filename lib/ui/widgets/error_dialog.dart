import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.titleKey,
    required this.messageKey,
  });

  final String titleKey;
  final String messageKey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr(titleKey)),
      content: Text(tr(messageKey)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('ok')),
        ),
      ],
    );
  }
}
