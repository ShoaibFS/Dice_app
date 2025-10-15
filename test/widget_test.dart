// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dicelab/app.dart';

void main() {
  testWidgets('DiceLab smoke test: app renders and navigates', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
    await tester.pumpAndSettle();

    // App title visible
    expect(find.text('DiceLab'), findsWidgets);

    // Roll button exists on home
    expect(find.widgetWithIcon(FilledButton, Icons.casino), findsOneWidget);

    // Navigate to Settings via bottom nav
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Dark mode'), findsOneWidget);
  });

  testWidgets('Bottom nav routes to History and Settings', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
    await tester.pumpAndSettle();

    // Navigate to History and verify placeholder
    await tester.tap(find.byIcon(Icons.history_outlined));
    await tester.pumpAndSettle();
    expect(find.text('No rolls yet. Tap Roll to get started!'), findsOneWidget);

    // Navigate to Settings and verify toggle exists
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Dark mode'), findsOneWidget);
  });

  testWidgets('Rolling dice adds to history list', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: DiceLabApp()));
    await tester.pumpAndSettle();

    // Roll the dice twice
    final rollButton = find.widgetWithIcon(FilledButton, Icons.casino);
    expect(rollButton, findsOneWidget);
    await tester.tap(rollButton);
    await tester.pumpAndSettle();
    await tester.tap(rollButton);
    await tester.pumpAndSettle();

    // Navigate to History and verify entries exist
    await tester.tap(find.byIcon(Icons.history_outlined));
    await tester.pumpAndSettle();
    expect(find.text('No rolls yet. Tap Roll to get started!'), findsNothing);
    final rolledFinder = find.byWidgetPredicate(
      (w) => w is Text && w.data != null && w.data!.startsWith('Rolled '),
    );
    expect(rolledFinder, findsWidgets);
  });
}
