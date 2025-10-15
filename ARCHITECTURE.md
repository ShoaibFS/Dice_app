# Architecture Documentation

## Overview

Pro Dice Roller follows **Clean Architecture** principles with a feature-based modular structure. This document explains the architectural decisions and patterns used.

## Architecture Layers

### 1. Presentation Layer
Located in `lib/features/*/widgets/`

**Responsibilities:**
- Display UI components
- Handle user interactions
- Observe state changes
- No business logic

**Technologies:**
- Flutter widgets
- Material Design 3
- Custom animations
- Responsive layouts

### 2. Business Logic Layer
Located in `lib/features/*/providers/`

**Responsibilities:**
- State management
- Business rules
- Data transformation
- Service coordination

**Technologies:**
- Riverpod StateNotifier
- Provider pattern
- Immutable state

### 3. Data Layer
Located in `lib/shared/models/` and `lib/core/utils/`

**Responsibilities:**
- Data models
- Storage operations
- External service calls
- Data serialization

**Technologies:**
- SharedPreferences
- Hive (for complex data)
- JSON serialization

## Project Structure

```
lib/
├── core/                           # Core functionality
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart     # Configuration values
│   ├── theme/                      # Theme configuration
│   │   └── app_theme.dart         # Light/Dark themes
│   └── utils/                      # Utility services
│       ├── sound_manager.dart     # Sound effects
│       ├── haptic_manager.dart    # Haptic feedback
│       └── storage_service.dart   # Persistent storage
│
├── features/                       # Feature modules
│   ├── dice_roller/               # Main feature
│   │   ├── models/                # Feature-specific models
│   │   ├── providers/             # State management
│   │   │   └── dice_provider.dart # Dice rolling logic
│   │   └── widgets/               # UI components
│   │       └── dice_roller_screen.dart
│   │
│   ├── history/                   # Roll history
│   │   └── widgets/
│   │       └── history_screen.dart
│   │
│   ├── statistics/                # Analytics
│   │   ├── providers/
│   │   │   └── statistics_provider.dart
│   │   └── widgets/
│   │       └── statistics_screen.dart
│   │
│   └── settings/                  # App settings
│       ├── providers/
│       │   └── settings_provider.dart
│       └── widgets/
│           └── settings_screen.dart
│
├── shared/                        # Shared resources
│   ├── models/                    # Shared data models
│   │   ├── dice_roll.dart        # Roll data structures
│   │   └── dice_statistics.dart  # Statistics models
│   └── widgets/                   # Reusable widgets
│       ├── animated_dice.dart    # Dice animation
│       └── gradient_background.dart
│
└── main.dart                      # App entry point
```

## State Management

### Riverpod Architecture

We use **Riverpod** for state management with the following pattern:

```dart
// 1. State class (immutable)
class DiceState {
  final List<int> currentValues;
  final bool isRolling;
  
  const DiceState({
    this.currentValues = const [1],
    this.isRolling = false,
  });
  
  DiceState copyWith({...}) { ... }
}

// 2. StateNotifier (business logic)
class DiceNotifier extends StateNotifier<DiceState> {
  DiceNotifier() : super(const DiceState());
  
  Future<void> rollDice() async {
    // Update state
    state = state.copyWith(isRolling: true);
    // ... business logic
  }
}

// 3. Provider (dependency injection)
final diceProvider = StateNotifierProvider<DiceNotifier, DiceState>(
  (ref) => DiceNotifier(),
);
```

### State Flow

```
User Action → Widget → Provider → StateNotifier → State Update → UI Rebuild
```

## Data Flow

### Writing Data
```
User Action → Provider → Storage Service → Local Storage
```

### Reading Data
```
App Start → Storage Service → Provider → Initial State → UI
```

## Design Patterns

### 1. Provider Pattern
**Where:** State management throughout the app

**Why:** 
- Dependency injection
- Testability
- State propagation

### 2. Repository Pattern
**Where:** `StorageService`

**Why:**
- Abstract storage details
- Easy to swap implementations
- Testable

### 3. Singleton Pattern
**Where:** `SoundManager`, `HapticManager`, `StorageService`

**Why:**
- Single instance needed
- Shared state
- Resource management

### 4. Observer Pattern
**Where:** Riverpod providers

**Why:**
- Reactive UI updates
- Loose coupling
- Automatic subscription management

### 5. Immutable State Pattern
**Where:** All state classes

**Why:**
- Predictable state changes
- Time-travel debugging
- Easier testing

## Key Architectural Decisions

### Why Riverpod?
- Better than Provider in terms of:
  - Compile-time safety
  - No BuildContext required
  - Better testing support
  - More flexible

### Why Feature-Based Structure?
- **Scalability:** Easy to add new features
- **Maintainability:** Related code is together
- **Team collaboration:** Clear boundaries
- **Code reuse:** Shared folder for common code

### Why Clean Architecture?
- **Testability:** Each layer can be tested independently
- **Flexibility:** Easy to change implementations
- **Maintainability:** Clear responsibilities
- **Independence:** UI, business logic, and data are separated

## Testing Strategy

### Unit Tests
- Test business logic in providers
- Test data models
- Test utility functions

```dart
test('Rolling dice updates values', () {
  final notifier = DiceNotifier();
  notifier.rollDice();
  expect(notifier.state.isRolling, false);
});
```

### Widget Tests
- Test UI components
- Test user interactions
- Test navigation

```dart
testWidgets('Roll button triggers dice roll', (tester) async {
  await tester.tap(find.text('Roll Dice'));
  // Assertions
});
```

### Integration Tests
- Test complete user flows
- Test across multiple screens

## Performance Considerations

### 1. Lazy Loading
Providers are created only when first accessed.

### 2. Efficient Rebuilds
Only widgets watching changed providers rebuild.

### 3. Immutable State
Uses structural sharing for efficient updates.

### 4. Animation Performance
- Uses `AnimatedWidget` for efficient animations
- Hardware acceleration for transforms
- Optimized repaints

## Security Considerations

### Data Privacy
- All data stored locally
- No external network calls
- No personal information collected

### Storage Security
- SharedPreferences for non-sensitive data
- Potential for encryption in future versions

## Future Scalability

The architecture supports easy addition of:

1. **New Features:** Add to `features/` folder
2. **New Data Sources:** Implement in data layer
3. **New UI Components:** Add to `shared/widgets/`
4. **State Providers:** Add to feature providers

## Dependencies Graph

```
main.dart
  ├── Providers
  │   ├── DiceProvider
  │   │   ├── StorageService
  │   │   ├── SoundManager
  │   │   └── HapticManager
  │   ├── SettingsProvider
  │   │   ├── StorageService
  │   │   ├── SoundManager
  │   │   └── HapticManager
  │   └── StatisticsProvider
  │       └── HistoryProvider
  └── Screens
      ├── DiceRollerScreen → DiceProvider
      ├── HistoryScreen → HistoryProvider
      ├── StatisticsScreen → StatisticsProvider
      └── SettingsScreen → SettingsProvider
```

## Best Practices

1. **Keep providers small and focused**
2. **One provider per feature responsibility**
3. **Use const constructors where possible**
4. **Prefer composition over inheritance**
5. **Write tests alongside features**
6. **Document complex business logic**
7. **Use meaningful names**
8. **Keep widgets simple and dumb**

## Resources

- [Flutter Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)
- [Riverpod Documentation](https://riverpod.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

For questions or suggestions about the architecture, please open an issue.
