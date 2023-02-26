import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PayContactSearchBar extends StatefulWidget {
  const PayContactSearchBar({super.key});

  @override
  State<PayContactSearchBar> createState() => _PayContactSearchBarState();
}

class _PayContactSearchBarState extends State<PayContactSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // color: Colors.grey[200],
      height: 60,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.search),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              decoration:
                  InputDecoration.collapsed(hintText: tr('search_user')),
            ),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Acción a realizar al presionar el botón de escanear código de barras
            },
          ),
        ],
      ),
    );
  }
}
