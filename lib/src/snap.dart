import 'dart:io';

/// Returns `true` if the app is running in a Snap sandbox.
bool runningInSnap() {
  return Platform.environment.containsKey('SNAP');
}
