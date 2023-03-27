import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/foundation.dart';

import '../data/models/contact.dart';
import '../g1/api.dart';
import 'logger.dart';

class ContactsCache {
  factory ContactsCache() {
    _instance ??= ContactsCache._internal();
    return _instance!;
  }

  ContactsCache._internal();

  static ContactsCache? _instance;
  final Map<String, List<Completer<Contact>>> _pendingRequests =
      <String, List<Completer<Contact>>>{};
  static Duration duration =
      kReleaseMode ? const Duration(days: 3) : const Duration(hours: 5);

  Future<Contact> getContact(String pubKey) async {
    final String cacheKey = _key(pubKey);

    Contact? cachedContact;
    try {
      cachedContact = _retrieveContact(pubKey);
    } catch (e) {
      logger('Error while retrieving contact from cache: $e, $pubKey');
    }

    if (cachedContact != null) {
      if (!kReleaseMode) {
        logger('Returning cached contact $cachedContact');
      }
      return cachedContact;
    } else {
      if (!kReleaseMode) {
        logger('Contact $pubKey not cached');
      }
    }

    if (_pendingRequests.containsKey(pubKey)) {
      final Completer<Contact> completer = Completer<Contact>();
      _pendingRequests[pubKey]!.add(completer);
      return completer.future;
    }

    final Completer<Contact> completer = Completer<Contact>();
    _pendingRequests[pubKey] = <Completer<Contact>>[completer];
    try {
      cachedContact = await getProfile(pubKey);

      final String encodedValue = json.encode(<String, dynamic>{
        'timestamp': DateTime.now().toIso8601String(),
        'data': cachedContact.toJson(),
      });
      window.localStorage[cacheKey] = encodedValue;
      if (!kReleaseMode) {
        //  logger('Returning non cached contact $contact');
      }
      // Send to listeners
      for (final Completer<Contact> completer in _pendingRequests[pubKey]!) {
        completer.complete(cachedContact);
      }
      _pendingRequests.remove(pubKey);

      return cachedContact;
    } catch (e) {
      // Send error to listeners
      for (final Completer<Contact> completer in _pendingRequests[pubKey]!) {
        completer.completeError(e);
      }
      _pendingRequests.remove(pubKey);

      rethrow;
    }
  }

  String _key(String pubKey) => 'contact-$pubKey';

  void addContact(Contact contact) {
    // Get the cached version of the contact, if it exists
    Contact? cachedContact = _retrieveContact(contact.pubKey);

    // Merge the new contact with the cached contact
    if (cachedContact != null) {
      // logger('Merging contact $contact with cached contact $cachedContact');
      cachedContact = cachedContact.merge(contact);
    } else {
      // logger('Adding contact $contact to cache as is not cached');
      cachedContact = contact;
    }

    // Cache the merged contact
    final String encodedValue = json.encode(<String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'data': cachedContact.toJson(),
    });
    window.localStorage[_key(contact.pubKey)] = encodedValue;
    // logger('Added contact $cachedContact to cache');
  }

  Contact? _retrieveContact(String pubKey) {
    final String? cachedValue = window.localStorage[_key(pubKey)];
    if (cachedValue != null) {
      final Map<String, dynamic> decodedValue =
          json.decode(cachedValue) as Map<String, dynamic>;
      final DateTime timestamp =
          DateTime.parse(decodedValue['timestamp'] as String);
      final bool before = DateTime.now().isBefore(timestamp.add(duration));
      if (before) {
        final Contact contact =
            Contact.fromJson(decodedValue['data'] as Map<String, dynamic>);
        if (!kReleaseMode) {
          logger('Returning cached contact $contact');
        }
        return contact;
      }
      // logger('Cached contact $pubKey is expired');
    }
    return null;
  }
}
