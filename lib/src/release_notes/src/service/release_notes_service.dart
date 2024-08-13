import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/release_notes.dart';

/// Retrieves the release notes from GitHub for a specific version.
class ReleaseNotesService {
  final http.Client _client;

  /// The GitHub repository to retrieve release notes from.
  ///
  /// In the form of `owner/repository`.
  final String repository;

  const ReleaseNotesService({
    required http.Client client,
    required this.repository,
  }) : _client = client;

  /// Retrieves the release notes for a specific version.
  ///
  /// The [version] should be the full tag, for example `v1.2.3`.
  ///
  /// Returns `null` if the release notes could not be retrieved.
  Future<ReleaseNotes?> getReleaseNotes(String version) async {
    final url =
        'https://api.github.com/repos/$repository/releases/tags/$version';

    final http.Response response;
    try {
      response = await _client.get(Uri.parse(url));
    } catch (e) {
      return null;
    }

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body);

    return ReleaseNotes(
      version: json['tag_name'],
      date: json['published_at'],
      notes: _validateNotes(json['body']),
      fullChangeLogUrl: json['html_url'],
    );
  }

  // Matches GitHub commit links.
  static const String _githubCommitLinkRegex =
      r'https:\/\/github\.com\/[a-zA-Z0-9-]+\/[a-zA-Z0-9-]+\/commit\/[a-zA-Z0-9]+';

  /// Validates the notes.
  ///
  /// Returns the notes with any GitHub commit links removed, for a cleaner
  /// changelog.
  String _validateNotes(String notes) {
    return notes.replaceAllMapped(
      RegExp(_githubCommitLinkRegex),
      (_) => '',
    );
  }
}
