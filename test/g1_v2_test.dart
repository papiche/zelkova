import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/g1_v2_helper.dart';

void main() {
  group('isValidAddress', () {
    test('returns true for valid addresses', () {
      final List<String> validAddresses = <String>[
        '5GrpknVvGGrGH3EFuURXeMrWHvbpj3VfER1oX5jFtuGbfzCE',
        '5FLdosNUhAJ4zW8NKp65yaXEECUwkuNqVRcmjTEsZ8vvkxuP'
      ];

      for (final String address in validAddresses) {
        expect(isValidV2Address(address), isTrue);
      }
    });

    test('returns false for invalid addresses', () {
      final List<String> invalidAddresses = <String>[
        '1G9tTobcmjgjSg2CEGjmFqZBbB3LQ85PhpMXD7NfnKhhJd3',
        '1KjvmrF1uVSaJvmjF1uVSaJF1uVSaJZ9QZ5',
        'BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'
      ];

      for (final String address in invalidAddresses) {
        expect(isValidV2Address(address), isFalse);
      }
    });
  });
}
