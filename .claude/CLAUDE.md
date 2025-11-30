# CLAUDE.md

@.claude/context/flutter-patterns.md

## After Reading This Document

When human says "Read CLAUDE.md", respond ONLY with:
"Read CLAUDE.md. Ready to implement BDD scenarios."

Do NOT:
- List questions about the workflow
- Ask about service setup (Vercel, Firebase, TestFlight)
- Ask about file organization
- Ask if gh CLI is authenticated
- Explain what you understood

If you genuinely don't understand something critical, ask ONE specific question.
Otherwise, just confirm ready and wait for BDD scenario.

---

## Project Purpose
Validate BDD contract-first development workflow using Flutter.
Single test suite runs on web + Android + iOS platforms.

## Tech Stack
- Flutter (cross-platform framework)
- Dart (programming language)
- integration_test package (E2E testing)
- Provider package (state management)

## Directory Structure
/docs/bdd/ - Gherkin BDD scenarios (human writes these)
/integration_test/ - E2E test files (you write these)
/lib/ - Application code (you write this)

## Development Workflow

Step 1: Read BDD scenario from /docs/bdd/*.feature
Step 2: Generate test plan covering all scenarios
Step 3: STOP and wait for human approval of test plan
Step 4: Implement integration test in /integration_test/
Step 5: Run flutter test integration_test/ locally - tests should FAIL
Step 6: Implement feature code in /lib/
Step 7: Run flutter test integration_test/ locally - tests should PASS
Step 8: Run git commit with message format: "feat: {description}"
Step 9: Run git push to feature branch

## Permissions

Run these commands WITHOUT asking:
- cat, ls, grep, find, view (read operations)
- flutter pub add {package}
- flutter pub get
- flutter test integration_test/
- git status, git add, git commit, git push, git branch, git checkout
- dart format lib/ integration_test/

ALWAYS ask human before:
- rm, deleting any files or directories
- Editing files in /integration_test/ directory
- Editing files in /docs/bdd/ directory
- Editing CLAUDE.md file
- Editing .github/workflows/ files
- flutter pub add (if adding new package beyond provider)

## Architecture Constraints

Write single codebase that works on web + Android + iOS.

Do NOT write platform-specific code unless absolutely necessary.
If platform-specific code is required:
1. Use: import 'dart:io' show Platform; or import 'package:flutter/foundation.dart' show kIsWeb;
2. Add comment explaining why platform-specific code is needed
3. Keep platform-specific code minimal

State management:
- Use Provider package for global state
- Use setState() for local widget state
- Do NOT add: Redux, Bloc, Riverpod, GetX, or other state libraries

Before adding ANY new package:
1. STOP
2. Explain: Why is this package needed?
3. Verify: Does it support web + Android + iOS?
4. Wait for human approval

## Testing Requirements

Use integration_test package (built into Flutter).
Same test code runs on all three platforms.

USE DATA-DRIVEN TESTING APPROACH:
1. Create test helper functions in integration_test/helpers.dart
2. Define test scenarios as data structures
3. Loop over scenarios to generate tests
4. Avoid duplicating test code for similar scenarios

Example structure:
```dart
// Define reusable actions
class TestHelpers {
  static Future<void> tapButton(WidgetTester tester, String key, {int times = 1}) async {
    for (int i = 0; i < times; i++) {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }
  }
}

// Define scenarios as data
final scenarios = [
  {'action': 'tap increment 1x', 'expected': '1'},
  {'action': 'tap increment 3x', 'expected': '3'},
];

// Generate tests from data
for (final scenario in scenarios) {
  testWidgets(scenario['action'], (tester) async {
    // Execute using helpers
  });
}
```

CRITICAL: Every interactive widget must have a Key:
- Buttons: key: Key('button-name')
- Text fields: key: Key('field-name')
- Display text: key: Key('value-name')

Tests automatically restart app before each test (clean state).

## BDD Scenario Standards

**Core Principle:** Givens describe WHAT state, not HOW you got there.

Implementation details (navigation, clicking, typing) belong in step definitions, NOT scenarios.

**Good BDD (Declarative State):**
```gherkin
Given the counter is at 0
When I increment once
Then the counter shows 1
```

**Bad BDD (Implementation Details):**
```gherkin
Given I launched the app
And I navigated to the home screen
And I waited for the counter to load
When I tap the button with key 'increment-button'
Then the Text widget displays '1'
```

**Rules:**
1. Givens set up state, not navigation steps
2. Whens describe user actions in business terms
3. Thens verify observable behavior
4. Never mention: Keys, widgets, class names, variable names, code structure
5. If your Given is longer than When+Then combined, you're doing it wrong

**For simple apps:** Default state can be implied
```gherkin
Scenario: Fresh start
  Then the counter shows 0

Scenario: Single increment
  When I tap increment
  Then the counter shows 1
```

**For complex state:** Use named states, not step-by-step setup
```gherkin
# Good
Given I have items in my cart
When I checkout
Then I see order confirmation

# Bad
Given I navigate to products
And I click "Add to Cart" on item 1
And I click "Add to Cart" on item 2
And I go to cart page
When I click checkout
Then I see confirmation
```

## Git Workflow

Branch naming: feature/{short-description}
Example: feature/counter-implementation

Commit message format: {type}: {description}
Types: feat, fix, test, refactor
Example: "feat: add counter increment functionality"

Create pull request to main branch after pushing.

## CI Test Failure Response

When human says: "See the CI results"

You should:
1. Run: gh pr checks
2. Run: gh run view --log-failed
3. Read the error output
4. Identify the failing test and error message
5. Fix the issue in code
6. Run: git commit -m "fix: {what you fixed}"
7. Run: git push
8. CI will automatically re-run tests

## Prohibited Actions

Do NOT:
- Write placeholder code like "// TODO: implement this"
- Write TODOs or FIXMEs
- Write code comments (code should be self-documenting)
- Write documentation files (README, docs, etc.) unless explicitly asked
- Skip test failures or commit failing tests
- Say "tests pass locally" when CI fails (CI is source of truth)
- Modify integration tests without human approval

## Test Execution Commands

Local testing (web only):
flutter test integration_test/

CI runs same tests on:
- Web (Chrome headless)
- Android (emulator)
- iOS (simulator)

All three must pass before preview deployment.

---

## Preview Deployment (For Human Manual Testing)

After all CI tests pass, GitHub Actions automatically deploys previews:

**Web Preview:**
- Runs: flutter build web --release
- Deploys to: Vercel (or Firebase Hosting)
- You receive: https://counter-app-pr-123.vercel.app
- Access: Click URL in PR comment, test in browser

**Android Preview:**
- Runs: flutter build apk --release
- Uploads to: Firebase App Distribution
- You receive: Email with install link
- Access: Click link on Android phone, install APK, test app

**iOS Preview:**
- Runs: flutter build ipa --release  
- Uploads to: TestFlight (Apple's beta system)
- You receive: Email invitation to test
- Access: Install TestFlight app, accept invite, test app

**Manual Testing Process:**
1. Wait for "All checks passed" + preview links in PR
2. Test web: Open URL, run through BDD scenarios
3. Test Android: Install from email, run through BDD scenarios
4. Test iOS: Install via TestFlight, run through BDD scenarios
5. If all match BDD → approve PR and merge
6. If behavior wrong → comment issue → Claude fixes → CI runs again