import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/g1/g1_helper.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';

void main() {
  group('Contact Search Page - V2 Address Processing', () {
    test(
        'Full v2 address should create Contact.withAddress (not Contact with pubKey)',
        () {
      const String fullV2Address =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      // Verify it's a valid v2 address
      expect(isValidV2Address(fullV2Address), isTrue);

      // Verify it's NOT valid as v1 pubkey (too long)
      expect(validateKey(fullV2Address), isFalse);

      // Simulate what contact_search_page should do:
      // If it's not valid v1, it should check v2
      Contact createdContact;
      if (validateKey(fullV2Address)) {
        // Wrong path - treating as v1 pubkey
        createdContact = Contact(pubKey: fullV2Address);
      } else if (isValidV2Address(fullV2Address)) {
        // Correct path - treating as v2 address
        createdContact = Contact.withAddress(
          address: fullV2Address,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        );
      } else {
        fail('Address should be valid as v2');
      }

      // Verify the contact was created correctly with address, not pubKey
      expect(createdContact.address, equals(fullV2Address));
      expect(createdContact.pubKey, isNotEmpty); // Should have derived pubkey
      expect(
          createdContact.pubKey,
          isNot(equals(
              fullV2Address))); // pubKey should NOT be the address itself
    });

    test('Truncated v2 address (44 chars) shows the problem clearly', () {
      const String truncatedV2 = 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9';

      // The problem: truncated v2 passes v1 validation
      final bool passesV1 = validateKey(truncatedV2);
      final bool passesV2 = isValidV2Address(truncatedV2);

      expect(passesV1, isTrue,
          reason: 'Truncated v2 incorrectly passes v1 validation');
      expect(passesV2, isFalse,
          reason: 'Truncated v2 correctly fails v2 validation');

      // If contact_search_page follows the OLD LOGIC (check v1 first):
      Contact wrongContact;
      if (validateKey(truncatedV2)) {
        // This is what happens NOW (WRONG)
        wrongContact = Contact(pubKey: truncatedV2);
      } else if (isValidV2Address(truncatedV2)) {
        wrongContact = Contact.withAddress(
          address: truncatedV2,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        );
      } else {
        fail('Should not reach here');
      }

      // The WRONG contact has the truncated string as pubKey
      expect(wrongContact.pubKey, equals(truncatedV2));

      // But this is WRONG because it's a truncated v2 address, not a v1 pubkey!
      // The correct behavior should be to REJECT this truncated address
    });

    test('Complete v2 address should NOT be treated as v1 pubkey', () {
      const String fullV2Address =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      // This address is 49 characters
      expect(fullV2Address.length, equals(49));

      // v1 pubkeys are 43-44 characters max
      // So this should NOT pass v1 validation (it's too long)
      expect(validateKey(fullV2Address), isFalse,
          reason: 'Full v2 address (49 chars) should NOT pass v1 validation');

      // But it SHOULD pass v2 validation
      expect(isValidV2Address(fullV2Address), isTrue,
          reason: 'Full v2 address should pass v2 validation');
    });

    test('V1 pubkey should create Contact with pubKey', () {
      const String v1Pubkey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';

      // This is a valid v1 pubkey
      expect(validateKey(v1Pubkey), isTrue);

      // It should NOT be valid as v2
      expect(isValidV2Address(v1Pubkey), isFalse);

      // Should create Contact with pubKey
      final Contact contact = Contact(pubKey: v1Pubkey);
      expect(contact.pubKey, equals(v1Pubkey));
    });

    test('parseMultipleKeys should only parse v1 pubkeys, not v2 addresses',
        () {
      // parseMultipleKeys uses a regex that matches 43-44 character base58 strings
      // This is DANGEROUS for v2 addresses because:
      // - The first 44 chars of a v2 address match this pattern
      // - So it will extract the TRUNCATED v2 address as if it was a v1 pubkey

      const String mixedText =
          'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5 and some text g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      final Set<Contact> parsedContacts = parseMultipleKeys(mixedText);

      // parseMultipleKeys will now correctly find:
      // 1. The v1 pubkey: BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5
      // 2. The COMPLETE v2 address: g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY
      // This is the FIX: the v2 address is NOT truncated!
      expect(parsedContacts.length, equals(2),
          reason:
              'parseMultipleKeys finds both v1 and complete v2 (not truncated)');

      // One of them will be the v1 pubkey
      final bool hasV1 = parsedContacts.any((Contact c) =>
          c.pubKey == 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5');
      expect(hasV1, isTrue);

      // The other will be the COMPLETE v2 address (not truncated!)
      final bool hasCompleteV2 = parsedContacts.any((Contact c) =>
          c.address == 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY');
      expect(hasCompleteV2, isTrue,
          reason:
              'The full v2 address is preserved, not truncated to 44 chars');
    });

    test('Contact.withAddress creates correct v2 contact structure', () {
      const String v2Address =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      final Contact contact = Contact.withAddress(
        address: v2Address,
        createdOn: DateTime.now().millisecondsSinceEpoch,
      );

      // Verify the contact has the address stored
      expect(contact.address, equals(v2Address));

      // Verify it has a pubKey (derived from the address)
      expect(contact.pubKey, isNotEmpty);

      // The pubKey should be different from the address (it's derived)
      expect(contact.pubKey, isNot(equals(v2Address)));
    });

    test('Invalid address should not create a contact', () {
      const String invalidAddress = 'not_a_valid_address_12345';

      final bool isV1Valid = validateKey(invalidAddress);
      final bool isV2Valid = isValidV2Address(invalidAddress);

      expect(isV1Valid, isFalse);
      expect(isV2Valid, isFalse);

      // Should not create any contact
      // This is what should happen in contact_search_page when both validations fail
    });

    test(
        'Full v2 address validation chain: should end up with Contact.withAddress',
        () {
      const String v2Address =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      // This is the correct validation chain for contact_search_page:
      Contact finalContact;

      // First check: is it a v1 pubkey?
      if (validateKey(v2Address)) {
        finalContact = Contact(pubKey: v2Address);
      }
      // Second check: is it a v2 address?
      else if (isValidV2Address(v2Address)) {
        finalContact = Contact.withAddress(
          address: v2Address,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        );
      } else {
        fail('Address should be valid as v2');
      }

      // Expected outcome: Contact created via Contact.withAddress
      expect(finalContact.address, equals(v2Address));
      expect(finalContact.pubKey, isNot(equals(v2Address)));
    });
  });

  group('parseMultipleKeys - Improved to handle v2 addresses', () {
    test('Single v2 address should NOT be truncated', () {
      const String v2Address =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      final Set<Contact> parsedContacts = parseMultipleKeys(v2Address);

      // Should find exactly 1 contact (the v2 address)
      expect(parsedContacts.length, equals(1),
          reason: 'Single v2 address should be parsed as one contact');

      final Contact contact = parsedContacts.first;

      // The contact should have the FULL v2 address, not truncated
      expect(contact.address, equals(v2Address),
          reason: 'v2 address should be stored completely, not truncated');

      // It should NOT have the address as pubKey
      expect(contact.pubKey, isNot(equals(v2Address)));
    });

    test('Single v1 pubkey should be parsed correctly', () {
      const String v1Pubkey = 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5';

      final Set<Contact> parsedContacts = parseMultipleKeys(v1Pubkey);

      // Should find exactly 1 contact (the v1 pubkey)
      expect(parsedContacts.length, equals(1));

      final Contact contact = parsedContacts.first;

      // The contact should have the v1 pubkey
      expect(contact.pubKey, equals(v1Pubkey));
    });

    test('Mixed v1 and v2 should both be parsed correctly', () {
      const String mixedText =
          'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5 and g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY';

      final Set<Contact> parsedContacts = parseMultipleKeys(mixedText);

      // Should find 2 contacts: 1 v1 and 1 v2
      expect(parsedContacts.length, equals(2),
          reason:
              'Should find both v1 pubkey and v2 address without truncation');

      // Check for v1 pubkey
      final bool hasV1 = parsedContacts.any((Contact c) =>
          c.pubKey == 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5');
      expect(hasV1, isTrue, reason: 'Should find the v1 pubkey');

      // Check for full v2 address (not truncated)
      final bool hasFullV2 = parsedContacts.any((Contact c) =>
          c.address == 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY');
      expect(hasFullV2, isTrue,
          reason: 'Should find the full v2 address without truncation');

      // Should NOT have the truncated v2 as pubKey
      final bool hasTruncatedV2 = parsedContacts.any((Contact c) =>
          c.pubKey == 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9');
      expect(hasTruncatedV2, isFalse,
          reason: 'Should NOT have truncated v2 address as pubKey');
    });

    test('Multiple v2 addresses should all be parsed', () {
      const String multiV2 =
          'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY and g1NGGZ4pjwmJPgB8Do8yCgP37En31wzbTVLUhYVa48NDGASGK';

      final Set<Contact> parsedContacts = parseMultipleKeys(multiV2);

      // Should find 2 v2 addresses
      expect(parsedContacts.length, equals(2));

      // Both should have full addresses, not truncated
      final bool hasFirst = parsedContacts.any((Contact c) =>
          c.address == 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY');
      expect(hasFirst, isTrue);

      final bool hasSecond = parsedContacts.any((Contact c) =>
          c.address == 'g1NGGZ4pjwmJPgB8Do8yCgP37En31wzbTVLUhYVa48NDGASGK');
      expect(hasSecond, isTrue);
    });

    test('Text with extra content should only extract valid addresses/pubkeys',
        () {
      const String textWithNoise =
          'Hello, send to BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5 or g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY please!';

      final Set<Contact> parsedContacts = parseMultipleKeys(textWithNoise);

      // Should find exactly 2: v1 and v2
      expect(parsedContacts.length, equals(2),
          reason: 'Should extract addresses/pubkeys and ignore text');

      // v1 pubkey should be correct
      final bool hasV1 = parsedContacts.any((Contact c) =>
          c.pubKey == 'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5');
      expect(hasV1, isTrue);

      // v2 address should be complete
      final bool hasV2 = parsedContacts.any((Contact c) =>
          c.address == 'g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY');
      expect(hasV2, isTrue);
    });
  });
}
