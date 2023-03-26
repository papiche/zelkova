import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';

void main() {
  final Contact c = Contact(
    nick: 'Alice',
    pubKey: 'abcd1234',
    avatar: Uint8List.fromList(<int>[1, 2, 3]),
    notes: 'Some notes',
    name: 'Alice Smith',
  );

  test('Serializing and deserializing Contact', () {
    final Map<String, dynamic> contactJson = c.toJson();
    final Contact contact = Contact.fromJson(contactJson);
    final dynamic json = contact.toJson();

    expect(json, equals(contactJson));

    const String contactS =
        '{"nick":null,"pubKey":"7wnDh2FPdwNW8Dd5JyoJTbspuu8b9QJKps2xAYenefsu","avatar":[],"notes":null,"name":null}';
    final Contact contactFromS =
        Contact.fromJson(jsonDecode(contactS) as Map<String, dynamic>);
    expect(contactFromS.pubKey,
        equals('7wnDh2FPdwNW8Dd5JyoJTbspuu8b9QJKps2xAYenefsu'));

    const String contactWithAvatarS =
        '{"nick":null,"pubKey":"7wnDh2FPdwNW8Dd5JyoJTbspuu8b9QJKps2xAYenefsu","avatar":[68,174,66,96,130],"notes":null,"name":null}';
    final Contact contactFromWithAvatar = Contact.fromJson(
        jsonDecode(contactWithAvatarS) as Map<String, dynamic>);
    expect(contactFromWithAvatar.avatar, isNotNull);
    expect(contactFromWithAvatar.avatar!.toList(),
        equals(<int>[68, 174, 66, 96, 130]));
  });
}
