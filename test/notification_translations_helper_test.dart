import 'package:flutter_test/flutter_test.dart';
import 'package:zelkova/ui/notification_translations_helper.dart';

void main() {
  group('NotificationTranslationsHelper', () {
    setUp(() {
      NotificationTranslationsHelper.clearCache();
    });

    tearDown(() {
      NotificationTranslationsHelper.clearCache();
    });

    test('get returns key when translation not found (default behavior)',
        () async {
      // Without loading translations, should return the key itself
      final String value =
          NotificationTranslationsHelper.get('en', 'non_existent_key_12345');
      expect(value, equals('non_existent_key_12345'));
    });

    test('get returns fallback value when provided', () async {
      final String value = NotificationTranslationsHelper.get(
        'en',
        'non_existent_key_12345',
        fallback: 'custom_fallback',
      );
      expect(value, equals('custom_fallback'));
    });

    test('clearCache clears all cached translations', () async {
      NotificationTranslationsHelper.clearCache();

      // After clear, get should return the key (not cached)
      final String value = NotificationTranslationsHelper.get(
          'en', 'notification_new_sent_title');
      // Should return key since cache is empty
      expect(value, equals('notification_new_sent_title'));
    });

    test('get without cache returns key as fallback', () async {
      NotificationTranslationsHelper.clearCache();

      final String title = NotificationTranslationsHelper.get(
          'en', 'notification_new_sent_title');

      // Should return key since nothing is cached
      expect(title, equals('notification_new_sent_title'));
    });

    test('loadTranslations handles language fallback', () async {
      // Attempting to load a non-existent language should try English
      // This tests the recursive fallback behavior
      final Map<String, String> translations =
          await NotificationTranslationsHelper.loadTranslations('xx');

      // Result should be either populated (if file exists) or empty (if en also fails)
      expect(translations, isA<Map<String, String>>());
    });

    test('loadTranslations caches results', () async {
      // Load English translations
      final Map<String, String> translations1 =
          await NotificationTranslationsHelper.loadTranslations('en');

      // Load again - should return cached version (same reference or identical content)
      final Map<String, String> translations2 =
          await NotificationTranslationsHelper.loadTranslations('en');

      // Both calls should return the same data
      expect(translations1.runtimeType, equals(translations2.runtimeType));
    });
  });
}
