# 🚀 Quick Start Guide

Get your professional dice roller app running in minutes!

## Prerequisites

✅ Flutter SDK installed (3.3.3 or higher)  
✅ Android Studio or VS Code with Flutter plugins  
✅ An emulator or physical device  

Not sure if you have Flutter? Run: `flutter doctor`

## Step 1: Install Dependencies

Open a terminal in the project directory and run:

```bash
flutter pub get
```

This will download all required packages (~2-3 minutes first time).

## Step 2: Run the App

### On Emulator/Simulator
```bash
flutter run
```

### On Specific Device
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### On Chrome (Web)
```bash
flutter run -d chrome
```

## Step 3: Verify Everything Works

Once the app launches, you should see:

1. ✅ "Pro Dice Roller" title at the top
2. ✅ An animated dice in the center
3. ✅ "Roll Dice" button
4. ✅ Bottom navigation bar with 3 tabs
5. ✅ Smooth animations when rolling

## Step 4: Test Key Features

### Test Dice Rolling
1. Tap "Roll Dice" button
2. Watch the dice animate
3. See the new random value

### Test Multiple Dice
1. Select "2", "3", or more dice
2. Tap "Roll Dice"
3. See all dice roll and total calculated

### Test History
1. Roll dice a few times
2. Tap "History" tab at bottom
3. See all your previous rolls

### Test Statistics
1. Roll dice several times
2. Tap "Statistics" tab
3. See charts and analytics

### Test Theme
1. Tap settings icon (top right)
2. Toggle "Theme" switch
3. Watch app switch between light/dark

## Troubleshooting

### Issue: "flutter: command not found"
**Solution:** Install Flutter SDK from https://flutter.dev/docs/get-started/install

### Issue: Dependencies fail to download
**Solution:** 
```bash
flutter clean
flutter pub get
```

### Issue: App doesn't launch
**Solution:**
```bash
# Check for issues
flutter doctor

# Fix any reported problems
```

### Issue: "No devices found"
**Solution:**
```bash
# Start an emulator
flutter emulators --launch <emulator-id>

# Or connect a physical device via USB
```

### Issue: Build errors
**Solution:**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## Optional: Add Sound Effects

For a complete experience, add sound files:

1. Find or create two MP3 files:
   - `dice_roll.mp3` - Dice rolling sound
   - `success.mp3` - Success sound

2. Place them in: `assets/sounds/`

3. Enable sounds in Settings

## Next Steps

### Customize the App
1. **Change Colors:** Edit `lib/core/theme/app_theme.dart`
2. **Change App Name:** Edit `lib/core/constants/app_constants.dart`
3. **Add Features:** Follow the architecture in `ARCHITECTURE.md`

### Test Your Changes
```bash
flutter test
```

### Build for Distribution
```bash
# Android APK
flutter build apk --release

# iOS (requires Mac)
flutter build ios --release

# Web
flutter build web --release
```

## Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/features/dice_roller/dice_provider_test.dart
```

## Code Quality Checks

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Check for unused dependencies
flutter pub deps
```

## Development Tips

### Hot Reload
While app is running, press `r` to hot reload changes instantly!

### Hot Restart
Press `R` (capital R) to fully restart the app.

### DevTools
```bash
# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

## IDE Setup

### VS Code
1. Install "Flutter" extension
2. Install "Dart" extension
3. Use `F5` to debug

### Android Studio
1. Install Flutter plugin
2. Install Dart plugin
3. Click "Run" button

## Common Commands Cheat Sheet

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Clean build
flutter clean

# Check Flutter installation
flutter doctor

# List devices
flutter devices

# Build release APK
flutter build apk --release
```

## Project Structure Quick Reference

```
lib/
├── main.dart              ← Start here!
├── core/
│   ├── theme/            ← Customize colors
│   └── constants/        ← Change app name
├── features/
│   ├── dice_roller/      ← Main feature
│   ├── history/          ← History screen
│   ├── statistics/       ← Stats screen
│   └── settings/         ← Settings screen
└── shared/
    ├── models/           ← Data structures
    └── widgets/          ← Reusable UI
```

## Getting Help

### Documentation
- `README.md` - Project overview
- `ARCHITECTURE.md` - Technical details
- `UPGRADE_SUMMARY.md` - What's new
- `CONTRIBUTING.md` - Development guide

### Online Resources
- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

## Performance Tips

### For Smoother Animations
```bash
# Run in profile mode
flutter run --profile
```

### For Better Performance
```bash
# Build in release mode
flutter run --release
```

## Success Checklist

After setup, you should have:

- [x] App running on device/emulator
- [x] No errors in console
- [x] All features working:
  - [x] Dice rolling
  - [x] Multiple dice
  - [x] History tracking
  - [x] Statistics display
  - [x] Theme switching
  - [x] Settings saved
- [x] Tests passing: `flutter test`
- [x] No analysis issues: `flutter analyze`

## Ready for Portfolio?

Before showcasing:

1. ✅ Take screenshots of all screens
2. ✅ Record a demo video
3. ✅ Update README with your name/links
4. ✅ Test on multiple devices
5. ✅ Build release version
6. ✅ Add to GitHub with good commit messages
7. ✅ Deploy web version (optional)

## Need More Help?

Check the other documentation files:
- Technical questions → `ARCHITECTURE.md`
- Want to contribute → `CONTRIBUTING.md`
- See all changes → `UPGRADE_SUMMARY.md`

---

**You're all set! Enjoy your professional dice roller app! 🎲**

*If you encounter any issues, make sure to check `flutter doctor` first.*
