# Using This as a Flutter App Template

This project is a **production-ready template** for cross-platform Flutter apps with BDD testing and automated deployment.

## What This Template Provides

✅ **BDD Workflow**
- Gherkin scenarios in `docs/bdd/`
- Integration tests that match scenarios
- Test helpers for reusable actions
- Claude Code instructions for AI-assisted development

✅ **CI/CD Pipeline**
- Automated testing on PR (Web + Android)
- Automated builds
- Firebase deployment (Hosting + App Distribution)
- Preview URLs for testing

✅ **Claude Code Integration**
- Custom slash commands (`/new-feature`, `/run-tests`, `/check-deploy`)
- `.claudeignore` to skip unnecessary files
- BDD workflow instructions in `.claude/CLAUDE.md`

## Quick Start: New Project from Template

### 1. Copy Template Files

```bash
# Create new Flutter project
flutter create my_new_app
cd my_new_app

# Copy template files from counter_app
cp -r ../counter_app/.claude .
cp -r ../counter_app/.github .
cp ../counter_app/.claudeignore .
cp ../counter_app/.firebaserc .
cp ../counter_app/firebase.json .
cp ../counter_app/test_driver .
cp -r ../counter_app/docs .
cp ../counter_app/TEMPLATE_SETUP.md .
```

### 2. Update Project-Specific Values

**pubspec.yaml:**
```yaml
name: my_new_app  # Your app name
description: Your app description
```

**firebase.json:** (already configured)

**.firebaserc:**
```json
{
  "projects": {
    "default": "your-firebase-project-id"
  }
}
```

**.github/workflows/deploy.yml:**
- Replace `counter-app-REPLACE-ME` with your Firebase project ID (2 places)

**lib/main.dart:**
- Replace counter app with your app code

### 3. Set Up Firebase

```bash
# 1. Create Firebase project at console.firebase.google.com
# 2. Enable Hosting
# 3. Register Android app
# 4. Register iOS app (optional)
# 5. Create service account for CI
```

### 4. Add GitHub Secrets

Required secrets (Settings → Secrets → Actions):

- `FIREBASE_SERVICE_ACCOUNT` - Service account JSON
- `FIREBASE_ANDROID_APP_ID` - Android app ID from Firebase
- `FIREBASE_IOS_APP_ID` - iOS app ID (if using iOS)

### 5. Start Building with BDD

```bash
# Use Claude Code to create your first feature
/new-feature
```

## Template Structure

```
my_new_app/
├── .claude/
│   ├── CLAUDE.md              # BDD workflow instructions for AI
│   └── commands/              # Custom slash commands
│       ├── new-feature.md     # Start new BDD feature
│       ├── run-tests.md       # Run and debug tests
│       └── check-deploy.md    # Check deployment status
├── .github/workflows/
│   ├── ci.yml                 # Test automation
│   └── deploy.yml             # Build & deploy automation
├── docs/
│   ├── bdd/                   # Gherkin scenarios (you write these)
│   │   └── *.feature
│   └── ADDING_IOS_DEPLOYMENT.md  # iOS setup guide
├── integration_test/
│   ├── *_test.dart            # Integration tests (AI writes these)
│   └── helpers.dart           # Reusable test actions
├── test_driver/
│   └── integration_test.dart  # Web test driver
├── lib/                       # Your app code
├── .claudeignore              # Files Claude Code should skip
├── firebase.json              # Firebase Hosting config
└── .firebaserc                # Firebase project reference
```

## Files to Customize

**Always customize:**
- `lib/` - Your app code
- `docs/bdd/*.feature` - Your BDD scenarios
- `integration_test/*_test.dart` - Your integration tests
- `pubspec.yaml` - App name, dependencies
- `.firebaserc` - Your Firebase project ID
- `.github/workflows/deploy.yml` - Your Firebase project ID

**Optional customize:**
- `.claude/CLAUDE.md` - Adjust BDD workflow for your needs
- `.claude/commands/*.md` - Add project-specific commands
- `.claudeignore` - Add files specific to your project

**Don't customize (keep as-is):**
- `test_driver/integration_test.dart` - Standard driver
- `firebase.json` - Standard hosting config
- `.github/workflows/ci.yml` - Standard test workflow (mostly)

## Development Workflow with Template

### Step 1: Write BDD Scenario

Create `docs/bdd/your-feature.feature`:

```gherkin
Feature: Your Feature

Scenario: Your scenario
  Given some initial state
  When I perform an action
  Then I see expected result
```

### Step 2: Generate Tests

Use Claude Code:
```
/new-feature
```

Or manually create `integration_test/your_feature_test.dart`

### Step 3: Implement Feature

Write code in `lib/` to make tests pass

### Step 4: Run Tests

```
/run-tests
```

Or manually:
```bash
flutter test integration_test/
```

### Step 5: Deploy

```bash
git add .
git commit -m "feat: add your feature"
git push
```

CI automatically:
- Runs tests
- Builds apps
- Deploys to Firebase
- Posts preview URLs

## Custom Slash Commands

Use these in Claude Code:

- `/new-feature` - Start new BDD feature workflow
- `/run-tests` - Run integration tests and show results
- `/check-deploy` - Check CI/CD status and get preview URLs

## Tips for Template Reuse

**1. Keep Template Updated**

Save this `counter_app` as a reference:
```bash
# Clone as template reference
git clone https://github.com/you/counter_app flutter-bdd-template
cd flutter-bdd-template
git remote remove origin
```

**2. Version Control Template Files**

Track template files separately:
```bash
# In your template repo
git tag v1.0.0
git push --tags

# When updating template
git tag v1.1.0
```

**3. Reduce Claude Code Noise**

Always use `.claudeignore` to skip:
- Build outputs (`build/`, `.dart_tool/`)
- Platform folders (`android/`, `ios/`, etc.)
- Generated files (`*.g.dart`, `*.freezed.dart`)
- Dependencies (`.pub-cache/`)

**4. Add Project-Specific Commands**

Create `.claude/commands/your-command.md` for common tasks:
- Database migrations
- API endpoint updates
- Specific test scenarios

## What Makes This Template Great

**For You:**
- ✅ Skip boilerplate setup for every project
- ✅ BDD workflow enforced from day one
- ✅ CI/CD ready immediately
- ✅ Firebase deployment configured
- ✅ Claude Code optimized

**For Claude Code:**
- ✅ Clear instructions in CLAUDE.md
- ✅ Ignores unnecessary files
- ✅ Custom commands for common tasks
- ✅ Consistent project structure

**For Your Team:**
- ✅ Standardized testing approach
- ✅ Automated quality checks
- ✅ Preview deployments for QA
- ✅ Documentation built-in

## Common Customizations

### Add More Test Platforms

In `.github/workflows/ci.yml`, restore iOS:
```yaml
platform: [web, android, ios]  # Add iOS back
```

### Use Different State Management

The template uses `setState()`. To use Provider/Riverpod/Bloc:

1. Add dependency to `pubspec.yaml`
2. Update app code in `lib/`
3. Keep integration tests the same (they test behavior, not implementation)

### Add Code Generation

For models/serialization:

1. Add `build_runner` to `dev_dependencies`
2. Add to `.claudeignore`: `*.g.dart`, `*.freezed.dart`
3. Run `flutter pub run build_runner build` before tests

### Change Firebase Services

Template uses Hosting + App Distribution. To add:

- **Firestore:** Add to `firebase.json`, update security rules
- **Cloud Functions:** Create `functions/` directory
- **Authentication:** Enable in Firebase Console

## Troubleshooting Template Usage

**Tests fail in new project:**
- Did you update widget Keys?
- Did you update BDD scenarios?
- Did you update test assertions?

**Deployment fails:**
- Did you update Firebase project ID?
- Did you add GitHub secrets?
- Did you enable Firebase Hosting?

**Claude Code reads too many files:**
- Check `.claudeignore` is present
- Add project-specific ignores

**iOS builds fail:**
- iOS is commented out by default
- See `docs/ADDING_IOS_DEPLOYMENT.md`

## Next Steps

1. **Clone this template** for your new project
2. **Customize** project-specific values
3. **Set up Firebase** and GitHub secrets
4. **Start with** `/new-feature` in Claude Code
5. **Push code** and watch CI/CD work!

---

**This template proves:** BDD + Flutter + Firebase + Claude Code = Fast, reliable, cross-platform development.
