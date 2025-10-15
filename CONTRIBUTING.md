# Contributing to Pro Dice Roller

Thank you for your interest in contributing to Pro Dice Roller! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, professional, and constructive in all interactions.

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in Issues
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Device/platform information

### Suggesting Enhancements

1. Check if the enhancement has been suggested
2. Create a new issue with:
   - Clear description of the feature
   - Use cases and benefits
   - Mockups or examples if applicable

### Pull Requests

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes following our coding standards
4. Write/update tests as needed
5. Update documentation
6. Commit with clear messages
7. Push and create a Pull Request

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/first_app.git

# Install dependencies
flutter pub get

# Run tests
flutter test

# Run the app
flutter run
```

## Coding Standards

### Dart Style
- Follow official Dart style guide
- Use `flutter analyze` before committing
- Format code with `dart format .`

### Architecture
- Follow the existing clean architecture pattern
- Keep features modular and independent
- Use Riverpod for state management

### Naming Conventions
- Classes: `PascalCase`
- Files: `snake_case.dart`
- Variables/Functions: `camelCase`
- Constants: `camelCase` or `SCREAMING_SNAKE_CASE`

### Code Organization
```dart
// 1. Imports (sorted)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 2. Class/Provider definitions
class MyWidget extends ConsumerWidget {
  // 3. Fields
  final String title;
  
  // 4. Constructor
  const MyWidget({required this.title});
  
  // 5. Methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Implementation
  }
  
  // 6. Private methods
  void _privateMethod() {
    // Implementation
  }
}
```

### Testing
- Write unit tests for business logic
- Write widget tests for UI components
- Aim for >80% code coverage
- Test file structure mirrors source structure

### Documentation
- Use dartdoc comments for public APIs
- Keep README updated
- Add inline comments for complex logic

## Commit Messages

Format: `type: description`

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/config changes

Examples:
```
feat: add custom dice configuration
fix: resolve theme switching bug
docs: update installation instructions
```

## Review Process

1. All PRs require review before merging
2. Address review comments promptly
3. Keep PRs focused and atomic
4. Update PR description if scope changes

## Questions?

Open an issue with the `question` label.

Thank you for contributing! 🎲
