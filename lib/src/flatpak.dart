import 'dart:io';

/// Returns `true` if the app is running in a Flatpak sandbox.
bool runningInFlatpak() {
  return Platform.environment.containsKey('FLATPAK_ID');
}
