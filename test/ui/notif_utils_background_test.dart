import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/ui/notif_utils.dart';
import 'package:zelkova/ui/notification_translations_helper.dart';

// Sample Spanish translations for testing
const String _spanishTranslations = '''
{
  "notification_new_payment_title": "Nuevo pago recibido",
  "notification_new_sent_title": "Nuevo pago enviado",
  "notification_new_payment_desc": "Has recibido un nuevo pago de {amount} de {from}",
  "notification_new_sent_desc": "Has enviado un nuevo pago de {amount} a {to}",
  "notification_open": "ABRIR"
}''';

const String _englishTranslations = '''
{
  "notification_new_payment_title": "New payment received",
  "notification_new_sent_title": "New payment sent",
  "notification_new_payment_desc": "You have received a new payment of {amount} from {from}",
  "notification_new_sent_desc": "You have sent a new payment of {amount} to {to}",
  "notification_open": "OPEN"
}''';

void main() {
  group('NotifUtils in Background Context (without easy_localization)', () {
    setUp(() {
      NotificationTranslationsHelper.clearCache();
    });

    tearDown(() {
      NotificationTranslationsHelper.clearCache();
    });

    group('buildTxNotifTitle', () {
      test(
          'returns translated title in spanish when translations are pre-loaded and languageCode is spanish',
          () async {
        // Pre-load Spanish translations (simulating what fetchTransactionsFromBackground does)
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        // Should NOT return the key, but the translated text
        final String title = buildTxNotifTitle(null, languageCode: 'es');
        expect(title, isNotEmpty);
        expect(title, isNot('notification_new_sent_title'),
            reason:
                'Expected translated title, but got the key. This means the fallback failed.');
        expect(title.toLowerCase(), contains('pago'),
            reason:
                'Expected Spanish translation containing "pago", got: $title');
      });

      test(
          'returns translated title in english when translations are pre-loaded',
          () async {
        // Pre-load English translations
        await NotificationTranslationsHelper.loadFromJson(
            'en', _englishTranslations);

        // Call buildTxNotifTitle with from=null and en language code
        final String title = buildTxNotifTitle(null, languageCode: 'en');

        // Should NOT return the key
        expect(title, isNotEmpty);
        expect(title, isNot('notification_new_sent_title'));
        expect(title.toLowerCase(), contains('sent'),
            reason:
                'Expected English translation containing "sent", got: $title');
      });

      test(
          'returns key as fallback when no languageCode provided (background scenario)',
          () {
        // This simulates the bug: when tr() fails and no languageCode is provided
        final String title = buildTxNotifTitle(null);

        // This is the problematic behavior we want to catch
        expect(title, equals('notification_new_sent_title'),
            reason:
                'When no languageCode is provided, it returns the key itself.');
      });

      test(
          'returns translated title for received transaction (from is not null)',
          () async {
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        final String title = buildTxNotifTitle('John Doe', languageCode: 'es');

        expect(title, isNotEmpty);
        expect(title, isNot('notification_new_payment_title'));
        expect(title.toLowerCase(), contains('pago'),
            reason:
                'Expected Spanish translation for received payment, got: $title');
      });
    });

    group('buildTxNotifDescription', () {
      test(
          'returns translated description in spanish with amount and recipient',
          () async {
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        final String desc = buildTxNotifDescription(
          from: null,
          to: 'alice@duniter',
          comment: null,
          localeLanguageCode: 'es',
          amount: 10.5,
          isG1: true,
          currentUd: 1.0,
        );

        expect(desc, isNotEmpty);
        expect(desc, isNot('notification_new_sent_desc'));
        // Check for locale-formatted amount (0,1 Ğ1 in Spanish)
        expect(desc, contains('Ğ1'),
            reason: 'Expected Ğ1 currency symbol in description, got: $desc');
        expect(desc, contains('alice@duniter'),
            reason: 'Expected recipient to be in description, got: $desc');
      });

      test('returns translated description in english', () async {
        await NotificationTranslationsHelper.loadFromJson(
            'en', _englishTranslations);

        final String desc = buildTxNotifDescription(
          from: null,
          to: 'bob@duniter',
          comment: null,
          localeLanguageCode: 'en',
          amount: 5.0,
          isG1: true,
          currentUd: 1.0,
        );

        expect(desc, isNotEmpty);
        expect(desc, isNot('notification_new_sent_desc'));
        // Check for locale-formatted amount with Ğ1 symbol
        expect(desc, contains('Ğ1'),
            reason: 'Expected Ğ1 currency symbol in description, got: $desc');
        expect(desc, contains('bob@duniter'));
      });

      test('includes comment when provided', () async {
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        final String desc = buildTxNotifDescription(
          from: null,
          to: 'alice@duniter',
          comment: 'Payment for lunch',
          localeLanguageCode: 'es',
          amount: 15.0,
          isG1: true,
          currentUd: 1.0,
        );

        expect(desc, contains('Payment for lunch'),
            reason: 'Expected comment to be appended, got: $desc');
      });

      test('handles received transaction (from is not null)', () async {
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        final String desc = buildTxNotifDescription(
          from: 'charlie@duniter',
          to: null,
          comment: null,
          localeLanguageCode: 'es',
          amount: 20.0,
          isG1: true,
          currentUd: 1.0,
        );

        expect(desc, isNotEmpty);
        expect(desc, isNot('notification_new_payment_desc'));
        expect(desc, contains('charlie@duniter'));
        // Check for locale-formatted amount with Ğ1 symbol
        expect(desc, contains('Ğ1'),
            reason: 'Expected Ğ1 currency symbol in description, got: $desc');
      });

      test('returns key as fallback when translations not loaded', () {
        // Simulate the bug: translations not loaded, description falls back to key
        final String desc = buildTxNotifDescription(
          from: null,
          to: 'alice@duniter',
          comment: null,
          localeLanguageCode: 'es',
          amount: 10.5,
          isG1: true,
          currentUd: 1.0,
        );

        // This is what happens currently - it returns the key
        expect(desc, equals('notification_new_sent_desc'),
            reason:
                'When translations are not pre-loaded, it fails and returns the key.');
      });
    });

    group('Integration: Full background notification flow', () {
      test('simulates background isolate without easy_localization', () async {
        // GIVEN: Background isolate starts without easy_localization
        // (cleared cache, no tr() context)
        NotificationTranslationsHelper.clearCache();

        // WHEN: Translations are pre-loaded for Spanish (as should happen in main.dart:1102)
        await NotificationTranslationsHelper.loadFromJson(
            'es', _spanishTranslations);

        // AND: We build a notification for a sent transaction
        final String title = buildTxNotifTitle(null, languageCode: 'es');
        final String desc = buildTxNotifDescription(
          from: null,
          to: 'recipient@duniter',
          comment: null,
          localeLanguageCode: 'es',
          amount: 25.0,
          isG1: true,
          currentUd: 1.0,
        );

        // THEN: Both should be translated, not keys
        expect(title, isNot('notification_new_sent_title'),
            reason: 'Title should be translated: $title');
        expect(desc, isNot('notification_new_sent_desc'),
            reason: 'Description should be translated: $desc');
        expect(title, contains('pago'),
            reason: 'Title should be in Spanish, got: $title');
      });

      test(
          'reproduces the bug: background isolate with default locale (en) but user has spanish',
          () async {
        // GIVEN: Background isolate with default locale 'en'
        NotificationTranslationsHelper.clearCache();

        // WHEN: Translations are loaded for 'en' (the DEFAULT, not user's Spanish)
        await NotificationTranslationsHelper.loadFromJson(
            'en', _englishTranslations);

        // AND: We try to get Spanish translations but they're not loaded
        final String title = buildTxNotifTitle(null, languageCode: 'es');

        // THEN: This is the bug - we get the key because 'es' translations aren't loaded
        expect(title, equals('notification_new_sent_title'),
            reason:
                'BUG: We loaded English translations but asked for Spanish, so we get the key');
      });
    });
  });
}
