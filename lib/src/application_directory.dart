import 'dart:io';

Directory? _directory;

/// The [Directory] where this application exists.
///
/// Specifically, this resolves to the directory where the executable is.
Directory get applicationDirectory {
  if (_directory != null) return _directory!;

  final List<String> splitPath = Platform //
      .resolvedExecutable
      .split(Platform.pathSeparator)
    ..removeLast();

  final String path = splitPath.join(Platform.pathSeparator);
  _directory = Directory(path);
  return _directory!;
}
