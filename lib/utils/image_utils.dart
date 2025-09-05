import 'package:flutter/material.dart';

/// Utility class for optimized image loading
class ImageUtils {
  /// Preload an image with error handling
  static Future<void> precacheImageSafe(
    AssetImage image,
    BuildContext context,
  ) async {
    try {
      await precacheImage(image, context);
    } catch (e) {
      debugPrint('Failed to preload image: ${image.assetName}, error: $e');
    }
  }

  /// Get optimized image widget with fallback
  static Widget getOptimizedImage({
    required String optimizedPath,
    required String fallbackPath,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    return Image.asset(
      optimizedPath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Failed to load optimized image: $optimizedPath, falling back to: $fallbackPath');
        return Image.asset(
          fallbackPath,
          fit: fit,
          width: width,
          height: height,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      },
    );
  }
}