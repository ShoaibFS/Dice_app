import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    
    // Wait for initial render
    await tester.pumpAndSettle();

    // Verify that the app title is present
    expect(find.text('Pro Dice Roller'), findsOneWidget);
    
    // Verify that navigation bar is present
    expect(find.byType(NavigationBar), findsOneWidget);
    
    // Verify that Roll button is present
    expect(find.text('Roll Dice'), findsOneWidget);
  });
  
  testWidgets('Navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    
    await tester.pumpAndSettle();
    
    // Tap on History tab
    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();
    
    // Verify we're on History screen
    expect(find.text('Roll History'), findsOneWidget);
    
    // Tap on Statistics tab
    await tester.tap(find.text('Statistics'));
    await tester.pumpAndSettle();
    
    // Verify we're on Statistics screen
    expect(find.text('Statistics'), findsOneWidget);
    
    // Go back to Roll tab
    await tester.tap(find.text('Roll'));
    await tester.pumpAndSettle();
    
    // Verify we're back on Roll screen
    expect(find.text('Roll Dice'), findsOneWidget);
  });
}
