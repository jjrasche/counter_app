# Flutter + BDD Patterns

This context is always loaded to help Claude understand project patterns.

## Widget Key Naming Convention

**Always use descriptive, action-based keys:**

```dart
// ✅ Good
key: Key('submit-button')
key: Key('email-input')
key: Key('error-message')
key: Key('user-list-item-0')

// ❌ Bad
key: Key('button1')
key: Key('widget')
key: Key('temp')
```

## Integration Test Helper Pattern

**Create reusable helpers in `integration_test/helpers.dart`:**

```dart
class TestHelpers {
  // Action helpers
  static Future<void> tapButton(WidgetTester tester, String key) async {
    await tester.tap(find.byKey(Key(key)));
    await tester.pumpAndSettle();
  }

  // Verification helpers
  static void verifyText(WidgetTester tester, String text) {
    expect(find.text(text), findsOneWidget);
  }
}
```

## Data-Driven Test Pattern

**Use scenarios as data, not duplicated test code:**

```dart
final scenarios = [
  {'input': '5', 'expected': '5'},
  {'input': '10', 'expected': '10'},
];

for (final scenario in scenarios) {
  testWidgets(scenario['input'], (tester) async {
    // Use helpers
  });
}
```

## BDD Scenario Style

**Declarative (what), not imperative (how):**

```gherkin
# ✅ Good
Given the user is logged out
When I log in with valid credentials
Then I see the dashboard

# ❌ Bad (too implementation-focused)
Given I navigate to the login screen
And I tap the email field with key 'email-input'
And I type 'user@example.com'
When I tap the button with key 'login-button'
Then the Text widget shows 'Dashboard'
```

## State Management

**This project uses setState() by default:**

- Local widget state → `setState()`
- Shared state → Add Provider if needed
- Don't add state management until actually needed

## File Organization

```
lib/
├── main.dart              # App entry
├── screens/               # UI screens
├── widgets/               # Reusable widgets
└── models/                # Data models

integration_test/
├── helpers.dart           # Reusable test helpers
└── feature_test.dart      # Feature tests (match BDD scenarios)

docs/bdd/
└── feature.feature        # Gherkin scenarios
```

## Common Mistakes to Avoid

1. **Don't hardcode widget finders**
   ```dart
   // ❌ Bad
   find.text('Submit')

   // ✅ Good
   find.byKey(Key('submit-button'))
   ```

2. **Don't skip pumpAndSettle**
   ```dart
   // ❌ Bad
   await tester.tap(find.byKey(Key('button')));

   // ✅ Good
   await tester.tap(find.byKey(Key('button')));
   await tester.pumpAndSettle();
   ```

3. **Don't write platform-specific code without comments**
   ```dart
   // ❌ Bad
   if (Platform.isIOS) { ... }

   // ✅ Good
   // iOS uses different padding for safe area
   if (Platform.isIOS) { ... }
   ```

## Quick Reference

**Run tests:** `flutter test integration_test/`
**Format code:** `dart format .`
**Analyze:** `flutter analyze`
**Build web:** `flutter build web --release`
**Build Android:** `flutter build apk --release`
