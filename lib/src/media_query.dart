import 'package:flutter/widgets.dart';

extension MediaQueryHelpers on MediaQueryData {
  /// Matches opposite the `mediumAndUp` breakpoint from the
  /// flutter_adaptive_scaffold package, eg. `mediumAndDown`.
  bool get isSmallScreen => size.width < 600;
}
