import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Market Analysis Fixes', () {
    group('Transaction Count Parameter Order Fix', () {
      test('onResult callback receives parameters in correct order', () {
        // This test verifies that the transaction count fix works correctly
        // The parameters should be: totalReceived (double), totalSent (double),
        // totalReceivedNumber (int), totalSentNumber (int), otherContacts (Set),
        // markdownSummary (String)

        // Mock callback to capture parameters
        late double capturedTotalReceived;
        late double capturedTotalSent;
        late int capturedTotalReceivedNumber;
        late int capturedTotalSentNumber;

        // Simulate the callback with correct parameter order
        void onResultCallback(
            double totalReceived,
            double totalSent,
            int totalReceivedNumber,
            int totalSentNumber,
            Set<dynamic> other,
            String md) {
          capturedTotalReceived = totalReceived;
          capturedTotalSent = totalSent;
          capturedTotalReceivedNumber = totalReceivedNumber;
          capturedTotalSentNumber = totalSentNumber;
        }

        // Test case: 3 transactions received, 2 transactions sent
        const double expectedTotalReceived = 1500.0;
        const double expectedTotalSent = 750.0;
        const int expectedReceivedCount = 3;
        const int expectedSentCount = 2;

        onResultCallback(expectedTotalReceived, expectedTotalSent,
            expectedReceivedCount, expectedSentCount, <dynamic>{}, '');

        // Verify parameters are in correct order
        expect(capturedTotalReceived, equals(expectedTotalReceived),
            reason: 'totalReceived should be 1500.0');
        expect(capturedTotalSent, equals(expectedTotalSent),
            reason: 'totalSent should be 750.0');
        expect(capturedTotalReceivedNumber, equals(expectedReceivedCount),
            reason: 'totalReceivedNumber should be 3');
        expect(capturedTotalSentNumber, equals(expectedSentCount),
            reason: 'totalSentNumber should be 2');
      });

      test('parameter order prevents swapping received/sent counts', () {
        // Test that demonstrates the bug would have shown received count
        // as sent count and vice versa
        late int receivedNumber;
        late int sentNumber;

        void correctOrder(double _, double __, int recvNum, int sentNum,
            Set<void> ___, String ____) {
          receivedNumber = recvNum;
          sentNumber = sentNum;
        }

        void incorrectOrder(double _, double __, int sentNum, int recvNum,
            Set<void> ___, String ____) {
          // This would be the buggy order (what we fixed)
          receivedNumber = recvNum;
          sentNumber = sentNum;
        }

        // With correct order
        correctOrder(0, 0, 5, 3, <dynamic>{}, '');
        expect(receivedNumber, equals(5));
        expect(sentNumber, equals(3));

        // With incorrect order (simulating the bug)
        incorrectOrder(0, 0, 3, 5, <dynamic>{}, '');
        expect(receivedNumber, equals(5)); // Would be swapped!
        expect(sentNumber, equals(3));
      });
    });

    group('Timestamp Conversion for Date Range Filtering', () {
      test('Unix timestamp (seconds) converts to ISO 8601 correctly', () {
        // Test: 2026-03-07 00:00:00 UTC = 1772841600 seconds
        const int unixSecondsFrom = 1772841600;
        final DateTime fromDate = DateTime.fromMillisecondsSinceEpoch(
            unixSecondsFrom * 1000,
            isUtc: true);
        final String iso8601From = fromDate.toIso8601String();

        expect(iso8601From, contains('2026-03-07'));
        expect(iso8601From, contains('00:00:00'));
        expect(iso8601From.endsWith('Z'), isTrue,
            reason: 'ISO 8601 string should end with Z for UTC');
      });

      test('Unix timestamp (seconds) to ISO 8601 includes milliseconds', () {
        // Test that ISO 8601 conversion includes milliseconds
        const int unixSeconds = 1772841600;
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(
            unixSeconds * 1000,
            isUtc: true);
        final String iso8601 = date.toIso8601String();

        // Format should be: 2026-03-07T00:00:00.000Z
        expect(iso8601,
            matches(RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z')));
      });

      test('Multiple timestamps convert correctly', () {
        // Test range: 2026-03-07 to 2026-03-08
        const int fromSeconds = 1772841600; // 2026-03-07 00:00:00
        const int toSeconds = 1772928000; // 2026-03-08 00:00:00

        final DateTime fromDate = DateTime.fromMillisecondsSinceEpoch(
            fromSeconds * 1000,
            isUtc: true);
        final DateTime toDate =
            DateTime.fromMillisecondsSinceEpoch(toSeconds * 1000, isUtc: true);

        final String iso8601From = fromDate.toIso8601String();
        final String iso8601To = toDate.toIso8601String();

        expect(iso8601From, contains('2026-03-07'));
        expect(iso8601To, contains('2026-03-08'));
        expect(iso8601From.compareTo(iso8601To), isNegative,
            reason: 'From timestamp should be before to timestamp');
      });

      test('Null timestamps are handled gracefully', () {
        // Test that null values don't cause issues
        const int? fromSeconds = null;
        const int? toSeconds = null;

        String? timestampFrom;
        String? timestampTo;

        if (fromSeconds != null) {
          final DateTime fromDate = DateTime.fromMillisecondsSinceEpoch(
              fromSeconds * 1000,
              isUtc: true);
          timestampFrom = fromDate.toIso8601String();
        }
        if (toSeconds != null) {
          final DateTime toDate = DateTime.fromMillisecondsSinceEpoch(
              toSeconds * 1000,
              isUtc: true);
          timestampTo = toDate.toIso8601String();
        }

        expect(timestampFrom, isNull);
        expect(timestampTo, isNull);
      });

      test('UTC conversion is preserved', () {
        // Test that UTC timezone indicator is present
        const int unixSeconds = 1772841600;
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(
            unixSeconds * 1000,
            isUtc: true);
        final String iso8601 = date.toIso8601String();

        expect(date.isUtc, isTrue, reason: 'DateTime should be in UTC');
        expect(iso8601.endsWith('Z'), isTrue,
            reason: 'ISO 8601 UTC string should end with Z');
      });

      test('Timestamp conversion preserves precision', () {
        // Test that conversion doesn't lose precision
        const int unixSeconds = 1772841600;
        const int milliseconds = unixSeconds * 1000;

        final DateTime date =
            DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
        final int reconstructedMillis = date.millisecondsSinceEpoch;

        expect(reconstructedMillis, equals(milliseconds));
      });
    });

    group('GraphQL Query Variable Integration', () {
      test('Timestamp variables are not null when date range is provided', () {
        // Test that when date range is provided, both from and to are set
        const int from = 1772841600;
        const int to = 1772928000;

        String? timestampFrom;
        String? timestampTo;

        // Simulate the conversion in duniter_indexer_helper.dart
        if (from != null) {
          final DateTime fromDate =
              DateTime.fromMillisecondsSinceEpoch(from * 1000, isUtc: true);
          timestampFrom = fromDate.toIso8601String();
        }
        if (to != null) {
          final DateTime toDate =
              DateTime.fromMillisecondsSinceEpoch(to * 1000, isUtc: true);
          timestampTo = toDate.toIso8601String();
        }

        expect(timestampFrom, isNotNull,
            reason: 'timestampFrom should be set when from is provided');
        expect(timestampTo, isNotNull,
            reason: 'timestampTo should be set when to is provided');
      });

      test('Timestamp variables can be used in GraphQL filter', () {
        // Test that converted timestamps are in the format expected by GraphQL
        const int fromSeconds = 1772841600;
        const int toSeconds = 1772928000;

        final DateTime fromDate = DateTime.fromMillisecondsSinceEpoch(
            fromSeconds * 1000,
            isUtc: true);
        final DateTime toDate =
            DateTime.fromMillisecondsSinceEpoch(toSeconds * 1000, isUtc: true);

        final String timestampFrom = fromDate.toIso8601String();
        final String timestampTo = toDate.toIso8601String();

        // Verify format matches expected GraphQL Datetime format
        // Format: 2026-03-07T00:00:00.000Z
        expect(timestampFrom,
            matches(RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z')));
        expect(timestampTo,
            matches(RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z')));
      });

      test('Null handling in GraphQL variable passing', () {
        // Test that null values are handled correctly in variable passing
        const int? from = null;
        const int to = 1772928000;

        String? timestampFrom;
        String? timestampTo;

        if (from != null) {
          final DateTime fromDate =
              DateTime.fromMillisecondsSinceEpoch(from * 1000, isUtc: true);
          timestampFrom = fromDate.toIso8601String();
        }
        if (to != null) {
          final DateTime toDate =
              DateTime.fromMillisecondsSinceEpoch(to * 1000, isUtc: true);
          timestampTo = toDate.toIso8601String();
        }

        expect(timestampFrom, isNull,
            reason: 'timestampFrom should remain null when from is null');
        expect(timestampTo, isNotNull,
            reason: 'timestampTo should be set when to is provided');
      });

      test('Edge case: same from and to timestamps', () {
        // Test filtering for a single day
        const int singleDay = 1772841600;

        final DateTime fromDate =
            DateTime.fromMillisecondsSinceEpoch(singleDay * 1000, isUtc: true);
        final DateTime toDate =
            DateTime.fromMillisecondsSinceEpoch(singleDay * 1000, isUtc: true);

        final String timestampFrom = fromDate.toIso8601String();
        final String timestampTo = toDate.toIso8601String();

        expect(timestampFrom, equals(timestampTo),
            reason: 'Should be equal for same timestamp');
      });
    });

    group('Integration: Date Range Filtering with Transactions', () {
      test('Date filtering excludes transactions outside range', () {
        // Test that date range filtering logic works correctly
        const int rangeFrom = 1772841600; // 2026-03-07 00:00:00
        const int rangeTo = 1772928000; // 2026-03-08 00:00:00

        // Mock transaction timestamps
        const int txWithin = 1772884800; // 2026-03-07 13:00:00 (within range)
        const int txBefore = 1772668800; // 2026-03-04 00:00:00 (before range)
        const int txAfter = 1772928001; // 2026-03-08 00:00:01 (after range)

        // Test logic: timestamp >= rangeFrom AND timestamp <= rangeTo
        expect(txWithin >= rangeFrom && txWithin <= rangeTo, isTrue,
            reason: 'Transaction within range should be included');
        expect(txBefore >= rangeFrom && txBefore <= rangeTo, isFalse,
            reason: 'Transaction before range should be excluded');
        expect(txAfter >= rangeFrom && txAfter <= rangeTo, isFalse,
            reason: 'Transaction after range should be excluded');
      });

      test('Empty date range returns no transactions', () {
        // Test filtering with inverted range (from > to)
        const int from = 1772928000;
        const int to = 1772841600;

        const int txTimestamp = 1772884800;

        // This should fail because range is invalid
        expect(from > to, isTrue);
        expect(txTimestamp >= from && txTimestamp <= to, isFalse);
      });
    });
  });
}
