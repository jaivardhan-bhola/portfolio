# macOS Platform Detection Fix

## Problem
The portfolio Flutter web application was not correctly detecting macOS users. The original code used `defaultTargetPlatform == TargetPlatform.macOS` which only works for native macOS desktop applications, not web applications running in browsers.

## Root Cause
In Flutter web applications:
- `TargetPlatform.macOS` is never true because the app runs in a browser, not as a native app
- All web users were getting the Windows theme regardless of their operating system
- Platform detection needs to check the browser's user agent instead

## Solution
Created a robust platform detection system with conditional imports:

### Files Added:
1. `lib/platform_detector.dart` - Main interface for platform detection
2. `lib/platform_detector_web.dart` - Web-specific implementation using user agent
3. `lib/platform_detector_io.dart` - Native platform fallback (for future desktop builds)
4. `test/platform_detector_test.dart` - Basic test coverage

### Changes Made:
- Modified `lib/main.dart` to use the new platform detection
- Uses conditional imports to safely handle web vs native environments
- Detects macOS by checking browser user agent for 'mac os x' or 'macintosh'

## Code Changes

### Before:
```dart
body: defaultTargetPlatform == TargetPlatform.macOS
      ? const MacEntry()
      : const WindowsEntry(),
```

### After:
```dart
body: isMacOSPlatform()
      ? const MacEntry()
      : const WindowsEntry(),
```

## Impact
- ✅ macOS users now see the macOS-themed interface
- ✅ Windows/Linux users continue to see the Windows-themed interface  
- ✅ Maintains compatibility with potential future native desktop builds
- ✅ No breaking changes to existing functionality

## Testing
Run the demo script to see user agent detection in action:
```bash
node /tmp/platform_detection_demo.js
```

This shows how different browser user agents are detected and mapped to the appropriate theme.