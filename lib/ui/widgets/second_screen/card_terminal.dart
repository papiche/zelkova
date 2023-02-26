import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'card_terminal_button.dart';

class CardTerminal extends StatelessWidget {
  const CardTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 320.0,
        // height: 200.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.grey[800]!,
              Colors.grey[500]!,
            ],
          ),
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        // padding: const EdgeInsets.all(20.0),
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/QR_Code_Example.svg/368px-QR_Code_Example.svg.png?20111025115625',
                            width: 200,
                            height: 200,
                          ),
                        )))),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Muestra este código QR a tus clientes para recibir pagos',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.75 / 1,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      CardTerminalButton(text: '1'),
                      CardTerminalButton(text: '2'),
                      CardTerminalButton(text: '3'),
                      CardTerminalButton(text: '4'),
                      CardTerminalButton(text: '5'),
                      CardTerminalButton(text: '6'),
                      CardTerminalButton(text: '7'),
                      CardTerminalButton(text: '8'),
                      CardTerminalButton(text: '9'),
                      CardTerminalButton(
                          text:
                              '*${NumberFormat.decimalPattern(context.locale.toString()).symbols.DECIMAL_SEP}'),
                      CardTerminalButton(text: '0'),
                      CardTerminalButton(text: '#'),
                      CardTerminalButton(bgColor: const Color(0xFFCD303D)),
                      CardTerminalButton(bgColor: const Color(0xFFF7E378)),
                      CardTerminalButton(bgColor: const Color(0xFF36B649)),
                    ])),
          ],
        ),
      ),
    );
  }
}
