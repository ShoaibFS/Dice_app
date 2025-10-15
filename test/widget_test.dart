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
}
