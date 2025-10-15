DiceLab – Professional Flutter Dice Simulator 🎲

DiceLab is a polished, production-grade, multi-platform Flutter app showcasing modern architecture, animations, routing, and state management. Ideal for portfolio demos and real-world distribution.

Key features

- Professional Material 3 UI, light/dark themes with Google Fonts
- Riverpod state management with persistent settings (theme) and roll history
- GoRouter navigation with bottom navigation shell (Home, History, Settings)
- Roll animation and accessible controls
- Multi-platform ready (Android, iOS, Web, Desktop)

Architecture

- `lib/core`: router, app-wide providers, persistence
- `lib/features`: feature-first modules (`home`, `history`, `settings`)
- `lib/widgets`: shared UI widgets (scaffold)

Development

```bash
flutter pub get
flutter run -d chrome  # or android/ios/desktop
```

Testing

```bash
flutter test
```

Branding

- Android label: DiceLab
- iOS display/name: DiceLab

Notes

- This project uses Material 3 and requires Flutter 3.19+.
