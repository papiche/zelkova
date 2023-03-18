import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'contact.dart';

@immutable
class ContactsState extends Equatable {
  const ContactsState(
      {this.contacts = const <Contact>[],
      this.filteredContacts = const <Contact>[]});

  final List<Contact> contacts;
  final List<Contact> filteredContacts;

  @override
  List<Object?> get props => <Object>[contacts, filteredContacts];

  ContactsState copyWith(
      {List<Contact>? contacts, List<Contact>? filteredContacts}) {
    return ContactsState(
        contacts: contacts ?? this.contacts,
        filteredContacts: filteredContacts ?? this.filteredContacts);
  }

  @override
  String toString() {
    return 'ContactsState(contacts: $contacts, filteredContacts: $filteredContacts)';
  }
}
