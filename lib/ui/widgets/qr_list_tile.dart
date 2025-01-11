import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../g1/g1_helper.dart';
import '../ui_helpers.dart';

class QrListTile extends StatelessWidget {
  const QrListTile(
      {super.key, required this.pubKeyOrAddress, required this.isV2});

  final String pubKeyOrAddress;
  final bool isV2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showQrDialog(
              context: context,
              pubKeyOrAddress: pubKeyOrAddress,
              isV2: isV2,
              noTitle: true,
              feedbackText: 'some_key_copied_to_clipboard');
        },
        child: ListTile(
            leading: const Icon(Icons.key),
            trailing: !isV2
                ? const Icon(Icons.qr_code)
                : const Badge(
                    label: Text('v2'),
                    child: Icon(Icons.qr_code),
                  ),
            title: Text(!isV2
                ? tr('form_contact_pub_key')
                : tr('form_contact_address_v2')),
            subtitle: Text(!isV2
                ? humanizePubKey(pubKeyOrAddress)
                : humanizeAddress(pubKeyOrAddress))));
  }
}
