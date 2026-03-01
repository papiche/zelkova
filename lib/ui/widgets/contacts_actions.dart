import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../data/models/payment_cubit.dart';
import '../../shared_prefs_helper.dart';
import '../contacts_cache.dart';
import '../qr_helper.dart';
import 'contact_page.dart';
import 'first_screen/contact_search_page.dart'
    show ContactSearchPage, SearchUse;
import 'third_screen/contact_form_dialog.dart';

void onEditContact(BuildContext context, Contact contact) {
  // Get the latest version of the contact from ContactsCubit
  final ContactsCubit contactsCubit = context.read<ContactsCubit>();
  final Contact? updatedContact = contactsCubit.state.contacts
      .where((Contact c) => c.pubKey == contact.pubKey)
      .firstOrNull;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactFormDialog(
          // Use the updated contact from cubit if available, otherwise use the passed contact
          contact: updatedContact ?? contact,
          onSave: (Contact c) {
            contactsCubit.updateContact(c);
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
      isV2: false,
      pubKeyOrAddress: contact.pubKey,
      noTitle: true,
      feedbackText: 'some_key_copied_to_clipboard');
}

void showMyContactPage(BuildContext context) {
  showContactPage(
      context, Contact(pubKey: SharedPreferencesHelper().getPubKey()));
}

void showContactPage(BuildContext context, Contact contact) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactPage(contact: contact);
    },
  );
}

void onSentContact(BuildContext context, Contact contact) {
  context.read<PaymentCubit>().selectUser(contact);
  Future<void>.delayed(const Duration(milliseconds: 100), () {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    context.read<BottomNavCubit>().updateIndex(0);
  });
}

void addContact(BuildContext context, Contact newContact) {
  final ContactsCubit contactsCubit = context.read<ContactsCubit>();
  contactsCubit.addContact(newContact);
  // Get ScaffoldMessenger before showing dialog to avoid using deactivated context
  final ScaffoldMessengerState scaffoldMessenger =
      ScaffoldMessenger.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactFormDialog(
          contact: newContact,
          onSave: (Contact c) {
            contactsCubit.updateContact(c);
            ContactsCache().saveContact(c);
            // Use the scaffoldMessenger reference instead of context
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(tr('contact_added')),
              ),
            );
          });
    },
  );
}

void searchForContactsGlobally(BuildContext context, {String? search}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ContactSearchPage(
          searchUse: SearchUse.contactSearch, initialSearch: search);
    },
  );
}
