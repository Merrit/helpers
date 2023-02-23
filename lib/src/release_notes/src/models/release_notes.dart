/// A model representing the release notes for a specific version.
class ReleaseNotes {
  const ReleaseNotes({
    required this.version,
    required this.date,
    required this.notes,
    required this.fullChangeLogUrl,
  });

  final String version;
  final String date;
  final String notes;
  final String fullChangeLogUrl;

  ReleaseNotes copyWith({
    String? version,
    String? date,
    String? notes,
    String? fullChangeLogUrl,
  }) {
    return ReleaseNotes(
      version: version ?? this.version,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      fullChangeLogUrl: fullChangeLogUrl ?? this.fullChangeLogUrl,
    );
  }

  @override
  String toString() {
    return 'ReleaseNotes(version: $version, date: $date, notes: $notes, fullChangeLogUrl: $fullChangeLogUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReleaseNotes &&
        other.version == version &&
        other.date == date &&
        other.notes == notes &&
        other.fullChangeLogUrl == fullChangeLogUrl;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        date.hashCode ^
        notes.hashCode ^
        fullChangeLogUrl.hashCode;
  }
}
