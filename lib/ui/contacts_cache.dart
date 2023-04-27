import 'dart:async';
import 'dart:collection';
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

  Future<void> _init() async {
    try {
      if (kIsWeb) {
        _box = await Hive.openBox(_boxName);
      } else {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String appDocPath = appDocDir.path;
        _box = await Hive.openBox(_boxName, path: appDocPath);
      }
    } catch (e) {
      logger('Error opening Hive: $e');
    }
    _box ??= MemoryFallbackBox<Map<String, dynamic>>();
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

  Future<Box<dynamic>> _openBox() async {
    if (_box == null) {
     await _init();
    }
    return _box!;
  }

  Future<Contact> getContact(String pubKey, [bool debug = false]) async {
    Contact? cachedContact;
    try {
      cachedContact = await _retrieveContact(pubKey);
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      logger('Error while retrieving contact from cache: $e, $pubKey');
    }

    if (cachedContact != null) {
      if (!kReleaseMode && debug) {
        logger('Returning cached contact $cachedContact');
      }
      return cachedContact;
    } else {
      if (!kReleaseMode && debug) {
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
      if (!kReleaseMode && debug) {
        logger('Returning non cached contact $cachedContact');
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
    final Box<dynamic> box = await _openBox();
    await box.put(contact.pubKey, <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'data': json.encode(contact.toJson()),
    });
  }

  Future<Contact?> _retrieveContact(String pubKey) async {
    final Box<dynamic> box = await _openBox();
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

class MemoryFallbackBox<E> extends Box<E> {
  final Map<String, dynamic> _storage = HashMap<String, dynamic>();

  @override
  String get name => '_memory_fallback_box';

  @override
  bool get isOpen => true;

  @override
  String? get path => null;

  @override
  bool get lazy => false;

  @override
  Iterable<dynamic> get keys => _storage.keys;

  @override
  int get length => _storage.length;

  @override
  bool get isEmpty => _storage.isEmpty;

  @override
  bool get isNotEmpty => _storage.isNotEmpty;

  @override
  dynamic keyAt(int index) {
    return _storage.keys.elementAt(index);
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    throw UnimplementedError('watch() is not supported in _MemoryFallbackBox');
  }

  @override
  bool containsKey(dynamic key) {
    return _storage.containsKey(key);
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    _storage[key as String] = value;
  }

  @override
  Future<void> putAt(int index, dynamic value) async {
    _storage[_storage.keys.elementAt(index)] = value;
  }

  @override
  Future<void> putAll(Map<dynamic, dynamic> entries) async {
    _storage.addAll(entries as Map<String, dynamic>);
  }

  @override
  Future<int> add(E value) async {
    throw UnimplementedError('add() is not supported in _MemoryFallbackBox');
  }

  @override
  Future<Iterable<int>> addAll(Iterable<E> values) async {
    throw UnimplementedError('addAll() is not supported in _MemoryFallbackBox');
  }

  @override
  Future<void> delete(dynamic key) async {
    _storage.remove(key);
  }

  @override
  Future<void> deleteAt(int index) async {
    _storage.remove(_storage.keys.elementAt(index));
  }

  @override
  Future<void> deleteAll(Iterable<dynamic> keys) async {
    // ignore: prefer_foreach
    for (final dynamic key in keys) {
      _storage.remove(key);
    }
  }

  @override
  Future<void> compact() async {}

  @override
  Future<int> clear() async {
    final int count = _storage.length;
    _storage.clear();
    return count;
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> deleteFromDisk() async {}

  @override
  Future<void> flush() async {}

  @override
  E? get(dynamic key, {E? defaultValue}) {
    return _storage.containsKey(key) ? _storage[key] as E : defaultValue;
  }

  @override
  E? getAt(int index) {
    return _storage.values.elementAt(index) as E?;
  }

  @override
  Map<dynamic, E> toMap() {
    return Map<dynamic, E>.from(_storage);
  }

  @override
  Iterable<E> get values => _storage.values.cast<E>();

  @override
  Iterable<E> valuesBetween({dynamic startKey, dynamic endKey}) {
    if (startKey == null && endKey == null) {
      return values;
    }

    final int startIndex = startKey != null
        ? _storage.keys.toList().indexOf(startKey as String)
        : 0;
    final int endIndex = endKey != null
        ? _storage.keys.toList().indexOf(endKey as String)
        : _storage.length - 1;

    if (startIndex < 0 || endIndex < 0) {
      throw ArgumentError('Start key or end key not found in the box.');
    }

    return _storage.values
        .skip(startIndex)
        .take(endIndex - startIndex + 1)
        .cast<E>();
  }
}
