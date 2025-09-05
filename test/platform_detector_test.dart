import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/platform_detector.dart';

void main() {
  group('Platform Detection Tests', () {
    test('isMacOSPlatform should return a boolean', () {
      // This test verifies that the platform detection function works
      // and returns a boolean value without throwing an exception
      final result = isMacOSPlatform();
      expect(result, isA<bool>());
    });
  });
}