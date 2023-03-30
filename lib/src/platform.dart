import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;

extension TargetPlatformHelper on TargetPlatform {
  /// Returns true if the platform is a desktop platform: Linux, macOS or Windows.
  bool get isDesktop =>
      this == TargetPlatform.linux ||
      this == TargetPlatform.macOS ||
      this == TargetPlatform.windows;

  /// Returns true if the platform is a mobile platform: Android, iOS or Fuchsia.
  bool get isMobile => !isDesktop && !kIsWeb;
}
