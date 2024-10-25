import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/ui/contacts_cache.dart';

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
}
