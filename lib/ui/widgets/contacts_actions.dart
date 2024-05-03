import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../data/models/payment_cubit.dart';
import '../../g1/g1_helper.dart';
import '../contacts_cache.dart';
import '../ui_helpers.dart';
import 'third_screen/contact_form_dialog.dart';

void onEditContact(BuildContext context, Contact contact) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactFormDialog(
          contact: contact,
          onSave: (Contact c) {
            context.read<ContactsCubit>().updateContact(c);
            ContactsCache().saveContact(c);
          });
    },
  );
}

void onDeleteContact(BuildContext context, Contact contact) {
  context.read<ContactsCubit>().removeContact(contact);
}

void onShowContactQr(BuildContext context, Contact contact) {
  showQrDialog(
      context: context,
      publicKey: getFullPubKey(contact.pubKey),
      noTitle: true,
      feedbackText: 'some_key_copied_to_clipboard');
}

void onSentContact(BuildContext c, Contact contact) {
  c.read<PaymentCubit>().selectUser(contact);
  c.read<BottomNavCubit>().updateIndex(0);
}

void addContact(
    ContactsCubit contactsCubit, Contact newContact, BuildContext context) {
  contactsCubit.addContact(newContact);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(tr('contact_added')),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactFormDialog(
          contact: newContact,
          onSave: (Contact c) {
            context.read<ContactsCubit>().updateContact(c);
            ContactsCache().saveContact(c);
          });
    },
  );
}
