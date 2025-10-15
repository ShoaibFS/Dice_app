# 🎲 Pro Dice Roller

A professional, feature-rich dice rolling application built with Flutter, showcasing modern mobile development practices, clean architecture, and beautiful UI/UX design.

[![Flutter](https://img.shields.io/badge/Flutter-3.3.3+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

### Core Features
- 🎲 **Multiple Dice Rolling** - Roll 1-6 dice simultaneously
- 📊 **Advanced Statistics** - Comprehensive roll analytics with charts
- 📜 **Roll History** - Track all your previous rolls with timestamps
- 🎨 **Beautiful Animations** - Smooth, professional animations and transitions
- 🌓 **Dark/Light Themes** - Elegant themes with smooth transitions
- 🔊 **Sound Effects** - Immersive audio feedback (optional)
- 📳 **Haptic Feedback** - Physical feedback on supported devices
- 💾 **Persistent Storage** - All data saved locally

### Technical Highlights
- 🏗️ **Clean Architecture** - Feature-based modular structure
- 🔄 **State Management** - Riverpod for reactive state management
- 🎯 **Type Safety** - Fully typed with strong Dart type system
- 📱 **Responsive Design** - Works on phones and tablets
- 🧪 **Testable Code** - Well-structured for unit and widget testing
- 📦 **Dependency Injection** - Proper DI patterns with Riverpod

## 📸 Screenshots

> Add screenshots of your app here when ready

## 🏗️ Architecture

The app follows **Clean Architecture** principles with a feature-based structure:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App-wide constants
│   ├── theme/              # Theme configuration
│   └── utils/              # Utility classes
│       ├── sound_manager.dart
│       ├── haptic_manager.dart
│       └── storage_service.dart
├── features/               # Feature modules
│   ├── dice_roller/       # Main dice rolling feature
│   │   ├── models/
│   │   ├── providers/
│   │   └── widgets/
│   ├── history/           # Roll history feature
│   ├── statistics/        # Statistics & analytics
│   └── settings/          # App settings
└── shared/                # Shared resources
    ├── models/            # Shared data models
    └── widgets/           # Reusable widgets
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.3.3)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter plugins

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd first_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 📦 Dependencies

### Core
- `flutter_riverpod` - State management
- `google_fonts` - Custom typography
- `shared_preferences` - Local storage
- `hive` - Fast key-value database

### UI & Animations
- `flutter_animate` - Animation utilities
- `animations` - Pre-built animations
- `fl_chart` - Beautiful charts

### Utilities
- `uuid` - Unique ID generation
- `intl` - Internationalization
- `equatable` - Value equality
- `audioplayers` - Sound effects
- `vibration` - Haptic feedback

## 🎯 Key Concepts Demonstrated

### State Management with Riverpod
```dart
final diceProvider = StateNotifierProvider<DiceNotifier, DiceState>((ref) {
  return DiceNotifier(/* dependencies */);
});
```

### Clean Architecture Layers
1. **Presentation Layer** - UI widgets and screens
2. **Business Logic Layer** - Providers and state management
3. **Data Layer** - Models and storage services

### Immutable State
All state classes use immutability patterns with `copyWith` methods:
```dart
DiceState copyWith({
  List<int>? currentValues,
  bool? isRolling,
  int? diceCount,
}) { ... }
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 🎨 Design Patterns Used

- **Provider Pattern** - Dependency injection and state management
- **Repository Pattern** - Data access abstraction
- **Observer Pattern** - Reactive state updates
- **Factory Pattern** - Object creation
- **Singleton Pattern** - Shared service instances

## 🔧 Configuration

### Theme Customization
Edit `lib/core/theme/app_theme.dart` to customize colors and styles.

### Add Sound Effects
1. Add `.mp3` files to `assets/sounds/`
2. Update `pubspec.yaml` if needed
3. Files used: `dice_roll.mp3`, `success.mp3`

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🤝 Contributing

This is a portfolio project, but suggestions and feedback are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Your Name**
- Portfolio: [your-portfolio.com]
- GitHub: [@yourusername]
- LinkedIn: [your-linkedin]

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for excellent state management
- FL Chart for beautiful charting library
- Google Fonts for typography

## 📈 Future Enhancements

- [ ] Custom dice configurations (4, 8, 10, 12, 20-sided dice)
- [ ] Multiplayer mode
- [ ] Cloud sync
- [ ] Achievements system
- [ ] Share results
- [ ] Export statistics
- [ ] Widgets for home screen
- [ ] Apple Watch support

---

**Made with ❤️ and Flutter**
