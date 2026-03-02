import 'dart:convert';
import 'package:flutter/services.dart';

/// Helper to load notification translations without requiring easy_localization context.
///
/// This is necessary because notifications can be triggered from:
/// 1. Background isolates (WorkManager) where easy_localization is not initialized
/// 2. Web service workers where Flutter context is not available
/// 3. Situations where easy_localization context is not accessible
///
/// The translations are loaded once and cached statically.
class NotificationTranslationsHelper {
  NotificationTranslationsHelper._();
  static final Map<String, Map<String, String>> _cache =
      <String, Map<String, String>>{};

  /// Load all notification translations for a given language code.
  ///
  /// **Parameters:**
  /// - `languageCode`: Language code (e.g., 'en', 'es', 'fr')
  ///
  /// **Returns:** Map of translation keys to values, or empty map if loading fails.
  ///
  /// **Example:**
  /// ```dart
  /// final es = await NotificationTranslationsHelper.loadTranslations('es');
  /// final title = es['notification_new_sent_title'] ?? 'fallback';
  /// ```
  static Future<Map<String, String>> loadTranslations(
      String languageCode) async {
    // Return cached translation if available
    if (_cache.containsKey(languageCode)) {
      return _cache[languageCode]!;
    }

    try {
      // Load the JSON translation file
      final String jsonString = await rootBundle.loadString(
        'assets/translations/$languageCode.json',
      );
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;

      // Cache the translations
      final Map<String, String> translations = json.cast<String, String>();
      _cache[languageCode] = translations;

      return translations;
    } catch (e) {
      // Fallback to English if the language file is not found
      if (languageCode != 'en') {
        return loadTranslations('en');
      }
      // Return empty map as last resort
      return <String, String>{};
    }
  }

  /// Load translations from a JSON string (useful for testing).
  ///
  /// **Parameters:**
  /// - `languageCode`: Language code (e.g., 'en', 'es')
  /// - `jsonString`: JSON string containing translations
  ///
  /// **Example:**
  /// ```dart
  /// await NotificationTranslationsHelper.loadFromJson('es', jsonString);
  /// ```
  static Future<Map<String, String>> loadFromJson(
      String languageCode, String jsonString) async {
    try {
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;

      // Cache the translations
      final Map<String, String> translations = json.cast<String, String>();
      _cache[languageCode] = translations;

      return translations;
    } catch (e) {
      return <String, String>{};
    }
  }

  /// Get a translation value, with optional fallback.
  ///
  /// **Parameters:**
  /// - `languageCode`: Language code to get translation for
  /// - `key`: Translation key
  /// - `fallback`: Fallback value if not found (defaults to the key itself)
  ///
  /// **Returns:** Translated string or fallback value.
  ///
  /// **Note:** This method is synchronous and assumes translations are already loaded.
  /// Use `loadTranslations()` first to ensure data is cached.
  static String get(String languageCode, String key, {String? fallback}) {
    final Map<String, String>? translations = _cache[languageCode];
    if (translations == null) {
      return fallback ?? key;
    }
    return translations[key] ?? (fallback ?? key);
  }

  /// Clear the translation cache (useful for testing or language changes).
  static void clearCache() {
    _cache.clear();
  }
}
