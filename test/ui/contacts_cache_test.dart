import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/contact.dart';
import 'package:zelkova/ui/contacts_cache.dart';

void main() {
  // Valid G1 public key format from existing tests
  const String validPubKey1 = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
  const String validPubKey2 = '6JgGvDDBu8XWL89BTvzHCfVmJWbSRfBNb1ZK4dQW6fNK';

  group('ContactsCache Lifecycle Tests', () {
    late ContactsCache cache;

    setUp(() {
      // Reset singleton instance before each test
      ContactsCache.resetInstance();
      // Create a new instance with in-memory fallback
      cache = ContactsCache();
    });

    tearDown(() async {
      await cache.dispose();
    });

    test('should initialize with memory fallback', () async {
      await cache.init(true);
      expect(cache.box, isNotNull);
    });

    test('should add and retrieve contact', () async {
      await cache.init(true);
      final Contact testContact = Contact(
        pubKey: validPubKey1,
        name: 'Test Contact',
      );

      await cache.addContact(testContact);
      final Contact? retrieved = cache.getCachedContact(validPubKey1);

      expect(retrieved, isNotNull);
      expect(retrieved!.pubKey, equals(validPubKey1));
      expect(retrieved.name, equals('Test Contact'));
    });

    test('should handle access after disposal gracefully', () async {
      await cache.init(true);
      final Contact testContact = Contact(
        pubKey: validPubKey1,
        name: 'Test Contact',
      );

      await cache.addContact(testContact);
      await cache.dispose();

      // Should not throw, should return null
      final Contact? retrieved = cache.getCachedContact(validPubKey1);
      expect(retrieved, isNull);
    });

    test('should prevent addContact after disposal', () async {
      await cache.init(true);
      await cache.dispose();

      final Contact testContact = Contact(
        pubKey: validPubKey1,
        name: 'Test Contact',
      );

      // Should not throw
      await cache.addContact(testContact);

      // Verify it was not added
      final Contact? retrieved = cache.getCachedContact(validPubKey1);
      expect(retrieved, isNull);
    });

    test('should prevent multiple disposals', () async {
      await cache.init(true);

      // First disposal
      await cache.dispose();

      // Second disposal should not throw
      await cache.dispose();
    });

    test('should prevent clear after disposal', () async {
      await cache.init(true);
      final Contact testContact = Contact(
        pubKey: validPubKey1,
        name: 'Test Contact',
      );

      await cache.addContact(testContact);
      await cache.dispose();

      // Should not throw
      await cache.clear();
    });

    test('should prevent removeContact after disposal', () async {
      await cache.init(true);
      final Contact testContact = Contact(
        pubKey: validPubKey1,
        name: 'Test Contact',
      );

      await cache.addContact(testContact);
      await cache.dispose();

      // Should not throw
      await cache.removeContact(validPubKey1);

      // Verify contact still exists (was not removed)
      // Note: After disposal, retrieval should return null anyway
      final Contact? retrieved = cache.getCachedContact(validPubKey1);
      expect(retrieved, isNull);
    });

    test('should handle concurrent addContact and disposal', () async {
      await cache.init(true);

      final List<Contact> contacts = List<Contact>.generate(
        5,
        (int i) => Contact(
          pubKey: i == 0 ? validPubKey1 : validPubKey2,
          name: 'Test Contact $i',
        ),
      );

      // Start adding contacts
      final List<Future<void>> addFutures =
          contacts.map((Contact c) => cache.addContact(c)).toList();

      // Dispose while operations are in flight
      await Future<Duration?>.delayed(const Duration(milliseconds: 10));
      await cache.dispose();

      // Wait for all operations to complete
      await Future.wait(addFutures);

      // Should not throw and cache should be disposed
      final Contact? retrieved = cache.getCachedContact(validPubKey1);
      expect(retrieved, isNull);
    });

    test('should preserve contacts before disposal', () async {
      await cache.init(true);

      final Contact testContact1 = Contact(
        pubKey: validPubKey1,
        name: 'Contact 1',
      );

      final Contact testContact2 = Contact(
        pubKey: validPubKey2,
        name: 'Contact 2',
      );

      await cache.addContact(testContact1);
      await cache.addContact(testContact2);

      // Verify both contacts exist before disposal
      expect(cache.getCachedContact(validPubKey1), isNotNull);
      expect(cache.getCachedContact(validPubKey2), isNotNull);

      await cache.dispose();

      // After disposal, retrieval should return null
      expect(cache.getCachedContact(validPubKey1), isNull);
      expect(cache.getCachedContact(validPubKey2), isNull);
    });
  });
}
