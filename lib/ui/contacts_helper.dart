import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/contact.dart';
import '../data/models/contact_cubit.dart';
import 'contacts_cache.dart';

Future<Contact> retrieveContactFromCubitOrCache(
    ContactsCubit contactsCubit, String pubKey) async {
  if (pubKey.isEmpty) {
    throw Exception('Empty pubKey provided');
  }
  final Contact? cubitContact = contactsCubit.getContact(pubKey);
  return cubitContact ?? await ContactsCache().getContact(pubKey);
}

Future<List<Contact>> enrichContacts(
    BuildContext context, List<Contact> contacts) async {
  final ContactsCubit contactsCubit = context.read<ContactsCubit>();
  final Set<Contact> newContacts = <Contact>{};
  for (final Contact contact in contacts) {
    Contact contactNew =
        await retrieveContactFromCubitOrCache(contactsCubit, contact.pubKey);

    // Preserve createdOn from original contact if enriched contact doesn't have it
    if (contact.createdOn != null && contactNew.createdOn == null) {
      contactNew = contactNew.copyWith(createdOn: contact.createdOn);
    }

    newContacts.add(contactNew);
  }
  return newContacts.toList();
}
