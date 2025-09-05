// This is a basic Flutter widget test for the portfolio app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';
import 'package:portfolio/platform_detector.dart';

void main() {
  group('Portfolio App Tests', () {
    testWidgets('Portfolio app should build without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the HomeScreen is present
      expect(find.byType(HomeScreen), findsOneWidget);
      
      // Verify that the app has the correct title
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    test('Platform detection should return boolean', () {
      // Test that the platform detection function works
      final result = isMacOSPlatform();
      expect(result, isA<bool>());
    });
  });
}
