import 'package:flutter/material.dart';

import '../../../data/models/wallet_themes.dart';
import '../../ui_helpers.dart';

class AccountCardSelectorItem extends StatelessWidget {
  const AccountCardSelectorItem(
      {super.key,
      this.name,
      required this.theme,
      this.suffix,
      this.hasName,
      this.isDerived = false});

  final String? name;
  final bool? hasName;
  final String? suffix;
  final WalletTheme theme;
  final bool isDerived;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: AspectRatio(
                aspectRatio: cardAspectRatio, // Credit cart aspect ratio
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cardRadius),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[400]!,
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          theme.primaryColor,
                          theme.secondaryColor,
                          // card.theme.primaryColor,
                          // card.theme.secondaryColor,
                        ],
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Stack(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                    'assets/img/gbrevedot_alt.png',
                                    width: 100,
                                    height: 100),
                              )),
                          if (name != null)
                            Positioned(
                                bottom: 8,
                                left: 8,
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: name,
                                          style: _textStyle(context),
                                        ),
                                        if (hasName ?? false)
                                          TextSpan(
                                            text: suffix,
                                            style: _textStyle(context),
                                          ),
                                      ]),
                                )),
                          if (isDerived)
                            const Positioned(
                              bottom: 8,
                              right: 8,
                              child: Icon(Icons.link,
                                  color: Colors.white70, size: 20),
                            ),
                        ]))))));
  }

  TextStyle? _textStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall?.copyWith(
          fontFamily: 'SourceCode',
          color: Colors.white,
        );
  }
}
