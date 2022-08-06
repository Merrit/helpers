import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Converts an asset into an accessible file in the temp directory.
///
/// Takes a String [path] which is the same used to identify the asset.
///
/// For example, if you have assets specified like this:
///
/// ```yaml
/// assets:
///   - assets/icons/
///   - assets/amazingfont.tiff
///   - images/sparkle.png
/// ```
///
/// You can have an asset converted into a [File] by:
///
/// ```dart
/// File coolIcon = await assetToTempDir('assets/icons/cool_icon.png');
/// ```
///
/// ```dart
/// File amazingFont = await assetToTempDir('assets/amazingfont.tiff');
/// ```
///
/// ```dart
/// File sparkleImage = await assetToTempDir('images/sparkle.png');
/// ```
Future<File> assetToTempDir(String path) async {
  // Pubspec likes unix-type path separators for assets, so it should always end
  // up being a forward slash that we need to split on.
  final String assetName = path.split('/').last;
  final assetBytes = await rootBundle.load(path);
  final tempDir = await getTemporaryDirectory();
  final assetFile = File('${tempDir.path}/$assetName');
  return await assetFile.writeAsBytes(
    assetBytes.buffer.asUint8List(
      assetBytes.offsetInBytes,
      assetBytes.lengthInBytes,
    ),
  );
}
