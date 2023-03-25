import 'dart:convert';
import 'dart:html';

import 'package:flutter/foundation.dart';

import '../data/models/contact.dart';
import '../g1/api.dart';
import 'logger.dart';

class ContactsCacheBasic {
  factory ContactsCacheBasic() {
    _instance ??= ContactsCacheBasic._internal();
    return _instance!;
  }

  ContactsCacheBasic._internal();

  static ContactsCacheBasic? _instance;

  final Map<String, Contact> _cache = <String, Contact>{};

  Future<Contact> getContact(String pubKey) async {
    final String cacheKey = 'avatar-$pubKey';

    final Contact? cachedContact = _cache[cacheKey];
    if (cachedContact != null) {
      return cachedContact;
    }

    final Contact contact = await getProfile(pubKey);

    _cache[cacheKey] = contact;

    return contact;
  }
}

class ContactsCache {
  factory ContactsCache() {
    _instance ??= ContactsCache._internal();
    return _instance!;
  }

  ContactsCache._internal();

  static ContactsCache? _instance;

  Future<Contact> getContact(String pubKey) async {
    final String cacheKey = 'avatar-$pubKey';
    const Duration duration = Duration(days: 3);

    try {
      final String? cachedValue = window.localStorage[cacheKey];
      if (cachedValue != null) {
        final Map<String, dynamic> decodedValue =
        json.decode(cachedValue) as Map<String, dynamic>;
        final DateTime timestamp =
        DateTime.parse(decodedValue['timestamp'] as String);

        if (DateTime.now().isBefore(timestamp.add(duration))) {
          final Contact contact =
          Contact.fromJson(decodedValue['data'] as Map<String, dynamic>);
          if (!kReleaseMode) {
            logger('Returning cached contact $contact');
          }
          return contact;
        }
      }
    } catch (e) {
      logger('Error while retrieving contact from cache: $e, $pubKey');
    }

    final Contact contact = await getProfile(pubKey);

    final String encodedValue = json.encode(<String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'data': contact.toJson(),
    });
    window.localStorage[cacheKey] = encodedValue;
    if (!kReleaseMode) {
      logger('Returning non cached contact $contact');
    }
    return contact;
  }
}
