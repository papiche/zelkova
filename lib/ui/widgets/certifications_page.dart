import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/cert.dart';
import '../../data/models/contact.dart';
import '../contact_list_item.dart';
import '../ui_helpers.dart';
import 'contacts_actions.dart';

class CertificationsPage extends StatelessWidget {
  const CertificationsPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.certifications,
      required this.issued});

  final String title;
  final String subtitle;
  final bool issued;
  final List<Cert> certifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.fromLTRB(75, 10, 0, 10),
                child: Text(
                  '$subtitle (${certifications.length})',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        //fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: certifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Cert cert = certifications[index];
                    final Contact contact =
                        issued ? cert.receiverId : cert.issuerId;
                    // FIXME I don't know how to calculate the cert date
                    String? certDate = inDevelopment
                        ? humanizeTimeFull(
                            utcDateTime: DateTime.now()
                                .add(Duration(seconds: cert.updatedOn)),
                            locale: currentLocale(context))
                        : null;
                    certDate = null;
                    return ContactListItem(
                        contact: contact,
                        subtitleExtra: certDate,
                        index: index,
                        isV2: true,
                        onTap: () {
                          showContactPage(context, contact);
                        },
                        trailing: cert.expireOn > 0
                            ? Text(humanizeTimeFuture(
                                    currentLocale(context), cert.expireOn) ??
                                '')
                            : Text(tr('cert_expired')));
                  },
                ),
              )
            ]));
  }
}
