import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../data/models/contact.dart';
import '../g1/api.dart';
import '../g1/g1_helper.dart';
import 'logger.dart';
import 'ui_helpers.dart';

class ContactsCache {
  factory ContactsCache() {
    _instance ??= ContactsCache._internal();
    return _instance!;
  }

  ContactsCache._internal();

  Box<dynamic>? box;

  /// Lifecycle flags to prevent race conditions during disposal
  bool _isDisposing = false;
  bool _isDisposed = false;

  /// Check if the Hive box is available and safe to use
  bool _isBoxOpen() {
    final bool isOpen =
        box != null && box!.isOpen && !_isDisposing && !_isDisposed;
    if (!isOpen) {
      loggerDev(
          '[ContactsCache] Box not available: box=$box, isOpen=${box?.isOpen}, '
          '_isDisposing=$_isDisposing, _isDisposed=$_isDisposed');
    }
    return isOpen;
  }

  Future<void> init([bool test = false]) async {
    if (test) {
      box = MemoryFallbackBox<Map<String, dynamic>>();
      return;
    }
    try {
      if (kIsWeb) {
        box = await Hive.openBox(_boxName);
      } else {
        final Directory appDataDir = await getAppDataDirectory();
        final String appDataPath = appDataDir.path;
        box = await Hive.openBox(_boxName, path: appDataPath);
      }
      // We clear the box on every startup to avoid issues with old data
    } catch (e) {
      logger('Error opening Hive: $e');
    }
    box ??= MemoryFallbackBox<Map<String, dynamic>>();
  }

  Future<void> addContacts(List<Contact> contacts) async {
    for (final Contact contact in contacts) {
      await addContact(contact);
    }
  }

  Future<void> dispose() async {
    if (_isDisposed) {
      logger('[ContactsCache] Already disposed, skipping dispose');
      return;
    }

    _isDisposing = true;
    logger('[ContactsCache] Starting disposal...');

    try {
      await box?.close();
      logger('[ContactsCache] Hive box closed successfully');
    } catch (e) {
      logger('[ContactsCache] Error closing Hive box: $e');
    }

    _isDisposed = true;
    logger('[ContactsCache] Disposal complete');
  }

  Future<void> clear() async {
    if (!_isBoxOpen()) {
      logger('[ContactsCache] Cannot clear, box is not available');
      return;
    }
    await box?.clear();
  }

  Future<void> removeContact(String pubKey) async {
    if (!_isBoxOpen()) {
      logger('[ContactsCache] Cannot remove contact, box is not available');
      return;
    }
    await box?.delete(pubKey);
  }

  static ContactsCache? _instance;

  /// Reset the singleton instance (for testing purposes only)
  static void resetInstance() {
    _instance = null;
  }

  final Map<String, List<Completer<Contact>>> _pendingRequests =
      <String, List<Completer<Contact>>>{};
  final Map<String, DateTime> _failedRequests = <String, DateTime>{};

  final String _boxName = 'contacts_cache';

  Contact? getCachedContact(String pubKey,
      [bool debug = false, bool withoutAvatar = false]) {
    return withoutAvatar
        ? _retrieveContact(pubKey)?.cloneWithoutAvatar()
        : _retrieveContact(pubKey);
  }

  Future<Contact> getContact(String pubKey, [bool debug = false]) async {
    Contact? cachedContact;
    try {
      cachedContact = _retrieveContact(pubKey);
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

    if (_failedRequests.containsKey(pubKey)) {
      final DateTime failedTime = _failedRequests[pubKey]!;
      if (DateTime.now().difference(failedTime) < const Duration(minutes: 5)) {
        if (!kReleaseMode && debug) {
          logger('Returning cached failure for $pubKey');
        }
        return Contact(pubKey: pubKey);
      } else {
        _failedRequests.remove(pubKey);
      }
    }

    final Completer<Contact> completer = Completer<Contact>();
    _pendingRequests[pubKey] = <Completer<Contact>>[completer];
    try {
      cachedContact = await getProfile(pubKey, complete: false);
      _storeContact(cachedContact);
      if (!kReleaseMode && debug) {
        logger('Returning non cached contact $cachedContact');
      }
      // Send to listeners
      final List<Completer<Contact>>? pending = _pendingRequests.remove(pubKey);
      if (pending != null) {
        for (final Completer<Contact> completer in pending) {
          completer.complete(cachedContact);
        }
      }

      return cachedContact;
    } catch (e, stackTrace) {
      // If it's a 404 or other fetch error, cache it for a while
      _failedRequests[pubKey] = DateTime.now();

      // Send error to listeners
      final List<Completer<Contact>>? pending = _pendingRequests.remove(pubKey);
      if (pending != null) {
        for (final Completer<Contact> completer in pending) {
          // Return an empty contact instead of an error to avoid breaking UI flows
          completer.complete(Contact(pubKey: pubKey));
        }
      }
      if (e is! Exception || !e.toString().contains('404')) {
        await Sentry.captureException(e, stackTrace: stackTrace);
      }
      return Contact(pubKey: pubKey);
    }
  }

  Future<void> saveContact(Contact contact) async => addContact(contact);

  Future<void> addAllContacts(List<Contact> contacts) async {
    for (final Contact contact in contacts) {
      await addContact(contact);
    }
  }

  Future<void> addContact(Contact contactRaw) async {
    if (_isDisposing || _isDisposed) {
      logger('[ContactsCache.addContact] Skipping add, cache is '
          'disposing/disposed. Contact: ${contactRaw.pubKey}');
      return;
    }

    // Get the cached version of the contact, if it exists
    final Contact contact =
        contactRaw.copyWith(pubKey: extractPublicKey(contactRaw.pubKey));
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
    // Cache the merged contact
    await _storeContact(cachedContact);

    // logger('Added contact $cachedContact to cache');
  }

  Future<void> _storeContact(Contact contact) async {
    if (!_isBoxOpen()) {
      logger(
          '[ContactsCache._storeContact] Cannot store contact, box is not available. '
          'Contact: ${contact.pubKey}');
      return;
    }

    try {
      await box!.put(contact.pubKey, <String, dynamic>{
        'timestamp': DateTime.now().toIso8601String(),
        'data': json.encode(contact.toJson()),
      });
    } catch (e) {
      logger('[ContactsCache._storeContact] Error storing contact: $e');
    }
  }

  Contact? _retrieveContact(String pubKey) {
    // Return null if box is not available
    if (!_isBoxOpen()) {
      logger(
          '[ContactsCache._retrieveContact] Cannot retrieve contact, box is not available');
      return null;
    }

    try {
      final dynamic record = box!.get(pubKey);

      if (record != null) {
        final Map<String, dynamic> typedRecord =
            Map<String, dynamic>.from(record as Map<dynamic, dynamic>);
        // final DateTime timestamp =
        // DateTime.parse(typedRecord['timestamp'] as String);
        final Contact contact = Contact.fromJson(
            json.decode(typedRecord['data'] as String) as Map<String, dynamic>);
        return contact;
      }
      return null;
    } catch (e) {
      logger('[ContactsCache._retrieveContact] Error retrieving contact: $e');
      return null;
    }
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

Contact getContactCache({required Contact simpleContact}) {
  final Contact contact =
      ContactsCache().getCachedContact(simpleContact.pubKey, false, true) ??
          simpleContact;
  assert(contact.hasAvatar == false);
  return contact;
}
