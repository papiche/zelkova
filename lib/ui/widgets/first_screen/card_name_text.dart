import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../ui_helpers.dart';
import 'card_text_style.dart';

class CardNameText extends StatelessWidget {
  const CardNameText(
      {super.key,
      required this.currentText,
      required this.onTap,
      required this.isGinkgoCard});

  final String currentText;
  final bool isGinkgoCard;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String defValue = isGinkgoCard ? tr('your_name_here') : '';
    return InkWell(
      onTap: onTap,
      child: RichText(
        // softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            if (currentText == defValue)
              TextSpan(
                  text: currentText.toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'SourceCodePro', color: Colors.grey)),
            if (currentText.isNotEmpty && currentText != defValue)
              TextSpan(
                  text: currentText,
                  style: cardTextStyle(context, fontSize: 15)),
            if (currentText.isNotEmpty && currentText != defValue)
              TextSpan(
                text: isGinkgoCard
                    ? g1nkgoUserNameSuffix
                    : protectedUserNameSuffix,
                style: cardTextStyle(context, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
