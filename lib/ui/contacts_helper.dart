import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/contact.dart';
import '../data/models/contact_cubit.dart';
import 'contacts_cache.dart';

Future<Contact> retrieveContactFromCubitOrCache(
    ContactsCubit contactsCubit, String pubKey) async {
  final Contact? cubitContact = contactsCubit.getContact(pubKey);
  return cubitContact ?? await ContactsCache().getContact(pubKey);
}

Future<List<Contact>> enrichContacts(
    BuildContext context, List<Contact> contacts) async {
  final ContactsCubit contactsCubit = context.read<ContactsCubit>();
  final Set<Contact> newContacts = <Contact>{};
  for (final Contact contact in contacts) {
    final Contact contactNew =
        await retrieveContactFromCubitOrCache(contactsCubit, contact.pubKey);
    newContacts.add(contactNew);
  }
  return newContacts.toList();
}
