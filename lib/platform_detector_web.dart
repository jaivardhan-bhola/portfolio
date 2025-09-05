import 'dart:html' as html;

bool isWebMacOS() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('mac os x') || userAgent.contains('macintosh');
}

bool isNativeMacOS() {
  // This should never be called on web, but return false as fallback
  return false;
}