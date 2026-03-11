# Integration Tests for Ginkgo Wallet

This directory contains integration tests for the Ginkgo wallet application using the **Patrol** framework.

## Overview

Integration tests simulate real user interactions with the app, testing complete workflows rather than individual functions. These tests help catch bugs that unit tests might miss, especially bugs involving multiple components working together.

## What are Integration Tests?

Integration tests:
- Start the entire app
- Simulate user interactions (taps, text input, navigation)
- Verify the app's behavior from a user's perspective
- Test real workflows like wallet creation, contact management, etc.

**Unlike unit tests:**
- Unit tests test small, isolated pieces of code
- Integration tests test how components work together

**Unlike end-to-end tests:**
- Integration tests often use mocks for external services (blockchain, network)
- This makes them faster and more reliable than connecting to real networks

## Test Organization

```
integration_test/
├── app_smoke_test.dart              # Basic app startup test
├── contact_search_v2_test.dart      # Critical: Tests v2 address truncation bug
├── wallet_creation_test.dart        # Tests wallet creation flows
├── contact_management_test.dart     # Tests contact search and management
├── navigation_test.dart              # Tests app navigation
├── helpers/
│   └── test_helpers.dart            # Common test utilities
└── README.md                         # This file
```

## Prerequisites

### 1. Install Patrol CLI

```bash
dart pub global activate patrol_cli
```

Verify installation:
```bash
patrol --version
```

### 2. Set Up Emulator/Device

**For Android:**
```bash
# Start Android emulator
emulator -avd <emulator_name>
```

**For iOS (macOS only):**
```bash
# Start iOS simulator
open -a Simulator
```

### 3. Flutter Environment

```bash
flutter pub get
```

## Running Tests

### Run All Integration Tests

```bash
# Start the first test on first available device/emulator
patrol test

# Run tests on specific device
patrol test --device <device-id>

# Run with verbose output
patrol test --verbose
```

### Run Specific Test File

```bash
# Run only the smoke test
patrol test integration_test/app_smoke_test.dart

# Run only the v2 address test (critical bug test)
patrol test integration_test/contact_search_v2_test.dart

# Run only wallet creation tests
patrol test integration_test/wallet_creation_test.dart

# Run only contact management tests
patrol test integration_test/contact_management_test.dart

# Run only navigation tests
patrol test integration_test/navigation_test.dart
```

### Run Specific Test Group

```bash
# Run only tests matching a specific pattern
patrol test -k "V2 Address"
patrol test -k "Wallet Creation"
patrol test -k "Contact"
```

### Run with Custom Configuration

```bash
# Run with longer timeout for slower devices
patrol test --verbose

# Run tests sequentially (default is parallel)
patrol test --concurrency 1
```

## Test Files Description

### `app_smoke_test.dart`
**Purpose:** Basic sanity check that the app starts and runs

**Tests:**
- App starts successfully
- App has required navigation structure

**Why:** Ensures the basic app infrastructure works before running other tests

---

### `contact_search_v2_test.dart` ⚠️ CRITICAL
**Purpose:** Tests the v2 address truncation bug

**Tests:**
- Full v2 address (49 chars) is NOT truncated to 44 chars
- V1 pubkey (43-44 chars) still works correctly
- Truncated v2 address (44 chars) is rejected or handled gracefully
- Mixed v1 and v2 addresses are both recognized

**Why:** This tests a known bug where v2 addresses were getting truncated. This is critical for wallet functionality.

**Bug Description:**
- V2 addresses are 49 characters: `g1KLWJ4jou6cgL1FEF4zJQo14Kc1Zc8mm8FAthK5bmf9cRSxY`
- V1 pubkeys are 43-44 characters: `BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5`
- If the app truncates v2 addresses to 44 chars, it loses the last 5 characters
- This makes the address invalid and breaks wallet transfers to v2 users

---

### `wallet_creation_test.dart`
**Purpose:** Tests wallet creation UI and flows

**Tests:**
- Can navigate to wallet creation options
- Wallet options dialog opens
- Multiple wallets can be listed
- App displays wallet interface correctly
- Can interact with wallet options without errors
- Navigation between tabs works
- Wallet list displays without scrolling errors
- Can see wallet balance or placeholder

**Why:** Ensures users can create and manage multiple wallets

---

### `contact_management_test.dart`
**Purpose:** Tests contact search and management

**Tests:**
- Can access contacts screen
- Search field is accessible
- Can add contact with v1 pubkey
- Can search for existing contacts
- Can add contact with v2 address
- Search with multiple characters works
- Invalid contact input shows appropriate response
- Contact search field accepts clipboard input
- Contact list displays without errors
- Can clear search field
- Edge cases (long strings, special characters, rapid searches)

**Why:** Contacts are core to wallet functionality - users need to search and add contacts

---

### `navigation_test.dart`
**Purpose:** Tests app navigation and UI responsiveness

**Tests:**
- App starts with correct main screen
- Bottom navigation bar has multiple tabs
- Can navigate between tabs
- All main screens are accessible
- Each screen (1-5) displays correctly
- Tab switching is smooth
- Back navigation works
- Screen content is visible
- Orientation changes are handled
- UI responds without lag
- No memory leaks from repeated navigation

**Why:** Navigation is fundamental - if navigation breaks, the whole app breaks

---

## Understanding Test Helpers

The `test_helpers.dart` file provides common utilities:

```dart
// Setup test environment (disable network calls)
await TestHelpers.setupTestEnvironment();

// Wait for a widget to appear
await TestHelpers.waitForWidget(tester, finder);

// Tap and wait for UI to settle
await TestHelpers.tapAndSettle(tester, finder);

// Enter text and wait for UI to settle
await TestHelpers.enterTextAndSettle(tester, finder, text);

// Find widget by key
TestHelpers.findByKey(keyString);

// Find widget by text content
TestHelpers.findByTextContaining(textSnippet);

// Clean up after tests
await TestHelpers.cleanupTestEnvironment();
```

## Writing New Tests

### Basic Test Structure

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/main.dart' as app;
import 'helpers/test_helpers.dart';

void main() {
  group('My Feature Group', () {
    setUpAll(() async {
      // Called once before all tests in this group
      await TestHelpers.setupTestEnvironment();
    });

    tearDownAll(() async {
      // Called once after all tests in this group
      await TestHelpers.cleanupTestEnvironment();
    });

    testWidgets('My test description', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Your test code here
      expect(find.byType(Scaffold), findsWidgets);
    });
  });
}
```

### Common Patterns

**Finding widgets:**
```dart
find.byType(MyWidget)           // Find by type
find.byIcon(Icons.add)          // Find by icon
find.byKey(ValueKey('mykey'))   // Find by key
find.byText('Hello')            // Find exact text
find.byWidgetPredicate(...)     // Find by custom condition
```

**User interactions:**
```dart
await tester.tap(finder);                                    // Tap
await tester.enterText(finder, 'text');                      // Type
await tester.testTextInput.receiveAction(TextInputAction.done); // Press enter
await tester.fling(finder, offset, velocity);                // Swipe
await tester.longPress(finder);                              // Long press
```

**Waiting:**
```dart
await tester.pumpAndSettle();                                 // Wait until UI settles
await tester.pumpAndSettle(Duration(seconds: 2));           // Wait with timeout
await TestHelpers.waitForWidget(tester, finder, timeout);   // Wait for specific widget
```

**Assertions:**
```dart
expect(finder, findsOneWidget);        // Exactly one widget
expect(finder, findsWidgets);          // One or more widgets
expect(finder, findsNothing);          // No widgets found
expect(value, isTrue);
expect(value, equals(expected));
```

## Troubleshooting

### Test Hangs

**Problem:** Test never completes
```
Solution: The app might be waiting for network. Check that DerivationScanService.skipNetworkCheck = true
```

### Widget Not Found

**Problem:** `find.byType(MyWidget)` returns nothing
```dart
// Debug: Print all widgets of a type
debugPrintBeginFrame = true;

// Alternative: Search for similar widgets
find.byWidgetPredicate((widget) => widget is Text && widget.data?.contains('expected text') ?? false)
```

### App Crashes During Test

**Problem:** Test crashes with exception
```
Solution: 
1. Check logs: patrol test --verbose
2. Ensure all required BLoCs are initialized
3. Check that MockSecureStorage is registered if needed
```

### Test Times Out

**Problem:** `tester.pumpAndSettle()` times out
```dart
// Increase timeout
await tester.pumpAndSettle(const Duration(seconds: 5));

// Or use multiple smaller waits
await tester.pumpAndSettle(const Duration(seconds: 1));
await tester.pumpAndSettle(const Duration(seconds: 1));
```

## Important Notes

⚠️ **Always set `DerivationScanService.skipNetworkCheck = true`**
- This is done in `test_helpers.dart`
- Prevents tests from making actual blockchain calls
- Makes tests fast and reliable

⚠️ **UI Testing is Fragile**
- Tests depend on UI structure
- If UI changes, tests may break
- Update tests when UI changes significantly

⚠️ **Not a Replacement for Unit Tests**
- Integration tests are slower than unit tests
- Use unit tests for business logic
- Use integration tests for user workflows

## CI/CD Integration

To run these tests in CI/CD:

```yaml
# Example GitHub Actions workflow
- name: Run Integration Tests
  run: |
    flutter pub get
    patrol test --verbose
```

## Performance Considerations

- Each test starts the entire app (slow)
- Tests run sequentially by default (change with `--concurrency`)
- Average test takes 5-10 seconds
- Full test suite takes 1-2 minutes

## Debugging Tips

1. **Add print statements**
   ```dart
   print('Debug: Before search');
   await tester.pumpAndSettle();
   print('Debug: After search');
   ```

2. **Use `--verbose` flag**
   ```bash
   patrol test --verbose
   ```

3. **Check dart logs**
   ```bash
   adb logcat | grep flutter
   ```

4. **Screenshot during test**
   ```dart
   await tester.binding.window.screenshotSize = const Size(540, 960);
   ```

## Resources

- [Patrol Documentation](https://pub.dev/packages/patrol)
- [Flutter Test Documentation](https://flutter.dev/docs/testing/integration-tests)
- [Flutter Test Recipes](https://flutter.dev/docs/cookbook#testing)

---

**Last Updated:** 2026-03-04  
**Framework:** Patrol 4.1.1  
**Flutter:** 3.41.2  
**Dart:** 3.11.0
