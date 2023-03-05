import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'contact_search_dialog.dart';

class PayContactSearchWidget extends StatefulWidget {
  const PayContactSearchWidget({super.key});

  @override
  State<PayContactSearchWidget> createState() => _PayContactSearchWidgetState();
}

class _PayContactSearchWidgetState extends State<PayContactSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SearchDialog();
          },
        );
      },
      icon: Row(
        children: <Widget>[
          const Icon(Icons.search),
          const SizedBox(width: 8.0),
          Text(tr('search_user_btn')),
        ],
      ),
      label: const Icon(Icons.qr_code_scanner),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60.0),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}
