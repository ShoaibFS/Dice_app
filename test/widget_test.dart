// Comprehensive widget tests for DiceLab app
//
// Tests cover app initialization, navigation, dice rolling,
// history management, settings, and theme toggling.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dicelab/app.dart';
import 'package:dicelab/widgets/app_scaffold.dart';
import 'package:dicelab/features/home/home_screen.dart';
import 'package:dicelab/features/history/history_screen.dart';
import 'package:dicelab/features/settings/settings_screen.dart';
import 'package:dicelab/gradient_container.dart';
import 'package:dicelab/dice_roller.dart';

void main() {
  group('DiceLab App Tests', () {
    setUp(() {
      // Reset shared preferences before each test
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('App initializes and renders home screen', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Verify app bar title
      expect(find.text('DiceLab'), findsWidgets);

      // Verify Roll button exists
      expect(find.widgetWithIcon(FilledButton, Icons.casino), findsOneWidget);
      expect(find.text('Roll Dice'), findsOneWidget);

      // Verify bottom navigation bar
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('Roll'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Navigation between screens works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Start on home screen
      expect(find.text('Roll Dice'), findsOneWidget);

      // Navigate to History
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();
      expect(find.text('No rolls yet. Tap Roll to get started!'), findsOneWidget);

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Dark mode'), findsOneWidget);
      expect(find.text('About DiceLab'), findsOneWidget);

      // Navigate back to home
      await tester.tap(find.byIcon(Icons.casino_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Roll Dice'), findsOneWidget);
    });

    testWidgets('Dice rolling functionality works', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Find and tap the Roll Dice button
      final rollButton = find.widgetWithIcon(FilledButton, Icons.casino);
      expect(rollButton, findsOneWidget);

      // Roll the dice
      await tester.tap(rollButton);
      await tester.pumpAndSettle();

      // Verify dice image is displayed (should be one of dice-1.png to dice-6.png)
      expect(find.byType(Image), findsOneWidget);

      // Verify RotationTransition exists (animation)
      expect(find.byType(RotationTransition), findsOneWidget);
    });

    testWidgets('Dice rolls are added to history', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Roll the dice
      await tester.tap(find.widgetWithIcon(FilledButton, Icons.casino));
      await tester.pumpAndSettle();

      // Navigate to History
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();

      // Verify history now contains the roll
      expect(find.textContaining('Rolled '), findsOneWidget);
      expect(find.byType(ListTile), findsAtLeastNWidgets(1));
    });

    testWidgets('Multiple dice rolls create history entries', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Roll the dice 3 times
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.widgetWithIcon(FilledButton, Icons.casino));
        await tester.pumpAndSettle();
      }

      // Navigate to History
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();

      // Verify 3 history entries
      expect(find.textContaining('Rolled '), findsNWidgets(3));
      expect(find.byType(ListTile), findsNWidgets(3));
    });

    testWidgets('Settings screen displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Verify settings components
      expect(find.text('Dark mode'), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.text('About DiceLab'), findsOneWidget);
      expect(find.text('A professional multi-platform dice simulator'), findsOneWidget);
    });

    testWidgets('Dark mode toggle works', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Find the dark mode switch
      final darkModeSwitch = find.byType(SwitchListTile);
      expect(darkModeSwitch, findsOneWidget);

      // Get the initial switch state
      SwitchListTile switchWidget = tester.widget(darkModeSwitch);
      final initialValue = switchWidget.value;

      // Toggle dark mode
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      // Verify the switch value changed
      switchWidget = tester.widget(darkModeSwitch);
      expect(switchWidget.value, !initialValue);
    });

    testWidgets('AppScaffold displays navigation bar correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AppScaffold(
              child: Center(child: Text('Test Child')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify app scaffold components
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('DiceLab'), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);

      // Verify navigation destinations
      expect(find.byType(NavigationDestination), findsNWidgets(3));
    });

    testWidgets('HomeScreen renders GradientContainer and DiceRoller', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GradientContainer), findsOneWidget);
      expect(find.byType(DiceRoller), findsOneWidget);
    });

    testWidgets('HistoryScreen shows empty state initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: HistoryScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No rolls yet. Tap Roll to get started!'), findsOneWidget);
    });

    testWidgets('SettingsScreen renders all components', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: SettingsScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Dark mode'), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.text('About DiceLab'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('Theme persistence works across app restarts', (WidgetTester tester) async {
      // Set initial theme to dark
      SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Verify dark mode is enabled
      final darkModeSwitch = find.byType(SwitchListTile);
      SwitchListTile switchWidget = tester.widget(darkModeSwitch);
      expect(switchWidget.value, true);
    });

    testWidgets('History persistence works across app restarts', (WidgetTester tester) async {
      // Set initial history
      SharedPreferences.setMockInitialValues({
        'diceHistoryV1': '[{"value":6,"timestamp":"2025-10-15T12:00:00.000"}]'
      });

      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Navigate to History
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();

      // Verify persisted history is loaded
      expect(find.textContaining('Rolled 6'), findsOneWidget);
    });

    testWidgets('Navigation bar highlights correct tab', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
      await tester.pumpAndSettle();

      // Get NavigationBar
      final navBar = find.byType(NavigationBar);
      expect(navBar, findsOneWidget);

      // Initially on home (index 0)
      NavigationBar navWidget = tester.widget(navBar);
      expect(navWidget.selectedIndex, 0);

      // Navigate to History (index 1)
      await tester.tap(find.byIcon(Icons.history_outlined));
      await tester.pumpAndSettle();
      navWidget = tester.widget(navBar);
      expect(navWidget.selectedIndex, 1);

      // Navigate to Settings (index 2)
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      navWidget = tester.widget(navBar);
      expect(navWidget.selectedIndex, 2);
    });
  });
}
