import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../ui_helpers.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 320.0,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.deepPurple[800]!,
              Colors.purple[500]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tr('g1_wallet'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () => showTooltip(context, '',
                  'Tu monedero dispone de una clave pública y una privada que sería esta que no debes mostrar a nadie. La clave privada aún así se puede obtener en las opciones avanzadas.'),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '**** **** **** G7VT',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      // decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => showTooltip(context, '',
                    'Este monedero funcionará mientras funcione este navegador y este dispositivo'),
                child: Text(
                  'Validez',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.0,
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
