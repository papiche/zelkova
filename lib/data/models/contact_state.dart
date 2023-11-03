import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'contact.dart';
import 'contact_sort_type.dart';

@immutable
class ContactsState extends Equatable {
  const ContactsState(
      {this.contacts = const <Contact>[],
      this.filteredContacts = const <Contact>[],
      this.order = ContactsSortType.date});

  final List<Contact> contacts;
  final List<Contact> filteredContacts;
  final ContactsSortType order;

  @override
  List<Object?> get props => <Object>[contacts, filteredContacts, order];

  ContactsState copyWith(
      {List<Contact>? contacts,
      List<Contact>? filteredContacts,
      ContactsSortType? order}) {
    return ContactsState(
        contacts: contacts ?? this.contacts,
        filteredContacts: filteredContacts ?? this.filteredContacts,
        order: order ?? this.order);
  }

  @override
  String toString() {
    return 'ContactsState(contacts: $contacts, filteredContacts: $filteredContacts)';
  }
}
