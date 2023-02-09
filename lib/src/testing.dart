import 'dart:io';

import 'package:flutter/foundation.dart';

/// True if the running environment is a unit test.
final bool testing = _checkTesting();

// Check if running in a test environment.
bool _checkTesting() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
