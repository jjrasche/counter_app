# Adding iOS Deployment

iOS deployment is currently disabled because Firebase App Distribution requires **signed IPAs**, which need Apple Developer Account setup.

## Current State

**What Works:**
- ✅ Web: Full deployment to Firebase Hosting
- ✅ Android: Full deployment to Firebase App Distribution

**What's Disabled:**
- ❌ iOS tests (commented out in `.github/workflows/ci.yml`)
- ❌ iOS builds (commented out in `.github/workflows/deploy.yml`)
- ❌ iOS deployment (commented out)

## Why iOS is Disabled

Firebase App Distribution **cannot accept unsigned IPAs**. iOS apps must be code-signed to install on physical devices.

**Options:**
1. **Apple Developer Program** ($99/year) - Recommended for external testers
2. **Free Provisioning** (No cost) - Limited to 3 devices, 7-day expiry

## Steps to Enable iOS Deployment

### 1. Get Apple Developer Account

**Option A: Paid ($99/year) - Recommended**

1. Go to [Apple Developer Program](https://developer.apple.com/programs/)
2. Click "Enroll"
3. Sign in with your Apple ID
4. Complete enrollment ($99 USD/year)
5. Wait for approval (usually 24-48 hours)

**Option B: Free Provisioning (Limited)**

- Use your personal Apple ID
- Limited to 3 test devices
- Apps expire every 7 days
- Not recommended for team testing

### 2. Create Code Signing Identities

**Using Xcode (macOS required):**

1. Open Xcode → Preferences → Accounts
2. Add your Apple ID
3. Select your team
4. Click "Manage Certificates"
5. Click "+" → "Apple Distribution"
6. Export certificate:
   - Right-click certificate → Export
   - Save as `.p12` file with password
   - Keep password secure (needed for CI)

### 3. Create Provisioning Profile

**In Apple Developer Portal:**

1. Go to [Certificates, IDs & Profiles](https://developer.apple.com/account/resources)
2. Click **Identifiers** → **+** (new App ID)
   - Description: `Counter App`
   - Bundle ID: `com.example.counterApp` (match your app)
   - Click "Register"
3. Click **Profiles** → **+** (new profile)
   - Select "App Store" distribution
   - Select your App ID
   - Select your certificate
   - Name: `Counter App Distribution`
   - Download the `.mobileprovision` file

### 4. Add Secrets to GitHub

**Required secrets** (Settings → Secrets → Actions):

**IOS_CERTIFICATE_P12**
- Base64 encode your `.p12` file:
  ```bash
  base64 -i certificate.p12 | pbcopy
  ```
- Paste the base64 string

**IOS_CERTIFICATE_PASSWORD**
- The password you used when exporting the certificate

**IOS_PROVISIONING_PROFILE**
- Base64 encode your `.mobileprovision` file:
  ```bash
  base64 -i profile.mobileprovision | pbcopy
  ```
- Paste the base64 string

**FIREBASE_IOS_APP_ID**
- Already set (from Firebase Console)

### 5. Update Workflows

**In `.github/workflows/ci.yml`:**

Uncomment iOS test section:
```yaml
strategy:
  matrix:
    platform: [web, android, ios]  # Add ios back
    include:
      - platform: ios
        os: macos-latest
        device: iPhone
```

Uncomment iOS test steps (lines 54-65)

**In `.github/workflows/deploy.yml`:**

1. Uncomment `build-ios` job (lines 53-78)

2. Update build step to use signing:
```yaml
- name: Build iOS IPA
  run: |
    # Import certificate
    echo "${{ secrets.IOS_CERTIFICATE_P12 }}" | base64 --decode > certificate.p12
    security create-keychain -p "" build.keychain
    security import certificate.p12 -k build.keychain -P "${{ secrets.IOS_CERTIFICATE_PASSWORD }}" -T /usr/bin/codesign
    security set-keychain-settings -t 3600 -u build.keychain
    security default-keychain -s build.keychain
    security unlock-keychain -p "" build.keychain

    # Import provisioning profile
    echo "${{ secrets.IOS_PROVISIONING_PROFILE }}" | base64 --decode > profile.mobileprovision
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    cp profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

    # Build with signing
    flutter build ipa --release --export-options-plist=ios/ExportOptions.plist
```

3. Create `ios/ExportOptions.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.example.counterApp</key>
        <string>Counter App Distribution</string>
    </dict>
</dict>
</plist>
```

4. Uncomment `deploy-ios` job (lines 133-158)

### 6. Test the Workflow

1. Commit and push changes
2. Check CI workflow runs successfully
3. Verify signed IPA uploads to Firebase App Distribution
4. Install on test device from Firebase email

## Cost Breakdown

**Apple Developer Program:**
- $99 USD/year
- Required for distribution to external testers
- No per-app fees
- Includes TestFlight access

**GitHub Actions:**
- macOS runners: 10x cost multiplier
- ~10 minutes per iOS build = 100 minutes consumed
- Free tier: 2,000 minutes/month (private repos)
- iOS builds consume minutes quickly

**Firebase:**
- App Distribution: Free (unlimited)
- Hosting: Free tier sufficient

## Alternative: TestFlight

If you have Apple Developer Account, consider TestFlight instead of Firebase App Distribution for iOS:

**Pros:**
- Official Apple beta distribution
- Better iOS user experience
- Up to 10,000 external testers
- Automatic app updates

**Cons:**
- Apps require Apple review (24-48 hours)
- More complex setup
- Separate from Android distribution

**To use TestFlight:**
- Use `fastlane` for deployment automation
- See: [Flutter iOS deployment docs](https://docs.flutter.dev/deployment/ios)

## Quick Reference

**Enable iOS when ready:**
1. ✅ Get Apple Developer Account ($99/year)
2. ✅ Create certificates & profiles
3. ✅ Add GitHub secrets (4 required)
4. ✅ Uncomment workflow files
5. ✅ Create ExportOptions.plist
6. ✅ Push and test

**Current working platforms:**
- Web → Firebase Hosting ✅
- Android → Firebase App Distribution ✅
- iOS → Disabled (waiting for signing setup) ⏸️
