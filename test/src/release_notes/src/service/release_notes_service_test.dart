import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helpers/src/release_notes/release_notes.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ReleaseNotesRetriever', () {
    late http.Client client;
    late ReleaseNotesService service;

    setUpAll(() {
      registerFallbackValue(Uri.parse(''));
    });

    setUp(() {
      client = MockClient();
      service = ReleaseNotesService(
        client: client,
        repository: 'owner/repo',
      );
    });

    test('getReleaseNotes returns null if the response is not 200', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      final result = await service.getReleaseNotes('v1.2.3');

      expect(result, isNull);
    });

    test('getReleaseNotes returns null if the response is not valid JSON',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('not json', 404));

      final result = await service.getReleaseNotes('v1.2.3');

      expect(result, isNull);
    });

    test(
        'getReleaseNotes returns a ReleaseNotes object if the response is valid',
        () async {
      const version = 'v1.2.3';
      when(() => client.get(any())).thenAnswer((_) async => http.Response(
            jsonEncode({
              'tag_name': version,
              'published_at': '2023-01-31T20:36:20Z',
              'body': 'notes',
              'html_url': 'https://github.com/owner/repo/releases/tag/v1.2.3',
            }),
            200,
          ));

      final result = await service.getReleaseNotes(version);

      expect(result, isNotNull);
      expect(result!.version, version);
      expect(result.date, '2023-01-31T20:36:20Z');
      expect(result.notes, 'notes');
      expect(
        result.fullChangeLogUrl,
        'https://github.com/owner/repo/releases/tag/v1.2.3',
      );
    });
  });
}
