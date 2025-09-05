import 'package:flutter/foundation.dart';

bool isWebMacOS() {
  // This should never be called on non-web platforms, but return false as fallback
  return false;
}

bool isNativeMacOS() {
  return defaultTargetPlatform == TargetPlatform.macOS;
}