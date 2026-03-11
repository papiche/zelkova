import 'package:flutter/material.dart';

import '../../../data/models/stored_account.dart';
import '../card_helper.dart';
import 'card_text_style.dart';

class SimpleCardNameText extends StatelessWidget {
  const SimpleCardNameText(
      {super.key,
      required this.currentText,
      required this.addSuffix,
      required this.onTap,
      required this.account});

  final String currentText;
  final StoredAccount account;
  final bool addSuffix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  if (currentText.isNotEmpty)
                    TextSpan(
                      text: currentText,
                      style: cardTextStyle(context, fontSize: 15),
                    ),
                  /*// Show g1nkgo suffix only in v1 passwordLess accounts
                  if (account.type == AccountType.v1PasswordLess)
                    TextSpan(
                      text: g1nkgoUserNameSuffix,
                      style: cardTextStyle(context, fontSize: 15),
                    ),*/
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Opacity(
              opacity: 0.45,
              child: walletIconByTypeSimple(context, account, 18)),
        ],
      ),
    );
  }
}
