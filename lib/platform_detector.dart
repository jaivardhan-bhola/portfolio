import 'package:flutter/foundation.dart';

// Conditional import for web
import 'platform_detector_web.dart'
    if (dart.library.io) 'platform_detector_io.dart';

bool isMacOSPlatform() {
  if (kIsWeb) {
    return isWebMacOS();
  } else {
    return isNativeMacOS();
  }
}