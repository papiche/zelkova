import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/data/models/contact.dart';
import 'package:zelkova/data/models/contact_cubit.dart';
import 'package:zelkova/g1/g1_v2_helper.dart';
import 'package:zelkova/ui/contacts_cache.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class _MockStorage implements Storage {
  final Map<String, dynamic> _store = <String, dynamic>{};

  @override
  Future<void> write(String key, dynamic value) async {
    _store[key] = value;
  }

  @override
  dynamic read(String key) {
    return _store[key];
  }

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> clear() async {
    _store.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  const String testPubKey = '7wnDh2FPdwNW8Dd5JyoJTbspuu8b9QJKps2xAYenefsu';

  final Contact c = Contact(
    nick: 'Alice',
    pubKey: testPubKey,
    avatar: Uint8List.fromList(<int>[1, 2, 3]),
    notes: 'Some notes',
    name: 'Alice Smith',
  );

  setUpAll(() {
    ContactsCache().init(true);
    ContactsCache().addContacts(<Contact>[c]);
  });

  test('Serializing and deserializing Contact', () {
    final Map<String, dynamic> contactJson = c.toJson();
    final Contact contact = Contact.fromJson(contactJson);
    final dynamic json = contact.toJson();

    expect(json, equals(contactJson));

    const String contactS =
        '{"nick":null,"pubKey":"$testPubKey","avatar":[],"notes":null,"name":null}';
    final Contact contactFromS =
        Contact.fromJson(jsonDecode(contactS) as Map<String, dynamic>);
    expect(contactFromS.pubKey, equals(testPubKey));

    const String contactWithAvatarS =
        '{"nick":null,"pubKey":"$testPubKey","avatar":[68,174,66,96,130],"notes":null,"name":null}';
    final Contact contactFromWithAvatar = Contact.fromJson(
        jsonDecode(contactWithAvatarS) as Map<String, dynamic>);
    expect(contactFromWithAvatar.avatar, isNotNull);
    expect(contactFromWithAvatar.avatar!.toList(),
        equals(<int>[68, 174, 66, 96, 130]));
  });

  group('Contact merge test', () {
    test('Merge properties', () {
      final Contact contact1 = Contact(nick: 'nick1', pubKey: testPubKey);

      final Contact contact2 = Contact(
        pubKey: testPubKey,
        avatar: Uint8List.fromList(<int>[1, 2, 3]),
        name: 'name2',
        notes: 'notes2',
      );

      final List<Contact> merged = <Contact>[
        contact1.merge(contact2),
        contact2.merge(contact1),
      ];
      for (final Contact mergedContact in merged) {
        expect(mergedContact.nick, 'nick1');
        expect(mergedContact.pubKey, testPubKey);
        expect(mergedContact.avatar, Uint8List.fromList(<int>[1, 2, 3]));
        expect(mergedContact.notes, 'notes2');
        expect(mergedContact.name, 'name2');
      }
    });

    test('Merge with empty contact', () {
      final Contact contact1 = Contact(
        nick: 'nick1',
        pubKey: testPubKey,
        avatar: Uint8List.fromList(<int>[1, 2, 3]),
        notes: 'notes1',
        name: 'name1',
      );

      final Contact contact2 = Contact(pubKey: testPubKey);
      final Contact contact3 = Contact(pubKey: testPubKey);

      final Contact mergedContact1st = contact1.merge(contact2);
      final Contact mergedContact = mergedContact1st.merge(contact3);

      expect(mergedContact.nick, 'nick1');
      expect(mergedContact.pubKey, testPubKey);
      expect(mergedContact.avatar, Uint8List.fromList(<int>[1, 2, 3]));
      expect(mergedContact.notes, 'notes1');
      expect(mergedContact.name, 'name1');
    });
  });

  test('Merge with empty contact in Contact cache', () async {
    final Contact c2 = Contact(
      pubKey: testPubKey,
    );

    ContactsCache().addContact(c2);
    final Contact mergedContact = await ContactsCache().getContact(testPubKey);

    expect(mergedContact.nick, 'Alice');
    expect(mergedContact.pubKey, testPubKey);
    expect(mergedContact.avatar, Uint8List.fromList(<int>[1, 2, 3]));
    expect(mergedContact.notes, 'Some notes');
    expect(mergedContact.name, 'Alice Smith');
  });

  group('ContactsCubit search with v2 addresses', () {
    late ContactsCubit contactsCubit;

    setUp(() {
      HydratedBloc.storage = _MockStorage();
      contactsCubit = ContactsCubit();
    });

    tearDown(() {
      contactsCubit.close();
    });

    test('Search by v1 pubkey finds contact saved with v1 pubkey', () {
      const String v1Pubkey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';
      final Contact contact = Contact(
        pubKey: v1Pubkey,
        name: 'Test User',
      );

      contactsCubit.addContact(contact);
      final List<Contact> results = contactsCubit.search(v1Pubkey);

      expect(results.length, 1);
      expect(results[0].pubKey, v1Pubkey);
    });

    test('Search by v2 address finds contact saved with v1 pubkey', () {
      // This is the actual test case for the bug fix
      // Real v2 address and v1 pubkey pair from parse_scanned_uri_test.dart
      const String v1Pubkey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
      const String v2Address =
          'g1LjVbmvZVx7QxgAW9Q7NSS4jKHXo51M44zUwbkG3UsA7UZVM';

      // Verify that v2Address converts to v1Pubkey
      expect(v1pubkeyFromAddress(v2Address), v1Pubkey);

      // Add contact with v1 pubkey (how old contacts are stored)
      final Contact contact = Contact(
        pubKey: v1Pubkey,
        name: 'Test User',
      );
      contactsCubit.addContact(contact);

      // Search using v2 address - should find the contact
      final List<Contact> results = contactsCubit.search(v2Address);

      expect(results.length, 1,
          reason: 'Should find contact when searching by v2 address');
      expect(results[0].pubKey, v1Pubkey);
      expect(results[0].name, 'Test User');
    });

    test('Search by partial v2 address finds contact', () {
      const String v1Pubkey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';

      final Contact contact = Contact(
        pubKey: v1Pubkey,
        name: 'Test User',
      );
      contactsCubit.addContact(contact);

      // Search using part of the v2 address
      final List<Contact> results = contactsCubit.search('g1LjVbmvZVx7');

      expect(results.length, 1,
          reason: 'Should find contact when searching by partial v2 address');
      expect(results[0].pubKey, v1Pubkey);
    });

    test(
        'Search by v2 address type (like GWC8e...) finds contact saved with v1',
        () {
      // Another real example from parse_scanned_uri_test.dart
      const String v1Pubkey = 'DU7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZ';
      const String v2Address =
          'g1PAf1Dg6NAtsece62shM98dgmGiCF36PDJjfJ86aCYhe78XP';

      // Verify that v2Address converts to v1Pubkey
      expect(v1pubkeyFromAddress(v2Address), v1Pubkey);

      final Contact contact = Contact(
        pubKey: v1Pubkey,
        name: 'Test User 2',
      );
      contactsCubit.addContact(contact);

      // Search using v2 address
      final List<Contact> results = contactsCubit.search(v2Address);

      expect(results.length, 1,
          reason: 'Should find contact when searching by v2 address');
      expect(results[0].pubKey, v1Pubkey);
    });

    test('Search still works with name, nick, and notes', () {
      const String v1Pubkey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';

      final Contact contact = Contact(
        pubKey: v1Pubkey,
        name: 'Alice Smith',
        nick: 'alice',
        notes: 'Friend from university',
      );
      contactsCubit.addContact(contact);

      // Search by name
      expect(contactsCubit.search('Alice').length, 1);
      expect(contactsCubit.search('alice').length, 1);
      expect(contactsCubit.search('Smith').length, 1);

      // Search by nick
      expect(contactsCubit.search('alice').length, 1);

      // Search by notes
      expect(contactsCubit.search('university').length, 1);
    });
  });
}
