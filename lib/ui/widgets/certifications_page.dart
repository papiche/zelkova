import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/cert.dart';
import '../../data/models/contact.dart';
import '../contact_list_item.dart';
import 'contacts_actions.dart';

class CertificationsPage extends StatelessWidget {
  const CertificationsPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.certifications,
      required this.currentBlockHeight,
      required this.issued});

  final String title;
  final String subtitle;
  final bool issued;
  final int currentBlockHeight;
  final List<Cert> certifications;
  static const int limit = 201600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                title: Text(
                  '$subtitle (${certifications.length})',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: certifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Cert cert = certifications[index];
                    final Contact contact =
                        issued ? cert.receiverId : cert.issuerId;
                    final bool isExpired = cert.expireOn <= currentBlockHeight;
                    final bool isExpiringSoon = cert.isActive &&
                        (cert.expireOn - currentBlockHeight < limit);
                    final bool isMember = contact.isMember ?? false;
                    /* final DateTime updateOn = estimateDateFromBlock(
                        futureBlock: cert.updatedOn,
                        currentBlockHeight: currentBlockHeight); */
                    /* final String certDate = humanizeTimeFull(
                        locale: currentLocale(context), utcDateTime: updateOn); */
                    final String statusMsg =
                        tr('idty_status_${contact.status!.name}');
                    return ContactListItem(
                        contact: contact,
                        // subtitleExtra: statusMsg,
                        index: index,
                        isV2: true,
                        onTap: () {
                          showContactPage(context, contact);
                        },
                        trailing: Tooltip(
                            message: statusMsg,
                            child: Icon(
                              isMember
                                  ? isExpiringSoon
                                      ? Icons.timelapse
                                      : Icons.check_circle_outline
                                  : Icons.warning_amber_outlined,
                              color: isMember
                                  ? isExpiringSoon
                                      ? Colors.orange.shade300
                                      : Theme.of(context).colorScheme.primary
                                  : Colors.red.shade300,
                            )));
                  },
                ),
              )
            ]));
  }
}
