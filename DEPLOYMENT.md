# Deployment Setup

This project uses Firebase for automated deployments across all three platforms:
- **Web**: Firebase Hosting (with preview channels for PRs)
- **Android**: Firebase App Distribution
- **iOS**: Firebase App Distribution (simulator builds only, no code signing)

## Firebase Project Setup

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **Add project**
3. Enter project name (e.g., `counter-app`)
4. Disable Google Analytics (optional for this demo)
5. Click **Create project**

### 2. Update Project ID

Edit `.firebaserc` and replace `counter-app-REPLACE-ME` with your actual Firebase project ID:

```json
{
  "projects": {
    "default": "your-firebase-project-id"
  }
}
```

Also update the `projectId` in `.github/workflows/deploy.yml` (2 occurrences).

### 3. Enable Firebase Hosting

1. In Firebase Console, go to **Build** → **Hosting**
2. Click **Get started**
3. Follow the setup wizard (you can skip the CLI commands, we already have firebase.json)

### 4. Register Apps in Firebase

#### Web App (for Hosting)
Already configured via Hosting setup above.

#### Android App
1. In Firebase Console, click **Add app** → **Android**
2. Enter Android package name: `com.example.counter_app`
3. Download `google-services.json` (optional for this demo)
4. Copy the **App ID** (format: `1:123456789:android:abc123def456`)
5. Save this for GitHub Secrets setup

#### iOS App
1. In Firebase Console, click **Add app** → **iOS**
2. Enter iOS bundle ID: `com.example.counterApp`
3. Download `GoogleService-Info.plist` (optional for this demo)
4. Copy the **App ID** (format: `1:123456789:ios:abc123def456`)
5. Save this for GitHub Secrets setup

### 5. Enable Firebase App Distribution

1. Go to **Release & Monitor** → **App Distribution**
2. Click **Get started**
3. Create a tester group named `testers`
4. Add email addresses of testers

## GitHub Secrets Setup

### Required Secrets

Add these secrets in GitHub: **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

#### 1. FIREBASE_SERVICE_ACCOUNT

This is a JSON key for a Google Cloud service account with Firebase permissions.

**To create:**

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Go to **IAM & Admin** → **Service Accounts**
4. Click **Create Service Account**
5. Name: `github-actions-deploy`
6. Click **Create and Continue**
7. Grant roles:
   - **Firebase Hosting Admin**
   - **Firebase App Distribution Admin**
8. Click **Continue** → **Done**
9. Click on the created service account
10. Go to **Keys** tab → **Add Key** → **Create new key**
11. Choose **JSON** format
12. Download the JSON file
13. Copy the **entire contents** of the JSON file
14. In GitHub, create secret `FIREBASE_SERVICE_ACCOUNT` and paste the JSON

#### 2. FIREBASE_ANDROID_APP_ID

The App ID from step 4 (Android App) above.

Format: `1:123456789:android:abc123def456`

#### 3. FIREBASE_IOS_APP_ID

The App ID from step 4 (iOS App) above.

Format: `1:123456789:ios:abc123def456`

## How Deployment Works

### On Pull Request

When you create a PR to `main`:

1. **Build Jobs** run in parallel:
   - Web build (`flutter build web --release`)
   - Android build (`flutter build apk --release`)
   - iOS build (`flutter build ios --release --no-codesign`)

2. **Deploy Jobs** run after builds complete:
   - **Web**: Deploys to Firebase Hosting preview channel
     - Creates a unique preview URL (expires in 7 days)
     - Posts URL as PR comment
   - **Android**: Uploads APK to Firebase App Distribution
     - Sends notification to `testers` group
   - **iOS**: Uploads IPA to Firebase App Distribution
     - ⚠️ **Cannot be installed on physical devices** (no code signing)
     - For documentation/process validation only

### On Merge to Main

When PR is merged to `main`:

1. Same build jobs run
2. **Deploy Jobs** deploy to production:
   - **Web**: Deploys to Firebase Hosting live channel
     - Updates production URL
   - **Android**: Uploads to App Distribution (same as PR)
   - **iOS**: Uploads to App Distribution (same as PR, still unsigned)

## Testing Preview Deployments

### Web
1. Create a PR
2. Wait for deployment to complete
3. Check PR comments for preview URL
4. Open URL in browser and test

### Android
1. Create a PR
2. Wait for deployment to complete
3. Testers receive email from Firebase App Distribution
4. Install from link on Android device
5. Test the app

### iOS (Simulator Only)
1. ⚠️ **IPA cannot be installed on physical devices**
2. Build is created to prove the process works
3. CI already tests iOS functionality via simulator
4. For manual testing, see "iOS Physical Device Testing" below

## iOS Physical Device Testing

The iOS builds are created with `--no-codesign` and **cannot be installed on physical devices**.

### Why?

- Code signing requires Apple Developer Account ($99/year)
- This setup is for proving the BDD workflow, not production distribution
- CI tests in simulator provide sufficient validation

### To Enable Physical Device Testing

If you need to test on physical iOS devices:

#### Option 1: Free Provisioning (Personal Team)
- Limited to your own devices
- Builds expire in 7 days
- No cost

**Steps:**
1. Remove `--no-codesign` from `.github/workflows/deploy.yml`
2. Add `--export-options-plist=ios/ExportOptions.plist`
3. Set up signing in Xcode with your Apple ID
4. Export provisioning profile as GitHub secret
5. Update workflow to import profile before build

#### Option 2: Apple Developer Program ($99/year)
- Can distribute to external testers
- Proper enterprise distribution
- No expiration limits

**Steps:**
1. Enroll in Apple Developer Program
2. Create App ID in Apple Developer Portal
3. Create distribution certificate
4. Create provisioning profile
5. Store certificate + profile as GitHub secrets
6. Update workflow to use proper signing

**Resources:**
- [Apple Developer Account](https://developer.apple.com/programs/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [Code Signing Guide](https://docs.flutter.dev/deployment/ios#create-a-build-archive-with-xcode)

## Troubleshooting

### Web deployment fails
- Check that `build/web` directory exists after build
- Verify `FIREBASE_SERVICE_ACCOUNT` secret is valid JSON
- Check Firebase project ID matches in `.firebaserc`

### Android deployment fails
- Verify `FIREBASE_ANDROID_APP_ID` is correct format
- Check that APK was built successfully
- Ensure `testers` group exists in Firebase Console

### iOS deployment fails
- iOS build creates IPA but it's unsigned
- This is expected - see "iOS Physical Device Testing" above
- Deployment to App Distribution may still work (for process validation)

### No preview URL in PR comments
- Ensure `GITHUB_TOKEN` has permissions (automatically provided)
- Check workflow logs for errors
- Verify Firebase Hosting is enabled in Console

## Local Testing

You can test builds locally before pushing:

```bash
# Web
flutter build web --release
firebase serve

# Android (requires Android device/emulator connected)
flutter build apk --release
flutter install

# iOS (requires macOS)
flutter build ios --release --no-codesign
# Can only run in simulator, not on physical devices
```

## Cost Considerations

Firebase free tier (Spark Plan) includes:
- **Hosting**: 10 GB storage, 360 MB/day transfer
- **App Distribution**: Unlimited

For this demo app, free tier is sufficient. Upgrade to Blaze Plan (pay-as-you-go) if you exceed limits.

GitHub Actions free tier:
- **2,000 minutes/month** for private repos
- **Unlimited** for public repos

Note: macOS runners consume minutes **10x faster** (1 minute = 10 minutes consumed).
