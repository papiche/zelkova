import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../contacts_cache.dart';
import '../third_screen/contact_form_dialog.dart';

class ContactFavIcon extends StatelessWidget {
  const ContactFavIcon({
    super.key,
    required this.contact,
    required this.contactsCubit,
    this.paymentCubit,
  });

  final ContactsCubit contactsCubit;
  final Contact contact;
  final PaymentCubit? paymentCubit;

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = contactsCubit.isContact(contact.pubKey);
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red.shade400 : null,
        ),
        onPressed: () {
          if (!isFavorite) {
            contactsCubit.addContact(contact);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('contact_added')),
              ),
            );
            if (contact.name == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ContactFormDialog(
                      contact: contact,
                      onSave: (Contact c) {
                        context.read<ContactsCubit>().updateContact(c);
                        if (paymentCubit != null) {
                          paymentCubit!.selectUser(c);
                        }
                        ContactsCache().saveContact(c);
                      });
                },
              );
            }
          } else {
            contactsCubit.removeContact(Contact(
              pubKey: contact.pubKey,
            ));
          }
        });
  }
}
