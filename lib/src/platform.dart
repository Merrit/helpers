import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;

extension TargetPlatformHelper on TargetPlatform {
  /// Returns true if the platform is Android.
  bool get isAndroid => this == TargetPlatform.android;

  /// Returns true if the platform is a desktop platform: Linux, macOS or Windows.
  bool get isDesktop =>
      this == TargetPlatform.linux ||
      this == TargetPlatform.macOS ||
      this == TargetPlatform.windows;

  /// Returns true if the platform is Fuchsia.
  bool get isFuchsia => this == TargetPlatform.fuchsia;

  /// Returns true if the platform is iOS.
  bool get isIOS => this == TargetPlatform.iOS;

  /// Returns true if the platform is Linux.
  bool get isLinux => this == TargetPlatform.linux;

  /// Returns true if the platform is macOS.
  bool get isMacOS => this == TargetPlatform.macOS;

  /// Returns true if the platform is a mobile platform: Android, iOS or Fuchsia.
  bool get isMobile => !isDesktop && !kIsWeb;

  /// Returns true if the platform is the web.
  bool get isWeb => kIsWeb;

  /// Returns true if the platform is Windows.
  bool get isWindows => this == TargetPlatform.windows;
}
