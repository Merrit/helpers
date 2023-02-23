import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_notes.freezed.dart';

/// A model representing the release notes for a specific version.
@freezed
class ReleaseNotes with _$ReleaseNotes {
  factory ReleaseNotes({
    /// The version of the app.
    required String version,

    /// The date the version was released.
    required String date,

    /// The release notes for the version.
    required String notes,

    /// The URL to the full release notes.
    required String fullChangeLogUrl,
  }) = _ReleaseNotes;
}
