import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Tests for translation JSON files validation
///
/// This replaces the validation logic previously in build.sh (lines 55-79)
/// Ensures all translation files:
/// - Have valid JSON syntax
/// - Use only allowed template arguments
///
/// Template arguments whitelist prevents injection attacks and ensures
/// consistency across all translation files.
void main() {
  group('Translation JSON Validation', () {
    // Allowed template arguments in translation strings
    // This whitelist ensures consistency and prevents malformed translations
    final allowedArgs = [
      '{nick}',
      '{days}',
      '{amount}',
      '{from}',
      '{to}',
      '{type}',
      '{error}',
      '{node}',
      '{number}',
      '{currency}',
      '{success}',
      '{people}',
      '{fail}',
      '{key}',
      '{others}',
      '{someone}',
      '{count}',
      '{time}',
      '{name}',
      '{currentAppStoreVersion}',
      '{currentInstalledVersion}',
      '{\$}',
      '{}',
    ];

    // All supported languages
    final languages = [
      'ast',
      'ca',
      'da',
      'de',
      'en',
      'eo',
      'es-AST',
      'es',
      'eu',
      'fr',
      'gl',
      'it',
      'nl',
      'pt',
    ];

    for (final lang in languages) {
      test('$lang.json has valid JSON syntax', () {
        final file = File('assets/translations/$lang.json');
        expect(
          file.existsSync(),
          isTrue,
          reason: '$lang.json should exist in assets/translations/',
        );

        // Parse JSON to verify syntax
        final content = file.readAsStringSync();
        expect(
          () => jsonDecode(content),
          returnsNormally,
          reason: '$lang.json should have valid JSON syntax',
        );
      });

      test('$lang.json uses only allowed template arguments', () {
        // Skip es-AST as it's a copy of ast.json (created by build process)
        if (lang == 'es-AST') {
          return;
        }

        final file = File('assets/translations/$lang.json');
        final content = file.readAsStringSync();
        final lines = content.split('\n');

        final invalidLines = <String>[];

        for (final line in lines) {
          // Check lines containing template arguments
          if (line.contains('{')) {
            // Skip if line contains any allowed argument
            bool hasValidArg = false;
            for (final arg in allowedArgs) {
              if (line.contains(arg)) {
                hasValidArg = true;
                break;
              }
            }

            // If line has '{' but no valid arg, it's invalid
            if (!hasValidArg && line.trim().isNotEmpty) {
              // Skip JSON structure characters
              final trimmed = line.trim();
              if (trimmed != '{' &&
                  trimmed != '}' &&
                  !trimmed.startsWith('//')) {
                invalidLines.add(line.trim());
              }
            }
          }
        }

        expect(
          invalidLines,
          isEmpty,
          reason:
              '$lang.json has invalid template arguments:\n${invalidLines.take(10).join('\n')}',
        );
      });
    }

    test('ast.json exists as source for es-AST.json', () {
      // es-AST.json is created by copying ast.json during build
      // This test ensures the source file exists
      final astFile = File('assets/translations/ast.json');
      expect(
        astFile.existsSync(),
        isTrue,
        reason: 'ast.json must exist as source for es-AST.json generation',
      );
    });
  });
}
