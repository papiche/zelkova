import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../data/models/contact.dart';
import '../g1/api.dart';
import 'logger.dart';

class ContactsCache {
  factory ContactsCache() {
    _instance ??= ContactsCache._internal();
    return _instance!;
  }

  ContactsCache._internal();

  Box<dynamic>? _box;

  Future<void> init() async {
    if (kIsWeb) {
      _box = await Hive.openBox(_boxName);
    } else {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      _box = await Hive.openBox(_boxName, path: appDocPath);
    }
  }

  Future<void> dispose() async {
    await _box?.close();
  }

  static ContactsCache? _instance;
  final Map<String, List<Completer<Contact>>> _pendingRequests =
      <String, List<Completer<Contact>>>{};
  static Duration duration =
      kReleaseMode ? const Duration(days: 3) : const Duration(hours: 5);

  final String _boxName = 'contacts_cache';

  Box<dynamic> _openBox() {
    return _box!;
  }

  Future<Contact> getContact(String pubKey) async {
    Contact? cachedContact;
    try {
      cachedContact = await _retrieveContact(pubKey);
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
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
      storeContact(cachedContact);
      if (!kReleaseMode) {
        //  logger('Returning non cached contact $contact');
      }
      // Send to listeners
      for (final Completer<Contact> completer in _pendingRequests[pubKey]!) {
        completer.complete(cachedContact);
      }
      _pendingRequests.remove(pubKey);

      return cachedContact;
    } catch (e, stackTrace) {
      // Send error to listeners
      for (final Completer<Contact> completer in _pendingRequests[pubKey]!) {
        completer.completeError(e);
      }
      _pendingRequests.remove(pubKey);
      await Sentry.captureException(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> saveContact(Contact contact) async => addContact(contact);

  Future<void> addContact(Contact contact) async {
    // Get the cached version of the contact, if it exists
    Contact? cachedContact = await _retrieveContact(contact.pubKey);

    // Merge the new contact with the cached contact
    if (cachedContact != null) {
      // logger('Merging contact $contact with cached contact $cachedContact');
      cachedContact = cachedContact.merge(contact);
    } else {
      // logger('Adding contact $contact to cache as is not cached');
      cachedContact = contact;
    }

    // Cache the merged contact
    // Cache the merged contact
    await storeContact(cachedContact);

    // logger('Added contact $cachedContact to cache');
  }

  Future<void> storeContact(Contact contact) async {
    final Box<dynamic> box = _openBox();
    await box.put(contact.pubKey, <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'data': json.encode(contact.toJson()),
    });
  }

  Future<Contact?> _retrieveContact(String pubKey) async {
    final Box<dynamic> box = _openBox();
    final dynamic record = box.get(pubKey);

    if (record != null) {
      final Map<String, dynamic> typedRecord =
          Map<String, dynamic>.from(record as Map<dynamic, dynamic>);
      final DateTime timestamp =
          DateTime.parse(typedRecord['timestamp'] as String);
      final bool before = DateTime.now().isBefore(timestamp.add(duration));
      if (before) {
        final Contact contact = Contact.fromJson(
            json.decode(typedRecord['data'] as String) as Map<String, dynamic>);
        return contact;
      }
    }
    return null;
  }
}
