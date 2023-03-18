import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'contact.dart';
import 'contact_state.dart';

class ContactsCubit extends HydratedCubit<ContactsState> {
  ContactsCubit() : super(const ContactsState());

  void addContact(Contact contact) {
    if (!state.contacts.contains(contact)) {
      emit(state.copyWith(contacts: <Contact>[...state.contacts, contact]));
    }
  }

  void removeContact(Contact contact) {
    final List<Contact> contactsTruncated = state.contacts
        .where((Contact c) => c.pubkey != contact.pubkey)
        .toList();
    final List<Contact> filteredContactsTruncated = state.filteredContacts
        .where((Contact c) => c.pubkey != contact.pubkey)
        .toList();
    emit(state.copyWith(
        contacts: contactsTruncated,
        filteredContacts: filteredContactsTruncated));
  }

  void updateContact(Contact contact) {
    final List<Contact> contacts = state.contacts.map((Contact c) {
      if (c.pubkey == contact.pubkey) {
        return contact;
      }
      return c;
    }).toList();
    emit(state.copyWith(contacts: contacts));
  }

  void resetFilter() {
    emit(state.copyWith(filteredContacts: state.contacts));
  }

  void filterContacts(String query) {
    final List<Contact> contacts = state.contacts.where((Contact c) {
      if (c.pubkey.contains(query)) {
        return true;
      }
      if (c.nick != null && c.nick!.contains(query)) {
        return true;
      }
      if (c.name != null && c.name!.contains(query)) {
        return true;
      }
      if (c.notes != null && c.notes!.contains(query)) {
        return true;
      }
      return false;
    }).toList();
    emit(state.copyWith(filteredContacts: contacts));
  }

  List<Contact> get contacts => state.contacts;

  List<Contact> get filteredContacts => state.filteredContacts;

  @override
  ContactsState fromJson(Map<String, dynamic> json) {
    final List<dynamic> contactsJson = json['contacts'] as List<dynamic>;
    final List<Contact> contacts = contactsJson
        .map((dynamic c) => Contact.fromJson(c as Map<String, dynamic>))
        .toList();
    return ContactsState(contacts: contacts);
  }

  @override
  Map<String, dynamic> toJson(ContactsState state) {
    final List<Map<String, dynamic>> contactsJson =
        state.contacts.map((Contact c) => c.toJson()).toList();
    return <String, dynamic>{'contacts': contactsJson};
  }

  @override
  String get id => 'contacts';

  bool isContact(String pubKey) =>
      state.contacts.any((Contact c) => c.pubkey == pubKey);
}
