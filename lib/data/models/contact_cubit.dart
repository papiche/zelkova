import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../g1/g1_helper.dart';
import '../../ui/contacts_cache.dart';
import '../../ui/ui_helpers.dart';
import 'contact.dart';
import 'contact_sort_type.dart';
import 'contact_state.dart';

class ContactsCubit extends HydratedCubit<ContactsState> {
  ContactsCubit() : super(const ContactsState());

  @override
  String get storagePrefix => kIsWeb ? 'ContactsCubit' : super.storagePrefix;

  Contact? _find(Contact contact) {
    try {
      return state.contacts
          .firstWhere((Contact c) => c.pubKey == contact.pubKey);
    } catch (e) {
      return null;
    }
  }

  void addContact(Contact contact) {
    final Contact? nFound = _find(contact);
    if (nFound == null) {
      final List<Contact> updatedContacts = List<Contact>.from(state.contacts)
        ..add(contact);

      List<Contact> updatedFilteredContacts;
      if (state.order == ContactsSortType.alpha) {
        updatedFilteredContacts = List<Contact>.from(state.filteredContacts)
          ..add(contact);
        sortContactList(updatedFilteredContacts);
      } else {
        updatedFilteredContacts = updatedContacts;
      }

      emit(state.copyWith(
        contacts: updatedContacts,
        filteredContacts: updatedFilteredContacts,
      ));
    }
    ContactsCache().addContact(contact);
  }

  void removeContact(Contact contact) {
    final List<Contact> contactsTruncated = state.contacts
        .where((Contact c) => c.pubKey != contact.pubKey)
        .toList();
    final List<Contact> filteredContactsTruncated = state.filteredContacts
        .where((Contact c) => c.pubKey != contact.pubKey)
        .toList();
    emit(state.copyWith(
        contacts: contactsTruncated,
        filteredContacts: filteredContactsTruncated));
  }

  Future<List<Contact>> _resizeAvatars(List<Contact> list) async {
    final List<Contact> newList = <Contact>[];
    for (final Contact c in list) {
      if (c.avatar != null) {
        final Contact newC = c.copyWith(avatar: await resizeAvatar(c.avatar!));
        newList.add(newC);
      } else {
        newList.add(c);
      }
    }
    return newList;
  }

  Future<void> resizeAvatars() async {
    final List<Contact> contactsCompressed =
        await _resizeAvatars(state.contacts);
    final List<Contact> filteredContactsCompressed =
        await _resizeAvatars(state.filteredContacts);
    emit(state.copyWith(
        contacts: contactsCompressed,
        filteredContacts: filteredContactsCompressed));
  }

  void updateContact(Contact contact) {
    final List<Contact> contacts = state.contacts.map((Contact c) {
      if (c.pubKey == contact.pubKey ||
          c.pubKey == extractPublicKey(contact.pubKey)) {
        return contact;
      }
      return c;
    }).toList();
    final List<Contact> fcontacts = state.filteredContacts.map((Contact c) {
      if (c.pubKey == contact.pubKey ||
          c.pubKey == extractPublicKey(contact.pubKey)) {
        return contact;
      }
      return c;
    }).toList();
    ContactsCache().addContact(contact);
    emit(state.copyWith(contacts: contacts, filteredContacts: fcontacts));
  }

  void resetFilter() {
    emit(state.copyWith(filteredContacts: state.contacts));
  }

  void filterContacts(String query) {
    final List<Contact> contacts = search(query);
    emit(state.copyWith(filteredContacts: contacts));
  }

  ContactsSortType get order => state.order;

  void sortContactsAsStored() {
    sortContacts(order);
  }

  void sortContacts(ContactsSortType sortOrder) {
    List<Contact> sortedContacts = List<Contact>.from(state.filteredContacts);

    if (sortOrder == ContactsSortType.alpha) {
      sortContactList(sortedContacts);
    } else if (sortOrder == ContactsSortType.date) {
      sortedContacts = List<Contact>.from(state.contacts).where((Contact c) {
        return state.filteredContacts
            .any((Contact fc) => fc.pubKey == c.pubKey);
      }).toList();
    }

    emit(state.copyWith(filteredContacts: sortedContacts, order: sortOrder));
  }

  void sortContactList(List<Contact> sortedContacts) {
    sortedContacts.sort((Contact a, Contact b) => a.title.compareTo(b.title));
  }

  List<Contact> search(String initialQuery) {
    final String query = normalizeQuery(initialQuery);
    if (query.isEmpty) {
      return state.contacts;
    }
    final String queryLower = query.toLowerCase();
    final String queryUpper =
        queryLower[0].toUpperCase() + queryLower.substring(1);
    final List<Contact> contacts = state.contacts.where((Contact c) {
      if (c.pubKey.contains(query)) {
        return true;
      }
      if (c.pubKey.contains(extractPublicKey(query))) {
        return true;
      }
      if (c.nick != null &&
          containsLowerOrUpper(c.nick!, query, queryLower, queryUpper)) {
        return true;
      }
      if (c.name != null &&
          containsLowerOrUpper(c.name!, query, queryLower, queryUpper)) {
        return true;
      }
      if (c.notes != null &&
          containsLowerOrUpper(c.notes!, query, queryLower, queryUpper)) {
        return true;
      }
      return false;
    }).toList();
    return contacts;
  }

  bool containsLowerOrUpper(
          String text, String query, String queryLower, String queryUpper) =>
      text.contains(query) ||
      text.contains(queryLower) ||
      text.contains(queryUpper);

  List<Contact> get contacts => state.contacts;

  List<Contact> get filteredContacts => state.filteredContacts;

  @override
  ContactsState fromJson(Map<String, dynamic> json) {
    final dynamic cJson = json['contacts'];
    if (cJson == null) {
      return const ContactsState();
    } else {
      final List<dynamic> contactsJson = cJson as List<dynamic>;
      final List<Contact> contacts = contactsJson
          .map((dynamic c) => Contact.fromJson(c as Map<String, dynamic>))
          .toList();
      return ContactsState(contacts: contacts);
    }
  }

  @override
  Map<String, dynamic> toJson(ContactsState state) {
    final List<Map<String, dynamic>> contactsJson =
        state.contacts.map((Contact c) => c.toJson()).toList();
    return <String, dynamic>{'contacts': contactsJson};
  }

  @override
  String get id => 'contacts';

  bool isContact(String pubKey) => state.contacts.any(
      (Contact c) => extractPublicKey(c.pubKey) == extractPublicKey(pubKey));

  Contact? getContact(String pubKey) => isContact(pubKey)
      ? state.contacts.firstWhere(
          (Contact c) => extractPublicKey(c.pubKey) == extractPublicKey(pubKey))
      : null;
}
