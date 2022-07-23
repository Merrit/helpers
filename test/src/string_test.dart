import 'package:flutter_test/flutter_test.dart';
import 'package:helpers/helpers.dart';

void main() {
  group('String:', () {
    group('capitalized():', () {
      test('single word is capitalized', () {
        const word = 'capital';
        expect(word.capitalized(), 'Capital');
      });

      test('only first letter capitalized with multiple words', () {
        const word = 'capital city';
        expect(word.capitalized(), 'Capital city');
      });
    });
  });
}
